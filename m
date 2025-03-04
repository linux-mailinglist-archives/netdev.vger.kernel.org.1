Return-Path: <netdev+bounces-171652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5153DA4E089
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 15:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769343A28E4
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 14:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F47204F6A;
	Tue,  4 Mar 2025 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="CL3RYKQE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0FuZhWqK"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D311C54AA;
	Tue,  4 Mar 2025 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097582; cv=none; b=Y/13BLqd1j/iBjHHxN6gf3oq3e/uD1KUfrPTVsrjpMrqsF+G1wf608hJFR/LY9HEvIZ4iH24MeJLNU6hxKupiE2lcQi/VkRT1N3HXeDbTypELT/pPpGBA8jQ4cGuuINkN6LzzgZxaZWyb4rh1wUJBjlQAskT4WJ+7jjNcBh8W5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097582; c=relaxed/simple;
	bh=lHqKosFyPgPaypbiEvaH9iehas6L5xniiZhzlH4VqRc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lnleMbg+bqOZ4gLiIuOoT23cifldVoblwvq+nGS12BIrrgfl6cImtUpuE6dgLe3EuPXCwJ+IwuPjlXmDN182TWI2POmSTC6LOgx4td02XOtE9AiPIud40YsczsReAYJyUaXJhN4ZDw1WdOZJD0dyu+3RB6ipSTR/2kVuQGWgmnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=CL3RYKQE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0FuZhWqK; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 6680B114017B;
	Tue,  4 Mar 2025 09:12:58 -0500 (EST)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-06.internal (MEProxy); Tue, 04 Mar 2025 09:12:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1741097578;
	 x=1741183978; bh=CupnNxId9lKKUCsY814yni/CdDwtjCpeVVEN0FS8OQE=; b=
	CL3RYKQEmfOJrGOXMBV3R9j+P3ioLr87qr7lUXLZTyNvAHRwc33K7+6ahrCIL2LE
	XoABVvS6JeH8Ctr/pc5LAAXGNwstmo5XmR/K8Mj4OyPLIyYJySUiyjhtTBavdYy0
	28oV6fom29lMTeOdxUPkHruTjNgl0AOt1aL60Mk9q4wrjJ0qau6XJpDeHFlJGtPl
	qUQwUSwiQ+4vEZpXDOAFld1CEFoIaprsI3bOV1wScB0dv/lmGsfzfZQ5KzSt6dcm
	yzc2pU7POtqkd9nQ3f17UnkE2d3Pt1WhcnHlwXUE9Ll5dkaqS48X9y8EWJ0l/JqZ
	UJpZKxUX/rl90a0fPA6h3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741097578; x=
	1741183978; bh=CupnNxId9lKKUCsY814yni/CdDwtjCpeVVEN0FS8OQE=; b=0
	FuZhWqKhRCRvbRmX4SkW7iPko1sDKS9tiRdGJ2yVrHK38hY/+4jkF7nJYz+saodG
	m58pBtWiL3YA9yETb9enM84yHSjEE4hZMo9D7F0wLXJqy0/92HnCTFambvFcf/l6
	6r3+v5b1O4CByJYQWp0qE/wbe74af9/RZsjqxP9DZCjusDCranllj1jUweyI4UuW
	3n9V7J9B2HApzckJR/QQGdNylq76SipnxCZzNv8DtD+qJWHHVeWMGFMgNbkjdPo4
	7xSrsUlvc+BFh+bMcSVTXcygxrjQmkMgAK5ZVyURLsuk1ss5NhlK4/gZniusqKk1
	xCy2CvrvJZCJiGlgXer/w==
X-ME-Sender: <xms:aQrHZ9a6uOGVj1bQ10YHC3p4ZmtSbX2_QgUFjtTSn0S6E-_QN0JF2w>
    <xme:aQrHZ0btwSwdMg6xVeG2eRPZxYkCJp3VnUOwYY2DR0CHUsFbMnmAtjePaHgzxwYsV
    8DqNAn-FdP6U0slB9M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddvvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedfofgrrhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlh
    gvnhhovhhosehsqhhuvggssgdrtggrqeenucggtffrrghtthgvrhhnpeegheduieffieek
    vdduhfejjeefhfehfeeuhfekuefhffdvjeffuedufeetfeegtdenucffohhmrghinhepih
    hnthgvlhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhnsggprh
    gtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvmhes
    uggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglh
    gvrdgtohhmpdhrtghpthhtoheprghnthhhohhnhidrlhdrnhhguhihvghnsehinhhtvghl
    rdgtohhmpdhrtghpthhtohepphhriigvmhihshhlrgifrdhkihhtshiivghlsehinhhtvg
    hlrdgtohhmpdhrtghpthhtohepvhhithgrlhihrdhlihhfshhhihhtshesihhnthgvlhdr
    tghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepih
    hnthgvlhdqfihirhgvugdqlhgrnheslhhishhtshdrohhsuhhoshhlrdhorhhgpdhrtghp
    thhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegrnh
    gurhgvfieslhhunhhnrdgthh
X-ME-Proxy: <xmx:aQrHZ_9Cp7HpzoSLKsB-ydwOhXfwIkqbG6RD4NAW-xocOSYJHkNTwQ>
    <xmx:aQrHZ7oMYBSVVK0UUNr5N8mnmgW7Ix1lmV5NoLDJkF9jgBlVbqD9KA>
    <xmx:aQrHZ4pLEDztSxRFVK_xijgyeRTa6M21ujEJw69S2fVMafB9tsbIxg>
    <xmx:aQrHZxTC7Ab1Xsf0M2uwbu8G-q_yRk_jwrHd8FtByNzE_Uv-NCA0CA>
    <xmx:agrHZ-hCUbyZQjPGRQJOKDKdmHbdxT6v-6fY0FTdrMR_Qmvh1HVGN1rK>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8F1673C0066; Tue,  4 Mar 2025 09:12:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 04 Mar 2025 09:12:37 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Vitaly Lifshits" <vitaly.lifshits@intel.com>,
 "Andrew Lunn" <andrew@lunn.ch>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <a2bd6964-1ec0-4bd6-ad68-7210ac3fe38b@app.fastmail.com>
In-Reply-To: <316a020a-aa49-700e-3735-f5f810adaaed@intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20250226194422.1030419-1-mpearson-lenovo@squebb.ca>
 <36ae9886-8696-4f8a-a1e4-b93a9bd47b2f@lunn.ch>
 <50d86329-98b1-4579-9cf1-d974cf7a748d@app.fastmail.com>
 <1a4ed373-9d27-4f4b-9e75-9434b4f5cad9@lunn.ch>
 <9f460418-99c6-49f9-ac2c-7a957f781e17@app.fastmail.com>
 <4b5b0f52-7ed8-7eef-2467-fa59ca5de937@intel.com>
 <698700ab-fd36-4a09-8457-a356d92f00ea@lunn.ch>
 <24740a7d-cc50-44af-99e2-21cb838e17e5@app.fastmail.com>
 <316a020a-aa49-700e-3735-f5f810adaaed@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: Link flap workaround option for false
 IRP events
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Thanks Vitaly,

On Tue, Mar 4, 2025, at 5:48 AM, Lifshits, Vitaly wrote:
> On 3/3/2025 5:34 AM, Mark Pearson wrote:
>> Hi Andrew,
>> 
>> On Sun, Mar 2, 2025, at 11:13 AM, Andrew Lunn wrote:
>>> On Sun, Mar 02, 2025 at 03:09:35PM +0200, Lifshits, Vitaly wrote:
>>>>
>>>>
>>>> Hi Mark,
>>>>
>>>>> Hi Andrew
>>>>>
>>>>> On Thu, Feb 27, 2025, at 11:07 AM, Andrew Lunn wrote:
>>>>>>>>> +			e1e_rphy(hw, PHY_REG(772, 26), &phy_data);
>>>>>>>>
>>>>>>>> Please add some #define for these magic numbers, so we have some idea
>>>>>>>> what PHY register you are actually reading. That in itself might help
>>>>>>>> explain how the workaround actually works.
>>>>>>>>
>>>>>>>
>>>>>>> I don't know what this register does I'm afraid - that's Intel knowledge and has not been shared.
>>>>>>
>>>>>> What PHY is it? Often it is just a COTS PHY, and the datasheet might
>>>>>> be available.
>>>>>>
>>>>>> Given your setup description, pause seems like the obvious thing to
>>>>>> check. When trying to debug this, did you look at pause settings?
>>>>>> Knowing what this register is might also point towards pause, or
>>>>>> something totally different.
>>>>>>
>>>>>> 	Andrew
>>>>>
>>>>> For the PHY - do you know a way of determining this easily? I can reach out to the platform team but that will take some time. I'm not seeing anything in the kernel logs, but if there's a recommended way of confirming that would be appreciated.
>>>>
>>>> The PHY is I219 PHY.
>>>> The datasheet is indeed accessible to the public:
>>>> https://cdrdv2-public.intel.com/612523/ethernet-connection-i219-datasheet.pdf
>>>
>>> Thanks for the link.
>>>
>>> So it is reading page 772, register 26. Page 772 is all about LPI. So
>>> we can have a #define for that. Register 26 is Memories Power. So we
>>> can also have an #define for that.
>> 
>> Yep - I'll look to add this.
>> 
>>>
>>> However, that does not really help explain how this helps prevent an
>>> interrupt. I assume playing with EEE settings was also played
>>> with. Not that is register appears to have anything to do with EEE!
>>>
>> I don't think we did tried those - it was never suggested that I can recall (the original debug started 6 months+ ago). I don't know fully what testing Intel did in their lab once the issue was reproduced there.
>> 
>> If you have any particular recommendations we can try that - with a note that we have to run a soak for ~1 week to have confidence if a change made a difference (the issue can reproduce between 1 to 2 days).
>
> Personally I doubt that it is related to EEE since there was no real 
> link flap.
>
> I suggest to try replacing the register read for a short delay or 
> reading the PHY STATUS register instead.
>

Ack - we'll try that, and collect some other debug registers in the process.
Will update with findings - this may take a while :)

Thanks
Mark

