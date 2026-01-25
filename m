Return-Path: <netdev+bounces-253243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id K3iyI4aZdmmESwEAu9opvQ
	(envelope-from <netdev+bounces-253243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:30:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F5782B14
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B52A63004267
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007C32264CC;
	Sun, 25 Jan 2026 22:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMiM5pmf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FF63EBF09
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769380227; cv=none; b=mI/OE4BmQzbxOedrSA8K759kKCXC07sDa/ms6y392QsnpEm1gdTZGJOJisqf0TKNyrhTsjejxU1kZ6SXzIhWrpjehC5kjFgAIl52XZ7zv7JiHhkJGQLGwVkKsOn8+ftEKQ70MQcHMnWSIVwyeech4Ifjeg72YXG+gJapAeivkro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769380227; c=relaxed/simple;
	bh=0x6QUhS6URPmuUQuF152sT1aQFQKoPAJ7u8jb5l6mi0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OXy+Hynv401oQg063Yis7dQBTsgtmIzbFO2or5+9/PTVbLk/Zks85XW4nO3dgNqUaOX6l+YevX9d9WlV2hGl/UhcII8Iimg+12E31N3lrYD6bKjfdtyqQ+EGX967o5bMmTtb0Qdocj/3gzQjW3nt0zqWVzCNaJBZ7Rv+bbRmbpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMiM5pmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47DFC4CEF1;
	Sun, 25 Jan 2026 22:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769380227;
	bh=0x6QUhS6URPmuUQuF152sT1aQFQKoPAJ7u8jb5l6mi0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cMiM5pmfBr16sShGWMHD+j6hZuQposA8lDSWFfF/tS4QUMBzF3pO/hKmNyrEGxutM
	 nAZje/MK/yMk1ToOuRiuiCf4Eix6C4EV22JGcIJZyciViYdXl3LunvGbM1lQu8g9jw
	 8W1yKp6UQk3qVY3IFmzQ4/Kty5tuGSrK23Agn+f7yOWu6vNBjP6JEiHBuyLD9ksMJS
	 oWm4cXgg14/SZ8QZPWcE6hTH2OtjB7dzHIE/+eRrG9sz7y7gFzm2Tf92cSY6tuM9gl
	 6+0PB3B8GTTZhirEv9JtWtpcnCP6PIWvUt0lm8iQaGzqoyBzQxvZrihAOGO9sFRg8+
	 YBdP98IWB7mhg==
Date: Sun, 25 Jan 2026 14:30:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Mohsin Bashir
 <mohsin.bashr@gmail.com>, netdev@vger.kernel.org, alexanderduyck@fb.com,
 alok.a.tiwari@oracle.com, andrew+netdev@lunn.ch, andrew@lunn.ch,
 chuck.lever@oracle.com, davem@davemloft.net, donald.hunter@gmail.com,
 edumazet@google.com, horms@kernel.org, idosch@nvidia.com,
 jacob.e.keller@intel.com, kernel-team@meta.com, kory.maincent@bootlin.com,
 lee@trager.us, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 kernel@pengutronix.de
Subject: Re: [PATCH net-next 0/3] net: ethtool: Track TX pause storm
Message-ID: <20260125143025.1bab8769@kernel.org>
In-Reply-To: <aa5f189a-ac62-4633-97b5-ebf939e9c535@nvidia.com>
References: <20260122192158.428882-1-mohsin.bashr@gmail.com>
	<aXNAjOjkCqOESf5y@pengutronix.de>
	<aXNbTVF5KNz1yV-1@pengutronix.de>
	<20260123104031.16d914e4@kernel.org>
	<aa5f189a-ac62-4633-97b5-ebf939e9c535@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253243-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[pengutronix.de,gmail.com,vger.kernel.org,fb.com,oracle.com,lunn.ch,davemloft.net,google.com,kernel.org,nvidia.com,intel.com,meta.com,bootlin.com,trager.us,redhat.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E6F5782B14
X-Rspamd-Action: no action

On Sun, 25 Jan 2026 11:59:07 +0200 Gal Pressman wrote:
> On 23/01/2026 20:40, Jakub Kicinski wrote:
> >> - The auto-recovery (service task) enforces a fixed policy. Can we make
> >>   this configurable? I used devlink health (.recover) to let userspace
> >>   decide between auto-reset or manual intervention.  
> > 
> > There is already a tunable for this exact feature but for PFC:
> > ETHTOOL_PFC_PREVENTION_TOUT. Should be trivial to add the same thing for
> > non-PFC pause. But we didn't want to open the uAPI can of warms unless
> > there's a clear ask and consensus. We don't need tuning (or so we
> > think), and there was some talk about not adding uAPI for fbnic because
> > it's a "private device".  
> 
> I had to refresh my memory on this, but I think we've chosen a non-ideal
> name back then.
> We use this value for both PFC and global pause, I recommend you do the
> same (perhaps with better documentation?).

Excellent, I was wondering if that may indeed be the case. Thanks for
doing the digging. Let's respin, use that knob and document it better
as you suggest.

> mlx5 exposes tx_pause_storm_warning_events/tx_pause_storm_error_events
> through 'ethtool -S', we can probably assign one of them into
> tx-pause-storm-events.

Do you prefer to take care of that or should Mohsin do it? According to
https://enterprise-support.nvidia.com/s/article/understanding-mlx5-ethtool-counters
sounds like the "error" counter is the one that matches.

