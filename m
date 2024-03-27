Return-Path: <netdev+bounces-82589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0920688EA19
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 16:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82A3299E97
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 15:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67E712E1C9;
	Wed, 27 Mar 2024 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4q//FFQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD014F20C;
	Wed, 27 Mar 2024 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555149; cv=none; b=Z11cSypeR8kF4ZZOBv2sN/6MdPlrp0ad6GQWNa2Cn2hBB80ppElbqXLVDhvE3Yu/JpaUuZUpjQ86gyDA7HEjmHdzZMG6JQwU6FeBA31yw0aGphD7Tr7wrVeiBqWDyGxGX4lB207HYy3RZPOlJo4+axoqE6u+vYg8NnOlA8gCLtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555149; c=relaxed/simple;
	bh=hxk8JW6n2a2CwYg8PRgruRnRUtmQmi8Bja/eNuJkqPY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sU11wutxVXqM6yi590jQSWIds7KXlg0GKXUfq70YmGhgxc554Sb54Pod6KXlb6mO/y50g24ojwxve0jWddyEJmO8jTJXn2heVO1laFourjSN4+tMG3rtbvy8CHWR4fFl/UuMGThrJEpu7RNmJ4T6w4jWD3xa+PXUBLfMR4peTx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4q//FFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54778C433C7;
	Wed, 27 Mar 2024 15:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711555149;
	bh=hxk8JW6n2a2CwYg8PRgruRnRUtmQmi8Bja/eNuJkqPY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d4q//FFQVIXCFP0O6qLr2hGQ5nI/Uuz0yY/36Bn4h53kXqMkev8iod6+nEsq7VlL4
	 zomuSKmiRFiFaqhoCbr+R1p6FO67Klr7UXvQojiNgprLwLbyYjzddcr7lnA2/rv1gJ
	 M6AEQEEXh4polGidRm1jWWxh+IHTVwqg1cooI0E+GMLV3geSJYJSISkhtWUxVUbCgW
	 kSLagzkVLr2DcPW/twcYyjdAO5iU3D7CEgoHxtLo6GD3m8NDiT6hNwZjuKFYQ5eghD
	 Z4ZASJSNliTB4oXW45dFKbz6Bkcu3tYui7IX0bPicr3BnpPiixKwmeLZ3D7aB7bsb4
	 qtkbGvmKYRWKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42325D95063;
	Wed, 27 Mar 2024 15:59:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth-next 2024-03-22
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171155514926.7842.16833615896468734890.git-patchwork-notify@kernel.org>
Date: Wed, 27 Mar 2024 15:59:09 +0000
References: <20240308181056.120547-1-luiz.dentz@gmail.com>
In-Reply-To: <20240308181056.120547-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  8 Mar 2024 13:10:55 -0500 you wrote:
> The following changes since commit eeb78df4063c0b162324a9408ef573b24791871f:
> 
>   inet: Add getsockopt support for IP_ROUTER_ALERT and IPV6_ROUTER_ALERT (2024-03-06 12:37:06 +0000)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2024-03-08
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth-next 2024-03-22
    https://git.kernel.org/bluetooth/bluetooth-next/c/2f901582f032

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



