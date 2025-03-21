Return-Path: <netdev+bounces-176751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C9DA6BFA4
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 17:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05A4517E955
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 16:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711CD1DEFC5;
	Fri, 21 Mar 2025 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Liw89G9J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F98414601C;
	Fri, 21 Mar 2025 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573996; cv=none; b=XCS1h5ADTBo870vlHoKdO3GQ/jrQTSU+eyN7nznyRynRiC4WBvH9fKmmwLuhcPgKiU2BKip5OFKba21eFrlkeSCCjK11NCbB7WPhke9LhaxfzJ3dEemMKnRjS/gizmkYar07RB9qiHXyb+VPp4Ji+J+8xPFRSLYe9idpH81RTgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573996; c=relaxed/simple;
	bh=XI2f7SgbQyb+AjtyGj/tTNrFlGkFGsaPs29m6a6WOvg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h7iFtDZH8RlD/HZR2ICu6BU/TL6LKEoXeg+QQnG3ppQxKSwZVby7vBkHHgb/yK9Lp5PiXCczIJhbfi5WjSLRVR3taMYFDu1ygXu4dLdYaQwg0I+JcqikvHuny4qQOPvqF+1O495NfNP6/wt3+q1P7L0Q70owyatT1I0FtPWCOK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Liw89G9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3447C4CEE3;
	Fri, 21 Mar 2025 16:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742573995;
	bh=XI2f7SgbQyb+AjtyGj/tTNrFlGkFGsaPs29m6a6WOvg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Liw89G9JebAAheTFGPYolng/r/+euxjKQK+sJFI4TrqTrKYLQRHVbvcRQ/cBk+UVz
	 5nhfYLQHDxA+gubhPIX/1xxcAZ7mt/hNfftQON3JbzzwBeE3g8oGNTS+bKrhNsh8QI
	 ZHbtZoZ+aMGmkJRNMypGw1p3Gf92SK3ZSEmv4S65j6IY9IQtQTpWa4ZJ/OFUsXhmXH
	 DFxXrfg96Zi7aDVu/DBm1R3ssg6ut6k52DxOERAQWd2qPMLTXBmAsJQr9eSykde5hY
	 bp2Rev6o3RCi4m78rkwZAMcMxqxJDPV7/raGRMQfAYLU75KhLqFmmnYpqmfaysku+2
	 djJW8iK6RmiWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBF0A3806659;
	Fri, 21 Mar 2025 16:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: remove sb1000 cable modem driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174257403177.2538209.5678698281791174462.git-patchwork-notify@kernel.org>
Date: Fri, 21 Mar 2025 16:20:31 +0000
References: <20250312085236.2531870-1-arnd@kernel.org>
In-Reply-To: <20250312085236.2531870-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, arnd@arndb.de, horms@kernel.org,
 corbet@lwn.net, christophe.leroy@csgroup.eu, rafael@kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-acpi@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 12 Mar 2025 09:51:19 +0100 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This one is hilariously outdated, it provided a faster downlink over
> TV cable for users of analog modems in the 1990s, through an ISA card.
> 
> The web page for the userspace tools has been broken for 25 years, and
> the driver has only ever seen mechanical updates.
> 
> [...]

Here is the summary with links:
  - net: remove sb1000 cable modem driver
    https://git.kernel.org/netdev/net-next/c/3fed9fda150d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



