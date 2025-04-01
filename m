Return-Path: <netdev+bounces-178490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1895A77309
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 05:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D22A17A1826
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 03:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC341D5151;
	Tue,  1 Apr 2025 03:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dC+DKyr9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEC81D5141
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 03:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743478799; cv=none; b=O92E37+tf4bSJREgWDV74hWq+WuO5oBZguUNMt8OwI4MJm6jzJsV4x4ghAjPevkqnueEBfRp5d9tAaiXpkiqIoPd4L5Rsxdw5wpq0BeFdaKPvRfj6qsgJhMctwlFRw4tipg6I7muVIuLoWnk2NKPwbgScKW44X24k7p9GgDUEdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743478799; c=relaxed/simple;
	bh=y8OCR8N6Te4VWrBXpAY5QPm1buB/x8iE6DmQR1/KRpo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G32+7pV+sL2TYyEucNccaSdXuwiie0iHhxspeEUA7ECIwHPORpPq21+oSSBbogGHIZQ7z66lTvhG0+LrRoYqp0ZmqLLY6WUkci9JrXjwef9Uo++eJA+DaWezDsF3Bhq9JS2Z2gddP/iE33zSPQBxHmutJgPuVpWuJxMAaQRTunk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dC+DKyr9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85353C4CEE9;
	Tue,  1 Apr 2025 03:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743478798;
	bh=y8OCR8N6Te4VWrBXpAY5QPm1buB/x8iE6DmQR1/KRpo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dC+DKyr9QL3nex1mcMMXIEFg6xGODzRt8XutSrEEpS5i1x7g7//ex/oEZjoD5jk2P
	 8i7CRdwOylXi3HJOxXB0RUI+PSe+/u/41PCV6J2zpEZpfttdSIdRTgeri9+n7eY9kI
	 /cjllrIlFX+zzqCIv5PawR8tmBq1JeNIFsCMzPn5pG28FJbnhPQbJwAoKMEstZTOlA
	 8kL5YOZVxLTGhAnRNhyqX7etHzu51xhxuW5jfcCU9nD/KGqtSXZkadTY/CwHJxGDK4
	 rTuaxnnbgXYYMa1yWXieM8SIMDLvUdLWcf25PZ/5Fw8xZf7bDWjHhUbkHR03LpHJC/
	 Ad/Owxedt30fA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7102D380AA7A;
	Tue,  1 Apr 2025 03:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] ip: display the 'netns-immutable' property
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174347883527.227928.17713387159044503900.git-patchwork-notify@kernel.org>
Date: Tue, 01 Apr 2025 03:40:35 +0000
References: <20250328095826.706221-1-nicolas.dichtel@6wind.com>
In-Reply-To: <20250328095826.706221-1-nicolas.dichtel@6wind.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: stephen@networkplumber.org, dsahern@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Fri, 28 Mar 2025 10:58:26 +0100 you wrote:
> The user needs to specify '-details' to have it.
> 
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> ---
>  ip/ipaddress.c | 5 +++++
>  1 file changed, 5 insertions(+)

Here is the summary with links:
  - [iproute2] ip: display the 'netns-immutable' property
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=e4e55167d004

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



