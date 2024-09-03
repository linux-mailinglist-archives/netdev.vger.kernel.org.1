Return-Path: <netdev+bounces-124501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88778969B6F
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 13:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03B8BB2191B
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 11:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAA11A3AA0;
	Tue,  3 Sep 2024 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPqc6bhZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0390D1885B5;
	Tue,  3 Sep 2024 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725362426; cv=none; b=XuxXMynLV9L92f7RjfuqnUXwlvF692n3AIm0OuqWoJdybs6CgzoXgjGmteYrBkjazTU1+mlQoZkPMBVHpPEsG3NJuPcc5ogIh4HK6VJvTHuGavQb42SUhnfMWA5wpL+vk5Xucaw08kOayljST94cVPYtCwE1a0RpqrwjGp4Fk+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725362426; c=relaxed/simple;
	bh=xPY5uk3MU4IF6V2WUtetm4ESkvHY4wRyj3F6HawGALM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X7r8Fv0kWalHjBov57G/Cbsp0bY4A2hqD0WkQGF8EkHA/DAkOx8/s+WKVpm8B2VkvOnjGAZfEIRWVCTpCaq6Yq7WVikwfk4qXlZn7Sv91RnNT2oTsMA2EvU/kP71nY9tbHp/MLtziIpQbTG+wBbzIyjpAqoQokQR//UVPS8sK6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPqc6bhZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FEFC4CEC4;
	Tue,  3 Sep 2024 11:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725362425;
	bh=xPY5uk3MU4IF6V2WUtetm4ESkvHY4wRyj3F6HawGALM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PPqc6bhZtqabxv88MFhG83qo+p4BmJceCEiYWiR5iQLr9bkkTu5ITFagR0ejiLK9V
	 2PbauLRtLTlDmJTC8Q1hvc9vKlkU2gMYyPLa8bNIUYli13o3CViy8YvmQoZBVf5Ka6
	 GSfxdldTKIiFyBhKdEOGZzK4mIfb4bi974usmiXbXqoQf6HvPdiZPQpLpNT5/bJHKq
	 r+/cXBeG6yF49pjXMZ9xYGPr/q7LmJ4u840HQrxkw3yBzZscXYoPTuB8A7N2cHd5bY
	 jMtQkUeIAG5S4ieb+79g7BtlmnhXaubDbWgNzy6/IgZHhXHd9tawM2q8vZE3KKJDdM
	 Hhi0VECRJpz2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F2D3822D30;
	Tue,  3 Sep 2024 11:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/3] cleanup chelsio driver declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172536242625.262111.10519772172037402313.git-patchwork-notify@kernel.org>
Date: Tue, 03 Sep 2024 11:20:26 +0000
References: <20240830093338.3742315-1-yuehaibing@huawei.com>
In-Reply-To: <20240830093338.3742315-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: bharat@chelsio.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 30 Aug 2024 17:33:35 +0800 you wrote:
> v2: correct patch 3 commit citation
> 
> Yue Haibing (3):
>   cxgb3: Remove unused declarations
>   cxgb4: Remove unused declarations
>   cxgb: Remove unused declarations
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/3] cxgb3: Remove unused declarations
    https://git.kernel.org/netdev/net-next/c/bd11198da8ac
  - [v2,net-next,2/3] cxgb4: Remove unused declarations
    https://git.kernel.org/netdev/net-next/c/17d8aa831aa0
  - [v2,net-next,3/3] cxgb: Remove unused declarations
    https://git.kernel.org/netdev/net-next/c/f5f840de659b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



