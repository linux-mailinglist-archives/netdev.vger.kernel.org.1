Return-Path: <netdev+bounces-193483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD52EAC4327
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 18:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BCC13B6F36
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 16:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D2419CD07;
	Mon, 26 May 2025 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaRtq9h1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EEF3D994
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748278214; cv=none; b=dTakRQA+rZ58NGe28zbu+M4yJy6eLXlfMv+FPFPYzGHPVxZs3J7QvC2UuhLKq44vpt5tSBmgi5OXLditvXOBuocZu6vvQLoPKdGh/jbx+LyhKM2cgT08FMFA7Sn52CTEedx9VxFwDZFXqCOBvukkS6H7xK9LMoTbfcQuVL3h8aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748278214; c=relaxed/simple;
	bh=JQSIhpIw8FKGAid2McGuyqsh4veM7vKnDHOEt8+Sm+A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MALF3iH5dliNSgNC4UG+81LIGPYwx52PEUxQ01lyXf5SXZZfJdCoUfqqtDeAC1X6i+mdp53SM1ekRLK8lo8Q7z0aZcEj24RrozTYnnzm8v9M7PvjUD7rY+f8LU3pfX/ovQ3GvfPaaMIUezDaFoCEsQ1jf2oaIaWJg7aUV48wCCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaRtq9h1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBD1C4CEE7;
	Mon, 26 May 2025 16:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748278213;
	bh=JQSIhpIw8FKGAid2McGuyqsh4veM7vKnDHOEt8+Sm+A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VaRtq9h1lMGostdODzNg5gGfW1KHh1RXV+X0NM/D9eaW+t6e7IoLYtrqXoAhQ5B5K
	 5msd9wh8nTe2+lockF9v4k80Q/jNY7xLIwySRWmwn6aSHf0nvGJZfnP3xZ/zdLQh+Y
	 PTIXTrnrkW7XuxLrD0C0oXmlKCjXKSTxlNF6xB0AhuY7/5aQhZ+L6huyTykKR8LLWu
	 tzocI06pGxrPp4+rxtVTQZgX/YC3abOLKBiprimYKigEJemZ+QGEaa6+R7Dyg4Iw/9
	 24fbhYUI6EF4gxuYuMQCGgMXcLXlXAaUbRdmCOfHQF7+HIioDOgOnuDzyx73tI4uRG
	 6tCeANNpGBHWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B273805D8E;
	Mon, 26 May 2025 16:50:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/12] xfrm: Remove unnecessary strscpy_pad() size arguments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174827824800.980356.241010343461254785.git-patchwork-notify@kernel.org>
Date: Mon, 26 May 2025 16:50:48 +0000
References: <20250523075611.3723340-2-steffen.klassert@secunet.com>
In-Reply-To: <20250523075611.3723340-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Fri, 23 May 2025 09:56:00 +0200 you wrote:
> From: Thorsten Blum <thorsten.blum@linux.dev>
> 
> If the destination buffer has a fixed length, strscpy_pad()
> automatically determines its size using sizeof() when the argument is
> omitted. This makes the explicit sizeof() calls unnecessary - remove
> them.
> 
> [...]

Here is the summary with links:
  - [01/12] xfrm: Remove unnecessary strscpy_pad() size arguments
    https://git.kernel.org/netdev/net-next/c/20eb35da409f
  - [02/12] net/mlx5: Avoid using xso.real_dev unnecessarily
    https://git.kernel.org/netdev/net-next/c/d79444e8c3d4
  - [03/12] xfrm: Use xdo.dev instead of xdo.real_dev
    https://git.kernel.org/netdev/net-next/c/25ac138f58e7
  - [04/12] xfrm: Remove unneeded device check from validate_xmit_xfrm
    https://git.kernel.org/netdev/net-next/c/d53dda291bbd
  - [05/12] xfrm: Add explicit dev to .xdo_dev_state_{add,delete,free}
    https://git.kernel.org/netdev/net-next/c/43eca05b6a3b
  - [06/12] bonding: Mark active offloaded xfrm_states
    https://git.kernel.org/netdev/net-next/c/fd4e41ebf66c
  - [07/12] bonding: Fix multiple long standing offload races
    https://git.kernel.org/netdev/net-next/c/d2fddbd34799
  - [08/12] xfrm: Migrate offload configuration
    https://git.kernel.org/netdev/net-next/c/ab244a394c7f
  - [09/12] xfrm: Refactor migration setup during the cloning process
    https://git.kernel.org/netdev/net-next/c/e8961c50ee9c
  - [10/12] xfrm: validate assignment of maximal possible SEQ number
    https://git.kernel.org/netdev/net-next/c/e86212b6b13a
  - [11/12] xfrm: prevent configuration of interface index when offload is used
    https://git.kernel.org/netdev/net-next/c/c82b48b63a93
  - [12/12] xfrm: use kfree_sensitive() for SA secret zeroization
    https://git.kernel.org/netdev/net-next/c/e7a37c9e428a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



