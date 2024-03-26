Return-Path: <netdev+bounces-81946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDB588BDF8
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 10:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71E92B27E2D
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 09:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC776CDC1;
	Tue, 26 Mar 2024 09:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maeK0eUd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272086CDB7;
	Tue, 26 Mar 2024 09:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711445044; cv=none; b=racYoHTX3oRlZ1JL89AL9oXGyVc8TcJ73zb4+GpvkfJ1DtRV4TToWBAlEW/zeEZgwVa6CUBWw0MJ8CM38zHqENlw74Db7eq/TAjQLM2nJed79SjaAFeyYKNMvJgIMAYEUzbTniAcusFsYIOZE6MijfXYZNQW6UL8NWOT0Oydc+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711445044; c=relaxed/simple;
	bh=WGk0ZRJwtuYNnR9de/ugCWxjFk8TauYdpoLkEozxQw8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CxWl2O8VVQEGVdg1G5kZbNcB9vl4KZwsKkVI2XiyzC9Pyuo69dZvGCIedPfJglc0jHD8mcNM3FI9V+nEnvnLakLCBRWyF8HEX3UKPRiou/DbKRf+SqerFkKgaHWrwDAHWoKnOBgUxqpEUykdMwm3yPNiUaf4E2TSfc311unR44U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maeK0eUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A16BCC433B1;
	Tue, 26 Mar 2024 09:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711445043;
	bh=WGk0ZRJwtuYNnR9de/ugCWxjFk8TauYdpoLkEozxQw8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=maeK0eUd03guDvFsxWn4wqQJYQiOHKUerGSII4pLtmFC0Np4GQDQcSc0YGA/w/F4i
	 PSalhzkaBKteUpncdUWqXKkwpBVvFI9UfVU8bk6OTph2pY4G/llF22yJkvPRlMBJt9
	 F5W0jXM3h40ddZq8XMqSbYPiq9T8DAZSI0gVT80gLRC9s++9SrtXZg3H2mlWF0Q11J
	 MPElMEAVuFMFjJ/Jl/7Cre4zFdnloysaIyoYQSyn6ii0GIfI7/VHz5qBioTw91/cdt
	 cIeupcXm9Q0upGgvRraK+G96H4adiW0RmN4HAXbUhmNyqXhoXZ4ReHAavN5pKGoH0e
	 AUExifK4gZFFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96A00D2D0E9;
	Tue, 26 Mar 2024 09:24:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] dns_resolver: correct module name in dns resolver
 documentation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171144504361.18039.10341546754537118346.git-patchwork-notify@kernel.org>
Date: Tue, 26 Mar 2024 09:24:03 +0000
References: <20240324104338.44083-1-bharathsm@microsoft.com>
In-Reply-To: <20240324104338.44083-1-bharathsm@microsoft.com>
To: Bharath SM <bharathsm.hsk@gmail.com>
Cc: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com,
 kuba@kernel.org, linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 corbet@lwn.net, pabeni@redhat.com, horms@kernel.org, bharathsm@microsoft.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 24 Mar 2024 16:13:38 +0530 you wrote:
> Fix an incorrect module name and sysfs path in dns resolver
> documentation.
> 
> Signed-off-by: Bharath SM <bharathsm@microsoft.com>
> ---
>  Documentation/networking/dns_resolver.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [v2] dns_resolver: correct module name in dns resolver documentation
    https://git.kernel.org/netdev/net-next/c/75925fafb4f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



