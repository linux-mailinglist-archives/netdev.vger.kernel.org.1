Return-Path: <netdev+bounces-246139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAE2CDFEE7
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 17:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDEA6300D172
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 16:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5652727FC;
	Sat, 27 Dec 2025 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5pvAuLr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8C0199FBA;
	Sat, 27 Dec 2025 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766851423; cv=none; b=BmBqsBJo0XGp7cFoIX5By8SkCLoVuwFoG8E8KemRWWcd1Q3aSlIVl8y9Vl40iEY/ZvaRBI9ttyidM6jmNsZ+QQ7ckg8m3yN6okoq6CPwkVfqE0H7MXJuAA1JnsnEIaagwHp1mZUv2nErjqZxEEQXj6AjJkc/QPNgznfg1BpeUD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766851423; c=relaxed/simple;
	bh=lcs0vkSRnPxQEduf0/0g8FxobJ41eRUEIo/KIzeEhPY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hP9vzB6GGqTimwkOZWGHjyEZ5gjxqq7lsN1OrKpZioz+6zSTS2IuezjSeumofZB++zueZO/gK/j5+zC0SNI9vWJSN1OaVETutyAE8n7RUkS7puENl+BYyGDwNgJx/WImeeAtp7moU21Q+FuuKWdMWKicCCrqDdWHWPLXgv6ppOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5pvAuLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72FDC4CEF1;
	Sat, 27 Dec 2025 16:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766851423;
	bh=lcs0vkSRnPxQEduf0/0g8FxobJ41eRUEIo/KIzeEhPY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T5pvAuLrYLnXAmDprdDj/sbGBZAL0qIpJRuxAZj2M0iWqf+VcOAFP1khmK3dpaWq3
	 LNFmWb7pxPMaeIs/6jhq5E4S9Ik3zNwNprslck0nxrZpCDVqIZzoMdXLkSUt1teG5N
	 nODPe/Y1hUEbhLapZ1IpX1KXoi+oajE5wevC32Ey+kvZtFButK1UMLfkAVokqxv44g
	 ZHu04gXteUYZmpjl9q6YgBh6sgSXb+8ItMMju46X908rmXVLj0u2Q4nvthAb72wOGY
	 q5H4n3vpoOkDazSr54it4dDPH75f7j71zfyNmRdYZEMoPbowQsosMObH6nO8sGvwBK
	 u8sVeE80y2D+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F281E3AAA77C;
	Sat, 27 Dec 2025 16:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] bng_en: update module description
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176685122679.2170128.2045392184016956286.git-patchwork-notify@kernel.org>
Date: Sat, 27 Dec 2025 16:00:26 +0000
References: <20251217104748.3004706-1-rajashekar.hudumula@broadcom.com>
In-Reply-To: <20251217104748.3004706-1-rajashekar.hudumula@broadcom.com>
To: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dharmender.garg@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 vikas.gupta@broadcom.com, bhargava.marreddy@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 17 Dec 2025 02:47:48 -0800 you wrote:
> The Broadcom BCM57708/800G NIC family is branded as ThorUltra.
> Update the driver description accordingly.
> 
> Fixes: 74715c4ab0fa0 ("bng_en: Add PCI interface")
> Signed-off-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
> Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
> 
> [...]

Here is the summary with links:
  - [net,1/1] bng_en: update module description
    https://git.kernel.org/netdev/net/c/d5dc28305143

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



