Return-Path: <netdev+bounces-260452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Mt0Gj2BnWk/QQQAu9opvQ
	(envelope-from <netdev+bounces-260452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:45:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3603B185978
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2780C31553B7
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22553793BB;
	Tue, 24 Feb 2026 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="gw958neF"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508EA379998
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771929619; cv=none; b=oOk8Rrh4SX6KP3cRU1deM3RrJl8hyT1RSLZRyWrXFQW0nrlN0VNgValTxHQM9V7lgRRYZ2exhY+8ywNBRFJX1eW+WDPXjnJkzXzXzVPHJg2LUSDnV12KKc08krULhL6JeUsKNg33SNpieZwRooD08Q3qWRIbv+n2wahWkxBXrr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771929619; c=relaxed/simple;
	bh=WBVOuPGA6GO1dyBeiZ6GvK3hAIw5tmGhxjpOH3BnGPU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=O2yIag1M8BxvepkYa0JEZSz3rQUr8p96ShrPgUsAcmrtDFLuxj5VbBgFhaRP4tflcbTZiAA3lK4BQqqdNFlr5XEZMcqKh30AYbyiJLlFGAYFwrWxes0dusLX37rZGw/hImJkL3r4dZpaIxtCYZxUditWcHMNCyfwjoCnpqxBl98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=gw958neF; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 88103A02E5;
	Tue, 24 Feb 2026 11:40:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1771929612; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tC5e+DB/41PrYQLmy6DP3vXc5ukhmrwGOTEii3Bivyo=;
	b=gw958neFtsHyv5GxAviLyO6EwJw3vLmdBNdJVDUV5rsyMNmaConhnlRkZsyIXhR6paYZ7r
	Tk3Fe9lOWlt3Aw9b7WefjoN2RXNgk9bIGBBXbhyJbrzhyleCEhLPPzIvOCfzsHA2y0WzKA
	HSGixkHZweuoXlu27imvBNmhKqH66gv2jBtZwkVwatTUvIkcpT5vy4pdR144vlatLc+9bm
	lSQku4CD0dtCj22F92y9xbcatI2mcD4JfByGycmugX+8q49TM7BKYBB/yGHtPzp9EClCIx
	gX0UfFBg0WNIhLBwaZugpYCJwqU0ePkq2icZOxbMQn8TjuxbX+j/fnIbnINNOg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 24 Feb 2026 11:40:10 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, claudiu.beznea@tuxon.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 nicolas.ferre@microchip.com, pabeni@redhat.com, phil@raspberrypi.com
Subject: Re: [PATCH net-next v2 3/5] net: cadence: macb: implement EEE TX LPI
 support
In-Reply-To: <aZ16qgIsRxkUuoW1@shell.armlinux.org.uk>
References: <20260224091821.47671-1-nb@tipi-net.de>
 <20260224091821.47671-4-nb@tipi-net.de>
 <aZ16qgIsRxkUuoW1@shell.armlinux.org.uk>
Message-ID: <d8463e10e0c07ddf404a2515e2a8640c@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260452-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3603B185978
X-Rspamd-Action: no action

On 24.2.2026 11:17, Russell King (Oracle) wrote:
> On Tue, Feb 24, 2026 at 10:18:19AM +0100, Nicolai Buchwitz wrote:
>> Implement Energy Efficient Ethernet TX Low Power Idle using phylink's
>> managed EEE framework. The Cadence GEM MAC has no built-in idle timer
>> - TXLPIEN (NCR bit 19) immediately blocks all TX when set and the MAC
>> does NOT auto-wake - so the driver uses a software delayed_work timer
>> for idle detection.
>> 
>> The TX LPI lifecycle:
>>   - phylink calls mac_enable_tx_lpi() after link-up with the 
>> negotiated
>>     timer value. The driver defers the first LPI entry by 1 second per
>>     IEEE 802.3az section 22.7a.
>>   - macb_tx_complete() reschedules the idle timer after each TX drain.
>>   - macb_start_xmit() wakes from LPI by clearing TXLPIEN, cancelling
>>     the pending work, and waiting 50us (conservative Tw_sys) before
>>     initiating the transmit.
>>   - phylink calls mac_disable_tx_lpi() before link-down, which cancels
>>     the work and clears TXLPIEN.
>> 
>> The phylink_config is populated with LPI capabilities (MII, GMII, 
>> RGMII
>> modes; 100FD and 1000FD speeds) and a 250ms default idle timer, gated
>> on MACB_CAPS_EEE.
> 
> Much better, thanks. One suggestion:

Thanks for the quick feedback! I will address this in a v3 of this 
series.

> 
>> +static void macb_tx_lpi_set(struct macb *bp, bool enable)
> 
> bool return type.
> 
>> +{
>> +	unsigned long flags;
>> +	u32 ncr;
> 
> 	u32 old, ncr;
> 
>> +
>> +	spin_lock_irqsave(&bp->lock, flags);
>> +	ncr = macb_readl(bp, NCR);
> 
> 	old = ncr;
> 
>> +	if (enable)
>> +		ncr |= GEM_BIT(TXLPIEN);
>> +	else
>> +		ncr &= ~GEM_BIT(TXLPIEN);
> 
> 	if (old != ncr)
>> +	macb_writel(bp, NCR, ncr);
>> +	bp->tx_lpi_enabled = enable;
> 
> No need for tx_lpi_enabled
> 
>> +	spin_unlock_irqrestore(&bp->lock, flags);
> 
> 	return old != ncr;
> 
>> +}
> 
> ...
> 
>> +/* Wake from LPI before transmitting. The MAC must deassert TXLPIEN
>> + * and wait for the PHY to exit LPI before any frame can be sent.
>> + * IEEE 802.3az Tw_sys is ~17us for 1000BASE-T, ~30us for 100BASE-TX;
>> + * we use a conservative 50us.
>> + */
>> +static void macb_tx_lpi_wake(struct macb *bp)
>> +{
>> +	if (!bp->tx_lpi_enabled)
>> +		return;
> 
> No need for this if().
> 
>> +
>> +	macb_tx_lpi_set(bp, false);
> 
> instead:
> 	if (!macb_tx_lpi_set(bp, false))
> 		return;
> 
> The presence of the spinlock in macb_tx_lpi_set() suggests that there
> could be races, so keeping the state completely inside the spinlock
> region would be sensible.
> 
>> +	cancel_delayed_work(&bp->tx_lpi_work);
> 
> I wonder whether this is reliable on its own. cancel_delayed_work()
> documentation says:
> 
>  * Note:
>  * The work callback function may still be running on return, unless
>  * it returns %true and the work doesn't re-arm itself.  Explicitly 
> flush or
>  * use cancel_delayed_work_sync() to wait on it.
> 
> That means macb_tx_lpi_work_fn() could have just been entered at the
> point that cancel_delayed_work() has been called. Would that cause a
> problem, e.g. setting LPI mode again, or would we be guaranteed that
> macb_tx_all_queues_idle() returns false preventing LPI mode being set
> again?

AFAIK, the race shouldn't be an issue here because macb_tx_lpi_wake()
is called from macb_start_xmit() after the TX descriptors have been
written and tx_head has been advanced (there's a wmb() before the
call to ensure visibility). So if macb_tx_lpi_work_fn() happens to
be running concurrently, macb_tx_all_queues_idle() will see
tx_head != tx_tail and return false, preventing LPI from being
re-enabled.

> 
> Thanks.

Nicolai

