Return-Path: <netdev+bounces-130792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AE298B8FC
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C11A1C2233A
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D705D1A071F;
	Tue,  1 Oct 2024 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GADfWDW9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99EE1C693
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727777430; cv=none; b=BCCXhIX/DRAjeF1zDNUO5Nh0jSFKCLqTiBCkt3zCslEOQG4XipSkizJ4V2aZao3uOCsopjpXHyyb+J1HASdFii4iLFi8lsnL3pa9nULJJQA1YtEcUtvLbZQuVRXiQzuCZdbe1iGQKXbbNR2HglcCeD84icH7cL/r1KcWhO0Lem4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727777430; c=relaxed/simple;
	bh=p6Zhy73K9T/98erzli7FFbwmZrHopHOgLcouvw7ZmAY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OqWzWfe58YMh5bCuZcGx3sEnr7y2i4cMG8eqPyv73zG2LhtUbMmFHmkXGD6Vpdh5n4uj6yT2V97/fuk0fZcy0jmRC7OCbqvw9FUgrvfd+rYJDXAkI/Haln0cYse0qYTGwbRsnWP5ThJD9JBbATD0WGCUcmzKYH3k3S7+NWNg08U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GADfWDW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9E9C4CEC6;
	Tue,  1 Oct 2024 10:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727777430;
	bh=p6Zhy73K9T/98erzli7FFbwmZrHopHOgLcouvw7ZmAY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GADfWDW9cG9LPsWMbTXOIcWIS5r6NrcG31WaY7HJp1m9m24JbBA4s7+IdfpVYzjfS
	 wRvBwdHIqkZTuXSlEieZGGHce0ckPjxA/QFpJk8GaCYOOE5dqvjDT6//jt9BgpjjVv
	 rmkcTOVM4dtWESApRMXNRER4eu0RfWDjvxdFNe1QzpvEBlpV7KmSl0m07dcbK0DWGi
	 bPhefUxro4U+KnS0N/qX1Xni63O1mmpxnXYYd9AMB/GyT5Vsk3UiuLXYb54ccnnOis
	 pzKVoFpOAXvD9nfdklNVT6JY+z/KLjfHiVzuHfkFD56v+B6Nwiy/beq2fV+HN1T4OW
	 z4CRIITsITvGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE28380DBF7;
	Tue,  1 Oct 2024 10:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] net: two fixes for qdisc_pkt_len_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172777743350.295383.15996340075475212184.git-patchwork-notify@kernel.org>
Date: Tue, 01 Oct 2024 10:10:33 +0000
References: <20240924150257.1059524-1-edumazet@google.com>
In-Reply-To: <20240924150257.1059524-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, willemb@google.com,
 jonathan.davies@nutanix.com, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 24 Sep 2024 15:02:55 +0000 you wrote:
> Inspired by one syzbot report.
> 
> At least one qdisc (fq_codel) depends on qdisc_skb_cb(skb)->pkt_len
> having a sane value (not zero)
> 
> With the help of af_packet, syzbot was able to fool qdisc_pkt_len_init()
> to precisely set qdisc_skb_cb(skb)->pkt_len to zero.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: avoid potential underflow in qdisc_pkt_len_init() with UFO
    https://git.kernel.org/netdev/net/c/c20029db2839
  - [net,2/2] net: add more sanity checks to qdisc_pkt_len_init()
    https://git.kernel.org/netdev/net/c/ab9a9a9e9647

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



