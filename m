Return-Path: <netdev+bounces-226369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E330B9F9C2
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 15:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2EA3A227D
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 13:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F6F2727E6;
	Thu, 25 Sep 2025 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQP6B6mL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FEE26E6E1;
	Thu, 25 Sep 2025 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758807610; cv=none; b=qH5P+vwLPUZQRQhrcrDVu8trb2zIBAYkAy4/GLyEeINdbNdvBtWUbqYnugK628MDHh+pg2ANKa/cFrbt2iM92eCUXjObyySL15V7WTaSzQ0eWJOmyEp6W/Z45AzcpBWdU13JhZ39u45Pj1SNKMbw9sw0cecuJKpOFx8k5l6wYBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758807610; c=relaxed/simple;
	bh=JnOwVIpGpVzxV4Y6Wdml0j81r/GFoPs26eqDZ9ooP6Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UbPcJLHh8YPsG3oC+Y1Xnnea9Nad5bY5dph4hw6xwLosordqvJkQyhw3HZ2cbuHnsEoU7nwk+e23yW8pI2aFAzFZdn80NOFgU94Y/H7l4KJxP91lgcDzGEwbT27crD5uh9rPcX2znzVKhIpVkD6tCIk+mfgg0rFqlSasOlKljDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQP6B6mL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43366C4CEF0;
	Thu, 25 Sep 2025 13:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758807610;
	bh=JnOwVIpGpVzxV4Y6Wdml0j81r/GFoPs26eqDZ9ooP6Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SQP6B6mLiiOnGee5X4RiregiXVrJVROcuMAMU/yjJK/4Z8s6w5ZBfA+W4ktyWOyT1
	 qWyKib5Sx9U8Ufqfunua1A1T9p0xrUVQZ83/OxIRJO32kIWMkT8ywyKTP33K8hhklx
	 ko6idbSacmtrnYajNUP1od+TXaTcMPYBJvy/zsoxSVe9O3gFwZ/PyWWDFUsKvpTvOv
	 q/+fXoRpldLw0drS6Bedvmbjspl2b6aZVRrMMra3AKTmDR7OgaBLLaZiGrvqlr+H7V
	 9IV1mWn5wAhBTV5kPZj+gR894jLm1gJGITLznB3WOKJLi3uJjS2IqOqzk/w4VnmwVc
	 oKKjH/zCrRskQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7111C39D0C21;
	Thu, 25 Sep 2025 13:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2][next] Bluetooth: Avoid a couple dozen
 -Wflex-array-member-not-at-end warnings
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175880760625.2984149.17268227498282852314.git-patchwork-notify@kernel.org>
Date: Thu, 25 Sep 2025 13:40:06 +0000
References: <aMAZ7wIeT1sDZ4_V@kspp>
In-Reply-To: <aMAZ7wIeT1sDZ4_V@kspp>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 9 Sep 2025 14:13:35 +0200 you wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the __struct_group() helper to fix 31 instances of the following
> type of warnings:
> 
> 30 net/bluetooth/mgmt_config.c:16:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 1 net/bluetooth/mgmt_config.c:22:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> [...]

Here is the summary with links:
  - [v2,next] Bluetooth: Avoid a couple dozen -Wflex-array-member-not-at-end warnings
    https://git.kernel.org/bluetooth/bluetooth-next/c/33c9dc51e8b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



