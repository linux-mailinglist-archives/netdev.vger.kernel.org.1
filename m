Return-Path: <netdev+bounces-300304-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UCoiJ+xgM2q2/wUAu9opvQ
	(envelope-from <netdev+bounces-300304-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 05:07:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF5E69D34E
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 05:07:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300304-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300304-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 032403093646
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 03:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D73A2798EA;
	Thu, 18 Jun 2026 03:07:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28653E47B
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 03:07:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781752040; cv=none; b=nRvnEgA2sZ06TpgX3rx2uMKt3jE9USoEPEDFv3sWnF9aj1HXVtTf6CTjRjFjcZ3MRIv2Ib3XZ5MZawO9FhusYPSgbPfykwFak5NGLQw7WqivFHeS+w6EtifQhY5ZIehAPY1NcpSmC1r2VsQr9EDow58UVgLSjAf53mK9muGP+4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781752040; c=relaxed/simple;
	bh=77qUmEb+KAeeg6OoNTdMTmnXTubYCYusT58IwKoUOr4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rJd8pihwbYxf9sd22RAbIM4Zae4Hf7J8+ZWbTNVIRRRHjetiX1Kfvo0/PzUUewZmKpUIDR8d4NdiV51XMxMiTSXVPmDbGKO2Xnb/RcDUZoIlk01zUUFUjRS+B4d1+RGwC4jRYcVDQ+qY/ML/qNTru6t9K8t0KkLnvCOubEWt8XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.169.211.239
X-QQ-mid: zesmtpsz3t1781752011t36c57a60
X-QQ-Originating-IP: aC4NZm1ZEzpePHnP8mHe3oWKrKiu+M7lLMnW9/oUnx4=
Received: from smtpclient.apple ( [122.235.195.85])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 11:06:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3626486330295239536
EX-QQ-RecipientCnt: 6
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net-next v1] net: wangxun: don't advertise IFF_SUPP_NOFCS
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20260617092854.133992-1-clementwei90@163.com>
Date: Thu, 18 Jun 2026 11:06:38 +0800
Cc: netdev@vger.kernel.org,
 jiawenwu@trustnetic.com,
 pabeni@redhat.com,
 kuba@kernel.org,
 Rongguang Wei <weirongguang@kylinos.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1EB78FD0-FA39-4117-AF64-538B9D76C0F9@net-swift.com>
References: <20260617092854.133992-1-clementwei90@163.com>
To: Rongguang Wei <clementwei90@163.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NAeO0+xU6W76JStfVwIynOaVolK543HmiENcuEzTIgKme+87Taicz1F/
	iY5cCZqvvf70nJOwCLl6AByYfvHEXR/wit17AnarxFjgASGmR9zokV8jNf2+VjVaMfA6t/j
	TDoQCbZtmfcc04q0yb3N14SgLEqoeawGRZau6DWNApw11II7TVt/XAWzYtdgbqbdLeNlTjK
	+5kEXSOdqqwG7yuGE1jLhDKMRFGJzrOPqMvwmct/+hbWUBmPPt0T63sUsVNu4JRILzMuCRM
	Bha2Am6gr33XNKC9ab5nMYo8Rd7Jm4f5Yua1EEQluAeJ+4YMo7AMZK5lwvdFICtMnPjcWZY
	RkBjQyFyroFWiTWkyMwK3TErpwwrJKf69ZxQCssi3nqSUZ+m5D1xsUniX/vqceZKFbu7XSI
	LJWy7+bKomFLckyLpeX5i/iFUzp9adO9t/qXytqDa/PGpJRQcmDBQcceQ/t/8f8GGYQ8qcP
	OcvPKo2q6z/Tcsm5sCkCZ60dO4dDpUCF8eSYML4uFr9YPgmJy36NCx986998fAKX33ihghi
	m3v01SkatbdrpQ3S4gsATU0XF1yFm4eURz6k8sLsaG0eaz88OxhRNiXOwVMzBPVa8zxl3+n
	ymJmU95yxniSPgZWk+Na96+n6irgZ0+Uk3w5jTRHJgNUybunD0OwXNuPiac4ZBTq4/v7O8W
	gf7T38Nt6EAQlwCpxw+S7yu1Y6kKgF8PjkrbUK7ZZ+xmrNXk+jS7R09QPJPNU5W7v5nfxTm
	+hTGSPb83HGo/OJO3+/xmfaxJGcNV01wlRuErrduDDmRJT93CxcL2Jj9quVOZQv8fl0wi0r
	//b3/BYDe+FBjKt23DHKiVhMv4z+Py2KiAZXtvPkHbMWh/SBc/uctXRafS1/Pvgz5EyrXWG
	gevrSw4CjpliKdrbstN/oQAFdFVGIlFTkKWxjkzi/5LQPzrLEzKC5OgPuZmYCiqW75IQSxU
	/LS5TR3u1xjoPA2XmtKNn5XLY5lObBLv7iEEe92Et7RmjnA0O7LmIrygLzuNhzNI751Uei4
	8ySMj+ZINX5/wtIPu5k4Jo7l+aKY2gxtZXeGsbVcHyH39YXq+vC8LfZ5ECIqcrNpYgiyWPK
	g==
X-QQ-XMRINFO: MPJ6Tf5t3I/yDq8W/MhFvRa0Pzh3gYhZJQ==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FROM_DN_EQ_ADDR(1.00)[];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jiawenwu@trustnetic.com,m:pabeni@redhat.com,m:kuba@kernel.org,m:weirongguang@kylinos.cn,m:clementwei90@163.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[net-swift.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-300304-lists,netdev=lfdr.de];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,net-swift.com:mid,net-swift.com:from_mime,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EFF5E69D34E



> 2026=E5=B9=B46=E6=9C=8817=E6=97=A5 17:28=EF=BC=8CRongguang Wei =
<clementwei90@163.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> From: Rongguang Wei <weirongguang@kylinos.cn>
>=20
> Like commit a24162f18825("i40e: don't advertise IFF_SUPP_NOFCS"),
> ngbe and txgbe also advertises IFF_SUPP_NOFCS and allowing users
> to use the SO_NOFCS socket option. But the driver does not check
> skb->no_fcs, so this option is silently ignored.
>=20
> With this change, send() fails with -EPROTONOSUPPORT when AF_PACKET
> socket is set SO_NOFCS option.

In fact, the hardware supports this function, but it seems that no one =
is using it at present.
To ensure that the interface does not report any errors, it can be =
removed.

>=20
> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
> ---
> drivers/net/ethernet/wangxun/ngbe/ngbe_main.c   | 1 -
> drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 1 -
> 2 files changed, 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c =
b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index d8e3827a8b1f..1e4ebac8e495 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -713,7 +713,6 @@ static int ngbe_probe(struct pci_dev *pdev,
> netdev->features |=3D NETIF_F_GRO;
>=20
> netdev->priv_flags |=3D IFF_UNICAST_FLT;
> - netdev->priv_flags |=3D IFF_SUPP_NOFCS;
> netdev->priv_flags |=3D IFF_LIVE_ADDR_CHANGE;
>=20
> netdev->min_mtu =3D ETH_MIN_MTU;
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c =
b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index 8b7c3753bb6a..db9262b00a66 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> @@ -801,7 +801,6 @@ static int txgbe_probe(struct pci_dev *pdev,
> netdev->features |=3D NETIF_F_RX_UDP_TUNNEL_PORT;
>=20
> netdev->priv_flags |=3D IFF_UNICAST_FLT;
> - netdev->priv_flags |=3D IFF_SUPP_NOFCS;
> netdev->priv_flags |=3D IFF_LIVE_ADDR_CHANGE;
>=20
> netdev->min_mtu =3D ETH_MIN_MTU;
> --=20
> 2.25.1
>=20
>=20
>=20


