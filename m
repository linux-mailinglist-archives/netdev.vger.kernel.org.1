Return-Path: <netdev+bounces-27367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D3F77BA75
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 15:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468692810CA
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 13:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CF1C126;
	Mon, 14 Aug 2023 13:45:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678EEBE68
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 13:45:34 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD65E77
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 06:45:32 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 320645C00DF;
	Mon, 14 Aug 2023 09:45:32 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 14 Aug 2023 09:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1692020732; x=1692107132; bh=xH
	H+aHpZ7+XPelhY5Ww+5bnDZ0APLRmonlX0V+nwmMA=; b=GR7+YC7rB8Ll3C2YLP
	t/OF2TQ0bLqlIG6SpYset7OlzEdAdCggLo2SmS2C8I/KrUr2/rr949KWFX3/5To3
	/GFDpZbsQ/jQSHXeUrwf/ZzKEqVZPy/lHHqTHDwUteJ7adjjEiBNp4yF1ZUTBIK5
	GQIggkqcXoK8sIwocm4hsAzXAYX5bnkSqaGyVCvCxDn9Y7hc3gzN3qSg2EQeF0BQ
	DdbUH87o77sK/SL45Mvnc1R51s8zk+u5I23k6h6s+jWNNgx5Y4RJHD1PHUKvMc81
	z5yQgOMarhjIP8tDKnMEUy2kOUlFDOrt+mv+eR3J3D+9bWmxGypjS1JUHfHV8Kfd
	06pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1692020732; x=1692107132; bh=xHH+aHpZ7+XPe
	lhY5Ww+5bnDZ0APLRmonlX0V+nwmMA=; b=vijavl2AZgbyCJOYODOfN2P6cHFXF
	FDq3Wc3Ltclenk/xfT9oStQyB8xLLYsAYKJI1zjZG4qU5nGOdBEp8I1gtJIg1Xsp
	T0X2KbTKFwN8iRo9RlVp0u4yoVXQ+lh5HDTNSpzi52CA/Rljt0yu0fSccathijyL
	5griNEuDdEaWLCviN5GMRLKLV6jfpS2por2l6kScKiibMHLSyulBaMqir0h7+9nx
	q6eySBBUF0oL2aCiRqSbqb/QRlvVtkIWz9P/lsqrmogEDa7itUxf2cZGwck7eBeB
	quke+WUr7c0+559ugv+RmEWJVr81kry10HlpoZRpnIoKrKUlBaiOnLdgA==
X-ME-Sender: <xms:-y_aZNjXFGKA_JccOxd3x9mETuaXh-AFfXNm5CTDFL1-acx-0z2k4Q>
    <xme:-y_aZCAT4g9mlR298-coCEyVxdbc9RMdGW5_Lm83rLSdjxKm4_a_JNMPMkQVgmUo7
    wMEvXig_KgdDE8mp_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtgedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:-y_aZNE8UTlNcz2d8-SVQ9-mdsm_6CTljZo6xpFQzE_40sMn4Wn7Ow>
    <xmx:-y_aZCQXyveSNFcvPwqHgyasjJRYglSpqzyppgxAV5rJbiSXzALE-g>
    <xmx:-y_aZKz2SdtmnSp5J7ITNDbLtbNiTuVevJIPrtO05DmQs6ghqp5oAg>
    <xmx:_C_aZFyldmlwoTtY6EibasAqhuMzJEI8-nFnqpG4xcbQHXN0cX9wIA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C4BE6B60089; Mon, 14 Aug 2023 09:45:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <d5d4ae40-047c-4913-9e6f-16093e150e40@app.fastmail.com>
In-Reply-To: <90e83021-49f3-2b0e-bb9c-01539229c50b@gmail.com>
References: <cover.1687545312.git.ecree.xilinx@gmail.com>
 <dfe2eb3d6ad3204079df63ae123b82d49b0c90e2.1687545312.git.ecree.xilinx@gmail.com>
 <ceec28d4-48e2-4de1-9f26-bfd3c61fde45@app.fastmail.com>
 <90e83021-49f3-2b0e-bb9c-01539229c50b@gmail.com>
Date: Mon, 14 Aug 2023 15:45:10 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Edward Cree" <ecree.xilinx@gmail.com>,
 "edward.cree" <edward.cree@amd.com>, linux-net-drivers@amd.com,
 "David S . Miller" <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>,
 "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>
Cc: Netdev <netdev@vger.kernel.org>,
 "Martin Habets" <habetsm.xilinx@gmail.com>,
 "Kees Cook" <keescook@chromium.org>
Subject: Re: [PATCH v2 net-next 1/3] sfc: use padding to fix alignment in loopback test
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 14, 2023, at 12:06, Edward Cree wrote:
> On 12/08/2023 09:23, Arnd Bergmann wrote:
>> On Fri, Jun 23, 2023, at 20:38, edward.cree@amd.com wrote:
>> Unfortunately, the same warning now came back after commit
>> 55c1528f9b97f ("sfc: fix field-spanning memcpy in selftest")
> ...
>> I'm out of ideas for how to fix both warnings at the same time,
>> with the struct group we get the iphdr at an invalid offset from
>> the start of the inner structure,
>
> But the actual address of the iphdr is properly aligned now, right?

Yes

> AFAICT the concept of the offset per se being 'valid' or not is not
>  even meaningful; it's the access address that must be aligned, not
>  the difference from random addresses used to construct it.
> In which case arguably the warning is just bogus and it's a compiler
>  fix we need at this point.

I think overall this is still a useful warning, in the sense that
it can spot incorrect code elsewhere. The reasoning seems to be
that the behavior of __packed is GNU specific and incompatible with
the C23 _Alignas() annotation that is specified as

  5 The combined effect of all alignment specifiers in a declaration
    shall not specify an alignment that is less strict than the
    alignment that would otherwise be required for the type of
    the object or member being declared.
    ...
    When multiple alignment specifiers occur in a declaration, the
    effective alignment requirement is the strictest specified
    alignment.

I tried the same code using the standard C notation, which
turns the warning into an error in clang.

      Arnd

