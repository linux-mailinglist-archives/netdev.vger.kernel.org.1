Return-Path: <netdev+bounces-152566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 174329F49B8
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 12:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC746188AEB2
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 11:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B127616ABC6;
	Tue, 17 Dec 2024 11:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9V2QDvF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6FB23DE
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 11:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734434417; cv=none; b=dNmkl474jAL+EbJWvmltyoyqFDCpmYPbFL5lwnkF4iLxe1QW6cWijHKJFyjgnlTlLCLfIfAgckYuL0ZGlnNGEv5Wz8QESBZm12W6Dt64aR6Th+vsQCHSjQszJ+scy6G7DKs1YQdNV0CQw7EiErMuixIN1g8kplRULke973MzKQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734434417; c=relaxed/simple;
	bh=gwfgwXdyi2D8XztgP5cZ+yqKOYnay71dX91hLEbq8/Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=be1rgSosrcYmN+DeXwV3TqMhFk7hVnWjFheT0/8pEGSUp5hfXTkmOQ9qlSK7k2U2KJjJpZpFzd0BKeH6zMCJCorgx97j8+utnOel8+3LxA/hodmGSIo5g8kuxIDfql5hecvelYxhsB6sdD/QHyAf6ODqyHIajXe/N8dNEnkmUcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9V2QDvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7F9C4CED3;
	Tue, 17 Dec 2024 11:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734434417;
	bh=gwfgwXdyi2D8XztgP5cZ+yqKOYnay71dX91hLEbq8/Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k9V2QDvFj9yGPGbMYsKpoPTVhwaMEwdzTaR8yqmrLvJx/IKGuhpii0Cdekrt0FbaO
	 w7S9cDuPPcexcsNcXXoXVlYvnzdTIIyQbquzsoQlwF2bnA0LMrwtTOBrxz78/ofoe/
	 iMg61l7dOR4VzujDbJcDu55oPmJkTTM8UXUpCXDdCFrElsJ61a6p5edoUtdhMn65Ve
	 Jwbs7VUlmh36DLBjOFG27SblIeHhMYZ1elZfQ+XMUg1yJKOiqWa0mBYYrLsWBg80Cl
	 ufN6pU5Ybm3IhLgbR+1Iuq73YP55uPzg+yqg+Q0T3Cpupjm8dR3wIM35KLa/bHuxqp
	 Fs+zvFAFV1r4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710D53806656;
	Tue, 17 Dec 2024 11:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 00/12] af_unix: Prepare for skb drop reason.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173443443409.861865.7749859577562828916.git-patchwork-notify@kernel.org>
Date: Tue, 17 Dec 2024 11:20:34 +0000
References: <20241213110850.25453-1-kuniyu@amazon.com>
In-Reply-To: <20241213110850.25453-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 13 Dec 2024 20:08:38 +0900 you wrote:
> This is a prep series and cleans up error paths in the following
> functions
> 
>   * unix_stream_connect()
>   * unix_stream_sendmsg()
>   * unix_dgram_sendmsg()
> 
> [...]

Here is the summary with links:
  - [v2,net-next,01/12] af_unix: Set error only when needed in unix_stream_connect().
    https://git.kernel.org/netdev/net-next/c/34c899af6c1a
  - [v2,net-next,02/12] af_unix: Clean up error paths in unix_stream_connect().
    https://git.kernel.org/netdev/net-next/c/e26ee0a736bd
  - [v2,net-next,03/12] af_unix: Set error only when needed in unix_stream_sendmsg().
    https://git.kernel.org/netdev/net-next/c/6c444255b193
  - [v2,net-next,04/12] af_unix: Clean up error paths in unix_stream_sendmsg().
    https://git.kernel.org/netdev/net-next/c/d460b04bc452
  - [v2,net-next,05/12] af_unix: Set error only when needed in unix_dgram_sendmsg().
    https://git.kernel.org/netdev/net-next/c/001a25088c35
  - [v2,net-next,06/12] af_unix: Move !sunaddr case in unix_dgram_sendmsg().
    https://git.kernel.org/netdev/net-next/c/f4dd63165b08
  - [v2,net-next,07/12] af_unix: Use msg->{msg_name,msg_namelen} in unix_dgram_sendmsg().
    https://git.kernel.org/netdev/net-next/c/3c05329a2abe
  - [v2,net-next,08/12] af_unix: Split restart label in unix_dgram_sendmsg().
    https://git.kernel.org/netdev/net-next/c/a700b43358cc
  - [v2,net-next,09/12] af_unix: Defer sock_put() to clean up path in unix_dgram_sendmsg().
    https://git.kernel.org/netdev/net-next/c/689c398885cc
  - [v2,net-next,10/12] af_unix: Clean up SOCK_DEAD error paths in unix_dgram_sendmsg().
    https://git.kernel.org/netdev/net-next/c/106d979b85e5
  - [v2,net-next,11/12] af_unix: Clean up error paths in unix_dgram_sendmsg().
    https://git.kernel.org/netdev/net-next/c/62c6db251e66
  - [v2,net-next,12/12] af_unix: Remove unix_our_peer().
    https://git.kernel.org/netdev/net-next/c/bf61ffeb9cc4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



