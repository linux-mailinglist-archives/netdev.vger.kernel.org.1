Return-Path: <netdev+bounces-263545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xJg3L3mSp2mUiQAAu9opvQ
	(envelope-from <netdev+bounces-263545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 03:01:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7F31F9C07
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 03:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CEF8C300AD49
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 02:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2383AFC0A;
	Wed,  4 Mar 2026 02:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbREuAb4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001CC849C
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 02:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772589684; cv=none; b=rzvAQRK1WlxBoAjd8WK49dN5FFBVy4YwsceVAVetwT305IPOuoZsaV1D92su3o4f6YBG5vgRUhF4gAxxuzzUUw1eObNIDcIZM/9umUiko25sO8KCZ4bVBUWxgxaf3ezSwg7RH7kuoieu40I6Y9CIXRl66oSpPgeTIilo11L49pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772589684; c=relaxed/simple;
	bh=T7FmybkNSy/N0YmI3/gUccmkYfny+vPep341845UZGk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qlurlYKq4BgakoAHF2vHw53IkWLmjQjMqPOIm8E9zsMhp87xemNTAJpm3HSOJBea4qmGBzHjrqSQczdcAqu/FGRKX3OFkCHtkqUeo9eMujy7NGKH69L5xpGqZkUQKUsIJ2TED559ZnzADGOVQku9Zedb9AJHIkBJZzFITkv/9Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbREuAb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA7AC116C6;
	Wed,  4 Mar 2026 02:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772589683;
	bh=T7FmybkNSy/N0YmI3/gUccmkYfny+vPep341845UZGk=;
	h=Date:From:To:Cc:Subject:From;
	b=MbREuAb4zj3QTuCS2lYRLadtP+KLo2/0K4oW9ybnWeNHC/4x8Pi/hfIc/m9+gJaUT
	 sL/72KkbPmIhzqBIqSL6adl9cqK06gG4EZBHaUOwZG5f0M4yQWI6PD637UoslTV3GT
	 ej6H1sdNkQff2uKwyHwgn9FBghrj2cF1I8QuVrXtjvrVfF8qd5yI9ls+QqqzY0vlrj
	 8mZgEDY4sPLPwWvZ7q5XUgSgK6XTJTTv5A4vaxJT0T5Uj7uCCmgNY0Y5EnAPulCR4U
	 iYMIb1SbYcs0rnT3m22cDF5tqZfGwrM/NHOLxCGUhDI7+Tqx20CqwYRm7tPZ+ZEVFX
	 PWmi4hhJBFaDg==
Date: Tue, 3 Mar 2026 18:01:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>
Subject: review scoring
Message-ID: <20260303180122.0929a864@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BA7F31F9C07
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263545-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi!

Alexei just sent an announcement to the BPF list describing
a new system of requiring review participation:
https://lore.kernel.org/all/CAADnVQ+TKKptnNB25V3=bcdybh5G6c2DyW2sYtXvyRaVnPN8MA@mail.gmail.com/
I'm very curious to see how this goes, it definitely feels like
a logical step.

On the netdev side I've been using a patch review queue which
takes into account 
 - the reviewer score of the author
 - the reviewer socre of their employer (using the same logic 
   I use for the periodic "developer statistics" email),
 - quality metrics like "is checkpatch clean"
 - whether someone already reviewed the patches on the list
   (reviews from the same company do not count)

I've been meaning to send an email to let folks know that I'm doing
this. Most large companies are getting a 2 day delay from this scoring
system. To be clear, I'm not intentionally waiting 2 days before
looking at code (at the cost of my sanity). It's just that with our
patch volume if something gets a 2 day delay there's plenty of patches
that will jump earlier in the queue. And so far advancements in AI
failed to make the days any longer..

the queue: https://netdev.bots.linux.dev/suie.html?delegate=netdev

