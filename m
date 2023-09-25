Return-Path: <netdev+bounces-36155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE397ADBFE
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 17:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4E2632813CB
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 15:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663492137D;
	Mon, 25 Sep 2023 15:46:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F600111A0
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 15:46:02 +0000 (UTC)
Received: from anon.cephalopo.net (anon.cephalopo.net [128.76.233.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5F395
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 08:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lagy.org; s=def2;
	t=1695656759; bh=DPaUdruEHRuwltFKWgjx9BLwrVTlDUyP0M0hpwrk2dk=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=g2BuVjUxi8iayj7QOcsgCwyPnB9VtB+uWK/F+YEIzWnhNV/LJp0uj2gsVCsN0MdaX
	 jHKOMMNyQmoeffb0Y527IIt7r10x7TaOTbwwhXchAmEaXjrNKgAVoXCHNeVqdpuEjt
	 Dyo6h/yEUyNmcgj4xxNwAxdrc08s7ity4L1cZL/LTzu821JsQ/cjrNHHmXDvb0EvoA
	 gc8XUsfKF/f3yZH2Zqp5gU4oFIyumFTQf0ziGNvmcAor8BxIlQZoNMvvVf1h9G1gSf
	 HD4A9tDWMU1ikVKUmZ1G7Xf6oMS7XXFhNQD2/yA7+x4PLEY4nMZr7GPvZ7u32gT9GE
	 sx6nKsDm+0moA==
Authentication-Results: anon.cephalopo.net;
	auth=pass smtp.auth=u1 smtp.mailfrom=me@lagy.org
Received: from localhost (ws.c.lan [172.18.134.9])
	by anon.cephalopo.net (Postfix) with ESMTPSA id AF05411C00BE;
	Mon, 25 Sep 2023 17:45:59 +0200 (CEST)
References: <87zg30a0h9.fsf@lagy.org> <20230809125805.2e3f86ac@kernel.org>
 <87a5taabs9.fsf@mkjws.danelec-net.lan>
 <4ed0991b-5473-409d-b00a-bf71f0877df5@gmail.com>
 <87y1guv5p7.fsf@mkjws.danelec-net.lan>
 <e391ca3b-c3e8-478a-a771-2554b8b828c0@gmail.com>
User-agent: mu4e 1.8.13; emacs 29.1
From: Martin =?utf-8?Q?Kj=C3=A6r_J=C3=B8rgensen?= <me@lagy.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 nic_swsd@realtek.com
Subject: Re: r8169 link up but no traffic, and watchdog error
Date: Mon, 25 Sep 2023 17:41:47 +0200
In-reply-to: <e391ca3b-c3e8-478a-a771-2554b8b828c0@gmail.com>
Message-ID: <87ttriqmru.fsf@ws.c.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On Mon, Sep 25 2023, Heiner Kallweit <hkallweit1@gmail.com> wrote:

> On 25.09.2023 13:30, Martin Kj=C3=A6r J=C3=B8rgensen wrote:
>>
>> On Mon, Sep 25 2023, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>>
>> There are no PCI extension cards.
>>
>
> Your BIOS signature indicates that the system is a Thinkstation P350.
> According to the Lenovo website it comes with one Intel-based network por=
t.
> However you have additional 4 Realtek-based network ports on the mainboar=
d?
>

Yes. 2 PCIE cards with two Realtek ethernet controllers each.

>>> And does the problem occur with all of your NICs?
>>
>> No, only the Realtek ones.
>>
>>> The exact NIC type might provide a hint, best provide a full dmesg log.
>> [ 1512.295490] RSP: 0018:ffffbc0240193e88 EFLAGS: 00000246
>> [ 1512.295492] RAX: ffff998935680000 RBX: ffffdc023faa8e00 RCX: 00000000=
0000001f
>> [ 1512.295493] RDX: 0000000000000002 RSI: ffffffffb544f718 RDI: ffffffff=
b543bc32
>> [ 1512.295494] RBP: 0000000000000003 R08: 0000000000000000 R09: 00000000=
00000018
>> [ 1512.295495] R10: ffff9989356b1dc4 R11: 00000000000058a8 R12: ffffffff=
b5d981a0
>> [ 1512.295496] R13: 000001601bd198ef R14: 0000000000000003 R15: 00000000=
00000000
>> [ 1512.295497]  ? cpuidle_enter_state+0xbd/0x440
>> [ 1512.295499]  cpuidle_enter+0x2d/0x40
>> [ 1512.295501]  do_idle+0x217/0x270
>> [ 1512.295503]  cpu_startup_entry+0x1d/0x20
>> [ 1512.295505]  start_secondary+0x11a/0x140
>> [ 1512.295508]  secondary_startup_64_no_verify+0x17e/0x18b
>> [ 1512.295510]  </TASK>
>> [ 1512.295511] ---[ end trace 0000000000000000 ]---
>> [ 1512.295526] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have A=
SPM control
>> [ 1531.322039] r8169 0000:03:00.0 enp3s0: Link is Down
>> [ 1534.138489] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow=
 control rx/tx
>> [ 1538.177385] r8169 0000:03:00.0 enp3s0: Link is Down
>> [ 1566.174660] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow=
 control rx/tx
>> [ 1567.839082] r8169 0000:03:00.0 enp3s0: Link is Down
>> [ 1570.621088] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow=
 control rx/tx
>> [ 1576.294267] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have A=
SPM control
>
> Regarding the following: Issue occurs after few seconds of link-loss.
> Was this an intentional link-down event?

Yes, I intentionally unplug the cable at the other end for the link to go d=
own.

> And is issue always related to link-up after a link-loss period?
>

Yes, it happends after cable is plugged in again, so after a link-loss peri=
od.


>> [ 1488.643231] r8169 0000:03:00.0 enp3s0: Link is Down
>> [ 1506.576941] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow=
 control rx/tx
>> [ 1512.295215] ------------[ cut here ]------------
>> [ 1512.295219] NETDEV WATCHDOG: enp3s0 (r8169): transmit queue 0 timed o=
ut 5368 ms

