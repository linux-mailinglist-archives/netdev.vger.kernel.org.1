Return-Path: <netdev+bounces-45304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E54177DC040
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 20:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA391C20895
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 19:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCA319BCC;
	Mon, 30 Oct 2023 19:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bernat.ch header.i=@bernat.ch header.b="qTyNjirK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uxn07+kA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD1019BBB
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 19:18:32 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84B0A9
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 12:18:30 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id A55AC5C0049;
	Mon, 30 Oct 2023 15:18:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 30 Oct 2023 15:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bernat.ch; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1698693507; x=1698779907; bh=dKejwYjgNB2ZIOaAAC2MPWeLWJ3CMRZwSUB
	1mGSlY1g=; b=qTyNjirKGQkbdEL8n8SD/n46aDVxgZC9QmAexiAN6RNGxmeEsJn
	/Ql4CfJ8E2xsU50GxLh2HfBz3wSwgMr6XW6WiKY6opKG3kocSb5jnFudHxzdIc9O
	CIVBJ4LqHi+8Q3kp/pZocNMlNojnggiy89V1/38bjdJrVPy2twZcQYdWhVrPiUIz
	NQA47fD2VOfb7V5lCu+t9RYb2aXs2Gnazygr8tJ8iqDvPVVPyakW6EhZ737hNvHw
	+jeJCZ2NWI69JS6l5O8E2P4/DXx3/RECOb8ll6gs0gRyWPagjQuqf8sfNj4AipSj
	VgZeoOqhkudaInt58ZqeMD/Nc/1wb1RVoAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1698693507; x=1698779907; bh=dKejwYjgNB2ZIOaAAC2MPWeLWJ3CMRZwSUB
	1mGSlY1g=; b=uxn07+kAtW04DaygRApJVbbNLSxetA9ZN0aeMGBqe9TMN8Z5DgJ
	HdKyFX3mxB4v5yZD5BbW+F/ZwJgK9ZHzo6Q30APu8fCHCuLSUpjFWCJUu+2rNZIL
	IS7jA4UyVGWLQr/0BhKCVHdihGTkemPGnL6ySd+U+A6pw8dQasv4zQMT5qn318JR
	rKJ0hnw8HQ6B5kcD24ByihyKLchvOogRJf802ebMohJzStsTGIgmc/45eGPEoaJ5
	FtMWN7SxbePeqE/+V5keyDzPNim1WS0b80iE7n/W3Pp+BgZDAQKRUQTK3/9dIdxf
	cR0/G8evb7XRvLz2uF99n746+E/jNdayCBA==
X-ME-Sender: <xms:gwFAZbgUEOKc79rH9PZsYBDIoTBXkXWRDoYiTYeZ0Vry5JB5EcWRcg>
    <xme:gwFAZYA-DKW4emF_rrWTxLtUrbqrhiAZ3hRrkNbqHExVkx4sSdS_ncPZR1LBjYtRx
    EC161Dllf0HcGRzCus>
X-ME-Received: <xmr:gwFAZbH0vdvAeNFCLPS4p7bsx9NEJHmQpoC0ZPXUo-prV-TsnV35zTdrW5BZtltk8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddttddguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepgghi
    nhgtvghnthcuuegvrhhnrghtuceovhhinhgtvghnthessggvrhhnrghtrdgthheqnecugg
    ftrfgrthhtvghrnhepheevkeeutdeiledtffeludehteegudffjefftdelffettdfgkeeu
    leffgfdukefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepvhhinhgtvghnthessggvrhhnrghtrdgthh
X-ME-Proxy: <xmx:gwFAZYShx49eb1ANEwG35Y3lOD3DmGS8ns6UgZ0vJ1gffiQgFbcn4w>
    <xmx:gwFAZYwhEC2dghi5lccQwrb9faJShH___DrnZlQYXe1278DBjlEuiw>
    <xmx:gwFAZe6s-INyKn2f8SLLr5vRG-YJMSCh4coYKUHaqRsiElHfaIzljQ>
    <xmx:gwFAZfkXDJXEPZt9mkmEo-xpQ5FMkg62IXGcKk6c7jkBoP2NVizyIw>
Feedback-ID: id69944f0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Oct 2023 15:18:26 -0400 (EDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by wally.luffy.cx (Postfix) with ESMTP id DD3F15F7A9;
	Mon, 30 Oct 2023 20:18:23 +0100 (CET)
Message-ID: <67d2a73d-c2a6-4d66-ba7d-4aae77360f25@bernat.ch>
Date: Mon, 30 Oct 2023 20:18:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7] vxlan: add support for flowlabel inherit
Content-Language: en-US, fr
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alce Lafranque <alce@lafranque.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
References: <20231024165028.251294-1-alce@lafranque.net>
 <20231025182019.1cf5ab0d@kernel.org>
 <8adb039f-00db-40a1-bcb6-4379e823fd0b@bernat.ch>
 <20231026090424.73a49f35@kernel.org>
From: Vincent Bernat <vincent@bernat.ch>
Autocrypt: addr=vincent@bernat.ch;
 keydata= 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
In-Reply-To: <20231026090424.73a49f35@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-10-26 18:04, Jakub Kicinski wrote:
> On Thu, 26 Oct 2023 17:53:22 +0200 Vincent Bernat wrote:
>>>> +	enum ifla_vxlan_label_policy	label_policy;
>>>
>>> Here, OTOH, you could save some space, by making it a u8.
>>
>> Is it worth it?
> 
> I'm just pointing out the irony of trying to save space in netlink,
> where everything is aligned to 4B, and not trying where it may actually
> matter :)

OK, let's fix this by using 4B for the netlink attribute, but we keep 
the enum unless you object strongly on this matter.  Also, just using u8 
wouldn't save space as `flags' would introduce a 3B padding, so we would 
also need to move it at the end.

