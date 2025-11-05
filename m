Return-Path: <netdev+bounces-235656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA9EC33984
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 02:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5813B4285A1
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 01:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E9B255F31;
	Wed,  5 Nov 2025 01:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtmWGRVS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B21253950;
	Wed,  5 Nov 2025 01:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762305042; cv=none; b=tx3bsyqduBhSLtze10GSAUG8VMwDBloc+o0rxUxbVf7Kfq1Tmo6PBof9unGywe8buJhqm6zef34vApybGT7sorgK7kisA49QYbacDbPfmjyEPTkZmxzYNKJqxcW+HztiJAgFQf2RjDuxACX09yrY6lH4TrR5D9oLUjio3P9z5TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762305042; c=relaxed/simple;
	bh=y2L9qWm7lVvSl6LGUzqpLXLrlGl1utfai5roLg1NNQk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eMVA9/P+q0vSjb06Zm/F9/II5lO1120NDsWEXsObiHU0ChRWGzzV5wqZzL/cUBcJlnnl6g4LsNKim6G8OGwnxy4b6n1Wj9p40ZzXcgjTlKIRlVNqbAW44w4e2zpMvZV7dZRfAfS5rzWeI4NQ5EIYoBrlvSxCJV1800rUdvWKJ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtmWGRVS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62828C116D0;
	Wed,  5 Nov 2025 01:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762305042;
	bh=y2L9qWm7lVvSl6LGUzqpLXLrlGl1utfai5roLg1NNQk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XtmWGRVSb6I4rD34kjuTUi6R9fauoOtkN3e9qpFdNnpEfNKI3D9tt5LeKm3PEjBRA
	 ff5mzFqnMrjbgERXI2i+rKtwwSQlPYDpYX/tg4pueC16JbIxhFfDBLKPXWooN+Rt1r
	 s5uypyclP8HzJLhUCfzRj2Wzkn3G7EDFpGY6Ei9GIIumofwKlo/QBoJTrjE4mWv5mV
	 HOXm6R13ciq2HpchI/WRDY8xu5h+/0zXwMSW7yj+47+VK3IOLQIThbU9RwZk4LEfhF
	 /p44sZrRaX+Ow4Y0rTXEwNV512uIxOJVTE/Q3xhAkrvU0/IIYo+t3Z8roiwcYQ99ze
	 uHoZxsCubvztQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70A6B380AA54;
	Wed,  5 Nov 2025 01:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] virtio_net: Fix a typo error in virtio_net
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176230501599.3047110.9620420576012479457.git-patchwork-notify@kernel.org>
Date: Wed, 05 Nov 2025 01:10:15 +0000
References: <20251103074305.4727-1-chuguangqing@inspur.com>
In-Reply-To: <20251103074305.4727-1-chuguangqing@inspur.com>
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 3 Nov 2025 15:43:05 +0800 you wrote:
> Fix the spelling error of "separate".
> 
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - virtio_net: Fix a typo error in virtio_net
    https://git.kernel.org/netdev/net-next/c/f4b2786fb14b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



