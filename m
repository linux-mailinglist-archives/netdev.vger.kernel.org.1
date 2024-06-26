Return-Path: <netdev+bounces-106968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 828229184B0
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 16:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB8D1B2B1AC
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 14:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3BD187560;
	Wed, 26 Jun 2024 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+wHJTys"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580B918754A
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412830; cv=none; b=PwJ7MREheLQGVxzXKM5/I/Rqu3ojlDell234XOxNOhvxu9htgdWDIPr90946MveRblKOOo/QsN7BmdAqZxNCEwNGkZFeiIjozYlXp7kgfd63cLA36sLajuafaigUvGHHlCyAPKvLiNNldtAZ17nxOkl1QGABsHOB3gMc/CT5OAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412830; c=relaxed/simple;
	bh=jYjqnDqrAcshDV7e7md7gqDsBacMvaIMt5pNk9T4jBY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lDkFttJpcnH1l+kkbif1quqXDa50iKfVH7RQnIjNTcnKJgPJgXRpF1wbDByEyOD7LARiGZizn/ELcmNgx481FbmJmdTs/bFq8p8Gw3ncVexcOwzkF8aEs+cl4A9C/z1utjCzN/o7T1P2KNFY2LTuvLvlS7PIvO1+UmRY2PZdHXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+wHJTys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE0A5C32782;
	Wed, 26 Jun 2024 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719412829;
	bh=jYjqnDqrAcshDV7e7md7gqDsBacMvaIMt5pNk9T4jBY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C+wHJTysx6jLrDir2ggAzJQltMOLLpqprz0bBWeBDWH6hzKYoMlwMr+pkxtoPP9nY
	 tBdsu7RkJUsROXxn/9BzrkrJSBRtLxOJHcI0KmFleWQ/uzJwit7oBJ+AUCH4Al00n2
	 DYzTLVc/cZPr4FjNe0BauQSm2TCBWCJg2x78eG/0yjxgexhVDXQ/oLNhGEktjGz/Sr
	 9AAa0eEDUsp/aNp4wY1ujfB2ClQd+s03zwZmnPA9adSN7tehaz6sA9Ru2zLSIFRMOE
	 3z0vSLJHLI56JE/ZxbxJ5uvKcMjNizRPDxvY+ZcZSOFCcJrivWgRWarpAEc8E7Qgp6
	 qN4TvAiZv3yiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2512DE8DF2;
	Wed, 26 Jun 2024 14:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: Drop explicit initialization of struct
 i2c_device_id::driver_data to 0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171941282978.9808.3649469008264341115.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jun 2024 14:40:29 +0000
References: <20240625083853.2205977-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20240625083853.2205977-2-u.kleine-koenig@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=3Cu=2Ekleine-koenig=40baylibre=2Ecom=3E?=@codeaurora.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
 george.mccollister@gmail.com, idosch@nvidia.com, petrm@nvidia.com,
 jk@codeconstruct.com.au, matt@codeconstruct.com.au, o.rempel@pengutronix.de,
 kory.maincent@bootlin.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Jun 2024 10:38:53 +0200 you wrote:
> These drivers don't use the driver_data member of struct i2c_device_id,
> so don't explicitly initialize this member.
> 
> This prepares putting driver_data in an anonymous union which requires
> either no initialization or named designators. But it's also a nice
> cleanup on its own.
> 
> [...]

Here is the summary with links:
  - [net-next] net: Drop explicit initialization of struct i2c_device_id::driver_data to 0
    https://git.kernel.org/netdev/net-next/c/a6a6a9809411

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



