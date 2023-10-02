Return-Path: <netdev+bounces-37616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD517B6593
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 11:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 05CEF2814F3
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 09:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316CBDF65;
	Tue,  3 Oct 2023 09:34:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869586AB3
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 09:34:02 +0000 (UTC)
X-Greylist: delayed 4199 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Oct 2023 02:34:00 PDT
Received: from anon.cephalopo.net (93-160-30-86-cable.dk.customer.tdc.net [93.160.30.86])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596DFAB
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 02:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lagy.org; s=def2;
	t=1696235609; bh=J9GYgPKEVNOC8VA9fZaZIaeVG1ROlCBm2binmr7WsSg=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=4jx8wbK6oqs4QrvXrYS+MefPgs3MPVZDsSY++CsqGlNmnAJzUDh7QXKVzf6rwrSvF
	 P7T64cddvbroDd0gU7gB/QnerZ/0ldIv3romOCOtp6Hr5DuByo8euesPOH6QAlFJ3F
	 TPt68nd2ISkfP89sfHqbmm5uNag52mqpjS57iLJZzuRfYXxV0/hBDK6z7e2xG1ppkA
	 5cuAuP0powlBMquWdbH0Gv7IP6FIXvFD6XL6g54FdLsoo4Ph8wn5CF4QIlJHa+9yhw
	 uZJU1P2FmXL/h8sHINHJ2jICb8cKbLAx4pJawyhbu0I5JpgLCt0YANkmUJry9Ki+fR
	 48rREy36T3Gag==
Authentication-Results: anon.cephalopo.net;
	auth=pass smtp.auth=u1 smtp.mailfrom=me@lagy.org
Received: from localhost (unknown [109.70.55.226])
	by anon.cephalopo.net (Postfix) with ESMTPSA id 749C011C00BE;
	Mon,  2 Oct 2023 10:33:29 +0200 (CEST)
References: <87zg30a0h9.fsf@lagy.org> <20230809125805.2e3f86ac@kernel.org>
 <87a5taabs9.fsf@mkjws.danelec-net.lan>
 <4ed0991b-5473-409d-b00a-bf71f0877df5@gmail.com>
 <87y1guv5p7.fsf@mkjws.danelec-net.lan>
 <e391ca3b-c3e8-478a-a771-2554b8b828c0@gmail.com> <87ttriqmru.fsf@ws.c.lan>
 <f29267e6-e9a4-4755-b707-2bca9a65cf36@gmail.com>
User-agent: mu4e 1.8.13; emacs 29.1
From: Martin =?utf-8?Q?Kj=C3=A6r_J=C3=B8rgensen?= <me@lagy.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 nic_swsd@realtek.com
Subject: Re: r8169 link up but no traffic, and watchdog error
Date: Mon, 02 Oct 2023 10:28:28 +0200
In-reply-to: <f29267e6-e9a4-4755-b707-2bca9a65cf36@gmail.com>
Message-ID: <87msx1bezt.fsf@mkjws.danelec-net.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
	RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On Mon, Sep 25 2023, Heiner Kallweit <hkallweit1@gmail.com> wrote:

> On 25.09.2023 17:41, Martin Kj=C3=A6r J=C3=B8rgensen wrote:
>>
>> On Mon, Sep 25 2023, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>>> On 25.09.2023 13:30, Martin Kj=C3=A6r J=C3=B8rgensen wrote:
>>>>
>>>> On Mon, Sep 25 2023, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>>
>>>>
>>>> There are no PCI extension cards.
>>>>
>>>
>>> Your BIOS signature indicates that the system is a Thinkstation P350.
>>> According to the Lenovo website it comes with one Intel-based network p=
ort.
>>> However you have additional 4 Realtek-based network ports on the mainbo=
ard?
>>>
>>
>> Yes. 2 PCIE cards with two Realtek ethernet controllers each.
>>
>>>>> And does the problem occur with all of your NICs?
>>>>
>>>> No, only the Realtek ones.
>>>>
>>>>> The exact NIC type might provide a hint, best provide a full dmesg lo=
g.
>>>> [ 1512.295490] RSP: 0018:ffffbc0240193e88 EFLAGS: 00000246
>>>> [ 1512.295492] RAX: ffff998935680000 RBX: ffffdc023faa8e00 RCX: 000000=
000000001f
>>>> [ 1512.295493] RDX: 0000000000000002 RSI: ffffffffb544f718 RDI: ffffff=
ffb543bc32
>>>> [ 1512.295494] RBP: 0000000000000003 R08: 0000000000000000 R09: 000000=
0000000018
>>>> [ 1512.295495] R10: ffff9989356b1dc4 R11: 00000000000058a8 R12: ffffff=
ffb5d981a0
>>>> [ 1512.295496] R13: 000001601bd198ef R14: 0000000000000003 R15: 000000=
0000000000
>>>> [ 1512.295497]  ? cpuidle_enter_state+0xbd/0x440
>>>> [ 1512.295499]  cpuidle_enter+0x2d/0x40
>>>> [ 1512.295501]  do_idle+0x217/0x270
>>>> [ 1512.295503]  cpu_startup_entry+0x1d/0x20
>>>> [ 1512.295505]  start_secondary+0x11a/0x140
>>>> [ 1512.295508]  secondary_startup_64_no_verify+0x17e/0x18b
>>>> [ 1512.295510]  </TASK>
>>>> [ 1512.295511] ---[ end trace 0000000000000000 ]---
>>>> [ 1512.295526] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have=
 ASPM control
>>>> [ 1531.322039] r8169 0000:03:00.0 enp3s0: Link is Down
>>>> [ 1534.138489] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - fl=
ow control rx/tx
>>>> [ 1538.177385] r8169 0000:03:00.0 enp3s0: Link is Down
>>>> [ 1566.174660] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - fl=
ow control rx/tx
>>>> [ 1567.839082] r8169 0000:03:00.0 enp3s0: Link is Down
>>>> [ 1570.621088] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - fl=
ow control rx/tx
>>>> [ 1576.294267] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have=
 ASPM control
>>>
>>> Regarding the following: Issue occurs after few seconds of link-loss.
>>> Was this an intentional link-down event?
>>
>> Yes, I intentionally unplug the cable at the other end for the link to g=
o down.
>>
>>> And is issue always related to link-up after a link-loss period?
>>>
>>
>> Yes, it happends after cable is plugged in again, so after a link-loss p=
eriod.
>>
>>
>>>> [ 1488.643231] r8169 0000:03:00.0 enp3s0: Link is Down
>>>> [ 1506.576941] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - fl=
ow control rx/tx
>>>> [ 1512.295215] ------------[ cut here ]------------
>>>> [ 1512.295219] NETDEV WATCHDOG: enp3s0 (r8169): transmit queue 0 timed=
 out 5368 ms
>
> Could you please test whether the following helps?
>
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethe=
rnet/realtek/r8169_main.c
> index 6351a2dc1..a2fbfff5a 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -4596,7 +4596,9 @@ static void r8169_phylink_handler(struct net_device=
 *ndev)
>  	if (netif_carrier_ok(ndev)) {
>  		rtl_link_chg_patch(tp);
>  		pm_request_resume(d);
> +		netif_wake_queue(tp->dev);
>  	} else {
> +		rtl_reset_work(tp);
>  		pm_runtime_idle(d);
>  	}

This patch seems to have a good influence. I have applied it to a vanilla
6.1.55 kernel, and been using it for a while.

No kernel netdev watchdog errors, and interface responds to traffic almost
instantly when it gets up again after link loss :-)

