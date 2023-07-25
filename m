Return-Path: <netdev+bounces-21036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECF176239A
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 22:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29669281AC0
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 20:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C009425939;
	Tue, 25 Jul 2023 20:37:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A3A24181
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 20:37:58 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735FC1BE4;
	Tue, 25 Jul 2023 13:37:30 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id ACF5F5C00F2;
	Tue, 25 Jul 2023 16:37:28 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 25 Jul 2023 16:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1690317448; x=1690403848; bh=tU
	enbxuC5I1n+MGN9iC/9qo7/L6cRKUPK2gsdMgfmGw=; b=fUEfQhmeApsH9S+6d8
	dYCpcvq8XcHWxwayJ0kqkX98H0Zrh192T3eC1AgofzGoeyFYLIMTQjjomWFFGH8d
	WEFHRz2Qsk5f0pNrllJbEFWYMPAd1xVxoIMz6iw/+6RaB8HVb6eoA9F3CPl6Hc8u
	MFDnIqBKICtznrqd34WKsUWbjprS//1HrCc8ZbXd1ZF4hdL3A/cnWy4/Ais+JJFr
	Tf3B24U/KIg2nlnsfMEEvbDCPkeyQUb3AbwfKqHneedUCtVPEiq9F6YIn+l7qSV/
	clqj/uyg0VymFXIiX1Cg/fO7KXvWC3i5+JiyxzNpFuA2kD+ypP3YtdUUdU86BPHD
	3zvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1690317448; x=1690403848; bh=tUenbxuC5I1n+
	MGN9iC/9qo7/L6cRKUPK2gsdMgfmGw=; b=Yj2eA52T+f6RmDpoylZMRUKC49eAT
	qp57mr5n4hyjAGu0NHElHMvyEaBmedsdszebCSN47BuQST3DhJEilKciT9g6P0DO
	RKjyS9awY8sWwUJmcWI2XRF6M6MziA8k4mwsXa7Kgnr/nouxJCEiYSZWaK2bBeI7
	Om082OLg70b/GiTeMLWs3yfM2MESjyL1U6LhXZDla8EHPdnQiA8mFeURA6fsKXfK
	/GuIlO76msupya8Ql3+j4uj0dajz8DBRsnkNV4Gg2XSthYNiVVZsTP1VIb0OzdVZ
	KnoPX4ZFCaxhRc1EH/JF4mZKfDFnrK4Nlc+kyX0amloNqvPdZjTibdXSQ==
X-ME-Sender: <xms:iDLAZM9jlh-_2HEHcbS4mRTbbmV7kPLQxQDq-CruLOgM8MKATkkjSA>
    <xme:iDLAZEuVfl1FcwsNTCbApVhVife_-LDQbJiyZKJAFHOQ6_xZV7oD8F22Vfc9gDAZx
    UzMfjQ6jvO0A9q5hZc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedtgddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:iDLAZCBLiytdthl5PM9WNDsivrcXlpjNPhcnuKl1Kn_SZA94j8AL8A>
    <xmx:iDLAZMcoMfYrbCPhi9ppQARGQgtIYe9lT4XfX-aW2Xiu-SD0nyXeWQ>
    <xmx:iDLAZBPrSGNq_sXGdp7Kv5wmgrlulBO_ptFX0OiFL0yICBK-8DZavw>
    <xmx:iDLAZHvJ7u8686wpz0zedDpJYSTV8ckcM4jXj811Vp71k33Lu9OlCg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id F280AB60089; Tue, 25 Jul 2023 16:37:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <990b6871-169b-4d03-b202-f19294730f8c@app.fastmail.com>
In-Reply-To: <ZMAqPdO2XcIXOCFs@corigine.com>
References: <20230725064403.581634-1-arnd@kernel.org>
 <ZMAqPdO2XcIXOCFs@corigine.com>
Date: Tue, 25 Jul 2023 22:37:07 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Simon Horman" <simon.horman@corigine.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Ioana Ciornei" <ioana.ciornei@nxp.com>,
 "Russell King" <linux@armlinux.org.uk>,
 "Robert-Ionut Alexa" <robert-ionut.alexa@nxp.com>,
 "Russell King" <rmk+kernel@armlinux.org.uk>,
 "Vladimir Oltean" <vladimir.oltean@nxp.com>,
 "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
 "Sean Anderson" <sean.anderson@seco.com>,
 "Josua Mayer" <josua@solid-run.com>, Netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dpaa: avoid linking objects into multiple modules
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023, at 22:02, Simon Horman wrote:
> On Tue, Jul 25, 2023 at 08:43:40AM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> Each object file contains information about which module it gets linked
>> into, so linking the same file into multiple modules now causes a warning:
>> 
>> scripts/Makefile.build:254: drivers/net/ethernet/freescale/dpaa2/Makefile: dpaa2-mac.o is added to multiple modules: fsl-dpaa2-eth fsl-dpaa2-switch
>> scripts/Makefile.build:254: drivers/net/ethernet/freescale/dpaa2/Makefile: dpmac.o is added to multiple modules: fsl-dpaa2-eth fsl-dpaa2-switch
>> 
>> Chang the way that dpaa2 is built by moving the two common files into a
>> separate module with exported symbols instead.
>> 
>> To avoid a link failure when the switch driver is built-in, but the dpio driver
>> is a loadable module, add the same dependency in there that exists for
>> the ethernet driver.
>> 
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Hi Arnd,
>
> overall this looks good to me.
> One thing that I noticed, and I'm not sure if we care,
> is that an x86_64 allmodconfig now reports:
>
> WARNING: modpost: missing MODULE_DESCRIPTION() in 
> drivers/net/ethernet/freescale/dpaa2/fsl-dpaa2-common.o

My mistake, I had disabled the warning in modpost.c as it was
generating too much output while I tried to address some
other warnings, so I missed the regression I introduced.

I'll send a v2, adding

MODULE_DESCRIPTION("DPAA2 Ethernet core library");

      Arnd

