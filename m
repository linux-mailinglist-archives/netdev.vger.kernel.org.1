Return-Path: <netdev+bounces-286350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOa9CH2+AGoCMQEAu9opvQ
	(envelope-from <netdev+bounces-286350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:21:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2F65055F2
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26CB73009140
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8048A3B27DB;
	Sun, 10 May 2026 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJoGD5+9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8FD318EDF;
	Sun, 10 May 2026 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778433658; cv=none; b=ASgoOelYa5JbkgJzra27hyXrmfrTjoiOYRYsY5tCNx7LIk/mAVjNh0AZWdizHVVSMze7EI4mF/oVu7+uuWD+csePmeapeRxkBvvgEm/ddrOacJPorkFiWjYtc4AE2yQton4DBwy0PYNkgw99nquFP49TUOWQQRN/+t1qMX9gOSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778433658; c=relaxed/simple;
	bh=owpLj3Ze02xoWmEbBjiGZptpDr/0r5IMgHN9f92DuiI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YdEvywS1+/t37J5cR6WsrdAN5d0YtDXdXByuHQqRwUdAv2T0OggyOVgP2Z5jh3GkgX+w7DSXc7ILL8FtY8JCgIFyJT1bL3NaCdKtL7SJ6oyOV31titr8PPWByTWg0jNl3zKbGXLmNDxoS1hmfzPCeyG57o0Rx5yselUm3rTvpTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJoGD5+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA011C2BCB8;
	Sun, 10 May 2026 17:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778433658;
	bh=owpLj3Ze02xoWmEbBjiGZptpDr/0r5IMgHN9f92DuiI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AJoGD5+9IA0cnhGHcBhw5QCnRSGGm6OqtHZv44m30aG6l/DFtu8Uf+VzbXAbtPlvw
	 x/JFgaeSBOcFrB4aMjJoxROIndlWVLwse2p2ByB4JKDcWH0LMucbGh1VP8Qgq8v4Vk
	 dU99PQ1Emj78Q4v5MUTWrR2455cLPIGJ8mM+go88Pzfajgd8A2XoJZk91kPiMts2hT
	 Q8bSDGImNC7zUKFnBxUti6RlBgEeNnhtyMBVKWousibQU1IzBMmaJbSZ01CDjIOyKp
	 jhA3IwzVcvMC2LUl2sE99KX0KdU/z2XV0avduwGP057UCp8v3LVOPl7/VZDOSAj3og
	 LECoyZbWAWtwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD783930020;
	Sun, 10 May 2026 17:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: xgene: fix mdio_np leak in
 xgene_mdiobus_register()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177843360530.1437390.1044977418463848579.git-patchwork-notify@kernel.org>
Date: Sun, 10 May 2026 17:20:05 +0000
References: <20260507142024.811543-1-shitalkumar.gandhi@cambiumnetworks.com>
In-Reply-To: <20260507142024.811543-1-shitalkumar.gandhi@cambiumnetworks.com>
To: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
 quan@os.amperecomputing.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 shitalkumar.gandhi@cambiumnetworks.com
X-Rspamd-Queue-Id: 7E2F65055F2
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
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-286350-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cambiumnetworks.com:email]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 May 2026 19:50:24 +0530 you wrote:
> The for_each_child_of_node() loop captures mdio_np via break,
> holding the refcount. of_mdiobus_register() does not consume the
> reference, so it leaks on success.
> 
> Put it after registration.
> 
> Fixes: e6ad767305eb ("drivers: net: Add APM X-Gene SoC ethernet driver support.")
> Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
> 
> [...]

Here is the summary with links:
  - [net] net: xgene: fix mdio_np leak in xgene_mdiobus_register()
    https://git.kernel.org/netdev/net/c/a450063ef86b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



