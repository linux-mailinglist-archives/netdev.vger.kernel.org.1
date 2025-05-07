Return-Path: <netdev+bounces-188523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA9FAAD2F7
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 03:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A489822EF
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 01:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB33156228;
	Wed,  7 May 2025 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXeWerSe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA4A4B1E5F
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 01:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746583189; cv=none; b=dXyM2CaLtwq59eUqTo7ya04VSo6iLPwXx/j4U9yniUOTQmKy8K7zwuXat3LsdoNC3IwRivHEd5l4DaDo1hpctOwmlBJH0a2k2oTc6fW1GHck4qkhZ9Jv3k9hBY1lYZrTVPFltu2Afs9XHcSFIgVL21vn8ccl1zl0uzjNYI7jdfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746583189; c=relaxed/simple;
	bh=heYj8KHMbipMXSQKHrYGOjhoY4NXK5zK5fRx0SLkcOA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ff3JL7gLhoWNNB+mDQGEFjJ++AsXeChZfJYAih0W+u9wtoJUBS8N5d5wRBBUtSxDr20nWyHyeHBEtgJ71LEbpIefVB8ZITBnVu2gqC7sAE22dfaj6n8zSNWBO5+soDwzTnVWA52X7yGOMQhcClPJOxCCczr4g373SFi7VAp9tbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXeWerSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE5DC4CEEB;
	Wed,  7 May 2025 01:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746583188;
	bh=heYj8KHMbipMXSQKHrYGOjhoY4NXK5zK5fRx0SLkcOA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dXeWerSekPt6gKSqxBDvpCdhisnfdc5xCXWJtok122iHzFeedXpoyJSq9w/wW7SJj
	 Zu5yzhJASD7ogC+IjTQhctb+GTkmAchPiHLseChOAHR39RQbDy9vm5cqXZIWu9mEz1
	 XQ4jSHfjRkLcscv13SvOlCruckzuHVdBYjN+us+HfBuZzUsn08Becfkwxcxe3tT7mH
	 yAwLNEAaxNPuuHu8wkqob0bOjZlhHPLxyYV9694FnTtGWU5h8I20bd1qKQFtqstyUR
	 UE94vq4JP27fqD1HF2RjrTGA8s3eljCVxLUq6Uuvvmya4dv7ecwHxKsuEIe2UM6XiX
	 L4i1vnIi/Os0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACE0380664B;
	Wed,  7 May 2025 02:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ice: use DSN instead of PCI BDF for ice_adapter index
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174658322775.1708611.17170825514022969775.git-patchwork-notify@kernel.org>
Date: Wed, 07 May 2025 02:00:27 +0000
References: <20250505161939.2083581-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250505161939.2083581-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 przemyslaw.kitszel@intel.com, karol.kolacinski@intel.com,
 sergey.temerkhanov@intel.com, michal.kubiak@intel.com,
 aleksandr.loktionov@intel.com, jacob.e.keller@intel.com, mschmidt@redhat.com,
 horms@kernel.org, jiri@resnulli.us, sx.rinitha@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 May 2025 09:19:38 -0700 you wrote:
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Use Device Serial Number instead of PCI bus/device/function for
> the index of struct ice_adapter.
> 
> Functions on the same physical device should point to the very same
> ice_adapter instance, but with two PFs, when at least one of them is
> PCI-e passed-through to a VM, it is no longer the case - PFs will get
> seemingly random PCI BDF values, and thus indices, what finally leds to
> each of them being on their own instance of ice_adapter. That causes them
> to don't attempt any synchronization of the PTP HW clock usage, or any
> other future resources.
> 
> [...]

Here is the summary with links:
  - [net] ice: use DSN instead of PCI BDF for ice_adapter index
    https://git.kernel.org/netdev/net/c/0093cb194a75

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



