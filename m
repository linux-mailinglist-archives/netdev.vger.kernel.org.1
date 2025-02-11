Return-Path: <netdev+bounces-165186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AB9A30DFD
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 15:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 164261886F13
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 14:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D9D21CFF7;
	Tue, 11 Feb 2025 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="CIoCgiDr"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B70C26BD81;
	Tue, 11 Feb 2025 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739283404; cv=none; b=C+LmhIRsEtMB1zpDrXq8fbmQ64idsIqRcgJA7i0PFPpo6iyBN2M5m4bb95IuEhulmqwAerUIrE4+X6e2si2ITcCZ1LXOlcfQY3t4e27N3Glo2QSDbmhfj6uIHew7F9RilWQx5sXVkoPF5sGuAGTa16ePgFcXkOWPNBUJsy7pBhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739283404; c=relaxed/simple;
	bh=Av6E65X93ZDV7ReN7FBX9WeuiuZfRC5v81xAZZU2K2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZGjahQJw+ppi1t5HWYFQuT6bm3CncNmXUlPXdEmQE35j7m/4VKcJEDU0xVWyIIL18VciKuD+gjevwC2GWA9LAF984B31pJ5BoUWiAfg4Eu/0TyqBSwF4CDcF++0a1+KQ5csYJllwlebQSZckCRjlJljMBMiY5JlzqugmA8RVtZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=CIoCgiDr; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id DC83412000C;
	Tue, 11 Feb 2025 17:16:34 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru DC83412000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1739283394;
	bh=a9bkt3y3P97QXCwMrtbY2A0SpgcCvcSFAyWcYlq9ZMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=CIoCgiDrMl5ZIV5lLG4AK3tLdI1jiyPY6fYBFL4Y8vaDaqKLtOi11XFq4ZDs15Kw0
	 ZSNg0uOib3sduFNy2dT4G9Fv9CRRqpWGEIMfc744TaOSDWc4902xM+sSRgROtbrM5b
	 vYIOWBVdJWSkKcHzORXUw1voROX8YkZmVJd8G71UX7JQz18zsxk1WQ4nNVm7RN1Hna
	 5ASJHUkpjJMGX5zlFy/P4a/+/d4tbuBUEXPo4gSVLip+7oE4NptF8ZhxWpuluOJ0kX
	 aduiYb5mg454dg9l/OBYNBYBxgEkMuaoMxPCfJZIL2YXXF0dp7wTIgwOk1iqNOI4Eb
	 OaUkPPbUfTvZg==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 11 Feb 2025 17:16:34 +0300 (MSK)
Message-ID: <e8b8686f-8de1-aa25-9707-fcad4ffa5710@salutedevices.com>
Date: Tue, 11 Feb 2025 17:16:29 +0300
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
To: <hdanton@sina.com>, <linux-bluetooth@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luiz.dentz@gmail.com>,
	<luiz.von.dentz@intel.com>, <marcel@holtmann.org>, <netdev@vger.kernel.org>,
	<syzkaller-bugs@googlegroups.com>
References: <67a9e24a.050a0220.3d72c.0050.GAE@google.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <67a9e24a.050a0220.3d72c.0050.GAE@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 190939 [Feb 11 2025]
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, syzkaller.appspot.com:5.0.1,7.1.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;goo.gl:5.0.1,7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2025/02/11 13:33:00
X-KSMG-LinksScanning: Clean, bases: 2025/02/11 13:29:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/02/11 08:54:00 #27149591
X-KSMG-AntiVirus-Status: Clean, skipped

Hi, I guess problem here is that, if hci_uart_tty_close() will be called between
setting HCI_UART_PROTO_READY and skb_queue_head_init(), in that case mrvl_close()
will access uninitialized data.

hci_uart_set_proto() {
        ...
        set_bit(HCI_UART_PROTO_READY, &hu->flags);
                                                   
        err = hci_uart_register_dev(hu);
                mrvl_open()
                    skb_queue_head_init();

        if (err) {
                return err;
        }
        ...
}

Thanks

On 10.02.2025 14:26, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit c411c62cc13319533b1861e00cedc4883c3bc1bb
> Author: Arseniy Krasnov <avkrasnov@salutedevices.com>
> Date:   Thu Jan 30 18:43:26 2025 +0000
> 
>     Bluetooth: hci_uart: fix race during initialization
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=116cebdf980000
> start commit:   40b8e93e17bf Add linux-next specific files for 20250204
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=136cebdf980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=156cebdf980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ec880188a87c6aad
> dashboard link: https://syzkaller.appspot.com/bug?extid=683f8cb11b94b1824c77
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b7eeb0580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f74f64580000
> 
> Reported-by: syzbot+683f8cb11b94b1824c77@syzkaller.appspotmail.com
> Fixes: c411c62cc133 ("Bluetooth: hci_uart: fix race during initialization")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

