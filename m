Return-Path: <netdev+bounces-14253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5001273FC3A
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 14:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA59E281061
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 12:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A7A17FE6;
	Tue, 27 Jun 2023 12:54:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A82111E
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 12:54:48 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5A92944;
	Tue, 27 Jun 2023 05:54:44 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 431B65C01D0;
	Tue, 27 Jun 2023 08:54:41 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 27 Jun 2023 08:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1687870481; x=1687956881; bh=Il
	Bb3apajPhN/l8gLah0GaLHQYTfmUxtdLJ9RjV0BfI=; b=WkeCwVfZDHVMO+MpRb
	KzlnGYLTGdhc1hJmjiKDRwOnBqY2z57Fr1SxMUgz4dZHSy1xQpRRl6qC2xd/7wFH
	8tAqeoMAxB4pLt4DXMtRlHf4mhSBuvFc1IMYjq2qxlugPMOcAfrLM/Kfo77GF06n
	DAfYNxEHCyvF4d6MEyBBzeyTWxr4Koc5ThhTwfuUR+lFPBC8AfIIHqh2XMlk6uid
	5CgOD2s7t1mrb0n1+GpBKyBSRiTX2TXVTmFSbYbaXPbFmJVEwmrsxsKL+OSW62rj
	kZ7/e/XUkQ8H76giweWQ5DoaVBoyanNntQj/mTH5WIjFnrKqyZjvHeeARDjeQm5e
	lsGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1687870481; x=1687956881; bh=IlBb3apajPhN/
	l8gLah0GaLHQYTfmUxtdLJ9RjV0BfI=; b=f7sKexIVSPqInL2fcESgFKBXUNLbZ
	fbD34+KA5c4+wcPw8jTCxQhd3oOgXYGQM9NbadInyZl4pOYmoIzMDPjbBeszcQPu
	SxZeU3FhAEzQ/5rrt8YXLxgqFf2ftb6DdXqpNqrQpBUT/+a+s8eJ2gykl+fp2tM/
	WMIdDriRJHdUe/jw0NqutnuGELpUs86lWRarkWgZQ/FFV2d+X8HOfj0fhSe+Vomr
	hWsXsrkRF2tGouQpiOG691IgreX8jr6PUjwdd1TNeqO3lO/DwyLrHN5SXxujXJPN
	2YhcEV0QSzN09zkyvcCC0pvnYxJkRenFSkU1ZtPK01QRJlJBEmmyT7qjA==
X-ME-Sender: <xms:ENyaZKlStiUDI71v2z9eXPoBbJj_fXA2caEiaeEy4HkhkgGl9ZSLjQ>
    <xme:ENyaZB0kp-ZdUWg9T17Ui9KVmvNL7hWsmyw-NMJRlePGPvq6Jq3aIVTOBlTolSeGr
    xF2cBHVNQxkxlfWuS8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtddtgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:ENyaZIrGuMf4xHJ5grbl2j-xIZbft02DGFwUPv2zKTFPG7PZBEGAVQ>
    <xmx:ENyaZOnwJwSma7IIF8Tht0fh9-D_9xWKeu3re7VUnCPgi41mKRFyKA>
    <xmx:ENyaZI2tgggHmEUBUc0-IMGjg9S2uDm79jIRukj0auBxhRjii2n1VQ>
    <xmx:EdyaZCM3E-tfO0_X23ZOyyNU-xH-9ocLC9K38h6hwDCGHss4_cYZMw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7B94FB60086; Tue, 27 Jun 2023 08:54:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <de4fe7d1-a0ae-40eb-a9d4-434802083e70@app.fastmail.com>
In-Reply-To: <43a1f34a6b1c5a14519f3967dff5eb42e82ee88d.camel@linux.ibm.com>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
 <7b5c40f3-d25b-4082-807d-4d75dc38886d@app.fastmail.com>
 <43a1f34a6b1c5a14519f3967dff5eb42e82ee88d.camel@linux.ibm.com>
Date: Tue, 27 Jun 2023 14:53:59 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Richard Cochran" <richardcochran@gmail.com>,
 "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 "Mauro Carvalho Chehab" <mchehab@kernel.org>,
 "Alan Stern" <stern@rowland.harvard.edu>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-pci@vger.kernel.org, Netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH v5 00/44] treewide: Remove I/O port accessors for HAS_IOPORT=n
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 27, 2023, at 11:12, Niklas Schnelle wrote:
> On Mon, 2023-05-22 at 13:29 +0200, Arnd Bergmann wrote:
>> 
>> Maybe let's give it another week to have more maintainers pick
>> up stuff from v5, and then send out a v6 as separate submissions.
>> 
>>     Arnd
>
> Hi Arnd and All,
>
> I'm sorry there hasn't been an updated in a long time and we're missing
> v6.5. I've been quite busy with other work and life. Speaking of, I
> will be mostly out for around a month starting some time mid to end
> July as, if all goes well, I'm expecting to become a dad. That said, I
> haven't forgotten about this and your overall plan of sending per-
> subsystem patches sounds good, just haven't had the time to also
> incorporate the feedback.

Ok, thanks for letting us know. I just checked to see that about half
of your series has already made it into linux-next and is likely to
be part of v6.5 or already in v6.4.

Maybe you can start out by taking a pass at just resending the ones
that don't need any changes and can just get picked up after -rc1,
and then I'll try to have a look at whatever remains after that.

    Arnd

