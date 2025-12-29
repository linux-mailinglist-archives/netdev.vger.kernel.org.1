Return-Path: <netdev+bounces-246212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3804CE5E73
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 05:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 147983004F73
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 04:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D532C2EA;
	Mon, 29 Dec 2025 04:19:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D87FAD5A
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 04:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766981944; cv=none; b=hHy1i3jvNoOUnHSHi/k63jFU06kgnVdighAHiLpZ/AdHoa2GV0zL1dcX5quO1+3h50obeh9pwogKIxvU4QXrbDkPctWwTsFeKw6tqwcVv25Fq7eEzpmMXpeUCAWVZrhFVEZc8Rps2ofu3woZjIeTCcqTNFUqmJFg/luOrd6gLxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766981944; c=relaxed/simple;
	bh=lkw/+atPxW7AA3kjcz7U+nXpWcQNiqLT7AOcnmnjzHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dNME0QcAyvQ6jy/+OnYE4+gba+bG/24fCpYPwXzDSf3ir34rx0M9HeBJMb/JplOaLxiCPrsgLE3OnWt+2RMDNvxcaPAPhVjWdoEThK0ZXF5YRO00tmgDmiL7vjQkEpLBu8tBCi4lXBea70u7MrKGdhp4NNdNPk9VIpFP1MH+5Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip4t1766981924t8f506d98
X-QQ-Originating-IP: xw7EXW2ieoe1L2q2bgUK/SIDg20cC3Xa74+GoFuIlJI=
Received: from [IPV6:240f:10b:7440:1:3961:bf03 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Dec 2025 12:18:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5321299945096190126
Message-ID: <4B0E7A890ED5AF50+57f079d1-0be3-4d27-8118-1216bef2076a@radxa.com>
Date: Mon, 29 Dec 2025 13:18:42 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] r8169: add support for RTL8127ATF
To: Heiner Kallweit <hkallweit1@gmail.com>,
 Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Michael Zimmermann <sigmaepsilon92@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251120195055.3127-1-fabio.baltieri@gmail.com>
 <f263daf0-70c2-46c2-af25-653ff3179cb0@gmail.com>
 <aSDLYiBftMR9ArUI@google.com>
 <b012587a-2c38-4597-9af9-3ba723ba6cba@gmail.com>
 <aSNVVoAOQHbleZFF@google.com>
 <0cacca03-6302-4e39-a807-06591bf787b1@gmail.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <0cacca03-6302-4e39-a807-06591bf787b1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OSjQccS6YHkHxppCOJg+azNBeIImlJAqzbQ6fJnYyxkKQWPbcljSDEMr
	XyjOYEjhlWs0Re4zDK/SviunNv6qZZ+7mlHW7Wnw2pX1yEpXhC4W3514IQ3lcgt564aWZAp
	nqmStkFk//yAX41yDtWhR+9pZtKXKHZqXA7tkScm/xxIBpfb+M3lSdDKTv/xuc9lu08dfqY
	E8VPoTKP3IaX/eYZFiBJpFJBEWhKCP+1dvGrE6upyPT0OBMNdiWfM6sk7I+TABW/STj1nWi
	pruGeXeaQB8x5yob0CbFGT68vdoWFps6gN4JPhlrwEupuSe73oQRK/d2P+YWt5ZCl2Ccdjc
	vJNto6QUmNHiH2ulYZI10VaYflYL6o8F+ipAIoorXG6C+8Z4XD09UT3Vs0aeOo3Td5CReeE
	sKbLGbah4Mb6ngtk5RIEn+q4LLYrmBQY9Syt26A/RklpDSXc0h45FCbs7T1Zy8E81GGkyRk
	UmRNGzoczxvI5Fp844AroYOahh7w54zoi3VhpkFavA45empLNCTC5LLE/MJFTJZvGw/DPfC
	LIoXdJRTxb7w3UYdCUVlbkhQ96PUtaRNc0eAdca4kcKFiKum2fgSewI3ncxlHk06mShGQa4
	NUvRsDF51rWKK5yzOzUPZJmd1XX9CM3H1mkYgHMWtrwgzWSWs0SmXg7Y4w78+ZmtwSq8KDZ
	vbhhadBSZUXj1+rMkbIHhhyzUgYorjaEfPdxkxL00R+jgOftnCpeDbx4ht5ZSnjnbMZkFpm
	UhluxYm54ihSrqeNMR0RGeC4274P340bRp12zRj+eqCbXAg4B7pICyFhYw7P0sAKr6qBCGE
	9ixQCHJpHX+Q8PWTIoBeqZcfQs9pd6CiMLk34wRoqICGDiazF1JrUlhuI53gklGp4JO055G
	Mp3Lu4oXzR+3Oy2wjpIvyCnuJIiie57qiK7klzH3mlUSiIJI1QjltCyAbUB5CHc4y4LvKX/
	VyEEPVpB4AvWqpqL+Mx1UMlriorMRrKTpDCcKiqNS9TUPzUT7YPBKg0HU
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

Hi Heiner,

Thank you so much for your work!

On 11/24/25 07:54, Heiner Kallweit wrote:
> On 11/23/2025 7:41 PM, Fabio Baltieri wrote:
>> Hi Heiner,
>>
>> On Sun, Nov 23, 2025 at 04:58:23PM +0100, Heiner Kallweit wrote:
>>> This is a version with better integration with phylib, and with 10G support only.
>>> Maybe I simplified the PHY/Serdes initialization too much, we'll see.
>>> A difference to your version is that via ethtool you now can and have to set autoneg to off.
>>>
>>> I'd appreciate if you could give it a try and provide a full dmesg log and output of "ethtool <if>".
>>>
>>> Note: This patch applies on top of net-next and linux-next. However, if you apply it on top
>>> of some other recent kernel version, conflicts should be easy to resolve.
>>
>> Thanks for the patch, ran some initial tests, I'm on Linus tree for
>> other reasons but applied 3dc2a17efc5f, 1479493c91fc, 28c0074fd4b7 and
>> the recent suspend fix, then your patch applies cleanly.
>>
>> Here's ethtool output:
>>
>> # ethtool eth1
>> Settings for eth1:
>>          Supported ports: [  ]
>>          Supported link modes:   10000baseT/Full
>>          Supported pause frame use: Symmetric Receive-only
>>          Supports auto-negotiation: No
>>          Supported FEC modes: Not reported
>>          Advertised link modes:  10000baseT/Full
>>          Advertised pause frame use: Symmetric Receive-only
>>          Advertised auto-negotiation: No
>>          Advertised FEC modes: Not reported
>>          Speed: 10000Mb/s
>>          Duplex: Full
>>          Auto-negotiation: off
>>          master-slave status: master
>>          Port: Twisted Pair
>>          PHYAD: 0
>>          Transceiver: internal
>>          MDI-X: Unknown
>>          Supports Wake-on: pumbg
>>          Wake-on: d
>>          Link detected: yes
>>
>> The phy is identified correctly:
>>
>> [ 1563.678133] Realtek SFP PHY Mode r8169-1-500:00: attached PHY driver (mii_bus:phy_addr=r8169-1-500:00, irq=MAC)
>>
>> That said I've observed two issues with the current patch:
>>
>> 1. the link on the other end is flapping, I've seen this while working
>> on the original patch and seems to be due to the EEE settings, it is
>> addressed by:
>>
>> @@ -2439,7 +2439,10 @@ static void rtl8125a_config_eee_mac(struct rtl8169_private *tp)
>>
>>   static void rtl8125b_config_eee_mac(struct rtl8169_private *tp)
>>   {
>> -       r8168_mac_ocp_modify(tp, 0xe040, 0, BIT(1) | BIT(0));
>> +       if (tp->sfp_mode)
>> +               r8168_mac_ocp_modify(tp, 0xe040, BIT(1) | BIT(0), 0);
>> +       else
>> +               r8168_mac_ocp_modify(tp, 0xe040, 0, BIT(1) | BIT(0));
>>   }
>>
>>   static void rtl_rar_exgmac_set(struct rtl8169_private *tp, const u8 *addr)
>>
>>
>> 2. the link is lost after a module reload or after an ip link down and
>> up, the driver logs "Link is Down" and stays there until the cable is
>> unplugged and re-plugged. This seems to be addressed by the code that
>> was in rtl8127_sds_phy_reset(), re-adding that code fixes it:
>>
>> @@ -2477,6 +2480,13 @@ static void r8127_init_sfp_10g(struct rtl8169_private *tp)
>>   {
>>          int val;
>>
>> +       RTL_W8(tp, 0x2350, RTL_R8(tp, 0x2350) & ~BIT(0));
>> +       udelay(1);
>> +
>> +       RTL_W16(tp, 0x233a, 0x801f);
>> +       RTL_W8(tp, 0x2350, RTL_R8(tp, 0x2350) | BIT(0));
>> +       udelay(10);
>> +
>>          RTL_W16(tp, 0x233a, 0x801a);
>>          RTL_W16(tp, 0x233e, (RTL_R16(tp, 0x233e) & ~0x3003) | 0x1000);
>>
>> Guess the phy needs a reset after all.
>>
>> With these two applied it seems to be working fine, tested suspend as
>> well.
>>
>> Would you integrate these two or want to try me something different?
> 
> Thanks a lot for the valuable feedback!
> I added the SDS PHY reset to the patch, and improved MAC EEE handling
> in a second patch, incl. what you mentioned.
> Patches should fully cover your use case now. Please give it a try.

for 0001-r8169-add-support-for-10G-SFP-mode-on-RTL8127ATF.patch,

Tested-by: FUKAUMI Naoki <naoki@radxa.com>

Tested on Radxa ROCK 5B+/5T (RK3588 SoC) running v6.18.1 with the 
following commits applied:

  28c0074fd4b7 (r8169: bail out from probe if fiber mode is detected on 
RTL8127AF, 2025-11-13)
  87ad869feaed (r8169: improve MAC EEE handling, 2025-11-24)

$ lspci -s 0001:11:00.0 -v
0001:11:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 
8127 (rev 08)
	Subsystem: Realtek Semiconductor Co., Ltd. Device 0123
	Flags: bus master, fast devsel, latency 0, IRQ 77, IOMMU group 7
	I/O ports at 100000 [size=256]
	Memory at f1300000 (64-bit, non-prefetchable) [size=256K]
	Memory at f1360000 (64-bit, non-prefetchable) [size=16K]
	Expansion ROM at f1340000 [virtual] [disabled] [size=128K]
	Capabilities: <access denied>
	Kernel driver in use: r8169
	Kernel modules: r8169

$ dmesg | grep SFP
[    4.799931] Realtek SFP PHY Mode r8169-1-1100:00: attached PHY driver 
(mii_bus:phy_addr=r8169-1-1100:00, irq=MAC)

iperf3 results:

TX: 9.4 Gbps
RX: Limited to 5.5 Gbps due to single-core performance bottlenecks (RSS 
and RPS are not working)

It would be great if this could be backported to the v6.18.y.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

