Return-Path: <netdev+bounces-225977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6705AB9A26C
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 16:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25322322580
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 14:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FB621423C;
	Wed, 24 Sep 2025 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nucleusys.com header.i=@nucleusys.com header.b="iUBDqjfL"
X-Original-To: netdev@vger.kernel.org
Received: from lan.nucleusys.com (lan.nucleusys.com [92.247.61.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC114A3C;
	Wed, 24 Sep 2025 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.247.61.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758722717; cv=none; b=Wq1znSqnUdPM8hqFuUp5riD+pk34iFtu6R5r4cQ3g44A0KGTeB3cvLyDBhEZOATNqeyxsnoJpw9fBxA9mb8rDv5RGSOZf0LsUsuyT2XIS/poqRyiab4xZf2N7/DtBLfGvtoUo7ynbHw0OrQsg4RI+bFoIfM/EjTWKzmLNTLQFus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758722717; c=relaxed/simple;
	bh=minEcWUjTwDz7RlfoM9/JlDnRLWlpos7Kk7PzRMbms0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmPmA12FtEezSO88WiGeHUmOMZdbqDM2GKFoYr1po3IduD9AyYDWYbUykq+mU5JnP5qPLlSfsQScChEpjDhw4GgMF4E8wGoa3jeqCpdyVCqOplfgqgZBydI6iLIA4N872twCVZ3up1GLziHnqBXvQ4ZSY9s+znoljAEBmoswVCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nucleusys.com; spf=pass smtp.mailfrom=nucleusys.com; dkim=pass (2048-bit key) header.d=nucleusys.com header.i=@nucleusys.com header.b=iUBDqjfL; arc=none smtp.client-ip=92.247.61.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nucleusys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nucleusys.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nucleusys.com; s=xyz;
	t=1758722299; bh=minEcWUjTwDz7RlfoM9/JlDnRLWlpos7Kk7PzRMbms0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iUBDqjfLX76ppr6FPR0MSpHrrWkSFUsM+T+tKMaILSR/QQhqQMk7U8cZBA9xQEs0X
	 RK3RCyL6eL+BztPXqeFibOw1XvLRsknR/12AstOtIZWh+N29zBuiYklFabCItIAsXg
	 ysrIL8bGTHahdz8TBc/lP8NaTsWtkVkpdwZaECrFQXFj91k7zBYuRThU9NPu9rpI6l
	 M9qorlAcRjyXT2pOtwcLVwyH/DFNKJhZGo/GoAewDnvOwrMTYwhta8PUNL4A/QqtoW
	 +hqRX3LaNLGVQTG4G+GHmEa1Tq4EfjssbDdDG/v8o70myN5YzJNMGxZMK13YhTzIva
	 W0WiE0w4z/Gqg==
Received: from cabron.k.g (unknown [95.111.117.177])
	by lan.nucleusys.com (Postfix) with ESMTPSA id D8C8C3FC0B;
	Wed, 24 Sep 2025 16:58:18 +0300 (EEST)
Date: Wed, 24 Sep 2025 16:58:14 +0300
From: Petko Manolov <petkan@nucleusys.com>
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: kuba@kernel.org, michal.pecio@gmail.com, edumazet@google.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, pabeni@redhat.com,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com,
	syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
Subject: Re: [PATCH net v3] net: usb: Remove disruptive netif_wake_queue in
 rtl8150_set_multicast
Message-ID: <20250924135814.GC5387@cabron.k.g>
References: <20250924134350.264597-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924134350.264597-1-viswanathiyyappan@gmail.com>

On 25-09-24 19:13:50, I Viswanath wrote:
> syzbot reported WARNING in rtl8150_start_xmit/usb_submit_urb.
> This is the sequence of events that leads to the warning:
> 
> rtl8150_start_xmit() {
> 	netif_stop_queue();
> 	usb_submit_urb(dev->tx_urb);
> }
> 
> rtl8150_set_multicast() {
> 	netif_stop_queue();
> 	netif_wake_queue();		<-- wakes up TX queue before URB is done
> }
> 
> rtl8150_start_xmit() {
> 	netif_stop_queue();
> 	usb_submit_urb(dev->tx_urb);	<-- double submission
> }
> 
> rtl8150_set_multicast being the ndo_set_rx_mode callback should not be calling
> netif_stop_queue and notif_start_queue as these handle TX queue
> synchronization.

netif_[stop|wake]_queue() should have been removed from rtl8150_set_multicast()
long time ago, but somehow it has slipped under the radar.  As far as i can tell
this is the only change needed.


		Petko


> The net core function dev_set_rx_mode handles the synchronization
> for rtl8150_set_multicast making it safe to remove these locks.
> 
> Reported-and-tested-by: syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=78cae3f37c62ad092caa
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Tested-by: Michal Pecio <michal.pecio@gmail.com>
> Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
> ---
> v1: 
> Link: https://lore.kernel.org/netdev/20250920045059.48400-1-viswanathiyyappan@gmail.com/
>  
> v2:
> - Add explanation why netif_stop_queue/netif_wake_queue can be safely removed
> - Add the net prefix to the patch, designating it to the net tree
> Link: https://lore.kernel.org/netdev/20250920181852.18164-1-viswanathiyyappan@gmail.com/
>  
> v3:
> - Simplified the event sequence that lead to the warning
> - Added Tested-by tag
> 
>  drivers/net/usb/rtl8150.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
> index ddff6f19ff98..92add3daadbb 100644
> --- a/drivers/net/usb/rtl8150.c
> +++ b/drivers/net/usb/rtl8150.c
> @@ -664,7 +664,6 @@ static void rtl8150_set_multicast(struct net_device *netdev)
>  	rtl8150_t *dev = netdev_priv(netdev);
>  	u16 rx_creg = 0x9e;
>  
> -	netif_stop_queue(netdev);
>  	if (netdev->flags & IFF_PROMISC) {
>  		rx_creg |= 0x0001;
>  		dev_info(&netdev->dev, "%s: promiscuous mode\n", netdev->name);
> @@ -678,7 +677,6 @@ static void rtl8150_set_multicast(struct net_device *netdev)
>  		rx_creg &= 0x00fc;
>  	}
>  	async_set_registers(dev, RCR, sizeof(rx_creg), rx_creg);
> -	netif_wake_queue(netdev);
>  }
>  
>  static netdev_tx_t rtl8150_start_xmit(struct sk_buff *skb,
> -- 
> 2.47.3
> 

