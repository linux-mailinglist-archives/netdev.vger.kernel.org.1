Return-Path: <netdev+bounces-198827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FA3ADDF67
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 01:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D9417E17D
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 23:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670DF2957A9;
	Tue, 17 Jun 2025 23:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaP3PGJy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCA7295531
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 23:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750201804; cv=none; b=h5F6f9xUi4yZ1Mxve4psQRHOWo1FESBS+NtWDgiVhEvNXM/PfyXyrA/gUA1kw7HGgOInEd8v9GmKF4+lSbr2zg3nlyASblTkvvNxQJpmmfXVJ7GJ79j9ABb2LR7tMcJ+nXDo++ZEmLkOCkECLLK4zX/SjonysjqRC/JxiEChlP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750201804; c=relaxed/simple;
	bh=hf6VGmJN2wcWRSTg/+Ju/5u6ux48QGSCU3Q746i96qQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=APmaw/jE9gL+35p7hVqBzR6xSq46jmPlQB3JXbMy7htuT3E7r54xtlJW42qr1W2DvY00SfURghi5Knunx64MYfsXhNWfXduHpVZUEmVAq8bBBIH7PB32iPCeY5Qu3Te9Nck/5dojTILMB4EATV2vEFMTeWfGImdUyXqvXPBOeXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaP3PGJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7DFC4CEE3;
	Tue, 17 Jun 2025 23:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750201803;
	bh=hf6VGmJN2wcWRSTg/+Ju/5u6ux48QGSCU3Q746i96qQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QaP3PGJyTpwnrEV1VfjoFWuTKzkxQ5OqxB5CNFjVDyC2L4Q2yC04sBMIVZfan2Aa9
	 4zVzX3J7k14yOI45ANLo8Z3FSv9nQ7sx6zg93vuhgs0WKuEN/rrUT5iZBcj15au7uo
	 WAAL03Js81dytrDsala75lQaZvifVoHwIu12JOIkWN47I2lFeEWnSrUMWG2kd+hxoa
	 H7xDrhexgTZu/LnAkzq+oV0hMbOAOjHyU/pb6KG7DDIX6tzcmYxZ1Njv1rBHnSPcd1
	 ZfMP9eFPkzMx6FZiCzsVhvOTs1G5gPE9yG1B9n5Hbo629EYvv/3/IAS88uTdtFq6Lx
	 K3ks7VZGZBfEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DC738111DD;
	Tue, 17 Jun 2025 23:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] bnxt_en: Bug fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175020183225.3730251.406729643354262674.git-patchwork-notify@kernel.org>
Date: Tue, 17 Jun 2025 23:10:32 +0000
References: <20250613231841.377988-1-michael.chan@broadcom.com>
In-Reply-To: <20250613231841.377988-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Jun 2025 16:18:38 -0700 you wrote:
> Thie first patch fixes a crash during PCIe AER when the bnxt_re RoCE
> driver is loaded.  The second patch is a refactor patch needed by
> patch 3.  Patch 3 fixes a packet drop issue if queue restart is done
> on a ring belonging to a non-default RSS context.  Patch 2 and 3 are
> version 2 that has addressed the v1 issue by reducing the scope of
> the traffic disruptions:
> 
> [...]

Here is the summary with links:
  - [net,1/3] bnxt_en: Fix double invocation of bnxt_ulp_stop()/bnxt_ulp_start()
    https://git.kernel.org/netdev/net/c/1e9ac33fa271
  - [net,2/3] bnxt_en: Add a helper function to configure MRU and RSS
    https://git.kernel.org/netdev/net/c/e11baaea94e2
  - [net,3/3] bnxt_en: Update MRU and RSS table of RSS contexts on queue reset
    https://git.kernel.org/netdev/net/c/5dacc94c6fe6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



