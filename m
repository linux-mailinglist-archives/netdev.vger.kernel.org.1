Return-Path: <netdev+bounces-75085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F7B8681EB
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 21:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343B11F24B1E
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 20:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5156312F390;
	Mon, 26 Feb 2024 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvxLWMi7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C77C335BA
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 20:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708979429; cv=none; b=jHjD4OVbcFEPdKVa0AMg59FgucuPIRf4eQ/WeoW36ogfujxza6ivcDwYxfLnHYXB827kNSK8RrUAm02J5OCpatRn7miXQJfaQHp1js8A1O3bK//n86U//2WznnZcalPk5jDBI+crdWvMVqiV0S7GihFExwAMXC0jVFCjW7n/ocA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708979429; c=relaxed/simple;
	bh=b/VSCJTqxqSbpQCqGDn1ah67LS2JZWSaERNgeck6xTk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qi2inloNeTbBtQ9QHEZBa3FLcgM2hpuT0Q6HSachcbhA8mbBj/k1YFAJGQXL7GQURpnEkk2YvkhJJOd3UEVwjUYnfwpN5OteotqaW1s41u00IGLjC72yxLIEC8s7m4ZPq8od1oGpukdpMWAf0swKvIbF7B7bpmdHdLn2z+jTYZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvxLWMi7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99404C43390;
	Mon, 26 Feb 2024 20:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708979428;
	bh=b/VSCJTqxqSbpQCqGDn1ah67LS2JZWSaERNgeck6xTk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KvxLWMi7pvtBmR7zC/XEgDa7+vDNNhmGGHVICwTZ8RnGvR8UfZpLCScx1DCy8aWZ0
	 VnPXFZX5b+pSnL7hp8MVo+LKrQulJTMMcSGtOMOgAGWpONDUalvzDXdzT69fHJaVnp
	 /lKSXTWRQ37OWYdNN1ELLO9Uw8+EfQFlB+2HxrmdbkZ1ifRsW3QrMuNLjaHREOk7Rv
	 5Pw/xYqMyBWhFOmZQmUjmedeY4xAM0WyrCxMkEuD2J6waSDmK2AgfyhtRRnMkVZUrE
	 VDGhiSq02n9E3I9VfuazJBfJh5Tcz2lwSEC15+O0YQ0XGYB0akXnzGW6pfKGlMB+i8
	 faDwuLdyM1ayA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 822BDD88FB1;
	Mon, 26 Feb 2024 20:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] iptuntap: use TUNDEV macro
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170897942853.28014.3875908663092092958.git-patchwork-notify@kernel.org>
Date: Mon, 26 Feb 2024 20:30:28 +0000
References: <20240220134544.31119-1-dkirjanov@suse.de>
In-Reply-To: <20240220134544.31119-1-dkirjanov@suse.de>
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org, dkirjanov@suse.de

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue, 20 Feb 2024 08:45:44 -0500 you wrote:
> the code already has a path to the tan/tap device
> 
> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
> ---
>  ip/iptuntap.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [iproute2] iptuntap: use TUNDEV macro
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=533fb3c4bec8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



