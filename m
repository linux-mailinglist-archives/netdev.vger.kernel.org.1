Return-Path: <netdev+bounces-13052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5285D73A0BC
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 14:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831AF1C210A3
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 12:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BF31E523;
	Thu, 22 Jun 2023 12:20:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3558A1E516
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 12:20:25 +0000 (UTC)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4625610F2
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:20:24 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 67315320098C;
	Thu, 22 Jun 2023 08:20:20 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 22 Jun 2023 08:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1687436420; x=1687522820; bh=Wa
	qtPwQLyDZ2YLvIHgDIDSRwGDbuVFe58X1mf01iQzY=; b=lzWy4dLg/g0UOEuNqE
	OngWCLrHZgn+dayizs10Bcis+QAanPD9RPEvjvxnNKF803JIcDyWQlORqAPuED3h
	FCoHHvl+DO3N5att7r26uHdhm8MiVT+BmdhUl7vmyPSt6Kw63Y62aFX7+f2DEBMl
	VMMB3qPQXvNZjolrDLhEJc2MHFqBMU5NgulsaWo/U4fF4Z4iaVqisk8Vr1W68Kqb
	me30hYkMfdg1puU4OhGRgs8ZM0Fmi4JV6oUprEJQLLyx6tagsb0bQFR/Fw7wf8KS
	IkPDlLd0Bk0tyQbXGdN9vuumbWh7AZ9FhuSzl/xECQCudGpqRe6F3eHxSKBIuZwv
	lZXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1687436420; x=1687522820; bh=WaqtPwQLyDZ2Y
	LvIHgDIDSRwGDbuVFe58X1mf01iQzY=; b=itPudElv8krK/C4yEzeDJPfnANeFB
	YxFlDFXBsrEwuM9Ax4j2utWEuGQumvA7R1pUp0VSUNspuV9RSDXCvwHjihrpQCjs
	o8mBtgH35cfo3di9uUpxHf4gyplWhoTd8fyMUTGZYgRaxfgSob8uSYgH0qD50sBo
	Q88DYPGL1HisWmj6w1OI5HRd87JfdoSLjKAl2YGH2krRotr21tb23gtMC/SyrqbM
	oswUCNS/DRImsSbLq6ImpkhGdgVMj+VFXiAbfuwcXELFlhQaGWBSEl5TT2FPExGj
	K9NFswsALBDVfzkKKdd+UxPsLutv6k/dcbAFlsDXxntEzS8vCA+Es72fQ==
X-ME-Sender: <xms:gzyUZAxQs3uVQWzOEA2QvgzmsA7SErvdgvBv6mI10ZDz1rROHckuaA>
    <xme:gzyUZET5SUBKExDWv54BxjBZOf2l6jnIeifFmODspgCZrPwb_QOxY4PuHZ4EtcfwH
    CpcaCpjdW7XOAhqdC0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeguddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:gzyUZCWSgo9_g4H1ZdJmap_48pX3Di_zi0gcodfd6rdkVBO506CBmQ>
    <xmx:gzyUZOjj5H5-GiB-CApLWx05fMJR9KenmTQaGl9c7QgzDi_rzPkGBA>
    <xmx:gzyUZCA-WzIRWGSgVZVUc3t9E4PaYf0wH46TuSfNMAWar8Uo5gtiwQ>
    <xmx:hDyUZE3QBEAS7iXNKs-LpHnoh4nF7H0cAILQ0jboIScs3eSecTsG6g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6A782B60086; Thu, 22 Jun 2023 08:20:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <6f87fdf5-1844-4633-b4fe-6b247bc6ab49@app.fastmail.com>
In-Reply-To: <342903aa-ceb5-4412-f5b9-93413d413079@gmail.com>
References: <cover.1687427930.git.ecree.xilinx@gmail.com>
 <441f4c197394bdeddb47aefa0bc854ee1960df27.1687427930.git.ecree.xilinx@gmail.com>
 <c16273f9-f6e9-492d-a902-64604f3e40c2@app.fastmail.com>
 <342903aa-ceb5-4412-f5b9-93413d413079@gmail.com>
Date: Thu, 22 Jun 2023 14:19:58 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Edward Cree" <ecree.xilinx@gmail.com>,
 "edward.cree" <edward.cree@amd.com>, linux-net-drivers@amd.com,
 "David S . Miller" <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>,
 "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>
Cc: Netdev <netdev@vger.kernel.org>,
 "Martin Habets" <habetsm.xilinx@gmail.com>
Subject: Re: [PATCH net-next 1/3] sfc: use padding to fix alignment in loopback test
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023, at 14:02, Edward Cree wrote:
> On 22/06/2023 12:38, Arnd Bergmann wrote:
>> On Thu, Jun 22, 2023, at 12:18, edward.cree@amd.com wrote:
>> 
>> There should probably be an extra __aligned(4) after the __packed,
>> so that the compiler knows the start of the structure is aligned,
>> otherwise (depending on the architecture and compiler), any access
>> to a member can still turn into multiple single-byte accesses.
>
> Ok, will add that in v2.
>
>> I would also expect to still see a warning without that extra
>> attribute. Aside from this, the patch looks good to me.
> My compiler (gcc 8.3.1) doesn't reproduce the original warning, so
>  I'm flying slightly blind here :(  If you could build-test this on
>  your setup with/without the __aligned(4), I'd be very grateful.

I can confirm that your patch addresses the warning for me
with any version of clang I have installed, and that the __aligned(4)
is not needed for the warning, though it is still a good idea for
code generation.

     Arnd

