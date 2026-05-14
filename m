Return-Path: <netdev+bounces-287781-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qnVFB+IsBWrBTAIAu9opvQ
	(envelope-from <netdev+bounces-287781-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 04:01:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 942C953CE86
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 04:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 794253019E6D
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 02:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3921724BBEB;
	Thu, 14 May 2026 02:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0SO+KEp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E8D17736;
	Thu, 14 May 2026 02:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778724062; cv=none; b=VjFR94BZ4mY1jDUspjr9iMmcT9s8bTYEzWnGebjO+TvqSEnARPoONyZkX2W3dXMbU5BQl7Jb6DYZVPBha6knKmrW29fCfxf/0G0YURtp02Hpo3Boje7kWLpUc1hy1IHGCscT3ouHFPVuu6xpK7rieOrDk4wxXw4pWBf8HlvqcwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778724062; c=relaxed/simple;
	bh=JKdAI+bitHEPdgJrApAwtvVC5q9CMGqmjXD1fOFeQZI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XX6xY8DI9h9GTG2c7UNIjGxztpce4qFtlAfDQ64bGY3/X7Q+NlZuw2I5KsyuAyDIT8roWN0LeUfhIYP5TwJ+1Pf7myikHGZA1tVWNYXcl5FY9H9zB2D26A2VUEr7MNXvWn61fJ0u2xDE6lpbHMO76kNq7M4F6Wl5wEKdP4kXd/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0SO+KEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B3AC19425;
	Thu, 14 May 2026 02:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778724061;
	bh=JKdAI+bitHEPdgJrApAwtvVC5q9CMGqmjXD1fOFeQZI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q0SO+KEpOflkQRcggLZQ+43cNXIynjzM7bbRsh3PE/+k37ibAAVkkwXfjkodXhCOr
	 7G0PRLQYVhRC68IWiYPGd4TTxJRAeD0rncTEPghrLqBeGnSNNOEGivbxxq1NEuA7ed
	 RNpnmUdADMIJducK1TwUJffaQJigOL4J5ySWqt+vV0zc0NCYLMfwdocOBysIE4WFA0
	 qBJeWQ14hK1mz08RJaPBuLPqom2Lk+vAKg6MfEl8IimNlcfLNz/hUpzVAzltIoHmqI
	 6DCtHOWvfWjh+chppXFs2eWEAZItKFidoGWd3uiZCpDdzQH/8Nhb2N/2UW009KQC4f
	 yZvVqfrjgTA0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA061382330B;
	Thu, 14 May 2026 02:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: update atlantic driver maintainer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177872400629.3920037.7204020986534020620.git-patchwork-notify@kernel.org>
Date: Thu, 14 May 2026 02:00:06 +0000
References: <20260512125711.3142-1-sukhdeeps@marvell.com>
In-Reply-To: <20260512125711.3142-1-sukhdeeps@marvell.com>
To: Sukhdeep Soni [C] <sukhdeeps@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, epomozov@marvell.com, irusskikh@marvell.com
X-Rspamd-Queue-Id: 942C953CE86
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-287781-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 May 2026 18:27:11 +0530 you wrote:
> From: Sukhdeep Singh <sukhdeeps@marvell.com>
> 
> Igor Russkikh and Egor Pomozov have left Marvell.
> Take over maintenance of the atlantic driver and its PTP subsystem.
> 
> Signed-off-by: Sukhdeep Singh <sukhdeeps@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: update atlantic driver maintainer
    https://git.kernel.org/netdev/net/c/9a390d34d55c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



