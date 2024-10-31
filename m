Return-Path: <netdev+bounces-140754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8059B7D7A
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 16:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9941C210ED
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 15:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD9F19D88D;
	Thu, 31 Oct 2024 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYXlmhIi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F04196C6C;
	Thu, 31 Oct 2024 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730386831; cv=none; b=ZYVWXYMhW6+H09YMHhWj6FEZs1RZpr5M3yiGOR9P1HKrz+MWFWM24QZI0QQoloA785WvO/D+ngI9PhBSaW7R/LxZBpsng+q8xgCks9HcxhGRGqnEvJBkvPGcUq1rmNP0JPkyQh7dTHJ/rb2aP1S6jQewEX3FISnH1xASEfTWoA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730386831; c=relaxed/simple;
	bh=6aYTYpn8XYvD5hJGD3rYwwoC1Zt77qYWC4sWsNJymlw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QXDVQytBp93j8zofw3+uWrZdZQO/+WdvLWZaXb4NwDe4Kns6nKYbBEFl8Gao3ZFpvKFB5ZjKZouWzczjIuW44CQDgBypLphIJqOGvvTjJxHBWMRxgw3LO4KwZ6NFQxppg3L5wCzdOyVogHQrfPFMoyKfL8uaGe1ivjNKQFb7VEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYXlmhIi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F3EC4FF7B;
	Thu, 31 Oct 2024 15:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730386831;
	bh=6aYTYpn8XYvD5hJGD3rYwwoC1Zt77qYWC4sWsNJymlw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GYXlmhIitpA3Q1L9Yb5sY6LXMLNiQFfzOdP8QYt65rMJfXFBN/yOBgz4ZW0Eb0v1t
	 KxReS+q2hHQxUWI4f6UMOGVwnHMTNUMPEfcjEwzu+dBHJzGdLO1nUxQeP1f7TtHWm4
	 AbrBORmetYyssxt2VVDU6P1t6YAdINPqBZLdRXxDqJ+Eh+uyF/WmdlEFqP6Ej/t+pC
	 BXbQrmwwxhEbWy7S/6jBaa+ziGgr1lK2Ulrd++2cbo91agKAUyIeVl7AMEuxcSbqkE
	 rIWYyXmeZyZiHeWytosIIWPEv3g9LlCRHFceNnuSPG+CB9iRyv+LvGVlt7sun/mu9C
	 3wZ9f3RHp3H3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E40380AC0A;
	Thu, 31 Oct 2024 15:00:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: dp83822: Configure RMII mode on DP83825
 devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173038683927.1988442.18235112192893672854.git-patchwork-notify@kernel.org>
Date: Thu, 31 Oct 2024 15:00:39 +0000
References: <aa62d081804f44b5af0e8de2372ae6bfe1affd34.camel@iris-sensing.com>
In-Reply-To: <aa62d081804f44b5af0e8de2372ae6bfe1affd34.camel@iris-sensing.com>
To: Erik Schumacher <erik.schumacher@iris-sensing.com>
Cc: hkallweit1@gmail.com, andrew@lunn.ch, linux@armlinux.org.uk,
 davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 kuba@kernel.org, edumazet@google.com, jeremie.dautheribes@bootlin.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 24 Oct 2024 13:24:23 +0000 you wrote:
> Like the DP83826, the DP83825 can also be configured as an RMII master or
> slave via a control register. The existing function responsible for this
> configuration is renamed to a general dp8382x function. The DP83825 only
> supports RMII so nothing more needs to be configured.
> 
> With this change, the dp83822_driver list is reorganized according to the
> device name.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: dp83822: Configure RMII mode on DP83825 devices
    https://git.kernel.org/netdev/net-next/c/9e114ec80840

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



