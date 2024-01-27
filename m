Return-Path: <netdev+bounces-66408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A76983ED79
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 15:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D306F1C21699
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 14:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E704A25777;
	Sat, 27 Jan 2024 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjX4xJIW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB75249EB;
	Sat, 27 Jan 2024 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706365829; cv=none; b=VNPRrDgMgkEigQy+b4YxnIQ62W8rmYyiDa4WEBTA5B/fad4Ozv+PSm0Uzg/OZWuOhtaK/UldGCQD6qJsbykA+/qcI+VoHjaX2L74t5CMEasd+6suBT3P8RL3QNjknxUqOTAo06e7ok41xNRo+9TWVEKFXbAJauQU8fUSZtu4D2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706365829; c=relaxed/simple;
	bh=vhkO/341qSVUx1I9xpWC5or7XCVjQvvt6DSSus1M58I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a8l8jaKffR7l2QoS5kMkCbg/iTAPrDLlEsIwAUA1EqcmbUxfszlnEc7wBL/BfKdj9YTbJlSFtdn5Ktg8S6A5IXzbhvdUc+0wpgg4ONFjq1ozG+HGeo3PpItuhBeWqJHtlFK7TPH5VjBzL31HyLJIhRpk+DBS5BZH6mqlnL1gGSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjX4xJIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36E56C433C7;
	Sat, 27 Jan 2024 14:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706365829;
	bh=vhkO/341qSVUx1I9xpWC5or7XCVjQvvt6DSSus1M58I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XjX4xJIWuE6MgM1ZONGBgNMctqpkA8zgUIDIffp3Wf4FKQARe1HvOLU5KVUbEQVGH
	 3bwcqfCbKQU9LtKaXMS3M5ure25RqP5K9iqqMzP55kSkGxWWFixGj5uHVjPl2DprrR
	 kDV49TzpxwaukBYxTERbEOBiyYIEJ6P574EMqRMNLkTEfs225HtssKv4wGzv14qUp8
	 cxwxDUu1VnN9lUGe+Ss6y3TAvGvUw2Q9k2pCTsJevF+pLvVIxdEBtVEm5J5+5vRSMP
	 tdccu9L2v6KFuLKHtuVHr8bKZORBSJtywtZDrSf6bhS2j+36Zhh0CHDG4B2XsODTu3
	 GKL2pGb2SxP1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1E9E9D8C962;
	Sat, 27 Jan 2024 14:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] rust: phy: use VTABLE_DEFAULT_ERROR
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170636582912.20177.7242750022246827480.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jan 2024 14:30:29 +0000
References: <20240125014502.3527275-2-fujita.tomonori@gmail.com>
In-Reply-To: <20240125014502.3527275-2-fujita.tomonori@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 tmgross@umich.edu

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 25 Jan 2024 10:45:02 +0900 you wrote:
> Since 6.8-rc1, using VTABLE_DEFAULT_ERROR for optional functions
> (never called) in #[vtable] is the recommended way.
> 
> Note that no functional changes in this patch.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] rust: phy: use VTABLE_DEFAULT_ERROR
    https://git.kernel.org/netdev/net-next/c/599b75a3b753

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



