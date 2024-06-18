Return-Path: <netdev+bounces-104297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5928C90C11A
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 03:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB380B21263
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 01:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32FA1CD3F;
	Tue, 18 Jun 2024 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKNqV2ig"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995561CD29;
	Tue, 18 Jun 2024 01:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718673031; cv=none; b=jhpXKnmqsRsPwG16ncxFIdhBIQkx5iXpYee21WhgpLktdItvZS/wHfNhU+RCww9mZ/lzpuwayIfgICCEuQLXJFUuPtOSRv3j28+8DFT2mv6TFcfJ9zGgEI2jSQ20id7TItL81Zzim/YCJTg+vu6dnudUMwTJfQyUIaayQjEe4fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718673031; c=relaxed/simple;
	bh=xHsznYbqkDWmLLh0WPB8c2toLHwqTrLGNRNxcwScrdE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RoSb5uIB4+ivX3sy2I3h3nK/tvuCrKiqUt1LtR07cgfohzsmL6tEO8YAJR+tf7ePGI8Azenkz2f9n2mnVAsNj6fotyIk9ohEtEzNfwXhaDqqwtKqr00O9wpLOdkOwOIII8iQvlfXtJl9yVYBFoPdDhOKofejW9N1HYFqlFw8nWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKNqV2ig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA32CC4DDEC;
	Tue, 18 Jun 2024 01:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718673030;
	bh=xHsznYbqkDWmLLh0WPB8c2toLHwqTrLGNRNxcwScrdE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WKNqV2iga9Rk+7Xye0GW/G5/Plexs5kpkpO5Ia0CJfSq5Z12964flAuq9ESC2K5zm
	 xGWOeSTXdD0yQLu/QEZNIggINZDEnAxYYAmPzZjErY2UDN/U5TGyU+PjO3Hy3r6qC/
	 2stf6zvIpXtyYa7OMc7d2vR9bBrfa416uN+JuIIvSP+d6dCkhxn8pbrxwOh32rFqFx
	 WttpwwgPg3vVbmAoPVqou6XtcyWMHp8am1UVZ18oFzQ18EMAtr7GDrIYJ/l6hqQeSu
	 I1YqUd5QHXgHgNqraXiKa+7zohFR0/4r/8h0emEGOwpfGygo91GYrqXkyAuRtoBvkh
	 EPdebcz5ZFrrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E01A4C4166F;
	Tue, 18 Jun 2024 01:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dwc-xlgmac: fix missing MODULE_DESCRIPTION() warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171867302991.10892.6137229238136764379.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jun 2024 01:10:29 +0000
References: <20240616-md-hexagon-drivers-net-ethernet-synopsys-v1-1-55852b60aef8@quicinc.com>
In-Reply-To: <20240616-md-hexagon-drivers-net-ethernet-synopsys-v1-1-55852b60aef8@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jose.Abreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 16 Jun 2024 13:01:48 -0700 you wrote:
> With ARCH=hexagon, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/synopsys/dwc-xlgmac.o
> 
> With most other ARCH settings the MODULE_DESCRIPTION() is provided by
> the macro invocation in dwc-xlgmac-pci.c. However, for hexagon, the
> PCI bus is not enabled, and hence CONFIG_DWC_XLGMAC_PCI is not set.
> As a result, dwc-xlgmac-pci.c is not compiled, and hence is not linked
> into dwc-xlgmac.o.
> 
> [...]

Here is the summary with links:
  - net: dwc-xlgmac: fix missing MODULE_DESCRIPTION() warning
    https://git.kernel.org/netdev/net-next/c/0d9bb144276e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



