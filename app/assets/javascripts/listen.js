/*jshint esversion: 6 */

window.onSpotifyWebPlaybackSDKReady = () => {
  const token = 'BQDqs1HBDim1K-oyJ-1GnzI2sLK3_isuaOxocoL5H0GNB3tB0XS7kGdS5vTB6I2leRkX6owdHZ-_jhxRdHbwLNK6Azn8WAK01P7eVEP9MEdlRIp-2SMs6upxvrsBi3cfajemm20Dx_b4l774tNaRNDNrGp28RbqA3Q';
  const player = new Spotify.Player({
    name: 'Web Playback SDK Quick Start Player',
    getOAuthToken: cb => { cb(token); }
  });

  // Error handling
  player.on('initialization_error', e => { console.error(e); });
  player.on('authentication_error', e => { console.error(e); });
  player.on('account_error', e => { console.error(e); });
  player.on('playback_error', e => { console.error(e); });

  // Playback status updates
  player.on('player_state_changed', state => { console.log(state); });

  // Ready
  player.on('ready', data => {
    let { device_id } = data;
    console.log('Ready with Device ID', device_id);
  });

  // Connect to the player!
  player.connect();
};
