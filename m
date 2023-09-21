Return-Path: <netdev+bounces-35419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 303877A9722
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1532B20D5A
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 17:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BA2D53F;
	Thu, 21 Sep 2023 17:04:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596F3BE5F
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:04:52 +0000 (UTC)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5612111;
	Thu, 21 Sep 2023 10:02:39 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id A363832009CF;
	Thu, 21 Sep 2023 08:13:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 21 Sep 2023 08:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1695298398; x=1695384798; bh=qL6/VmfuEG0N5
	xc6Mz2PvEm3VWqhSA+Pyx12f0FNgWU=; b=NNL8lLZ+nJLyfc6TshaXc4SDbglQp
	a5ODaObdGtjszpBwKJ0Noyh3s/ouKVzOk3ISKCOGJ3XNBvbqe5AeN/048pZRLjiv
	iBeXMcn5Gi7b6wms38bJmdhePlZtGCQ+5HjCoS3OQvYf2yjeN0DWol9H/ihvIlDs
	B1BHuUigB92bXlPuGOFtLqzAKW3g4AEQYixtrwoJIEpt6B7/FO+9wvNzOBG2L5hx
	sswKQwV9JYGbLdkR2oUkpP+YqpSyQzc6UG1sXviI8XOuUUXYG6ogPgML+mfJlpO0
	qq9W6KkzK9vIs9UL/dRRcEqKyy6fVp8LwO6Gcl48X8QEQG6hrxKy0BQMA==
X-ME-Sender: <xms:XTMMZU558zdbFxDVrw_Ze1QeomT43lgk6oMhblaUrxvWoyO7G_QfMw>
    <xme:XTMMZV7WhFGkfhy9cDBfZoImR4-U9VV7Mi4kFtDuSncH_98CDVb_P4hub8H-HR-yc
    OBI4cjlhYaZV1Y>
X-ME-Received: <xmr:XTMMZTcSMCggTH-WN0omJfhlEc3mEWy01SQXRyhqoBeTbUYjI0E6aEzV7OtjGHYb_W0usouEZjkh-1JGP-0H5cRPMxaSrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekiedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepfeefueegheehleelgeehjefgieeltdeuteekkeefheejudffleefgfeludeh
    hfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:XTMMZZKXbA6vPaFCLmzHouZnZ4RYukMibMg83PSsC7kY1pdEfS-2sA>
    <xmx:XTMMZYJ5RUdkPQnNAdANDWlG2JlM3L6gEl3iA6nHkf9F4yaJLjFrgw>
    <xmx:XTMMZawkfgR8HELWgXaCFL5B3mVVXvyaTzTDKMBF4Vk_o0qllOJ0lw>
    <xmx:XjMMZV5p-3tjzZoiv3kOV5hCZK4mJttyW-Lf9t0syPcIwKPKyijm1A>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Sep 2023 08:13:16 -0400 (EDT)
Date: Thu, 21 Sep 2023 15:13:12 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Johannes Nixdorf <jnixdorf-oss@avm.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	David Ahern <dsahern@gmail.com>, Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Oleksij Rempel <linux@rempel-privat.de>,
	Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/6] net: bridge: Set BR_FDB_ADDED_BY_USER
 early in fdb_add_entry
Message-ID: <ZQwzWINOPagvLgbS@shredder>
References: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
 <20230919-fdb_limit-v4-1-39f0293807b8@avm.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919-fdb_limit-v4-1-39f0293807b8@avm.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 19, 2023 at 10:12:48AM +0200, Johannes Nixdorf wrote:
> In preparation of the following fdb limit for dynamically learned entries,
> allow fdb_create to detect that the entry was added by the user. This
> way it can skip applying the limit in this case.
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

