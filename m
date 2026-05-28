Return-Path: <netdev+bounces-292862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCzkIrm9GGoumwgAu9opvQ
	(envelope-from <netdev+bounces-292862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 00:12:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A895FAD24
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 00:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D03FB301E6F4
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 22:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E813367F54;
	Thu, 28 May 2026 22:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQZAvfB7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E076F368D47;
	Thu, 28 May 2026 22:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780006252; cv=none; b=aamnOPEROxrHqRJ7ROzt3xYtMiiFZPKC0nI7t68vD9YhwfMEQzlTVmlqgwOejZNVKlfbDaRevOHPpvpZx9VkHJCE6aFd/1vg5vjWnzS2wWUtoLkL5Eq1qGSQmzLRMsupK/geHXgBt7FMVAQVxFm3Ydu6XqrhmudwbpikqyH/JP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780006252; c=relaxed/simple;
	bh=X0CrO1Gzd3r43NK77s+f8/OaNKVowxvOD5sdslC4KEU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C8lWS/Mr9J5qAsq8arKLSA8W1k8XhLQyFRERZU4F3rCj3BPGbaLdFguYNP6e1fyEEcwBtTTtHkAskEvEnzychgtim3l50lV/y8+DoXBTb4dDvIfqDdwy9QLC7cyUhQyjSyKlnt2Ea4TIN2hNdYeBcpZk4Ct6SyWDAwcG0+712ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQZAvfB7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FE51F000E9;
	Thu, 28 May 2026 22:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780006250;
	bh=pV0TpeA+2/nAviN01+yWNZEiQyAe1hx/m48sZh/qlMI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FQZAvfB7nxAKHHNQ2lEvqB1lffUdXN8aHibGOat9gXwczL9EPrqto69hk/oyq4ssC
	 68bfu+GSag7N6y6itMQ7u06ds6COEioRmv6Hi5FRRpIKIYPuhbx4yL+fBVupQE7lu2
	 YrIvOx90gNRhRgk1zhkfOR8VvT8hvwickcNoHVKDZZmiac8O9lmZSQNrQQOwMCmTkt
	 Obz2+Cfk43h2ErS0juGYaiW2YEhv/zrkemzhDRJiW1uYbKUoqNUV5sL0so5Zq4JcL6
	 NLy7b+kD69p51zYxCk/WI2EexBVNBBgqGplmMD/bWb/DmanVEtkfphmQ8669UwuCfx
	 dYeBqaU802JKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A1D3811977;
	Thu, 28 May 2026 22:10:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/10] docs: net: updates for old and cobwebbed
 docs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178000625413.1533055.15504682871572783370.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 22:10:54 +0000
References: <20260526160151.2793354-1-kuba@kernel.org>
In-Reply-To: <20260526160151.2793354-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 vladimir.oltean@nxp.com, willemb@google.com, sdf.kernel@gmail.com,
 ecree.xilinx@gmail.com, jesse.brandeburg@intel.com, linux-doc@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292862-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,nxp.com,gmail.com,intel.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 90A895FAD24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 May 2026 09:01:41 -0700 you wrote:
> I'm hoping to start feeding our docs into the AI review tools, instead
> of maintaining a separate repo with review prompts. To experiment with
> that we have to refresh the docs a little bit.
> 
> A read thru our current docs makes one slightly question the value
> of including them in reviews. But directionally, I feel, it's probably
> still right. I'm hoping the Rx Checksum section about not dropping packets
> for example to be impactful. I don't think the current AI agents or
> review docs include this guidance.
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] docs: net: netdevices: small fixes and clarifications
    https://git.kernel.org/netdev/net-next/c/ea50122e4520
  - [net-next,02/10] docs: net: fix minor issues with driver guide
    https://git.kernel.org/netdev/net-next/c/c801a207794e
  - [net-next,03/10] docs: net: statistics: fix kernel-internal stats list
    https://git.kernel.org/netdev/net-next/c/73ac86c5845d
  - [net-next,04/10] docs: net: update devmem code examples
    https://git.kernel.org/netdev/net-next/c/427837e5fd85
  - [net-next,05/10] docs: net: fix minor issues with the NAPI guide
    https://git.kernel.org/netdev/net-next/c/33cd2d395cb4
  - [net-next,06/10] docs: net: refresh netdev feature guidance
    https://git.kernel.org/netdev/net-next/c/f7d7d7e2a53c
  - [net-next,07/10] docs: net: fix minor issues with checksum offloads
    https://git.kernel.org/netdev/net-next/c/f94874c38886
  - [net-next,08/10] docs: net: add Rx notes to the checksum guide
    https://git.kernel.org/netdev/net-next/c/6686e7f03f42
  - [net-next,09/10] docs: net: render the checksum comment in checksum-offloads.rst
    https://git.kernel.org/netdev/net-next/c/25bfb3a8edcb
  - [net-next,10/10] docs: net: fix minor issues with segmentation offloads
    https://git.kernel.org/netdev/net-next/c/1255733f2f32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



