Return-Path: <netdev+bounces-134005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF3E997A8D
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 04:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83707283EAD
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 02:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01F7186E52;
	Thu, 10 Oct 2024 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OodboFic"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DB1186607;
	Thu, 10 Oct 2024 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728527424; cv=none; b=Xvp4EO0wcV8yg+FrFUwK2Y+GgAn11xItmZbC/zIu4TaAW06pb4qImLk1mcbJl7fJgoXaQReDA+9bepnDtJHw8dJw7SdtYgESSiB62ZaYHpQuJ/JCWHEl/7kNGxj/8yKqNCsyYcxz0oj8SUidk/EFOK7CYVPfMTp1t3ddOcZAjHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728527424; c=relaxed/simple;
	bh=qQgHXchvEn6q2x0OsPxvnWYTVMQqjuTVlo/nmvWUcac=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PA94i2WPs3tpqUoxuhZYUbiW2vAEhyKQCm4rCkPmtgp0WxRmMalLc/qHUYZqGbTt81Fyn/Tw5QKChDgYIW9SLzDdhEifOC+LgM2PxRNK2Q+moxSsdIn0emf6lruXL9baI2J4KxPduX1G3fn9n2ZY/O2buOLdCtC3qUSYL9wekG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OodboFic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E29FC4CEC3;
	Thu, 10 Oct 2024 02:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728527424;
	bh=qQgHXchvEn6q2x0OsPxvnWYTVMQqjuTVlo/nmvWUcac=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OodboFicX22ykRXSpkjWDrv9vf6v+6NcBbFwkj/N6Yg2/+0U4UHE77RF0INRcqJhp
	 oqzJZ767wqwVky/fYqAUF0jWF5p/hDCuXV/ds33SYl8XSJ0DVwl4j9QegXme3sMbw7
	 9LIAkAG1v345aQ4q7Jq7oOz+eRPrziPPjoSJM7bfRnTKheCXMIHgObghIDlLrKVDTg
	 ZueqttGPlvdt/nzxA+D6sYKjfNqw/I7MC7OiuLVDWkUiRF156NVA3dM8LwhiF2S6uo
	 AFtakPhoZz5bX6fiThJJxzMu8Uf0c68Hpk9J+7N60KcezU3rUFt3caYJ6hSLNXzlYa
	 qe6AKgJKzaCvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2423806644;
	Thu, 10 Oct 2024 02:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net] net: ibm: emac: mal: add dcr_unmap to _remove
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172852742850.1542036.936862703910212990.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 02:30:28 +0000
References: <20241008233050.9422-1-rosenp@gmail.com>
In-Reply-To: <20241008233050.9422-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, quic_jjohnson@quicinc.com,
 leitao@debian.org, ansuelsmth@gmail.com, u.kleine-koenig@baylibre.com,
 david@gibson.dropbear.id.au, jeff@garzik.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Oct 2024 16:30:50 -0700 you wrote:
> It's done in probe so it should be done here.
> 
> Fixes: 1d3bb996 ("Device tree aware EMAC driver")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: Rebase and add proper fixes line.
>  drivers/net/ethernet/ibm/emac/mal.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [PATCHv2,net] net: ibm: emac: mal: add dcr_unmap to _remove
    https://git.kernel.org/netdev/net/c/080ddc22f3b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



