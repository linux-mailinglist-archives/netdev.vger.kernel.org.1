Return-Path: <netdev+bounces-156668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63228A0752D
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 13:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2063B188AE4E
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 12:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B5B217640;
	Thu,  9 Jan 2025 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8uBNtS7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1385216E28
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736424010; cv=none; b=arO50ahojom/W9IwHlGV1iniqrA5u6dojs3V2ClTmnmiDJh58asSEViNoWc082V78gR0aDOgChp9HiI9k+7XrjjWY2tup2XmLJDeQA9/BP/zf2YTstRGBPXYLd4fSyH0tXRxePCyzp1QD1m3YJ6hYOMK/F/XJHQHH7W0uhll+ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736424010; c=relaxed/simple;
	bh=xdHW0k6xjV2duvCRSvx86599wWJ2Tzl/t9H6CUTKX08=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HiTh1AXGCGFofqu9j7xoMXv3fsUdzVTVDYEN8oZKRcXfr1ZvTxFlaq/89IRXVzx59ozI8mFmqXNmTOw+Tpj2nGaz16vVMvuuEdyBD9TbGMlm4YWuHLTlUPbFIZ8xPFscPjKDIh0RNfDj8DZVe0LKMQ82CE+CHL25TN4qmUQ80Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8uBNtS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A62C4CED2;
	Thu,  9 Jan 2025 12:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736424010;
	bh=xdHW0k6xjV2duvCRSvx86599wWJ2Tzl/t9H6CUTKX08=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d8uBNtS7QXEyq6gTnmQ45ly6J4nG4cdH3MuXuO9w954cErvRljE0QtoaM3NfI6Sba
	 TxzP4osJivPdvQLatBGjYX8iM0HzujwWKvdvIPtfVPLXXh5IIo0Zg9MyTVm0soI+S+
	 o/phrp3ahybLWVv3reuUoPoppaF27qqPI79LZM+Kyzw/reQiPfRFEtSv+pYUGAs4vP
	 hci1zBmTrsKmEnj2ReMoKdk3Ls1xudZmGA1KncaQ2jGloYBk3I8KPir2JJD8ApAPNf
	 N20PK6uOC4HB9Cn5LZx+p9sJNTRA7sRldHvUaFTR9veNwLBScoAqsOVVhotwX3ypBX
	 GrZlZ6FnVcChA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB4843805DB2;
	Thu,  9 Jan 2025 12:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next,
 v3] netlink: add IPv6 anycast join/leave notifications
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173642403152.1297948.16448203699089192226.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 12:00:31 +0000
References: <20250107114355.1766086-1-yuyanghuang@google.com>
In-Reply-To: <20250107114355.1766086-1-yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org,
 jimictw@google.com, prohr@google.com, liuhangbin@gmail.com,
 nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org,
 maze@google.com, lorenzo@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  7 Jan 2025 20:43:55 +0900 you wrote:
> This change introduces a mechanism for notifying userspace
> applications about changes to IPv6 anycast addresses via netlink. It
> includes:
> 
> * Addition and deletion of IPv6 anycast addresses are reported using
>   RTM_NEWANYCAST and RTM_DELANYCAST.
> * A new netlink group (RTNLGRP_IPV6_ACADDR) for subscribing to these
>   notifications.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] netlink: add IPv6 anycast join/leave notifications
    https://git.kernel.org/netdev/net-next/c/33d97a07b3ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



