Return-Path: <netdev+bounces-73040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106E985AACE
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 19:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C45EB2102A
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB006481DC;
	Mon, 19 Feb 2024 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxNjXcGk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C76481CC
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366826; cv=none; b=deuAmQrTcXdOQvWnWCN3xssrWn7EWW8A2klxVq7m081zhfAMdPWMtShaKoXyda/jySZJnJ/1uYbfkL3v74nk3HtNCj9tzKi2eIISGNpwP0kV8vfQybUfTbaHAPf+FDyeECnr9L3Ro6c0Y8BxrVJFSofASez4n7OB5fX/DiJnm7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366826; c=relaxed/simple;
	bh=6qmuEsGXb0VOm37TOWbi89OGDfUh7FfqNxdXekRNCnA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rY+z7fr3iWGmSkap/MTHcilDEJuqm0y02pWvdZjs0CMlywoyzOdIAH4DEh14zcowBalnMAFEiCEAXIFJg6A2Vkub9BeObiQN+15bxtebGHc0Tea6f/EjZPE/UqJfarJkIu1SnsIExdBjikyaH75UAcuKfzU+esEC3UIhcoU3FwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxNjXcGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 782A2C43399;
	Mon, 19 Feb 2024 18:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708366826;
	bh=6qmuEsGXb0VOm37TOWbi89OGDfUh7FfqNxdXekRNCnA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LxNjXcGkQTsbntFo0D3rTrzQhOEdNQ2kYDoFvZaFTbKFyj4LDBFLTSg8/6uTV5+s3
	 f+8z/6wkYoTP6xfbSlHZuzO/k3nBM92XP8FKE2+18ww4T5irClzXvkZDmwGHeJXoi7
	 JI36FJyAttUmkksttAxpGwIICGl0sWZjP+4ASq6fbuDF/y3fxiKNfo8C9Mm9bY8/k+
	 42w1nVKyi4aGyy+ymgT1NReK2ViKgyFQS1yjc6b+jpdK1SWMqVeV1XyeIFTUqNKiSs
	 RLcJhWFFzWQX5AqG2TJkfpDyPOaavjnvz84m8gFwO4xybRFrINDEVBoo/Qr4Iu1Dvd
	 XbJJJ01W7pFtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63B7AD84BBE;
	Mon, 19 Feb 2024 18:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ip: Update command usage in man page
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170836682640.11627.10142895413866634776.git-patchwork-notify@kernel.org>
Date: Mon, 19 Feb 2024 18:20:26 +0000
References: <20240216144939.2585-1-yedaya.ka@gmail.com>
In-Reply-To: <20240216144939.2585-1-yedaya.ka@gmail.com>
To: Yedaya Katsman <yedaya.ka@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Fri, 16 Feb 2024 16:49:39 +0200 you wrote:
> The usage in the man page was out of date with the usage help, fix it.
> Also sort the commands alphabetically, the same as the command usage.
> 
> Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
> ---
>  man/man8/ip.8 | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Here is the summary with links:
  - ip: Update command usage in man page
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=ecac96e37d6f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



