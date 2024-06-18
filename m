Return-Path: <netdev+bounces-104296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B563590C117
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 03:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12B49B21244
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 01:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27261C697;
	Tue, 18 Jun 2024 01:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCwwvYki"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769AE1AACB
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 01:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718673030; cv=none; b=M/3L/pPqaWybC6rjMlZBkeEVw1MyC89K3ps2hDEc+LGse7TQlDb09ITHDnmrhcQsmvpt996Ws7RK50j43gNAec0pFxRGXTmD45KVqxSFXturZmwzo5/WVLg5wmXYIuY3KGpdhe60YHNeJxy9bXkjFu9XhJh2WN/HWfIODvty/6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718673030; c=relaxed/simple;
	bh=HHq/x5hIBRBxw5EQUd/MYAryjUg0Vfv1rVwyzxL8w0w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LBkyzggRDSrhBdg0qmfmpg+T2PpGJH229BXFu/fGNGu7ejiKsJG2nEUt0UNIKFyH9tQD4wlk/X4pzimMqe6lv4ihznmjQVKUQXyxRNEWpn7Q9ixr/Uc3o3Q1JnXx0huPww7IXx7cmvbFxNZwlB2eUEObLgnikCCLqh/2pXfbrlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCwwvYki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F26BDC4AF60;
	Tue, 18 Jun 2024 01:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718673030;
	bh=HHq/x5hIBRBxw5EQUd/MYAryjUg0Vfv1rVwyzxL8w0w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dCwwvYkilIrjesJYYPWqooMCSQJwLDg/Bevw9CbJuDFBiK3MvYH4cflIOzpEVQZ/r
	 eXpdZbcxvrNUv48ci6ilK2GQg9ULjxeA7/qTh7ke5aayLVWh4xq29HH6e7EzUhvW5y
	 O9Fj/EuBEIG2CnvZO9TrAlS2HtaPtCuUbb8ZkKgB1/9/GVlK7pfQs0V7W5BhIOr4Ca
	 sDraWXieQ6KCF7Pdj1wF2w53Qr9TxMxqFeDRjVAZ/BefhyNBz7NVT6H7KAtTobrKsb
	 795EZcwVKgy6vZtyfMAatjPKxoisfOmU3/gUqsFIJrq10t3CbItk4HpR8q/Z04h+zr
	 zezgUSioc22/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E92C6D2D0FB;
	Tue, 18 Jun 2024 01:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] fou: remove warn in gue_gro_receive on unsupported
 protocol
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171867302995.10892.2573358156575795101.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jun 2024 01:10:29 +0000
References: <20240614122552.1649044-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20240614122552.1649044-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, tom@herbertland.com,
 willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Jun 2024 08:25:18 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Drop the WARN_ON_ONCE inn gue_gro_receive if the encapsulated type is
> not known or does not have a GRO handler.
> 
> Such a packet is easily constructed. Syzbot generates them and sets
> off this warning.
> 
> [...]

Here is the summary with links:
  - [net-next] fou: remove warn in gue_gro_receive on unsupported protocol
    https://git.kernel.org/netdev/net-next/c/dd89a81d850f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



