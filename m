Return-Path: <netdev+bounces-218845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D83EB3ED13
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 19:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09E4B17B257
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 17:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C4632ED37;
	Mon,  1 Sep 2025 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnQ6Ymvk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C960C3064BB;
	Mon,  1 Sep 2025 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756746498; cv=none; b=hrsmZ2t/DEv/d+lwBPnvhEKa3bKZpYcUQshaowIoq+yJF7G6PBCkSZoMVonKiMTDO3XbQnMak5k7sSp3HI2sjqDah3k5mjBsowar5L+6cKQehQCcLtosahCRTExNFQvKdC718y6zapsd3ZxjyzHggwxMYSMTaDY8xu9Un6vY/Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756746498; c=relaxed/simple;
	bh=Psu+Ha7+6rvVuekjLBry2gD+q3T4H2+4ZpElYNdlzaY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hA2hhM5nkKRhp8DMMBzDPX6s1sGuqxMlcIA3OyqCxa5jaBueaR/jdyapnsitPEII8UqrCDlQiY8qjCj1euRalzdPQPMjESeTa0YfCti+xrIpGW/djqaQ6s/LvOvQQu4kfqg939fL/0JBgoJ5o318piQy9Fz8NBjq1Ael/ohzC3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnQ6Ymvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE21EC4CEF0;
	Mon,  1 Sep 2025 17:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756746498;
	bh=Psu+Ha7+6rvVuekjLBry2gD+q3T4H2+4ZpElYNdlzaY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FnQ6YmvkM+qxK3POl6Iw+D/ge1mC3CpLAudD5A5iIfqsu/47FZTZuboiRzkVCGdqT
	 e2h4dDGcIJvltoeVVWErE0qmZhjvscnprvveJItdURwYcee+RC+KlitBe1reT5IGad
	 uNjD2zZuyqUYWgCv0g4FReQ529CZxP0AYSOgiK9d0CW606W3HdqWZDe4kczVDBOjnL
	 NMA3WAi98aJKiKzgEF5ZMDuDWxt3dIRYgkaEVMZDDzVmfqQo9R6kXheQ+7VbAt8oaf
	 aUuhg2Ngyn8rbBtl5PkY5ta6IEbAW8Ai0vjMFB+izJbwSbh0hwEaAfWbZxClTUxN0H
	 hqssXOUbXSTjw==
From: Vinod Koul <vkoul@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Josua Mayer <josua@solid-run.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 Jon Nettleton <jon@solid-run.com>, netdev@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250826-lynx-28g-nullptr-v1-1-e4de0098f822@solid-run.com>
References: <20250826-lynx-28g-nullptr-v1-1-e4de0098f822@solid-run.com>
Subject: Re: [PATCH] phy: lynx-28g: check return value when calling
 lynx_28g_pll_get
Message-Id: <175674649543.186496.4663580683926892498.b4-ty@kernel.org>
Date: Mon, 01 Sep 2025 22:38:15 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 26 Aug 2025 20:32:03 +0200, Josua Mayer wrote:
> The lynx_28g_pll_get function may return NULL when called with an
> unsupported submode argument.
> 
> This function is only called from the lynx_28g_lane_set_{10gbaser,sgmii}
> functions, and lynx_28g_set_mode checks available modes before setting a
> protocol.
> 
> [...]

Applied, thanks!

[1/1] phy: lynx-28g: check return value when calling lynx_28g_pll_get
      commit: 9bef84d30f1f724191270044a7d045bfc9d6ad97

Best regards,
-- 
~Vinod



