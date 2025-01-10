Return-Path: <netdev+bounces-156904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54329A0842C
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 01:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C41C7A38E5
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 00:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9010222094;
	Fri, 10 Jan 2025 00:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZHSOgJK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AFAEEB5
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 00:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736470208; cv=none; b=kGU1A7ii61vEd70BUH48xbVrrritFayRXqmHUBe0kjzYAJNlg02LxYetfbIRfqk6uoyTeJ1QYizlsesn41iwdOc2PnjHB2J0Q1I1ra6I89WQ0is2L+g4QEAErLYT6bOjaf4Vprq9A5Bbcl1YEeLAz79xEcWCirNgOqMEv9MvvB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736470208; c=relaxed/simple;
	bh=SNA9seLEQ7iOin+k7zmBUYddgG5up54FB/fk2mUjrSU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y9j5y+PejTpe+p/qevysWn9z1KtiLMZ8OhTrG5m6Rcq4abhJoI6R3UOV51ZksMVblHOrOSu+Vwvxnj1yN5OUSZSqChKukH5bPsm8u7UpwEX3SL6Ycj5dxBessphWWQhfur4kRJvhLxVMW31DbCVC6/YQYFt5RsQvh3AMp6j1z5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZHSOgJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB6BC4CED2;
	Fri, 10 Jan 2025 00:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736470207;
	bh=SNA9seLEQ7iOin+k7zmBUYddgG5up54FB/fk2mUjrSU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sZHSOgJKmA1UC1JmpyexMGeYdpEyVa96kt+aL8zPKuO/TrXe/Ey3xRpsSZZkMGjf2
	 Vcw26VVRJLVuW1X5XLtX/jR4mqqkX2Wnm9g+J82Lv4GZ90SkSScaUsSTTaK+vRRwyF
	 oN07ouHpoJ5D3l3ukqT8SEFurz45vsMaZbeurjU3WxJHYeFpmgVRGF8LEBrPOSvxvl
	 VNuJHaxJsmNOYomjIARPs8JhknH59VJw1p2N/aI8OwPZP3vdGIVvDrxReAqf7snxgc
	 zTHcedGvBf17fNK2Sqi0D0q/SdlxcdaNUSYou08PhDonXlg+fo5vK6tt+N0j6363PM
	 dp9PaRG5TVHDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB8A2380A97F;
	Fri, 10 Jan 2025 00:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] iproute2: Fix grammar in duplicate argument error message
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173647022978.1561795.2572479854904559208.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jan 2025 00:50:29 +0000
References: <20241228223346.369003-1-neil.svedberg@gmail.com>
In-Reply-To: <20241228223346.369003-1-neil.svedberg@gmail.com>
To: Neil Svedberg <neil.svedberg@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sat, 28 Dec 2024 17:33:46 -0500 you wrote:
> Change "is a garbage" to "is garbage". Because garbage is a collective
> noun, it does not need the indefinite article.
> 
> Signed-off-by: Neil Svedberg <neil.svedberg@gmail.com>
> ---
>  lib/utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - iproute2: Fix grammar in duplicate argument error message
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=c4e85023e7ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



