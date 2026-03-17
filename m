Return-Path: <netdev+bounces-268725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OC5cKQasuWmEMAIAu9opvQ
	(envelope-from <netdev+bounces-268725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 20:31:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 103232B18EF
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 20:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C536A3051A9F
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 19:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D932340D91;
	Tue, 17 Mar 2026 19:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="nFraTJCw"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6953C42A80
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773775876; cv=none; b=uWP1jdCKvurtnAZ80QqYBLe4Q4r7cfA/HuvLKGNk1AYVqXwx5rrJhV0OgcRRHcQeublv0qZeRUYGLOxCFXoS3Y1gNJXoA24rxfC8aJlxwoDxww9Ii3jz3ImsKsYgGNyuCFekddLJ5E9C9RXxXzUggDh9u7yh0Pg/cKP02EeFi1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773775876; c=relaxed/simple;
	bh=e3mfkChrK8O6x2CXYuQFA55MxHVetS7pHIH1Lz97IC0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=kPE35UWcurY2iRe4tCn63jQpoA9hEypZyaLOxZM3qlqJSRz9GAuVxvZi5qmVLUW1ClVWyVjCOMdp04g8gxtL4jxl/TRR7+bbEJebizTcGCBr2nkzW66kRnvCG+PW6uIGKz3ue/ADXjebLta1FvgBvM2ocvzyBZJ6YRxSo5c9vSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=nFraTJCw; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 25161A1F89;
	Tue, 17 Mar 2026 20:31:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773775872; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=73lFawFjfbxkADcW8JHnUcOGH+i8xrgR+O/Yuf/gY2I=;
	b=nFraTJCwY90Ea+oB15FJoS+OSfjXlHmgNu7nwsO6D260kYLwSG/1CjRfOfLkmUDz04L14s
	sYKA4MTz5dni3rjVNCsoF+GSQpLl6joC13gxNEJmoD0sOl/Qza8bKqWZungS6prOVydap3
	5yqf1f5s2mVTSGKofhCIIT3iRFFEh9WWTjNlKLbtrYZFkf7AaOvPvp9dYoXOruDz1r8VY/
	85u77GXD8Rl8FMP8JQfvKFttVmF3p91vYSzFY9fzbf643OIfPCrX9w+2Kl28Yp3V1YqcUF
	sCE6oh5SrRVkSQBR2jERA7rwjIl7t0U+0kbTASzSJFtTm28w1nWm2UG7e1IroQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Mar 2026 20:31:10 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: macb: allow MTU changes while the interface
 is running
In-Reply-To: <DH57URLYG3TU.B4HGNJATLFMU@bootlin.com>
References: <20260316092720.39198-1-nb@tipi-net.de>
 <DH57URLYG3TU.B4HGNJATLFMU@bootlin.com>
Message-ID: <1175cc7425e073a0b8b84b2da04ee1b1@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268725-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid,bootlin.com:email,bootlin.com:url]
X-Rspamd-Queue-Id: 103232B18EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Théo

Thanks for the review and testing!

On 17.3.2026 18:00, Théo Lebrun wrote:
> Hello Nicolai,
> 
> On Mon Mar 16, 2026 at 10:27 AM CET, Nicolai Buchwitz wrote:
>> macb_change_mtu() currently returns -EBUSY if the interface is 
>> running,
>> requiring users to bring the interface down before changing the MTU. 
>> This
>> is unnecessarily restrictive.
> 
> One valid reasoning for making the operation return -EBUSY is that
> macb_close() will lead to packet loss for a few seconds. Users might
> not expect an MTU change to trigger that. -EBUSY means user (be it
> human or software) becomes aware and has time for a second thought.
> 
> But clearly, it becomes annoying as the user in the long run, when you
> own your platform and know the implications.

Since setting the MTU already requires elevated rights and usually 
involves reconfiguring surrounding infrastructure that may also drop 
packets, I think the better UX is worth the brief interruption.

> 
>> Instead, close and reopen the interface around the MTU change so that 
>> RX
>> DMA buffers are reallocated for the new MTU. This is the same approach
>> used by many other network drivers (e.g. igb, tg3, stmmac).
>> 
>> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
>> ---
>>  drivers/net/ethernet/cadence/macb_main.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
>> b/drivers/net/ethernet/cadence/macb_main.c
>> index 5e27e0e87a55..8dd01031250d 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -3262,11 +3262,16 @@ static int macb_close(struct net_device *dev)
>> 
>>  static int macb_change_mtu(struct net_device *dev, int new_mtu)
>>  {
>> -	if (netif_running(dev))
>> -		return -EBUSY;
>> +	bool was_running = netif_running(dev);
>> +
>> +	if (was_running)
>> +		macb_close(dev);
>> 
>>  	WRITE_ONCE(dev->mtu, new_mtu);
>> 
>> +	if (was_running)
>> +		return macb_open(dev);
>> +
>>  	return 0;
>>  }
> 
> Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
> Tested-by: Théo Lebrun <theo.lebrun@bootlin.com> # on eyeq5-epm
> 
> Thanks,
> 
> --
> Théo Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

Cheers
Nicolai

