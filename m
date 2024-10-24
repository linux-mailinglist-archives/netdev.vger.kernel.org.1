Return-Path: <netdev+bounces-138500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9E99ADF09
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 10:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA87E28A512
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 08:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E551B392E;
	Thu, 24 Oct 2024 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iK3+UNZN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA631B21BD
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729758025; cv=none; b=ZDa4eF5LI52QaFKiCiLyKcrGXnnyy6yHPr2EtXmkyauR/WeaS3p26dytY19bGyfhgszT6JVfJSLjXzlft2C+i9qyIaekO4j0opNx/yADH/ruqCOhP7TO/znogTxhFXECAJErpsuHkVPzuJe7kYoLsNl2/RW3rj9zX5emYSxqwPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729758025; c=relaxed/simple;
	bh=/qPmRvMQ9fwz6myGsTxVFIOZ+P1+g106s3nebbnRKEo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tOgo1SSLG0cJIZQ7vyoUwqjaJz0QraQXvxaFk8Wgf8L3RtPhLrU08OAXVoDjY3dHcU09YdGPnjZQE3Q5y7SbFaDARnoC4FB6tXe7oWiRvryLIOl0ATXQVUsjBLQTHMTLndiQuCV7b3M+2HOPjAHhOdDjiTT4Vh2Y/60y+AVNkrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iK3+UNZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2362BC4CEC7;
	Thu, 24 Oct 2024 08:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729758025;
	bh=/qPmRvMQ9fwz6myGsTxVFIOZ+P1+g106s3nebbnRKEo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iK3+UNZNNA6SKtgnnbNz2yCkd7pexuemhyBWnTk8dbytJlz63a+As1+50/Gu+2Bw9
	 arY/4E+Vk1I8BBw35WqKymbfEf1ksIIoRkIgZy35PIxgfkQ99wwcr/WtrmYEDvdijs
	 ZG5twFiaChiEgBVZ90CNyZe3g+pxb5bMPldZ9094Iexc6EDmCbt05CJPzAf/nhrDiK
	 YwuLF9fxclvjAb/AEJngtbwET5HsBETmu1dpXZ5K9RP0hG3C/yiisN7y4fSioR8+US
	 V8HOop4F0/BBt8vE3dS1KvHXz0ZgQkyhpvF4zWrz/ArrGGZZ6dcbJo9omgu3aSJz1n
	 Uu7roRnJ3YOPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE98380DBDC;
	Thu, 24 Oct 2024 08:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] tools/net/ynl: improve async notification
 handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172975803177.2154552.15832349779163809819.git-patchwork-notify@kernel.org>
Date: Thu, 24 Oct 2024 08:20:31 +0000
References: <20241018093228.25477-1-donald.hunter@gmail.com>
In-Reply-To: <20241018093228.25477-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, kory.maincent@bootlin.com,
 jiri@resnulli.us, donald.hunter@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 18 Oct 2024 10:32:28 +0100 you wrote:
> The notification handling in ynl is currently very simple, using sleep()
> to wait a period of time and then handling all the buffered messages in
> a single batch.
> 
> This patch changes the notification handling so that messages are
> processed as they are received. This makes it possible to use ynl as a
> library that supplies notifications in a timely manner.
> 
> [...]

Here is the summary with links:
  - [net-next,v1] tools/net/ynl: improve async notification handling
    https://git.kernel.org/netdev/net-next/c/1bf70e6c3a53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



