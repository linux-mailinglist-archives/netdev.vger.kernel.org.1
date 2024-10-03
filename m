Return-Path: <netdev+bounces-131543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FDF98ECD7
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50966B215E9
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 10:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1C21487DD;
	Thu,  3 Oct 2024 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoFB43Jk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2052B1B969;
	Thu,  3 Oct 2024 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727950829; cv=none; b=KppMvtFiaKfEk3Z2b5mpQVIdyo+Plv8MMhzHsoy9bPpO4cBK2YcjoGDD/OuXPR2DKNL1TWjH5ufQYRbgs4CQgP7BMNweXYDQU457YmQgMNRCx00TbXgnLKAmwxXasqo84RCGB1rHhGij1sO9qSqjVR2J3vGrBe8KTd65/wbSnvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727950829; c=relaxed/simple;
	bh=b6xfIy6LocaTgiQynoJhq7HsQBAFM3ayKFMNhQRjhyE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Go1wsga9OxPO9QtBJJ7E9fWlThjIi8wsgmPj58gEpHe2TONjs1Eq1SM+X4Y4INoBXsk4WRuZeKmPD939JFfN4OICgMST+EhXgh+IY7P7PrAlpWmWWVz1QrRopiSCaHoslI4Z2DLQPsnlu4aPHStQcOYYWcy9W8EeLWBK2FAX0BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoFB43Jk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC055C4CEC5;
	Thu,  3 Oct 2024 10:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727950828;
	bh=b6xfIy6LocaTgiQynoJhq7HsQBAFM3ayKFMNhQRjhyE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hoFB43JkYr+4j4XxQG4ODJPooL/GVRJdU0P5GAB5BtBfm7zP5iEkZ5cTMrii7s8FS
	 inF5hjGxU29X2uKurzzr5+LNtwPZF1Ik2i1nHA62H6Ol2N6L7EfI9FeMVFHLaBSmxu
	 YuwP2gc8EJBITqraW5rrwjNc58WpL6VDfGadEtF146rxTipFnQp07mwdR1m/Mzxa+l
	 Z93iUGFyur0PaPlDcMjADSofbt/teyVhLbNp/Xu5DuJpm6c4SSnFz4JPn+xlgpaI4/
	 jG4H5x0aTR5l05has+7fbwUzj9n/rixRJRDejwNwacpV1z33hHDhlfMuE3LZZN7UIx
	 KebymvNmTRz7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 72FC13803263;
	Thu,  3 Oct 2024 10:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] doc: net: napi: Update documentation for
 napi_schedule_irqoff
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172795083227.1807590.449747881502540277.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 10:20:32 +0000
References: <20240930153955.971657-1-sean.anderson@linux.dev>
In-Reply-To: <20240930153955.971657-1-sean.anderson@linux.dev>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, bigeasy@linutronix.de,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net,
 bcreeley@amd.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 30 Sep 2024 11:39:54 -0400 you wrote:
> Since commit 8380c81d5c4f ("net: Treat __napi_schedule_irqoff() as
> __napi_schedule() on PREEMPT_RT"), napi_schedule_irqoff will do the
> right thing if IRQs are threaded. Therefore, there is no need to use
> IRQF_NO_THREAD.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> 
> [...]

Here is the summary with links:
  - [net] doc: net: napi: Update documentation for napi_schedule_irqoff
    https://git.kernel.org/netdev/net/c/b63ad06ddddf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



