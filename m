Return-Path: <netdev+bounces-219384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360C2B4112E
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 02:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12999546A20
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 00:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFF02AF00;
	Wed,  3 Sep 2025 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxVbCRsZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98766139D;
	Wed,  3 Sep 2025 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756858208; cv=none; b=oL2z1V9TOOfGYdc1kcalkoSZoUFIOZG6VRpShl77Q6xjtF/LgfIQbaO5Dqjk9c4HoSN+Qb9+RkiN05i4zSKdiSYfFuYODrmqiMn0cex6tYrF7WY6q5S/gUdJSe5TO0W/nIA/Z6EOJLWhv5xJ8th5611/ibNSLyiEGTYPNZuCHvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756858208; c=relaxed/simple;
	bh=7t65t+pa0YCFZd4Pjv7Dvwx9VGOTWFpmCGuJMooS0dE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QL3VL5kCt8WNEoMD7fVlj0yTHBJZoY9qAHSgtiYCkKCs342sNr7VDQnh6M33AO8U3Ue7sUrl1l91LngiSLjaHjEeYsK4CfZ27mEDzRfWqLGp+OPvAZGgZmIhG5eNZ5zg2t69DPwvrcm/bl0jgK0dH+L2/0962y9CVXyDvt45jEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxVbCRsZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2376FC4CEF4;
	Wed,  3 Sep 2025 00:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756858208;
	bh=7t65t+pa0YCFZd4Pjv7Dvwx9VGOTWFpmCGuJMooS0dE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XxVbCRsZ7p/Yq8bkR185s2W40whHBXVAFkH4l0zS1I7Kl8jBB0Bp9TghItnURgX5K
	 dddfmREkkGmjkHmu7tvFhICb2ORI0ziB2AQZ8mORArSEpJjPYBmOU2t8jVS6Va/mp7
	 7GVhnLTWdko91VGsxq3AQ+BYYVCITQj8OxM/X0ivkZlDX7ULblwq9PY08dlqjLX9GT
	 ezMHg6U1ft3pZl+TFltTHhUdtuTDOd3bJloJIjNI9cYes9m2ryiPMVdnBlWdp7H5LD
	 h8qElq05nYerxMWafcj9DVB5s88Z61o0BpbfUO8Kd2XYtopdawl1PwhyuDosRJPq+S
	 CMc8Z6W9i0iRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDCD383BF64;
	Wed,  3 Sep 2025 00:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/2] ipv6: improve rpl_seg_enabled sysctl
 handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175685821323.475224.6132941673804776469.git-patchwork-notify@kernel.org>
Date: Wed, 03 Sep 2025 00:10:13 +0000
References: <20250901123726.1972881-1-yuehaibing@huawei.com>
In-Reply-To: <20250901123726.1972881-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 1 Sep 2025 20:37:24 +0800 you wrote:
> First commit annotate data-races around it and second one add sanity check that
> prevents unintentional misconfiguration.
> 
> Yue Haibing (2):
>   ipv6: annotate data-races around devconf->rpl_seg_enabled
>   ipv6: Add sanity checks on ipv6_devconf.rpl_seg_enabled
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/2] ipv6: annotate data-races around devconf->rpl_seg_enabled
    https://git.kernel.org/netdev/net/c/3a5f55500f3e
  - [v3,net-next,2/2] ipv6: Add sanity checks on ipv6_devconf.rpl_seg_enabled
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



