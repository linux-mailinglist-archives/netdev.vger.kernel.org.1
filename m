Return-Path: <netdev+bounces-234879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77078C2887F
	for <lists+netdev@lfdr.de>; Sun, 02 Nov 2025 00:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57F974E160A
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 23:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADCE1A255C;
	Sat,  1 Nov 2025 23:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NUOMw3Jx"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76313128819
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 23:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762038949; cv=none; b=kolKlWPuBtpWh1RMkfp2aAXUFp6bz10syoKRZdCGCB3SOBZM0fTgFlrOrPcaFJnkbb4wMcSEQevi5eHTXvni/0pPDA44XYE3uYJdNBV0bjY++iMoBOAcsHAZ0OFEbZLdb5uBYXHjq1qvs81AoXitN7aiNM3LDFv57tVcvWmxAkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762038949; c=relaxed/simple;
	bh=Urv6xl2QC2Nr1jas6iAymt3YBW0ooOA1yXGE2hUmT8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pz7TDUX5VcPPPm/Lb+Aj0QKT9RLWUVkwtYOJzTemRRfFpYfDhbY2VV6xXcO5393C63TVnKtgBZ6tG8WJfqe9/Vx4bCDIu4W2nEAuzapfkNm4apLV2G4VxBQ5MdWQCMVNK78NYXCboxnIgGsRQSBz6AiA3pHIsJdRuyPBFMSGdA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=NUOMw3Jx; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4czYcB5j9qz9tTf;
	Sun,  2 Nov 2025 00:15:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762038938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YI02przyFsx6fdwSVdTew+4GJQghTOlFjByupIarirM=;
	b=NUOMw3Jx3bLATFI6aHlAojIB+ahMPFAess+Ym1NRYRCjk9p3wCY8XQcwdWJU3wHW0hsTnq
	1yEv8StKr/0wj2qQsYf4UcX9EMxILAYUm8X78JIt5AUyhg8MpaiKEZOOHMZTZZE4s48lgJ
	aVgeq35LnyVbWfx0lvUtnDKA9WRCtiZSIEZb/tw3XhKkNAnSZqicRUIN03IG9avqWquPih
	afi5pOLGKnI6LqSkVz/RQBixq/YzTtqL9Zm62He/BS9jYwqu0eik15teDBn4mRSlK/Ommu
	DeevQXAXUt50MO5k9iIBTETrEQB/gULmBMLSFzHHXUaR+33yzDy3KY8i9kr1ew==
Message-ID: <c97cf296-f947-40d5-a4bc-6c30c2ba753b@mailbox.org>
Date: Sun, 2 Nov 2025 00:15:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next,PATCH] net: dsa: microchip: Do not count RX/TX Bytes
 and discards on KSZ87xx
To: vtpieter@gmail.com, tristram.ha@microchip.com
Cc: Arun.Ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
 Woojung.Huh@microchip.com, andrew@lunn.ch, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, olteanv@gmail.com, pabeni@redhat.com
References: <DM3PR11MB8736FCDDE21054AC6ACCEA44EC28A@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250813070321.1608086-1-vtpieter@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250813070321.1608086-1-vtpieter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 18iwt1ttmnqbs8yn7bbojcrb7cd6c94i
X-MBO-RS-ID: 1c4256709c1da1ba9e4

On 8/13/25 9:03 AM, vtpieter@gmail.com wrote:
>>>> Actually that many rx_discards may be a problem I need to find out.
>>>>
>>>> I think you are confused about how those MIB counters are read from
>>>> KSZ8795.  They are not using the code in ksz9477.c but in ksz8.c.
>>>
>>> See [1] TABLE 4-26: PORT MIB COUNTER INDIRECT MEMORY OFFSETS (CONTINUED)
>>> , page 108 at the very end . Notice the table ends at 0x1F
>>> TxMultipleCollision .
>>>
>>> See [2] TABLE 5-6: MIB COUNTERS (CONTINUED) , page 219 at the end of the
>>> table . Notice the table contains four extra entries , 0x80 RxByteCnt ,
>>> 0x81 TxByteCnt , 0x82 RxDropPackets , 0x83 TXDropPackets .
>>>
>>> These entries are present on KSZ9477 and missing on KSZ8795 .
>>>
>>> This is what this patch attempts to address.
>>
>> As I said KSZ8795 MIB counters are not using the code in ksz9477.c and
>> their last counter locations are not the same as KSZ9477.  KSZ9477 uses
>> ksz9477_r_mib_pkt while KSZ8795 uses ksz8795_r_mib_pkt.  The other
>> KSZ8895 and KSZ8863 switches uses ksz8863_r_mib_pkt.
>>
>> The 0x80 and such registers are not used in KSZ8795.  Its registers start
>> at 0x100, 0x101, ...
>>
>> They are in table 4-28.
>   
> Just wanted to chip in that for me, with a KSZ8794, the iproute2
> statistics work as expected as well after commit 0d3edc90c4a0 ("net:
> dsa: microchip: fix KSZ87xx family structure wrt the datasheet"). I'm
> on a 6.12 kernel and I see the following:
I'm sorry for my late reply, and yes, I got the versions mixed up.

The problem is still present in 6.6.115 , it is fixed in 6.12.y :

I can confirm 0d3edc90c4a0 ("net: dsa: microchip: fix KSZ87xx family 
structure wrt the datasheet") fixes the problem, thank you for that!

It would be good to backport this to 6.6.y LTS I think ?

The issue looks like this:

v6.11# cat /proc/net/dev
Inter-|   Receive                                                |  Transmit
  face |bytes    packets errs drop fifo frame compressed multicast|bytes 
    packets errs drop fifo colls carrier compressed
   eth0: 14818693   10334    0    0    0     0          0         0 
335961    2859    0    0    0     0       0          0
   lan1: 18446744073709510320   10324 14786075 14786075    0     0 
    0     10323 18446744073709540220    2849 342812    0 342812     0 
    0          0

v6.12.56# cat /proc/net/dev
Inter-|   Receive                                                |  Transmit
  face |bytes    packets errs drop fifo frame compressed multicast|bytes 
    packets errs drop fifo colls carrier compressed
   eth0: 14707237   10296    0    0    0     0          0         0 
340493    2889    0    0    0     0       0          0
   lan1: 14632865   10281    0    0    0     0          0         0 
335126    2875    0    0    0     0       0          0

Thank you for your help !

