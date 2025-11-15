Return-Path: <netdev+bounces-238826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54787C5FE0A
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 03:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 145233BF479
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 02:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5722821322F;
	Sat, 15 Nov 2025 02:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxR6FA/p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE562116E9;
	Sat, 15 Nov 2025 02:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763173244; cv=none; b=a3fN50kxWXH4TLDAB1tIQlu1RaZAHhkBsHUFtGtDzDyN8shS8/pfqvAxJGrpW5jIyDsgUJE5Qazif/R0Txe81cAKlOezKLDxhhmnX3u7iTZqkNixXBCPGg5W4kDTTXpDMYyEm7WWYpaV9RnGYVwcAFXTpb+AH9HHSqV48OLVElM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763173244; c=relaxed/simple;
	bh=TdCm5SkmgJhEmSSiOly4C4zq1lolVSxZE7dert6xcXU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DhAoriskavFlpVpBW3VCARynsABTmYfFc7GU8PmsUNIEd+vuA/qj4Sai7jO/gaRbk21pSw9J8RqHMUo1G5RR+VxoEYYkeUKuXeLjPeOnwezSOLRmi1ZirHxVMUwBs1TBJYvb/MhaZxmgOT+4eHlba55eFHpMtZWeDJyx5D/yKgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxR6FA/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE5CC16AAE;
	Sat, 15 Nov 2025 02:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763173243;
	bh=TdCm5SkmgJhEmSSiOly4C4zq1lolVSxZE7dert6xcXU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hxR6FA/pVAjbK37JcHz9iy3auyKjYD3K4nmS1ztWfEw8hGzSJTpEg84fD4yob1OUt
	 idSlKAyTd6r3qjKoDt4QYuTBGZzt2hTNOzeIMdaM/CMy3V4Wb0WBMLU+dBmeauQ90T
	 6WIdCavzL93MGLwAWkTjYK6yVvxFmoDM2/xryRd/g/PsqdhguF5r/DoOOCfJpeopSc
	 +pq9Ze0zOrMtjbgLJGo4zK2cMzuq+WDAgWdQf+rI4xCldABx6+A4FiuQHdz46iT1ff
	 Nq6azPvSGnXz+hwE8nAPFbrebyOluSONMEmHsnMyBori2VQC0UMR+x4BWPM230M1MB
	 4J2PO/WXmZBLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7115C3A78A62;
	Sat, 15 Nov 2025 02:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: openvswitch: remove never-working support for
 setting nsh fields
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176317321200.1911668.558293719970758983.git-patchwork-notify@kernel.org>
Date: Sat, 15 Nov 2025 02:20:12 +0000
References: <20251112112246.95064-1-i.maximets@ovn.org>
In-Reply-To: <20251112112246.95064-1-i.maximets@ovn.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, dev@openvswitch.org, echaudro@redhat.com,
 aconole@redhat.com, w@1wt.eu, kwqcheii@proton.me, zhuque@tencent.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Nov 2025 12:14:03 +0100 you wrote:
> The validation of the set(nsh(...)) action is completely wrong.
> It runs through the nsh_key_put_from_nlattr() function that is the
> same function that validates NSH keys for the flow match and the
> push_nsh() action.  However, the set(nsh(...)) has a very different
> memory layout.  Nested attributes in there are doubled in size in
> case of the masked set().  That makes proper validation impossible.
> 
> [...]

Here is the summary with links:
  - [net] net: openvswitch: remove never-working support for setting nsh fields
    https://git.kernel.org/netdev/net/c/dfe28c4167a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



