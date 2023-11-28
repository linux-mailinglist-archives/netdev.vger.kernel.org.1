Return-Path: <netdev+bounces-51701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1567FBC12
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8221C20E6E
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 14:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304F059B78;
	Tue, 28 Nov 2023 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skym.fi header.i=@skym.fi header.b="hkKHtTYA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m9q8YAtC"
X-Original-To: netdev@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8418210E7
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 06:01:17 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 7D5E33200AB9;
	Tue, 28 Nov 2023 09:01:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 28 Nov 2023 09:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skym.fi; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1701180075; x=1701266475; bh=6vF59PxESXUjV9xUIONgSBrgXrMurptqSOj
	leVxnrMY=; b=hkKHtTYAkE6b70DBAEnPDw4L3VDRuhOeTHqIZAFH+Yu4F4YqvRi
	bjNq1PKCeA4KHG6e9jnPcfs8ytnzacucgbzzFBwUVmU5bVWP5LytLwcYIF/zbpEf
	tWh8zcOgk13FkngVBaV6ofp9qv06ytEf8mswITl64V/k8oQX5cqGD7u1F5Y2wFk4
	HB8EBdzsm3lZvChgYkDFAGS6G4ZComIMGFkQS++/Zrk1gooWMFDy8ExYOY9L8c2H
	PxXlV9hIUM6L1EEBrnZQ6q9jwEVSD/VrUkdXziYNYKBf+YMFxxLWOnu1lLp+ZZYJ
	VCcvJ/022tbYS58SE9+f/NYCYyg/9IZF9kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1701180075; x=1701266475; bh=6vF59PxESXUjV9xUIONgSBrgXrMurptqSOj
	leVxnrMY=; b=m9q8YAtC+TxldhVKClaxWliv+9Bk4uENSnP4ZsDK5GBFra+myTv
	+Rh/3e8uEB9dWkdaaFjq1vK1ScmcoQSBTXQrZl8+2YpxGTRfGyPXhMw0/2e5wyvb
	YIhnQjPiRqpEffYTh8PXJn5TSJ9ATSKt8zcs0I3L+dgps48A1zM8v621GFUSeZpO
	adE33L8/r8cBHW7UDOWaiS10FT2raIDWek5KIyhSpByqSV7csb3N+e8YyFIvvroR
	R4oe/MWfyc9K/3c+dM7Fx7aokV8wnfPx38t3L7qWeWv08/dJOQbpkQ5+CUOQVdM0
	jjZWAgf8W1z4h69y8lFaX2efKkhgkMPV75g==
X-ME-Sender: <xms:q_JlZYZlv8QrFaUYQagZ_FVtRvh81CeIXmbffTMzyxPfXd3x4bR8LA>
    <xme:q_JlZTa6Ms5K2LbXbBWp9xDZnBBc7eOgduPPmdBhgc3oK2yvj7ThwlpW2p0fRMDi-
    HFURjJkP_2AnOmtHp4>
X-ME-Received: <xmr:q_JlZS8lDtS0kGA0hRlslY3AptISKzYOP4W8WIGgujvBo7R9mFFVQ30zI1mW_mV_KMiIFUDvGByBm5pBkDfS3lrdKdSum4rlww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeifedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhevhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefukhih
    lhgvrhcuofomnhhthihsrggrrhhiuceoshhmodhlihhsthhssehskhihmhdrfhhiqeenuc
    ggtffrrghtthgvrhhnpeffteeuuefhkedvleelteeukefhffekfeduudeukeduieeifeek
    jeegteffteekteenucffohhmrghinhepvhihohhsrdhiohdpkhgrphhsihdrfhhipdhkvg
    hrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehsmhdolhhishhtshesshhkhihmrdhfih
X-ME-Proxy: <xmx:q_JlZSp7pU2OxKS67T8XEOxj9LIU1cmacFOHeH3eLuV4s8Y4H3Cv6A>
    <xmx:q_JlZTrxGO_vxyASe36kiEBE0QrZ28DMEIaV3CBIO49Hqgwm1O-qLA>
    <xmx:q_JlZQRut2SkUQfPtAFTeZ_iq0kQM72ZajsM0eMvrOSsyiaMJjGUKw>
    <xmx:q_JlZSUQNjGYhOy9tlgvmJdLy_NegXVHsmUwoH6UalFvLGr2I7hw_Q>
Feedback-ID: i1cc947c0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Nov 2023 09:01:14 -0500 (EST)
Message-ID: <de20185e-26ee-40ec-bce0-7f94fa52f8e8@skym.fi>
Date: Tue, 28 Nov 2023 16:01:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] The difference between linux kernel driver and
 FreeBSD's with Intel X533
Content-Language: en-US
To: Ivan Pang <ipman@amazon.com>
References: <ee7f6320-0742-65d4-7411-400d55daebf8@skym.fi>
 <994cebfe-c97a-4e11-8dad-b3c589e9f094@intel.com>
 <c526d946-2779-434b-b8ec-423a48f71e36@skym.fi>
 <6e48c3ba-8d17-41db-ca8d-0a7881d122c9@intel.com>
 <4330a47e-aa31-4248-9d9d-95c54f74cdd9@app.fastmail.com>
 <10804893-d035-4ac9-86f0-161257922be7@app.fastmail.com>
 <03c9e8a4-5adc-4293-a720-fe4342ed723b@app.fastmail.com>
 <20231128021958.GA93203@dev-dsk-ipman-2a-ee5dfd20.us-west-2.amazon.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Jordan Crouse <jorcrous@amazon.com>, netdev@vger.kernel.org,
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

P.S Sorry for the double posting if you see this twice. It wasn't sent 
to Ivan correctly the first try.

- Skyler


