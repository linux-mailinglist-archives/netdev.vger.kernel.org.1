Return-Path: <netdev+bounces-201345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC084AE9141
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 00:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404F01C257B5
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 22:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D844F2F3655;
	Wed, 25 Jun 2025 22:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3mhir5m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27C12D5C8F
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 22:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750891805; cv=none; b=BnZPGQmbgK3LAF8LnpT9hlUYGwlv9Dwh5lNkSiv2XyZW7zH0Vt/9upodNK8f8jHrNif7eI4e+xgSgNIPfp3QFZizeDfkGrG6UvfCnYdrYHVJfIiIyXSkOKwAyD1CCAimO6EtnHDg8/BNe9T6BKFEzDf1bZ/+GsNxQRgzXZie17I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750891805; c=relaxed/simple;
	bh=v82gskl22APdeh0urlzJZw3z7AtesbqABDqaGH/hCr0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VZtL/W7zdKqf5Ku+M21LuJzHouWZjNkH9Tx6p2pm9ArVsHZ1+r6C3higWdWtsmc6Znl0CPOW2tGcHotJFbm703yNBTDmuII2U6yMNNTkvEI6hCK59AePDtV4qf3xPx/eay7jzRb8QGqeVp0zpLrgHIxmD+Gk9appYLBfXiuIUSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3mhir5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42601C4CEEA;
	Wed, 25 Jun 2025 22:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750891805;
	bh=v82gskl22APdeh0urlzJZw3z7AtesbqABDqaGH/hCr0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l3mhir5mQjNYmpZUwTzLWpKP7x8BMmu8jQNBhWCepaT6Yz+ZArc7cJdxeh1EfuWUd
	 NDzGYAjSZ1JrvQeQUxMp1GZNVcdpbvfp2pyGT6CI3DVBN64xeGIWbOl5eFQDvm1bsd
	 YgRXUWGnB1Tb3XH7OWJI8xXynmvC31JHIyOOAVmXXsN+CRbjU6vjvY06tQiR/IoU9O
	 8PaOMLvQMOwESycbiqebcKQHLMFvH4iAB4YMpUnoFiFznymueVlUmWT6k7ebzSmyuc
	 KhMHMaHO0OUGh2icKzbAgiOHw9yN9JzmuA5eQyXn0WckUcbOFiNlIRzlq5iN1SOjYE
	 nE9jnApCqsMvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADE03A40FCB;
	Wed, 25 Jun 2025 22:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 00/10] netlink: specs: enforce strict naming of
 properties
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175089183146.646343.16781467369627472889.git-patchwork-notify@kernel.org>
Date: Wed, 25 Jun 2025 22:50:31 +0000
References: <20250624211002.3475021-1-kuba@kernel.org>
In-Reply-To: <20250624211002.3475021-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, donald.hunter@gmail.com, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Jun 2025 14:09:52 -0700 you wrote:
> I got annoyed once again by the name properties in the ethtool spec
> which use underscore instead of dash. I previously assumed that there
> is a lot of such properties in the specs so fixing them now would
> be near impossible. On a closer look, however, I only found 22
> (rough grep suggests we have ~4.8k names in the specs, so bad ones
> are just 0.46%).
> 
> [...]

Here is the summary with links:
  - [net,01/10] netlink: specs: nfsd: replace underscores with dashes in names
    https://git.kernel.org/netdev/net/c/2434ccb94dfc
  - [net,02/10] netlink: specs: fou: replace underscores with dashes in names
    https://git.kernel.org/netdev/net/c/791a9ed0a40d
  - [net,03/10] netlink: specs: ethtool: replace underscores with dashes in names
    https://git.kernel.org/netdev/net/c/07caaf875c93
  - [net,04/10] netlink: specs: dpll: replace underscores with dashes in names
    https://git.kernel.org/netdev/net/c/354592f19c7b
  - [net,05/10] netlink: specs: devlink: replace underscores with dashes in names
    https://git.kernel.org/netdev/net/c/940768094514
  - [net,06/10] netlink: specs: ovs_flow: replace underscores with dashes in names
    https://git.kernel.org/netdev/net/c/e40d3d0931d2
  - [net,07/10] netlink: specs: mptcp: replace underscores with dashes in names
    https://git.kernel.org/netdev/net/c/9e6dd4c256d0
  - [net,08/10] netlink: specs: rt-link: replace underscores with dashes in names
    https://git.kernel.org/netdev/net/c/8d7e211ea925
  - [net,09/10] netlink: specs: tc: replace underscores with dashes in names
    https://git.kernel.org/netdev/net/c/eef0eaeca7fa
  - [net,10/10] netlink: specs: enforce strict naming of properties
    https://git.kernel.org/netdev/net/c/af852f1f1c95

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



