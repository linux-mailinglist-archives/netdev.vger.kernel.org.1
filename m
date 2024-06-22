Return-Path: <netdev+bounces-105824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48451913136
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 02:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B796B23B95
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 00:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016EBEC4;
	Sat, 22 Jun 2024 00:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMCnuCl5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15A0161
	for <netdev@vger.kernel.org>; Sat, 22 Jun 2024 00:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719017428; cv=none; b=ScVOBdOOnSxDWjb6D5sVLeoM8ranePkLgfdczM0CSWPbyqNAlIeOznBbqRPSZh/e30Vy8H8lgGFH7wum53WeK5clUigIuoCBjGKRh5DqInN9CpDb+IslzPYI+oWVtiOHPx9W/SYEzYqdjXhsbquc4rypl4rKvH34f4Dcf/lEsjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719017428; c=relaxed/simple;
	bh=Bj9MOHfWtL+9fo3AEuHW9fOA1Rv75hDCB38YuHhmdHE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QxMLLDm05YLbMKoXvTs6YbRqznsQn4uGaHE2JiMYFrF8UW5ho+x9E7fR/hywYzdFQzbBoRzjf3bQMi/QYFgK8/LtjWUeGpVTnXbhBd5bi3cRja+uEUhZ15AJmIwsflMP9FqH3b3j4NqG/RJ6m5pVMsuZWQ/zRE/ZN4mnTvdztFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMCnuCl5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55B53C4AF07;
	Sat, 22 Jun 2024 00:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719017428;
	bh=Bj9MOHfWtL+9fo3AEuHW9fOA1Rv75hDCB38YuHhmdHE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eMCnuCl5+IvT9r+qUZNSyGgatOZ0n8LDRCg/jDIkqTJnoX4B50gsxVBWtJtKLQ1CF
	 qC/yhDpRj+LUGtv0K0Q8mU/ONps9O4la/+cDP22qQ3fIyh7X+optIWZXdbprZ0HeJQ
	 x12XUZKbYWEZ15MSCxRUbebTasl9i3dBddhO2fNStpavRmIw221+NOZKfXMkGsQeTt
	 mDGMosiAqGt+bs7ELc0L7WwdP2L8G5CJh44TSaxc9tgBxUXuRdExRLsfv9kNZZZWYv
	 zFTDumsVLtRsksfjTgmsEtOCcfTBLE3x9zgwCu9X5ann///egj5oDlVszkk4hKD4wR
	 3aMohP2xcywqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 433C6C54BB3;
	Sat, 22 Jun 2024 00:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] vxlan: Pull inner IP header in vxlan_xmit_one().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171901742827.19632.17309295113576533527.git-patchwork-notify@kernel.org>
Date: Sat, 22 Jun 2024 00:50:28 +0000
References: <2aa75f6fa62ac9dbe4f16ad5ba75dd04a51d4b99.1718804000.git.gnault@redhat.com>
In-Reply-To: <2aa75f6fa62ac9dbe4f16ad5ba75dd04a51d4b99.1718804000.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, stephen@networkplumber.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Jun 2024 15:34:57 +0200 you wrote:
> Ensure the inner IP header is part of the skb's linear data before
> setting old_iph. Otherwise, on a non-linear skb, old_iph could point
> outside of the packet data.
> 
> Unlike classical VXLAN, which always encapsulates Ethernet packets,
> VXLAN-GPE can transport IP packets directly. In that case, we need to
> look at skb->protocol to figure out if an Ethernet header is present.
> 
> [...]

Here is the summary with links:
  - [net,v3] vxlan: Pull inner IP header in vxlan_xmit_one().
    https://git.kernel.org/netdev/net/c/31392048f55f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



