Return-Path: <netdev+bounces-251784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNZsJnB8cGktYAAAu9opvQ
	(envelope-from <netdev+bounces-251784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 08:12:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AAC52A62
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 08:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EAC16436F5
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 07:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A02044BC8C;
	Wed, 21 Jan 2026 07:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="dlHowCvQ"
X-Original-To: netdev@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B8344D012;
	Wed, 21 Jan 2026 07:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768979494; cv=none; b=CYIH4962v7NOAfziX6EQ/2a8WWQguUmLRLoHvhPvnRwIgvUe/jOW7Y8yMHLk8MlOiglEFQHkFOYvIMasWNaVryIioemoM9cgpBfI8egV89VwT4RS1gKvC3bbcpCoiCgjwXTNOTZRkig5YmyeAxxUPhLWGM6RFReH3nGZ55ZVynw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768979494; c=relaxed/simple;
	bh=Jo8tWaJanldjLGl3SShn1+DSg7/RvS2MRX+8f0csk1U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N3+LDmpchRu8HJGSsesT6jTZwko+RKbAfUalL/O3a3u3Zs8iexiWzuXD35gOQVUD8jShBGpZGGVeyMhwNoEod42fV8HhDmOlk/NdDALs0c/4SdFTGisfGZ2bXLrHKd+oXctRqy1CxomUIfWgbyHSb9QvmeNJ3QiAdnax5WdX0iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=dlHowCvQ; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1768979480;
	bh=Jo8tWaJanldjLGl3SShn1+DSg7/RvS2MRX+8f0csk1U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dlHowCvQe9me/z9JA9scRuBNsqKWsHL3b9syD/UAJy9OXP5YDLotW2yZVjt82voNm
	 aMlpnjnLA3gXzFC4T/pVeTSbsy2FWA74DqG/QP1m+tpJqNgp2WRjnJtxbAhRwn+8/K
	 1a87UXWgmllDUxKI4KeozaWRoaQYhodNh0+PjK+g=
Received: from [IPv6:2409:8a4c:e1d:a410::256] (unknown [IPv6:2409:8a4c:e1d:a410::256])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 1873466B43;
	Wed, 21 Jan 2026 02:11:12 -0500 (EST)
Message-ID: <e3598b9e9f2e3fcef2e1446fe9e88af08b9c0bcc.camel@xry111.site>
Subject: Re: [PATCH RESEND net-next v6 0/3] Add DWMAC glue driver for
 Motorcomm YT6801
From: Xi Ruoyao <xry111@xry111.site>
To: Yao Zi <me@ziyao.cc>, Georg Gottleuber <ggo@tuxedocomputers.com>, 
 "Russell King (Oracle)"
	 <linux@armlinux.org.uk>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, Frank.Sae@motor-comm.com,
 hkallweit1@gmail.com, 	vladimir.oltean@nxp.com, wens@csie.org,
 jszhang@kernel.org, 0x1207@gmail.com, 	linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, jeffbai@aosc.io, 	kexybiscuit@aosc.io, Christoffer
 Sandberg <cs@tuxedocomputers.com>
Date: Wed, 21 Jan 2026 15:10:56 +0800
In-Reply-To: <aW9sZwDpQu88BRPG@pie>
References: <20260109093445.46791-2-me@ziyao.cc>
	 <176827502141.1659151.5259885987231026081.git-patchwork-notify@kernel.org>
	 <147b700c-cae2-4286-b532-ec408e00b004@tuxedocomputers.com>
	 <aW5RMKqwpYTZ9uFH@shell.armlinux.org.uk>
	 <be9b5704-ac9c-4cd5-aead-37433c4305a8@tuxedocomputers.com>
	 <24cfefff-1233-4745-8c47-812b502d5d19@tuxedocomputers.com>
	 <aW7sW91DrgZ6FMrv@pie>
	 <1be6caa4-abbd-4f3b-8c63-b637f0f9ed15@tuxedocomputers.com>
	 <aW9sZwDpQu88BRPG@pie>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[xry111.site:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-251784-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,motor-comm.com,gmail.com,nxp.com,csie.org,vger.kernel.org,aosc.io,tuxedocomputers.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[xry111.site,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xry111@xry111.site,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[xry111.site:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: F2AAC52A62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-01-20 at 11:52 +0000, Yao Zi wrote:
> > > > > > > I tested this driver with our TUXEDO InfinityBook Pro AMD Gen=
9. Iperf
> > > > > > > revealed that tx is only 100Mbit/s:
> > > > > > >=20
> > > > > ...
> > > > > > >=20
> > > > > > > With our normally used DKMS module, Ethernet works with full-=
duplex and
> > > > > > > gigabit. Attached are some logs from lspci and dmesg. Do you =
have any
> > > > > > > idea how I can debug this further?

Just FYI: on the contrary, the DKMS module from vendor often negotiates
to 10Mbps (for both RX and TX) on the Loongson 3A6000 and 3C6000 boards
but we've not observed any issue with the driver in this series (we also
tested with iperf).

--=20
Xi Ruoyao <xry111@xry111.site>

