Return-Path: <netdev+bounces-143929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBABB9C4BF8
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 02:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC3E283DE3
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 01:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354E0204F64;
	Tue, 12 Nov 2024 01:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NghH6Mo5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1175F204921
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 01:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731375623; cv=none; b=mYPZEV23b9+yZn0PlA6FRH+CzTPSmaABxL+7kRaS7tc5N1DIvWqDrMJrj37fcMJPhGntod/Mz0uq/pv2SkKGtKCtqZSaOtyFj8QHCnRkVZ3v9kY3r3mWF1k3oz0fP4qNwOhpGptMK9iOgVA3wwJRp3oYqVR6+Y+qVSSkKoeRMyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731375623; c=relaxed/simple;
	bh=linjLXSBHfpGAG4Bnz3DuLpeEbydOuBHLgfPQ8uW4qo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gJ86X7PhapgfevFrSg2yOgqKae2jF7jWEuFE3PvL1y3rIjnrvbUCSSpwG7IqCHjX4fx21a/nZUTtC4i9+RU0K4mFkPzuR4xMHUjVOEyP3HtSiDLbNkRKm022iYZJObRpBPG3CHxkv066PYJNrt/wMuNpb1qVo8ISrFITJcjUsHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NghH6Mo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA03EC4CED5;
	Tue, 12 Nov 2024 01:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731375622;
	bh=linjLXSBHfpGAG4Bnz3DuLpeEbydOuBHLgfPQ8uW4qo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NghH6Mo5jU6XaHw4W3+fdeu6jm9y1HtAUBmgL+plbrlKqoi+hJbY8ec8v09itT2Vf
	 l4xByfpLdvSMOd/gTK374eJg/INyLvKwIPGFWbgCkBqzfXnt6Ze+4qrWmMGAUptnVD
	 RRXcMIP2rXLbmTnII/mx575kTW0OlXKBDm19soMp1r4PJ+fBujdyzUDtz0nbBNN3Xv
	 xHqcIl8Io63S1BdUq06Knxjlp9KrqZ84nqqFi6XMz82fw36nAMwPaSZ7+dUhBXvCpP
	 cXWqP8jkEydIB8WU8SM5EiSXPTPpfVGqxftIaC72n1+1MyZBV+7I/oA8937Ltb3CAC
	 txb+hHYYO6FLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AAF3809A80;
	Tue, 12 Nov 2024 01:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] bnxt_en: add unlocked version of bnxt_refclk_read
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173137563274.43860.8599488490188476265.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 01:40:32 +0000
References: <20241107214917.2980976-1-vadfed@meta.com>
In-Reply-To: <20241107214917.2980976-1-vadfed@meta.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: vadim.fedorenko@linux.dev, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 pabeni@redhat.com, davem@davemloft.net, netdev@vger.kernel.org,
 richardcochran@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 7 Nov 2024 13:49:17 -0800 you wrote:
> Serialization of PHC read with FW reset mechanism uses ptp_lock which
> also protects timecounter updates. This means we cannot grab it when
> called from bnxt_cc_read(). Let's move locking into different function.
> 
> Fixes: 6c0828d00f07 ("bnxt_en: replace PTP spinlock with seqlock")
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] bnxt_en: add unlocked version of bnxt_refclk_read
    https://git.kernel.org/netdev/net-next/c/f0fe51a04386

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



