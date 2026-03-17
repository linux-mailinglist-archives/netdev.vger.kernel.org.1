Return-Path: <netdev+bounces-268734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFA6C2y2uWnJMQIAu9opvQ
	(envelope-from <netdev+bounces-268734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 21:15:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A284B2B21B8
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 21:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23E3E303EC04
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 20:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC0B37B00F;
	Tue, 17 Mar 2026 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="mNRO7niY"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2D4346771
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 20:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773778308; cv=none; b=SZz0dkWwnh1fv3LfwfJDGB6XxgjVndkHaqmvk0balGXVgdRUbMW8WkDEd7R8TYhA9Xne3jSv9JrzP7WSCYsK9lnTBlvtNfLBPUAGp7Hnt6yiKtAV81OvBA+7GSgQOyAOZipOF4wwsuNYR81Wy33Ikww1TQ6H27JoxJMcImovDy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773778308; c=relaxed/simple;
	bh=rvO+4S75LTdAcT1JADZgoSDSzZpbdmjE6Tv0S8Da7jk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=eLKDkrtPm0e+CtEqOov3jJpbmeKAadV3bSFiVJZk6dVQlxwh8pvc6ZTzd689jFwvj8WQe+QBxmsiA4bWVPqAlbrD/5AX+0DMLOUVqZNUOvWjmuC0kQ1uhzsKmdjV9DXpJcsliw3WCG+RvHzkqGVT561gNSooYoyhjYJzXqsbKBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=mNRO7niY; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 263D2A508D;
	Tue, 17 Mar 2026 21:11:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773778305; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uUhASz9AHU5Mq+ZCgfV3SbGNBCbIh2iyUntKXpuOs98=;
	b=mNRO7niYZ0OgBcWrPfQY3CcJzGWZaWW5nBthb1/GgtV20VuxZS5neQr9JnICuyMBP1+PMC
	kTbK+LCbj1wYzsYM7ZsTgTFgTudzKFFM02nyCMNJkPdCOdV0SR7PbfeeJXi08yyY819vxF
	QDpSsJrt65+av4PGQGMJNyQa7hi6O+EwlFQNN+6hlSmx9CJ9vDNxzfLDsG6yp36HFKQ4Zp
	l0geX+cZzJ3nlEnR1Hc+vGIwmMifJ1aWW3qBVhaD235I95cP/q6pE6k3c7l/1ysBfwlAS+
	+twbBBqw90ow7S6JE5QQjXqHx/nzhlCUi24wT+tCIBdfYt5fWygrLlqbRKw4IA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Mar 2026 21:11:44 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Breno Leitao <leitao@debian.org>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: macb: allow MTU changes while the interface
 is running
In-Reply-To: <abmvax5GU9KdFBli@gmail.com>
References: <20260316092720.39198-1-nb@tipi-net.de>
 <abmtcI4NX_zFyAwA@gmail.com> <abmvax5GU9KdFBli@gmail.com>
Message-ID: <467fdc9c7af32942b4d25442577b8260@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268734-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A284B2B21B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 17.3.2026 20:47, Breno Leitao wrote:
> On Tue, Mar 17, 2026 at 12:42:04PM -0700, Breno Leitao wrote:
>> On Mon, Mar 16, 2026 at 10:27:20AM +0100, Nicolai Buchwitz wrote:
>> > macb_change_mtu() currently returns -EBUSY if the interface is running,
>> > requiring users to bring the interface down before changing the MTU. This
>> > is unnecessarily restrictive.
>> >
>> > Instead, close and reopen the interface around the MTU change so that RX
>> > DMA buffers are reallocated for the new MTU. This is the same approach
>> > used by many other network drivers (e.g. igb, tg3, stmmac).
>> >
>> > Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
>> > ---
>> >  drivers/net/ethernet/cadence/macb_main.c | 9 +++++++--
>> >  1 file changed, 7 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>> > index 5e27e0e87a55..8dd01031250d 100644
>> > --- a/drivers/net/ethernet/cadence/macb_main.c
>> > +++ b/drivers/net/ethernet/cadence/macb_main.c
>> > @@ -3262,11 +3262,16 @@ static int macb_close(struct net_device *dev)
>> >
>> >  static int macb_change_mtu(struct net_device *dev, int new_mtu)
>> >  {
>> > -	if (netif_running(dev))
>> > -		return -EBUSY;
>> > +	bool was_running = netif_running(dev);
>> > +
>> > +	if (was_running)
>> > +		macb_close(dev);
>> >
>> >  	WRITE_ONCE(dev->mtu, new_mtu);
>> >
>> > +	if (was_running)
>> > +		return macb_open(dev);
>> 
>> Would you like to keep the new_mtu set, even if macb_open() fails?
> 
> Looking a bit further, I found that macb_set_ringparam() doesn't return
> failure if macb_open() fails. Should it be fixed also?
> 
> Should we have something similar to your code above?
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index 5bc35f651ebd2..3c43fc85af79d 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -3516,7 +3516,7 @@ static int macb_set_ringparam(struct net_device 
> *netdev,
>         bp->tx_ring_size = new_tx_size;
> 
>         if (reset)
> -               macb_open(bp->dev);
> +               return macb_open(bp->dev);
> 
>         return 0;
>  }

Makes sense. I will send a separate patch for this.

Cheers
Nicolai

