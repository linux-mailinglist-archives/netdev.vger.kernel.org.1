Return-Path: <netdev+bounces-275739-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DD8J4Mg1GkxrgcAu9opvQ
	(envelope-from <netdev+bounces-275739-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 23:07:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE373A7692
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 23:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D63AB302A7D9
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 21:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF9330EF7D;
	Mon,  6 Apr 2026 21:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="PHwJHf9e"
X-Original-To: netdev@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629102D7BF;
	Mon,  6 Apr 2026 21:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775509630; cv=none; b=Ul6R+mpBHIYWBbF+1WnQp/3O/eUy+tBEPEXT/HU9BzfShowF6Vz3s5kyvRBDExjvQ0bUh4CFo6gldDfBfjY7rbRuS5OG2Xh5ObehHB16QeNpgjJfRp5dPae7X3HPVTsps9Bsu+TDqirfT/4wgZv/d4VGnyZGar61CS4OevV4DLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775509630; c=relaxed/simple;
	bh=1LOfMHXAr/3VoSQrFTWUhUhKZV2VaoER/vYpoa0XP0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eywbwrYwBbbuWkNgU8LPF+8nDzypXflUPznfo4RS/vECs+89fPbFEfxu/4fy/VKV+GCsfRKTPBinkUqN5btkBE0PYnPinMitHV8iYM2z1nMRq+Mmt6MNRJ9VSjIkno3dOZP5//ovtqGiw18nW5BgBz5dpaZoGERLvLCIQlQ8luI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=PHwJHf9e; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from killaraus.ideasonboard.com (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id DF513143F;
	Mon,  6 Apr 2026 23:05:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1775509533;
	bh=1LOfMHXAr/3VoSQrFTWUhUhKZV2VaoER/vYpoa0XP0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PHwJHf9eaBqF0JQPh+ng+LOsd6OrJW9PeBsdhY3K7cVhiU2sfzphJxwtKXzmdosyK
	 phr84tEWXSqYHDuxsNazBpARTpABGzraGcBDW55sRVfZWlNJXDyU8ENxYQuPmm7UNx
	 IvpGfLzo6EjfB6B2jUBX5wjo9I7QEb3/lTEa0FvE=
Date: Tue, 7 Apr 2026 00:06:57 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, mbloch@nvidia.com
Subject: Re: [PATCH net-next] docs: netdev: document AI-assisted review
 tooling
Message-ID: <20260406210657.GD1268443@killaraus.ideasonboard.com>
References: <20260406-nb-docs-ai-review-v1-1-b58943762ca9@tipi-net.de>
 <345722f0-21b1-4970-8c45-ef85edf9d45b@suse.de>
 <56c5bdfe2e37738e47b3b4d22e21697c@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56c5bdfe2e37738e47b3b4d22e21697c@tipi-net.de>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ideasonboard.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ideasonboard.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275739-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[ideasonboard.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laurent.pinchart@ideasonboard.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,killaraus.ideasonboard.com:mid]
X-Rspamd-Queue-Id: 1AE373A7692
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 10:24:14PM +0200, Nicolai Buchwitz wrote:
> On 6.4.2026 21:58, Fernando Fernandez Mancera wrote:
> > [...]
> 
> > 
> > Hi Nicolai,
> > maybe I am missing something but [2] isn't from sashiko.dev but from 
> > netdev AI CI instead. See: 
> > https://netdev-ai.bots.linux.dev/ai-review.html?id=0b114a22-9aab-4265-8bfc-ea1b5bca5514
> 
> You're right, I mixed up the two systems - the example I linked was
> from the netdev AI bot, not Sashiko. My mistake on the link.
> 
> I stumbled over Sashiko when I noticed the name appearing more often
> in other reviews and then found Jonathan's LWN article about it [1].
> 
> Both tools are actively reviewing patches on the list today. I think
> it makes sense to document both rather than just one:
> 
> The netdev AI bot at netdev-ai.bots.linux.dev
> Sashiko at sashiko.dev, which posts reviews publicly on its website
> Both use the same review prompts by Chris Mason [2], so there is
> common ground - though results will vary between them due to the
> different AI models (Claude Opus for netdev-ai, Gemini for Sashiko)
> on top of the usual AI uncertainty.
> 
> I think it would be useful to document that AI reviews are happening
> but mixing AI bots might confuse people.
> 
> Agreed, I'll rework the patch to distinguish the two systems once
> the discussion has been settled.
> 
> > The documentation mentioned for running the AI locally is correctly 
> > related to netdev AI bot.
> > 
> > I think it would be useful to document that AI reviews are happening 
> > but mixing AI bots might confuse people.
> > 
> >> Check for findings on your submissions and address
> >> +valid ones before a maintainer has to relay the same questions.
> >> +
> > 
> > I wonder what would be the consequences for this. If less experienced 
> > submitters are expected to address issues pointed out by AI bots they 
> > might work on something that isn't valid. AFAIU, the AI output is only 
> > forwarded to the submitter after a maintainer reviewed it and believes 
> > it makes sense.
> 
> Fair point. The wording should make clear that the local tooling is
> an optional aid, not an obligation. I'll soften the language around
> addressing findings.
> 
> Would appreciate input on how much detail is appropriate here -
> should the doc just acknowledge that AI review exists and point to
> the tooling, or go into more detail about the workflow?

In general, if a workflow is expected by a subsystem, it should be
documented. I don't see much to be gained from not telling submitters
what they're expecting to do.

More precisely in this case, as a submitter, I would take it pretty
badly if I was told to act on the output of a tool that is prone to
hallucinations without a maintainer first triaging the comments.

> [1] https://lwn.net/Articles/1063292/
> [2] https://github.com/masoncl/review-prompts/blob/main/kernel/subsystem/networking.md
> 
> >> +You can also run AI reviews locally before submitting. Instructions
> >> +and tooling are available at:
> >> +
> >> +  https://netdev-ai.bots.linux.dev/ai-local.html
> >> +
> >>   Testimonials / feedback
> >>   -----------------------
> >> 
> 
> Thanks for your input
> 
> Nicolai

-- 
Regards,

Laurent Pinchart

