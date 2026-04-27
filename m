Return-Path: <netdev+bounces-281369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNvfMKpx72n6BQEAu9opvQ
	(envelope-from <netdev+bounces-281369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:24:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 690854744FA
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3DA73016F15
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 14:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5640EF9C0;
	Mon, 27 Apr 2026 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IJyw50GF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B423D5223;
	Mon, 27 Apr 2026 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777299782; cv=none; b=iqH8H1+MtAdLWxbYWJ8gWLqi8vRy2zrpOL+LMVAHS56OnkeN8A3snEZVHQSRWU29XOHk7r0P1m5R4JJibGv4Y2Vp0fcw7n7OnEmXZ3z51H2EzNWRpu+j2947yJHInIGCGDYuRvxHbteELv8tGSoKkrs2yq66ZBRCyLhVrO0Dv+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777299782; c=relaxed/simple;
	bh=x3INYK3FMdwrkwM/uwyEQ2Ke1ivaYA0MvNR0xVSCPWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BK4ZIRk3/sAqDjTFLNkdh9ykJpXgkE3Jks0302j5tagZMiiFG6gsqlqt27Rzg5Qgqi1bQYzJ10KWO/rk/yQYSB/Dfsg0WL6M+Umpnp7Udy2SQ4L8FhLECQ1PlFjLCUGIkR8e0vyGmqJACr7Lk7vop1xqtxXZUJ5LMpbHlyuuVjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IJyw50GF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KYfYtf5Y4Fyu2QE8+zpHAIL9xId7qqkHn3ODGSBMfBg=; b=IJyw50GFOFMgsD6WDyh2COPUuJ
	oqY1DdVUBP4s+3OqO8MoGdBu7yK6awZk0fTFKGxqct2ylxs+gvV/Y+IZLDU/6TXAWrQ9M/yh/+d4L
	2v2viFH3PZqouIwsFIqa2OrlLmXu/60IEExuo9CMPmaeOjPUkjjLnyZKb7ZgQVEN3sVc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHMrF-000AqO-ES; Mon, 27 Apr 2026 16:22:45 +0200
Date: Mon, 27 Apr 2026 16:22:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Javen <javen_xu@realsil.com.cn>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"nic_swsd@realtek.com" <nic_swsd@realtek.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC Patch net-next v1 1/9] r8169: add some register definitions
Message-ID: <d7240f69-66de-41e2-a4fb-f7757cac1c94@lunn.ch>
References: <20260420021957.1756-1-javen_xu@realsil.com.cn>
 <20260420021957.1756-2-javen_xu@realsil.com.cn>
 <546ff9b7-68b0-46ff-9db4-5fcde421f7df@gmail.com>
 <335ace172e20415ead8e56ae117b0fce@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <335ace172e20415ead8e56ae117b0fce@realsil.com.cn>
X-Rspamd-Queue-Id: 690854744FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281369-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid,realsil.com.cn:email]

On Mon, Apr 27, 2026 at 06:41:22AM +0000, Javen wrote:
> >On 20.04.2026 04:19, javen wrote:
> >> From: Javen Xu <javen_xu@realsil.com.cn>
> >>
> >> To support rss, this patch adds some macro definitions and register
> >> definitions.
> >>
> >> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> >> ---
> >>  drivers/net/ethernet/realtek/r8169_main.c | 75
> >> +++++++++++++++++++++++
> >>  1 file changed, 75 insertions(+)
> >>
> >> diff --git a/drivers/net/ethernet/realtek/r8169_main.c
> >> b/drivers/net/ethernet/realtek/r8169_main.c
> >> index 791277e750ba..0fbec27e4a0d 100644
> >> --- a/drivers/net/ethernet/realtek/r8169_main.c
> >> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> >> @@ -77,6 +77,23 @@
> >>  #define R8169_RX_RING_BYTES  (NUM_RX_DESC * sizeof(struct RxDesc))
> >>  #define R8169_TX_STOP_THRS   (MAX_SKB_FRAGS + 1)
> >>  #define R8169_TX_START_THRS  (2 * R8169_TX_STOP_THRS)
> >> +#define R8169_MAX_RX_QUEUES  8
> >> +#define R8169_MAX_TX_QUEUES  1
> >> +#define R8169_MAX_MSIX_VEC   32
> >> +#define R8127_MAX_TX_QUEUES  1
> >
> >Then why multi tx queue support?
> >
> >> +#define R8127_MAX_RX_QUEUES  8
> >> +#define R8127_MAX_IRQ                32
> >> +#define R8127_MIN_IRQ                30
> >
> >This isn't self-explanatory. What do min and max refer to here?
> 
> The hardware actually reserves a 64-bit interrupt status space for the new mapping in RTL8127. Although I don't think it is reasonable, its hardware design.
> - Vector 0-7 (from reg 0x0d04): Rx queues
> - Vector 8-15 (from reg 0x0d04): Tx queues
> - Vector 29 (from reg 0x0d06): Link Status Change (LSC)
> As the Link Status Change interrupt is fixed at vector index 29, we are forced to request a minimum of 30 MSI-X vectors from the PCI core.


Thanks for the explanation. Now please try to explain that in code, so
developers can understand what the driver is doing and why.

	Andrew

