Return-Path: <netdev+bounces-206288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0494B027DD
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 01:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41AACA481D0
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 23:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159C9224AFC;
	Fri, 11 Jul 2025 23:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3c4K2ev"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22FD22488B
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 23:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752277787; cv=none; b=ClwKztbWLKCy++0xc030XasOEHm4GpAJy1eeAISNoLYlBMTTxV1WidueyYhX5RXZ7QqGthsSwp/c+atNOoTelE/kTITRcba/F6aimjMR+x868XZz5uQzyr16nMzlebrkbdNHbwbZsO30um6HonYOOBKKOIDM1fbKKHYJbf4pmKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752277787; c=relaxed/simple;
	bh=Z/l4ZKAZUbvVdwx4CRIkWmAAJrHpspd0KbttdrUiQ8Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rRDee53sdJq5NujzL6nWnNs1wK1zceJNGUF1Zh5WE4FhOxoc9Lf7iGBMHqYCBRcYErDAuiLVFiIP3Sd89l2TBW/HcnW+n/MC6Bxit2zWwUQWR7zE5VryVx2pCu+v7Ihl23qljYfVtBm/3lsPWTI8ZaYVrp4W3xNLNqirdyhe2BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3c4K2ev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0CDC4CEED;
	Fri, 11 Jul 2025 23:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752277786;
	bh=Z/l4ZKAZUbvVdwx4CRIkWmAAJrHpspd0KbttdrUiQ8Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f3c4K2evBQ8r8yWQSiE5WteYLydGzm9uECzgk2qTrzu+ocl9dzVGFHcqf6tE1+cfz
	 cxmKegUaDa6eEsWXa54YO789xLkqj2qoue6xeHRFYUBvuvbdXhV9QV+TqVjDjevtbj
	 /JAbEjMoX8KwzBgLVlQfLUkTs/R5HyEnC8bEFy/mFj33hUhxfpWHeLRqgZmUUPCF7l
	 osQs42BRjyd3akGMfTyuj6WyXkDHpKrzfdPNbAxrT1sT+BeZVhbTONpE/EzqcAiOwS
	 UGl8FRd2dKFW3Aq2miGlnPc/CQdOqBuYKRlAAozLVbZ9vdCvYqBhYnfBWC3qrMEVuA
	 CrPFHdqrr1K2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 62EBA383B275;
	Fri, 11 Jul 2025 23:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sfc: falcon: refactor and document
 ef4_ethtool_get_rxfh_fields
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175227780812.2437895.2731074192480713527.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 23:50:08 +0000
References: <20250710173213.1638397-1-edward.cree@amd.com>
In-Reply-To: <20250710173213.1638397-1-edward.cree@amd.com>
To:  <edward.cree@amd.com>
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 ecree.xilinx@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Jul 2025 18:32:13 +0100 you wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> The code had some rather odd control flow inherited from when it was
>  shared with siena and ef10 before this driver was split out.
> Simplify that for easier reading.
> Also add a comment explaining why we return the values we do, since
>  some Falcon documents and datasheets confusingly mention the part
>  supporting 4-tuple UDP hashing.
> (I couldn't find any record of exactly what was "broken" about the
>  original Falcon A hash, I'm just trusting that falcon_init_rx_cfg()
>  had a good reason for not using it.)
> 
> [...]

Here is the summary with links:
  - [net-next] sfc: falcon: refactor and document ef4_ethtool_get_rxfh_fields
    https://git.kernel.org/netdev/net-next/c/4159a55f29e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



