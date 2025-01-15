Return-Path: <netdev+bounces-158347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BC7A11749
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A661887FEB
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 02:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5227222E3EC;
	Wed, 15 Jan 2025 02:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/rE6Hmn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1613A6FB9;
	Wed, 15 Jan 2025 02:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736908212; cv=none; b=D80MN9abRL63e1GwfMlDQXV30Z2mWTssxSjk5iDv+FXWx1aYReWPZA2ISgoRhHqQROPaoTLuDUHjkneMOqjcGpYPx3JO4oMCYl2sr93gxZ927fBE/K4vu82icSoPrlJxBQIzTrfwhJ4eVOv48wuwRAQDXibSsdBpTL8B1IZOjBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736908212; c=relaxed/simple;
	bh=Q7A0YpeUrC0hDFqR4vOuwLwW+JeMM/zV7LZ0poaJsMA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CIxJtWYVBedEuYuj3J4HQVR+BhHgus1HVY0qtlEUo8NKX5T+z0GV30WtCmRvd8gkoaqfXGldUbgHNKGS6mxrtLhj+9DvTwv/aTGng3A3OmunZ7xqJ+UurVdDMC4OAuwnnTa2LsjiQc8R4T781hePb8uIR6dV0KTlauFzh+07kBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/rE6Hmn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F9FC4CEDD;
	Wed, 15 Jan 2025 02:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736908211;
	bh=Q7A0YpeUrC0hDFqR4vOuwLwW+JeMM/zV7LZ0poaJsMA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G/rE6Hmn6XkrJUkN4QMRj6buuAXlf9lTlRyQjqSW2EgAtzvnd8a9vc1ikR1JVUFap
	 5Zk/UMUiPGTyNAPrUmCE5SighaFkvlkFZND0WYt6nDFaomwINmI0+QapvIKfMc4mAk
	 cwlColhGIGMp+YOwCFd52/XzkoMuVsirJXdAD/AhZEJ0CuX9GaJsVrvQsPDtxgdoY+
	 bvxURUELMrxvqYQg4SgNckX8sLBOPDyub1wwAuPB4LFB/z4V8nYrGYT5kXln/aca2+
	 eOIEmUb+t7YIhTAiU3omAhL67nllTlPR2Ko2T35cqoUmAoJ/R+IzEPs2rt0QNb+b1U
	 GE1o89Cw2aMpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 72416380AA5F;
	Wed, 15 Jan 2025 02:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] net: ethernet: sunplus: Switch to ndo_eth_ioctl
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173690823428.226316.18021866243820868917.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jan 2025 02:30:34 +0000
References: <tencent_8CF8A72C708E96B9C7DC1AF96FEE19AF3D05@qq.com>
In-Reply-To: <tencent_8CF8A72C708E96B9C7DC1AF96FEE19AF3D05@qq.com>
To: XIE Zhibang <Yeking@red54.com>
Cc: kuba@kernel.org, Yeking@Red54.com, andrew+netdev@lunn.ch, arnd@arndb.de,
 davem@davemloft.net, edumazet@google.com, jgg@ziepe.ca,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 wellslutw@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Jan 2025 09:41:56 +0000 you wrote:
> From: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
> 
> The device ioctl handler no longer calls ndo_do_ioctl, but calls
> ndo_eth_ioctl to handle mii ioctls since commit a76053707dbf
> ("dev_ioctl: split out ndo_eth_ioctl"). However, sunplus still used
> ndo_do_ioctl when it was introduced. So switch to ndo_eth_ioctl. (found
> by code inspection)
> 
> [...]

Here is the summary with links:
  - [net,v5] net: ethernet: sunplus: Switch to ndo_eth_ioctl
    https://git.kernel.org/netdev/net-next/c/5b4c2fdf72f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



