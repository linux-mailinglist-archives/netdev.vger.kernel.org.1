Return-Path: <netdev+bounces-266847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDNNNvkgsmnlIwAAu9opvQ
	(envelope-from <netdev+bounces-266847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:12:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FE126C1C7
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08221312043C
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EEC376BE1;
	Thu, 12 Mar 2026 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgjavjJl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2939377EC8
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773281432; cv=none; b=YVhsxS33Gdfav7Tx37kGH7GwjMeRC1qevaXFGQ79DZFlzs2dol7TkV+F2d8UuBa4A65lVH3nyLy64CsCt1AxnURJRBQrxYoOECY0xTjHajORm8Kg5dfWnaxuyfIM0skfXho/+WlTjKRFLCmPs6zAe+C9kORbji6d/LMIAPYdDrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773281432; c=relaxed/simple;
	bh=XnVHJMyGb+zd3+CmMtQEvRJ8v0laGAljxxG3javgTN0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n9ubbEHl0h8VGAuDnmhNrpnqCg1WOi9Y3PqvaEMyfk5PtxdfCrIO6Z20gZ3iGlLsvN/92HowulinZiE5MFG4He4oDazaARJeBIsCzWX2Gw8ZfK9vAtyq4Ue8H4mWU/QblwWfsGhZhIQG/vmMDHPAvkmOhQqa/rPRVF3KQInkQq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgjavjJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B460C4CEF7;
	Thu, 12 Mar 2026 02:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773281432;
	bh=XnVHJMyGb+zd3+CmMtQEvRJ8v0laGAljxxG3javgTN0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YgjavjJl4rbNpbwObQXsMn88P3KShMl9Zpyqfv/bGR7yCu4+jaoxp13rZ2z6BOQyP
	 cNTKN8C5623PA8tBULLKq3Zd7s7/AHFesB8qna0puGY5GIIb91Xqc87kmN8pzf5Fn5
	 vMSzifnEQSoPEHHzA+cKAdflDXAF1SkHZYlVDYZ2gmPCP9OoJo5Zq3usAOj3/nbgoV
	 J33943rNJs7KhuXlMZ4srp3xwmHNZyQpLVf96oXPYcb6fMzTE7hJd55qai7yh97vYx
	 Cr4vrqkQlX9VmbM2EnXZfvrnZqcynJ7X26hWeS8I4IxPoTpZajv0FgOHhgK4FrRYJu
	 dUrq7WbQXcX2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CECB3808200;
	Thu, 12 Mar 2026 02:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: macb: Clean up several member settings
 of macb_config instances
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177328142804.3905617.6498088817972486021.git-patchwork-notify@kernel.org>
Date: Thu, 12 Mar 2026 02:10:28 +0000
References: <20260310-macb-cleanup-v1-0-928c1a91a7dc@gmail.com>
In-Reply-To: <20260310-macb-cleanup-v1-0-928c1a91a7dc@gmail.com>
To: Kevin Hao <haokexin@gmail.com>
Cc: netdev@vger.kernel.org, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266847-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 57FE126C1C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Mar 2026 18:12:06 +0800 you wrote:
> Hi,
> 
> While debugging an issue in the macb driver, I noticed that many macb_config
> instances have very similar member settings. This makes it difficult to
> identify the actual differences between these instances. This patch series
> aims to clean up some of these settings and clarify the specific configurations
> of each macb_config instance. No functional changes are introduced.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: macb: Clean up the .clk_init setting in the macb_config instances
    https://git.kernel.org/netdev/net-next/c/f97977944d15
  - [net-next,2/3] net: macb: Clean up the .init settings in macb_config instances
    https://git.kernel.org/netdev/net-next/c/9179711ee2f7
  - [net-next,3/3] net: macb: Clean up the .usrio settings in macb_config instances
    https://git.kernel.org/netdev/net-next/c/0ae998c4efd6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



