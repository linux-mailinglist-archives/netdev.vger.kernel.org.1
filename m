Return-Path: <netdev+bounces-278183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG8wC68/3Wm2bQkAu9opvQ
	(envelope-from <netdev+bounces-278183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 21:10:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1CC3F27D3
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 21:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C3DA30164C9
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95673446C8;
	Mon, 13 Apr 2026 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2J1Ltq8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BE4318EE2
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776107435; cv=none; b=gqLToHNaXRvxUq9G4IEOwxnMZIqq6skhuMe8iVVoINVxklCe1N7VkWSTk+sPgAKEVqlI3Qvkeaf/heszBg/CJR0F/TcPrv/xp3pQfVNhP0hF/FDhHcZBqT3pZH3hofUfYEr1hyk1c4MSFYLtfuViQyw7BOTa1zq5xdlINmMP+ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776107435; c=relaxed/simple;
	bh=4Oe5L5ZzSwQEoeE5dC3O3OcveobiRZ+9ttZMhubSr3c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=huK8Py+W4x7viLXTV1/DgL2amG9dQMLhcciSFHfYdyUEEp56WacpOhR8+bVSIesDqg0rO6cXQJILlCtNyqXPOIGRS15oeP+N5rcMB1s7ZSCKRmKU4CdwNBl0MbAB2lulHKVwBkenJ1REF3vmxh2BpJKTwuEY50nr8jKIQE0e9KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2J1Ltq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6CFC2BCAF;
	Mon, 13 Apr 2026 19:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776107435;
	bh=4Oe5L5ZzSwQEoeE5dC3O3OcveobiRZ+9ttZMhubSr3c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F2J1Ltq83rJ2Y48ZOODpVjZtMFjrlY0PRUcpEHl4XJ/+5CKX/sBmzLTb9jhLuKTET
	 8XOd6bWH62562zQh220FwaiOVKTnWSsYIhQdt7ODd9VtXZJcAszXQHjqDC/MH9yvMv
	 DBb2Q8z0rsb5YxckZOiNF1HnMHKh+4XbCo0JqoAo5cifoUMLZvLnQqF8qeWuju7k3P
	 8Ch/+tO6R5/Q74ct9CXV37Tmdqu+s24MC7VEmp74Gqj1F3szJjXxS6JthcDmRyfaew
	 mb444ICifI+rxCTpXdhMmZUBg5Myhie3kutuM490yhSrrjgAJQFVKPjm0uZV9cqCP1
	 Chsa59cPAZOQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E1F3809A0B;
	Mon, 13 Apr 2026 19:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute 1/2] json_writer: support control character
 escaping
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177610740680.501842.5837972274983153432.git-patchwork-notify@kernel.org>
Date: Mon, 13 Apr 2026 19:10:06 +0000
References: <20260410224745.93416-1-stephen@networkplumber.org>
In-Reply-To: <20260410224745.93416-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278183-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC1CC3F27D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Fri, 10 Apr 2026 15:47:44 -0700 you wrote:
> Iproute2 never handled control characters in strings correctly.
> There are some cases like where string is under user control
> like paths in ss command. Make iproute2 json output conform
> to RFC 8259.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> 
> [...]

Here is the summary with links:
  - [iproute,1/2] json_writer: support control character escaping
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=9e99260759b7
  - [iproute,2/2] json_writer: fix builtin test code
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=fe811be6564c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



