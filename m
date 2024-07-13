Return-Path: <netdev+bounces-111205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC599303C9
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 07:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1432E1C218E2
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 05:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ED617BCC;
	Sat, 13 Jul 2024 05:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yfzlfi+r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219211BDE6
	for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 05:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720848648; cv=none; b=Q3eCrEB9W5n8hQEelxuw2fUhZwLPkUFs9wN82N1/+EjB+4sjJWKgTfPaa4gWCQIgxZAeTKaZ14vm5aL6f2O1j5FhZl9ZyeN9FiKPFf3SC6D1wEzgCmmxhHxuZh8lppZ7+D4RNZC3WH6PWK+GaCVp4+ECANz5AGxjM3kVpLSp7xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720848648; c=relaxed/simple;
	bh=bOB5jrf23hY0MlsT2PEIV6ZRe8oizRM29Ex0B7mLbPE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RX/lR6KTzOR4/Wq6UyTEm3fasOFemyy2P51QWNM7jslLCVCIrNf9k/wipnY5VCZuH58wXbS+V8IomFPAX+ImIOSqxPUquykpFDP412SgeL5YffFiWRGd/sluDVPsfVevGKBkEQZsYCo4+ePXYQMMVBwbcAUq5UkgB6uXuVZhmzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yfzlfi+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99664C4AF0B;
	Sat, 13 Jul 2024 05:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720848647;
	bh=bOB5jrf23hY0MlsT2PEIV6ZRe8oizRM29Ex0B7mLbPE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yfzlfi+rVz+ENFmJ1BHOJScLPEwfdjhThOUkZiKY/Mm0zANAAlFp4h1V34vrKtn5k
	 ddi6H7UI1iVcot+hy/b5eI3NNMPOLSYHtvHf+6lKuclGJuPi4Mu6e+kSEdOsj6UjOP
	 22/Px38VFjjN2fvb15BQZu0o3dnIPo0/eqlf4tpsSOcKGRzswTZd5T1jJ4yC0++cRA
	 GvChx4jjYBEUDTP/WsvI4jPZuFy4jFdSKw6+gGzrgAUcKOyds98cN37+HOHmaalYQy
	 rpyzRQjPOrVD5oh1Sn6aCRHgNix0jBlBjM7xiq5UhdHXd9+LcK2BhHMKNWxITLT3cM
	 R2JPhLp++2rIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86677C43153;
	Sat, 13 Jul 2024 05:30:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/11] eth: bnxt: use the new RSS API
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172084864754.5566.6138152514581030541.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jul 2024 05:30:47 +0000
References: <20240711220713.283778-1-kuba@kernel.org>
In-Reply-To: <20240711220713.283778-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, ecree.xilinx@gmail.com, michael.chan@broadcom.com,
 horms@kernel.org, pavan.chebbi@broadcom.com, przemyslaw.kitszel@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jul 2024 15:07:02 -0700 you wrote:
> Convert bnxt from using the set_rxfh API to separate create/modify/remove
> callbacks.
> 
> Two small extensions to the core APIs are necessary:
>  - the ability to discard contexts if for some catastrophic reasons
>    device can no longer provide them;
>  - the ability to reserve space in the context for RSS table growth.
> 
> [...]

Here is the summary with links:
  - [net-next,01/11] net: ethtool: let drivers remove lost RSS contexts
    https://git.kernel.org/netdev/net-next/c/d69ba6bbaf1f
  - [net-next,02/11] net: ethtool: let drivers declare max size of RSS indir table and key
    https://git.kernel.org/netdev/net-next/c/28c8757a792b
  - [net-next,03/11] eth: bnxt: allow deleting RSS contexts when the device is down
    https://git.kernel.org/netdev/net-next/c/667ac333dbb7
  - [net-next,04/11] eth: bnxt: move from .set_rxfh to .create_rxfh_context and friends
    https://git.kernel.org/netdev/net-next/c/5c466b4d4e75
  - [net-next,05/11] eth: bnxt: remove rss_ctx_bmap
    https://git.kernel.org/netdev/net-next/c/1a49a23c034b
  - [net-next,06/11] eth: bnxt: depend on core cleaning up RSS contexts
    https://git.kernel.org/netdev/net-next/c/bf30162915f8
  - [net-next,07/11] eth: bnxt: use context priv for struct bnxt_rss_ctx
    https://git.kernel.org/netdev/net-next/c/63d4769cf74a
  - [net-next,08/11] eth: bnxt: use the RSS context XArray instead of the local list
    https://git.kernel.org/netdev/net-next/c/20c8ad72eb7f
  - [net-next,09/11] eth: bnxt: pad out the correct indirection table
    https://git.kernel.org/netdev/net-next/c/9c34c6c28c70
  - [net-next,10/11] eth: bnxt: bump the entry size in indir tables to u32
    https://git.kernel.org/netdev/net-next/c/73afb518af4a
  - [net-next,11/11] eth: bnxt: use the indir table from ethtool context
    https://git.kernel.org/netdev/net-next/c/46e457a454de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



