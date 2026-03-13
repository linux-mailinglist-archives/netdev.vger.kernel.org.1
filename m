Return-Path: <netdev+bounces-267479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJASBtsgtGnahgAAu9opvQ
	(envelope-from <netdev+bounces-267479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:36:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E5428517C
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 629893009033
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0F13A3E9E;
	Fri, 13 Mar 2026 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4msbIrI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9BE3A3E8E
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773412222; cv=none; b=Xpvw8b/+q9WV4wqNtTS0FPbcgzkXGdV2GP+T/0un/xzQkm2t8957vDV4ZzTVfTXXuumPyQX4cdpVSZf+lHZTg0lZPf5vsL9mk/JnY0eaPps0bjW10FdRdekvEQr/ZWO1mBRM+xPXCV/24ERh92C9Ye5cGH4KEkrc+q3PbbZnqCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773412222; c=relaxed/simple;
	bh=Ay+vXhiV8XuqkQrW882GrFkmgzuSWH9fywkBW8jtW0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+Ku51NXdi4peIBTD6Ly39Ieirdcs5ZQ0R37dFtYVQ1LcJQfKd6mGv8wVZkHvAamrJ6ABN7CBeEqfAmiRUQjty1pjSftvKC+a4hIJ3j66IbRauwUEbqJYT/l2mDGuaS+m4JsvevoQgomFnR12liz2s2CHWw38uy1lqIWkHPoqWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4msbIrI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEF9C19421;
	Fri, 13 Mar 2026 14:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773412222;
	bh=Ay+vXhiV8XuqkQrW882GrFkmgzuSWH9fywkBW8jtW0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X4msbIrI1iihPXJ8SoRunh20u/9NK5f72rlEZlV6GLsN4qXi4RhYIeTTYKS7Kkouo
	 F22RbtH9apeRv1EeWqcqN2ZzJC0ydp8RCQoXrKJwlGufxdF6IddJiPAogM7bUdOUL2
	 MBJj0OzyPg/77huTVLU3RhIycLaWGNjA0p8aTs3OhtIB/4/wWH33lqGD8jVf0ZPuo3
	 MKihnbw7Vd9l7AhMPVTMBo+QW/e4hDzx3KcRRnOaEIkW4X+vurkqd5sgvM1S8V43mL
	 Gm3PQTyxz7eBfWkPag7RU07e9x5U6xux0cZZDHSl3manqfOL4dUBSveGp0TZ22WPMd
	 UPooWldAcCwPw==
Date: Fri, 13 Mar 2026 14:30:18 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: select QDMA block according
 LAN/WAN configuration
Message-ID: <20260313143018.GD461701@kernel.org>
References: <20260310-airoha-qdma-lan-wan-mode-v1-1-64ec74dea872@kernel.org>
 <20260312172430.GA1267298@kernel.org>
 <abMsvOMnnuTdoG-9@lore-desk>
 <20260312172248.68742f98@kernel.org>
 <abP2dLNIw6zqkxL4@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abP2dLNIw6zqkxL4@lore-desk>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267479-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75E5428517C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 12:35:16PM +0100, Lorenzo Bianconi wrote:
> > On Thu, 12 Mar 2026 22:14:36 +0100 Lorenzo Bianconi wrote:
> > > > Is this a bug fix?
> > > > If so, perhaps it is for net with a fixes tag.  
> > > 
> > > I guess we do not need to target net tree since airoha_eth driver currently
> > > supports just the LAN interface via the MT7530 DSA switch connected to GDM1
> > > and there are no WAN interfaces officially supported (PCS/external phy is not
> > > merged mainline yet, it is only available in OpenWrt).
> > > 
> > > > 
> > > > And at any rate, could you add some description of the before and after
> > > > behaviour?  
> > > 
> > > Theoretically, before this patch, GDM ports were equally distributed between
> > > QDMA0 and QDMA1 while this patch assigns LAN interfaces to QDMA0 and WAN
> > > interface to QDMA1. However, for the reason explained above, this change is
> > > not currently visible to the user.
> > 
> > Please update the commit message. And please try harder to explain 
> > the patches, this happens a lot with your submissions..
> 
> ack, fine. Sorry for not beeing very clear about this (and other
> patches), I will pay more attention in the future.
> Do you think we should target net-next or net for this patch?

Hi Lorenzo,

As per your explanation above it seems to me that there is
no user-visible change. And I assume that implies no bug manifests.

If so, net-next sounds right to me.

