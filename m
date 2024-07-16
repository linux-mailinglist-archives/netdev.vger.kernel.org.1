Return-Path: <netdev+bounces-111787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9149E9329D0
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 17:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15EE8B2163A
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 15:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2702819DF78;
	Tue, 16 Jul 2024 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6Sj+5TW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3911E889;
	Tue, 16 Jul 2024 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721142033; cv=none; b=QlhbuOZpo/ryjcKHO7Xlg4XDP0+00+r9YZXjl+8jA7iuQjVvi+CYGihvDyEaFxztBSk3KalyAND29Mwj56/v8ndf0Jd/zx7OLdpqK63ANB6dNxiovcogp2uTiPHPWdYE7Q0/ICRR65T85kodBLd92SJanA0yZTch0JKmna7URcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721142033; c=relaxed/simple;
	bh=qhkMF8KQIgDpGs8uEfEZIOOfX/MKKHV0oErPGRa35hk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OkcNcYSVd9VdYaWbyhoIYtX5shFQqKiHXtSUz06a1V7ovF74zZgoBsiZ6ytYuFTB6cGtTKYVvuQtpU4WWpqRZ2K5625hg6rs5nzpVPsbBs1gVaveKpsUMgyn5TZnAU02AoxaUBe7ssKMaGRIBbcdMfZ+ZehNsveh+b9bq4BLPUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6Sj+5TW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72973C4AF0E;
	Tue, 16 Jul 2024 15:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721142032;
	bh=qhkMF8KQIgDpGs8uEfEZIOOfX/MKKHV0oErPGRa35hk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f6Sj+5TWpgs4WeJid8ixrMdJdSX9UApFDlTCmkN3s+Av97Er0Y0bZYukzm6OZHRQ5
	 Djt3mhoyx7O2qwy8QTKmbWksXanjZ1ChimZxxTecvvbusozV6usAq6nlmFJx9vvYcH
	 I/WJ9d6mhULKblX74n5afqBSvihqdg+Ff3xXMP1G9y6rjWjdxn8EvViZBFmD7chBVV
	 y93zBp6xH2zJ/cRefVLhVY4/yuZkULQ2TnoxQZaI1Jg+sXRuQpTdusBxGSmOiRCsOK
	 DaIaSB/8f4piYbKkGfYklTasHPiLupUevyyJQWedLoNDJJPTQA1FVKzSDaUrvdT7oq
	 kFWuvegQBI1oA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5C2A0C4332E;
	Tue, 16 Jul 2024 15:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] eth: fbnic: Fix spelling mistake "tiggerring" ->
 "triggering"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172114203237.4794.14903597720826350692.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jul 2024 15:00:32 +0000
References: <20240716093851.1003131-1-colin.i.king@gmail.com>
In-Reply-To: <20240716093851.1003131-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Jul 2024 10:38:51 +0100 you wrote:
> There is a spelling mistake in a netdev_warn message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [next] eth: fbnic: Fix spelling mistake "tiggerring" -> "triggering"
    https://git.kernel.org/netdev/net-next/c/77ae5e5b0072

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



