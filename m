Return-Path: <netdev+bounces-146102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D659D1F0A
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 05:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E24B028264F
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 04:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317E21527B4;
	Tue, 19 Nov 2024 04:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CilEPpN0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0906514A4EB;
	Tue, 19 Nov 2024 04:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731988831; cv=none; b=sVCPLVxf7UF9un1+Dr+ogfMWQr6jDpSw+2oK0ILC5QUb0QJQoaqrLwX5Ijif95LDsiiJdJ3EiczySWbNUrXOwW/qSNq67QCupn6EUPkIuxtX4VtCHEd0aTTsdWfh9eZ38sarRzJIBD7+dg3yJ56wveSL9B7nZYQE61PwKHbp8xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731988831; c=relaxed/simple;
	bh=JrpMfsKiDZUzM7MMCPOjRLPifcbKsuTDdbLhPJ/UQv4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kIea9OsB/2q96c7DgozmGU6spU18R9T7YRKJIOFmBerK6XRJ1LOxVi7nEDZN6lcJZ7AZz96dnRxyIQnxFZqzyLdOzX6n8LUHzvRMjcuN8MntuieRXeRgou+F5rTWQeGKO0j8DbxbFoZGxszRqM20BCNIdZkwFWvJ/cZYvrNTqxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CilEPpN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FA4C4AF10;
	Tue, 19 Nov 2024 04:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731988830;
	bh=JrpMfsKiDZUzM7MMCPOjRLPifcbKsuTDdbLhPJ/UQv4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CilEPpN08lK6k+DFDXsB/MI1uxKH0CVI2IPgWbB/mvx+lBXHxuzrocohGPlPTsLGl
	 OvRWB1vlcvTq5cF+6kB/NGA2PAXS2TEUf1sVwDeN6Vy92L+n9Ii3K/z5W0vwReRWip
	 upXlXRl9SvzdJIJEVO5n5TwFDpjZ059BGeYEjQ83TBuhO8HiEBfevse91Bb0xAL/4i
	 G8CTQs2+uTPkm05oOshvU1i7wq3wHEW3yFDGqKtx9GToUWnmW4OT29TlNIdu+JKkhm
	 +Y7lUe2AIj+xpc40DLRa7Fw7gqGc+JzD1q4XHVeFhHi8hhLF+sabk7F5QXFw2enIW3
	 dSo5Ap89rDG7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7167C3809A80;
	Tue, 19 Nov 2024 04:00:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] stmmac: dwmac-intel-plat: remove redundant
 dwmac->data check in probe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173198884200.97799.10181079932395577855.git-patchwork-notify@kernel.org>
Date: Tue, 19 Nov 2024 04:00:42 +0000
References: <20241115132632.599188-1-mordan@ispras.ru>
In-Reply-To: <20241115132632.599188-1-mordan@ispras.ru>
To: Vitalii Mordan <mordan@ispras.ru>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, pchelkin@ispras.ru, khoroshilov@ispras.ru,
 mutilin@ispras.ru, andrew@lunn.ch

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 Nov 2024 16:26:32 +0300 you wrote:
> The driver’s compatibility with devices is confirmed earlier in
> platform_match(). Since reaching probe means the device is valid,
> the extra check can be removed to simplify the code.
> 
> Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] stmmac: dwmac-intel-plat: remove redundant dwmac->data check in probe
    https://git.kernel.org/netdev/net-next/c/cc84d89ad8d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



