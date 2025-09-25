Return-Path: <netdev+bounces-226212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F91B9E1EF
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 10:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37DA31BC2576
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 08:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669FC2777E4;
	Thu, 25 Sep 2025 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRsk0q1r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BBE8488
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790212; cv=none; b=f0IzJWc3mTAT1ynbu+vim7gkKSKTAsYsjTODbxNejzpFSfWZ7CuNiIFffIiIws20STlbKFVaano9GWI+qwwN9tihbR1iR5g+TXDBN9ob/qtCBTjKGYCROjX1FQ9Ka8lirZFnb6PULJH1mVR3bTpzcJ6V71JL3hhQQOsKEm1zEQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790212; c=relaxed/simple;
	bh=Mh1L2oJ8utWt4yo7+oEmKN2uNFYLbWelcobJ4lDyCk0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GdncEGsz4SUWFHz7I61/9m2kj3pUtee6d0nVPrH/dKBbLYO1FfuzJH7UjFz/HslRZOxH8/bLUHHCsQCzwUzeWajoNY+2UPBFjGNFcIU/DEryKNK+j8RmddnINqSBLcjarRY+SpofK6imyBYiHyg9pYFM25tZsDYO5vRDnd93CpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRsk0q1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16633C4CEF0;
	Thu, 25 Sep 2025 08:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758790212;
	bh=Mh1L2oJ8utWt4yo7+oEmKN2uNFYLbWelcobJ4lDyCk0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GRsk0q1r4esI4XUt/Z2y4tlwIdPsmiwt94UpS7EXGuZ5pGNypTTCHOGFFZxZnfDzU
	 WrFmHz19TFjsoB1rJUy6OopdltNFhHkZUGuyI5/7GLJSIrB42wW6iRh7tMVzoy2HuS
	 xPH9uVzFiy1i10ljqYOxCan8RlutzoooUvgB5PJaRQ45IN2NLe6CZ5p76OnwJlm9v/
	 nhP8zNMK/3lMjOStf61bHEUSlCldX/Yj54aUYMbGl4Fp3f4VcQbN3WfTrUYpjYP3Qe
	 Q4IX7EUi9+hF/GDkiyY37JLVPhAi0+inxOvo0feJ7knji9hm+9Tloai0DTr9/EumVC
	 T68lcmNF/6F2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C6A39D0C21;
	Thu, 25 Sep 2025 08:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] lantiq_gswip fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175879020825.2880928.14758733627344839219.git-patchwork-notify@kernel.org>
Date: Thu, 25 Sep 2025 08:50:08 +0000
References: <20250918072142.894692-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250918072142.894692-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, daniel@makrotopia.org, hauke@hauke-m.de,
 andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 18 Sep 2025 10:21:40 +0300 you wrote:
> This is a small set of fixes which I believe should be backported for
> the lantiq_gswip driver. Daniel Golle asked me to submit them here:
> https://lore.kernel.org/netdev/aLiDfrXUbw1O5Vdi@pidgin.makrotopia.org/
> 
> As mentioned there, a merge conflict with net-next is expected, due to
> the movement of the driver to the 'drivers/net/dsa/lantiq' folder there.
> Good luck :-/
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: dsa: lantiq_gswip: move gswip_add_single_port_br() call to port_setup()
    https://git.kernel.org/netdev/net/c/c0054b25e2f1
  - [net,2/2] net: dsa: lantiq_gswip: suppress -EINVAL errors for bridge FDB entries added to the CPU port
    https://git.kernel.org/netdev/net/c/987afe147965

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



