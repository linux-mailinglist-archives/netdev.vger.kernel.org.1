Return-Path: <netdev+bounces-295013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MqCfCzncIGpZ8gAAu9opvQ
	(envelope-from <netdev+bounces-295013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:00:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A00B263C547
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:00:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=kernel.org header.s=k20260515 header.b=fvDcGijf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295013-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295013-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=reject ("signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C7E5301C107
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 02:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD0F2DA74A;
	Thu,  4 Jun 2026 02:00:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E146C2D592D;
	Thu,  4 Jun 2026 02:00:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538414; cv=none; b=ShnF/v0j/awPzO6sV+763YEw6cPVwtHqSUrgBL8qEu8vqTAT9uRxnxY3uZWN405T+cpQrgIiU1VqjtgA0VeS5mLQYLPqEs6O+X9lmxc80yPFRbWbcgmRMZ4e7crIzNBR64/TvaSjMBQk3NcCmqhPYFaS9ABIXXkHMelLcJS8dqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538414; c=relaxed/simple;
	bh=ku492X8HrgiH6POBq4RHlE7QJqQinWpaqZDQCUjAsDA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q/6l+MK8oX/eWD6APiwfEPq8VvfIDfbOYQWhvxq7jBWl2NI4X26jKtxTtq6o1gKMew1h8RXB8qPCr09niTZzn1xlMiuA9otVoNG94cLShO5j5dKXA0PozsVxzNiewG5S38UR8KH3AqICW11pkYy4SFLBkVm9wSM/BC0VnWr7ZXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvDcGijf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4021F00893;
	Thu,  4 Jun 2026 02:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780538412;
	bh=o/e2tp3o6XwqB0JqbpB/82qzqoSQQtVzH5kjHR6BS5I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fvDcGijfOJ5Lp9r9vBegLx/CZMNo5x8k37nixDtqZ3BB5FtgIjGc8M31hi9T2vV7d
	 lbH7TtfYAH70IgzpyzeQF7Uy6ZiS+lNBL1I8elB0qPshCWJbUJwYVpoNrDa9dPiH94
	 QMS1YXl65HaHAEXuXJpG/yOJlKwE2DSDMYsCjfn9KvMiGRuGI+Halb6DnPZpEGbzGZ
	 3OuOahjwFgfxjS13QcT//wnUVJ8vDa/GUfISxAwNL6HYMpEhsgv6v/77Qk8kosSwri
	 2V3x0aMLg8mLH4z1BRjuObFlMtU3ztnFiTwiIW6SOBNwUrFpRylFcsDfwgWnZ5Ll0X
	 EX5DpfTHHEVBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0ADF39308E0;
	Thu,  4 Jun 2026 02:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] af_unix: Fix inq_len update issue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178053841338.2201066.2461366002485490345.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 02:00:13 +0000
References: <20260601113640.231897-1-jianyu.li@mediatek.com>
In-Reply-To: <20260601113640.231897-1-jianyu.li@mediatek.com>
To: =?utf-8?b?Smlhbnl1IExpICjmnY7lgaXnkYApIDxqaWFueXUubGlAbWVkaWF0ZWsuY29tPg==?=@codeaurora.org
Cc: kuniyu@google.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, willemb@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, black-ch.chen@mediatek.com,
 ivan.tseng@mediatek.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20260515];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:-];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295013-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:=?utf-8?b?Smlhbnl1IExpICjmnY7lgaXnkYApIDxqaWFueXUubGlAbWVkaWF0ZWsuY29tPg==?=@codeaurora.org,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemb@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:black-ch.chen@mediatek.com,m:ivan.tseng@mediatek.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mediatek.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A00B263C547

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 1 Jun 2026 19:36:38 +0800 you wrote:
> From: Jianyu Li <jianyu.li@mediatek.com>
> 
> This series fix the problem that inq_len is inconsistent with
> actual remaining byte count when only part of a skb is consumed.
> 
> Changes:
>   v3:
>     - Patch 2: Align macro definitions
>   v2: https://lore.kernel.org/netdev/20260528110033.3327744-1-jianyu.li@mediatek.com/
>     - Patch 1: Improve lock usage in unix_stream_read_generic()
>     - Patch 2: Follow reverse xmas tree ordering in partial_read test case
>   v1: https://lore.kernel.org/netdev/20260527065342.2463433-1-jianyu.li@mediatek.com/
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] af_unix: Fix inq_len update problem in partial read
    https://git.kernel.org/netdev/net/c/c1f07a7f2d47
  - [net,v3,2/2] af_unix: Add test for SCM_INQ on partial read
    https://git.kernel.org/netdev/net/c/dd8975ad710e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



