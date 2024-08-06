Return-Path: <netdev+bounces-116247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71C794990E
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 22:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7049A286B0C
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 20:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72D316E861;
	Tue,  6 Aug 2024 20:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNUmJn/W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FD916DEA6
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 20:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976084; cv=none; b=jOqISK6jUkevqUxncCO1gCm+JIUjQWGC5DMRhN8f4H2tK9GGBwx69p2GF9bhfUn0AKTBKBGAlbUIpmVrxQOPUo1t0t4lwgj6tzvdxzujllV7KZuXzRlcSak8ARzEQjiHdBg4Hi6NRWx++Qg4eRuWot17E/+7Y+wRYkcdNaz+LsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976084; c=relaxed/simple;
	bh=ZDK2VIjGyasQEBAujexaEDG0pqWNc67yY+RUFkv9r8Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xo9D2vDEP4j/qEWQiUDmqmbGdQ/qQzV8hW3aScxJP9IdbP7nJ/CzPPsbY/WYekv6swzzgcfveYpe5JmU6U73JPBed3ZJ2ib+ts99ol80UPaSQNHm5Cm4SnNEtktHFyaubaKl1zi3l7qtnz/n58insfEakxoY1UCoOLso2liFB6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNUmJn/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34760C32786;
	Tue,  6 Aug 2024 20:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722976084;
	bh=ZDK2VIjGyasQEBAujexaEDG0pqWNc67yY+RUFkv9r8Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vNUmJn/WmTUY4BM5CUfu8ziqUcNTR6cHYb2qpCJk7Ha9S5wJetD5eVAGVc5jLaFJ9
	 3ZuMun5c6P3yLcl0xRmQjDxezEjVNBXsJ3Be6nD9c9M5QeodbUcaE4B8rTwgG7P3eH
	 buWU3A46BuWoCRqodME3tSZSmrCJpAVzKyO/vQ5LDnRzKk7TIDieEMMlyVHfMtMOEk
	 kqaBi+9SSkE3EyigXE8q21UHZFCEgsJrFhZgVcoFPqY6bqwOqFC3REIx2zx1dEiz87
	 /uoaIa3ya0iBCi56TFROSzc4jLzyO+1ZZFyHFxZJNRuh2z8RhYVqBwM04kyFFr5o/B
	 VPembsN1WEopg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F153824F34;
	Tue,  6 Aug 2024 20:28:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: airoha: honor reset return value in
 airoha_hw_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172297608275.1692635.2332592411478238343.git-patchwork-notify@kernel.org>
Date: Tue, 06 Aug 2024 20:28:02 +0000
References: <f49dc04a87653e0155f4fab3e3eb584785c8ad6a.1722699555.git.lorenzo@kernel.org>
In-Reply-To: <f49dc04a87653e0155f4fab3e3eb584785c8ad6a.1722699555.git.lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, sean.wang@mediatek.com,
 Mark-MC.Lee@mediatek.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, lorenzo.bianconi83@gmai.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  3 Aug 2024 17:50:50 +0200 you wrote:
> Take into account return value from reset_control_bulk_assert and
> reset_control_bulk_deassert routines in airoha_hw_init().
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/mediatek/airoha_eth.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net-next] net: airoha: honor reset return value in airoha_hw_init()
    https://git.kernel.org/netdev/net-next/c/63a796b4988c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



