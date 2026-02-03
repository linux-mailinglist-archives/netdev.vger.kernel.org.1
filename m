Return-Path: <netdev+bounces-256393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJrvJ1Y0gmlTQgMAu9opvQ
	(envelope-from <netdev+bounces-256393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:45:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E691DD07F
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDAD8309C96E
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 17:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61353254AE;
	Tue,  3 Feb 2026 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwSNskwZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B342A4A35;
	Tue,  3 Feb 2026 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140341; cv=none; b=h04EtVjHUkxQt1gV9lzO6CadTnWC6zVwCRj02puA4fbiy0ox3R8xnBBczn3LPYtLRYeOVOetETGm3EJwu9uajA/8bhHdGdvUfxvjCg3s2KPMvfLRdv+IiOGzYhtTm5KIAVLwmFLCPzjFW0kDoJryCreky7zigp+OZ0n2C/Dyc1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140341; c=relaxed/simple;
	bh=LsPMK9Gl0InO1O9IIX6oGTQbjGIWk74dRMibVKKXQIw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gIRFqiivXb+ddooIwgmrr/RDXMsqhTig2CEeNm04u4KbLQXXzbgZpnWm/V3F0o8SFA+rjsmzySWSUJhgn92aqSs9QtpMVomuMxI2ZbAA9PAIEjesO3eO7s1fIt6obovesdhmkzn+KlwlkLl+hFAzspW2uhpqKMcL4p7zqMrBGmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwSNskwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1DBC19421;
	Tue,  3 Feb 2026 17:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770140341;
	bh=LsPMK9Gl0InO1O9IIX6oGTQbjGIWk74dRMibVKKXQIw=;
	h=Date:From:To:Cc:Subject:From;
	b=FwSNskwZ4hRTQjcsF/9ginUNfoZ6kPPr56DmBj95rOyYPZT+viNhb5oDYRYiNNXip
	 sgYr2hZz4LE9MiNL1H2m2b8yswYtNaW+ZIjSP7/DuFGV/+3D3My7iVFXzeXCkTzQA4
	 VfQSPVnCHlnadgb3kv7htcVj+GUCrXFwvI2AramtVzhsQNR3fCLCVb2Dr9QAFjF+rm
	 v6uu0WeOqEyw7JRXaKb+kuUirKRXGriO7mBwuDeVpE497YzuWsjMz1lledw1umG78o
	 z5YV3kfEcox25VThVLlaG2S5L6qZWzGfeys6qjMZNaB2wMrJtUGHOggDnexOSLGtD5
	 DwMkafQQpMg6g==
Date: Tue, 3 Feb 2026 17:38:56 +0000
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Tomas Hlavacek <tmshlvck@gmail.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <aYIysFIE9ooavWia@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lkug/g3BTk7qqesV"
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256393-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,iscas.ac.cn];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E691DD07F
X-Rspamd-Action: no action


--lkug/g3BTk7qqesV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/spacemit/k1_emac.c

between commit:

  3125fc1701694 ("net: spacemit: k1-emac: fix jumbo frame support")

=66rom the net tree and commit:

  f66086798f91f ("net: spacemit: Remove broken flow control support")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/net/ethernet/spacemit/k1_emac.c
index b49c4708bf9eb,40c9504b74445..0000000000000
--- a/drivers/net/ethernet/spacemit/k1_emac.c
+++ b/drivers/net/ethernet/spacemit/k1_emac.c
@@@ -201,9 -193,7 +194,7 @@@ static void emac_reset_hw(struct emac_p
 =20
  static void emac_init_hw(struct emac_priv *priv)
  {
- 	/* Destination address for 802.3x Ethernet flow control */
- 	u8 fc_dest_addr[ETH_ALEN] =3D { 0x01, 0x80, 0xc2, 0x00, 0x00, 0x01 };
 -	u32 rxirq =3D 0, dma =3D 0;
 +	u32 rxirq =3D 0, dma =3D 0, frame_sz;
 =20
  	regmap_set_bits(priv->regmap_apmu,
  			priv->regmap_apmu_offset + APMU_EMAC_CTRL_REG,
@@@ -228,21 -218,6 +219,15 @@@
  		DEFAULT_TX_THRESHOLD);
  	emac_wr(priv, MAC_RECEIVE_PACKET_START_THRESHOLD, DEFAULT_RX_THRESHOLD);
 =20
 +	/* Set maximum frame size and jabber size based on configured MTU,
 +	 * accounting for Ethernet header, double VLAN tags, and FCS.
 +	 */
 +	frame_sz =3D priv->ndev->mtu + ETH_HLEN + 2 * VLAN_HLEN + ETH_FCS_LEN;
 +
 +	emac_wr(priv, MAC_MAXIMUM_FRAME_SIZE, frame_sz);
 +	emac_wr(priv, MAC_TRANSMIT_JABBER_SIZE, frame_sz);
 +	emac_wr(priv, MAC_RECEIVE_JABBER_SIZE, frame_sz);
 +
- 	/* Configure flow control (enabled in emac_adjust_link() later) */
- 	emac_set_mac_addr_reg(priv, fc_dest_addr, MAC_FC_SOURCE_ADDRESS_HIGH);
- 	emac_wr(priv, MAC_FC_PAUSE_HIGH_THRESHOLD, DEFAULT_FC_FIFO_HIGH);
- 	emac_wr(priv, MAC_FC_HIGH_PAUSE_TIME, DEFAULT_FC_PAUSE_TIME);
- 	emac_wr(priv, MAC_FC_PAUSE_LOW_THRESHOLD, 0);
-=20
  	/* RX IRQ mitigation */
  	rxirq =3D FIELD_PREP(MREGBIT_RECEIVE_IRQ_FRAME_COUNTER_MASK,
  			   EMAC_RX_FRAMES);

--lkug/g3BTk7qqesV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmCMrAACgkQJNaLcl1U
h9Bvkgf/Vb8/B9F03SSUrMuREqVeo7lVL+iojs2fETc3dZ2310pYt7ZhvAJMSsmZ
KXy/d5ziPfNn9/F89vt0PLDCPPcZ5dz9F0x8MH5weE62KC/OxY1F6zZslzQj/IOF
ugt8qeLf5rVXJ3/zbCj5veAsOxnCNj8q+3litS5TQ0IYEH6bkFfvHYKGTWm7pjOo
QjHnv7viY4o8d7XrtCYu+LRdpFTFNndEbu0ihXGEdPCyiHHCHJncs9pPpktWeGaW
Nv6Lh9z88IkoM2zdroFzSMLNZiX/bO8tjzP5zmo7v/GA53pOH/XbOKqrpYCeYtr3
o6nwixOmlZtAmQj5c9N0Y7v9xqNgPQ==
=C+SL
-----END PGP SIGNATURE-----

--lkug/g3BTk7qqesV--

