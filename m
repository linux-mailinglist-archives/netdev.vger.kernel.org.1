Return-Path: <netdev+bounces-263599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCWGBxDIp2kZjwAAu9opvQ
	(envelope-from <netdev+bounces-263599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 06:50:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EDD1FAF84
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 06:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F8863031E9D
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 05:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B2C35C18C;
	Wed,  4 Mar 2026 05:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+pW484X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6B933F378;
	Wed,  4 Mar 2026 05:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772603405; cv=none; b=Vz54bvjwUQXCrd+YxELmEAqFS3B8NmVH9CRxM2wGmIUvDOQ9fbvCZQ7xc1pyonP/uzMZ2nPgZQSSSl9haEgYb+SsVg3YZin0IdEon1qS7zFLroiSQWYnFSGTdR1lyIqfb0lJS06iKMe9cKoDlb/B3jZ5qDRWk7ukZiysaiWGPRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772603405; c=relaxed/simple;
	bh=OwFeDaUYsSCEzFq60nmYWQfF86Foh94m+ZRafgHIQVg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=azoeQW/E7btvP/psp1xldyA6fXmt9zUPYZ9kKCtqkdc6akD9uEwhbJOaq6TYGqf6AVlXFDdPJHFz9wtmLG1V9yBbILWUxQKNlFieOmW2UvS0QbVK4DNMoPQUU7TUlT6ny3jhDFHxvypQ+4JhzgjjWeXPJT4OzCu69HWCYXTYSPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+pW484X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7BFC19423;
	Wed,  4 Mar 2026 05:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772603404;
	bh=OwFeDaUYsSCEzFq60nmYWQfF86Foh94m+ZRafgHIQVg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N+pW484XNio/ZQkGYkrgl7bO4AWHQcRhWRgX8rqm6avLZos0K6kEJMbW7kxVxxVI7
	 tBdi/xvtKLwa1m4T75GZVDZa2DRkw0BQn58HQs0gH+g2ZbFRukP9RzyN26KvF+QBu5
	 qdE+ml1uLyKMMyJC68gjXt5Dz79Am9oSvsst+d7W1fVS9yX8z/oGTQRoZ+hG4BdII8
	 UcoSNoPyJNWWMyZl3hkOdEJq9QDy43uqC4SZz7bHl5zyD47V00E5nkqMtYLRRu1qP6
	 nQ3QPfHAjCsXzMEazpVFeLrIzKuP2xEUVEakKMiUJL++DOGAwDwnhc5Y27+HSqlWBw
	 spJSrebcOlVLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F4B3808200;
	Wed,  4 Mar 2026 05:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests: tc-testing: fix list_categories() crash on
 list
 type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177260340555.1635731.7202537936783562636.git-patchwork-notify@kernel.org>
Date: Wed, 04 Mar 2026 05:50:05 +0000
References: <20260228074735.10438-1-mr.navi8680@gmail.com>
In-Reply-To: <20260228074735.10438-1-mr.navi8680@gmail.com>
To: Naveen A <mr.navi8680@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, jhs@mojatatu.com,
 jiri@resnulli.us, shuah@kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 72EDD1FAF84
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263599-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 28 Feb 2026 13:17:35 +0530 you wrote:
> From: Naveen Anandhan <mr.navi8680@gmail.com>
> 
> list_categories() builds a set directly from the 'category'
> field of each test case. Since 'category' is a list,
> set(map(...)) attempts to insert lists into a set, which
> raises:
> 
> [...]

Here is the summary with links:
  - selftests: tc-testing: fix list_categories() crash on list type
    https://git.kernel.org/netdev/net/c/fbdfa8da05b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



