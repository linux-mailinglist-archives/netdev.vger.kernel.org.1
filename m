Return-Path: <netdev+bounces-225279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFE6B91BCC
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 16:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 810847B1F6B
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 14:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E4B242D92;
	Mon, 22 Sep 2025 14:32:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay-b03.edpnet.be (relay-b03.edpnet.be [212.71.1.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D395163CF
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.71.1.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758551560; cv=none; b=RXJ+Rs10HXBuBEFMtkwt+5BT0hls4mbdfVLNmT+vFveEsPWVoF+8kxAeC6boxCMy4gxod6ZxcPDof1hU+ckfUMoNKq8PFGSXmaeJevE+6Yln4FPfeIYbGkp2WoAhj126KHnqrbyv1YW6ya5IzSiHw3JFoain4DDrC3gG5LJdNUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758551560; c=relaxed/simple;
	bh=v9u8kR/L4tjbhGCUd4EgqFwR2tzU3dt6U1O2iA4DW6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gq1tRZ47M9Gho+Gtn74JXHF7c7wj8E8zQt2mQ+bTTxAPlh9RaabpVy66r+gkmTzjsmuK0dCm7cK2SIkiMSK5XCVyyfT8a71wQ7Xo9k9XJcPKiX0U9/NvwZOMFbj7GoL5EKIsouAEq0AL3D9HAWXlATVsWzwux2ZW6RgS09Rmq4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=kabelmail.de; spf=fail smtp.mailfrom=kabelmail.de; arc=none smtp.client-ip=212.71.1.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=kabelmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kabelmail.de
Received: from [192.168.177.65] (94.105.126.5.dyn.edpnet.net [94.105.126.5]) by relay-b03.edpnet.be with ESMTP id VXx4EfUHXbL1PuVC; Mon, 22 Sep 2025 16:32:30 +0200 (CEST)
X-Barracuda-Envelope-From: janpieter.sollie@kabelmail.de
X-Barracuda-Effective-Source-IP: 94.105.126.5.dyn.edpnet.net[94.105.126.5]
X-Barracuda-Apparent-Source-IP: 94.105.126.5
Message-ID: <6ea48bbb-972e-41f7-8c73-5ddffd9d0384@kabelmail.de>
Date: Mon, 22 Sep 2025 16:30:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] increase MDIO i2c poll timeout gradually (including patch)
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
X-ASG-Orig-Subj: Re: [RFC] increase MDIO i2c poll timeout gradually (including patch)
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <971aaa4c-ee1d-4ca1-ba38-d65db776d869@kabelmail.de>
 <cbc4a620-36d3-409b-a248-a2b4add0016a@lunn.ch>
 <f86737b0-a0fe-49a6-aeca-9e51fbdf0f0d@kabelmail.de>
 <aM6Ng7tnEYdWmI1F@shell.armlinux.org.uk>
 <6d444507-1c97-4904-8edb-e8cc1aa4399e@kabelmail.de>
 <aM6xwq6Ns_LGxl4o@shell.armlinux.org.uk>
 <4683e9ea-f795-4dab-8a0a-bd0b0f4fbd99@kabelmail.de>
 <3fab95da-95c8-4cf5-af16-4b576095a1d9@kabelmail.de>
 <aNFDKaIh6RNqLcBM@shell.armlinux.org.uk>
Content-Language: nl
From: Janpieter Sollie <janpieter.sollie@kabelmail.de>
Autocrypt: addr=janpieter.sollie@kabelmail.de; keydata=
 xsBNBFhRXM0BCADnifwYnfbhQtJso1eeT+fjEDJh8OY5rwfvAbOhHyy003MJ82svXPmM/hUS
 C6hZjkE4kR7k2O2r+Ev6abRSlM6s6rJ/ZftmwOA7E8vdSkrFDNqRYL7P18+Iq/jM/t/6lsZv
 O+YcjF/gGmzfOCZ5AByQyLGmh5ZI3vpqJarXskrfi1QiZFeCG4H5WpMInml6NzeTpwFMdJaM
 JCr3BwnCyR+zeev7ROEWyVRcsj8ufW8ZLOrML9Q5QVjH7tkwzoedOc5UMv80uTaA5YaC1GcZ
 57dAna6S1KWy5zx8VaHwXBwbXhDHWvZP318um2BxeTZbl21yXJrUMbYpaoLJzA5ZaoCFABEB
 AAHNMEphbnBpZXRlciBTb2xsaWUgPGphbnBpZXRlci5zb2xsaWVAa2FiZWxtYWlsLmRlPsLA
 jgQTAQgAOAIbIwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBGBBYpsrUd7LDG6rUrFUjEUP
 H5JbBQJoLGc9AAoJELFUjEUPH5Jb9qoIAKzdJWg5FNhGTDNevUvVEgfJLEbcL7tM97FL9qNK
 WV6fwyoXUM4eTabSqcq2JVbqR4pNur2i7OSPvF3a/VRhl2I0qMcFz8/08hVgFG55iBI9Rdwl
 sn3b37KzwdGR7RX5cRt83ST76riKVdEsB/EKeU88/i9utWmT7M8HaqvKw16qhcs2i2hAuM9T
 wNmLt+l65sFMZcgY2+3pne8X1DRj6c9aQ3IBUcKMsB977P2aiss0xQrJ4CqSG3Tgjtzw0c7F
 BuamFq8FIzAtTwRnjxHtqYVUnFLLMu7INfdcQuW2Q2eZHO6+X80QlL+uMDirXB+EbHKZcrU4
 EN13bLOk6OG5ODLOwU0EaCxqtwEQAOfQzQMy61HqB1NL4rWCCI3fG131Da4iyMceOuMntmZx
 9EomthdZRiunLffjMcN7aBcgr4wCh2tNar0hpUkkPpnM/Lat+avTZBkaSmuSF52ukmkVZLEE
 +jPy33hTWkc+k2pJ91XvLVU9axtd33XDBL6bP2oNmG+QF8hfN7QzukWzI52EdzF+DYgt08te
 875abopdtZa/csYO51uqGg5zBjixylZ48pB9o5lWM6h1HSlBoHGBHh3u2ptxyxqTGQYOX+MR
 QEJElLV7ydJSWmm+3cSza3z2BtwyfjKUPzgHXQEBhPQdTalH4cZeJQGi3Zxhy4iQBGpvg1nW
 msd2//x0FRSHkZtzTVaTCTuf0kHhqiQ8a50B6YDJiTC5koH0hp72Fz2SQoFBcDpUFkNzBWng
 Ju9o1LBGd69c7AvOgMYZxDWwvDyb2sUfPJX0V4f+jJUjffO1K+PTrtnq2gpHKjBZHgGUvG4w
 36Juy5BFr7TDDRt5rZGN26Tcs4Nq4EZTjyE6QuJOtA5iyJQo3ZwqQ5d9apyStPBJC1CnBZCo
 kCbRrIbLgqe+mCgXhQngj3QZUZn8qmDB2VHEDmSdkJ4A9qKyiof9uRhmAH287uQ/i342xuUM
 8raS/RGFQaNCV2bBGKqflpS9l1BKGyevk2MUw/IGKJOYfXYc6L5RoPLSlkseBdSpABEBAAHC
 wHwEGAEIACYWIQRgQWKbK1Heywxuq1KxVIxFDx+SWwUCaCxqtwIbDAUJCWYBgAAKCRCxVIxF
 Dx+SW62eB/0SdagAw65x1IEwtEbdo4qxTL/a2iShsMvFOZYt/UE8fDTMkyTJFlDnxHDJqiHR
 0yHpt41+CGxt5z8xhd+4HE+NdQJD2rjvvk5A2C8baOQYv8Mb5I4iDjSuYJWjrAwjCo25oHo7
 CtoMd2jhn3+L1BO8/VY+AjdVXpGqPzor6Q/c5XAfUsgA2/2VEUpXLp8xKr7v/Gn08zUqaT+W
 90QjvK1gwYv7sQ4X0w7kzf3sgQvN64cjo0jVsC3EG1AfdLtc+213+3dzDLqomtWtqoxmnrqx
 oMdve2PL2byHDAtzeWGGM38JB4H6A0VlvUyGqgAnRS/UyOLPpqNYbi1lPemVHZsk
In-Reply-To: <aNFDKaIh6RNqLcBM@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Barracuda-Connect: 94.105.126.5.dyn.edpnet.net[94.105.126.5]
X-Barracuda-Start-Time: 1758551550
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 5716
X-Barracuda-BRTS-Status: 1
Content-Transfer-Encoding: quoted-printable
X-ASG-Debug-ID: 1758551550-24639c1e3080c7e0001-BZBGGp
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=10.0 QUARANTINE_LEVEL=10.0 KILL_LEVEL=7.0 test= 
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.125474
	Rule breakdown below
	  pts rule name              description
	 ---- ---------------------- --------------------------------------------------
	

Op 22/09/2025 om 14:38 schreef Russell King (Oracle):
> On Mon, Sep 22, 2025 at 12:54:20PM +0200, Janpieter Sollie wrote:
>> this is a diff of 10usecs (i=3D10), 40usecs (i=3D4) and 30usecs (i=3D3=
) my device
>> is running the i2c_transfer_rollball().
>> seems a lot to me when an i2c call takes 11-12 usecs avg per call
>> are you sure these numbers point to a stable i2c bus?
> I guess you've never dealt with I2C buses before.
No, but I've read many kernel code dealing with it, desperately trying to=
 figure out the error.
But yes, this is only the software part.
> As has already been
> stated, the clock rate for I2C used with SFP modules (which is, if you
> like, I2C v1) is 100kHz. that's 10us per bit.
>
> An I2C transaction consists of one start bit, 8 bits for the address
> and r/w bit, one bit for the ack, 8 bits for the each byte of data
> and their individual ACK bits, and finally a stop bit. If a restart
> condition is used, the stop and start between the messages can be
> combined into a restart condition, saving one bit.
>
> That works out at 1 + 8 + 1 + N*(8 + 1) + 1 bits, or 11 + 9 * N bits
> or clocks.
>
> The polling consists of two transactions on the bus:
>
> - a write of one byte - giving 20 clock cycles.
> - a read of six bytes - giving 65 clock cycles.
>
> So that's 85 clock cycles, or 84 if using restart. At 10us per cycle,
> that's 840us _minimum_.
and here's my first error:
 > this is a diff of 10usecs (i=3D10), 40usecs (i=3D4) and 30usecs (i=3D3=
) my device is running the=20
i2c_transfer_rollball().
 > seems a lot to me when an i2c call takes 11-12 usecs avg per call
I wrote usecs, but was obviously in a wrong universe, it should have been=
 msecs.=C2=A0 Sorry
>
> If i2c_transfer() for that write and read are taking on the order of
> 12us, that suggest the bus is being clocked at around 7MHz, which is
> certainly way too fast, a bug in the I2C driver, an issue with the
> I2C hardware, or maybe an error in calculating how long a call takes.
Yes, I'm afraid of the last one as well ...
Honestly, even after re-reading it (twice),
I'm still not sure if / when I made an error, so my calculations are belo=
w
>
> And... it's your interpretation of your results.
>
> Remember, these are nanoseconds (ns), nanoseconds are 1000 microseconds
> (us) and there are 1000000 nanoseconds in a millisecond (ms). Sorry
> to teach you to suck eggs, but based on your reply it seems necessary
> to point this out.
you're welcome, It's always useful to get corrected no mather what.
I'm simply trying to find a solution for hardware I built myself,
which is more or less "problem I created myself".
And I _WILL_ make dumb errors. I'm sorry for that.
but hey, at least I'm not crying like a little kid 'please help me to fix=
 my internet' ....
Yes, I know the definition of ns -> us -> ms -> sec,
the commands used (example for i =3D 4 here, a total msleep of 245):

$ echo $(($(sed -n 's/.*\ \([0-9]\+\)\ ns\ in\ iteration\ 4/\1/p' < tempo=
utput.txt | sort -n |=20
head -n 1) - 245000000)) -> for min
$ echo $(($(sed -n 's/.*\ \([0-9]\+\)\ ns\ in\ iteration\ 4/\1/p' < tempo=
utput.txt | sort -n |=20
tail -n 1) - 245000000)) -> for max
$ echo diff at iteration 4: $((123074939 - 82868351)) -> for diff
$ echo $(($(sed -n 's/.*\ \([0-9]\+\)\ ns\ in\ iteration\ 4/\1/p' < tempo=
utput.txt | sort -n |=20
awk '{x+=3D$0}END{print int(x/NR)}' -) - 245000000)) -> for average
avg: 86375811
so that's 86375811ns, 86375us, and 86ms, or ~12ms for each iteration

>
> You quoted an average of 99901858ns - 99.9ms for the i=3D3 case.
> You quoted an average of 86375811ns - 86.4ms for the i=3D4 case.
>
> Given that the difference in msleep() delay is 5ms, and we're
> talking about 50 or 55ms here, for the i=3D3 case that's 45ms
> for i2c_transfer(). For the i=3D4 case, that's 36.4ms.
Ouch ... that's a _LOT_ more than I thought.That explains the difference.=
=C2=A0 Sorry.
>
> However, msleep() is not accurate - and may even be bucket-based so I
> wouldn't rely on the requested msleep() interval being what you end
> up with - which seems to be suggested by the difference of almost 10ms
> in the apparent time that i2c_transfer() takes. 10ms, not 10us. So,
> unless you actually obtain timestamps before and after the
> i2c_transfer() call and calculate their difference, I would not read
> too much into that.
>
> In any case, figures in the realms of milliseconds are certainly in the
> realm of possibility for a 100kHz bus - as I say, one instance of a
> transaction _should_ be no less than 840 microseconds, so if your
> calculations come out less than that, you should not be claiming
> "bad bus" or something like that, but at first revalidating your
> analysis or interpretation of the figures.
>
> Also, because of scheduling delays, and some I2C drivers will sleep
> waiting for the transaction to finish, even that measurement I
> suggest can not be said to relate to the actual time it takes for
> the transactions on the bus, unless you're running a hard-realtime OS.
you are giving a lot of reasons why it's unreliable ...
and I certainly won't dare to calculate useless statistics anymore.
> However, it seems you're very keen to blame the I2C bus hardware...
>
Based on my mails, I can certainly see why you're thinking this way.
I have no idea what goes wrong anywhere between me making a modification =
in the mdio.c file ->=20
i2c code -> ... -> SFP phy.
I'm curious what goes wrong, notice the 3 dots in between,
I know there's a pca9545 muxer in in there further complicating it, but t=
hat's about it.

Long story short: should I somehow try to test the reliability of somethi=
ng else?

Thanks,

Janpieter Sollie

