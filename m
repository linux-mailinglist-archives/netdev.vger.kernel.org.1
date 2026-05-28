Return-Path: <netdev+bounces-292651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yO9YNfUbGGq+dQgAu9opvQ
	(envelope-from <netdev+bounces-292651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:41:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBC95F0CB2
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B157630C4423
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE863A4F30;
	Thu, 28 May 2026 10:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IABOLKkh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F59389107;
	Thu, 28 May 2026 10:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779964572; cv=none; b=I3W0owdXX+oEBhImKrOF68pDByjd1Emon3vhacLzrXkW+EqljGysfiuaQkIfEvFdF65cgsrIMGJVzJ3EiKKOYjmqhCgAhcjGAurx5qXlLe1SXyerciNUpi1ghGThlK+vz84c5tBPgyFW8voeUsYLu/oinNX8Brt0yeQBXpm3Ncs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779964572; c=relaxed/simple;
	bh=oyRkC6DV+Zw+pUbqAVANJkRxwHT0zJuoSs4Ip3KUOT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQTTuzhJ06DUlGZ1QUW+HAe1StTf6mEUjDcNarhiEuc+xRZ8OHI/OrC/Dq8TzEed66AtaeRZyXBHQ7djaZWg0x6qNtMuGJz/HICZ5AjIcGLDRCYfCUH5ORUy4+uI0DHpKwjoIgbpY5MFl0HZk43QFBad5oPgpHyu1UHOJZMTxNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IABOLKkh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184E71F000E9;
	Thu, 28 May 2026 10:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779964571;
	bh=ZKSloW17DUYpt4WwltD0X9HnAYEXYhUSfwzRcfTBnxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IABOLKkhVLvBKSKnjOa5gpA6raIJHm28qMWjxR6lzfgr7SHRFRgfzQbn9dsW4fXTh
	 GEOjgRVgZvpzftraoAnhJZvnEWlNxCo41g/QFQeXSFA+/5Sg+MZ73PFTccZrEUp6dN
	 ID6CcJ/N8pxnSxGaqY8hwreuu9fh4jkzOC3nIzMfaykHoJ8qjiBX5cdr9+7M/+IVjB
	 3CQiexyx/vqqQiBwukkNaXJM0xT9PnH2tvEHp2568dIIaUhGfVPVRHsANB/j4JNGSL
	 KK7Cj+QvPFUU8kcYmEFSKeJyu+aOCA46ifrffPHaR4H5/z9u+OOZuD4OJryfX+mtcO
	 AxnKKes/FYEDQ==
Date: Thu, 28 May 2026 11:36:06 +0100
From: Simon Horman <horms@kernel.org>
To: Javen <javen_xu@realsil.com.cn>
Cc: "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"nic_swsd@realtek.com" <nic_swsd@realtek.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch net-next v5 0/7] r8169: add RSS support for RTL8127
Message-ID: <20260528103606.GS2256768@horms.kernel.org>
References: <20260520031603.700-1-javen_xu@realsil.com.cn>
 <20260522092004.GJ1506108@horms.kernel.org>
 <c8edeb5447444dc49e3ee7bf18166399@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8edeb5447444dc49e3ee7bf18166399@realsil.com.cn>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-292651-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:url,sashiko.dev:url]
X-Rspamd-Queue-Id: 4CBC95F0CB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 07:15:23AM +0000, Javen wrote:
> >On Wed, May 20, 2026 at 11:15:56AM +0800, javen wrote:
> >> From: Javen Xu <javen_xu@realsil.com.cn>
> >>
> >> This patch series adds RSS (Receive Side Scaling) support for the
> >> r8169 ethernet driver, specifically for RTL8127 (RTL_GIGA_MAC_VER_80).
> >>
> >> RSS enables packet distribution across multiple receive queues, which
> >> can significantly improve network throughput on multi-core systems by
> >> allowing parallel processing of incoming packets.
> >
> >...
> >
> >Hi Javen,
> >
> >There are AI generated reviews of this patchset available on bogh
> >https://netdev-ai.bots.linux.dev/sashiko/ and https://sashiko.dev
> >
> >I would appreciate it if you could look over them and address any issues that
> >effect the functionality of your patchset. I do not suggest expanding the scope
> >of this patchset, but rather treating other issues in the context of possible
> >follow-up.
> 
> Hi,
> 
> r8169_main.c used request_irq() before, but I was suggested to use pci_request_irq() to generate the name for each irq dynamically. And I find that in pci_request_irq(), irqflags is fixed to IRQF_SHARED. So I want to know how can I handle with this situation?

I am unsure. But if that is the advice you received then I would suggest
sticking with it.

