Return-Path: <netdev+bounces-57338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D2D812E6E
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33CE1B209D1
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6D13F8FB;
	Thu, 14 Dec 2023 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMzxIjcB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3CB3F8D3
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 11:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1326C433C9;
	Thu, 14 Dec 2023 11:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702552826;
	bh=Lb5XqYOSqSQfVMQniEQlee0yhjHPQVebWTJkPwgqzg4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jMzxIjcB1L/E0pH2OqJUcwm/BebCDqmwEMxHj9pd7Dxi1A1Y9hH807zr88jfGmDry
	 eKnDqc5xUnHlB496zFQrDW7dDFNGQjgKIFWIu/gbFwMwgdhw6tykmdeXtezbz26PuS
	 u2FSjQK+naxIHUJ0JBURWYCDKoGa6T1stRvWrkRr56/Oj0oEgHpltlE8VTZTy9YwZ9
	 sglmF8M4s0TpKF0QWhPv7rIE7QxO0u1mKlWQbjucoHxXun8q3gJiDfp++X5ZbzyA2E
	 bs83Odl/V8nERZhJridgr1KwEe8xzBN8XeulbquFfOheks/ZhoxuG3eDWpSOUgQ8UZ
	 49BjtI5YcuCow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7099DD4EFD;
	Thu, 14 Dec 2023 11:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: atlantic: fix double free in ring reinit logic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170255282587.16566.13370188070764485246.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 11:20:25 +0000
References: <20231213094044.22988-1-irusskikh@marvell.com>
In-Reply-To: <20231213094044.22988-1-irusskikh@marvell.com>
To: Igor Russkikh <irusskikh@marvell.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 torvalds@linux-foundation.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 13 Dec 2023 10:40:44 +0100 you wrote:
> Driver has a logic leak in ring data allocation/free,
> where double free may happen in aq_ring_free if system is under
> stress and driver init/deinit is happening.
> 
> The probability is higher to get this during suspend/resume cycle.
> 
> Verification was done simulating same conditions with
> 
> [...]

Here is the summary with links:
  - net: atlantic: fix double free in ring reinit logic
    https://git.kernel.org/netdev/net/c/7bb26ea74aa8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



