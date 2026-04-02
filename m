Return-Path: <netdev+bounces-274605-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLN5L7yOzmkbogYAu9opvQ
	(envelope-from <netdev+bounces-274605-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:43:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B2C38B637
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5255D309C876
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 15:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A943E5593;
	Thu,  2 Apr 2026 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQBcqomQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1D53E867B
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144430; cv=none; b=PJhtBqN0IYHMx7DL08O578vV69AObdWUqVMc6H+fjd3ruXa3dxjnEz57e6UIfBnIAcE6cCBLkEBE/NxBpb6oI34PuIfrOUaKrOSnu56bOe4AZfelSLsn6kuj8mV5ckJ6HTKwFnqt5OkOicqr3ZO9mzQwMTa7DFGaScTF1tke40I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144430; c=relaxed/simple;
	bh=+7DKJlKO6IqaE5tnwQhTNT8c1muqZQQWBkddiEI2TQU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jUcg0ERUy7BCsK/VH8n8MVwtsVSPTCCr40plHvDGaRdoRmwaj1BbrTHcSNW4Pu/1z8KHlsODj9amIEvYAz+M6GxanHqPiNlhQnoebaJtautiDrHM9SSimXiZrmGx3EJbUlkwYGBRgxLb2cr/LMyjoGMX+O4lwlW6bKXZfo2G42c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQBcqomQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C0CC116C6;
	Thu,  2 Apr 2026 15:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775144429;
	bh=+7DKJlKO6IqaE5tnwQhTNT8c1muqZQQWBkddiEI2TQU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tQBcqomQKn/O+Sd0KscBRM/N4JqiYC1cXhn+10d46bCi6ajkvIeukjQtrAZCHEoJQ
	 Z9XJwrAjjaAisHOxkgF+8eF2xgOvFCR2XQa5Bx4P8NPKnPp5uc8Cv0AsIlzUEOum5Z
	 ZLG42aitHxs/bPt6x9EdLzLY767oW8kLRm1B7uEyBQueN5wlquKL+fYzbajA/B9ZDl
	 JOBYACUBgnxvLW0fv2Jwj38R24lSpKT2yyUdSCAbwga0NRwzydcg8kFp17EJyUSlKO
	 LOEd+WBfFB+lisdILYwJKbItjrtP7DK+zXfRnnAREkTfHeDiAx0lEuiL76dOc6Hlwq
	 PssEsdPkYNxsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE783809A05;
	Thu,  2 Apr 2026 15:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] eth: fbnic: Increase FBNIC_QUEUE_SIZE_MIN to 64
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177514441203.499423.7173464969097763576.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 15:40:12 +0000
References: <20260401162848.2335350-1-dimitri.daskalakis1@gmail.com>
In-Reply-To: <20260401162848.2335350-1-dimitri.daskalakis1@gmail.com>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: davem@davemloft.net, alexanderduyck@fb.com, kuba@kernel.org,
 kernel-team@meta.com, andrew+netdev@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, mohsin.bashr@gmail.com, horms@kernel.org,
 jacob.e.keller@intel.com, mike.marciniszyn@gmail.com, daskald@meta.com,
 bobbyeshleman@meta.com, netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274605-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,fb.com,kernel.org,meta.com,lunn.ch,google.com,redhat.com,gmail.com,intel.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10B2C38B637
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  1 Apr 2026 09:28:48 -0700 you wrote:
> From: Dimitri Daskalakis <daskald@meta.com>
> 
> On systems with 64K pages, RX queues will be wedged if users set the
> descriptor count to the current minimum (16). Fbnic fragments large
> pages into 4K chunks, and scales down the ring size accordingly. With
> 64K pages and 16 descriptors, the ring size mask is 0 and will never
> be filled.
> 
> [...]

Here is the summary with links:
  - [net] eth: fbnic: Increase FBNIC_QUEUE_SIZE_MIN to 64
    https://git.kernel.org/netdev/net/c/ec7067e66119

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



