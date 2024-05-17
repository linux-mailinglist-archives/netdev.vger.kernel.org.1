Return-Path: <netdev+bounces-96836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B6B8C7FF9
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 04:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 743CC282DC9
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 02:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465318F62;
	Fri, 17 May 2024 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbCl65c8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1D78BEC;
	Fri, 17 May 2024 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715913631; cv=none; b=pZ9vms7F6xSQ8wxF1lIMr6Cj9nwiyhZ6F6VBDneNJXijnyJmdPXT3cXgN5wh4ILfffMqijKEQHVMZ6iwN+rQjSlckj2XXpgklpFvB/SztFBRwupnoIPxCPCqfaD9WlRBtdEAl2IeSlwXvDpMEkYyUuaO4worB9yH6aO2Lw1GNuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715913631; c=relaxed/simple;
	bh=VCrb7UnnkO5S0CtIrGnADeHi98LkHpUqkncSHeHWXI4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lDney9GBjBBSIBZAJKCxilB+MhuHp20tgtU3Xh/w4wXYQIMSuPPLIGOvqMCnEznMIfFCHfcbr0UY8y6px21L85bFRPZ3z79l+VdhVIO2Qiko85oLKWPcAkxfsOqyLpu8KlgYcPD++codMJAeBw51H2UlFtd4ljeSoLtnB7BDQ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbCl65c8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE3ADC2BD11;
	Fri, 17 May 2024 02:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715913630;
	bh=VCrb7UnnkO5S0CtIrGnADeHi98LkHpUqkncSHeHWXI4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lbCl65c8KF+k0SbNnpm9D9nhd+IUxfzDEBknfJhvFIYBxUPyxLLVXXNy0Pg1B53o6
	 IzwydIAjR+XGs0/3jQ62sVcyu6qHkK4k1SGWUNRa4U5V8zHo6i7l04xqjEDiNXglBq
	 4i0q15zEmdxxVHUaGCaNaXF0YMEgkk906VUz2Moyj5c7KNtlUH+sLaa7DN3xBu2MTh
	 EpQJbyloBD0gqF9Fxe9LFT+ZcADd6j6PodoLr1Z6IdQbVljHbAOILQXA+Lo9ziMUhv
	 gJ/3u0lYCpVhqYjYaUQ2L89Bq/IVKhUXeky42Dv+se+TCaDfJnWmFYCcrsIPhpu/+r
	 NafwWAmQUdhEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A18D7C54BDA;
	Fri, 17 May 2024 02:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] idpf: don't skip over ethtool tcp-data-split setting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171591363065.2697.11756234770145638064.git-patchwork-notify@kernel.org>
Date: Fri, 17 May 2024 02:40:30 +0000
References: <20240515092414.158079-1-mschmidt@redhat.com>
In-Reply-To: <20240515092414.158079-1-mschmidt@redhat.com>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 przemyslaw.kitszel@intel.com, michal.kubiak@intel.com,
 aleksander.lobakin@intel.com, xudu@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 May 2024 11:24:14 +0200 you wrote:
> Disabling tcp-data-split on idpf silently fails:
>   # ethtool -G $NETDEV tcp-data-split off
>   # ethtool -g $NETDEV | grep 'TCP data split'
>   TCP data split:        on
> 
> But it works if you also change 'tx' or 'rx':
>   # ethtool -G $NETDEV tcp-data-split off tx 256
>   # ethtool -g $NETDEV | grep 'TCP data split'
>   TCP data split:        off
> 
> [...]

Here is the summary with links:
  - [net] idpf: don't skip over ethtool tcp-data-split setting
    https://git.kernel.org/netdev/net/c/67708158e732

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



