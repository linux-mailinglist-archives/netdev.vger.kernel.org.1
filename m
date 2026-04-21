Return-Path: <netdev+bounces-280140-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EHHEI+F52m+9gEAu9opvQ
	(envelope-from <netdev+bounces-280140-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:11:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 079FF43BCDB
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E25E300D1FA
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94B92C2363;
	Tue, 21 Apr 2026 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1+zGoYv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F143D6CB8
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776780645; cv=none; b=utk3FhcywISYTF7V3GjThR3DvST1ecIx3CDcp5dKwImLPd0D3iB9F3PtXb1lanCQy+jLnBMNWONMIQztAsM8zOflLzQrs8OCLr+6tRkNnJvWwWLbgbzxgp0Ie0lxKYWj1QzuhplADQkxlc3AOVxMHW78ty6l79V8B7nKVnW2keM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776780645; c=relaxed/simple;
	bh=BnRYqjTAvtsi8yDNEhLHJLQO5zPjpvVryHdfdcb7h1I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZCmb8h1XJgzbDK9EUnXGh935UT19Y1A+Fs/WybUkXi9iBhPqk7Nu2YSdGUkgXVzrJnNvzEUcp8y3Gjrm0vLpZUrCAszPluIoqHatgTOjxQJuLXkIDHnjvNY0LY+uSL8qcLt6/wMF7Eq0m4rAMPvSu0AoWoq5oi/K6tQTPck/gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1+zGoYv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF693C2BCB0;
	Tue, 21 Apr 2026 14:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776780645;
	bh=BnRYqjTAvtsi8yDNEhLHJLQO5zPjpvVryHdfdcb7h1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y1+zGoYvVPMSzwR6JoAumaAAAa4TU/WYlr1FONKGkl7qGFi/d+8MDq56X9u0BD4sx
	 RuR6kztmmS5a5dCXuhsYbfF5SWjaqvBG5iOrT9Vma9npo0PP5gsAwo4ldeiiNZLRSd
	 F2Thk9CXBrivrnu51mkV88fnRzpcCAVFrx/2uFURherVVFtNQCVtCvemkTdhFH3+79
	 38BytXtLeBZrme9JYDx80STqbPXEPTj/FdSIXVCJdcYkeJmDnUPV75T7i0dEFBOgRE
	 n2o9zbmdf/FOinz8m9u0elbKBA0lH1IMweZ+KzJtaQJnCPkEuBikFsRGmpbYEmyiUq
	 SwXh1MiZb82Ww==
Date: Tue, 21 Apr 2026 07:10:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Heidelberg <david@ixit.cz>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Michael Thalmeier
 <michael.thalmeier@hale.at>, Raymond Hackley
 <raymondhackley@protonmail.com>, Michael Walle <michael@walle.cc>, Bongsu
 Jeon <bongsu.jeon@samsung.com>, Mark Greer <mgreer@animalcreek.com>,
 netdev@vger.kernel.org
Subject: Re: Path forward for NFC in the kernel
Message-ID: <20260421071044.67a3cee1@kernel.org>
In-Reply-To: <1725ea8d-ac1f-49d2-8d8c-2e09721454c2@ixit.cz>
References: <20260416101041.4c533306@kernel.org>
	<9c4a4acf-b4f1-4e84-93bf-cdf080cb9970@kernel.org>
	<1725ea8d-ac1f-49d2-8d8c-2e09721454c2@ixit.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,hale.at,protonmail.com,walle.cc,samsung.com,animalcreek.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-280140-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 079FF43BCDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 17 Apr 2026 10:12:22 +0200 David Heidelberg wrote:
> > +Cc David Heidelberg recently trying to use Linux NFC stack,
> > 
> > Just "collecting" patches is not a big deal, I could do this, but
> > actually reviewing the patches with necessary due diligence is the
> > effort I could not provide in a reasonable time frame. And picking up
> > patches without proper review feels risky...  
> 
> Hello Krzystof, Jakub,
> 
> thanks for putting me into loop.
> 
> I can do limited reviews and basic maintenance. My knowledge about NFC is for 
> now somehow limited (but I'm willing to invest my limited time into learning more).
> 
> As "I & LLM" wrote [1] userspace very basic reader for GNOME and planning to do 
> more tight integration into GNOME, so would make sense to keep the kernel stack 
> alive.

Hi David!

Sorry for the delay, we (core maintainers) discussed the situation
off-list and since our choices are either delete all this code or give
you a chance, everyone agreed that the latter is strictly better :) 
It's a little unusual to designate someone who doesn't have a proven
track record acting as a de facto maintainer, but such are the times...

Our expectation would be that:
 - you'd create your own tree to gather NFC patches and send us
   periodic pull requests every 2 or 3 weeks, with what you gathered 
 - act upon submissions within 48h of posting (excluding weekends)

Of course we'll happy to provide any support and guidance you need,
specially for the first few months.

Is this what you had in mind? The phrase "limited reviews and basic
maintenance" is slightly worrying, we assumed it's an expression of
modesty rather than commitment? :)

