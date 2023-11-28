Return-Path: <netdev+bounces-51699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054977FBC08
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 14:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27AA71C20AEB
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 13:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C1D59B49;
	Tue, 28 Nov 2023 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skym.fi header.i=@skym.fi header.b="CFDS78jI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KK5J0/OP"
X-Original-To: netdev@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BF4E4
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 05:58:52 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 4FAE33200C33;
	Tue, 28 Nov 2023 08:58:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 28 Nov 2023 08:58:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skym.fi; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1701179928; x=1701266328; bh=+cALrsUIrcx5f7cIxyP2tNPd8MRX8TkMbC9
	rXdAjRsA=; b=CFDS78jIRH/665dSnQZVkOm2Eo6ujC9C7C83FBLLqPkC+qvCwh/
	MzxfJHPk2j4Q5PoxKaMLt/Ugt1WS6KyDNcP8J5Rv59DK1bBZtDbgLTxBuWTfjXyx
	8MH272bcIzuTQqF9UZ4d2UwyTQTLeTtkyjZ0CZ+QduvOa88UB9KUP2dKALlRrwYU
	WRUO0w6Kea27qjIF5G/eDznIvrXLx1/TQGKXKGVgzqom3sLNDhtoyAWXHS24Fv3Y
	zlDyS4+IVTb74AtkcCqrTiAmHP/GWC1KvuaX6xjW12MxuZrjSw4YH1BFSqtXwV23
	3fS/ofcg8G5tOOzFp7IyzilAQuzae+Rbxcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1701179928; x=1701266328; bh=+cALrsUIrcx5f7cIxyP2tNPd8MRX8TkMbC9
	rXdAjRsA=; b=KK5J0/OPzESFDUXzxG1KJpYTgW2+FnD0y3Gxl9ePBH305o/vy/P
	qjnA8fB+bOLDUzUz1A5JBMhS5pKFcDnXWxVwct34RQ4NuZmNwOU6c3LZzjTgS8n3
	4ayk9OuysrsoYdx3I3xzuUNJmFmuLRI4N4wEAScXWADG/RZjxV9s5b0nS9UpBxKj
	Es+R409tUS55ksi2GZymm/wr+snA6LLax+qxv4fB/5deac5iP29HxCN6wU6u0qZQ
	Vs+zAu4aNE78W/NWfr/Y28BAy/PcDUWLYo99NIGe71eTc+u/alIViiEXQZdXfJZJ
	lHACPEOdZi/uo+r/fBUmm9HZ0v0/Oa3M73w==
X-ME-Sender: <xms:GPJlZZrs8EV2Bl_ALZAxyh6epKj7kidVmCgICpaNlOGV3KO_t0Nf2Q>
    <xme:GPJlZbo1FS5dxHXYIlOEWQ0tImW-GaE66cNTsfVFmerJ-zWP1XpZaPrtkN_Ota5Ww
    2IIaKrflRU4dM3znp0>
X-ME-Received: <xmr:GPJlZWNUJXgyi34rx89Huk8dwRxtlCqBbungVwvIWBS3a5INbQnAM3j65SzJFCO0LIaFkTjN1KzIzLrDLm5OLZXjAL1LMu2rLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeifedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhevhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefukhih
    lhgvrhcuofomnhhthihsrggrrhhiuceoshhmodhlihhsthhssehskhihmhdrfhhiqeenuc
    ggtffrrghtthgvrhhnpeffteeuuefhkedvleelteeukefhffekfeduudeukeduieeifeek
    jeegteffteekteenucffohhmrghinhepvhihohhsrdhiohdpkhgrphhsihdrfhhipdhkvg
    hrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehsmhdolhhishhtshesshhkhihmrdhfih
X-ME-Proxy: <xmx:GPJlZU5M3Zu_jR4QGNqzhbebHFRs2JQXFKw6uPYYXOtB0G3cjupgHg>
    <xmx:GPJlZY5V82dUbL3Ndh9iqxbYIwhyUqEVlygeu04d7_xHHDL-UP0qSA>
    <xmx:GPJlZcidR2V3_d2NLiPB9U4-GUisDMdS4HgQGa546BPoVjjMBghWbw>
    <xmx:GPJlZYFG0tSpVMtQ31U0jshJl_59_oMcK1yq5Lvbw5M9U4Qz6iytyQ>
Feedback-ID: i1cc947c0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Nov 2023 08:58:47 -0500 (EST)
Message-ID: <c229a29d-84a9-4390-a138-2034cd3bf572@skym.fi>
Date: Tue, 28 Nov 2023 15:58:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] The difference between linux kernel driver and
 FreeBSD's with Intel X533
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
References: <ee7f6320-0742-65d4-7411-400d55daebf8@skym.fi>
 <994cebfe-c97a-4e11-8dad-b3c589e9f094@intel.com>
 <c526d946-2779-434b-b8ec-423a48f71e36@skym.fi>
 <6e48c3ba-8d17-41db-ca8d-0a7881d122c9@intel.com>
 <4330a47e-aa31-4248-9d9d-95c54f74cdd9@app.fastmail.com>
 <10804893-d035-4ac9-86f0-161257922be7@app.fastmail.com>
 <03c9e8a4-5adc-4293-a720-fe4342ed723b@app.fastmail.com>
 <20231128021958.GA93203@dev-dsk-ipman-2a-ee5dfd20.us-west-2.amazon.com>
Content-Language: en-US
Cc: Jordan Crouse <jorcrous@amazon.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
From: =?UTF-8?Q?Skyler_M=C3=A4ntysaari?= <sm+lists@skym.fi>
In-Reply-To: <20231128021958.GA93203@dev-dsk-ipman-2a-ee5dfd20.us-west-2.amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/28/23 04:20, Ivan Pang wrote:
> On Wed, Oct 18, 2023 at 09:50:35PM +0300, Skyler Mäntysaari wrote:
>> On Tue, Oct 10, 2023, at 03:39, Skyler Mäntysaari wrote:
>>> On Tue, Oct 10, 2023, at 02:50, Skyler Mäntysaari wrote:
>>>> On Mon, Oct 9, 2023, at 18:33, Jesse Brandeburg wrote:
>>>>> On 10/4/2023 10:08 AM, Skyler Mäntysaari wrote:
>>>>>>>> Hi there,
>>>>>>>>
>>>>>>>> It seems that for reasons unknown to me, my Intel X533 based 10G SFP+
>>>>>>>> doesn't want to work with kernel 6.1.55 in VyOS 1.4 nor Debian 12 but
>>>>>>>> it does in OPNsense which is based on FreeBSD 13.2.
>>>>>>>>
>>>>>>>> How would I go about debugging this properly? Both sides see light,
>>>>>>>> but no link unless I'm using FreeBSD.
>>>>>> https://forum.vyos.io/t/10g-sfp-trouble-with-linking-intel-x553/12253/11?u=samip537
>>>>>
>>>>> Hi Skyler,
>>>>>
>>>>> Response from Intel team:
>>>>>
>>>>> In the ethtool -m output pasted I see TX and RX optical power is fine.
>>>>> Could you request fault status on both sides? Just want to check if link
>>>>> is down because we are at local-fault or link partner is at local-fault.
>>>>>
>>>>> rmmod ixgbe
>>>>> modprobe ixgbe
>>>>> ethtool -S eth0 | grep fault
>>>>>
>>>>> Since it is 10G, if our side TX is ON (power level says it is) then we
>>>>> should expect link partner RX to be locked so cannot be at Local Fault.
>>>>>
>>>>> Skyler, please gather that ethtool -S data for us.
>>>>>
>>>>> Jesse
>>>>>
>>>>>
>>>>>
>>>>>
>>>>
>>>> Hi Jesse,
>>>>
>>>> As the other side of the link is an Juniper, I'm not quite sure how I
>>>> would gather the same data from it as it doesn't have ethtool?
>>>>
>>>> I have also somewhat given up hope on it working on VyOS and instead I
>>>> am using OPNsense for the moment but I still have VyOS installed as
>>>> well.
>>>>
>>>> Skyler
>>>
>>> Hi Jesse,
>>>
>>> I did verify that the grep doesn't yield any results on the VyOS box
>>> and all of the data returned has an value of 0. Paste of which is here:
>>> https://p.kapsi.fi/?4a82cedb4f4801ec#DcEgFMFK7cH13EqypsY4ZaHS5taeA1zXevmmTSVW3P9x
>>>
>>> I really think something weird is going on with the driver in Linux as
>>> otherwise the same exact config on Juniper wouldn't work there either.
>>> The VyOS box also says that it's unable to modify autoneg settings, or
>>> speed/duplex of the interface.
>>>
>>> Skyler
>>
>> It has been  verified that the driver in kernel version 5.4.255 seems to work aka 1.3 VyOS.  Post from another user in the same thread about it: https://forum.vyos.io/t/10g-sfp-trouble-with-linking-intel-x553/12253/46
>>
>> I have also verified that the out-of-tree ixgbe driver does work, but in-kernel doesn't in kernel 6.1.58.
>>
>> Please share these findings with the correct Intel team so that this could be fixed.
>>
>> - Skyler
>>
> 
> Hi Skyler, Jesse,
> 
> I came across this very similar issue when upgrading our networking gear
> from kernel 5.15 to 6.1. Our 10G link fails with the in-tree 6.1 ixgbe
> driver but works with the out-of-tree 5.x versions. I found that my link
> issues were related to this commit:
> 
> ixgbe: Manual AN-37 for troublesome link partners for X550 SFI
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.1.63&id=565736048bd5f9888990569993c6b6bfdf6dcb6d
> 
> Specifically, our 10G link works when both sides of the fiber are
> running the in-tree 6.1 ixgbe driver with this autonegotiation change.
> Our link also works when both sides are running the 5.x ixgbe drivers
> without this commit. It fails, however, when only one side has this
> commit. Our current setup compiles the in-tree 6.1 ixgbe driver with
> this commit reverted, for compatibility with our varying hardware.
> 
> I would appreciate it if anyone can cross-check my claim with their
> hardware as well. Also, would anyone be able to help explain what some
> of those registers and reg_val being written are doing?
> 
> -Ivan
> 

Hi Ivan,

It seems that for whatever reason, your reply does not appear on the lists?

- Skyler

