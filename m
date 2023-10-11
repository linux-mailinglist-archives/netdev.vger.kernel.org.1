Return-Path: <netdev+bounces-40042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF407C58B2
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 17:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C79B41C20DAC
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 15:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE992FE06;
	Wed, 11 Oct 2023 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="UVrZGTUI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DuqgHXuR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D59224E8;
	Wed, 11 Oct 2023 15:58:07 +0000 (UTC)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DFD8F;
	Wed, 11 Oct 2023 08:58:05 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 4DD8C3200945;
	Wed, 11 Oct 2023 11:58:01 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 11 Oct 2023 11:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1697039880; x=1697126280; bh=7H
	Jkg/z8yMK6BHAYpmQDPyFjBK9Xn+ituvuEwAuZ1sU=; b=UVrZGTUIN/c+wOrjog
	V4H1MycpdvOstYDdYmz6kQvmlXMauPc9wG4HupXP9G/ReLiXafAkUjS+sZEbRN0f
	jZYR39UNK2581JykJ0XJeyTsMpe/huU9w18VgyyKp6JwnNi7Tx9B8QhovC0NlI81
	hYf/r/qoMxEMTUwWznAh7j7NCxugCnHq860yJk4U81Uqq0qSgQAFlWeMiCdTsRe4
	WeS1otq5untWkPF34AdO27vX/Y62ovQR1+O6n/lg7bjQYE+pazHxI3k6c6Os0RcD
	MHn1EWGlZMobVxq/d1A7+fB+wdL8DkYfmj6MwSDv1b+SMvxPWxV9DwV4Y3P1NuRV
	P6sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1697039880; x=1697126280; bh=7HJkg/z8yMK6B
	HAYpmQDPyFjBK9Xn+ituvuEwAuZ1sU=; b=DuqgHXuRkjGzv+sTVQXosPn4qx3IG
	pp0FiLiqn0YzKA4Exz530ss62tkJ0JcrBK7OWeQz14oG3MEAAtZGcqzI0V+21941
	xFof5XUuSDb+0m4kwAzSKruypnuL188xCt70zp7dvyoLhT45IbrhJz/q3ySNn4cK
	/An+FzaHKbvg1iE9uK02O9ejiEjUBdoYHEdcXb00bzzjHaIx3foxvoQhSv3a8EIH
	TsguJLzeGl9vRBq1hT+9ugqXZvc6SGrPf8K7TqHwZQ4RO+oaoaS3TIS46KHel7rW
	oyoBMWFuQvAqQd7G1hLQ/j4P1h4zZwATDfcwwJGKZZ0/rDyGwt4dBPDAQ==
X-ME-Sender: <xms:CMYmZV0XE_EsNbv0M22Xjk7OczozGwze6bo3NRK15HHwsRKTwUu2Iw>
    <xme:CMYmZcGc0ENyppHryqZhpcyV0hOOcxjuTXA42bBoLODDCTcQEtXH2PAr1RIuPrqTi
    IB0IEPFtpOKWSCOL60>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheekgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:CMYmZV589CMQPoU21g8abAl3zQiB30Rq5SFLxdDrBC0XlvrFP_5y5A>
    <xmx:CMYmZS3UYGaaj_dDsRqeO5bwzM73qo2MfAiY8fjWT39O9vFI2ikiCA>
    <xmx:CMYmZYGJmnHAdwzedxXPSUko0KfLjLOGgtM7CAl8R2UN-HOCj08sgg>
    <xmx:CMYmZfcEwbKy8YlJQgLXNdgzXoi3YSodyaYkJuapJr-ijNW9VXkIoQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E845BB60089; Wed, 11 Oct 2023 11:57:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <82527b7f-4509-4a59-a9cf-2df47e6e1a7c@app.fastmail.com>
In-Reply-To: <ZSa5bIcISlvW3zo5@nanopsycho>
References: <20231011140225.253106-1-arnd@kernel.org>
 <ZSa5bIcISlvW3zo5@nanopsycho>
Date: Wed, 11 Oct 2023 17:57:38 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jiri Pirko" <jiri@resnulli.us>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Jakub Kicinski" <kuba@kernel.org>, Netdev <netdev@vger.kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, "Johannes Berg" <johannes@sipsolutions.net>,
 linux-wpan@vger.kernel.org,
 "Michael Hennerich" <michael.hennerich@analog.com>,
 "Paolo Abeni" <pabeni@redhat.com>, "Eric Dumazet" <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Rodolfo Zitellini" <rwz@xhero.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] appletalk: make localtalk and ppp support conditional
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023, at 17:04, Jiri Pirko wrote:
> Could you provide a cover letter for the set please?

Subject: [PATCH v2 00/10] remove final .ndo_do_ioctl references

The .ndo_do_ioctl() netdev operation used to be how one communicates
with a network driver from userspace, but since my previous cleanup [1],
it is purely internal to the kernel.

Removing the cops appletalk/localtalk driver made me revisit the
missing pieces from that older series, removing all the unused
implementations in wireless drivers as well as the two kernel-internal
callers in the ieee802154 and appletalk stacks.

One ethernet driver was already merged in the meantime that should
have used .ndo_eth_ioctl instead of .ndo_do_ioctl, so fix that as well.
With the complete removal, any future drivers making this mistake
cause build failures that are easier to spot.

[1] https://lore.kernel.org/netdev/20201106221743.3271965-1-arnd@kernel.org/

----
Hope that helps, I had commented on the cops removal about sending
this but of course not everyone here saw that. Let me know if I should
resend the patches together with the cover letter.

    Arnd

