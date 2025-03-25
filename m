Return-Path: <netdev+bounces-177329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664BFA6F463
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 12:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6EB3AE74D
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 11:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8032566C0;
	Tue, 25 Mar 2025 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnngVi02"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A902561DF
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902801; cv=none; b=lXplPq4ebkZKlxdUwFF2akrgwB1/E23BbA76nrVF9XQK+yrsZD9edY//1eWPQj9iWikc2OxQYfJxDdAX92eLKNT83LduN2DvDb9jxHJ5SkjM/xroX7hVjRrNFWZ2Br0AyPH0pHLQW7O+3cs0vhKcC/0exjOKzt6wVliVdBXSHfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902801; c=relaxed/simple;
	bh=iVel62Cown7t3ST0LVEeq5O5cDMS31FeysNAGL0XxyU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pcd1eL+FUUJ/a/i3y40QA+p+h4PLBMNN8SxbVi395EOr9DS93sLf5JMCdG3DFHzmOE7JrFuujbx9248/Qrlo0ox/FqV16FU1/QYDeJn7hYfBAd2uDluzGNckLICsvUW9I8XQLbLA0GvDWaa33kWiJsIygogjQUT3Y1WR/r06PkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnngVi02; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33681C4CEE4;
	Tue, 25 Mar 2025 11:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902801;
	bh=iVel62Cown7t3ST0LVEeq5O5cDMS31FeysNAGL0XxyU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XnngVi026wqU01fQzOpcXrQ+vA4Fr9U3bCuD/wf/oydW949AVDcb++Ri0j1dhk+/c
	 Y05Gt85eSfbfnD8GeJKJ2AEi0Jpqh0oIQP7wKSMtynP2qKcRwohdqQLbXggKhE25Pd
	 1TYYntNUcadyNuGvDWlnanTZIOO3DQEdYWa5zRJsFh+5Fy8QISqcKJrvNzGFGEo12i
	 TdvtZZF48vo/7LZAFq2MEU4Rbjvtw2b8GjzOSSeVpxslE4x6sIZ6gSzTsUy0ijBUe2
	 bFqTls9Abm2ThKESCWArlRHyIZWjLGqH9zrXCC/0MM2+gJOB/tnCB/v5Zs+kj17Iyo
	 CuXkf6+6X5EdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE17380CFE7;
	Tue, 25 Mar 2025 11:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/2] support TCP_RTO_MIN_US and TCP_DELACK_MAX_US
 for set/getsockopt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174290283724.528269.10411873053615633415.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 11:40:37 +0000
References: <20250317120314.41404-1-kerneljasonxing@gmail.com>
In-Reply-To: <20250317120314.41404-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, ncardwell@google.com, kuniyu@amazon.com,
 dsahern@kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Mar 2025 20:03:12 +0800 you wrote:
> Add set/getsockopt supports for TCP_RTO_MIN_US and TCP_DELACK_MAX_US.
> 
> v4
> 1. add more detailed information into commit log (Eric)
> 2. use val directly in do_tcp_getsockopt (Eric)
> 
> Jason Xing (2):
>   tcp: support TCP_RTO_MIN_US for set/getsockopt use
>   tcp: support TCP_DELACK_MAX_US for set/getsockopt use
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] tcp: support TCP_RTO_MIN_US for set/getsockopt use
    https://git.kernel.org/netdev/net-next/c/f38805c5d26f
  - [net-next,v4,2/2] tcp: support TCP_DELACK_MAX_US for set/getsockopt use
    https://git.kernel.org/netdev/net-next/c/9552f90835ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



