Return-Path: <netdev+bounces-241368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DF6C832F8
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 04:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43B0E4E2850
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 03:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E411F099C;
	Tue, 25 Nov 2025 03:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="homdYzWj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1844E1E9B35;
	Tue, 25 Nov 2025 03:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764040259; cv=none; b=jWU9cwY8bsSsRfgWb2HZyJhJsUOMT/YV/wyeaSc6VNvNMN+uUPJo/b1jZ5OMAnkHLEn7ddSlHKdNarAH/+cGyxU/dxBjhRWCndNVZQyK1wHoRKgtI1l/4DFlgpPUGhjSLWrBKqVyQiwnaLrmYd8kRMD/pRTKDKA/I2Z9iVFK65U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764040259; c=relaxed/simple;
	bh=9yTLMeCE6/5L2p8IaQYF/6/kfLa5biw61uFeneajF/I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nTfGkQdl+XrASef4IN3C8vnjRjplHTrKbd4gyPnlo+TJKR0/BZelVZPwH2NvS8lj2H9RAP75TEXB6c4+RwLuDR89cad2ra9S7+5QFsTVxWlodsVASt+fe8QYM2oyVB+ei/W55ueDLy508cxoQ/bsVD6WB39J7fxBHAchg48zSa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=homdYzWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A887CC4CEF1;
	Tue, 25 Nov 2025 03:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764040258;
	bh=9yTLMeCE6/5L2p8IaQYF/6/kfLa5biw61uFeneajF/I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=homdYzWj5mRV/DLvH/Nc3ngLqF6GCQDCG6QNksYomnbwFcp7ELKwgDC9pxF6Naz2y
	 GIdanGOEAXccbK5lVzhIGCyGZKuFMh7Tn0+lPY8CUIqZq5pKJYPWiQBwBPAnxmfCY2
	 wgsktSTw8ojQFdsHLHasJPdzt/fyukdnt48u95l+pt/RH2qkV/rfP7gEGWHhy4iAVs
	 xaz2+szqXWQ73mgVaZnmZznBwT2OVcks3BLJWaEwHIE1WHdefNK2W9SDUGva/GLd6q
	 E5KL7knNZ81RBoZxgu15J74FzMYmiybHjruL9p+XDKacrlNErrwyaKP431XuzeV90+
	 QH8q3/r2PNwJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF9B3A8A3CA;
	Tue, 25 Nov 2025 03:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] i40e: delete a stray tab
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176404022124.167368.5823229144968982813.git-patchwork-notify@kernel.org>
Date: Tue, 25 Nov 2025 03:10:21 +0000
References: <aSBqjtA8oF25G1OG@stanley.mountain>
In-Reply-To: <aSBqjtA8oF25G1OG@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: mheib@redhat.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Nov 2025 16:35:10 +0300 you wrote:
> This return statement is indented one tab too far.  Delete a tab.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] i40e: delete a stray tab
    https://git.kernel.org/netdev/net-next/c/ef0b78b5b6cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



