Return-Path: <netdev+bounces-157358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07173A0A06A
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 03:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D94793AB517
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 02:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BF712C470;
	Sat, 11 Jan 2025 02:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9q/4GXp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CE1139D
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 02:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736563810; cv=none; b=ltfVfOMUrJ1ccmDRjzj5iZS9apt5mTl0+L+W5vrS+ZkHz1cI8TEqDfiu5jAzKj3rPEGqgUw9U5LdwMDjvGfBQgt1NR1pzmU0L7u9kKbyVeSyVwjPaZmtDgME+FlpHW9+wC1gsqLRDFoXueFwEFCyNsfaEBFHY/5kloDjtenA0w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736563810; c=relaxed/simple;
	bh=aRVh5kOOPO/H1WUCaOBG2PJwhv9Rh/Rpxiha/iYMLy8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rF4mo0Edt/+VCr50wrV21wf5cmwowwHnAHxYeEqyfUrRn6xgQmSaHPBzBgRwBgFeBJiTeii7yYiYEJyKxuEjVzSDVht2XP0YkJ1CmKb24CxOGTo87urKgNXMI3PbcRyLaLXq8EvCjXDYB8/4MF85cK8+Gkpu2nEsHChw2rp9vsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9q/4GXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EBAC4CED6;
	Sat, 11 Jan 2025 02:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736563809;
	bh=aRVh5kOOPO/H1WUCaOBG2PJwhv9Rh/Rpxiha/iYMLy8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g9q/4GXpqXhrA8DgD7iI3lxUMdx8ENHJvhXeqw+PI/GtB1DPp3W+4HnrP7usAuqmi
	 QhS0sjAraqeWbmhmI2vJU1Bcfbyj9A4QFcRvnfcBn1Of8nT69YDXJ7EN/iKZ92FBOi
	 0suxYg9mRQgx/IVfXCH0P3GTPXBoGFYriIkai/xUnBj1hUZyGZhxlfXvUpntm1irvM
	 zLm9e0byOPM9bR1jQrd30y+QK9AdG0I9FNIrJJIxf0avsrg/wd1RfFT6gVWBFinCCy
	 tKsxNpvLuEEdobCzQqsn0N849PUQ+rfRgEpXsPcaal4GwCL9Gkx6ptKZy4qUUubLjN
	 HlNjibZdq8u/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE86380AA57;
	Sat, 11 Jan 2025 02:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: warn during dump if NAPI list is not sorted
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173656383151.2274657.8449250733088909011.git-patchwork-notify@kernel.org>
Date: Sat, 11 Jan 2025 02:50:31 +0000
References: <20250110004505.3210140-1-kuba@kernel.org>
In-Reply-To: <20250110004505.3210140-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 jdamato@fastly.com, almasrymina@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Jan 2025 16:45:04 -0800 you wrote:
> Dump continuation depends on the NAPI list being sorted.
> Broken netlink dump continuation may be rare and hard to debug
> so add a warning if we notice the potential problem while walking
> the list.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: warn during dump if NAPI list is not sorted
    https://git.kernel.org/netdev/net-next/c/af3525d41001

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



