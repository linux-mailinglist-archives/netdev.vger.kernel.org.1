Return-Path: <netdev+bounces-226805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9458BBA54EB
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 00:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52141B24BDE
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 22:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830AC28E5F3;
	Fri, 26 Sep 2025 22:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5eMUXVn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0EC1D6187;
	Fri, 26 Sep 2025 22:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758925212; cv=none; b=KqHxzByurAHTqeshHNgXxQeIW0zOVAwX8fb38v28TOZg7OOh4Yei0+DlngdhzVaPT5A245DkvHE1fdsjApai+XQHNYNuS/6FA6kuG78rlgqOxMZOUr5UQ+wV3yZKaHN7SjAHAy2nTAbaKmKf7B8TvZN4cyHiA6PfPoY/NPqHebk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758925212; c=relaxed/simple;
	bh=eLbeqUenCFCgz26YQfIMXaXq2qvZQp7IfzdLaObldT8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cLiBvZlt9aSz55+0Ph11xJ7/CTVZ7AASGCnBl2UXzCAS67ysD/N4z1v6T09I3fabwYZ/VZTMS12hgvjkkKSqtXqUiwO+99zyyJn23UGQh6mAFZzY22Nny7+S6pw+nzTtl2+OQ2Q57yzOug+jMrLiBppyO59caccqKm7hP2CVYnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5eMUXVn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CA1C4CEF4;
	Fri, 26 Sep 2025 22:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758925211;
	bh=eLbeqUenCFCgz26YQfIMXaXq2qvZQp7IfzdLaObldT8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q5eMUXVnk2cATiQ/BbURcfhPI3FY33E7EXpvLTkfxDGDGD1dPE6vHCo6B63Ay9kp1
	 K0U9+IIXrVc/ENhDVdmVY5pDkG3Z8HK60S8ly2OHrNTkDDIm3OcFh2bkHoKzCtLaVP
	 JKdt+Im3YLf3k5oyls73/2VZeSewOkQbhnNWwWk/vP7W9xKC20mH6I1agyHDGc5cKh
	 8W0rr5kfh3L41lgJPLdm4O0R4vnocyKBspFe3uXV/rI7Jvj/gcdrUPJ/k2zrUa3fT6
	 +LgX+jGuCUH+OzadB8y6mF0aBqYwPdc6O5C4Cga9HaVsCAZU5Xsj8R5yTQmQiXAdGc
	 TOienoHlacWzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E7839D0C3F;
	Fri, 26 Sep 2025 22:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: usb: Remove disruptive netif_wake_queue in
 rtl8150_set_multicast
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175892520700.77570.4782779943018588705.git-patchwork-notify@kernel.org>
Date: Fri, 26 Sep 2025 22:20:07 +0000
References: <20250924134350.264597-1-viswanathiyyappan@gmail.com>
In-Reply-To: <20250924134350.264597-1-viswanathiyyappan@gmail.com>
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: kuba@kernel.org, michal.pecio@gmail.com, edumazet@google.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, petkan@nucleusys.com,
 pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com,
 syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Sep 2025 19:13:50 +0530 you wrote:
> syzbot reported WARNING in rtl8150_start_xmit/usb_submit_urb.
> This is the sequence of events that leads to the warning:
> 
> rtl8150_start_xmit() {
> 	netif_stop_queue();
> 	usb_submit_urb(dev->tx_urb);
> }
> 
> [...]

Here is the summary with links:
  - [net,v3] net: usb: Remove disruptive netif_wake_queue in rtl8150_set_multicast
    https://git.kernel.org/netdev/net/c/958baf5eaee3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



