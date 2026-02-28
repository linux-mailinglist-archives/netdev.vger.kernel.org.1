Return-Path: <netdev+bounces-262194-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJ0zBkZJo2nW/AQAu9opvQ
	(envelope-from <netdev+bounces-262194-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:00:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 737DA1C7B7D
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD17A378A76D
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 19:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA86338F623;
	Sat, 28 Feb 2026 18:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFSp9hP6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E0F38D017;
	Sat, 28 Feb 2026 18:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772302202; cv=none; b=uou49hG6V1roBm2ZCpmx+bMY6w1ngzkJcvsKhN9UH5Q1Jcx1lmGBEWVDW31is51DbLQlYs9vSwo8m+bdAU0aK5tpC37T9ZCIqIs9VsUPt6yWW9j54/QfB19MsmGGo8JNDGSDckMuuTrXsLsN72mMHcIKKCCfdkl/uBhVXkgAffc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772302202; c=relaxed/simple;
	bh=xXY954PaTUGbY55G9SebxVmSOoNR8QEHYZV09MvUUZo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mWiT6/maNzp/IhrKwEptkkK5GZRFmgoQUzU00xalEWP/4erYjSbrA0ImQC+3CwO67TxPY36NRoq+1mDuwGLPYT+ZQqntfbL39gFTZNcEQGjE0czc0x6kICH5GpnDB1Qwu/Ysy134VUfR2e/JpEUOl+B2omRHrSKHY6g2WmFISuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFSp9hP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C49C19423;
	Sat, 28 Feb 2026 18:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772302202;
	bh=xXY954PaTUGbY55G9SebxVmSOoNR8QEHYZV09MvUUZo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bFSp9hP6ZD5UpzpPOJerBIVQcvhtt8moW+UolnSFA4S1eiQi+7DCdDOSRvaZ4cdyO
	 alOLkafhtpoBId7ED9AU8BxZTdLAKZc9V3s60IZHxh34l8SiVINb9c331xXwIVFU0Q
	 SUGYFlTRNCPN3aqXXMBsWeJGGGGCmaXPJ6VCyDFEVJdkkF/Lz4UrdDWbn0ig0SDXH7
	 RsCwoGWfKpxvPPm/tFVTbvkGZMczhzsgiu28+9yQiQ5NqVDh3xYZGB8gVCX0qKoS78
	 jXYtyCzxv7UYfHF6z7PhdnZSyGX649IeNEmLpq+c/mB2e0Uu1isZpGxZvToal0TJ5y
	 pbKWuu74Cu/7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E9E39F2022;
	Sat, 28 Feb 2026 18:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: sit: Replace deprecated strcpy with
 strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177230220580.3031657.12932155918490980438.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 18:10:05 +0000
References: <20260227004541.798966-3-thorsten.blum@linux.dev>
In-Reply-To: <20260227004541.798966-3-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-262194-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 737DA1C7B7D
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Feb 2026 01:45:42 +0100 you wrote:
> strcpy() has been deprecated [1] because it performs no bounds checking
> on the destination buffer, which can lead to buffer overflows. Replace
> it with the safer strscpy().  Use the two-argument version of strscpy()
> to copy 'parms->name' in ipip6_tunnel_locate().
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> [...]

Here is the summary with links:
  - [net-next] ipv6: sit: Replace deprecated strcpy with strscpy
    https://git.kernel.org/netdev/net-next/c/ded4a02e7d04

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



