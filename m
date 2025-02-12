Return-Path: <netdev+bounces-165399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8B6A31E73
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 07:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F7F167CB9
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 06:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AEF1FBC8B;
	Wed, 12 Feb 2025 06:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="HNZeYYsc"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3774A2B9BC;
	Wed, 12 Feb 2025 06:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739340352; cv=none; b=EuZkDLTSqKwpkIIYH9bm2/cNbdnNGUwU0rpS+9Yy8POkuXi3DM078HP/ef1OX8uf7/gZkRJPOnNVLQGFqJDLdJ55aCc+TqS/c1FxgddViCuyDKTxdrRm6AkQuVJljbZrUsPnUuS2yQ3E/WLqivRkPS54c+ZJOTwL0p4Vr3zY8qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739340352; c=relaxed/simple;
	bh=BhGxYFFMSV/YWK8FW8XvpoFm8hRwlSSbuDao9yYaFlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Su1w6JJlE6LXPHWEJocli/KDE+HT2t+KcAuaJlDLS68q7QdIVmtr5BxYOqnys93cfRtgZtH3CroY0T1oO24bQQcX5vai7wdcsyV/aSjQbJD4LurUqEjWXz5B/ljOeMs3v7JEnsVMXuukwKF4dGayEbt8+NnO7HMQcrZexxvdD14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=HNZeYYsc; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id AB829120006;
	Wed, 12 Feb 2025 09:05:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru AB829120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1739340340;
	bh=BPa6caO9adsb4O/x96x8tlDwFCtrZKhMCarBVowAQMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=HNZeYYscnU3jx/koN6jTSQo57w+PYvbHahPu94fSXc6MpvHuPK6iZ1yLxi958EnHy
	 EORwgXiNUqmW6dOxq9NDaJr/dn7mRcwV34Ipb8ncDSj6/KomoEZSAlPN+n9RHsoqrY
	 ZrolaiNddfnQR5jzBWU31oIAeKfyy03pZEYSoVM9oydS6BBVdXtC7bLetXD8SxB/ox
	 Bqz+snR4QSJ2KTE+N3IccyQwfBbVzzgEpndX1CL0Ot+fYSt2JfCiHRflnCV9mWa6c1
	 smlVfZsMRNFfcRR5pOBS3NwXSuvMmU2hPMawHYq0YVNBYHPn6e81AO3dxnDCdAPLvf
	 1Y7+eKJGh+3Lg==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 12 Feb 2025 09:05:40 +0300 (MSK)
Message-ID: <32571353-7448-f670-8962-cc84b3d6b1c3@salutedevices.com>
Date: Wed, 12 Feb 2025 09:05:10 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [DMARC error] Re: [syzbot] [bluetooth?] KASAN:
 slab-use-after-free Read in skb_queue_purge_reason (2)
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <hdanton@sina.com>, <linux-bluetooth@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luiz.von.dentz@intel.com>,
	<marcel@holtmann.org>, <netdev@vger.kernel.org>
References: <67a9e24a.050a0220.3d72c.0050.GAE@google.com>
 <e8b8686f-8de1-aa25-9707-fcad4ffa5710@salutedevices.com>
 <c2d99ec3-d69e-b47d-45cc-0ad39893afd7@salutedevices.com>
 <CABBYNZJqmayOhPtWpmj8PwK5uyzUemCEUz9eN+h26wH9ix91Kg@mail.gmail.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <CABBYNZJqmayOhPtWpmj8PwK5uyzUemCEUz9eN+h26wH9ix91Kg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 190954 [Feb 12 2025]
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_uf_ne_domains}, {Tracking_arrow_http, text}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;syzkaller.appspot.com:7.1.1,5.0.1;smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;lore.kernel.org:7.1.1;goo.gl:7.1.1,5.0.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2025/02/12 04:24:00
X-KSMG-LinksScanning: Clean, bases: 2025/02/12 04:24:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/02/11 22:40:00 #27152313
X-KSMG-AntiVirus-Status: Clean, skipped



On 11.02.2025 19:51, Luiz Augusto von Dentz wrote:
> Hi Arseniy,
> 
> On Tue, Feb 11, 2025 at 11:22 AM Arseniy Krasnov
> <avkrasnov@salutedevices.com> wrote:
>>
>> May be my previous version was free of this problem ?
>>
>> https://lore.kernel.org/linux-bluetooth/a1db0c90-1803-e01c-3e23-d18e4343a4eb@salutedevices.com/
> 
> You can try sending it to
> syzbot+683f8cb11b94b1824c77@syzkaller.appspotmail.com to check if that
> works.

Ok, I'll send it. I think that even this logic is deprecated, it is better to
keep it without bugs (even if fix is not elegant).

Thanks

> 
>> Thanks
>>
>> On 11.02.2025 17:16, Arseniy Krasnov wrote:
>>> Hi, I guess problem here is that, if hci_uart_tty_close() will be called between
>>> setting HCI_UART_PROTO_READY and skb_queue_head_init(), in that case mrvl_close()
>>> will access uninitialized data.
>>>
>>> hci_uart_set_proto() {
>>>         ...
>>>         set_bit(HCI_UART_PROTO_READY, &hu->flags);
>>>
>>>         err = hci_uart_register_dev(hu);
>>>                 mrvl_open()
>>>                     skb_queue_head_init();
> 
> Or we follow what the likes of hci_uart_register_device_priv, in fact
> we may want to take the time to clean this up, afaik the ldisc is
> deprecated and serdev shall be used instead, in any case if we can't
> just remove ldisc version then at very least they shall be using the
> same flow when it comes to hci_register_dev since the share the same
> struct hci_uart.
> 
>>>         if (err) {
>>>                 return err;
>>>         }
>>>         ...
>>> }
>>>
>>> Thanks
>>>
>>> On 10.02.2025 14:26, syzbot wrote:
>>>> syzbot has bisected this issue to:
>>>>
>>>> commit c411c62cc13319533b1861e00cedc4883c3bc1bb
>>>> Author: Arseniy Krasnov <avkrasnov@salutedevices.com>
>>>> Date:   Thu Jan 30 18:43:26 2025 +0000
>>>>
>>>>     Bluetooth: hci_uart: fix race during initialization
>>>>
>>>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=116cebdf980000
>>>> start commit:   40b8e93e17bf Add linux-next specific files for 20250204
>>>> git tree:       linux-next
>>>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=136cebdf980000
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=156cebdf980000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=ec880188a87c6aad
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=683f8cb11b94b1824c77
>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b7eeb0580000
>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f74f64580000
>>>>
>>>> Reported-by: syzbot+683f8cb11b94b1824c77@syzkaller.appspotmail.com
>>>> Fixes: c411c62cc133 ("Bluetooth: hci_uart: fix race during initialization")
>>>>
>>>> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> 
> 

