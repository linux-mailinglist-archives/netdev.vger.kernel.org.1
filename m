Return-Path: <netdev+bounces-307378-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wmiIEM/pVWrPvgAAu9opvQ
	(envelope-from <netdev+bounces-307378-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 09:48:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2307520F3
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 09:48:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samsung.com header.s=mail20170921 header.b=JE90R8US;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307378-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307378-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=samsung.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43719300A4DA
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 07:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E06D3F1AC0;
	Tue, 14 Jul 2026 07:48:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0246F3F2100
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 07:48:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784015288; cv=none; b=gPolb5uDIfNF/NVeiqgCE9idBRrm2O2eRA65fOGxYEvDicPxMWmXWhjqDVjbHY128NxDynA4O2TsCjM4ZeW2ON4NFbnktTqsNEiaVMlE3jYneiyeF+VXHkxsyqsyYKfhVP1H7CqAlExFA17e/ISgoPd7NubjO+NFhYTQnKNV2AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784015288; c=relaxed/simple;
	bh=beptTUop73IP0ckhVixMn1P+tWXgPikbHXSCtKKGRZk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=Hy8h+JP9IgQc8YmP6UmZHJRyrlUv0ScNzVkF17z2ecscV4RzhsUhQSwNM07dg+tW4RvKGC5DZJ2ujEvsuO6UrcMOGsxODx1ydBTU/UKe/4VPFh/dMnJKTolj+a+Sdc957Wo0/TA2cmECur8SZNuwI81j+6jJAzSL4PrrMIgXUQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JE90R8US; arc=none smtp.client-ip=210.118.77.11
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260714074757euoutp019c755ae0240628464e374a925616e85f~CGHFA4a-22857728577euoutp01f
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 07:47:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260714074757euoutp019c755ae0240628464e374a925616e85f~CGHFA4a-22857728577euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1784015277;
	bh=9/MMMAfaD7jcUR+QaEIK4dkYOFXzzXelyYlMpGJ9h7I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JE90R8USu9kjMDegx7Ba8rykmUvXjmiB75WKdNjOsWdg7jG5hFiVF0dVrN1j++MCO
	 c6YVR/G4eg6w86OgOJJNnpndZx3Vm93b8dGC2XYXkuderMS5zSKUTx/winNHc4L16r
	 mb0X/CHNiquH6H3InAfcv+Gq4aT7NMLgpTXgVnT4=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260714074756eucas1p1f342d5332d22cb1f10c364de4c311fa6~CGHEsLIUU3273632736eucas1p1M;
	Tue, 14 Jul 2026 07:47:56 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260714074756eusmtip2b7c3af04b4d864a29449219fd05421cc~CGHELaUfv1687316873eusmtip2m;
	Tue, 14 Jul 2026 07:47:56 +0000 (GMT)
Date: Tue, 14 Jul 2026 09:47:53 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk, maxime.chevallier@bootlin.com,
	Jose.Abreu@synopsys.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 0/3] net: stmmac: L3/L4 filter bug fixes
Message-ID: <alXpqbP4SGZXozt6@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260714023716.29865-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-CMS-MailID: 20260714074756eucas1p1f342d5332d22cb1f10c364de4c311fa6
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----BPbw8mQRoEt0u-7Bumi.mWTL05vKK99i-nO8JDZ4gq6NpdnW=_2873b_"
X-RootMTR: 20260714074756eucas1p1f342d5332d22cb1f10c364de4c311fa6
X-EPHeader: CA
X-CMS-RootMailID: 20260714074756eucas1p1f342d5332d22cb1f10c364de4c311fa6
References: <20260714023716.29865-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
	<CGME20260714074756eucas1p1f342d5332d22cb1f10c364de4c311fa6@eucas1p1.samsung.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[samsung.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307378-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:muhammad.nazim.amirul.nazle.asmade@altera.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[altera.com:email,vger.kernel.org:from_smtp,samsung.com:from_mime,samsung.com:email,samsung.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E2307520F3

------BPbw8mQRoEt0u-7Bumi.mWTL05vKK99i-nO8JDZ4gq6NpdnW=_2873b_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Jul 13, 2026 at 07:37:12PM -0700, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> This series fixes three bugs in the stmmac L3/L4 TC flower filter
> implementation for the XGMAC2 core. All three patches target net.
> 
> The L3/L4 filter match count statistics patch (originally patch 4/4)
> has been split out and will be sent separately against net-next per
> Andrew Lunn's review of v1.
> 
> Patch 1 fixes a register corruption bug in the L4 filter port configuration.
> The XGMAC_L4_ADDR register holds both source and destination port match
> values in a single register. The original code overwrites the entire register
> when setting either field, silently erasing the other. This is fixed by
> using a read-modify-write sequence.
> 
> Patch 2 fixes the basic flow match parser to properly reject unsupported
> offload requests with -EOPNOTSUPP instead of silently accepting them.
> Unsupported cases include partial protocol masks, non-IPv4 network proto,
> and non-TCP/UDP transport proto. Extack messages are now included so users
> know exactly which part of the match is unsupported. The -EOPNOTSUPP is
> also now returned directly instead of using break, which was silently
> discarding the error on FLOW_CLS_REPLACE operations.
> 
> Patch 3 fixes a stale action bug on filter deletion. When a filter entry
> with a drop action is deleted, the action field was not reset, causing
> it to persist and potentially affect subsequent filter configurations.
> 
> All three patches fix the original L3/L4 filter implementation introduced in
> 425eabddaf0f ("net: stmmac: Implement L3/L4 Filters using TC Flower").
> 
> Changes in v3:
> - Patch 2: add extack messages to each -EOPNOTSUPP return (Jakub Kicinski)
> - Patch 2: return -EOPNOTSUPP directly instead of break to avoid silently
>   reporting success on unsupported FLOW_CLS_REPLACE (Sashiko review)
> 
> Changes in v2:
> - Split patch 4/4 (ethtool stats) out to net-next per Andrew Lunn's review
> 
> Nazim Amirul (3):
>   net: stmmac: xgmac: fix l4 filter port overwrite on register update
>   net: stmmac: fix l3l4 filter rejecting unsupported offload requests
>   net: stmmac: reset residual action in L3L4 filters on delete
> 
>  .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 28 ++++++++-------
>  .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 35 +++++++++++++++++++
>  2 files changed, 51 insertions(+), 12 deletions(-)
>

I think you probably should have done [PATCH RESEND] and it looks bit
funky on mailing list (double cover letter ?), but is fine on patchwork.

One nit:
- Not sure EOPNOTSUPP is optimal, as this is just wrong config and maybe
  something like EINVAL would be better? But thats whatever

I have no means to test this now, but 1st patch seems to solve lot of
encountered issues.

For the series:
Reviewed-by: Jakub Raczynski <j.raczynski@samsung.com>

BR
Jakub Raczynski 

------BPbw8mQRoEt0u-7Bumi.mWTL05vKK99i-nO8JDZ4gq6NpdnW=_2873b_
Content-Type: text/plain; charset="utf-8"


------BPbw8mQRoEt0u-7Bumi.mWTL05vKK99i-nO8JDZ4gq6NpdnW=_2873b_--

