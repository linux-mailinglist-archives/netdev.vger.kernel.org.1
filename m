Return-Path: <netdev+bounces-267051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNEjNh63smmYOwAAu9opvQ
	(envelope-from <netdev+bounces-267051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:52:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C82272072
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A3DB30074E3
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 12:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C1A3BE658;
	Thu, 12 Mar 2026 12:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSaWi2gP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729A92D8DC2;
	Thu, 12 Mar 2026 12:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773319959; cv=none; b=aakc8qiZAGWXLeWipLdjbFBAN1KY1ZXRWS73zK3BztbyfOn36/z9Al9wXxpb36Cy8GtiRl14oHvkJUdfyT6ExIcD3+d0m/15oNxxCb6+zORvc17NzAMyepsGFhMAvg9CIX4f8vhzLkHlHuuiiQigVxvA+Vv0GCUpqWdyBk0Rwhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773319959; c=relaxed/simple;
	bh=XU3qMOLHx5LF82p/dzJ0X7DRVsKLx2VKAUG2jpRhIbw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FRHmnmVojGQ4l3kLe9aqwGFkHvkSb5jIV7gVXxM7XvL3AtLcNDS45EH+VPko6maN4nMTTu+VB3Bpn2/QgwtKtpiR8MS76fRVgufaITvxw9+YwNw/w8Zc0etNwE5UvwQdMSZNFnuMOxiqKJN/IHxBJG9hsEhLbYGJsn3Acri/MnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSaWi2gP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAEAC4CEF7;
	Thu, 12 Mar 2026 12:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773319959;
	bh=XU3qMOLHx5LF82p/dzJ0X7DRVsKLx2VKAUG2jpRhIbw=;
	h=Date:From:To:Cc:Subject:From;
	b=TSaWi2gPT0Fw5brUD+oEH/XSmmorUTSfBFou+F4EFlOtupQndlTy/pIvo0ps4BORl
	 I5p6AuL8lhTH9v2GkNQNLBx0egM2sRL0pLp/jxfH8YwhHGRKyU4Z1YcGWmggLbjMhE
	 Xd8uIL1eTOBAuCI/Zd3AonJInZZN5wALOpLy+YouIu5gkZ9DhyHaimn8WnOMvlAwpD
	 7TzE7WJAhr8eX163NhgyIBWNKQwXMJW55t6z6YbS1K2tG27PjMY5A2R2z/3WZWsNbY
	 PIKGmR4ImAGLQxl/AbR293U6MjL8OZPN37YMFiXHyZPVagCCMbBr1xiMZ25l6yehIf
	 /MKax7YF1U45g==
Date: Thu, 12 Mar 2026 12:52:34 +0000
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Chintan Vankar <c-vankar@ti.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <abK3EkIXuVgMyGI7@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BKOKz4LaxThvnM+6"
Content-Disposition: inline
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267051-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E0C82272072
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--BKOKz4LaxThvnM+6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/ti/am65-cpsw-nuss.c

between commit:

  840c9d13cb1ca ("net: ethernet: ti: am65-cpsw-nuss: Fix rx_filter value fo=
r PTP support")

=66rom the net tree and commit:

  a23c657e332f2 ("net: ethernet: ti: am65-cpsw: Use also port number to ide=
ntify timestamps")

=66rom the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 265ce5479915f,a38bf7f4f4343..0000000000000
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@@ -1351,8 -1351,8 +1351,8 @@@ static int am65_cpsw_nuss_rx_packets(st
  	ndev_priv =3D netdev_priv(ndev);
  	am65_cpsw_nuss_set_offload_fwd_mark(skb, ndev_priv->offload_fwd_mark);
  	skb_put(skb, pkt_len);
 -	if (port->rx_ts_enabled)
 +	if (port->rx_ts_filter)
- 		am65_cpts_rx_timestamp(common->cpts, skb);
+ 		am65_cpts_rx_timestamp(common->cpts, port_id, skb);
  	skb_mark_for_recycle(skb);
  	skb->protocol =3D eth_type_trans(skb, ndev);
  	am65_cpsw_nuss_rx_csum(skb, csum_info);

--BKOKz4LaxThvnM+6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmytxEACgkQJNaLcl1U
h9Ce4Qf/QPfy8FS3+1+khTB0KrNCnmKU0ylwfvhaX1tdznGj4KU/CepWn/xjjYUa
3k7nVtTP12SbqEUMTgTcT/j2SOhj/C7SfBJBMSBZIm1mjihgSffHLEC6uwHKDmM8
bqWjgG2q9REu7yNPGKD2CKNOLhXVaocMADhD9azPeOCleclRo6tWaZ45BIwKIpKh
n2a8XMlr7AmbAiumB00gkWVyWMHDrOjf9l3dZeHCOqGOBCI2t/m/LaLgjWbGEr7J
I4CpZQ8TaTJjdHGo1cCM0hXvMhDxKIaG9cVdurRbp2IbW+PzqBQkIfXc9A+QbJQA
u8/vuVFbucpZrxZ92/RFQsUva6SPCA==
=122z
-----END PGP SIGNATURE-----

--BKOKz4LaxThvnM+6--

