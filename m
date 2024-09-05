Return-Path: <netdev+bounces-125697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C0F96E456
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 22:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0517B22489
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 20:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28A7193400;
	Thu,  5 Sep 2024 20:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J64Ykw4Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3T+n9uxa"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AE217839C
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 20:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725569229; cv=none; b=NL5ldTDzNCaYypP45yRqJYPMsLH1XdCezcQqK6QCygb/SQlxAT2xWqRqjptn3iy7dWkWAOy3Z/UxV568hOrSwGja7A+tAck+OnnCS2JNDoz+4hkvK9AHmpjTeuTOIxMncWBh6VFz53/vPJ5zSmWB7nNfGmynzV7e45mB3yRfwxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725569229; c=relaxed/simple;
	bh=JaVu555RgEIY/q7qOnNLtt0S+FA7Sux+kbqg5HTmQkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ay2Qx+yOFUXIamie9ocm9O3MFwCkY/mfOA90EjBCEgdSkKF5cbGrhV5e1QTx5coBJUfwPjij05dJbLK4MXRdVhKVj+UPtkje/5/M9knVKH65uRiIj2i6QrKCkDjqxcYkACzx1RAcgOtUjzTbHdzQHw7zGMzL4PDAA6jMHjVgVtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J64Ykw4Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3T+n9uxa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 5 Sep 2024 22:47:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725569226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6E+7eW43UY8VAK0AMka/x4FkMFSQ8fw1ZCUCLOSpOOY=;
	b=J64Ykw4QhICksKtGtetr78UTB6vLK9qE7uIsZ17MI0Hz7vtzAmxejCubiCTEPYECduLJoa
	PlLaLRGwMRIPqUg1Bc/KI4vAvr11wbHdBEq5YDq343JaC0gqaW487/dZbQDeFkeR1FhAd0
	epUC9yz9QV1Gs04VqaXTegnm468CyI0orMDkAwymrZYucfCFuvWKxQZ/Dl9bvA80LJdTwk
	OA3n6UwBNlsn3IgGO2O2hIgGCDReG/Q8qsjEMo9N4SO0Z5G46JJII0+lST81h5wRKefARH
	Z2lk55zdwGdPyhMBKgzfSYJnYCfO5wz+zRiT1IHUrAaKZP+HBm+7+ASrEaO/pA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725569226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6E+7eW43UY8VAK0AMka/x4FkMFSQ8fw1ZCUCLOSpOOY=;
	b=3T+n9uxaoGoF9By1AryN24O+bWqVHVko4JQNyDL7eHrw6/XmEf5QG6jVh4DZ1WbpW93C3A
	LYEFQ/X4Gp3CIECw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Eric Dumazet <edumazet@google.com>, Lukasz Majewski <lukma@denx.de>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] net: hsr: remove seqnr_lock
Message-ID: <20240905204704.5PYieqpC@linutronix.de>
References: <20240904133725.1073963-1-edumazet@google.com>
 <20240905121701.mSxilT-9@linutronix.de>
 <CANn89i+K8SSmsnzVQB8D_cKNk1p_WLwxipUjGT0C6YU+G+5mbw@mail.gmail.com>
 <20240905131831.LI9rTYTd@linutronix.de>
 <CANn89iLQxH0H_cPcZnxO9ni73ncmbbhx3knzRB2swTsx=J-Fmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANn89iLQxH0H_cPcZnxO9ni73ncmbbhx3knzRB2swTsx=J-Fmg@mail.gmail.com>

On 2024-09-05 15:26:27 [+0200], Eric Dumazet wrote:
> 
> This has nothing to do with GRO.
> 
> Look at this alternative patch, perhaps you will see the problem ?
> 
> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> index af6cf64a00e081c777db5f7786e8a27ea6f62e14..3971dbc0644ab8d32c04c262dbba7b1c950ebea9
> 100644
> --- a/net/hsr/hsr_slave.c
> +++ b/net/hsr/hsr_slave.c
> @@ -67,7 +67,9 @@ static rx_handler_result_t hsr_handle_frame(struct
> sk_buff **pskb)
>                 skb_set_network_header(skb, ETH_HLEN + HSR_HLEN);
>         skb_reset_mac_len(skb);
> 
> +       spin_lock_bh(&hsr->seqnr_lock);
>         hsr_forward_skb(skb, port);
> +       spin_unlock_bh(&hsr->seqnr_lock);
> 
>  finish_consume:
>         return RX_HANDLER_CONSUMED;
> 

This does not trigger any warning while testing (warning as in recursion
or so). The other invocations have the lock so it should work.

This did not trigger earlier because hsr_handle_frame() is invoked from
the Slave-Interfaces which don't assign a seq-nr.
syzkaller might have managed to receive the packet from the
master interface. Or it is the interlink which is new and was added in
commit 5055cccfc2d1c ("net: hsr: Provide RedBox support (HSR-SAN)").

Did the bot leave a reproducer? I'm wondering if the packet is dropped
later in process. I can't test interlink right now, my `ip' seems not
recent enough.

Assuming it is a interlink packet, I would suggest to acquire that lock
as you suggested. I can send a patch if you wish. Added Lukasz Majewski
on Cc who added interlink support, maybe he can say if this is a legal
path.

Sebastian

