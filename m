Return-Path: <netdev+bounces-230247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 079A4BE5C03
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 01:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B0AF73579DA
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 23:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652832E7199;
	Thu, 16 Oct 2025 23:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8q0T/CD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410E41917F1
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 23:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760655626; cv=none; b=aCH5UyNeOT3Nqr8Mt0E2yHApKOZyPt80i8RB7EwwflPXN3l8ZcO8SCJKnzZ11YErIqMZsnJ+DJ0psa46hkee2qcVSROblIWFEVafsYTaQAiN9fT/qb2yXAmPTSU+F2dhJq4heVHmHEQjRSy52wJroL40X7YOYHre99qPrY+PERw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760655626; c=relaxed/simple;
	bh=X4vMJCl0Q2iFSS8Hx0eKhB7NrhVJRXqYy4oxZ9xjAuk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jUW+TRKswB/U25mWVCBKdekmkiyinQk13/vLMQhCbZgCep9PtnAjq/fq38D/2xP4bBX6B5FWhiA2pXZulkIAap0mAnu9TYxTBvpuICk3Xp9KAHn9VUWznFbn9xhr1YTeYeJ+61eRfrU6huvnSF9OVaewM2jVlZZSvSPuz3p5Zc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8q0T/CD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2653C4CEF1;
	Thu, 16 Oct 2025 23:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760655625;
	bh=X4vMJCl0Q2iFSS8Hx0eKhB7NrhVJRXqYy4oxZ9xjAuk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c8q0T/CDCWef8Pf9L5P5dF8rkpKxI5Xs4lmm3WfJHO8BfBySyoyuf9gVFAgIxuunW
	 kvgIDEIN8zwcjISAYMAOnGjTMC3LwSnaTwPvlpwL6oVU1CU0cduG0EJ817oDWIVVXH
	 d0Q9ZXPiNW6ZEGisSoBSrmp1j+hK5wHmqFVZqwZd4aYTZy/x8v+OtSUoV9a8dJF6BD
	 vbcqlMyL9k1DR622I3Msf6pdgkTruQLua7o47SDLOUzf23iMitLetIRYSEA4aGzGgO
	 S4iYgXlHXN0ewsqb1XryATx6EJLOGyPAy3VPqpOlZMWXdICqds7LSUHZd7tr1g8L93
	 hS+egZWladaGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0C73810902;
	Thu, 16 Oct 2025 23:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/hsr: add interlink to fill_info output
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176065560965.1937406.37787787075247784.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 23:00:09 +0000
References: <20251015101001.25670-2-jvaclav@redhat.com>
In-Reply-To: <20251015101001.25670-2-jvaclav@redhat.com>
To: Jan Vaclav <jvaclav@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Oct 2025 12:10:02 +0200 you wrote:
> Currently, it is possible to configure the interlink
> port, but no way to read it back from userspace.
> 
> Add it to the output of hsr_fill_info(), so it can be
> read from userspace, for example:
> 
> $ ip -d link show hsr0
> 12: hsr0: <BROADCAST,MULTICAST> mtu ...
> ...
> hsr slave1 veth0 slave2 veth1 interlink veth2 ...
> 
> [...]

Here is the summary with links:
  - [net-next] net/hsr: add interlink to fill_info output
    https://git.kernel.org/netdev/net-next/c/f18c231fb12a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



