Return-Path: <netdev+bounces-148321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 169F99E11BC
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 04:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3D86B21024
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 03:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB1A13C8E2;
	Tue,  3 Dec 2024 03:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7tjIyLY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384CF3F9D2
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 03:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733196619; cv=none; b=uWWT4X8mZ+YTaaqa8SZUn+WjJvkYaZL7Ts3G6+D6b/SNzxmgT2JfORWotGKyGZNsfNYYTEC5ea18fEm1r/93aPANUH4gm77c5LMpY9TU7kkNP4bFBH0UsrsedvXCyN3epFwyovnYxHrpC7OvnwX0Nvq/+IpXtIQwvL4TUfsUMiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733196619; c=relaxed/simple;
	bh=DYz7z8J2QYY1pn9qau+Dy9b4XE9OB2Om3PMOMnt3QV8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eHVIDeDAnHdGJ8l1xMr4LnArpO0j6UDx+TjeTeTpc7oxni3/oz3wb5Yo4NSK3853bmIYcpVcZF67wnW7vzCHulnoCOFZTucetbGVOE6VZLGcuvFNOWWTyQugV4t2mxLMTBW4lWAdMMBWrztvfwLy4uRJyYkLqvFF3g9h25HrwNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7tjIyLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A70C4CED6;
	Tue,  3 Dec 2024 03:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733196618;
	bh=DYz7z8J2QYY1pn9qau+Dy9b4XE9OB2Om3PMOMnt3QV8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H7tjIyLYpd17kGrycVPacTbIdnxo5GvcOAbLbW6jxL+w/E/UjdTlo1L5He0ufq7mQ
	 0vbprzPmy/Tgve6e04wHJjv7CKjMt91dpSYzdvmaTRjjHeo2GshlKelrV44nGwvtH4
	 AHkQLGnGI8Bh16AW7tUCWiJobEoubu7SAobWRIkC+DppFCfj8L9KxozJ4RMz3WBzm5
	 4UtNNj3EHCwnmOSPLlP9PVC2+XPmXsi8f1d/9CWAryxgf17rS6ojlfkmYcMdrGqURm
	 AAjLKrLXxC3YwA2AhD9OgVtfh5VVVuJH/6Ur1McX5aV5b7Z4ZSvRQzP24rp/sNAdoQ
	 xANhZzRhz4LQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34CAC3806656;
	Tue,  3 Dec 2024 03:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net/ipv6: release expired exception dst cached in
 socket
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173319663276.4008208.14272876510720866117.git-patchwork-notify@kernel.org>
Date: Tue, 03 Dec 2024 03:30:32 +0000
References: <20241128085950.GA4505@incl>
In-Reply-To: <20241128085950.GA4505@incl>
To: Jiri Wiesner <jwiesner@suse.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 lucien.xin@gmail.com, yousaf.kaukab@suse.com, andreas.taschner@suse.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Nov 2024 09:59:50 +0100 you wrote:
> Dst objects get leaked in ip6_negative_advice() when this function is
> executed for an expired IPv6 route located in the exception table. There
> are several conditions that must be fulfilled for the leak to occur:
> * an ICMPv6 packet indicating a change of the MTU for the path is received,
>   resulting in an exception dst being created
> * a TCP connection that uses the exception dst for routing packets must
>   start timing out so that TCP begins retransmissions
> * after the exception dst expires, the FIB6 garbage collector must not run
>   before TCP executes ip6_negative_advice() for the expired exception dst
> 
> [...]

Here is the summary with links:
  - [v2,net] net/ipv6: release expired exception dst cached in socket
    https://git.kernel.org/netdev/net/c/3301ab7d5aeb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



