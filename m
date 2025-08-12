Return-Path: <netdev+bounces-212737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF31AB21B89
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 05:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD3797AA396
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 03:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBB32BEC2D;
	Tue, 12 Aug 2025 03:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjHgDzfH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05720335C7;
	Tue, 12 Aug 2025 03:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754968799; cv=none; b=S6aVbyhLtse57YeNmMDOrl1zSPWBJe20sQmD/tvh6gK5LplQnIUWnGfrFAM8j2kYshavFfyZsPRn7T+wND56SrUfHjh2+pB0H8GrMa/SV1xvn/YpCtrNjWr+VcsmMIXlZWhrpia1wmBmgy3WZm5iu8bOmFvkmxIveklfiwF7NS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754968799; c=relaxed/simple;
	bh=9XeyibphrUPbjRvvhkRYfsqQBB29W+NMaK2NU2KNypw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eogcgiuEUwhVNWR5HduXNURVFFCtuNgbXk5nogHijbkseYcgWno4NyWt7vAmmHvv/talQj8JFs3Z7qTgfDz7zB7eLG0rBTAdyZSZMg6j9ZRyMDC4qrl0O3jdau1syOaZxyk0Ita84zOzL4POUGet6fKrVVj/PHcc+HRwIvFqR4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjHgDzfH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEECC4CEED;
	Tue, 12 Aug 2025 03:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754968798;
	bh=9XeyibphrUPbjRvvhkRYfsqQBB29W+NMaK2NU2KNypw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XjHgDzfH+9+vbz8Bn2lPg5ixSC6PZMVEH7cpOuliVCDXrEChMFqZl2tzbfXwVHSxT
	 JwIshgH46OyOeC5nyVWkxoy3PEWONAebxUiSX/80Lu7UOvVuc2+M3Rgzaqu+IJtHUg
	 ZCNwwpSvGTCyjD7yQ936YLtth50niYxeDmLrPFU7dVQpbMWardh0OZtBT+vX7ytoKa
	 EKTLXRUK8Wskf1e/QdyhnD06JlR7n0leHfstRW1nPksWVaxa5Pbr7ivf3tqcczmVMF
	 io52bmimROmGtxGJt5caQG2RtMqqAlDqsOlvo4EJzFDtdsDQDsaGG7vWzTGte+BsfR
	 2RdAJX8IfYiLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC8E383BF51;
	Tue, 12 Aug 2025 03:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: Remove bouncing T7XX reviewer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175496881075.1990527.11700425109486498678.git-patchwork-notify@kernel.org>
Date: Tue, 12 Aug 2025 03:20:10 +0000
References: <20250808173925.FECE3782@davehans-spike.ostc.intel.com>
In-Reply-To: <20250808173925.FECE3782@davehans-spike.ostc.intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, chandrashekar.devegowda@intel.com,
 haijun.liu@mediatek.com, netdev@vger.kernel.org,
 ricardo.martinez@linux.intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 08 Aug 2025 10:39:25 -0700 you wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> This reviewer's email no longer works. Remove it from MAINTAINERS.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> Cc: Liu Haijun <haijun.liu@mediatek.com>
> Cc: Ricardo Martinez <ricardo.martinez@linux.intel.com>
> Cc: netdev@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: Remove bouncing T7XX reviewer
    https://git.kernel.org/netdev/net/c/b132a3b0c228

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



