Return-Path: <netdev+bounces-212599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF07EB216D6
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 22:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE839172294
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 20:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CDF2DA760;
	Mon, 11 Aug 2025 20:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DT7KGzVm"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430D75FEE6
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 20:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754945960; cv=none; b=idcIiCnU2Xw+BDhC7+bzJbSlQbZ7UAzP+TbNjoIZQMyB9ZYMFrLfhHu7D3RQhGXyNt4eveH2UvF/LhdybSTsALhdTdxmkpzBOyoNOj+pmqVEch+jy+6ePyCmakRUH2BdoZFIgp7vyl4fxNgF10wak9K8njfwg0eve4UIPAY986Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754945960; c=relaxed/simple;
	bh=SXw2jcQsPAR80b3zEVxsFle2S5fopWNeplCAvSBcC9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTdBG501t0uTgybUHVWafjEtOI2dcHEAhLiANDukkD/DDOIoxL8ZNV8lT4IZwxSBEsFIDVxlsNT7e5xKcXGheAV+LdAkitx+gnx3tKjUmgGa5CERrn7DivwFQuNrcod12/Z1y9Cnw5cryAE91vWxGgfbWPA4M4oRxEkS8+N0N5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=DT7KGzVm; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4c16Sc0mH0z9snJ;
	Mon, 11 Aug 2025 22:59:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1754945952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hgibbqZbKhBaQXpF76pgju1blp5ps7ig1abBLKuNCK0=;
	b=DT7KGzVmbgUvDyPmJCED0UXtt2Pc852HaqkBGfwDSByff+884rxoCbMAxeqNC/nmPaf0Dx
	rbD9awm2Zu41j838umUHa+WscrEIW1OEk09BXC2NWQtTsKrl650+aUucw8KcJQCF2JG3Nq
	xDlYM8Ccreo+cpKDtZmJOhusmAeC43q6ZpBDrtIb076HQrugYG3Tq7J3Y0R9QYAZEpehAO
	RSG/FMZaF0m6kVu2wJm6kiHjEKdTb76PPywh5umxpzw+4toi5gXkt/FV8kMrL7smL7r0Fr
	IXW8xStn/42Iz/WWwgAPzBSeGGtJUtLPlSiTHYn5FKAS6c+XkHhyBBqRxE6wAw==
Message-ID: <5fa3a420-e25a-4178-b0f3-b3b7bad4665e@mailbox.org>
Date: Mon, 11 Aug 2025 22:59:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next,PATCH] net: dsa: microchip: Do not count RX/TX Bytes
 and discards on KSZ87xx
To: Tristram.Ha@microchip.com
Cc: andrew@lunn.ch, Arun.Ramadoss@microchip.com, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, UNGLinuxDriver@microchip.com,
 olteanv@gmail.com, Woojung.Huh@microchip.com, netdev@vger.kernel.org
References: <20250810160933.10609-1-marek.vasut@mailbox.org>
 <DM3PR11MB87364054C23D4B64069F4639EC28A@DM3PR11MB8736.namprd11.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <DM3PR11MB87364054C23D4B64069F4639EC28A@DM3PR11MB8736.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: qicadu4py81hkqfc5okjw8h9d57s8ow8
X-MBO-RS-ID: 632a23befe5eae5fe6d

On 8/11/25 10:47 PM, Tristram.Ha@microchip.com wrote:
>> Unlike KSZ94xx, the KSZ87xx is missing the last four MIB counters at
>> address 0x20..0x23, namely rx_total, tx_total, rx_discards, tx_discards.
>>
>> Using values from rx_total / tx_total in rx_bytes / tx_bytes calculation
>> results in an underflow, because rx_total / tx_total returns values 0,
>> and the "raw->rx_total - stats->rx_packets * ETH_FCS_LEN;" calculation
>> undeflows if rx_packets / tx_packets is > 0 .
>>
>> Stop using the missing MIB counters on KSZ87xx .
>>
>> Fixes: c6101dd7ffb8 ("net: dsa: ksz9477: move get_stats64 to ksz_common.c")
>> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
>> ---
>> Cc: Andrew Lunn <andrew@lunn.ch>
>> Cc: Arun Ramadoss <arun.ramadoss@microchip.com>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: Tristram Ha <tristram.ha@microchip.com>
>> Cc: UNGLinuxDriver@microchip.com
>> Cc: Vladimir Oltean <olteanv@gmail.com>
>> Cc: Woojung Huh <woojung.huh@microchip.com>
>> Cc: netdev@vger.kernel.org
>> ---
>>   drivers/net/dsa/microchip/ksz_common.c | 13 ++++++++-----
>>   1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/dsa/microchip/ksz_common.c
>> b/drivers/net/dsa/microchip/ksz_common.c
>> index 7292bfe2f7cac..9c01526779a6d 100644
>> --- a/drivers/net/dsa/microchip/ksz_common.c
>> +++ b/drivers/net/dsa/microchip/ksz_common.c
>> @@ -2239,20 +2239,23 @@ void ksz_r_mib_stats64(struct ksz_device *dev, int port)
>>          /* HW counters are counting bytes + FCS which is not acceptable
>>           * for rtnl_link_stats64 interface
>>           */
>> -       stats->rx_bytes = raw->rx_total - stats->rx_packets * ETH_FCS_LEN;
>> -       stats->tx_bytes = raw->tx_total - stats->tx_packets * ETH_FCS_LEN;
>> -
>> +       if (!ksz_is_ksz87xx(dev)) {
>> +               stats->rx_bytes = raw->rx_total - stats->rx_packets * ETH_FCS_LEN;
>> +               stats->tx_bytes = raw->tx_total - stats->tx_packets * ETH_FCS_LEN;
>> +       }
>>          stats->rx_length_errors = raw->rx_undersize + raw->rx_fragments +
>>                  raw->rx_oversize;
>>
>>          stats->rx_crc_errors = raw->rx_crc_err;
>>          stats->rx_frame_errors = raw->rx_align_err;
>> -       stats->rx_dropped = raw->rx_discards;
>> +       if (!ksz_is_ksz87xx(dev))
>> +               stats->rx_dropped = raw->rx_discards;
>>          stats->rx_errors = stats->rx_length_errors + stats->rx_crc_errors +
>>                  stats->rx_frame_errors  + stats->rx_dropped;
>>
>>          stats->tx_window_errors = raw->tx_late_col;
>> -       stats->tx_fifo_errors = raw->tx_discards;
>> +       if (!ksz_is_ksz87xx(dev))
>> +               stats->tx_fifo_errors = raw->tx_discards;
>>          stats->tx_aborted_errors = raw->tx_exc_col;
>>          stats->tx_errors = stats->tx_window_errors + stats->tx_fifo_errors +
>>                  stats->tx_aborted_errors;
> 
> I am not sure why you have that problem.  In my KSZ8795 board running in
> kernel 6.16 those counters are working.  Using "ethtool -S lan3" or
> "ethtool -S eth0" shows rx_total and tx_total.  The "rx_discards" and
> "tx_discards" are hard to get.  In KSZ8863 the "tx_discards" counter is
> incremented when the port does not have link and a packet is sent to that
> port.  In newer switches that behavior was changed.  Occasionally you may
> get 1 or 2 at the beginning when the tail tagging function is not enabled
> yet but the MAC sends out packets.  The "rx_discards" count typically
> seldom happens, but somehow in my first bootup there are many from my
> KSZ8795 board.
> 
> Actually that many rx_discards may be a problem I need to find out.
> 
> I think you are confused about how those MIB counters are read from
> KSZ8795.  They are not using the code in ksz9477.c but in ksz8.c.

See [1] TABLE 4-26: PORT MIB COUNTER INDIRECT MEMORY OFFSETS (CONTINUED) 
, page 108 at the very end . Notice the table ends at 0x1F 
TxMultipleCollision .

See [2] TABLE 5-6: MIB COUNTERS (CONTINUED) , page 219 at the end of the 
table . Notice the table contains four extra entries , 0x80 RxByteCnt , 
0x81 TxByteCnt , 0x82 RxDropPackets , 0x83 TXDropPackets .

These entries are present on KSZ9477 and missing on KSZ8795 .

This is what this patch attempts to address.

[1] 
https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/DataSheets/KSZ8795CLX-Data-Sheet-DS00002112.pdf
[2] 
https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/KSZ9477S-Data-Sheet-DS00002392C.pdf

-- 
Best regards,
Marek Vasut

