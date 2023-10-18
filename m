Return-Path: <netdev+bounces-42358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3717CE735
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 20:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7485B1C20A05
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 18:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4033B7B7;
	Wed, 18 Oct 2023 18:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skym.fi header.i=@skym.fi header.b="eq2R009k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NOdSoo0I"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B311018E24
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 18:51:02 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF401128
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 11:50:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id AE6605C0145;
	Wed, 18 Oct 2023 14:50:56 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute5.internal (MEProxy); Wed, 18 Oct 2023 14:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skym.fi; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1697655056; x=1697741456; bh=6UXiDK5F4hL02ap4g9syLjADuw9582HbofF
	tHs675Og=; b=eq2R009keRrx9/kf+PI9nBrNvitEoRyTgRHer34JiOX6wyQ2bIl
	xnfkltdy1LYGhBvAwZROxsnZ9yaSEK+JZkBRRmPlotCl9m+gXuXBUu3HC9B0zHWJ
	dYEzQ21w6qAAtCYA60aeSz87dn6mYfLhVhdz4K+ge8YVnyg6R9NOrLg374/4yPPP
	FI0G9jmAkxlUumkASOKSzY/7qM1WbK+U6uQq85Lr2lnjeiZWInF8+uM+t1zZxlSB
	ah3wH3V9MzKDkDhFRtsPdS3YLQ5TH8FzBEMbNSIWgGT9koF+Qcf8Db6ZcxDsN3bf
	QeZJYuiCDPk1XHotwFjes069uArFMnl5Qfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1697655056; x=1697741456; bh=6UXiDK5F4hL02ap4g9syLjADuw9582HbofF
	tHs675Og=; b=NOdSoo0IIfGLT8hyzhaDEAD7yHOPXf5U7onpibZV+6g2e+2lmdU
	WGA/TufbYBO/tGMQchIkNLfZayqEu3s1jVmmSe06tKqLJywE4kAm0gybcG00eWja
	/d9kYsvNIP4/VJVSkIIBsBM5asLQrVyMYyyBT0VlJJ2cLm0jYKBjs73P1Nhbh4Ee
	NKWqaNS/SZH8SukAZ3XXjKTRz0SR+gWxRQd5mdlHiNjtOSnpdBfl+CBIAjxT07ow
	qFqUT/iU9OXiJY9zFN2wHfpRK9sEAwYAIabu139aZepZs07s0d9ESMTZABNcnL78
	OIqciGuQyRWg4GIO9Iz/Mi1QASVLYAUELIA==
X-ME-Sender: <xms:ECkwZZ7RzYHGOJQzWe_ZjTh2H9ZZJIKUh46I8CTptgSTiBijkCljBw>
    <xme:ECkwZW5QlLhlA06mv1KDeTZUsWUjHbd6s46vjGilJO9gdDzNaRa9a1PxG72mK5i4X
    I6tQf0vZ6dIf726mRU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeeggdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepufhk
    hihlvghrucfomohnthihshgrrghrihcuoehsmhdolhhishhtshesshhkhihmrdhfiheqne
    cuggftrfgrthhtvghrnhepueduveevfeeuudeuleevgeehleffgeelteefieekfedulefg
    lefgtedufeduvddvnecuffhomhgrihhnpehvhihoshdrihhopdhkrghpshhirdhfihenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsmhdolhhi
    shhtshesshhkhihmrdhfih
X-ME-Proxy: <xmx:ECkwZQdrMVj3IuR63GIlWY0s3X-gBNfaVlYgQMhCk65yDw49XNQhYQ>
    <xmx:ECkwZSJIivTtBOxZCGjORoax44EPhRSr33UB13vQn93xtijK8iplyQ>
    <xmx:ECkwZdIGS5NZhDU6JrDNZ4hVYK8TC-eAxEQ-f3RdSABNbTv6nP3BRw>
    <xmx:ECkwZfxBKAnkDJFwd9C8-_reUJI64aV0uD1Z6gfZktwl5eIk742wZA>
Feedback-ID: id05146f6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 58D4015A0092; Wed, 18 Oct 2023 14:50:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <03c9e8a4-5adc-4293-a720-fe4342ed723b@app.fastmail.com>
In-Reply-To: <10804893-d035-4ac9-86f0-161257922be7@app.fastmail.com>
References: <ee7f6320-0742-65d4-7411-400d55daebf8@skym.fi>
 <994cebfe-c97a-4e11-8dad-b3c589e9f094@intel.com>
 <c526d946-2779-434b-b8ec-423a48f71e36@skym.fi>
 <6e48c3ba-8d17-41db-ca8d-0a7881d122c9@intel.com>
 <4330a47e-aa31-4248-9d9d-95c54f74cdd9@app.fastmail.com>
 <10804893-d035-4ac9-86f0-161257922be7@app.fastmail.com>
Date: Wed, 18 Oct 2023 21:50:35 +0300
From: =?UTF-8?Q?Skyler_M=C3=A4ntysaari?= <sm+lists@skym.fi>
To: "Jesse Brandeburg" <jesse.brandeburg@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [Intel-wired-lan] The difference between linux kernel driver and FreeBSD's
 with Intel X533
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2023, at 03:39, Skyler M=C3=A4ntysaari wrote:
> On Tue, Oct 10, 2023, at 02:50, Skyler M=C3=A4ntysaari wrote:
>> On Mon, Oct 9, 2023, at 18:33, Jesse Brandeburg wrote:
>>> On 10/4/2023 10:08 AM, Skyler M=C3=A4ntysaari wrote:
>>>>>> Hi there,
>>>>>>
>>>>>> It seems that for reasons unknown to me, my Intel X533 based 10G =
SFP+
>>>>>> doesn't want to work with kernel 6.1.55 in VyOS 1.4 nor Debian 12=
 but
>>>>>> it does in OPNsense which is based on FreeBSD 13.2.
>>>>>>
>>>>>> How would I go about debugging this properly? Both sides see ligh=
t,
>>>>>> but no link unless I'm using FreeBSD.
>>>> https://forum.vyos.io/t/10g-sfp-trouble-with-linking-intel-x553/122=
53/11?u=3Dsamip537
>>>
>>> Hi Skyler,
>>>
>>> Response from Intel team:
>>>
>>> In the ethtool -m output pasted I see TX and RX optical power is fin=
e.
>>> Could you request fault status on both sides? Just want to check if =
link
>>> is down because we are at local-fault or link partner is at local-fa=
ult.
>>>
>>> rmmod ixgbe
>>> modprobe ixgbe
>>> ethtool -S eth0 | grep fault
>>>
>>> Since it is 10G, if our side TX is ON (power level says it is) then =
we
>>> should expect link partner RX to be locked so cannot be at Local Fau=
lt.
>>>
>>> Skyler, please gather that ethtool -S data for us.
>>>
>>> Jesse
>>>
>>>
>>>
>>>=20
>>
>> Hi Jesse,
>>
>> As the other side of the link is an Juniper, I'm not quite sure how I=20
>> would gather the same data from it as it doesn't have ethtool?
>>
>> I have also somewhat given up hope on it working on VyOS and instead =
I=20
>> am using OPNsense for the moment but I still have VyOS installed as=20
>> well.
>>
>> Skyler
>
> Hi Jesse,
>
> I did verify that the grep doesn't yield any results on the VyOS box=20
> and all of the data returned has an value of 0. Paste of which is here=
:=20
> https://p.kapsi.fi/?4a82cedb4f4801ec#DcEgFMFK7cH13EqypsY4ZaHS5taeA1zXe=
vmmTSVW3P9x
>
> I really think something weird is going on with the driver in Linux as=20
> otherwise the same exact config on Juniper wouldn't work there either.=20
> The VyOS box also says that it's unable to modify autoneg settings, or=20
> speed/duplex of the interface.
>
> Skyler

It has been  verified that the driver in kernel version 5.4.255 seems to=
 work aka 1.3 VyOS.  Post from another user in the same thread about it:=
 https://forum.vyos.io/t/10g-sfp-trouble-with-linking-intel-x553/12253/46

I have also verified that the out-of-tree ixgbe driver does work, but in=
-kernel doesn't in kernel 6.1.58.

Please share these findings with the correct Intel team so that this cou=
ld be fixed.

- Skyler

