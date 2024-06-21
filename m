Return-Path: <netdev+bounces-105650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD3191226D
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 12:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1351F22555
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E5616D4CA;
	Fri, 21 Jun 2024 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCDzunaT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289EC82D72;
	Fri, 21 Jun 2024 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718965828; cv=none; b=U+3jWhDdXV0kPDVLHuKDi66YGc7JyIPegBRXfBGRlG0MVqVvGo0rnpOnpkYvFDzvz24o60E3yGQXuKJC8kw1GHEQ4Au69niS3sG/6xvfY06NmX2XYxYst9Gn7FiBQ+Bkacu0a4nKs8lCd7DCvCg5ggG3zNZ1laqDMi7p0b9s4Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718965828; c=relaxed/simple;
	bh=B752BNIYio6k0ixN7OxVpVPWptHW5T/k1iw9vIoklR0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E5sqwN0P5vgh1h/U056I3kHLw7ysp6nTRT/h6tXQpTn3J2LWiO+jKDptwsGPefLsqu+qJrmLpzBBsEJG3uzrSHCnp/RJoWzU73Cu4H03Bl3J2nI2Y4QJAdFI6rgqDIsG0FKQKmVFH9HTBRVJJN6Yggr3jtVdzpRLI1tpfA5JAdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCDzunaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1F2AC4AF0A;
	Fri, 21 Jun 2024 10:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718965827;
	bh=B752BNIYio6k0ixN7OxVpVPWptHW5T/k1iw9vIoklR0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rCDzunaTmNxMHxYirml77GfBiWvjELwFaBc7UIpvWpiGvbP32Zrl/tkEkN4uN2nB9
	 hXKpkuQwCFn8w1dirs0nr72fijIDDTUHFWfkFsJUEl/8MnEbP8aX9IW+D5aJsEZ0Vm
	 OBJC3DZvv/TFiS+nSAYgzanxQRpMNfW8Zi7zJXAEmLEBIkQCMntLyjxCZQaHLSYZso
	 I4sjwr4ZCK+bLZwkRrXVLVtf4Q9ig34MSPmycuaMD1ttq5vGoy/MJ7LN03Zzq3bHVr
	 d78Nw49PsJxrkSYL1FndsynlgyXRebbcErhJoR5U/MEaJXEOUPyaVKQwDv4Qr2/B55
	 os3HFuLD74nbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C286BC4332D;
	Fri, 21 Jun 2024 10:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v0] net: mvpp2: fill-in dev_port attribute
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171896582779.421.10046577492424882330.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 10:30:27 +0000
References: <20240620041202.3306780-1-aryan.srivastava@alliedtelesis.co.nz>
In-Reply-To: <20240620041202.3306780-1-aryan.srivastava@alliedtelesis.co.nz>
To: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Cc: kuba@kernel.org, marcin.s.wojtas@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 20 Jun 2024 16:12:02 +1200 you wrote:
> Fill this in so user-space can identify multiple ports on the same CP
> unit.
> 
> Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
> ---
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [v0] net: mvpp2: fill-in dev_port attribute
    https://git.kernel.org/netdev/net/c/00418d5530ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



