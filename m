Return-Path: <netdev+bounces-183585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB41AA9114E
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 03:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64E317789E
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 01:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7627B1D5CE3;
	Thu, 17 Apr 2025 01:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MigcF/7a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2611DB361;
	Thu, 17 Apr 2025 01:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744854024; cv=none; b=ptpATUefC2VVokD9RAerddNlriW2uCTkLGiaYE77BRBvINthSgcBC9cViARcZ3sLEhmuu8fDLcm4ZPijOFFiUSVvYMlohrJ8IEyKeXrWliHDcGD7y+mOqg4mn3HAlryH1wFPpWiKfd6qBTSC8nqa2xQHsZjKtfDsofPrw7XeVzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744854024; c=relaxed/simple;
	bh=cztZiDpfsZr3l33vjJAgeizZdQL/4UaLccm/8nepslM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZtTLmEWVBdBm3yAvPsydGFFGT0tr2PPGroJIownvhyuGa2gC+IyQVGPKlz97wtF4EDOD8lspgMyxoXAC4uU0Y/IpNLOD6D9x773qeaINeJRi4N5v/k2f0nwv8sRN0yXAaJjuUgopFioIvbvquZFhmq5oeQfsE8YsMC3WpjU+HdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MigcF/7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B67C4CEEA;
	Thu, 17 Apr 2025 01:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744854024;
	bh=cztZiDpfsZr3l33vjJAgeizZdQL/4UaLccm/8nepslM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MigcF/7aJQCrIsHzddKjo2XwZaelprnPXAG4ZxPYdmxMdeNhtfx69GnmK6dtMNaSB
	 FYSpw5+s1KzFUAdcpD4fjFnLtuZZny3yMDh+SulZCwpoenFIxHlCwX+4ni7lECBspK
	 jLeJmotULVMbP8vNO+8v+abWj+VEQc0DUkHa2nrGF6t2g+PgWfnPOPHTxXY1E/7a9N
	 O7KFVBzV5TVR+ebujbXtoMNTZ3RpJVEJCf/z2ZtNmIBhbgJA71NG9N/XxhD708/ycm
	 oUulLoCJug/BVSASyPzo6M6HZcSjmeZ6TvlDa0DG+VR0iqePC8ZigYIx2X/d6AmQ1k
	 dpvdaN/ZlKrdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70ACA3822D5A;
	Thu, 17 Apr 2025 01:41:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] docs: networking: clarify intended audience of
 netdevices.rst
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174485406199.3559972.16186023825764653103.git-patchwork-notify@kernel.org>
Date: Thu, 17 Apr 2025 01:41:01 +0000
References: <20250415172653.811147-1-kuba@kernel.org>
In-Reply-To: <20250415172653.811147-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 linux-doc@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Apr 2025 10:26:53 -0700 you wrote:
> The netdevices doc is dangerously broad. At least make it clear
> that it's intended for developers, not for users.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/networking/netdevices.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] docs: networking: clarify intended audience of netdevices.rst
    https://git.kernel.org/netdev/net-next/c/49593c298cf7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



