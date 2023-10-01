Return-Path: <netdev+bounces-37309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8957B49B5
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 23:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3FAAB2816BC
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 21:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165751798C;
	Sun,  1 Oct 2023 21:21:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C3A2F39
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 21:21:31 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6675A9B
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 14:21:30 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 4A6085C2A2D;
	Sun,  1 Oct 2023 17:21:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 01 Oct 2023 17:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bernat.ch; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1696195287; x=1696281687; bh=cIZ1v9XzrZ5UK+8I505lBsq8IyE5FP99PPZ
	7d76FJQo=; b=ngEhtz66+iEv9UIqhAlK80Ld+rFATpimWv1P87XZZxyhDYIwxcb
	ZSBNco/fV5GoGiMYuudnowQh9Gv+7ApNWaByVb68jE7eW3+2vGxTQol4LR1Ci9aE
	QAqk1bD8Mj75O3Fl9o3RmROC7XFJaq+7eoOBW+x6I2B3O4hOIujMcUheP1A01+/4
	iwriApr4gluBDzhAJsIK6EetYxSXVpOeq8sYbTrwHRsfxsMTmuf+Hwp82/kazBY2
	5p7IZYwUH9r5Uuw6tNdIh5eUQVJdfoNiEQgKo9s6wiG2oYnWjG7tocBe2LTiAkB5
	YA3xLqicfvf4tQAHbGqurr8yCOPo4OIdxqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1696195287; x=1696281687; bh=cIZ1v9XzrZ5UK+8I505lBsq8IyE5FP99PPZ
	7d76FJQo=; b=L+P+kjN13xaUCPA6WkNtajXyXmBfdUvtGVrvGnYercipkrx6N6B
	P81FXZE0BDjXrmSKD3mqc7J92MTAFDL776HkbfvvBXgfrffz/AWBD3tKtxbVVhee
	wf6uCJKdKt9cUkxQJU3Xlp17eAoENR1pRIPdE/MU8v4N0rtuHSkO7CtX/6a8MMh3
	5VPyKDlLqAuuFVJ4yP5BoD60btSO8dIFmp1B4gpf8gmJVGAZ2Ae6FmoY17O4Q3Da
	E1AQ4fbJsGxGZddk2AAqSwco2VksrQHAkh9+DQ35+uy2KWOw9qlf2H3i9uPTaToJ
	fY7p7fHcW0PpX90tasjAY/zSlOxw21BM7AQ==
X-ME-Sender: <xms:1uIZZVkYElbDM6wyCFL30_6RZEBpZiwoPgncvICnSfGc2nxDcxZJdg>
    <xme:1uIZZQ1wls8Z04ecVrEDZEZjBryQ7-_kKOUgcSDdWDACu5eQzySJyOSxR7Nfl3ESW
    UZrHTCR7t7cMrJHUXE>
X-ME-Received: <xmr:1uIZZbq7FRW7rtCF3bqU0HAB34-azFWdRmfxEDh82AkJeUjRtDuEVFO6iZ4Vb5TUZc4uvw2fL6D9MDwSQST-Ni8fUXtZlxTio7a-Etkp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepgghinhgt
    vghnthcuuegvrhhnrghtuceovhhinhgtvghnthessggvrhhnrghtrdgthheqnecuggftrf
    grthhtvghrnhepheevkeeutdeiledtffeludehteegudffjefftdelffettdfgkeeuleff
    gfdukefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epvhhinhgtvghnthessggvrhhnrghtrdgthh
X-ME-Proxy: <xmx:1uIZZVl2RSEreCw5GkQ16rzFazKALtzfwr8YUtf4MyrklQIsfjZrgw>
    <xmx:1uIZZT0eNxfxcM_fpycyNt99KVwSLZRsHoXVlFqGece9U5UeHDwDmA>
    <xmx:1uIZZUtKxa6FtsRYbUahfliHKL2W3HUAevkV9yrs-E2DELBkA3_VfA>
    <xmx:1-IZZdpFihLVtAWnolCTzVtZFFWkK22xJANTVBQcswdQeZsVvVBRZQ>
Feedback-ID: id69944f0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Oct 2023 17:21:26 -0400 (EDT)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by neo.luffy.cx (Postfix) with ESMTP id 10AF8315;
	Sun,  1 Oct 2023 23:21:24 +0200 (CEST)
Message-ID: <891375df-7395-4512-bd0c-055dac5cbedc@bernat.ch>
Date: Sun, 1 Oct 2023 23:21:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] vxlan: add support for flowlabel inherit
Content-Language: en-US, fr
To: Eric Dumazet <edumazet@google.com>, Alce Lafranque <alce@lafranque.net>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org
References: <4444C5AE-FA5A-49A4-9700-7DD9D7916C0F.1@mail.lac-coloc.fr>
 <CANn89i+q_0e3ztiHD5YE4LBJCSeaETk3VyJ0TPuJYP9By1_1Tg@mail.gmail.com>
From: Vincent Bernat <vincent@bernat.ch>
Autocrypt: addr=vincent@bernat.ch;
 keydata= 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
In-Reply-To: <CANn89i+q_0e3ztiHD5YE4LBJCSeaETk3VyJ0TPuJYP9By1_1Tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-09-30 17:29, Eric Dumazet wrote:

>> $ ./ip/ip link add vxlan1 type vxlan id 100 flowlabel inherit remote 2001:db8::1 local 2001:db8::2
> 
> Side question : How can "flowlabel inherit" can be turned off later
> with an "ip link change ..." ?
> 
> It seems vxlan_nl2flag() would always turn it 'on' for NLA_FLAG type :
> 
> if (vxlan_policy[attrtype].type == NLA_FLAG)
>      flags = conf->flags | mask;  // always turn on
> else if (nla_get_u8(tb[attrtype]))    // dead code for NLA_FLAG
>      flags = conf->flags | mask;
> else
>      flags = conf->flags & ~mask;
> 
> conf->flags = flags;

Most "flags" in vxlan module cannot be changed (see 
vxlan_flag_attr_error()).

IFLA_VXLAN_TTL_INHERIT seems to be the only one using NLA_FLAG. All the 
others are using NLA_U8 and in iproute2, they use XXXX and noXXXX option 
style. I suppose it makes sense to do this way if you don't know what 
the default value is.

For IFLA_VXLAN_TTL_INHERIT, iproute2 treat it as a u8 when reading, but 
as a flag when writing. I don't know if it makes sense to turn it to a 
true flag or if it would be considered as breaking userspace? iproute2 
would be OK, but I suppose that another piece of userland could have put 
the attribute with a value of 0.

For IFLA_VXLAN_LABEL_INHERIT, we can use a proper flag from start.


