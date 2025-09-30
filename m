Return-Path: <netdev+bounces-227271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FB9BAAF0F
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 04:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 699C93AAC11
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 02:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E52C211A09;
	Tue, 30 Sep 2025 02:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2yokN6T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0819F20E334;
	Tue, 30 Sep 2025 02:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759197620; cv=none; b=kbWIjwzlDOSODg6Mr7ErZqZ45CcqyfXaU6Y0fmZOzYCVrgzBckQJhuowS9cA3ubgZngZNi8FgTHR0WvWwu3Dtrxi1DT91Fgm8MmzFzXqmEjEI0jLAuWU5j9qlvQdbSB5ttL6gCjlLX+RQ87jI+UHzfD5SpY/pjw7l6wvv144laY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759197620; c=relaxed/simple;
	bh=Iix9BDzZZc+Fv0GgMwl1KxhXx/NL85SDwSwPskElB6U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aRUUyKHlLkdWj2uBxFqNM6UgLkTSoBCIzHvYioMCqDxYxGixI0b4LhleD3kwIUdetge2mrXhtnXD0MBXz0tG1WLTki/HO/e+3KjtkfkoMtl92H0S9rWeZqPER2jBewtfO60bMYivXRryv97LYcrchj2IXHH6kEZQu5mLXmEe42w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2yokN6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD98C19421;
	Tue, 30 Sep 2025 02:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759197619;
	bh=Iix9BDzZZc+Fv0GgMwl1KxhXx/NL85SDwSwPskElB6U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t2yokN6Tsd1LPvrZxcHcRnzqHlcG/HqEK7q+ZwAYAJEDWzrNFlz4aAVY8VCwKSXzz
	 +E4Gbrg+cHFxSfe46ZhMaZ1zJKms3Je54UoLE1gdeu95ehlr9by7t+KXdNJZXanZDJ
	 yu37az7DCBEpHhqXhxAZmXszqHfoQUhAKFPN6BhjlPhlV5cdQChARZ8rx1Yjg0vHeh
	 hnlXBp2Ymx6mffFNRVRg5tdlq5GFL868h0LCchfJDpj03zOx0ItlrpR8pYJScoa3j4
	 eV7gpaKvDomstXfGurA8DSaKdO0sqL7UIT4rvkpx+dGbJ50TXhF8HPphKe+gGtcOVM
	 8qXLdprj+aMnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 345D939D0C1A;
	Tue, 30 Sep 2025 02:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: dlink: handle copy_thresh allocation failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175919761300.1786573.1621683119004244091.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 02:00:13 +0000
References: <20250928190124.1156-1-yyyynoom@gmail.com>
In-Reply-To: <20250928190124.1156-1-yyyynoom@gmail.com>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew@lunn.ch

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Sep 2025 04:01:24 +0900 you wrote:
> The driver did not handle failure of `netdev_alloc_skb_ip_align()`.
> If the allocation failed, dereferencing `skb->protocol` could lead to
> a NULL pointer dereference.
> 
> This patch tries to allocate `skb`. If the allocation fails, it falls
> back to the normal path.
> 
> [...]

Here is the summary with links:
  - [net,v4] net: dlink: handle copy_thresh allocation failure
    https://git.kernel.org/netdev/net/c/8169a6011c5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



