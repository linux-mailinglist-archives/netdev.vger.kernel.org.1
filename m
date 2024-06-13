Return-Path: <netdev+bounces-103054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08D690617B
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 04:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE1628362F
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 02:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963F7288A4;
	Thu, 13 Jun 2024 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flf80hdQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6474A182D2;
	Thu, 13 Jun 2024 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718244031; cv=none; b=LVCP15lg/q6q1qFJ+z3FUJLwiZ+jrBA42WmOJ75lv2D9kaWtfB9AV0nkMLrgB9iOa7nqQXwZvZyjXuKGMwgf3P7a4HH/4VWXozhy5d31ZOX4mohc3raoaJuG97cX43Dh8XYCdQ3h88iOaVwsvhtwqWkBIvre5PF9+2RbTkC6x8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718244031; c=relaxed/simple;
	bh=AHORsZ2XbgOLg/SYaRcgeXCqV/NnLh27EdS+OTnGA3M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qI03QRgRQgccimwySs94Kj9wAECL1hKhSBn9lrirmHmtCBd0eM2+dOSwg+ybBHuBz1PEnnK4zZsdVGLn8Xx3wznkU309i6iGBlMzXEqETvNbfQmd0snaN0bekAoQ1WC7kCe7tQkbVbhc/jxoG0zEVeRha9oShItWEK3XYhk4AXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flf80hdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E56D0C4AF60;
	Thu, 13 Jun 2024 02:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718244030;
	bh=AHORsZ2XbgOLg/SYaRcgeXCqV/NnLh27EdS+OTnGA3M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=flf80hdQwhhRq1NT1/OwAzpRtabI/tyjvdHQtfW+PAiXlPXRjCSpDu4WkwoDA+3kz
	 tFhfGiRJahlrPOHel0WMcWwKHNhXb9jK1DWqqpbJCbFb1QHlwsr1dg12wxCtGPa/L+
	 Wrmf1bYFONOfA25xWr5kRNPT6htyWhlp5hBrr3QHlMhPWtu09pHd81UwuTyOG4lbkb
	 Nc9i7o+ZozUHHWkXtNzURSpId9yLYS6mUG0/kKhYsZTF1sj0P6HFVERfIAy7LxA821
	 P31bTE11v414xgxopH8ZrycV94P8+BoLyOGDfKOAxnSn8LgikWf3xsB4WyFI4KfPHV
	 Rna+EoTr/LwMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DCD14C43616;
	Thu, 13 Jun 2024 02:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] CDC-NCM: add support for Apple's private interface
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171824403090.29575.17232138329645868339.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jun 2024 02:00:30 +0000
References: <20240607074117.31322-1-oleavr@frida.re>
In-Reply-To: <20240607074117.31322-1-oleavr@frida.re>
To: =?utf-8?b?T2xlIEFuZHLDqSBWYWRsYSBSYXZuw6VzIDxvbGVhdnJAZnJpZGEucmU+?=@codeaurora.org
Cc: linux-usb@vger.kernel.org, havard@hsorbo.no, oliver@neukum.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Jun 2024 09:40:17 +0200 you wrote:
> Available on iOS/iPadOS >= 17, where this new interface is used by
> developer tools using the new RemoteXPC protocol.
> 
> This private interface lacks a status endpoint, presumably because there
> isn't a physical cable that can be unplugged, nor any speed changes to
> be notified about.
> 
> [...]

Here is the summary with links:
  - CDC-NCM: add support for Apple's private interface
    https://git.kernel.org/netdev/net-next/c/3ec8d7572a69

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



