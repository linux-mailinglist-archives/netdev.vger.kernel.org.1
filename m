Return-Path: <netdev+bounces-165016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E758AA3014D
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 03:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599113A76AD
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 02:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B10BE6C;
	Tue, 11 Feb 2025 02:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYiVZ/zE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB005223;
	Tue, 11 Feb 2025 02:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739239807; cv=none; b=mW+/+xDpeUX3/bbljrk/SN6gjxwGC2ZoK+W0QwjVjWkmDr14PlWemRNyL2ZbQWqpr+skmw9nlpjUU5THRqJ5RJOnkZMcVQ6EDpzwmsmzHZ99nKrXa7xeTk+jQxPZEIM4SaECD0Fj11G4geba6TDtCV1oJ9U6llWZtSo/nRsE+ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739239807; c=relaxed/simple;
	bh=z5NJPX5gJrPYmWA9ZHQyj3O/WgEnVoFXobMd2W4Qb/I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z1hHGhEcD3vkEwGYU/kt1vY++pRyQAnTWYdH+iCIa61l1YOIdmRcdysCYDMvzLndaNwreycxbRfVEg5GrY1SXaKCfMIT7f/MJ5fqjUGKE+Amzrlx6pgj/93Ls2aDnLIsNwXS5ioC6eeidBqUtt5YbOPnCA/hV77WwPJaru7fVyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYiVZ/zE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693F7C4CED1;
	Tue, 11 Feb 2025 02:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739239806;
	bh=z5NJPX5gJrPYmWA9ZHQyj3O/WgEnVoFXobMd2W4Qb/I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nYiVZ/zEaKksk9oAsJk9TqymMFbN5ydOjw91CbEC9lg3QgjtSkLA+06DJPgQ3lvo8
	 qVHAqlib4F0TzBy3sQVX9NVUCyXweBh+Z3Gy6N64o8PYWfawW3reuuaq7v9EUVSAvl
	 PrA/RxTMP5qjvBNcv2qp1OXIxsk3Q/Z6PzwlrPmu5gBINaygoYGqhkJsEdKdKf2G6s
	 L5N0+gbP5dYv3q1VE6bVe7VYRW6mdDOeYHm186SlnqqeeLuVBAGe7LW/mKJA4B0nHY
	 OKGsncR2Gf1IxqxJhRVrbd977C6T/Fv/J7bDhmRUTtKaOQ83t7V3DYfo28wWfed7io
	 kfm64FQYolf/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3723A380AA7A;
	Tue, 11 Feb 2025 02:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8152: add vendor/device ID pair for Dell Alienware
 AW1022z
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173923983501.3914127.14403944549952423101.git-patchwork-notify@kernel.org>
Date: Tue, 11 Feb 2025 02:10:35 +0000
References: <20250206224033.980115-1-olek2@wp.pl>
In-Reply-To: <20250206224033.980115-1-olek2@wp.pl>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, gregkh@linuxfoundation.org,
 hayeswang@realtek.com, horms@kernel.org, dianders@chromium.org,
 gmazyland@gmail.com, ste3ls@gmail.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Feb 2025 23:40:33 +0100 you wrote:
> The Dell AW1022z is an RTL8156B based 2.5G Ethernet controller.
> 
> Add the vendor and product ID values to the driver. This makes Ethernet
> work with the adapter.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> 
> [...]

Here is the summary with links:
  - [net-next] r8152: add vendor/device ID pair for Dell Alienware AW1022z
    https://git.kernel.org/netdev/net-next/c/848b09d53d92

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



