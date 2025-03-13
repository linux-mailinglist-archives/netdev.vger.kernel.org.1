Return-Path: <netdev+bounces-174490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C79A5EFBF
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 10:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2028818916C6
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 09:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7161B264FA1;
	Thu, 13 Mar 2025 09:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mx6mGNN6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489D8264F99
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 09:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858800; cv=none; b=KaCsMxXiM6+4nF2JbcXedTo1ZOJRoIC14b1sXC+mHgbFQGKc+z6ch80AR/lB549coRqfIrHJQJgCXx6kAt3vxFWvoBi/FRq9fpTogyGcE100bgIXHZv8uMTc5p8GmipB8rH/DALbqEAvQzMPvO9WJ5weNaTR9ITp/KW5j29MTkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858800; c=relaxed/simple;
	bh=UhMzxZbTo9QnZ047rGT6v8BCZdle3/5iZTve+2A6IBQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hhKQyNiSCplUE/tJJW6LwpM4D9rUqKNzLogB7cepGyjJeqaXPjF+MMNxvMTWCr4MRrGQ8zCoG17uufsL/W7dkI+C4qxUKrRifMzeBUU0wKTx/wE6xcbcBXQhqgvak8osEl8Lyi6CgXQnuEqJ+gBcK+3t0h7nd4t/8gNWzbSqzjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mx6mGNN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1D1C4CEDD;
	Thu, 13 Mar 2025 09:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741858799;
	bh=UhMzxZbTo9QnZ047rGT6v8BCZdle3/5iZTve+2A6IBQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mx6mGNN6RbyKTeb37uQhpERBj2WVgyrj5VuzNy83lMpFAatO/msTdkP0FeVf/vVSF
	 ycYgD8EXycKsBWGpxQU/kCujESlcUvZCQUV9ACS3WDO6mPcrySKrqeWgp0raXKro/E
	 R7rleHaRgvpSW2sjKXjTmsHaWeDvNoH0EARlM4ZAMv8TEsjYWXbICwCgfEfH9zz26E
	 VuUm2bJ7KoXIyM880coM3OAgE95EMVt3gaa6+TVKmQP9Nt4jdrvKOU2qaQo3tGio3g
	 ujPlBy2W3q/UtMHjUHrl03Ncm6ht7UeF5I4wIS/H7I0evAPqb5HWk7lKeuPVXwGLYW
	 zhoIqlUuASjkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DD63806651;
	Thu, 13 Mar 2025 09:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] Revert "openvswitch: switch to per-action label counting
 in conntrack"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174185883400.1437903.1315270734410746330.git-patchwork-notify@kernel.org>
Date: Thu, 13 Mar 2025 09:40:34 +0000
References: <1bdeb2f3a812bca016a225d3de714427b2cd4772.1741457143.git.lucien.xin@gmail.com>
In-Reply-To: <1bdeb2f3a812bca016a225d3de714427b2cd4772.1741457143.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, ovs-dev@openvswitch.org,
 davem@davemloft.net, kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
 pshelar@ovn.org, i.maximets@ovn.org, aconole@redhat.com,
 marcelo.leitner@gmail.com, jianbol@nvidia.com, fw@strlen.de

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  8 Mar 2025 13:05:43 -0500 you wrote:
> Currently, ovs_ct_set_labels() is only called for confirmed conntrack
> entries (ct) within ovs_ct_commit(). However, if the conntrack entry
> does not have the labels_ext extension, attempting to allocate it in
> ovs_ct_get_conn_labels() for a confirmed entry triggers a warning in
> nf_ct_ext_add():
> 
>   WARN_ON(nf_ct_is_confirmed(ct));
> 
> [...]

Here is the summary with links:
  - [net] Revert "openvswitch: switch to per-action label counting in conntrack"
    https://git.kernel.org/netdev/net/c/1063ae07383c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



