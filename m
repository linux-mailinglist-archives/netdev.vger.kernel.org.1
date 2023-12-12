Return-Path: <netdev+bounces-56352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E0C80E957
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736041C20961
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0585C097;
	Tue, 12 Dec 2023 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YeUfoA7R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9D45C08E
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 10:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C390C433C9;
	Tue, 12 Dec 2023 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702377624;
	bh=bNZFXT6uE4NzbeIp42aj++88Ef7ZPb0Co0gmFlN7Hz8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YeUfoA7RbtZqZNIm0pyXM/cz0+LtFHXinS+bxpAoD1UAmAxBm5wJ6P1fon3FKq1an
	 fRKWKXzGy/l3AezkYKC0HmAwXAQpxZDxsgYCHPDtVjSvfmuq6PL+vVX88NroEy3uHl
	 HMUHk8m8DI0jyaRHJd2vkhiOk5+LFc0/KkQjGIkhaxDiEBQP3DYguF0kK/INn184EB
	 84guqI2a0BXGdfR64grRIcck29y5zdt38zYHEv2S3J6iU772+Z35gcK9TUUh+C/sMS
	 og2oeNZ/HAab9QuAjGVEN6O/AMg+Xg9FtIrXdNdQeCs8ulkmIiIoUVzlFOEG+12sQ+
	 WJaXnVoF8R3SQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 146E7DFC907;
	Tue, 12 Dec 2023 10:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] net: dl2k: Use proper conversion of dev_addr
 before IO to device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170237762408.11960.6180714999579283849.git-patchwork-notify@kernel.org>
Date: Tue, 12 Dec 2023 10:40:24 +0000
References: <20231208153327.3306798-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231208153327.3306798-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, lkp@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  8 Dec 2023 17:33:27 +0200 you wrote:
> The driver is using iowriteXX()/ioreadXX() APIs which are LE IO
> accessors simplified as
> 
>   1. Convert given value _from_ CPU _to_ LE
>   2. Write it to the device as is
> 
> The dev_addr is a byte stream, but because the driver uses 16-bit
> IO accessors, it wants to perform double conversion on BE CPUs,
> but it took it wrong, as it effectivelly does two times _from_ CPU
> _to_ LE. What it has to do is to consider dev_addr as an array of
> LE16 and hence do _from_ LE _to_ CPU conversion, followed by implied
> _from_ CPU _to_ LE in the iowrite16().
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/1] net: dl2k: Use proper conversion of dev_addr before IO to device
    https://git.kernel.org/netdev/net-next/c/68cbdb150d55

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



