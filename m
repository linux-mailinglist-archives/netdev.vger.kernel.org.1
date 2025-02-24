Return-Path: <netdev+bounces-169230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4CEA43032
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 23:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB2DE7A6E5E
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 22:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E09F1FBCB9;
	Mon, 24 Feb 2025 22:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErXZ1BzE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179791F5FA
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 22:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740436812; cv=none; b=KsARiBf4nA/eGjhq7H5JNvh81D0VDhm0mrf8xlfSYqLL4++QBfdb8Jx3b+ce2JV7nSPRRVVRywUzJB7EIqix3p5KeIrI/0KDEeoXCrPnOYBo8XlOS9kedAiyXkyFSViZ6hPfrv9d9pdubcfebmWFcBJnquqCLWErF4K9AxWYBhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740436812; c=relaxed/simple;
	bh=hoU/Gj4q2RJiV+TimIw+80gm0opJDVS17qXJ2pvKRdA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ufSx3lXK2cSIdRETXxN6EmK2LhpLxsJVY+fwbMXJHbQIXHkFi8SEveFm60tOxeHoMP98jfjYZV3dQSWYyVlEUxuwIOjwP+EY7M9OQn6vT1vjoB53EN7GadksUMKnWeztgmiUb83VxqyVHYguL3NdMM5u83PfUar/d1nvkbR4+60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErXZ1BzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8F1C4CED6;
	Mon, 24 Feb 2025 22:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740436811;
	bh=hoU/Gj4q2RJiV+TimIw+80gm0opJDVS17qXJ2pvKRdA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ErXZ1BzEoyc/OClz2NquYKP4oiRuM2Eaxi/JCATgEroRYO2vPPiy7K1/IWxkkFFQt
	 i0Rup+HOjFSXG/tys5cetRJkMO2ZecsWS4lPZdS5tfhv+CRSMmN0d07etTNPNNkJAs
	 vldu8wf2hGcAUCkEJIIPFvK17/hbsuqaAfGwnD7IG2QsiJ5dwWOK2sUXzijVEryIeR
	 JojNjGV6ELOYJEJDGjSVRfJjppYHqnpNJDgLbd96VmZX1XLjBCNuvyuqbIRi/FX4pS
	 BQApwb3Ot3srsLejhhhkfgXscE9MM7MnYvS0CT9DwZflPBAjkty3fGQ4nEfAQGe39E
	 NHXe23i5LvXYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BE9380CFD7;
	Mon, 24 Feb 2025 22:40:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: remove skb_flow_get_ports()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174043684301.3634134.4954094891423427977.git-patchwork-notify@kernel.org>
Date: Mon, 24 Feb 2025 22:40:43 +0000
References: <20250221110941.2041629-1-nicolas.dichtel@6wind.com>
In-Reply-To: <20250221110941.2041629-1-nicolas.dichtel@6wind.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, maciej.fijalkowski@intel.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Feb 2025 12:07:27 +0100 you wrote:
> Remove skb_flow_get_ports() and rename __skb_flow_get_ports() to
> skb_flow_get_ports().
> 
> v1 -> v2:
>  - remove the 'Fixes' tag from the patch #1
>  - add patch #2
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] skbuff: kill skb_flow_get_ports()
    https://git.kernel.org/netdev/net-next/c/89ac4a59ca6d
  - [net-next,v2,2/2] net: remove '__' from __skb_flow_get_ports()
    https://git.kernel.org/netdev/net-next/c/c52fd4f083cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



