Return-Path: <netdev+bounces-215134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A23B2D26F
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 05:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F629585E7B
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 03:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D23257ACF;
	Wed, 20 Aug 2025 03:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmU7TOoM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B182C78F34;
	Wed, 20 Aug 2025 03:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755659501; cv=none; b=R3VUC21GNi/9+N1VT1GqryB/YsMQDWDcLLZp7EMgz6phY+oEETvjH7EGvO83dGFxBsBwuUTfQtMQVS4rx3N/FkPKPKJx9g+x+aFCX4bGZ+M+VZsiC1HrMVBLB25+6zO5St7x4To7SxbqXd4ZaJmXc/+OtdGciuU6TRqoRG30t3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755659501; c=relaxed/simple;
	bh=2+QVvojJyGANiWkj4yXxbKlCR2iG+8Ht5YmkAd6DrMs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=teHcmSmJtITZ5+dCJ4fCguEcd5Fm0pvUfTP79nAoD4YQnQFBfpqeXxuNGuRxZb835AeUFv4SSVNFNUfzTE/bYIZu05JwEmK9y/GIIJpLsNijLd5azDFc/3eGTxdCLqisMUJAGl3rwmsjK1PCFVfXLSLQqObgoEf3bK1ZGj7POJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmU7TOoM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E957C4CEF1;
	Wed, 20 Aug 2025 03:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755659501;
	bh=2+QVvojJyGANiWkj4yXxbKlCR2iG+8Ht5YmkAd6DrMs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RmU7TOoMDzLG+AnMEOC3FULW2bhVYFGXrwyohX2nv46dOoCt86QKraffHBNQitM0J
	 /mv6rDzLLf8ks76XtxrVAh+df670m0jn6ncKYZBJvhZ/h0dGwvg2DEfA/EcTUDqikJ
	 pTWsTPHWmfvCnrDoTcaBTqJ4VzFeFGu0DD7lYcyFws/8nSzDmRUyyCh8Agp2Sn2zC7
	 m6S9buiVPcNgudzK/MujP2prz/xY2btvgWZ4kwsbwkbmPvjO/+cghY5BGLL8Ac1wkJ
	 /hABOBYH4xhDnjEUsOWghvNq3JPIhfoiu5vfepTyNVaZVMH9ZmPPaC7o/WGxmiw+MP
	 BXTjsEPyrPpZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C5D383BF58;
	Wed, 20 Aug 2025 03:11:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] There are a cleancode and a parameter check
 for
 hns3 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175565951073.3753798.100437251034921390.git-patchwork-notify@kernel.org>
Date: Wed, 20 Aug 2025 03:11:50 +0000
References: <20250815100414.949752-1-shaojijie@huawei.com>
In-Reply-To: <20250815100414.949752-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 jonathan.cameron@huawei.com, salil.mehta@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 Aug 2025 18:04:12 +0800 you wrote:
> This patchset includes:
>  1. a parameter check omitted from fix code in net branch
>    https://lore.kernel.org/all/20250723072900.GV2459@horms.kernel.org/
>  2. a small clean code
> 
> Jijie Shao (2):
>   net: hns3: add parameter check for tx_copybreak and tx_spare_buf_size
>   net: hns3: change the function return type from int to bool
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: hns3: add parameter check for tx_copybreak and tx_spare_buf_size
    https://git.kernel.org/netdev/net-next/c/e16e973c576f
  - [net-next,2/2] net: hns3: change the function return type from int to bool
    https://git.kernel.org/netdev/net-next/c/021f989c863b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



