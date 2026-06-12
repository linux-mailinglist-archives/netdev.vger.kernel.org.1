Return-Path: <netdev+bounces-298815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /WUjDj2ULGrpTAQAu9opvQ
	(envelope-from <netdev+bounces-298815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:20:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 985F067D08F
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:20:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PfRXj8pr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298815-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298815-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3825316B4F0
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 23:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B103D669D;
	Fri, 12 Jun 2026 23:20:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA0C3D5C07
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 23:20:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781306416; cv=none; b=NBNeuA3RdADLKNeLFNU2o3Cm4aJCukQYo9peQSbsA7O8HXMkYsykKnaqYVA5Rcl8XcMR3qky7nNpQ0ar7upJw0DckHXx81sLLjAxhvP5k0yeiUuOynlzm4z3pbyX5ZoE0G7hV2DpIAAwLOMNNJUeoPcnsL85uJ1wyRnFXrIrktU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781306416; c=relaxed/simple;
	bh=YxtU4XUJSJFtaw3P4YaUyCGmk9ESMJGW7VFNKLUi6bo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U+BMLQmP7DLqLaOXdxQcGjoVKPjaemRUKuSSX+RBMlbApGS3pS/xnAWSRHrXc2OIa9D7ykBVvwOvCM4P7xcLZZWNWYNqzafzX61b5BCswFGrwn5LvEvQMbVY+g/RmE+xw41dK3k/p5gGhaGATaoRENJ7+ctQqEzLGl54LtHB2oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfRXj8pr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56CB1F000E9;
	Fri, 12 Jun 2026 23:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781306415;
	bh=f2E4ZVZmxgGjJe6bLJagnl4w+BbGvc2KZMMid0U2qxc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PfRXj8prUxSvzr3CTOAKlmjMonB6UdfaYoO1iHp0/zh5iVuuQaDkml94chJgM6oSf
	 hG8/30taXbHQ6bu0yRXFBO/yDORxykjgvcRt4Tj4DZA/rILyTmNzbXF1vjhINXOkFF
	 U5Ncwsxh3gS+ZFOIg27BDpt5BYCG3JLEukA4hHuN+TIEQeYYHj49/7e60EBJ//V9Iw
	 nQOfRHtTUDfCl0Y2+KudnQNrqWItD3JNvZRSyVEAr2c4JXVoofDRzHRJFrbw5gyka7
	 4IykxEBocJF5rPRQtn+roS96dpPLGt+1Fv9ZDActzxA8VOz8OcmvrXQIjiUe8pPdDk
	 nJw1dk3Nd+CUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9391C39E9601;
	Fri, 12 Jun 2026 23:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ethernet: sis900: correct CONFIG_VLAN_8021Q macro
 name
 in comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178130641213.1287691.13481787190165825914.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jun 2026 23:20:12 +0000
References: <20260609175656.20574-1-enelsonmoore@gmail.com>
In-Reply-To: <20260609175656.20574-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, venza@brownhat.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298815-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:enelsonmoore@gmail.com,m:netdev@vger.kernel.org,m:venza@brownhat.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 985F067D08F

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jun 2026 10:56:55 -0700 you wrote:
> A comment in drivers/net/ethernet/sis/sis900.h incorrectly refers to
> CONFIG_VLAN_802_1Q instead of CONFIG_VLAN_8021Q. Correct it.
> 
> Discovered while searching for CONFIG_* symbols referenced in code but
> not defined in any Kconfig file.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> 
> [...]

Here is the summary with links:
  - net: ethernet: sis900: correct CONFIG_VLAN_8021Q macro name in comment
    https://git.kernel.org/netdev/net-next/c/0182b218a074

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



