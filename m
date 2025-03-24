Return-Path: <netdev+bounces-177240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B426DA6E663
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 23:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E1C07A43E2
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431721EB9EB;
	Mon, 24 Mar 2025 22:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6VYxTMy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2531E5B86
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 22:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742854203; cv=none; b=XXTOfMNDVgjNR73Zj3ukUtU247mfDV/quem3QfFaEXZD5Fiv2yk5c7ViHf5QbdZA+i4pxn1nM4tvE2m6mB1a3kGBKI5DZkWnMnA6NZrp6W63Mwq+KaBZD56mBGJ4GTKe/fk97g1PNjE5dkyeieFxENrUY7fU5cVCmMgYY/UnK4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742854203; c=relaxed/simple;
	bh=NAQFXa2rIdk9Ff4rFGA6D0fYhPcwKEXKHpnHxHhSBKk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mGTtuMv04ZZt4FnHlPqsB04t86d4d8st2LvY+tKxBuzAeBnK1xUro5HdONOcIqMd6lVyso/CHJSzg06JMaEfTj5io62Fu7HYGsuKNdj8PAKes7oEGHjtdheeWmmkp7uZbPKn0ATEdZHSONyDYoWdg/xk+EfUnncs9MTSIrhLwf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6VYxTMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC11C4CEDD;
	Mon, 24 Mar 2025 22:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742854202;
	bh=NAQFXa2rIdk9Ff4rFGA6D0fYhPcwKEXKHpnHxHhSBKk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C6VYxTMyQ5sHc6ZE0hysDlT8eWTKWt60YduSwdFmH+a1Bq5OgV1fdlAL4lgj5FgfR
	 hngR0kNfgaoxz70bp3yPh/1hlrshQ39enH6//5qleUfK4vIPzFTjqrAPPX5uXxg5se
	 JNazmXR+CWVf0+zCa/f6LYfMaP6D0VH+ud562ytr6w/0MvJcj/VyjGJzEFIcBlHlXe
	 3GduudZsxr4zWxrxroxwXfBDygVjxI7IZuQ2WXBpir1vPAol5/ftHOcj4DK7sIWRbz
	 EQTgDGpjw1AnATShoSg8nkho7ynCzMidpwOSfn3jS6is8P/xm68eOwKpWzb+xF0FP7
	 6irN4i+5EgHLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB843380664D;
	Mon, 24 Mar 2025 22:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/7] Fixes for mv88e6xxx (mainly 6320 family)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174285423877.1580.1370166192486015066.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 22:10:38 +0000
References: <20250317173250.28780-1-kabel@kernel.org>
In-Reply-To: <20250317173250.28780-1-kabel@kernel.org>
To: =?utf-8?q?Marek_Beh=C3=BAn_=3Ckabel=40kernel=2Eorg=3E?=@codeaurora.org
Cc: andrew@lunn.ch, olteanv@gmail.com, rmk+kernel@armlinux.org.uk,
 vivien.didelot@gmail.com, tobias@waldekranz.com, netdev@vger.kernel.org,
 lev_o@rad.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Mar 2025 18:32:43 +0100 you wrote:
> Hello Andrew et al.,
> 
> this is v2 of fixes for the mv88e6xxx driver.
> As requested, I left only the fixes that are needed for our board
> to be backported, the rest will be sent to net-next.
> 
> Marek
> 
> [...]

Here is the summary with links:
  - [net,v2,1/7] net: dsa: mv88e6xxx: fix VTU methods for 6320 family
    https://git.kernel.org/netdev/net/c/f9a457722cf5
  - [net,v2,2/7] net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
    https://git.kernel.org/netdev/net/c/4ae01ec00771
  - [net,v2,3/7] net: dsa: mv88e6xxx: enable PVT for 6321 switch
    https://git.kernel.org/netdev/net/c/f85c69369854
  - [net,v2,4/7] net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
    https://git.kernel.org/netdev/net/c/a2ef58e2c4ae
  - [net,v2,5/7] net: dsa: mv88e6xxx: enable STU methods for 6320 family
    https://git.kernel.org/netdev/net/c/1428a6109b20
  - [net,v2,6/7] net: dsa: mv88e6xxx: fix internal PHYs for 6320 family
    https://git.kernel.org/netdev/net/c/52fdc41c3278
  - [net,v2,7/7] net: dsa: mv88e6xxx: workaround RGMII transmit delay erratum for 6320 family
    https://git.kernel.org/netdev/net/c/1ebc8e1ef906

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



