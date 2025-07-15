Return-Path: <netdev+bounces-206929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F1BB04CF4
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 02:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2507D1AA21E4
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB6D19CCF5;
	Tue, 15 Jul 2025 00:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VL9Ymahc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4DC192D8A
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 00:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752539386; cv=none; b=cMstouV2tOytq+QMIUg+kSmas3o/SfGVZs0MhD6AZc+5CvvSPU8CBTjUaYjb+JndlfUL9D9nlINPlAeO0O8Qcuw+ucHhlPUKTtm199CxOY1kGsLWPDjYavhN38dXiln5qSaMTebAQVCrjl+F6A9xwtqLRJVk0I0MlrUBwzApXuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752539386; c=relaxed/simple;
	bh=YKE3xkZspAlRjTrL/xqCFGxLvIRtDHpI3mPD6ROxEbo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VzW/vzm3yt0+3c7pVSf2/VDJcrn8ZlwQsvBqzuGKiGeGTKPROA9QBh0kJyKDb9VuB1OhEUYrlnAhSPNdpTtTHdOGGGKl5hkru3kEF+ejHtcyU2880EAA9+JbfBXnON+yDtYLYtxfp0tR03NILbhgR4J9oSc6/IcCrTMV5UhzyEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VL9Ymahc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23B8C4CEED;
	Tue, 15 Jul 2025 00:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752539385;
	bh=YKE3xkZspAlRjTrL/xqCFGxLvIRtDHpI3mPD6ROxEbo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VL9Ymahc6quXkubQIs+I09mHHxvowSSuikNAzSzY/zXOYTGI73AOxZQdPhh4hwWTV
	 KKbFay7RqeaR+lebejmuvBVRKlbUtmgfB7v7S0L0+VXZ+ZZGipBdJO5BEbKDynF14o
	 NuRPkU9x5zjQz9tlz7l4FPeDEU+xr5quaSqX9SvA6azxkJvBh1kQMD8IJCeqp2pDPn
	 5J9j+GqmP3WBTGT8XEjiV+CzK7JzSNh5JZPz/hIPL+Vi+VAm+HGr2BWonxvl1YAq0h
	 K173mnKUFt1P1BihmaE/s2hENHoHuW+b369IeTBeGSrSj/BIkOtS2ZU/JilJgABw5W
	 Jt2C4JK5j3fZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD3F383B276;
	Tue, 15 Jul 2025 00:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests/tc-testing: Create test cases for adding
 qdiscs
 to invalid qdisc parents
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175253940659.4037397.15273616232830002589.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 00:30:06 +0000
References: <20250712145035.705156-1-victor@mojatatu.com>
In-Reply-To: <20250712145035.705156-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 pctammela@mojatatu.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 12 Jul 2025 11:50:35 -0300 you wrote:
> As described in a previous commit [1], Lion's patch [2] revealed an ancient
> bug in the qdisc API. Whenever a user tries to add a qdisc to an
> invalid parent (not a class, root, or ingress qdisc), the qdisc API will
> detect this after qdisc_create is called. Some qdiscs (like fq_codel, pie,
> and sfq) call functions (on their init callback) which assume the parent is
> valid, so qdisc_create itself may have caused a NULL pointer dereference in
> such cases.
> 
> [...]

Here is the summary with links:
  - [net] selftests/tc-testing: Create test cases for adding qdiscs to invalid qdisc parents
    https://git.kernel.org/netdev/net/c/e18f348632ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



