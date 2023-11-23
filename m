Return-Path: <netdev+bounces-50457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BB87F5DD7
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 12:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B66A281B0C
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 11:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9E222F1A;
	Thu, 23 Nov 2023 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w4GYCxXP"
X-Original-To: netdev@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF549A3
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 03:29:33 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id AB0015C01E7;
	Thu, 23 Nov 2023 06:29:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 23 Nov 2023 06:29:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1700738971; x=1700825371; bh=EMpX7yRuyhVb9
	Zpf17+RPJo++lxUYLk9pMh30y3VZdA=; b=w4GYCxXP24rU4nwDwX0CWopM2vXhr
	zsaGedPoH0PhVBEDFE8RiUtpCdE75NfgRz0t2kU9H+orlJ5NBAM0QFgYwYRBI9kZ
	DNsU+k6L/SD1CZkD/I9YGJ1eub0sgam/H0h1V6aL9X/e90ameqJASmkvvPayJD2V
	7wslU3k8sFf8fYq1YESJQjFpJXpdtUQ26yU3E4KJk5k9ZOgKDSY2Vl/41Or3fNew
	WqKeabedTYAIZVl9X+A5rq+oQhYx9QVwh8+/jT2S6Q7eY+FDJoaQKfUEB1UhOPkz
	WWf1NJJAdEAwJPeRhJwwsN2hznIt+hfXj3YOx2V7mIn04nCUypAf9r+RQ==
X-ME-Sender: <xms:mzdfZTXUCb3JSL5WGUZ4NJD9YtsN8p7CAajP0VtUbfH8IS1lx2BeHA>
    <xme:mzdfZbkUqTA0Y06AhGw8p9qES7n4PXkLDuyM9JkpDEAdDkbJbV1FQjZCxV4-RZlQZ
    x-sBGoAyJ6QpJM>
X-ME-Received: <xmr:mzdfZfZgiCBAs1Ts4iCqCNu6syJk-0YdIBXVmaYqqckz6-oal9QfndsIPaBf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehfedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:mzdfZeW42VyPZdQM6hZ2mbdBV0H-qvxqh0lCaZITzVyD3a2AL-9N5Q>
    <xmx:mzdfZdk7MWr0TsnXYCzWDU7M9lp04mKsr8Iw53N0lhwFYlAIAlBPtA>
    <xmx:mzdfZbcNrk1_uZDN1uy4WpOsnUQd7hxNMT8ySDDMj-iA7P0fKccpug>
    <xmx:mzdfZctmqNsxQ13PI0QM9fXoCKW37M4_03vRqbFcy6W6Hj9cHGbveg>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Nov 2023 06:29:30 -0500 (EST)
Date: Thu, 23 Nov 2023 13:29:27 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Ivar Simensen <is@datarespons.no>
Cc: "mkubecek@suse.cz" <mkubecek@suse.cz>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: ethtool module info only reports hex info
Message-ID: <ZV83lz4bwSpeBFb0@shredder>
References: <AM0PR03MB5938EE1722EF2C75112B86F5B9B9A@AM0PR03MB5938.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR03MB5938EE1722EF2C75112B86F5B9B9A@AM0PR03MB5938.eurprd03.prod.outlook.com>

On Thu, Nov 23, 2023 at 07:42:07AM +0000, Ivar Simensen wrote:
> Hi
> I'm not sure if this is a conscious decision or a bug, but I discovered a change of behavior between version 5.4 an 5.16 according to get module info from a SFP Fiber connector: "ethtool -m ens5".
> 
> After upgrading a target from Ubuntu 18.04 to 22.04, I discovered that the ethtool just report a hex dump when I tried to verify my fiber SFP connectors. In 18.04 I got a report with ethtool. I have tried to upgrade from version 5.16 to 6.1 and 6.5, but it did not fix the issue. I then downgraded to version 5.4 and now it works again.
> 
> The expected result with "ethtool -m ens5" was to get a human readable report, and with "ethtool -m ens5 hex on" a hexdump.
> I have tried with the flag "hex on/off" on 5.16, but the result is always hex dump. 
> On version 5.4 this flag switches between hex dump and module info report as expected.

Can you try the following ethtool patch?

diff --git a/netlink/module-eeprom.c b/netlink/module-eeprom.c
index 49833a2a6a38..8b19f8e28c72 100644
--- a/netlink/module-eeprom.c
+++ b/netlink/module-eeprom.c
@@ -216,6 +216,8 @@ static int eeprom_parse(struct cmd_context *ctx)
 
        switch (request.data[0]) {
 #ifdef ETHTOOL_ENABLE_PRETTY_DUMP
+       case SFF8024_ID_GBIC:
+       case SFF8024_ID_SOLDERED_MODULE:
        case SFF8024_ID_SFP:
                return sff8079_show_all_nl(ctx);
        case SFF8024_ID_QSFP:

We might be missing more identifiers there. I can look into it next week
(around Wednesday).

If it doesn't work, you can try compiling ethtool without the new
netlink support and instead use the legacy ioctl interface:

$ ./configure --disable-netlink
$ make

Thanks

