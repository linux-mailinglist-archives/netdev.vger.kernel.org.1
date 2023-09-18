Return-Path: <netdev+bounces-34435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F8D7A42A5
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 09:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A72D281DC9
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 07:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CD379FD;
	Mon, 18 Sep 2023 07:31:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E4F14AAD
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 07:31:39 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E5A197;
	Mon, 18 Sep 2023 00:31:28 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 9D4C65C0152;
	Mon, 18 Sep 2023 03:31:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 18 Sep 2023 03:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1695022287; x=1695108687; bh=YTcyWiGsDcH3h
	DR+6efIJUv0XVuW7F54zGUEX+HekeE=; b=XeFZt4k3yxxKIxg7+9pecr1XxHAdB
	uoruOhrzc1asSfE4JphaRxshTnvuTSond3JWHvfRLEH+nN+XJ8RaXfzE/Iz7UaNH
	srdBS5GfO5VonagRvQVR++8rCrm1mTGw5GHKiHjqHuuhAoKspd38YveDTbF1sE3e
	41wNcJ1s3ejc2SSJgTEM8TIxmYYe2BoNu5puI2zoU0WAt2tseXa5IogAMUc3M8rZ
	Rs3IREi4eWiqYD4HLxyZOUF+ssc+Jo2IyZ5maOiQUjg/n/fzMaUrHiSUceCPzZhR
	HWpoCqbu+9c3QqOE+jba1Ce+zzJU1bDWZo7ZK6WeRR0MvrRoqXgq98qHw==
X-ME-Sender: <xms:z_wHZdiqpsmq6FbcYpWTc350Oo2xIXJG0ajGWxdeYJKvvox-B-HGHQ>
    <xme:z_wHZSDqirBuP4o_lDLr-Z30pQ-osGbstWCoa3_eqTBBzAeyt51gMhtZwVDvAPeE7
    U_yH5fRPgAj-rk>
X-ME-Received: <xmr:z_wHZdHHXobL1zAwrqfNfQFityIhTfi42c8-toBPOX-zhQV3oKCxBYMvvlF8ZHB_Ga_VadPE7J5J2feLAClHfk0bhk3MQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejjedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkugho
    ucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeej
    geeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:z_wHZSRGcBV8QG7J_ccEk-4r5J-onpFW11kqVmxu0S_K-fDPcQB0yg>
    <xmx:z_wHZaz5RR1g392IzmS-fkOW25IN8zWSr5zWyxAeMu4CVm-9MD0n7A>
    <xmx:z_wHZY5ykig_eLZ9sOdBJT7NEzpgEiw0mrZn43yZjvDYAIZyT6HVZA>
    <xmx:z_wHZZlGA_49A5j-D3VFJ371f3FatlZZeXjleRORcxdrYVw9mWQkRw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Sep 2023 03:31:26 -0400 (EDT)
Date: Mon, 18 Sep 2023 10:31:23 +0300
From: Ido Schimmel <idosch@idosch.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] mlxsw: Use size_mul() in call to struct_size()
Message-ID: <ZQf8y6RVobiGUyzZ@shredder>
References: <ZQSqA80YyLQsnd1L@work>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQSqA80YyLQsnd1L@work>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 01:01:23PM -0600, Gustavo A. R. Silva wrote:
> If, for any reason, the open-coded arithmetic causes a wraparound, the
> protection that `struct_size()` adds against potential integer overflows
> is defeated. Fix this by hardening call to `struct_size()` with `size_mul()`.
> 
> Fixes: 2285ec872d9d ("mlxsw: spectrum_acl_bloom_filter: use struct_size() in kzalloc()")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

