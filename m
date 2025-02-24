Return-Path: <netdev+bounces-169225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BDFA43018
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 23:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C753B4315
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 22:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D402054E7;
	Mon, 24 Feb 2025 22:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwpBCV+b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C74E18F2CF
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 22:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740436201; cv=none; b=FbSxi9Q/x46SHNN97QPAiandbzrgAnYbMx1e8Mfl++OY7meuDsjIuoxC+xK67aAnf9k15eY9vuokgclAmqwumukAsmKkarZ6w7jbY9ZIFOSBmWgJ4LyHGf3Ud15J+fgbZmtm6i8FSMcd9mIkbKNZ4Jicjb1J+1ToKsYJ9m8vkLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740436201; c=relaxed/simple;
	bh=BN4/vm2t8FQBq1dPTvYQ58U8+BiwqOF9IpOwFSBPKaI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pqXvWfHCvZAqin7DfeUeck0/lgLedrmmQpq0e7sdu3VPvAudcp+pF0Oap7Iub2GeoIxbMyCGl0ldvyhLxgTn7jqKp65BM87581XhWMMA1OL1M/pAKKXS3FWuajsz1r9VCb22HeHhvAmDGzIzNk6cyfi7txWXN+EGS3q/VrIL3+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwpBCV+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF10C4CED6;
	Mon, 24 Feb 2025 22:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740436201;
	bh=BN4/vm2t8FQBq1dPTvYQ58U8+BiwqOF9IpOwFSBPKaI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FwpBCV+b7JvaYr+tzqfR6/k8s1Cle4wOSj2BZJGImxwWr67IrhsT3l0q/t/XX+zoy
	 iYh1qDEoYpFdBApvPBJoNsQv4bMjvv0sKCmOLd/22YBZDyNYIN5Do0U1rTQNlM1x76
	 aQyXOy8VE48D5Xa4mlwhrk7HD7LYpFafvj/NEC06gT1E9zDNABGsQ8Q1P6XF92zHkq
	 QVQ2nBh68tYBVieYYiDr6lrdazjLJJTJCQQEXuEhiSZ/79piq5RJMo5awaBdkblsaP
	 BCBtB/ZNtBUU7nyuYHKKd9v1uUrF0yPL19Kw/VcIDt6g+k4Lfec9EYfJUetNdQKP8Z
	 q3IFRB5h9gA8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE86380CEDD;
	Mon, 24 Feb 2025 22:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net-sysfs: restore behavior for not running devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174043623253.3631570.1103599122489720781.git-patchwork-notify@kernel.org>
Date: Mon, 24 Feb 2025 22:30:32 +0000
References: <20250221051223.576726-1-edumazet@google.com>
In-Reply-To: <20250221051223.576726-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, atenart@kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Feb 2025 05:12:23 +0000 you wrote:
> modprobe dummy dumdummies=1
> 
> Old behavior :
> 
> $ cat /sys/class/net/dummy0/carrier
> cat: /sys/class/net/dummy0/carrier: Invalid argument
> 
> [...]

Here is the summary with links:
  - [net-next] net-sysfs: restore behavior for not running devices
    https://git.kernel.org/netdev/net-next/c/75bc3dab4e49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



