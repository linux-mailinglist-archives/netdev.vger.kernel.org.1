Return-Path: <netdev+bounces-214651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF3DB2AC22
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 17:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA2D189A667
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 15:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0F0246BB8;
	Mon, 18 Aug 2025 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="YYOhEVzm"
X-Original-To: netdev@vger.kernel.org
Received: from crocodile.elm.relay.mailchannels.net (crocodile.elm.relay.mailchannels.net [23.83.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216A222422A;
	Mon, 18 Aug 2025 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.212.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529479; cv=none; b=LcSB+Ny5SCfFolk/4P8zfF2A8j76W6eEdpdZWqP29HHgFW0a3eJOE1BdZae142kqiqzQjCYpM4O3vG9uezL72amrD59rCrcroVKreyvSgxVbJWxF4snvHexsCP0KCfXaxHdv+IvPiWFYu1BjvTug9aa8brSkr9odpafJuu/kMcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529479; c=relaxed/simple;
	bh=b/oFLGReGRGIc7T2lr4JuMUteQW36cH+fP9/f+wDfdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mPtqDicuH/+PWSXkhnzgDXPMpS4MF4hvn9FXcyPg7IZzCkp1IzCQrFUNREbRhgNiquAnzHPsbRu/8COfuOqSl1O8e943Vc4XnzJu1TQYpXk7pRlqjxC91AGAovsiM9pxEvpCRtrkn4OeEXvXI5w8U03Gwib3Z37VzdofHagqGb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=YYOhEVzm; arc=none smtp.client-ip=23.83.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 841B84E58FF;
	Mon, 18 Aug 2025 15:04:30 +0000 (UTC)
Received: from pdx1-sub0-mail-a235.dreamhost.com (trex-blue-7.trex.outbound.svc.cluster.local [100.96.43.79])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 23D394E420D;
	Mon, 18 Aug 2025 15:04:10 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Arch-Illegal: 63c5801721cfaa18_1755529470300_816563999
X-MC-Loop-Signature: 1755529470300:2887004154
X-MC-Ingress-Time: 1755529470300
Received: from pdx1-sub0-mail-a235.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.43.79 (trex/7.1.3);
	Mon, 18 Aug 2025 15:04:30 +0000
Received: from [192.168.88.7] (unknown [209.81.127.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a235.dreamhost.com (Postfix) with ESMTPSA id 4c5GFj08Knzb3;
	Mon, 18 Aug 2025 08:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1755529450;
	bh=HcrziblwsFLluWpHnBKGpQ1YyfcfHYU/BF0Q24g090Y=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=YYOhEVzmuUBJOqMJ3oty2DhjBCsZIND2G0eLaM4ogD3beae/GkglsStC/XwV1ebHj
	 PD7j7ISKzGUb14JCUugk6ZIeA9TZOYg/o/JTbbiieZWp05ALkoUj9p15h41TEl+PXp
	 W+gDQ6ekpSfmldlPkHAOSGKaUupQXbuDyWkziQjJ81Y1/mFBtp8xPxASFbSsGljFG7
	 mNEenVQRQ9nhluL2PHcOJ+texyNaoKJhpzGVE2i/5KYXS6cSouV8dBZqbKXBOm6xcZ
	 LH6d7svmneCAzpyNQMNnu2mWLPQQxG7p+q+xs+RilEu2BWN6iA49ooZpSYwZtBFdEO
	 My39+Lv8fOMdA==
Message-ID: <06a0c642-fb7e-4ccb-9772-232e32b4ead9@landley.net>
Date: Mon, 18 Aug 2025 10:03:17 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: net: Add support for J-Core EMAC
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Artur Rojek <contact@artur-rojek.eu>
Cc: Jeff Dionne <jeff@coresemi.io>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250815194806.1202589-1-contact@artur-rojek.eu>
 <20250815194806.1202589-3-contact@artur-rojek.eu>
 <aa6bdc05-81b0-49a2-9d0d-8302fa66bf35@kernel.org>
 <cab483ef08e15d999f83e0fbabdc4fdf@artur-rojek.eu>
 <CAMuHMdVGv4UHoD0vbe3xrx8Q9thwrtEaKd6X+WaJgJHF_HXSaQ@mail.gmail.com>
 <26699eb1-26e8-4676-a7bc-623a1f770149@kernel.org>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <26699eb1-26e8-4676-a7bc-623a1f770149@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/25 03:07, Krzysztof Kozlowski wrote:
> On 18/08/2025 08:43, Geert Uytterhoeven wrote:
>>>>
>>>> You need SoC-based compatibles. And then also rename the file to match
>>>> it.
>>>
>>> Given how the top-most compatible of the bindings [1] of the board I am
>>> using has "jcore,j2-soc", this driver should probably go with
>>> "jcore,j2-emac".
>>>
>>> But as this is an FPGA design, I don't know how widespread the use is
>>> across other jcore derived SoCs (if any?).
>>> I will wait for Jeff (who's design this is) to clarify on that.
>>>
>>> PS. Too bad we already have other IP cores following the old pattern:
>>>
>>>> $ grep -r "compatible = \"jcore," bindings/ | grep -v "emac"
>>>> bindings/timer/jcore,pit.yaml:        compatible = "jcore,pit";
>>>> bindings/spi/jcore,spi.txt:   compatible = "jcore,spi2";
>>>> bindings/interrupt-controller/jcore,aic.yaml:        compatible =
>>>> "jcore,aic2";
>>
>> I would go with "jcore,emac", as it is already in use.
> 
> git grep jcore,emac
> 
> Gives me zero?

Ethernet support wasn't part of the original kernel submission, in part 
because we hadn't created the turtle board yet (and _still_ don't have a 
consumer retail arm to get them out into the world in less than triple 
digit lot sizes) and the off the shelf FPGA board we were pointing the 
open source community at circa 2016 (Numato Mimas V2) didn't include 
ethernet.

(Also, our internal driver had half an unfinished IEEE-1588 
implementation in it, which we kept meaning to clean out for public 
consumption. We took a different approach to time synchronization but 
had never produced a clean driver for external use until Artur decided 
to do one, which was very nice of him.)

>> If an incompatible version comes up, it should use a different
>> (versioned?) compatible value.
> 
> Versions are allowed if they follow some documented and known vendor SoC
> versioning scheme. Is this the case here?

This ethernet implementation hasn't significantly changed in 10 years.

Whenever we've needed something else we've done different I/O devices 
that weren't ethernet. (Even the USB 2.0 "ethernet" isn't technically 
ethernet, it made our board act as a USB dongle that showed up as an 
ethernet device to the computer it was plugged into so we could exchange 
data. No actual ethernetting really occurred, it's kind a like calling 
slip/ppp or virtio-net an ethernet interface.)

In theory gigabit phy would be a successor to this, A) no idea if they 
would share any code on the VHDL _or_ C side, B) that kind of phy 
requires 125mhz clock speed which is less cost effective in FPGA, 
especially now that AMD bought xilinx and doubled the prices. (We've 
stuck with LPDDR2 for similar reasons, although that's on the shorter 
term todo list to support. I mean yeah we _could_ use various FPGAs' 
builtin DDR3 library but we don't because we only want to use stuff we 
can implement ourselves in ASIC, and we need to not just test the state 
machine (minimum jedec clock speed 300mhz: kintex or vertex territory) 
but also commission the analog part of the circuit which is 
process-specific so you have to pick a fab to have them drawn for if 
you're avoiding NDAs and per-chip royalties for other people's black box 
libraries.

(Oh, and the higher up the FPGA stack you go the less likely yosys' open 
source FPGA tools are to work right, and the more NDA-clingy the closed 
source tools get, which is kind of annoying for a mostly non-US 
development team. (Lots of testing for $50 FPGAs, far less for $700 
FPGAs plus the more lawsuit-happy the vendors get about their crown 
jewels.) Gowin is trying but those suckers SUCK DOWN power, the ones 
I've seen are Lattice clones not Xilinx clones (ecp5 exists if we want 
_bigger_ lattice, the question is _faster_), and going that direction is 
really just a different kind of ecosystem lock-in...)

tl;dr: the 100baseT engine works fine for its niche, we've had no reason 
to fiddle with it.

> This is some sort of SoC, right? So it should have actual SoC name?

https://github.com/j-core/jcore-soc

Internally we have branches for various projects, which are named after 
the project not the base platform. It's "j2" because it's the dual 
processor version. J1 is what we use on ICE-40:

https://github.com/j-core/jcore-j1-ghdl

They're _mostly_ the same but the j2 SOC build has a whole automatic bus 
generator thing that pulls in dependencies (it's written in cloture and 
java) and the broken out j1 builds with just the 01 and 02 stages of the 
https://github.com/j-core/openlane-vhdl-build open source 
toolflow/toolchain. (There's a todo item to reorganize the repositories 
so j1 becomes a git submodule of j2 which would naturally keep them in 
sync, but it was all originally done in mercurial and needs a bit more 
massaging. Plus recently we've done a j1 fork removing the hardware 
multiplier and did a software multiplier toolchain, which hasn't made it 
over to the J2 side yet because it really needs a better configure 
mechanism (VHDL generics sure but what _selects_ them...) which REALLY 
says we need to rewrite the makefiles entirely... it's on the todo list.)

Rob

P.S. We haven't been pushing to github much since Microsoft bought it. 
I'm trying to convince Jeff to look at codeberg but he's hung up on the 
gitea->forgejo fork...

