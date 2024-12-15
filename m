Return-Path: <netdev+bounces-151985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC749F23C9
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 13:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A6237A0F94
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 12:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78EC183CD1;
	Sun, 15 Dec 2024 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dB/8ohHU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C6E1FDD
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734266412; cv=none; b=J5jfMfzzqDLKnBvT/JOWUbIp6xnCRvIrC+KudYLWjUJM86mrKyB7BHhiVybuEuGdOf2gCPs4H0y7ybO5fD8o8P7dv15abZH6cc9olMQ5CqC9F7PbExCT6Wfd3Ibbq+0I2vR/+g/DnkXCQnUkHsvUHzdYvevKkv71T0wEUMG4vZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734266412; c=relaxed/simple;
	bh=jD+VSDXhSi98AK2rUowkJnOIrMdcL72bV7ZCIyhsc7I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FLDFXtOm/kgIIq+UBY/JX3fBbY8CR69oA1asIEYFNAdKjbaARFwFo+QxtrobRpq6fnT8uUj5tbMYmKEUXuvKtaCCHUdxmv556nRmUCVX+BK2C//tW6d7Qxk6jRdYoSXXqWUsPl/pMPtEeCYpNSpxJiaTIGWGOY/EFOy67Tbvfbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dB/8ohHU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F21C4CECE;
	Sun, 15 Dec 2024 12:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734266412;
	bh=jD+VSDXhSi98AK2rUowkJnOIrMdcL72bV7ZCIyhsc7I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dB/8ohHUCPyOSR8d76VfKdbX7GnPFGWWhhgWAvC5xUDVckOz9IkqlajwhSjc072sB
	 0gRLvvIm+wplmrWhYTAmusqILjOkFXBr3b2Q02cuXJt8YeKwRQtnVX1YanZn20HxNn
	 cRcv5ZfyE6wWTyCi+gl5RwBmlPOJsi75vrA7mvKA7WqymwN1isKO8jyF8EWZU9FIDj
	 IIn6qdMsrUUD+btKG/JOYf9fKCtvVuNVD1Wr3B/ECjianVSRLc1EC1hsauYx4nrgpN
	 BSxEdnQlvSMrFyqD32+J32oSmVoKevSwtg20eDWSEbKTshjm3dNYvr3hON4Ug3GbQE
	 GwBXr/sgwsoDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE1D3806656;
	Sun, 15 Dec 2024 12:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next, v6] netlink: add IGMP/MLD join/leave notifications
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173426642876.3510808.13498380815286857153.git-patchwork-notify@kernel.org>
Date: Sun, 15 Dec 2024 12:40:28 +0000
References: <20241211082241.3372537-1-yuyanghuang@google.com>
In-Reply-To: <20241211082241.3372537-1-yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org,
 jimictw@google.com, prohr@google.com, liuhangbin@gmail.com,
 nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org,
 maze@google.com, lorenzo@google.com, pruddy@vyatta.att-mail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 11 Dec 2024 17:22:41 +0900 you wrote:
> This change introduces netlink notifications for multicast address
> changes. The following features are included:
> * Addition and deletion of multicast addresses are reported using
>   RTM_NEWMULTICAST and RTM_DELMULTICAST messages with AF_INET and
>   AF_INET6.
> * Two new notification groups: RTNLGRP_IPV4_MCADDR and
>   RTNLGRP_IPV6_MCADDR are introduced for receiving these events.
> 
> [...]

Here is the summary with links:
  - [net-next,v6] netlink: add IGMP/MLD join/leave notifications
    https://git.kernel.org/netdev/net-next/c/2c2b61d2138f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



