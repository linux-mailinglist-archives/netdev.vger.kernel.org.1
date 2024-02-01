Return-Path: <netdev+bounces-67962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3F28457DC
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 13:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070681F22E82
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 12:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6340F5CDDC;
	Thu,  1 Feb 2024 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TX4qmDrM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408AB5CDC4
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790628; cv=none; b=d5IVOwKlpDlBeDBgtOfKsIBCz9RWF4+31XFfvaqw7aQZxeGehHL/IRNnZLkt8ycpwyOEdzmhfg+n4awQuI4ND5a9xovPQ94G9G363zIjwF2Dj1l2kD/9aSnYgP4VXxK//KMqm9Int44WU0fg1S9+gVj68MDmDbG3zDh49WT/WNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790628; c=relaxed/simple;
	bh=DBvgQXkRvLI9oy5I3Bs1HzaZ+aJXSMBrlrz9UE+HB3w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kljx68RiJP/6v7TWHV1VgsDSwRAT7WBDkxM6id5lVqV6Nk6LwFe5ZBfFykXn9qVtNUzGaoHCyK2cT9zJp33a2ho037HcgHXyD/O/4VB+aK0LDZCPlJ3qK0VbWLBEYZ1L2Ex04uGR7Nc91oXCIHiq1tGIuuW7qXClpp1uyG/dT6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TX4qmDrM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3D59C433C7;
	Thu,  1 Feb 2024 12:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706790627;
	bh=DBvgQXkRvLI9oy5I3Bs1HzaZ+aJXSMBrlrz9UE+HB3w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TX4qmDrM97LGPMjRUbFzyCMnPhNiXn58q6TqpcMxKv54AdCoPi6ZFPLSdZFqC9bOh
	 GDeciYBENLMDeOWOPVpqOLqB9yzSgOYB+Pg75wMtNiQj2y3LCCx9E8zubfGipJsOdm
	 dUFiBOlm5U6qL4BnZqFoVDo8e/ZAly+tmyMnykd9fw3vSJg1dNO9L34nDGIBLfSD9g
	 QLiyynb5fkmOKx3B49715ZnYRWJTAER7PTTSzP8dcjNK/I4bUou18eL4FBH5QnAp1Z
	 WzhNQ5X7dy9zCIeQIWsJKtS23qUGyA4yCcKy0hFJLKdYBVkimpPhtalqIFZKYlRBxY
	 S7WeC1Gy3hRKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6D83DC99ED;
	Thu,  1 Feb 2024 12:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 00/11] ENA driver changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170679062767.10307.17987301987672256826.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 12:30:27 +0000
References: <20240130095353.2881-1-darinzon@amazon.com>
In-Reply-To: <20240130095353.2881-1-darinzon@amazon.com>
To: Arinzon@codeaurora.org, David <darinzon@amazon.com>
Cc: shannon.nelson@amd.com, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org, dwmw@amazon.com, zorik@amazon.com, matua@amazon.com,
 saeedb@amazon.com, msw@amazon.com, aliguori@amazon.com, nafea@amazon.com,
 netanel@amazon.com, alisaidi@amazon.com, benh@amazon.com, akiyano@amazon.com,
 ndagan@amazon.com, shayagr@amazon.com, itzko@amazon.com, osamaabb@amazon.com,
 evostrov@amazon.com, ofirt@amazon.com, nkoler@amazon.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Jan 2024 09:53:42 +0000 you wrote:
> From: David Arinzon <darinzon@amazon.com>
> 
> This patchset contains a set of minor and cosmetic
> changes to the ENA driver.
> 
> Changes from v1:
> - Address comments from Shannon Nelson
> 
> [...]

Here is the summary with links:
  - [v2,net-next,01/11] net: ena: Remove an unused field
    https://git.kernel.org/netdev/net-next/c/0def8a15dae7
  - [v2,net-next,02/11] net: ena: Add more documentation for RX copybreak
    https://git.kernel.org/netdev/net-next/c/bd765cc91012
  - [v2,net-next,03/11] net: ena: Minor cosmetic changes
    https://git.kernel.org/netdev/net-next/c/243f36eef5c7
  - [v2,net-next,04/11] net: ena: Enable DIM by default
    https://git.kernel.org/netdev/net-next/c/50d7a2660579
  - [v2,net-next,05/11] net: ena: Remove CQ tail pointer update
    https://git.kernel.org/netdev/net-next/c/06a96fe6f9f0
  - [v2,net-next,06/11] net: ena: Change error print during ena_device_init()
    https://git.kernel.org/netdev/net-next/c/ae8220929329
  - [v2,net-next,07/11] net: ena: Add more information on TX timeouts
    https://git.kernel.org/netdev/net-next/c/071271f39ce8
  - [v2,net-next,08/11] net: ena: Relocate skb_tx_timestamp() to improve time stamping accuracy
    https://git.kernel.org/netdev/net-next/c/70c9360390ea
  - [v2,net-next,09/11] net: ena: Change default print level for netif_ prints
    https://git.kernel.org/netdev/net-next/c/716bdaeceaee
  - [v2,net-next,10/11] net: ena: handle ena_calc_io_queue_size() possible errors
    https://git.kernel.org/netdev/net-next/c/4b4012da28cf
  - [v2,net-next,11/11] net: ena: Reduce lines with longer column width boundary
    https://git.kernel.org/netdev/net-next/c/50613650c3d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



