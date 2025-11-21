Return-Path: <netdev+bounces-240619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 141B4C76FF4
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 03:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DDDD1352AF0
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 02:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A50A23BF83;
	Fri, 21 Nov 2025 02:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODy/qR+h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364B823AB8A
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 02:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763691648; cv=none; b=S7zTeXAQF0Nl0Er7g7TfObmbbJKU92DfDx4FQTIBx3hxp8dNcm+VZdpvkPNT8GVESpBdS04i1W0l+M5m8l935SiaIaPM1ddXSuvRAxs55FLaltqtmTXIinmE++oATVVnrR9HcFDlSU32IbykdYuTwHtdo2owab2KaGXzQtoluGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763691648; c=relaxed/simple;
	bh=MppdL4eAIoNsL6jClSvQoS8LRalb8jt9Woz5Be/kBSQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ojCDppOxXmsi4tSOLCToVps8fE5ShljSwJ9nZfjtlBPV7Tm+hwDGrEs+q/6cV95LEjuFcWVLCzsV+/JeR/UlJwGsBtXtt3JnNmCzHfvJbezugrtCRO3VrsU43fb43fq7S6SmPVzGC36RQlGDcz1tzToHf09H1olZpTdoe+XVKa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODy/qR+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3508C4CEF1;
	Fri, 21 Nov 2025 02:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763691647;
	bh=MppdL4eAIoNsL6jClSvQoS8LRalb8jt9Woz5Be/kBSQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ODy/qR+h40REpnTCmsXnpTrxdi+TbcFiHutlPC4sis+Jv3DGnE01Lpcn3yG6rGImf
	 q2QUbBe2bryQcaLUEO0CWjAJPKvgrjHGUeNKpKZOK9C1Ru3DkLueCx7ymMfLE1SSzV
	 AvfMITe3a9c/9TFV1UI8ndgQi4MxkYcv4UdSWQVumGdHK/FPzolgXetDQi86RbjLSL
	 osOJLNjarmtvvKCkscsyEOn8TEiqZLLHfY8AinredGYd4bHMbGmg/Dng/xwr7ph7m8
	 l6CQK5QMyuCW24uZc9odF9H2Ekz2elbsqdAkWbUTyn4YQA8jHpdoM0Ikcym+y6CjER
	 85KT+5pbm6k6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB44E3A41003;
	Fri, 21 Nov 2025 02:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] net: phy: adin1100: Fix powerdown mode setting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176369161249.1863338.9405406366227563464.git-patchwork-notify@kernel.org>
Date: Fri, 21 Nov 2025 02:20:12 +0000
References: <20251119124737.280939-1-ada@thorsis.com>
In-Reply-To: <20251119124737.280939-1-ada@thorsis.com>
To: Alexander Dahl <ada@thorsis.com>
Cc: netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Nov 2025 13:47:35 +0100 you wrote:
> Hei hei,
> 
> while building a new device around the ADIN1100 I noticed some errors in
> kernel log when calling `ifdown` on the ethernet device.  Series has a
> straight forward fix and an obvious follow-up code simplification.
> 
> Greets
> Alex
> 
> [...]

Here is the summary with links:
  - [1/2] net: phy: adin1100: Fix software power-down ready condition
    https://git.kernel.org/netdev/net-next/c/bccaf1fe08f2
  - [2/2] net: phy: adin1100: Simplify register value passing
    https://git.kernel.org/netdev/net-next/c/5894cab4e1b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



