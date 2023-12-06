Return-Path: <netdev+bounces-54340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37397806B10
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 10:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FE901C20B99
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 09:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26E3288A7;
	Wed,  6 Dec 2023 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwXPedNz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E58241F4;
	Wed,  6 Dec 2023 09:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2E84C433C9;
	Wed,  6 Dec 2023 09:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701856224;
	bh=IYirpk9Zuv663jhWbzf8HfLvsoJDvN1k0rophts0q9I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cwXPedNz3opDAYq+xJxJX5vFliJiGNkcoW/FuI4Eu/irzT1TJhylZSClp1303uG8K
	 kQPtsVJwbzgvtRXW3V5hPt/zN+r91cJQEis9DkeJChu3YulKX6JhTaFtFwoJCfSJNb
	 EozKE+WLvtn70OufSSfIy9Lpi7ZeZKmRsl8+e17Fk03jAxtdaTPx0bT6V8o0wjyUxI
	 tCKxRJH/6TSVfeX2Fuv4OOLqE+mfnxWVRDegzg8bRZjvxFeQN8EoSvghdMfwyCMd30
	 dt7ZboR+t4LO8bzXNOzyO1MZCQp7GrFn72f3N9ID39zvI9DwVvA2B10TBi8Zm5td7t
	 y0MpcIDTbOtkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC267DD4F1F;
	Wed,  6 Dec 2023 09:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] r8152: add vendor/device ID pair for ASUS USB-C2500
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170185622389.11676.14511333566632987056.git-patchwork-notify@kernel.org>
Date: Wed, 06 Dec 2023 09:50:23 +0000
References: <20231203011712.6314-1-kelly@hawknetworks.com>
In-Reply-To: <20231203011712.6314-1-kelly@hawknetworks.com>
To: Kelly Kane <kelly@hawknetworks.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  2 Dec 2023 17:17:12 -0800 you wrote:
> The ASUS USB-C2500 is an RTL8156 based 2.5G Ethernet controller.
> 
> Add the vendor and product ID values to the driver. This makes Ethernet
> work with the adapter.
> 
> Signed-off-by: Kelly Kane <kelly@hawknetworks.com>
> 
> [...]

Here is the summary with links:
  - r8152: add vendor/device ID pair for ASUS USB-C2500
    https://git.kernel.org/netdev/net/c/7037d95a047c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



