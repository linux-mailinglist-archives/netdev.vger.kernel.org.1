Return-Path: <netdev+bounces-263569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kK6DODmgp2nTigAAu9opvQ
	(envelope-from <netdev+bounces-263569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 04:00:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 734361FA253
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 04:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97889303B910
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 03:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19A33542F8;
	Wed,  4 Mar 2026 03:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfDAxKRT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803E0355F28
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 03:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772593206; cv=none; b=gvlLA8s8RMXH3dAmQspZgW6kADByuagb5nBoeAw5NqA/4F8bIbg59PspTi5YfNp21RpDJn4nqbIkSFhwYvUmA2USzRhGm2bhPQPL7AXdQO2SXHEOaOglU6rpDjl7ksiQkQjRyDrRaZQcrxztnoy7ET5IsgKP51Ohf9yJuyDLHUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772593206; c=relaxed/simple;
	bh=Kr7KQAXVWvfHfTuvymud/n7QTbneMFDGz9+QGsaf2nk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SVuaNynyBBEdZJjSaQVbCCmwh1eVwZCwyMvFJ7pQZFHnJ2fAaO662gZhBgaTVC6T5TUMtOyqN4nI/ONNzo0FKP5wf3RKRGtbxx/pe+LyJDpJYyVl67ZesEXu8XDkjMiGGZE9zwCXw+gDphykxML/PSKMRk8CyEEqiNWZARKlnrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfDAxKRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0573AC116C6;
	Wed,  4 Mar 2026 03:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772593206;
	bh=Kr7KQAXVWvfHfTuvymud/n7QTbneMFDGz9+QGsaf2nk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jfDAxKRT7RekDVM628zjcJa6jLg5tCYf7Uc+FyOzQU6nbvP5JlMEwADlJPmfoqEJP
	 eqTavLGCT7wItISnGunvEAdNeSDXkKxjXI4k34loWSbhIPScTTT+ibN/o1d24VkTEw
	 zYLHqWf1JwRTxo+bhH8YnLf8UBzFI4/OtUHhS04HpmlyKWqPt45CxJ29gBBKtC/B+K
	 dTaQjzA8QfUGFLGlj7LhbkEvf6yPI4awEyX4Xf1hVV12MIH7Xc0/bC9uO6ugeg72DM
	 sOK0b3Zrs/D7rki577lRbIrCgZ19z+P8SFtF09Na0EbmY7PDmYjNSvVafw49QMlY6B
	 vpEwCiE6OzewQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CE93808200;
	Wed,  4 Mar 2026 03:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: update the skge/sky2 maintainers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177259320680.1572572.16673367244930384714.git-patchwork-notify@kernel.org>
Date: Wed, 04 Mar 2026 03:00:06 +0000
References: <20260302195120.187183-1-stephen@networkplumber.org>
In-Reply-To: <20260302195120.187183-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
X-Rspamd-Queue-Id: 734361FA253
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263569-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,networkplumber.org:email]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Mar 2026 11:50:20 -0800 you wrote:
> Mark the skge and sky2 drivers as orphan.
> I no longer have any Marvell/SysKonnect boards to test with and
> mail to Mirko Lindner bounced because Marvell sold off that divsion.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  MAINTAINERS | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Here is the summary with links:
  - [net] MAINTAINERS: update the skge/sky2 maintainers
    https://git.kernel.org/netdev/net/c/7f5d8e63f3d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



