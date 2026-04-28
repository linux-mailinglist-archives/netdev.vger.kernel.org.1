Return-Path: <netdev+bounces-281951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aN2lN+rR8GnDYwEAu9opvQ
	(envelope-from <netdev+bounces-281951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:27:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8073B487D0C
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8299C301703F
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0746E3B52FE;
	Tue, 28 Apr 2026 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaR6Sspa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F223B27F3
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777390028; cv=none; b=lMW/zfPkvblWee2EkUdX3mB5+GdaLOmlTPciCvFYLAMH91wHb0ozHieVvrnw0/27l1ebuXzDpOK6Q7R+bC9M34p2HeMxffhvkohm02zt62RfZvfyJ/+zPlsaw5dvcMl3PXAdaWHF25he57/unMa0JmCWpQNnAGySxbPSWYSp/Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777390028; c=relaxed/simple;
	bh=A8XtxfWYhNGKyD7aPL9zb7Vkmi6ASiCZ1zxx/Oi3BTc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZxO27748u4d44o3hapXpPqVYeYyjn32ylVDtF4UJG1eyiz6RYGOw7ka+PE5mvBD6PypjMByBOx3zjVxgloIHz0qOut+tiJNSI7JQhKO9piKfDNDd7b7au3bfrM4k/4/l3btAb6VOplLEi+PmhJANDGY3YkbmEXAK6upv0v9yasg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaR6Sspa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EC9C2BCAF;
	Tue, 28 Apr 2026 15:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777390028;
	bh=A8XtxfWYhNGKyD7aPL9zb7Vkmi6ASiCZ1zxx/Oi3BTc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kaR6Sspa+oaPFkMoT0cMu3BDu4Xw6e9WjanAdjlE2NDZl0xPb/RpFj9YNdfhQqnqr
	 pfmU0+q0v8RX5AYSe6BoCwSG94Wm5P22fp7Eao+xmONhoqQZ1iQkRtF29GuDJg42RJ
	 z7K5kqdKcI3REXhhD7DhOLcuYmhUR+B5RlVkonIVLNV/VRu+7ykzr90Lzfd2nu1PP1
	 SC+djjuEDBtMPb5EtDVEpBZBLslkbYPahCfKGvFTo7hcDFwuB8sWkVVU9S8f36nmVw
	 /hXU+ubVqv128YRfUMadLRN5XqKxUa/8N/zpEdw/K6UFelZh8vLGQ/Jl++HIQyUQ/A
	 hFzKgd/EBXW1g==
Date: Tue, 28 Apr 2026 08:27:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Satish Kharat <satishkh@cisco.com>
Cc: netdev@vger.kernel.org
Subject: Re: Recommended local LLM-assisted review for netdev submissions?
Message-ID: <20260428082707.606e7a94@kernel.org>
In-Reply-To: <20260428151755.1310712-1-satishkh@cisco.com>
References: <20260428151755.1310712-1-satishkh@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8073B487D0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281951-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, 28 Apr 2026 08:17:55 -0700 Satish Kharat wrote:
> I'm the author of the in-flight enic SR-IOV series. Before posting
> revisions I run checkpatch --strict, make W=1 C=1 on touched files,
> scripts/kernel-doc -none, and `b4 prep --check`.
> 
> I've read Jesse's Netdev 0x18 talk on AI-enhanced reviews [1], the
> LWN coverage [2][3], and looked at sashiko [4]. What I haven't been
> able to tell from the public material:
> 
>   - Is sashiko (or a successor) what's currently producing the
>     LLM-style review replies showing up on netdev, or is that a
>     different pipeline?
>   - For contributors who'd like to self-review with the same
>     prompt/ruleset before posting, is there a recommended setup,
>     or is sashiko-as-is the closest thing today?

Our current recommendation for "individual" contributors is to use
the review prompts directly:
https://netdev-ai.bots.linux.dev/ai-local.html

If you have / can get LLM API keys sashiko seems to be producing
better results (although not strictly better). Ideally you'd want
to run Sashiko on all three of the major LLM models and then another
sweep to coalesce the results. We can't do this at netdev today because
it's cost prohibitive. But Google's Sashiko runs on Gemini, ours runs
on Claude and they find different things..

I tried to improve Sashiko + CLI models but from my limited
experimentation it's worse than just using the review prompts.

> Happy with a one-line pointer if it's already documented somewhere
> I missed.

Sorry for not having the source of truth. The space is rapidly
evolving :(

