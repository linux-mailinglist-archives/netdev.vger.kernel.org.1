Return-Path: <netdev+bounces-105334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90811910801
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 16:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E64281F97
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3794D1AE093;
	Thu, 20 Jun 2024 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApgRTr0h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C33B1AD4AF;
	Thu, 20 Jun 2024 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893230; cv=none; b=t1Cswqw4JniA8z2CIFFHqQJSoZXBB/oaCcYpX5qJi78+CwhN0C1jtH2O6AWJXeVtSr8oivgwdHs+ZOCD5VQVQvl2iMShPJdf43vZcAzVJoskooc2R0mJrIzHdDWyy3DwK0VLwqZzmWoDbQOqTcnZnrg+pFjuFZIPN5SubhtzmvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893230; c=relaxed/simple;
	bh=cAY4YNjsaO/pgwkfEF4denp9cphxu8+CRGJm/rhUhx0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZsZwR5FJ1hO3tm74sC1sGHhhSl3ZxIgkFFWw89g4gnKkACtNh2aL+hIdsuwrA9/SDufMvRe0ROnXmZWIl9OLUMhOBDKXRZXyNHd31kxINKSFW0LXmKDFW2+wshDYH8seSdPj6pX1HIt30cOHff1/vt+S67rJ4DDVWsmhsa9vpio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApgRTr0h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95CDFC4AF09;
	Thu, 20 Jun 2024 14:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718893229;
	bh=cAY4YNjsaO/pgwkfEF4denp9cphxu8+CRGJm/rhUhx0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ApgRTr0hKC70A6GhRdGfiuAXmp4dDjy90Kkx7SiEyG34DMI+HaT4/ECv+NzqAU1lt
	 QW9CYh14MAUuVvM/14FdJh/ksTl+dwjvEBsWBfPXkBrVlL0er5O5MoaZEsVvzqI4ON
	 hx1+vLwx1RYhUuJtRE7KZXq3l1UCYw6gjXr7O9p00WOXb04WDDoAal4qvE0Rr8Iu8z
	 V0Qam18pUVGhWKABoHV10Xc26JjJdLb1Uo72XEYbCw9iMnRUYi0mAqp3kqJ5eR0clv
	 yF9Lhkez5Z4kb4uRTd3llq2xXcNbc6arCS+fT1GnbzmgyXmc6FGXu46pkNFkZ6k2cx
	 8lVZLWND3xhnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F30CC39563;
	Thu, 20 Jun 2024 14:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: usb: rtl8150 fix unintiatilzed variables in
 rtl8150_get_link_ksettings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171889322951.30997.6577917822297455148.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jun 2024 14:20:29 +0000
References: <20240619132816.11526-1-oneukum@suse.com>
In-Reply-To: <20240619132816.11526-1-oneukum@suse.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: petkan@nucleusys.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+5186630949e3c55f0799@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Jun 2024 15:28:03 +0200 you wrote:
> This functions retrieves values by passing a pointer. As the function
> that retrieves them can fail before touching the pointers, the variables
> must be initialized.
> 
> Reported-by: syzbot+5186630949e3c55f0799@syzkaller.appspotmail.com
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> 
> [...]

Here is the summary with links:
  - [net] net: usb: rtl8150 fix unintiatilzed variables in rtl8150_get_link_ksettings
    https://git.kernel.org/netdev/net/c/fba383985354

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



