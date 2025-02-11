Return-Path: <netdev+bounces-165221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50461A31128
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 17:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571FF161C54
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 16:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A353224C679;
	Tue, 11 Feb 2025 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="JnGDb0UY"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F51D21D5B8;
	Tue, 11 Feb 2025 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739290989; cv=none; b=EEOLN7qg9ScVL/rftFMZ2s209QGp7hCei0xPCsGAVllmPJ2ShRaDdNeFHhIwvTjR8elegRPn+YRb80vFEtWuj9ld/m6sM5Ft74aqtR5W0tmpHJGCADSYFJ1Qwi38EnZ5S5p1xTVyNwONjVjD4dTDXvxAsXG7EJ40isbsjzVQzk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739290989; c=relaxed/simple;
	bh=93OCurokwazYSKoYLZQnYciT9cqkswl/r4fl+UXzcyE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Mm6CZ8EVdFBgOsjuvx41RhDlxo1dJEpQHqCBl9py04DIBZxpgmvlsVPorloTv+xWVl6mo1USzIQ7xwz/RLmq2HtgStmchJYrKuFdbj+ua5QvyM1cZfI0XJ40Zjqix134wuL0/czFhBVsmt2SWMTdMD2Fr6Nk8iaQjRiX6yUXj3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=JnGDb0UY; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id E5A10120007;
	Tue, 11 Feb 2025 19:22:53 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru E5A10120007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1739290973;
	bh=WPFZfeQ8PegZ3Nuh6+l4FJbam841wWNz+m9Q/mulbrg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type:From;
	b=JnGDb0UYpInSi1z5y8lw7H2IrPn4ZoCX9kiLB5WT46LGpgIx/lLIsjSxvk6Z6cLq/
	 TKUf4ufM3I/cfDlckqTv62RnXPDsgE7R3UxdnxzLiIsOlYxyWW2vMM9szNK4dR1g85
	 jsyCPlCWLrwAHEWL/tOQ1HE74Q8PLqsEWbA72oNQCPVQhBgNaUY2V87BlzFmVgAIqC
	 36RKoISq0Z21IIU6AMoI+bu/QlDzxJ5+mQkKQzIxZtE4ZMpsSl72aqK79LAAzqvz9t
	 kl1cw4UT+3WTrJibuZvHrbJAoT8K1NgsC1MZEhzbCc6/rHqCaXgX7kocj1b9WmOQvh
	 9nZROV0z256hQ==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 11 Feb 2025 19:22:53 +0300 (MSK)
Message-ID: <c2d99ec3-d69e-b47d-45cc-0ad39893afd7@salutedevices.com>
Date: Tue, 11 Feb 2025 19:22:51 +0300
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
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
To: <hdanton@sina.com>, <linux-bluetooth@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luiz.dentz@gmail.com>,
	<luiz.von.dentz@intel.com>, <marcel@holtmann.org>, <netdev@vger.kernel.org>
References: <67a9e24a.050a0220.3d72c.0050.GAE@google.com>
 <e8b8686f-8de1-aa25-9707-fcad4ffa5710@salutedevices.com>
In-Reply-To: <e8b8686f-8de1-aa25-9707-fcad4ffa5710@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 190946 [Feb 11 2025]
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;lore.kernel.org:7.1.1;syzkaller.appspot.com:7.1.1,5.0.1;salutedevices.com:7.1.1;goo.gl:7.1.1,5.0.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2025/02/11 14:44:00
X-KSMG-LinksScanning: Clean, bases: 2025/02/11 14:43:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/02/11 08:54:00 #27149591
X-KSMG-AntiVirus-Status: Clean, skipped

May be my previous version was free of this problem ?

https://lore.kernel.org/linux-bluetooth/a1db0c90-1803-e01c-3e23-d18e4343a4eb@salutedevices.com/

Thanks

On 11.02.2025 17:16, Arseniy Krasnov wrote:
> Hi, I guess problem here is that, if hci_uart_tty_close() will be called between
> setting HCI_UART_PROTO_READY and skb_queue_head_init(), in that case mrvl_close()
> will access uninitialized data.
> 
> hci_uart_set_proto() {
>         ...
>         set_bit(HCI_UART_PROTO_READY, &hu->flags);
>                                                    
>         err = hci_uart_register_dev(hu);
>                 mrvl_open()
>                     skb_queue_head_init();
> 
>         if (err) {
>                 return err;
>         }
>         ...
> }
> 
> Thanks
> 
> On 10.02.2025 14:26, syzbot wrote:
>> syzbot has bisected this issue to:
>>
>> commit c411c62cc13319533b1861e00cedc4883c3bc1bb
>> Author: Arseniy Krasnov <avkrasnov@salutedevices.com>
>> Date:   Thu Jan 30 18:43:26 2025 +0000
>>
>>     Bluetooth: hci_uart: fix race during initialization
>>
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=116cebdf980000
>> start commit:   40b8e93e17bf Add linux-next specific files for 20250204
>> git tree:       linux-next
>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=136cebdf980000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=156cebdf980000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=ec880188a87c6aad
>> dashboard link: https://syzkaller.appspot.com/bug?extid=683f8cb11b94b1824c77
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b7eeb0580000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f74f64580000
>>
>> Reported-by: syzbot+683f8cb11b94b1824c77@syzkaller.appspotmail.com
>> Fixes: c411c62cc133 ("Bluetooth: hci_uart: fix race during initialization")
>>
>> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

