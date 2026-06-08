Return-Path: <netdev+bounces-296436-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DT36EyiOJmq0YgIAu9opvQ
	(envelope-from <netdev+bounces-296436-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 11:40:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A07654ABC
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 11:40:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296436-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296436-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=kabelmail.de (policy=reject);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5F43303259C
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 09:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2353A7F79;
	Mon,  8 Jun 2026 09:35:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay-b01.edpnet.be (relay-b01.edpnet.be [212.71.1.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3941419A4
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 09:35:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780911324; cv=none; b=jmQ5YrrvvX2kxMJKjIr0uoN5+3VcE6yAcccnTvfbxzWFl3cJCy0SaY+EbvyyIGIF1+eOUNcO3jmG+3fuzaFDS8/VSmo9TvBC0igycv490J93IVSs7907/++ZhUN7mGJMvnH8ZQoWA097I23OC6ltzXWq0RouS81zr7B2O7vpY1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780911324; c=relaxed/simple;
	bh=m+tGjoIq3m3dzG/J2EvBsluXCR7A+cn2+oiv/sXot4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oiuUaNAYG6K2UcihNJnGIBk0UT0ZApYTd+zkxAds8CFSaEHqmrouZDMW2RCKVnMJm/sEZqAyq52kRX7q/9x6VMSUXOrUAKi9LU8ZpMDy+SAqUV0bz3C8I/06GxzQF8KYGqR83fDBvYjG7NgOay8paIJaTNAxYKnFjMhSIGSIbrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=kabelmail.de; spf=fail smtp.mailfrom=kabelmail.de; arc=none smtp.client-ip=212.71.1.221
Received: from [192.168.177.83] (212.71.13.3.static.edpnet.net [212.71.13.3]) by relay-b01.edpnet.be with ESMTP id 5bhmfmdAC185yeE9; Mon, 08 Jun 2026 11:21:05 +0200 (CEST)
X-Barracuda-Envelope-From: janpieter.sollie@kabelmail.de
X-Barracuda-Effective-Source-IP: 212.71.13.3.static.edpnet.net[212.71.13.3]
X-Barracuda-Apparent-Source-IP: 212.71.13.3
Message-ID: <7c0cf4f7-6e32-454b-bd56-5ef00eab8f98@kabelmail.de>
Date: Mon, 8 Jun 2026 11:20:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SFP/MDIO/I2C: help requested unlocking a SFP+ MCU to expose PHY
To: Andrew Lunn <andrew@lunn.ch>, Nicolai Buchwitz <nb@tipi-net.de>
X-ASG-Orig-Subj: Re: SFP/MDIO/I2C: help requested unlocking a SFP+ MCU to expose PHY
Cc: netdev@vger.kernel.org
References: <ec5bd768-3f54-4c30-b5a2-1e0b43f789e3@kabelmail.de>
 <903daf32-aecd-4160-8f69-4fc329fdad3f@lunn.ch>
 <49CA4531-3BDC-4054-8830-BA80775C2B68@tipi-net.de>
 <dc641872-9ac5-407b-b1c4-04cac5f0ef8a@lunn.ch>
Content-Language: en-US
From: Janpieter Sollie <janpieter.sollie@kabelmail.de>
Autocrypt: addr=janpieter.sollie@kabelmail.de; keydata=
 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
In-Reply-To: <dc641872-9ac5-407b-b1c4-04cac5f0ef8a@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Barracuda-Connect: 212.71.13.3.static.edpnet.net[212.71.13.3]
X-Barracuda-Start-Time: 1780910465
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 8893
X-Barracuda-BRTS-Status: 1
X-ASG-Debug-ID: 1780910465-23923417bd373410001-BZBGGp
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=10.0 QUARANTINE_LEVEL=10.0 KILL_LEVEL=7.0 test= 
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.125474
	Rule breakdown below
	  pts rule name              description
	 ---- ---------------------- --------------------------------------------------
	
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[kabelmail.de : SPF not aligned (relaxed), No valid DKIM,reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-296436-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[janpieter.sollie@kabelmail.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:nb@tipi-net.de,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[janpieter.sollie@kabelmail.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kabelmail.de:from_mime,kabelmail.de:mid,10gtek.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94A07654ABC

Op 5/06/2026 om 23:34 schreef Andrew Lunn:
>>> Do you know what MCU is in the SFP? Is there a data sheet for it? Can
>>> you read out the EEPROM holding its code over the I2C bus? You can
>>> then disassemble/decompile the code and see what it is actually doing.
>> https://doc.10gtek.com/file/file/20240806/d6fa28f954989f74cde42c75353b5fe6.pdf
>>
>> I2c address should be A0h
> That is the usual address for an SFP. However, MCUs sometime have ways
> to program them, etc. That is why i asked if you know what the MCU
> is. I guess you have not taken one apart to see what is actually in
> it.
>
> 	Andrew
>
>
Thank you for your help, I was quite a bit lost in there.
I got 2 modules, so I can send a dump of both, but my guess is that only 1 will be sufficient.
Let me know whether you want the 2nd as well.
below you can see the output.
I was surprised reading OEM SFP-10G-T instead of ASF-10G-T80. but that's 10Gtek's decision , not 
mine.
i2cdump and i2csfp eepromdump (but only 0x51, 0x50 is already in i2cdetect).
This is the output with IC_MDIO_NONE, so sfp.ko did not touch any config yet (I guess):
Should I really take it apart? or is there a "in between" solution?

Thank you for your suggestions,

Janpieter Sollie

i2cdetect -y 3
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: 50 51 -- -- -- -- 56 -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: UU -- -- -- -- -- -- --
# i2cdump -y 3 0x50
   0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f 0123456789abcdef
00: 03 04 07 10 00 00 00 00 00 00 00 06 67 00 00 00 ????.......?g...
10: 08 02 00 1e 4f 45 4d 20 20 20 20 20 20 20 20 20    ??.?OEM
20: 20 20 20 20 00 00 90 65 53 46 50 2d 31 30 47 2d ..?eSFP-10G-
30: 54 20 20 20 20 20 20 20 30 32 20 20 03 52 00 3f    T       02 ?R.?
40: 00 1a 00 00 43 53 59 31 30 31 50 41 36 32 35 39 .?..CSY101PA6259
50: 20 20 20 20 32 35 30 39 33 30 20 20 68 80 03 e0        250930 h???
60: 00 00 11 b9 60 12 02 18 29 53 70 64 c1 b1 1d 95 ..??`???)Spd????
70: a1 2f 32 00 00 00 00 00 00 00 00 00 a4 f7 d6 06 ?/2.........????
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
# i2cdump -y 3 0x51
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f 0123456789abcdef
00: 5f 00 7f 03 5a 00 d3 00 8c a0 75 30 88 b8 79 18 _.??Z.?.??u0??y?
10: 1d 4c 01 f4 19 64 03 e8 4d f0 06 30 3d e8 06 f2 ?L???d??M??0=???
20: 2b d4 00 c7 27 10 00 df 00 00 00 00 00 00 00 00 +?.?'?.?........
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
40: 00 00 00 00 3f 80 00 00 00 00 00 00 01 00 00 00 ....??......?...
50: 01 00 00 00 01 00 00 00 01 00 00 00 00 00 00 a5 ?...?...?......?
60: 47 4f 82 78 0b b8 13 88 0f a0 00 00 00 00 00 00 GO?x??????......
70: 40 00 00 00 00 00 00 00 03 00 00 ff ff ff ff 00 @.......?.......
80: 43 4f 55 49 41 38 4e 43 41 41 31 30 2d 32 34 31 COUIA8NCAA10-241
90: 35 2d 30 33 56 30 33 20 01 00 46 00 00 00 00 c6    5-03V03 ?.F....?
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 aa 36 ..............?6
c0: 53 46 50 2d 31 30 47 2d 53 52 20 20 20 20 20 20    SFP-10G-SR
d0: 20 20 20 20 32 33 00 00 00 00 00 00 00 00 00 35 23.........5
e0: 15 1a 20 24 2a 30 20 30 00 00 00 00 00 00 00 00    ?? $*0 0........
f0: 00 00 00 00 00 1d 00 00 ff ff ff ff 00 00 00 00 .....?..........
# i2cdump -y 3 0x56
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f 0123456789abcdef
00: 20 40 00 06 35 90 50 81 60 31 00 9b c0 00 00 09  @.?5?P?`1.??..?
10: 93 01 00 00 00 1f 41 a4 41 a4 41 a4 00 00 00 00 ??...?A?A?A?....
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ................


i2csfp /dev/i2c-3 eepromdump
...

0x51:
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f  0123456789abcdef
00: 5f 00 7f 03 5a 00 d3 00 8c a0 75 30 88 b8 79 18  _...Z.....u0..y.
10: 1d 4c 01 f4 19 64 03 e8 4d f0 06 30 3d e8 06 f2  .L...d..M..0=...
20: 2b d4 00 c7 27 10 00 df 00 00 00 00 00 00 00 00  +...'...........
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
40: 00 00 00 00 3f 80 00 00 00 00 00 00 01 00 00 00  ....?...........
50: 01 00 00 00 01 00 00 00 01 00 00 00 00 00 00 a5  ................
60: 46 91 82 78 0b b8 13 88 0f a0 00 00 00 00 00 00  F..x............
70: 40 00 00 00 00 00 00 00 03 00 00 ff ff ff ff 00  @...............
0x51 PAGE 0x00:
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f  0123456789abcdef
80: 43 4f 55 49 41 38 4e 43 41 41 31 30 2d 32 34 31  COUIA8NCAA10-241
90: 35 2d 30 33 56 30 33 20 01 00 46 00 00 00 00 c6   5-03V03 ..F.....
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 aa 36  ...............6
c0: 53 46 50 2d 31 30 47 2d 53 52 20 20 20 20 20 20   SFP-10G-SR
d0: 20 20 20 20 32 33 00 00 00 00 00 00 00 00 00 35  23.........5
e0: 15 1a 20 24 2a 30 20 30 00 00 00 00 00 00 00 00   .. $*0 0........
f0: 00 00 00 00 00 1d 00 00 ff ff ff ff 00 00 00 00  ................
0x51 PAGE 0x01:
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f  0123456789abcdef
80: 43 4f 55 49 41 38 4e 43 41 41 31 30 2d 32 34 31  COUIA8NCAA10-241
90: 35 2d 30 33 56 30 33 20 01 00 46 00 00 00 00 c6   5-03V03 ..F.....
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 aa 36  ...............6
c0: 53 46 50 2d 31 30 47 2d 53 52 20 20 20 20 20 20   SFP-10G-SR
d0: 20 20 20 20 32 33 00 00 00 00 00 00 00 00 00 35  23.........5
e0: 15 1a 20 24 2a 30 20 30 00 00 00 00 00 00 00 00   .. $*0 0........
f0: 00 00 00 00 00 1d 00 00 ff ff ff ff 00 00 00 00  ................
0x51 PAGE 0x02:
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f  0123456789abcdef
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
0x51 PAGE 0x03:
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f  0123456789abcdef
80: 00 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
f0: ff ff ff ff ff 56 31 33 ff ff 02 00 63 73 77 77  .....V13....csww


