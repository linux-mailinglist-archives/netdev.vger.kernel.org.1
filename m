Return-Path: <netdev+bounces-281026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDK1L+Sr62nfQAAAu9opvQ
	(envelope-from <netdev+bounces-281026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 19:44:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 409D2462139
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 19:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD965300A50C
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 17:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7253624CE;
	Fri, 24 Apr 2026 17:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CJZQvsCa"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321701D5AD4
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 17:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052641; cv=none; b=BYgFNm9LF9XMPDmmPi4X7yo1NBIgIbhOsYfHgxx/+4YWteywKmolgRxf2hHe9WWB+mDS+s+zLgmHErKwDS8x315v5Yzoum+4YXmSPMiu/sP+FqgHRr6uWNLAnq77cjXjjZTdYbqESDIiYIn5ev2BJy3EJdCdLESwW7M4wXnIidE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052641; c=relaxed/simple;
	bh=uEovCLyUlP+vQ43bmLfSPRWiIERStlsQm1hCynuai2I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NUh8VxIpFUZfjj0wGez3KuX1+CRWN71e8aNk4Ig9ZSxik4H1z6+FZZbyTtf5tttjkSBIqokh2r1NKUt18/H4r0eTjC0Qd0NtHuqoc9LClENc3ss6QyDlLzdSFvaN6UH5yzF4WRDYJdUMU8dU6O3NVTZJA+Vgqi/SaWHwuTAqSAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CJZQvsCa; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777052628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DWCu4wxPcDh4wGenYXek8cabQgd3EbdJF9AepYB3owg=;
	b=CJZQvsCaHjoGNETf/ROZqt1o4J7g39Gh1xZxEjdnHe9LGwjVGjyXvL3NJj0rlVrcjU1lfX
	t7L98fzYO1JkyrALmsPh0JaAjSU5xobarXzd56bkDTyxG9aF4iYaSLddM3C9/05PTrlZ7K
	8Qq3Spyq45h2R/e7dn/BbRtcBnv3NJw=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Paolo Abeni <pabeni@redhat.com>,  Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Networking deletions for 7.1
In-Reply-To: <20260423201029.64927aba@kernel.org> (Jakub Kicinski's message of
	"Thu, 23 Apr 2026 20:10:29 -0700")
References: <20260423235422.1541768-1-kuba@kernel.org>
	<7ia4se8lb0vf.fsf@castle.c.googlers.com>
	<20260423201029.64927aba@kernel.org>
Date: Fri, 24 Apr 2026 17:43:29 +0000
Message-ID: <7ia4ldecb6f2.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 409D2462139
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-281026-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roman.gushchin@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]

Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 24 Apr 2026 01:31:00 +0000 Roman Gushchin wrote:
>> 2c on Sashiko:
>
> Did I say Sashiko 3 times? ;)
> FTR - thanks a lot for the awesome work on that project!

You certainly did :)
Thank you and really appreciate your contributions to Sashiko!

>
>> 1) I'm working on an infrastructure to separate pre-existing issues from
>> new issues. My current thinking is to stop reporting these issues with
>> reviews of new patches and instead put them into some database and give
>> maintainers access to it. Sashiko will automatically deduplicate issues
>> and index them by the source file/subsystem. Hopefully it will mean that
>> maintainers will see only a limited number of issues in source files
>> they support. But I have yet to see how it works in practice.
>> 
>> But I'm somewhat concerned that this way many of these issues will
>> remain there forever and by reporting them with new material we actually
>> have better chances to get them fixes. Maybe it should be configurable
>> per-subsystem. I'm very open for ideas here.
>
> After a couple of hours of glasswing-inspired hacking today I wonder
> if we can close the loop on patch generation without blowing the budget.
> Or maybe a better question would be - how many of the issues are simple
> enough for the LLM to pop out a patch for, once it has all the context
> from the review.

My bet is <50% as of now, but I might be wildly off.

Even for human maintainers or very experienced kernel developers it's
common to have long discussions on what's the best approach, go through
multiple revisions etc. Current generation of LLMs is definitely worse
at code generation, so...

>> 2) Re false positives vs finding more bugs I had the same experience.
>> It's easy to tweak it to be more conservative or creative, but it comes
>> at a price. It seems like the real answer is simple a better model. We
>> saw a big improvement internally switching from Gemini Pro 3.0 to 3.1.
>
> Makes sense. What didn't really land for me until now is that at least
> for now different models are better at catching different types of bugs.
> Off the top of my head, Gemini does short work of misuses of DMA API
> without much context. Claude/codex/whatever the Meta one is called
> externally - none of them catch those.

Yeah, in a perfect world we would run code reviews using all best models
and combine results...

