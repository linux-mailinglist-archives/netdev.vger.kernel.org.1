Return-Path: <netdev+bounces-260061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDG3K39qnGmcGAQAu9opvQ
	(envelope-from <netdev+bounces-260061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:55:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 184911784E3
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE52D30F36D7
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8B3258EDE;
	Mon, 23 Feb 2026 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="254YfcH4"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6443A23E229
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858481; cv=none; b=CwDDwvUc8ZPyLTSnJeyZsmYQ5Y7YvxAwZzA3YNK5bfQD4HKbgDSxlKU7dJQGU2eGZhKZ9gW3Ai8YvtS5q9LN0qXvswr9w7PTYWDfA4q/LUY03AeKiNLHsF7yV9I+TQW8l24VoBkjOPHGqAE56Vf13kFFkETg8Uch0OJlLsMsuds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858481; c=relaxed/simple;
	bh=hanRw6neqo1V+xkrPiN7EJ0NS7fHSnweQt1XIxZc9no=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=A4wMpGDzlzPmDLTdBWdLsLhIGhdbbmQNupevtyCY/Uz1Pc0t45FjbeqEoCY3xml5RxEnR10Q10utFPD/Mo7pMf5bgewgOqKAridrXX82TkkfYslzZTc8ysWkA3Z1rvmGuh4/hhwDzOXVkx1M/e1AgAjqlkQ2caDz+7smm8mfENg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=254YfcH4; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D9304A0387;
	Mon, 23 Feb 2026 15:54:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1771858475; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=R/OB9yjVomqfrNS8o4uEl0JRvNoCayKvxpqSMhtr2tU=;
	b=254YfcH4fPrCGlNpJqA1Qc2gfoMXOWnywYPSI5GcVsr13PHZSlH34+KYIwAhs5qbCM2929
	gOmleCoW7Tn2nOGjge5g6GbI8xBw4XL3OKDVAT/dzrhp314LqfsuOOEkInNfLnBGLnPJdG
	LMKCRBqkKUZipc8WOhQXcEOeUtDp0lo5wmlkX2GeOXP//E3ouSa227hj+Yv3oqKnmzKyw1
	/OpwU4mc9diRgU8TC2vO9VgXhknf9I3BnJy8Itvi2quUTvMRLxcKzMQ4l1FGuSTnK/XUMS
	FAo/Wbx3zfXXpABNHJgZFBPXTByiNZwvXpJ4IJQIXIbdyDuCEdYVF14q4d4CWw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Feb 2026 15:54:31 +0100
From: nb@tipi-net.de
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, claudiu.beznea@tuxon.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 nicolas.ferre@microchip.com, pabeni@redhat.com
Subject: Re: [PATCH net-next 3/5] net: cadence: macb: implement EEE TX LPI
 support
In-Reply-To: <aZwm9u_xCbuXCkDX@shell.armlinux.org.uk>
References: <20260223090412.44070-1-nb@tipi-net.de>
 <20260223090412.44070-4-nb@tipi-net.de>
 <aZwm9u_xCbuXCkDX@shell.armlinux.org.uk>
Message-ID: <cdf89583f91ce548f1108c8105632102@tipi-net.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260061-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 184911784E3
X-Rspamd-Action: no action

On 23.2.2026 11:07, Russell King (Oracle) wrote:
> On Mon, Feb 23, 2026 at 10:04:10AM +0100, Nicolai Buchwitz wrote:
>> Implement software-managed TX Low Power Idle (LPI) for the Cadence GEM
>> MAC as part of IEEE 802.3az Energy Efficient Ethernet support.
>> 
>> The GEM MAC has no built-in idle timer - the TXLPIEN bit (NCR bit 19)
>> immediately asserts LPI and blocks all TX while set. The MAC does not
>> auto-wake for transmit. Per Microchip GMAC documentation (section
>> 40.6.19): "It is best to use firmware to control LPI."
>> 
>> This patch implements a software idle timer using delayed_work:
>> - On TX completion with an empty ring, schedule LPI entry after a
>>   configurable idle timeout (default 250ms). The work function
>>   verifies all TX queues are truly idle before entering LPI to
>>   prevent entering LPI while traffic is still active.
>> - On TX start, wake from LPI by clearing TXLPIEN, cancelling any
>>   pending re-entry, and waiting 50us for the PHY to exit LPI
>>   (conservative vs IEEE 802.3az Tw_sys of ~17us/~30us)
>> - On link up, check EEE negotiation via phy_init_eee() and defer
>>   first LPI entry by 1 second per IEEE 802.3az requirements
>> - On link down, immediately cancel pending work and clear TXLPIEN
>> 
>> The timer value is configurable at runtime via ethtool --set-eee
>> tx-timer.
>> 
>> The implementation is gated on MACB_CAPS_EEE so platforms must
>> explicitly opt in via their macb_config.
> 
> In addition to my comments, please check the nipabot status for this
> patch which can be found at:
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/20260223090412.44070-4-nb@tipi-net.de/
> 

Thanks. I will have a look at the mentioned patches + feedback from the 
pipeline and prepare a v2 of this series.

> Thanks.

Nicolai

