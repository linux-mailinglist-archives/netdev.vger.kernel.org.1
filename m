Return-Path: <netdev+bounces-261769-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDSoDKxdoWmksQQAu9opvQ
	(envelope-from <netdev+bounces-261769-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:02:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BC91B4DD3
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D52F730209CB
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713B531618B;
	Fri, 27 Feb 2026 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="KC6dWdzy"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F05584A35
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 09:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772182877; cv=none; b=OEGhzUCk2E6NfARuslnb9MEN79dGsSNAkI/4ybvkh5IutBuPFfGpgJ2x2JE00x9rPb9vaBDv/OGXrfk7M4RlWLduTpeSkf0iv8AvzPKU8uPSdQR1Y8Ki/YZtbM1MBgjv0DxaaPnnzH2CgcHoSaIYRAgUc8H27a5ODG6psUK7A3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772182877; c=relaxed/simple;
	bh=N1GrKpz7sYQ3lH34liNNZrwlZu9g2iOBQDK9CTR/8wU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=j06MgOJ05IHN+ecCsyY6Hxnsc5H7hNMT6GqhXjZkVh49lYtVOJ7zhsCwn3nObE029bLG7FAkI4cEwFKzcsUSE745p8pR+Q4B7ABATz+2z5tBGl63y0NOsw21CdThxW7kUyRmotMyZ8EuOx4fPRmuX/D5/4gllZEMo0SiK6bDilY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=KC6dWdzy; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C9D7BA0387;
	Fri, 27 Feb 2026 10:00:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1772182864; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=GWX4+6wT5AW/5pQ5aV0uBQNunQQTIoD3EExB6jWsI4U=;
	b=KC6dWdzyf0vYVm+257Uno5h/A2XCxbd9oNlTVwoVZYcWzXcyPf+bSMvC/A104MXuDchXsp
	PfZ2VtLYsgMo4FI72zCA0LrO9rmnUo5CL7pwdSbUNnW7yXmKvzmfAWrrELzvDZEyxqf5Bd
	a7WKvJR5hMFZFuzs6Tjaf+GwUNsvYaqrAVQOeItMdfBO2GnGpryOjRnUlpt/e+JUzNJGVD
	q+BrZxKgqwGKIIZT8SMXZykKWSxTTkSP3To2tFOE5wVZPQoxBVOyWBDSTYUak+wT+FBUA1
	dUz7qktCBXQxBSni0qgX3VgWF56eMILbFK6lBq5crL2MEAKLTZKqyev8X1CsXA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 27 Feb 2026 10:00:57 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, claudiu.beznea@tuxon.dev, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, nicolas.ferre@microchip.com,
 pabeni@redhat.com, phil@raspberrypi.com, =?UTF-8?Q?Gr=C3=A9gory_Clemen?=
 =?UTF-8?Q?t?= <gregory.clement@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 3/5] net: cadence: macb: implement EEE TX LPI support
In-Reply-To: <DGOXXGNSSMYK.2XNU9AQ6E077P@bootlin.com>
References: <20260225091558.51157-1-nb@tipi-net.de>
 <20260225091558.51157-4-nb@tipi-net.de>
 <DGO88446M74S.6C1O0I79IM0E@bootlin.com>
 <aZ82VFPu2FDmPpJ0@shell.armlinux.org.uk>
 <DGOSV8GS9VI6.8IV6D1L3F94F@bootlin.com>
 <342fd96e9f9668392705496e54d93eff@tipi-net.de>
 <DGOXXGNSSMYK.2XNU9AQ6E077P@bootlin.com>
Message-ID: <e90dc9e1ac7c9d85607c8fad6094d6b2@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:query timed out];
	TAGGED_FROM(0.00)[bounces-261769-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 45BC91B4DD3
X-Rspamd-Action: no action

On 26.2.2026 14:50, Théo Lebrun wrote:
> On Thu Feb 26, 2026 at 11:49 AM CET, Nicolai Buchwitz wrote:
>> On 26.2.2026 10:52, Théo Lebrun wrote:
>>> On Wed Feb 25, 2026 at 6:50 PM CET, Russell King (Oracle) wrote:
>>>> On Wed, Feb 25, 2026 at 06:42:08PM +0100, Théo Lebrun wrote:
>>>>> On Wed Feb 25, 2026 at 10:15 AM CET, Nicolai Buchwitz wrote:
>>>>> > @@ -2349,6 +2454,8 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
>>>>> >  	netdev_tx_sent_queue(netdev_get_tx_queue(bp->dev, queue_index),
>>>>> >  			     skb->len);
>>>>> >
>>>>> > +	macb_tx_lpi_wake(bp);
>>>>> 
>>>>> Should this be protected by a bp->eee_active condition? It could go
>>>>> in macb_tx_lpi_wake(). We avoid a spinlock acquire per xmit for 
>>>>> most
>>>>> platforms. Probably negligeable though.
>>>> 
>>>> It will read the register, find the bit clear, and then return if
>>>> EEE is already disabled.
>>> 
>>> Yes I agree with your sentence, sorry my point was unclear. I was not
>>> describing a bug but rather a performance optimisation.
>>> 
>>> We would look up bp->eee_active to know if we can avoid calling
>>> macb_tx_lpi_set(), to avoid grabbing bp->lock once per xmit.
>>> That spinlock is interface-wide.
>> 
>> So you're suggesting to revert to the v2 approach?
>> https://patchwork.kernel.org/project/netdevbpf/patch/20260224091821.47671-4-nb@tipi-net.de/
> 
> I discovered this series at its V3.
> It seems like I was suggesting a mix of both V2 & V3 approaches.
> 
> // V2 was:
> static void macb_tx_lpi_wake(struct macb *bp)
> {
> 	if (!bp->eee_active)
> 		return;
> 
> 	macb_tx_lpi_set(bp, false);
> 	cancel_delayed_work(&bp->tx_lpi_work);
> 	udelay(50);
> }
> 
> // V3 & V3 are:
> static void macb_tx_lpi_wake(struct macb *bp)
> {
> 	if (!macb_tx_lpi_set(bp, false))
> 		return;
> 
> 	cancel_delayed_work(&bp->tx_lpi_work);
> 	udelay(50);
> }
> 
> // I was suggesting:
> static void macb_tx_lpi_wake(struct macb *bp)
> {
> 	if (!eee_active || !macb_tx_lpi_set(bp, false))
> 		return;
> 
> 	cancel_delayed_work(&bp->tx_lpi_work);
> 	udelay(50);
> }
> 
> But talking about perf, let's measure.

Tthanks for testing! Since you have the hardware at hand, would you be 
willing to add MACB_CAPS_EEE to eyeq5_config as well? I'm happy to 
include it in the series if you can confirm it works correctly.

> 
> I don't get any measurable performance improvement on average/max time
> spent in macb_start_xmit() between net-next and this series. We spend
> <3µs per call anyway. 10s iperf3 1G TCP test on EyeQ5, ftrace function
> graph tracer on macb_start_xmit().
> 
> Summary: you can ignore my remark.
> 
> Thanks,
> 
> --
> Théo Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

Nicolai

