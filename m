Return-Path: <netdev+bounces-153217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 624C59F7355
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 04:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C5A188A41D
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 03:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918C215B122;
	Thu, 19 Dec 2024 03:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOXDagVO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD5D1531C0
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 03:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734579014; cv=none; b=ZLve0/8oFe8GJbt658thvJ2DhsP9TURS5T8/oD5Z2XT/IvnMxYnlEBQj8Dbj1/fYMABbShr1MvkCNE+CY+WiJxSN6WM2hDd4sNaiY7ODSFYZjI1RECpwXLTfXeAdMuPYL712v6GTm2zUC857ZFzSl5VRz9ZThyUpWKU+GCMm/wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734579014; c=relaxed/simple;
	bh=3a+1aT9rHcU+DVyXtBlLPhNMQlfG1T4xukUktrk9BiY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B1GXp4/H3gw1N/kJXljYUj+07V26dn0kVcBn8O1eO/UBKQqADy80fpKbs3hiMb6f3n/CwGrNnYxaWdnjTalkulteBIaX+ZblUBemEUY7SvpwsQXJ6sXLoJ8gwKHmvOyHB5N1wi0QuvxST3No6lv6Dmk4NXbJ3E/SMA6FB5Y3pso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOXDagVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD09C4CED4;
	Thu, 19 Dec 2024 03:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734579014;
	bh=3a+1aT9rHcU+DVyXtBlLPhNMQlfG1T4xukUktrk9BiY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kOXDagVOcnZO6xEa0aRK2yGO/hV9PzQXP+g5/e/1mvZZp8RWuDx3G1FmSMfVnfZn8
	 8OPN2CSP5wOuOzBNPEGG97DALN5hRtVExbathRb1Bf6srYKUJg9eErbxpE42IIA7hE
	 dAvn5eHj9KCHtIx1U23uToGEg8Vayz9jheAgG/BT8SbEJ3EWFsuZt7ETn5BDVYVgPR
	 aGEo5naUqIzyHjrhEXOT4WoZUbJmOkY7arAkdu75xvdYXZpMemLIH5qyuzfrvUGECq
	 0C6EoiELQnMlp6jdE7RI6q6234850UlAv+aZvZMhdZZB0GpoZYNb0YoXm8pzXKk/8m
	 S7hqKBSx5u7Mw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEE73805DB1;
	Thu, 19 Dec 2024 03:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: restore dsa_software_vlan_untag() ability to
 operate on VLAN-untagged traffic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173457903151.1807897.16925032481407031771.git-patchwork-notify@kernel.org>
Date: Thu, 19 Dec 2024 03:30:31 +0000
References: <20241216135059.1258266-1-vladimir.oltean@nxp.com>
In-Reply-To: <20241216135059.1258266-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, claudiu.manoil@nxp.com,
 alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
 robert.hodaszi@digi.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Dec 2024 15:50:59 +0200 you wrote:
> Robert Hodaszi reports that locally terminated traffic towards
> VLAN-unaware bridge ports is broken with ocelot-8021q. He is describing
> the same symptoms as for commit 1f9fc48fd302 ("net: dsa: sja1105: fix
> reception from VLAN-unaware bridges").
> 
> For context, the set merged as "VLAN fixes for Ocelot driver":
> https://lore.kernel.org/netdev/20240815000707.2006121-1-vladimir.oltean@nxp.com/
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: restore dsa_software_vlan_untag() ability to operate on VLAN-untagged traffic
    https://git.kernel.org/netdev/net/c/16f027cd40ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



