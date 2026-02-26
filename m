Return-Path: <netdev+bounces-261214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFUHC7b+n2n3fAQAu9opvQ
	(envelope-from <netdev+bounces-261214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:05:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB291A23F7
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D77230FC50B
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 08:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543E8392C3C;
	Thu, 26 Feb 2026 08:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="J0lOjLfY"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE4139281F
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092879; cv=none; b=kzIiRd/aFs8xSZlrbAyI73PIWryJTSbGtrxE7PHBjl5aiLIz0JLVC2xsD5bIs0JRHEl1gqXKkdge32O/+MjH8r+areta5qcv9tn5PZChDeJ8YzWloQEgvLF6QyO78sRUQJnS9O4TOfZ4nC0F/JOOa51pp7VSArueaY4Sy95Akb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092879; c=relaxed/simple;
	bh=uoXzDz8hPntBB9gEZjrFrugNoe3dX3aGj2en+Qg9/FA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=GeKuXvzzFfeQPmuY1BtaxQf61Gl72q/5iOj2RrC/qTaEMAx3hFSZDTXQ9FwrqKckkuu2zUxJ7eu2SHfNYIOVGNF/PHeclFSQrmsHUpsClF9YFLqLXUwY3sEB+uTLEjhS1QnHQUS0P9lOa5yRy5XLB65OGqyWR3HXnrd84LdwTfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=J0lOjLfY; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BB19EA0372;
	Thu, 26 Feb 2026 09:01:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1772092867; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=C9kxIK7u5kJFDJDYVq8MnabzqN+/gkRx7ZcEkr+12go=;
	b=J0lOjLfYp6seJeKvYrEILonLHHfASe840Z4/MwEgiWTUrowwLu/nOfgrVi/z7uJBA+PQ2O
	SKuDt6zKD2s4A4IykT560LNr7Pyd7CLkaTEoOcwRReq6LEnRiVcs4W6A5163dZmQ/f4pwD
	XdX3tq7CFy5PzbKJVZySYHAIgw62+gCp697pEXsMQH20OgX8CrvIMw9ItRdhDxNF2rgyiq
	jsaNTYBt466wdNIrjx3N/CR+Jham9Ah6tQ0GEXucllEexEKB1sY6Cvg1SDsiqvg438w2ge
	C74iE8yZlsaz1qP4bjmfckKnsQp8a/zPKGkM3OmjVCpIV4id5bj0hl7qkEjF3Q==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 26 Feb 2026 09:01:03 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Sai Krishna Gajula <saikrishnag@marvell.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, claudiu.beznea@tuxon.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 nicolas.ferre@microchip.com, pabeni@redhat.com, linux@armlinux.org.uk,
 phil@raspberrypi.com
Subject: Re: [PATCH 3/5] net: cadence: macb: implement EEE TX LPI support
In-Reply-To: <BYAPR18MB373524BEA045174E7E453250A075A@BYAPR18MB3735.namprd18.prod.outlook.com>
References: <20260225091558.51157-1-nb@tipi-net.de>
 <20260225091558.51157-4-nb@tipi-net.de>
 <BYAPR18MB373524BEA045174E7E453250A075A@BYAPR18MB3735.namprd18.prod.outlook.com>
Message-ID: <84890c811e5a8f133595ea8b7ed01e01@tipi-net.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261214-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davemloft.net:email,raspberrypi.com:email,microchip.com:email,tuxon.dev:email]
X-Rspamd-Queue-Id: 7FB291A23F7
X-Rspamd-Action: no action

On 25.2.2026 18:32, Sai Krishna Gajula wrote:
>> -----Original Message-----
>> From: Nicolai Buchwitz <nb@tipi-net.de>
>> Sent: Wednesday, February 25, 2026 2:46 PM
>> To: netdev@vger.kernel.org
>> Cc: andrew+netdev@lunn.ch; claudiu.beznea@tuxon.dev;
>> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>> nicolas.ferre@microchip.com; pabeni@redhat.com; linux@armlinux.org.uk;
>> phil@raspberrypi.com; Nicolai Buchwitz <nb@tipi-net.de>
>> Subject: [PATCH 3/5] net: cadence: macb: implement EEE TX LPI
>> support
>> 

[...]

>> +
>> +static void macb_tx_lpi_schedule(struct macb *bp) {
>> +	if (bp->eee_active)
>> +		mod_delayed_work(system_wq, &bp->tx_lpi_work,
>> +				 usecs_to_jiffies(bp->tx_lpi_timer));
>> +}
>> +
>> +/* Wake from LPI before transmitting. The MAC must deassert TXLPIEN
>> + * and wait for the PHY to exit LPI before any frame can be sent.
>> + * IEEE 802.3az Tw_sys is ~17us for 1000BASE-T, ~30us for 100BASE-TX;
>> + * we use a conservative 50us.
>> + */
>> +static void macb_tx_lpi_wake(struct macb *bp) {
>> +	if (!macb_tx_lpi_set(bp, false))
>> +		return;
>> +
>> +	cancel_delayed_work(&bp->tx_lpi_work);
>> +	udelay(50);
> Any reason the 50µs busy-wait in xmit path? Can it be avoided?
> 

The 50us delay is required by IEEE 802.3az. After clearing TXLPIEN the
PHY needs time to exit LPI and re-establish normal operation before the
MAC can transmit. This is defined as Tw_sys_tx - approximately 16.5us
for 1000BASE-T and 30us for 100BASE-TX. We use a conservative 50us to
cover both speeds without needing to track the current link rate.

Testing without the delay confirmed packet loss on the first frame after
waking from LPI, as the PHY had not yet fully transitioned back to
normal mode.

This delay is specific to the GEM MAC because TXLPIEN directly and
immediately controls LPI with no hardware enforcement of Tw_sys_tx - the
software must enforce it. Other phylink-managed EEE drivers (mvneta,
stmmac, lan743x, mtk) don't need an explicit delay because their
hardware handles the wake timing automatically.

The cost is also bounded: the delay only fires when TXLPIEN was
actually asserted, i.e. on the first transmit after an idle period.

[...]

Nicolai

