Return-Path: <netdev+bounces-224996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB198B8CB70
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 17:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E48189B648
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 15:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AB51EB5C2;
	Sat, 20 Sep 2025 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oeHi3YvS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869C0219301;
	Sat, 20 Sep 2025 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758382268; cv=none; b=UEY57LssJgkBXpSkRGJQI/ve3wdUqzBsW9KUVlB+pCO5+BRQLr7EHziqIMg2vQKVyI7S9sTgN9SNHYY/cBumQqwBgYwoIdYHjK4NxDjfRFpJ2KLTCM21LHqABSPYXcER1KxBkujjE+hvInH9Ojcpmksw5emAlg8YK8fqn2JVVyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758382268; c=relaxed/simple;
	bh=VmpXs+T5FJFMh9uMlfY1zO0F1J8+Bi53OUp0N4Q+6Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RC8dO5PrXiQrx0U5tEQxQWHV0Gp0MacnnD7iEEgpociJ52IjpFa+sFhhHcBAhs9/v1bbEOyOeTlzdwCwLqf1ycCDa4WcV32R0ueGCgtYypPcE5i5a7WbltTD2fSC7mo0o4jyeLoVc3fcG/+AbtlS4HjyjXk5wNp9TnuZpWCscZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oeHi3YvS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=l3P7xbNm51dRG4YbNP1VYdE4uOUg89upg8bJchvamQY=; b=oeHi3YvSJt50OQWpfvMD3AnU28
	IBiODy924lqyKQsQ74HLH6chjOVrcyJIGZ7Lj2lk9xcLEQFW5wk2WqNdrJwWHW4+boq8lmbuUqACa
	4qqSk1nGV8gMO/iuq9+R7fvIpBslDj0JnT26ZrOQP3V1OaUHpgcsDt/PtQQoicW5+YWY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uzzXo-0091G0-9s; Sat, 20 Sep 2025 17:30:36 +0200
Date: Sat, 20 Sep 2025 17:30:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: petkan@nucleusys.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com,
	syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
Subject: Re: [PATCH] net: usb: Remove disruptive netif_wake_queue in
 rtl8150_set_multicast
Message-ID: <5b51d80e-e67c-437d-a2fc-bebdf5e9a958@lunn.ch>
References: <20250920045059.48400-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920045059.48400-1-viswanathiyyappan@gmail.com>

On Sat, Sep 20, 2025 at 10:20:59AM +0530, I Viswanath wrote:
> syzbot reported WARNING in rtl8150_start_xmit/usb_submit_urb.
> This is a possible sequence of events:
> 
>     CPU0 (in rtl8150_start_xmit)   CPU1 (in rtl8150_start_xmit)    CPU2 (in rtl8150_set_multicast)
>     netif_stop_queue();
>                                                                     netif_stop_queue();
>     usb_submit_urb();
>                                                                     netif_wake_queue();  <-- Wakes up TX queue before it's ready
>                                     netif_stop_queue();
>                                     usb_submit_urb();                                    <-- Warning
> 	freeing urb
> 	
> Remove netif_wake_queue and corresponding netif_stop_queue in rtl8150_set_multicast to
> prevent this sequence of events

Please expand this sentence with an explanation of why this is
safe. Why are these two calls not needed? The original author of this
code thought they where needed, so you need to explain why they are
not needed.

    Andrew

---
pw-bot: cr

