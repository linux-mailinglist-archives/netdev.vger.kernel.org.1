Return-Path: <netdev+bounces-135685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C17299EE02
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 15:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A7E1F25809
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 13:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010D41B2181;
	Tue, 15 Oct 2024 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gc80enfs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D100E147C91
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999625; cv=none; b=jiDb3q4FWAko/7kB00A9UdQY+trMGgy90xVKQ5/73+36OVGzhqUhomx1CGkeSOiwvOmOUjberFyXU7YMteFvQnkNQ5SpN6TcnkqYL1+Qh0zhzV+K2Vn+bbswyZCeu+wgtlgsM2VFtOXvJOesoGfdjFkPNvNMVsz2GvPhE1K1inE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999625; c=relaxed/simple;
	bh=b5y3IscGRmb/wpzVvp1/nTnMJhvtbyKoww/llZjjv78=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S8V/5F/s2ALvNDQ+A5dzOKjaBJO2/pJEZ6uIGuPbeAL2k0zFAvV2GfDGJhMGyX2vTQUU/eY1iHwZQjG7gOFYuuMK9cfHJtbGxvYTbXlV7Zd/otuAxgb/FGysAnFFGMI3vi8mx9F6f523KKueL6uYACK22KRZzOohhPlDkeD5sDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gc80enfs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDDFC4CEC6;
	Tue, 15 Oct 2024 13:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728999625;
	bh=b5y3IscGRmb/wpzVvp1/nTnMJhvtbyKoww/llZjjv78=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gc80enfsBa3TXrTI7U/d604am910OUv4UigweWPOKIX123whHbH/BPaSE/yPFtZhe
	 Dd2ge8JvNm8YiAmzkKqDmhaE584HZBHN98/DbSzHWWuuB2+/2tEGJlrZv2VnW6U6Ir
	 M/Sk6XGLdD+3t7YvuVRnn65BzC8JAyqxPOJNmi4dMiwJ59c66QbWoIydzlQ67eWhvC
	 acT/ieKnEu10sT70CgeFqKSfQbXYY41QeCVb1Xjth3ujN9N3XUGCnKChTc6WCx+g2A
	 0PwET2BK5mmBkOsMTDfl2unzx5PXpq7Yj63j2FU6qFAiBJTAVPcA2mQQaeOqm+Z9Kq
	 X3TXS/0F7PvrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDAE3809A8A;
	Tue, 15 Oct 2024 13:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/4] batman-adv: Start new development cycle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172899963051.1165800.3482605759558886670.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 13:40:30 +0000
References: <20241015073946.46613-2-sw@simonwunderlich.de>
In-Reply-To: <20241015073946.46613-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org

Hello:

This series was applied to netdev/net-next.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Tue, 15 Oct 2024 09:39:43 +0200 you wrote:
> This version will contain all the (major or even only minor) changes for
> Linux 6.13.
> 
> The version number isn't a semantic version number with major and minor
> information. It is just encoding the year of the expected publishing as
> Linux -rc1 and the number of published versions this year (starting at 0).
> 
> [...]

Here is the summary with links:
  - [1/4] batman-adv: Start new development cycle
    https://git.kernel.org/netdev/net-next/c/0f4e6f947600
  - [2/4] batman-adv: Add flex array to struct batadv_tvlv_tt_data
    https://git.kernel.org/netdev/net-next/c/4436df478860
  - [3/4] batman-adv: Use string choice helper to print booleans
    https://git.kernel.org/netdev/net-next/c/5c956d11cfca
  - [4/4] batman-adv: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
    https://git.kernel.org/netdev/net-next/c/356c81b6c494

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



