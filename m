Return-Path: <netdev+bounces-118707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 456A195286A
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 05:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30E21F23EBE
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 03:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BFE2CCB4;
	Thu, 15 Aug 2024 03:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EM/vpS46"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C234B42056
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 03:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723693834; cv=none; b=ixJORd6/woEq/SF+igmpeitVfGCTlgtNU21pRKgu/8qTgGikwQDQo/gm0VWClcfldtIa7JtGipZMci7QlJ118Cm1IjXk3uF25rMn/xKDLEUgreOcjX7645MkCSQECTEHxXYcOHy3TxPnn2ri71WcgQqQkv+0OnNA0HULIx3wSkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723693834; c=relaxed/simple;
	bh=DnCsd7ZQl7K3D77NVnP+5Y9sAjCQxeHRawGB96qrRaE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l+haPrYBGUwkDzGwK7lVw84sgJW7tqP2Kqlg5sDueIQUOEPipHPKm179ys3/CpW8lC4F6SaGxiz94rdAeLygDNY0aIhc6dXwB+ephwCcCvI4oHiVUl1l2F3WbUwYrat5H4oW5RhNkY68tAv6Vr/78+k+sUFhcVFiNqFcnwaP60I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EM/vpS46; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B235C4AF09;
	Thu, 15 Aug 2024 03:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723693834;
	bh=DnCsd7ZQl7K3D77NVnP+5Y9sAjCQxeHRawGB96qrRaE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EM/vpS460NPPcVRSYYWOZG2tFqtWW9rZHkV9bJYkaocwn22rO56DWb7jjO8hqqQ+q
	 2LuMxg4X4aJuRh2hjSebDFJdRb6xzvGatL1x/YncQxZqOTQx/nIy4Nd2sY/vhlnKVf
	 Qa6IVsKsrjSDXxME7Fp/r0iFkicl/fNdvzeDQIdNviJaQj+GNi0ZY4jHtyQUbmmPAx
	 bT5CazrlT9wMEhp2mBfQyS7l8isJGSWFa30ZFrL8J5TH1l2WJ66yFFm3TscuKL+utu
	 E0qHuGfs9MYFxah1UCaqDL8G8bv1ySKlcH2Xa+S/uYqI10RpgLWV5RIkufIRlHmhYa
	 FMOZTro/Z+1iQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1353810934;
	Thu, 15 Aug 2024 03:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] bnxt_en: address string truncation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172369383323.2458412.9628825378914048599.git-patchwork-notify@kernel.org>
Date: Thu, 15 Aug 2024 03:50:33 +0000
References: <20240813-bnxt-str-v2-0-872050a157e7@kernel.org>
In-Reply-To: <20240813-bnxt-str-v2-0-872050a157e7@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: michael.chan@broadcom.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
 przemyslaw.kitszel@intel.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Aug 2024 15:32:54 +0100 you wrote:
> Hi,
> 
> This series addresses several string truncation issues that are flagged
> by gcc-14. I do not have any reason to believe these are bugs, so I am
> targeting this at net-next and have not provided Fixes tags.
> 
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] bnxt_en: Extend maximum length of version string by 1 byte
    https://git.kernel.org/netdev/net-next/c/ffff7ee843c3
  - [net-next,v2,2/2] bnxt_en: avoid truncation of per rx run debugfs filename
    https://git.kernel.org/netdev/net-next/c/1418e9ab3e2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



