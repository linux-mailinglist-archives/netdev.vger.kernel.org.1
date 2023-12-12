Return-Path: <netdev+bounces-56603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97A680F996
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 22:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDFAC1C20D50
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 21:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA26264152;
	Tue, 12 Dec 2023 21:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahltqe3G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF1F6414F
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 21:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BB30C433C9;
	Tue, 12 Dec 2023 21:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702417223;
	bh=W+a8QMxDJQ/wYzGPICirRFBKNDviDAgz3f9h+vYPOVs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ahltqe3GMajhJjOwZIMS9LnC1dVNv/CJeMj99NUsY5zFpeify4fEmCnVLrIz/WA5B
	 ilQQlRw/Xe8TI7WdIfHPQYAKP5rdzG8CH8Zs18AMs8DUMhnrS4bnzK+axx0d6JHBsg
	 u58Ih445lqMrBnj0Szjl72+txqphW594iZ6/u52lwWhtBpbgUt+Qyvc8k4FABBpyFv
	 CXS4fb2E4v6QkfsegyCYmh82PA9InOlT21aui99zGZZvOuamjqgVV1qMW+AvYcOYaF
	 iT47kGgYTzp4wxgJ0uhnno41Ypl/RSfVshxtyu47MgRsXCMNlD7MjJWpcWcqF820pc
	 q9eHw4EFsAN6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 233A6DD4EFE;
	Tue, 12 Dec 2023 21:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [v3] qed: Fix a potential use-after-free in
 qed_cxt_tables_alloc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170241722314.18097.10660076112019451693.git-patchwork-notify@kernel.org>
Date: Tue, 12 Dec 2023 21:40:23 +0000
References: <20231210045255.21383-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20231210045255.21383-1-dinghao.liu@zju.edu.cn>
To: Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc: aelior@marvell.com, manishc@marvell.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Yuval.Mintz@qlogic.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 10 Dec 2023 12:52:55 +0800 you wrote:
> qed_ilt_shadow_alloc() will call qed_ilt_shadow_free() to
> free p_hwfn->p_cxt_mngr->ilt_shadow on error. However,
> qed_cxt_tables_alloc() accesses the freed pointer on failure
> of qed_ilt_shadow_alloc() through calling qed_cxt_mngr_free(),
> which may lead to use-after-free. Fix this issue by setting
> p_mngr->ilt_shadow to NULL in qed_ilt_shadow_free().
> 
> [...]

Here is the summary with links:
  - [v3] qed: Fix a potential use-after-free in qed_cxt_tables_alloc
    https://git.kernel.org/netdev/net/c/b65d52ac9c08

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



