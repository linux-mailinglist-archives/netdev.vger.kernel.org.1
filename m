Return-Path: <netdev+bounces-13743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC44373CCC6
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 23:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3B4280FEE
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 21:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4E9C136;
	Sat, 24 Jun 2023 21:33:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605E06AA8
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 21:33:01 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA42CE4E;
	Sat, 24 Jun 2023 14:32:59 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 6AD2C5C0090;
	Sat, 24 Jun 2023 17:32:56 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 24 Jun 2023 17:32:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1687642376; x=1687728776; bh=Km
	TzCmtgkDsMsUlkemd4GN1f65YFZGx/erXYr9/Gkuo=; b=X5qbVwWu+hZaXySzg5
	7XHiKwVqb7U7JNYP5AH0hvx1Wyv8lALLs+8p6LuXmS4OdEfoG3FSh8IXyTtWHIFO
	S6PpUl8fL9UnuOgqRhTKJHt9PgZumlR3nv4OUtyxZhk3PPgnQn3Dot9n9SjhNm9d
	5mwLBCdtF3CB7RBP4l5yVsPvi2+dQ36FWnggZR6nqj5dHoFxaUY32CALLetzt4/1
	ZTef9eztymqpzmnf6jS4k+BgxY6yiMa15WORbLysDWzCnaeSzjCLrp9SpaNwoogb
	HJGFLwM0MEKIghMbFwiCPvvqMnWEzCRLZGZf49qEX4FeitlEmDhcNP5TYzt4jCiB
	6Alg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1687642376; x=1687728776; bh=KmTzCmtgkDsMs
	Ulkemd4GN1f65YFZGx/erXYr9/Gkuo=; b=mJr1TpXHXCAg0pYchom+rBjJBnpZ5
	cx6KZ6Lat8B70vXeXNvgZcMw8aDyCXtKrhqt3qxbYd8KuRlf77foix76XGkpNk52
	1zYFajXN3xjWq+uUYJwJP3ppvDm/VT9Tfo5NCD8uqIShOfJayefCIdW6a6sNH0Nv
	UNTlDmy+iTtjLe5ldXaAMQhhavAaKZJg42RwageQKHW63B0gadPKRLhgYs2d9AgJ
	mUhqH3VaTJWPSkWUmq7WeLOEpg/aJPJCXH3s1duHam/njtTx0MCdn8yKnsVZbHp4
	W1LqtPmLL1SzDjF1QSsF3UuoePqRi1Pnu8s5GcozG9NhBHLEVYTsEkFFg==
X-ME-Sender: <xms:B2GXZPDk5kWKhlr1lrM1WulZBwZct3pJybpZzjj6VpvtV62JNBc4IA>
    <xme:B2GXZFg2Naryh6WdS15SENGfzRMmo5od2tcyXEfvcutSdPtb_xvPrqet1UFJS4MTW
    PQaSenV0NUfZuDfDT0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeegjedgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:B2GXZKmL-6f2MlU8M05vus6KcuIlN09GJp-mjyvGinUDSK7cBePQ3Q>
    <xmx:B2GXZBy5QxgvUIF9ebRQKCNskqvKWbGpmYUOuq2aAM5v3omHAL0T5w>
    <xmx:B2GXZES9OFehFvO4r4G377opQ-_ZgAYcLp5W-VUk94zF59z96UfapA>
    <xmx:CGGXZHGwOH7jggq_SYPp5T418kQ52V2cMTtyDGqwE5Ko7Jpwd12rCg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C1263B60086; Sat, 24 Jun 2023 17:32:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <b9428e48-f0f9-46f6-892c-4c8834c930c4@app.fastmail.com>
In-Reply-To: <27829c69-515c-36a6-4beb-3210225f8936@gmail.com>
References: <27829c69-515c-36a6-4beb-3210225f8936@gmail.com>
Date: Sat, 24 Jun 2023 23:32:52 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Bagas Sanjaya" <bagasdotme@gmail.com>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 "Linux Regressions" <regressions@lists.linux.dev>,
 "Linux Wireless" <linux-wireless@vger.kernel.org>,
 Netdev <netdev@vger.kernel.org>
Cc: =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>,
 "kernel test robot" <lkp@intel.com>,
 "Simon Horman" <simon.horman@corigine.com>,
 "Larry Finger" <Larry.Finger@lwfinger.net>, "Kalle Valo" <kvalo@kernel.org>,
 sardonimous@hotmail.com
Subject: Re: Fwd: After kernel 6.3.7 or 6.3.8 b43 driver fails
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 24, 2023, at 03:44, Bagas Sanjaya wrote:
> I notice a regression report on Bugzilla [1]. Quoting from it:
>
>> After upgrading to linux 6.3.8-arch1-1 from 6.3.6-arch1-1, b43 broadcom wireless driver fails.  downgrading back to 6.3.6-arch1-1 resolves.
>> 
>> Jun 16 20:56:37 askasleikir kernel: Hardware name: Apple Inc. MacBookPro7,1/Mac-F222BEC8, BIOS MBP71.88Z.0039.B15.1702241313 02/24/17
>> Jun 16 20:56:37 askasleikir kernel: Workqueue: phy0 b43_tx_work [b43]
>> Jun 16 20:56:37 askasleikir kernel: RIP: 0010:__ieee80211_stop_queue+0xcc/0xe0 [mac80211]

FWIW, the report is missing a few lines at the top about
which error condition is being hit.

>> Jun 16 20:56:37 askasleikir kernel: <TASK>
>> Jun 16 20:56:37 askasleikir kernel: ? __ieee80211_stop_queue+0xcc/0xe0 [mac80211 136d1d948548ad6cca697df0da0a13c0a2333310]
>> Jun 16 20:56:37 askasleikir kernel: ? __warn+0x81/0x130
>> Jun 16 20:56:37 askasleikir kernel: ? __ieee80211_stop_queue+0xcc/0xe0 [mac80211 136d1d948548ad6cca697df0da0a13c0a2333310]
>> Jun 16 20:56:37 askasleikir kernel: ? report_bug+0x171/0x1a0
>> Jun 16 20:56:37 askasleikir kernel: ? handle_bug+0x3c/0x80
>> Jun 16 20:56:37 askasleikir kernel: ? exc_invalid_op+0x17/0x70
>> Jun 16 20:56:37 askasleikir kernel: ? asm_exc_invalid_op+0x1a/0x20
>> Jun 16 20:56:37 askasleikir kernel: ? __ieee80211_stop_queue+0xcc/0xe0 [mac80211 136d1d948548ad6cca697df0da0a13c0a2333310]
>> Jun 16 20:56:37 askasleikir kernel: ieee80211_stop_queue+0x36/0x50 [mac80211 136d1d948548ad6cca697df0da0a13c0a2333310]

This indicates that a WARN_ON() was hit in __ieee80211_stop_queue(),
and the only condition that could cause this is

        if (WARN_ON(queue >= hw->queues))
                return;

Maybe that helps figure out what went wrong. 

        Arnd

