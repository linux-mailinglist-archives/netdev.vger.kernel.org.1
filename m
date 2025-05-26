Return-Path: <netdev+bounces-193469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB87AC4284
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 17:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85F237ADBCA
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 15:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6278215793;
	Mon, 26 May 2025 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/kkXh6P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD0021578D
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748274002; cv=none; b=T39+q6s7gVuZWtoJOr/IyCLFmfpgVCXfEzp2FaMwIOVEND2M5qkuM/E63xUJMM+RNp+GJIcVvbeq9xLGobdBg7nSHZY2ynSiUkvvk4pCHOeZTavwBwP8HBrSKxxLs/to/oIWF/s9ueeiKMkvdya/eAkNdCPSy/P/pQm0UaGsmYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748274002; c=relaxed/simple;
	bh=LkCB1cxpnlw0YjZLmRg+PL+0hf4e/c14ioxMmsZ/hX4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lQtcn84Td0OelJoyO3LSudlxe9+Ur2fIgNZoB5/9jTh42zC1ld5gK3XdyXaAZtMWMLQlv6egBB9iECkhwWQSec2Uo/Q1cdIuydtYlnoFB43DqliO/z4Qxeq7Oz9EonzM19rgWdhGwxh9BBpEG+1UD+lK2VEplOlP/NVVqaDcuP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/kkXh6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0890C4CEE7;
	Mon, 26 May 2025 15:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748274002;
	bh=LkCB1cxpnlw0YjZLmRg+PL+0hf4e/c14ioxMmsZ/hX4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U/kkXh6PLvxmC07EdWwTZbDM2vQC33MEj58Nkxsu1NyIJbFGDnm28f4vegi4M1u/A
	 cAD6+pFlcSEg5eGZBsOJcq81XFtufL4H9magk8ANINVhuKsweTlpAeTS3XB0SFTfjh
	 RL6wriYeTuNWt3pvXcpgmk7J8EWv+d+kV5EYmojoWjJVyxpHHIh105NGP26Fcg3wpU
	 UIfpBNvZD3B3MDBsCU51tGV7K4kwz5NiEnIWyP9uFBtbi+C7VLnjCyahhCWhdncwIa
	 T/yA8KvQxqWl2aNzVJIBdYKJ6upcgarcTVuuUlMgfZJysvm86sRoiH3DATtusOj5ix
	 G3jpfm/SJ1aTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE1E3805D8E;
	Mon, 26 May 2025 15:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: mctp: use nlmsg_payload() for netlink
 message data extraction
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174827403624.961666.4981172630312635196.git-patchwork-notify@kernel.org>
Date: Mon, 26 May 2025 15:40:36 +0000
References: <20250521-mctp-nlmsg-payload-v2-1-e85df160c405@codeconstruct.com.au>
In-Reply-To: <20250521-mctp-nlmsg-payload-v2-1-e85df160c405@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: matt@codeconstruct.com.au, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 May 2025 17:33:36 +0800 you wrote:
> Jakub suggests:
> 
> > I have a different request :) Matt, once this ends up in net-next
> > (end of this week) could you refactor it to use nlmsg_payload() ?
> > It doesn't exist in net but this is exactly why it was added.
> 
> This refactors the additions to both mctp_dump_addrinfo(), and
> mctp_rtm_getneigh() - two cases where we're calling nlh_data() on an
> an incoming netlink message, without a prior nlmsg_parse().
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: mctp: use nlmsg_payload() for netlink message data extraction
    https://git.kernel.org/netdev/net-next/c/0a9b2c9fd168

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



