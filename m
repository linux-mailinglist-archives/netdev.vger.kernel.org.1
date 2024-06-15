Return-Path: <netdev+bounces-103761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 691ED909591
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 04:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F2E284AB5
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 02:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1203479F5;
	Sat, 15 Jun 2024 02:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQdXYsOz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE95F173;
	Sat, 15 Jun 2024 02:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718417435; cv=none; b=qKNPgdDHFXLa9wQT4PuIpRS3bPz0zSIepISAEyaYOznVJ19O/B7YbxuMd9a1/7BAGfPke0BDhofB/28S+1ZO69ME4u7ZLdc36T5y7PwASzIkYjvZySAov/bYdIzM2peOZsP6nziTEhZC58HLEiUkC7W5LADegnClUwPx+iZ2Qow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718417435; c=relaxed/simple;
	bh=GCWmK2mdjXrPgBNPEyFvcbzSuRZtsonLQhm18KyHfGo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j4RjFpVVf7x9hBeo+kpp8BnOpCNljOR4BpF4qABuPQmEJPdTNw4E8t/YSUGo4wkgSNVtmFysU2Nw02+581vJQAjX3R/xxhHx/2kfQlRXkcVCBjfv6SpciQL7unjhLKa9a0k/B4SetVJ6vqHnYmCkBe2qpGUCL4Wma+7GnOv+YSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQdXYsOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 900BCC4AF48;
	Sat, 15 Jun 2024 02:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718417434;
	bh=GCWmK2mdjXrPgBNPEyFvcbzSuRZtsonLQhm18KyHfGo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jQdXYsOzn1dl6F9031mpQy4zKonqcp0dKV9Go9XNgiDq0V9DMoxNBmZ9XTD7V9GoP
	 P468TSd1eamaXg6xMx3G+NnGVNl333hgu+VxOeYQk67bE+N7VjkUntuHYXDMO7Xg3l
	 QC3BZKAdnfx6P8UNs8driUksLmM+BVNIrxPpU+o+t9padi9gbsXMfgyZTo7trGzaOq
	 QBFvHnyUUMm8oVYv52Ga6rvg3gX43dC+AZ/WZvSbcjWuqHXmlnQUm51O6kxNmL8EtS
	 ZdJUzwbMW8HmNAuDc+U7LVzuUm7KckRWHwhcBRfPFyQRnfkNCwbDY6WCfWE9Cwhi+u
	 6qfcCJpnLNXoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71966C43616;
	Sat, 15 Jun 2024 02:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] atm: clean up a put_user() calls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171841743446.11975.10416200680014723985.git-patchwork-notify@kernel.org>
Date: Sat, 15 Jun 2024 02:10:34 +0000
References: <04a018e8-7433-4f67-8ddd-9357a0114f87@moroto.mountain>
In-Reply-To: <04a018e8-7433-4f67-8ddd-9357a0114f87@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, v4bel@theori.io, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Jun 2024 21:21:42 +0300 you wrote:
> Unlike copy_from_user(), put_user() and get_user() return -EFAULT on
> error.  Use the error code directly instead of setting it.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  net/atm/ioctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] atm: clean up a put_user() calls
    https://git.kernel.org/netdev/net-next/c/afc5625e2097

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



