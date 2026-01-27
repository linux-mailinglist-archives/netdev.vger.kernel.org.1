Return-Path: <netdev+bounces-253663-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KpHAeApeGl7oQEAu9opvQ
	(envelope-from <netdev+bounces-253663-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:58:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB0E8F4C1
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C88A3013ABB
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 02:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1321B1F3D56;
	Tue, 27 Jan 2026 02:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwrFUzI0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C59139D
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 02:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769482461; cv=none; b=TfO9wBEcO8JC9ETaJG9LhZQvBz/cmToduwkTlcYVBgNfZPJxjYEVxIDdHwYc9sCkzy9CBXp3AYBmkiljyP4bK+VPncFqXaX6H4NxxXdkTvCWf02TpysMvDdialnSt7HQ1BJhGmi5zkNz2+JxpiprjuHh0Ml5INIUQN1iKMjA5dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769482461; c=relaxed/simple;
	bh=t5Ws8K9ruX9jK+rrFbsHhjSSQv/nHotDIXG0CEYJYd8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0GX+5G1DRz1rKNsjMqs0s5vHMfNGWWZEke2UcNbhOqfN7dxNes7Ewi8vBbJjr/XSVvMcLlAeE43AjduFCalcv1LwMRKeHD3/LjUE5xxmCebiy6MXnk14pp0sJ/88imxsxKmZjMyO8TKbhk5QH+RMoI1ey1/4h932OTNyCBgb9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwrFUzI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030B4C116C6;
	Tue, 27 Jan 2026 02:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769482460;
	bh=t5Ws8K9ruX9jK+rrFbsHhjSSQv/nHotDIXG0CEYJYd8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gwrFUzI00eEw/Xbx59fhVsGFJm6+EaEH58Fw34xJ2gBMcoAuxFP3JYa77vY6YQpsb
	 CUXwOZopU/dGFO8MasO7NZGLZFWB67RIr9HPG7u6whk3ifg1rP6xqMHJZx9AHshYZN
	 TTQtK5Z15YmL/Yi02BXYkdARCr0TwsfaRkVgeu3NZxJ4jU64ZFv8sFYdK+f68iHbxY
	 t77HU3V+bmyt5ybyLh/WIcR2MOrhHmtuIBs+wLrp49R0h4Xy/FNW8Z+LnsPXMoI6Jr
	 fOZPLFajNKmCGntEK6lwFdhpxpU4aA+AsJEIwt/dPoEifECT4uHoiCkYCyVW9uzjfG
	 sZ/R6K6MGG7MA==
Date: Mon, 26 Jan 2026 18:54:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Heiko
 Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 06/22] net: stmmac: rk: add SoC specific
 ->init() method
Message-ID: <20260126185419.626ba56e@kernel.org>
In-Reply-To: <aXgbEYvjcXqQKRIx@shell.armlinux.org.uk>
References: <aXdTi4ViCkhhXvFI@shell.armlinux.org.uk>
	<E1vkL28-00000005usi-30YC@rmk-PC.armlinux.org.uk>
	<aXd7aSk7KIxlQd5z@shell.armlinux.org.uk>
	<20260126165144.25055591@kernel.org>
	<aXgN2UjiI_OxWHH-@shell.armlinux.org.uk>
	<20260126171606.6153aa1a@kernel.org>
	<aXgbEYvjcXqQKRIx@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-253663-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7DB0E8F4C1
X-Rspamd-Action: no action

On Tue, 27 Jan 2026 01:55:29 +0000 Russell King (Oracle) wrote:
> On Mon, Jan 26, 2026 at 05:16:06PM -0800, Jakub Kicinski wrote:
> > On Tue, 27 Jan 2026 00:59:05 +0000 Russell King (Oracle) wrote:  
> > > This sounds like my contributions to netdev aren't valued, and if that's
> > > the case, I will stop.  
> > 
> > Quite the opposite, what I'm saying is that your complaints make me
> > feel like the weekends spent on trying to make this project come out 
> > of stone age testing-wise are not appreciated. Of course your
> > contributions are appreciated.
> > 
> > The AI code reviews on existing buggy code are indeed very painful.
> > Not sure what we can do here to make the contributing easier.
> > It costs us around $2 now to review a single patch so we can't afford
> > public access. I think Google is working on making Gemini code reviews
> > public and free, hopefully that materializes.  
> 
> For a series of this size and complexity, the AI reviews are valued
> because it's finding real issues that I can't test for.
> 
> The big problem is that the AI only finds one issue with a patch, not
> all the issues. So, it's going to take multiple submissions to get to
> a point where the AI review of this series is clean.
> 
> I suspect the problem with "AI only finds one issue" is that the AI
> systems aren't advanced enough to do anything else yet.

Yes, looking at its "reasoning" output it both goes down different
investigation paths each time but more importantly it runs out of
tokens at some point, so it won't cover all the same paths each time.

> So, do I continue fixing the AI issues each day and resubmitting a new
> version of this series each day this week, costing $44 each time?

I think so.. I don't want to change our process because of AI, but 
some ways to save cost rhyme with our normal recommendations.
Keep the series under 15 patches. Split the series up, and extract
trivial patches out so that they can be applied and not reposted.

> Do we reach a point where it gets merged even though the AI review
> still has issues?

Whether the comment comes from AI is secondary, so it's just a question
of whether we merge code knowing that it has issues. Rarely, I guess.

> These are honest questions... and if they haven't been considered, I
> think they need to be, because I can see this series becoming very
> expensive.

