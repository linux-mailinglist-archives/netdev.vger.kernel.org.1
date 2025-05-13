Return-Path: <netdev+bounces-190168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD69AB5679
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8464C1B467CC
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 13:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB39628F936;
	Tue, 13 May 2025 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Deoz/43t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82214242931;
	Tue, 13 May 2025 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747144192; cv=none; b=izFQPDCnDqwfRDTcGl14QCjnv5ALQco6B2kn17ufq9rXhUPGEwnD8oTG42gB+yLupVlXQYtF72YQ5RY5Xgr5afPczsHsfGlKndEgbwGg0ugjdrVpBKrIluKLCCNyM6xNKAugAZGsdQ/VduJSfl1+LLVvTMon+b6Y79XbzA1MvBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747144192; c=relaxed/simple;
	bh=iXce77Zxe0hJqfiwEb6FAIjbqHrEaQ2HlNz9uvNBDUQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=shaqKQSch/hnBmR6shtVlGsWysab/1GrmAQetgY6dCdPp4ximDJ6cuAhVwBM0fMOAMgnMZAAW4ybdAMeu9iiOy0RALhjeIfh8yKIe58+uwBq4jTPV+9ZpMdDmd157tHIAJ5xHZ10xsBg/7Y0dNPV/UAqufZ+nuEWJm+BD8JZAOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Deoz/43t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA732C4CEE4;
	Tue, 13 May 2025 13:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747144192;
	bh=iXce77Zxe0hJqfiwEb6FAIjbqHrEaQ2HlNz9uvNBDUQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Deoz/43tY8IQC8vU47bA0UzoagE1pIqJg8dq0GUUUuDt1/CWtHwjZrcY8ifhBlFtO
	 emuOJMENOeaxnhiu2+LgDRHN1VvQH18uwxEabwVShb0HrHb5m2JERJPnfu7ehjbgHS
	 NifbKMYrOoydZD0QKHoGl1Ego89C+5c8hS/XXCNyAmBwa1Rssi+vq3P1Eq8n+llrHn
	 SAsO/kvkP1Seb3icFkgPfGHHYr4zn6GgIDE4u/OY+IqNjjR8svFZHJEWymJ9dFByYC
	 awa5BZ3IJKvWBk4KMo2/srEcabXRqBLNJMfm0GRU4rRvEKvzF3sUva0NvcNwVW99df
	 l8LUH5H8lUeNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD4A39D61FF;
	Tue, 13 May 2025 13:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: b53: prevent standalone from trying to forward
 to other ports
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174714422950.1672299.16837840764503369784.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 13:50:29 +0000
References: <20250508091424.26870-1-jonas.gorski@gmail.com>
In-Reply-To: <20250508091424.26870-1-jonas.gorski@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 f.fainelli@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  8 May 2025 11:14:24 +0200 you wrote:
> When bridged ports and standalone ports share a VLAN, e.g. via VLAN
> uppers, or untagged traffic with a vlan unaware bridge, the ASIC will
> still try to forward traffic to known FDB entries on standalone ports.
> But since the port VLAN masks prevent forwarding to bridged ports, this
> traffic will be dropped.
> 
> This e.g. can be observed in the bridge_vlan_unaware ping tests, where
> this breaks pinging with learning on.
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: b53: prevent standalone from trying to forward to other ports
    https://git.kernel.org/netdev/net/c/4227ea91e265

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



