Return-Path: <netdev+bounces-55647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 266A980BCA7
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 20:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B58EE1F20F10
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 19:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8771BDF6;
	Sun, 10 Dec 2023 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIvC1+1r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028DE1B277;
	Sun, 10 Dec 2023 19:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FAD5C433C8;
	Sun, 10 Dec 2023 19:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702235424;
	bh=QFEYl2GTyzHL8G65W9eJVUzDQs+Qo+xNhychBgwOuYo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oIvC1+1r85XwLS2pRdluom39HUorF+6mdub69rN1BLGNJnrx6AC5crfMk0ANe14lE
	 PGSNqdRl7pa23j+EWBx8fPaoO5Oy0GrNaJC+GATP6L1l8K+rn0g4dQC/Bujz8rE+W6
	 QcRr//SRqJYnnJLTW4ADFTTJBTRF6/ql+KGXH866vfgnE6IduQzXfFm7GzzQE0UE6h
	 Z3b/DoI73uMOzURoP2BiKcZjyIK+Y4YMVj+F6rFOK0xB2U/wyp/eH/EEMvZ0GXgbKy
	 BEgzt1xEwtfMi4Mol3lbDIE+hDC6n6sIpG5jkZAv+eGR6hIAdXuPUOPMoEV1twaoRh
	 8PWtYEKDA5/qw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 557A5DD4F1D;
	Sun, 10 Dec 2023 19:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: mdio_bus: replace deprecated strncpy with strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170223542434.32670.6160588807079213491.git-patchwork-notify@kernel.org>
Date: Sun, 10 Dec 2023 19:10:24 +0000
References: <20231207-strncpy-drivers-net-phy-mdio_bus-c-v2-1-fbe941fff345@google.com>
In-Reply-To: <20231207-strncpy-drivers-net-phy-mdio_bus-c-v2-1-fbe941fff345@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 07 Dec 2023 21:57:50 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect mdiodev->modalias to be NUL-terminated based on its usage with
> strcmp():
> |       return strcmp(mdiodev->modalias, drv->name) == 0;
> 
> [...]

Here is the summary with links:
  - [v2] net: mdio_bus: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/1674110c0dd4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



