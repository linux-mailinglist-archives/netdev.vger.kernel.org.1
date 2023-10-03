Return-Path: <netdev+bounces-37711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAE37B6B3D
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 16:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 63994281699
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 14:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8757731A68;
	Tue,  3 Oct 2023 14:20:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E8A2940B
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 14:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E83E7C433CA;
	Tue,  3 Oct 2023 14:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696342825;
	bh=C1PjOzaL6zGFv+xuvVXZQ13drp+ZYgssUutzpbcy2Ak=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E/88OPYA3oZRLgnKZRERHOlLix5vAteTZXojrXTtyNsTNmKYsqQoYvdc2QcSIXnkf
	 I48CMArszW0e82A01Z/Rf/mcs4B/IVuSTjEigA2OZMpDWWL6Y8u7L/F9vCrFdYhQLV
	 k4XrdQwSCKHvcz19dKsefaFwxBsfTYHw4r02SpiROVTaVPTvXZ5u+XIJCJVBbc3qC6
	 xAnChi5Qwv8dlcMx7HVamAdiMRLbeqltLqLfvsxKNu4YhOisU2ixwZbtsa+/GdKJ8Q
	 onW+W6fkXa1iUBGPDf2xBs4GvMqdfj+N9W1hgmCn/KIxbM0zyHEYNG2gFa+cr3foWk
	 IvqctveWokijQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C95DEE632D1;
	Tue,  3 Oct 2023 14:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: microchip: sparx5: clean up error checking in
 vcap_show_admin()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169634282481.20237.11023023965900224021.git-patchwork-notify@kernel.org>
Date: Tue, 03 Oct 2023 14:20:24 +0000
References: <b88eba86-9488-4749-a896-7c7050132e7b@moroto.mountain>
In-Reply-To: <b88eba86-9488-4749-a896-7c7050132e7b@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: lars.povlsen@microchip.com, horatiu.vultur@microchip.com,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 UNGLinuxDriver@microchip.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 8 Sep 2023 10:03:37 +0300 you wrote:
> The vcap_decode_rule() never returns NULL.  There is no need to check
> for that.  This code assumes that if it did return NULL we should
> end abruptly and return success.  It is confusing.  Fix the check to
> just be if (IS_ERR()) instead of if (IS_ERR_OR_NULL()).
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202309070831.hTvj9ekP-lkp@intel.com/
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: microchip: sparx5: clean up error checking in vcap_show_admin()
    https://git.kernel.org/netdev/net-next/c/788f63c4dc17

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



