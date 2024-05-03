Return-Path: <netdev+bounces-93395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BB28BB7F1
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 01:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 694911F23B5D
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 23:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F44839F5;
	Fri,  3 May 2024 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adtshKMT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EF9824AC
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714777829; cv=none; b=tg7Zyv6bx4weqZWDjNuMqpTJAUawiHUcejXfpckhEPV+Ilt5By3vPQf1fFDlofJ4LM3VKp3zxjRcieg8r8RiJEFJdFTTNPs8znfJozX3mYM+q9erZ3QPgJasraNYyr/tlv0MP98Q7riuPmE7Wi2i8VEL/iwnsu7Iq7VPUaQJoIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714777829; c=relaxed/simple;
	bh=lsSUvSpTsNeEfYBCNSCtilDx1CFQma5f5EAulwQnQZs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dQNUKunh3EU4fTbRTeHOom6gOhF8pbsFWG/Xr38WJEr/VVyQNsQmzNnitxXxF0G2YS/9CX1Ny2/EVB84reAmdp/+yTUEywOXEXYQIyHjHiSPKCiijB2+hDAu2HFS69BekA8yDY9uQG6iBdrdt6VPK0zzZPvDA4IVo7tITY2xjyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adtshKMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72A5BC2BBFC;
	Fri,  3 May 2024 23:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714777829;
	bh=lsSUvSpTsNeEfYBCNSCtilDx1CFQma5f5EAulwQnQZs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=adtshKMTh8mNjm/F2OvHdKAMTH5yijskIbduOSwq0lIawUZ/7JbfEsE8gnR8jXcnn
	 9qvwUA4LAITReS426yxc72Rex9YTkOZE6wE4DO3n4AWJMW8/Z1igDNRUnf89RRgeKi
	 CZk3I+XdbvTTM4FKwMimXpAHfgMVg74siZiTD9XDB3wUsKkFs7rAXFVIUz6v6QCVBb
	 zCvE8Ff43jYrM0KsGqyy9KX1avZcDymzJchf7W2rxf+dahvNBXLPVF5ghQ2Cgoiu5w
	 F1TnJCvo+FFICpCjEAy01KYd7SYJgX5MRhQcAXXJi3irEp9quC+4dvQdH6KeH4r3y6
	 4bo6OezayGwMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60096C43444;
	Fri,  3 May 2024 23:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] rtnetlink: Correct nested IFLA_VF_VLAN_LIST attribute
 validation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171477782938.11856.16739206272754478830.git-patchwork-notify@kernel.org>
Date: Fri, 03 May 2024 23:10:29 +0000
References: <20240502155751.75705-1-rzats@paloaltonetworks.com>
In-Reply-To: <20240502155751.75705-1-rzats@paloaltonetworks.com>
To: Roded Zats <rzats@paloaltonetworks.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, orcohen@paloaltonetworks.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 May 2024 18:57:51 +0300 you wrote:
> Each attribute inside a nested IFLA_VF_VLAN_LIST is assumed to be a
> struct ifla_vf_vlan_info so the size of such attribute needs to be at least
> of sizeof(struct ifla_vf_vlan_info) which is 14 bytes.
> The current size validation in do_setvfinfo is against NLA_HDRLEN (4 bytes)
> which is less than sizeof(struct ifla_vf_vlan_info) so this validation
> is not enough and a too small attribute might be cast to a
> struct ifla_vf_vlan_info, this might result in an out of bands
> read access when accessing the saved (casted) entry in ivvl.
> 
> [...]

Here is the summary with links:
  - [net] rtnetlink: Correct nested IFLA_VF_VLAN_LIST attribute validation
    https://git.kernel.org/netdev/net/c/1aec77b2bb2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



