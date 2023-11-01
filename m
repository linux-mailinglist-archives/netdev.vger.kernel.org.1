Return-Path: <netdev+bounces-45599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D287DE81F
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 23:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 998FD28119E
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 22:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE65C1C294;
	Wed,  1 Nov 2023 22:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="a4yNYvZI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nNgZQUqC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713361C687
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 22:29:44 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CBB135
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 15:29:37 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id DE9B75C0370;
	Wed,  1 Nov 2023 18:29:33 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 01 Nov 2023 18:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1698877773; x=1698964173; bh=VA
	tk4joSxz95XQTbl0nvff9mxXDCg9NALjFyJozqkec=; b=a4yNYvZISKlK3Amda/
	JPyGswNeuBXYtiQeztFVZd74cgPovoeeNT/A8r53zkhcu9w4LkMmzjDF1s+dF2Hy
	Z97YowrY8ZzygjDUtbgZnluWH6p8ceHfm0iZhol3kCq1WlBlAd2NO+6Z9rvg0jZP
	fSmF1hnufv+/sk+raaZubFg00AjJNyvw8UN6DGBkT3PXb0RXJmtHOLLra/GdA0pP
	M4AmjwMFRZbqbME/82dV+cU14uEdBUaGPcpeEUNlUki26pS4/7FlMJa3q3PiNnDX
	0/X30SZCtgT1jJ873ffVXt78dH7hZJ/79j9LKDjiQ7G6seo/fq4lNycNt6HwMhRs
	InAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698877773; x=1698964173; bh=VAtk4joSxz95X
	QTbl0nvff9mxXDCg9NALjFyJozqkec=; b=nNgZQUqCJqcdBgOzSnniO7Mhq1FNG
	CxphAGqGqt6U1rrNjWp5Lj5T9/1OjgFkNWqH5bVpQdUcDPM7b8sv9qQTWAd0Wpo8
	1KQvukPHQG1xneggzdskFKOcY35GTLJw3hvvz4Qt6o7hqFc+xPJryDd/nPGWBNSD
	xjuqWSTDLwex62EUbuxPoFhD4/vm6NfFjyuhzizbsp3Be+T6+FsQ9AyKD9oX+Gi9
	O6aFbScl0m3ga16kbN+27XyfcMYD0Fgw+s4IWumc3eXOI7skKAf2SZZ3XL4p+7al
	uS3eMImxFwB6iGDmEpnN45iwEoC5VVdUERRO56Vri03dCIAbzLakQzTjw==
X-ME-Sender: <xms:TNFCZe8vfyNWLUyZ3RbbX9sM93Clkca5JLnboIFejYORiGymUWwjaA>
    <xme:TNFCZes-ghxlP9Hov1AMdH20WWkLV5Tb9a3u0JEQeh2jfhhSYIp6oKQwOON1jnNJo
    tNKxYShSeqYBPmjSf8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeejvddvvdduleduheejiedtheehiedvjefgleelffeigfevhffhueduhfeg
    feefheenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:TNFCZUBEAOqKMLKHaVhyYyhzB3nuyxAUnsyovh2P2WgaS2XCYK-fKQ>
    <xmx:TNFCZWf7UY-MZhvwbT4zg6W8L8kHxfB1uzebwe7pzBnlhr2bjEQKmw>
    <xmx:TNFCZTNZ_v4dlv8ZhesNHXhQyBsb5zBzEgxe0bmN0luH4vw-UVaYhA>
    <xmx:TdFCZcqG2Wn-rdIAhp1Pcfj6waRQeF6PrhyPLuisLlCKD97i0B0GxA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id BCA86B60089; Wed,  1 Nov 2023 18:29:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d40cd45a-e7e3-49c4-931b-c5ec75a6bf56@app.fastmail.com>
In-Reply-To: <79b7f88e3dd6536fe69c63ed3b4cc1f2c551ce8d.camel@redhat.com>
References: 
 <CAMuHMdWL2TnYmkt2W6=ohBuKmyof8kR3p7ZPzmXmWSGnKj9c3g@mail.gmail.com>
 <594446aaf91b282ff3cbd95953576ffd29f38dab.camel@physik.fu-berlin.de>
 <CAMuHMdWv=A6MiVwUuOp8zOCcf21HxKb8cdrndzdbAZik3VRXiw@mail.gmail.com>
 <5e3e52a48ba9cc0109a98cf4c5371c3f80c4b4cc.camel@physik.fu-berlin.de>
 <79b7f88e3dd6536fe69c63ed3b4cc1f2c551ce8d.camel@redhat.com>
Date: Wed, 01 Nov 2023 23:29:12 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dan Williams" <dcbw@redhat.com>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>,
 "Jakub Kicinski" <kuba@kernel.org>, Netdev <netdev@vger.kernel.org>
Subject: Re: Does anyone use Appletalk?
Content-Type: text/plain

On Wed, Nov 1, 2023, at 21:27, Dan Williams wrote:
> On Wed, 2023-11-01 at 13:26 +0100, John Paul Adrian Glaubitz wrote:
>> Hi Geert,
>> 
>> On Wed, 2023-11-01 at 13:19 +0100, Geert Uytterhoeven wrote:
>> > > Isn't that a bit late?
>> > 
>> > It can always be reverted...
>> 
>> Sure, but I'd rather see such discussions before merging the removal
>> patch. Best would have been to reach out to the netatalk project, for
>> example and ask [1]. They just released version 3.1.18 of the
>> netatalk
>> server in October 2023.

I think you mean netatalk 2.2 for appletalk support, as the 3.x
versions only implement AFP over IP, with no localtalk/appletalk
support.

>> It's an incredibly cool project because it allows you to replace the
>> expensive Apple TimeMachine hardware with a cheap Raspberry Pi ;-).
>
> But... Time Machine debuted with 10.5 and AppleTalk got removed in
> 10.6; did the actual TimeCapsules ever support AppleTalk, or were they
> always TCP/IP-based?
>
> (also TimeMachine-capable Airport Extremes [A1354] are like $15 on
> eBay; that's cheaper than a Raspberry Pi)
>
> This patch only removes the Linux-side ipddp driver (eg MacIP) so if
> Time Capsules never supported AppleTalk, this patch is unrelated to
> TimeMachine.

If we had not removed all localtalk support already, ipddp
might have been used to bridge between a pre-ethernet mac
running macip and an IP based AFP server (netatalk or time machine).
Without localtalk support, that is not all that interesting of
course.

> What this patch *may* break is Linux as a MacIP gateway, allowing
> AppleTalk-only machines to talk TCP/IP to systems. But that's like
> what, the 128/512/Plus and PowerBook Duo/1xx? Everything else had a
> PDS/NuBus slot or onboard Ethernet and could do native
> MacTCP/OpenTransport...

As far as I can tell, https://github.com/jasonking3/macipgw
should work fine as a replacement for ipddp.

     Arnd

