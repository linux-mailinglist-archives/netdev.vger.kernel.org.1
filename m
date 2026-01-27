Return-Path: <netdev+bounces-253878-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cE/1Ir/AeGn6sgEAu9opvQ
	(envelope-from <netdev+bounces-253878-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:42:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8D295072
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B39213004DA1
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED5D35A923;
	Tue, 27 Jan 2026 13:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4hsXvio"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7BB27BF79;
	Tue, 27 Jan 2026 13:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769521326; cv=none; b=BxFaQ3lGjXN8+7f2hxRcyILfW5WMarsTvlSwjX/4KCQox1aQPP5pl7+IHqJfCSFd/OwVW6/KgVBZ8594s687fln4IFs22hBbG7FfYpr94tRGJtbUskJBv/OvEbYPvsdYAWlPazyMWfPgV8TBDMU/XhQQ2NtmsyFtT/J3rHDssTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769521326; c=relaxed/simple;
	bh=YeHXlxP0dmg6RHVDtkVhWveAzGoBAVACEuP1+dVwj2U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E24zVC35WzuPKBUI2fvTH/bSot529UW4+sFHs9jRwCOYV7JADu0TsjsJoWRPzQzKRh+3/uLeZ/8F3kmGL5PB6zk2R2Osw2fyxVfurm2N+ZKh5ykKzDCCryuAtPe0V5Gru+IJBK+r9ja5ULDpp2uSMG/9u5sJYGpebtVx00U17K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4hsXvio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C77BC116C6;
	Tue, 27 Jan 2026 13:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769521325;
	bh=YeHXlxP0dmg6RHVDtkVhWveAzGoBAVACEuP1+dVwj2U=;
	h=Date:From:To:Cc:Subject:From;
	b=s4hsXvioBfF59F2HGqCBrp/RhH3TOUzjPV3C+jDgyCzvAi1CTt/pjsPO/MQOvmJRj
	 ZPliQVrBV+JVQvA/p+bLAgNO8e8QyrgdO1CBQkqUJhcXvoZF358ER93w/x+pwmKEUM
	 3pdDS02RZwxmuunzeq/weOZu8hjVvlA9mRb9WW6F4N8VWuzO3eTmB4NLxTOVN1ybgN
	 kU8Kv22fU+KbdCbSHs2AWWlVDzKm6pB4iOAw0P4tcz5pW3zTOEs5dFaQ30uH+veeT9
	 DflLo4Tk8oCacl18Nq0zewHfo1h1higDQZPWmpNvGfxkQUehcpauT1892Hd1kR32un
	 OP5U9cTgKL0Kw==
Date: Tue, 27 Jan 2026 13:42:01 +0000
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Chukun Pan <amadeus@jmu.edu.cn>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Vivian Wang <wangruikang@iscas.ac.cn>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <aXjAqZA3iEWD_DGM@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2jrxtingMBd5InMe"
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253878-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E8D295072
X-Rspamd-Action: no action


--2jrxtingMBd5InMe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/spacemit/k1_emac.c

between commit:

  2c84959167d64 ("net: spacemit: Check for netif_carrier_ok() in emac_stats=
_update()")

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
index 88e9424d2d51a,c85dc742c404d..0000000000000
--- a/drivers/net/ethernet/spacemit/k1_emac.c
+++ b/drivers/net/ethernet/spacemit/k1_emac.c
@@@ -1648,14 -1531,6 +1545,12 @@@ static void emac_adjust_link(struct net
  		}
 =20
  		emac_wr(priv, MAC_GLOBAL_CONTROL, ctrl);
 +
- 		emac_set_fc_autoneg(priv);
-=20
 +		/*
 +		 * Reschedule stats updates now that link is up. See comments in
 +		 * emac_stats_update().
 +		 */
 +		mod_timer(&priv->stats_timer, jiffies);
  	}
 =20
  	phy_print_status(phydev);

--2jrxtingMBd5InMe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAml4wKgACgkQJNaLcl1U
h9CZiAf/cayrZGhkTVbrARdIJj6yE5+1bj+P0uGbE07rXZdU5KZ7GqAn8ZnQQI1/
jhIY4L/LFn1UvQN8Lkrx1VWuhiMK6inEyZZio/nP587F3Hi10Xrtc76+v6aHV76d
m05fPxPcnWQ9GqDlonLaMr2cDNmkc42ukGCr1CNRj6spm0oFb0mvdk5s88/pcwQ8
AtDBDJBsC+vXLk9AZ4AWqOoWkoOoT8rg5ijXnSY5+ODBT7OkHCvflHYryc9Bals8
3n0Ei0s7NRBUfbENRGeQ0rlyIymZi/Hb+Ie+It43WEEAGqli4StlIJxVUd//DKbg
hwqK05r1a6s9ES6btRCzO57iMwqVNQ==
=qkgv
-----END PGP SIGNATURE-----

--2jrxtingMBd5InMe--

