Return-Path: <netdev+bounces-112586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215B493A142
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D105228229B
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F6C153804;
	Tue, 23 Jul 2024 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0f0EwB7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F541527BE
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721740833; cv=none; b=d94AM9L8cCHFQMojwpcBqHPDdZvPyIKY5TtxV8NM4O0m2kdn4011HFIb0zXBeGvJt+K8ispHmFE4pyAsikikuP4/UC6fammbnRY96gOJtHd4nyXGlO6wpgu5y/rSiyIoxMdSGXm4mT5E0DCs4K2om4W59RHBcwf9NrynMRzCBbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721740833; c=relaxed/simple;
	bh=wDKrGVyLrjQyeFdGAq7Nkj7xzBtXA5ZbMZJrEZIJihM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aV76KIoejq4w+5hVLEYcNf8YO91I4M/u6NHz9wbo1WrP2HUD/tyWl2TW2DYKsJKJfzacsL01xfIsnR5fXoQXxLVuhIoLSPrxdKqwpkTexl7byrbYX484JmAV7GGmFHQLotX+sy+vWNY0ErvacAKZtPuO3/eRny4H/TIdGl71O4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0f0EwB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E025AC4AF0F;
	Tue, 23 Jul 2024 13:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721740832;
	bh=wDKrGVyLrjQyeFdGAq7Nkj7xzBtXA5ZbMZJrEZIJihM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a0f0EwB7tZellhVLzhm37mKyppPs/TzbNJvO5+8BMG8rrWFT8/pJCjbda9LxkocjT
	 vKtd9avNs5n2pio8IJyupG6m94ALqJ++piMViJdIvQPX3yo2X4ofMlLrpbRoEfuVT/
	 Rwz7pgG+OEWEn72ei5zr5aS8sZQw4MBarV+XtWwBTX0BJGkthxMf0zgmbkBbeKCp7Y
	 zP6EGdxBdcJDq+ftucqa8Sh8Ee4geAjPzb1Zo82JzPDkp88g0BZyQIzwpiMEbVepZ/
	 wmQgXRwEUJXNlGqpdhRRRAgvsFe8cZ9oRl57NGgr+Z4rNX8LvHQf8GFeYdB1A9p9QV
	 6C/rQVKRqamoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB1CBC4333D;
	Tue, 23 Jul 2024 13:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: bonding: correctly annotate RCU in
 bond_should_notify_peers()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172174083282.27427.8145333747572048841.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jul 2024 13:20:32 +0000
References: <20240719094119.35c62455087d.I68eb9c0f02545b364b79a59f2110f2cf5682a8e2@changeid>
In-Reply-To: <20240719094119.35c62455087d.I68eb9c0f02545b364b79a59f2110f2cf5682a8e2@changeid>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, j.vosburgh@gmail.com, andy@greyhouse.net,
 johannes.berg@intel.com, jiri@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 19 Jul 2024 09:41:18 -0700 you wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> RCU use in bond_should_notify_peers() looks wrong, since it does
> rcu_dereference(), leaves the critical section, and uses the
> pointer after that.
> 
> Luckily, it's called either inside a nested RCU critical section
> or with the RTNL held.
> 
> [...]

Here is the summary with links:
  - [net-next] net: bonding: correctly annotate RCU in bond_should_notify_peers()
    https://git.kernel.org/netdev/net/c/3ba359c0cd6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



