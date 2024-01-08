Return-Path: <netdev+bounces-62456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D55C827686
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 18:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8830CB22619
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 17:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA12F54773;
	Mon,  8 Jan 2024 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJUFwQFT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF36547782
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 17:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46AE3C433CC;
	Mon,  8 Jan 2024 17:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704735624;
	bh=VAwqYlnl4aFR6hHWiRSDUqmi/obFOxtGRUuT8q59QeQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MJUFwQFTjUeEjYdMD5EDuEFxL0avEu0e8eUcQKpxfg8RXyO7Mc5SgTYh6oJcluNK3
	 ZGbKJTlk1F7AaUPS+HuFjZbgVn2ZY7SAHkDBZdGY7x5vAK5bey23P5cdbhY0BhBG/8
	 1NN1UirMJArxJeXZZv6/KzO5b1Ny0Op3mA/gmkSXIOiJkx9nSfMdxm6WDui3R6QZBD
	 tROdjnoesDi9+dLGEY71ZtaGwoKn9BiYbgtqY5q23NsRNkrGSM2ZTxAfPwLzh9NnsF
	 ZNrp+obDHOznyst70gyf4S2gatJ8ft8CRX4eLuwplPrkyKpl7nwuy/HIaFapskxQTU
	 PVj6SpY+CRDnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E662DFC690;
	Mon,  8 Jan 2024 17:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] lnstat: Fix deref of null in print_json() function
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170473562418.18645.13567675830617183194.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jan 2024 17:40:24 +0000
References: <20240106190423.25385-1-maks.mishinFZ@gmail.com>
In-Reply-To: <20240106190423.25385-1-maks.mishinFZ@gmail.com>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: stephen@networkplumber.org, maks.mishinFZ@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sat,  6 Jan 2024 22:04:23 +0300 you wrote:
> Now pointer `jw` is being checked for NULL before using
> in function `jsonw_start_object`.
> Added exit from function when `jw==NULL`.
> 
> Found by RASU JSC
> 
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> 
> [...]

Here is the summary with links:
  - lnstat: Fix deref of null in print_json() function
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=a193733b7a7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



