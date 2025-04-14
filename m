Return-Path: <netdev+bounces-182391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD74A889F1
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 19:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5F63B48B9
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A6D274641;
	Mon, 14 Apr 2025 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtMKiUok"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF782DFA3B;
	Mon, 14 Apr 2025 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652249; cv=none; b=J+urJ9SpUVJ1wNugelSFnl0hEnokgJWZe/YZUjjFxcdAFmsDF6tyiEPm7eBTFdkA0GzyT1Ow4seEoAJih+JTsE6iIX8j81PKMmZHnaSY5ofmr2n0pQjzQQySOvYk+kdfyu/ICA/JtIDd59rQuujFkeZeHUGSyua+cbWroCCac5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652249; c=relaxed/simple;
	bh=bv3JKaNt5rx0LnwZ1DOrPwjLkqw6RVsySzVRPn8KFwc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HOJa80rJuP6t9mkVhaH4S6DbIKOvD2eeGMkJyappaNmaqUBD9bx1c+90yl6Ehr/TcyEpZ3FQORb2Pf2VzgY8kWqo6yDZh8+qTHMK1Ucr0Uc2zYaIZDpuiIGmUJx2iGmAl3giUnC95+S8GxyDR7o33r+6kaEyIoewtRYpxrlS9ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtMKiUok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915ABC4CEE2;
	Mon, 14 Apr 2025 17:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744652249;
	bh=bv3JKaNt5rx0LnwZ1DOrPwjLkqw6RVsySzVRPn8KFwc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UtMKiUok7FM2vHx7iVPzBMdDnSKkEIgdvBTqIlcNK0utqs2dV/9dmN6DjWJKlCPKn
	 7cVsd2ZJHgcSxPPrDWyGnEDzLgzqZVs7xcMsYmiIrYGO1VqhZ8AjxFidFzXitVmFDf
	 ZoTxzxf3Uq63+D3einbLEUYZsLF/1SBX7tDMYvmfrxHLVb5tsvupavzXHtCJRZS1j9
	 k02a9aORyFXj6ttDLM6W+4WIgoCypDYIHNLCmSlhMFlczX3WOjV1779MMVu22ffEH8
	 b+/VDbRoAM0/xobEsPMpoNyN04XYuutAA9ULdyNioHO6bFnIE2ipVWPny5f3kFENbj
	 hoAcJCDtmPrTw==
Date: Mon, 14 Apr 2025 10:37:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <syzbot+de1c7d68a10e3f123bdd@syzkaller.appspotmail.com>,
 <cratiu@nvidia.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <horms@kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <pabeni@redhat.com>, <sdf@fomichev.me>,
 <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] general protection fault in rtnl_create_link
Message-ID: <20250414103727.0ea92049@kernel.org>
In-Reply-To: <20250414023048.44721-1-kuniyu@amazon.com>
References: <67fc6f85.050a0220.2970f9.039e.GAE@google.com>
	<20250414023048.44721-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Apr 2025 19:30:46 -0700 Kuniyuki Iwashima wrote:
> diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
> index 5706835a660c..270e157a4a79 100644
> --- a/include/net/netdev_lock.h
> +++ b/include/net/netdev_lock.h
> @@ -30,7 +30,8 @@ static inline bool netdev_need_ops_lock(const struct net_device *dev)
>  	bool ret = dev->request_ops_lock || !!dev->queue_mgmt_ops;
>  
>  #if IS_ENABLED(CONFIG_NET_SHAPER)
> -	ret |= !!dev->netdev_ops->net_shaper_ops;
> +	if (dev->netdev_ops)
> +		ret |= !!dev->netdev_ops->net_shaper_ops;
>  #endif

This is a bit surprising, we pretty much never validate if dev has ops.

I think we're guaranteed that IFF_UP will not be set if we just
allocated the device, so we can remove the locks in rtnl_create_link()
and to double confirm add a netdev_ops_assert_locked_or_invisible() 
in netif_state_change() ?

