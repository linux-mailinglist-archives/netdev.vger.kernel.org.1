Return-Path: <netdev+bounces-286324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANjUKnqrAGrhLQEAu9opvQ
	(envelope-from <netdev+bounces-286324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:59:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B78504F63
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6862D300104B
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 15:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF833A6EE3;
	Sun, 10 May 2026 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irXJtI1i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D804D3A2571;
	Sun, 10 May 2026 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778428790; cv=none; b=eSm/nzfNuZ6GogDqQuSf04QZOSJRxNyzDxuzubgvEKH7wLxrKXiMasEFjza3uYaVx+fJYlgO4GqpRSV1GXGcVjdhXT/ODaI2di03ZU166db3hkdGoCciRomaFcXpeMEG06SRZHVQ8GZFy64W8UgwmsTrwzENFhdTvzMz+zB17N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778428790; c=relaxed/simple;
	bh=5b44R9A+1FqS91NncqFrxNHWtkWlDfsMpLqKYOx3rBM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IvWoDE5kRFpZiqMdhfNvb/h8nqgdpKctj0gZqJYrTimY3S1kak58s1HBPdHP6p5rOXJ+STl+iPiRbXOHq+Tal42djbk81DHxuxfrg10TPhRvYwJocFh9Hk6yn0eLQBWup9U5KCQ1kz7L42+460qij2v7SSq56YBVdXAczvERzqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irXJtI1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5742DC2BCB8;
	Sun, 10 May 2026 15:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778428789;
	bh=5b44R9A+1FqS91NncqFrxNHWtkWlDfsMpLqKYOx3rBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=irXJtI1i54ty39NWHMs/sYfv6N3yN0v+vcbZfOVJdV2tsPVnC/CQoCeflsRulhy5o
	 XzRhkZEryqrA1WdA8nByaphgyA74ndROOqUftpMgpl2d6NAn8QDROP1dQFoEb5U5/+
	 O4GbaFko6ZWdADmwpKYqQfXQ46b2ck2HErMx//c4bwE+NtxjNTJiedEMYUYiRtIpgs
	 /3SGXPjIPQCmHK7jU6eu9arieFnsE+J2Zb/IcF7bpDlZkfMafrXpUkS5vHcEG9PiTv
	 nItkDYOL4z/kniuxOeGsF2XKu9LbYsxlUVJHdfkkEmI4jueB2xX/Jd5qXwhtmbG/ZH
	 Hue6gh6wsmCBA==
Date: Sun, 10 May 2026 08:59:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: patchwork-bot+netdevbpf@kernel.org, linux-kernel@vger.kernel.org,
 macro@orcam.me.uk, netdev@vger.kernel.org
Subject: Re: MAINTAINERS: Add self for the 3c509 network driver
Message-ID: <20260510085948.396ed523@kernel.org>
In-Reply-To: <20260509230519.57607-2-enelsonmoore@gmail.com>
References: <177827761704.865600.12887598979033208728.git-patchwork-notify@kernel.org>
	<20260509230519.57607-2-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 45B78504F63
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286324-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,netdevbpf];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sat,  9 May 2026 16:05:20 -0700 Ethan Nelson-Moore wrote:
> > This patch was applied to netdev/net.git (main)
> > by Jakub Kicinski <kuba@kernel.org>:  
> [...]
> >   - MAINTAINERS: Add self for the 3c509 network driver  
> 
> Did you forget to revert the driver removal, or have you just not gotten
> around to it yet?

Heh, I only checked this file isn't already covered.
Did not expect someone could send a patch for a driver that doesn't
exist. 

