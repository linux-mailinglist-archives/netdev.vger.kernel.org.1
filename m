Return-Path: <netdev+bounces-13031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E605739FBE
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 13:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 294742818CE
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 11:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3831B901;
	Thu, 22 Jun 2023 11:39:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA5B1B8FC
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 11:39:41 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38FF1FD2
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 04:39:15 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 1F71E5C00DF;
	Thu, 22 Jun 2023 07:39:15 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 22 Jun 2023 07:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1687433955; x=1687520355; bh=QV
	UNC0FH3SU6TgaN7cK2R/DHog5zWqVr3O8d5LjsIgU=; b=ZRMCFdDIC4bVn/HrJy
	GJuNsLyJC4W9GziIYbmC6FiSySca944uCBaXd/krc1ozCupYjOfXzcmSGdWE6ZJ4
	9y8lfKB++mH8qX1vr0SkjgpSWVjQxBtk1wOl6MrGXl/h8Ge0BILegIjhOErMa3ut
	gdA659xPyvn/a/qra/FNsExy72CS3fYVpp5BY1RlnR3gQEWswV7Q39SuJMTx4EbW
	TzKDBm9kKS+0ivT2Dfl61gNTZ6RU7ycy1R4QMblBRY98CNYK26W5d0S9yLWgICZ5
	/+H0rpJdo7kqUk+dhv5gx+eKTv13DAt5jpqcQV0EDvKRbeYKGfyVf1nxRjChc7RI
	pyZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1687433955; x=1687520355; bh=QVUNC0FH3SU6T
	gaN7cK2R/DHog5zWqVr3O8d5LjsIgU=; b=MkX+xz8mvq5GtOYkNgQlbUi5Abk08
	YMDM0InPlV8K56Wqc8l4aReHSkbr1Eet4TpRy1tL4ndT9iX/u5HfDsdDiqLxcLTf
	HxULOb+1rHwzP/tmXCwxMjEhlYD9g4aHPQrvDB8GuUH3FJyLB4uRvqJ2rIiCZ3Pz
	0Oz3LGeE1SdHWJ18tSH+VpLsoJUepffBX87hYFbSjk908L4rWwhhCYunJ7nptAtT
	GHjF9WZvk9zEk45znRd3T1pQDp9XfNUuhT7p3F7u9rX+d6OBXs3R83gWPBnp4ATG
	hBqqtYsvv+u6z8wONE8hUSyGmDg2qVGLlo4yoGfoD+9vZJpDEBpOaK2Ow==
X-ME-Sender: <xms:4jKUZFVYP9MtlC0MEhftAauW6nrzMRabpu7SWB-GUM4d8MdOEasUIQ>
    <xme:4jKUZFkWp0d3XWdYUh_kM1O2CcgWsOjUcoPOtkTlu2r15nQUiX-gccucenMDNoxr2
    AkvCklSfDgxqs3R2NY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeguddggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:4jKUZBbSpF9ROsNeqa3U8vsWA3jWMah4DlfUMwR4URZPGjwA_d6xbg>
    <xmx:4jKUZIWjGNOJHilvaV5MbmxgaKrsbJii9NeY1U_5KMfTfIW7OjNXUg>
    <xmx:4jKUZPnhRlVhlCPsP1zMyr39RzGQfpwUAEGb9A0Z-g_4WSyTdCne0w>
    <xmx:4zKUZNZ8t7MNAhfHc9zWqGyeizw-uTzTxa7vDiStGsSchlAYK_nEVg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id DF71DB60086; Thu, 22 Jun 2023 07:39:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <c16273f9-f6e9-492d-a902-64604f3e40c2@app.fastmail.com>
In-Reply-To: 
 <441f4c197394bdeddb47aefa0bc854ee1960df27.1687427930.git.ecree.xilinx@gmail.com>
References: <cover.1687427930.git.ecree.xilinx@gmail.com>
 <441f4c197394bdeddb47aefa0bc854ee1960df27.1687427930.git.ecree.xilinx@gmail.com>
Date: Thu, 22 Jun 2023 13:38:54 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: edward.cree@amd.com, linux-net-drivers@amd.com,
 "David S . Miller" <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>,
 "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>
Cc: "Edward Cree" <ecree.xilinx@gmail.com>, Netdev <netdev@vger.kernel.org>,
 "Martin Habets" <habetsm.xilinx@gmail.com>
Subject: Re: [PATCH net-next 1/3] sfc: use padding to fix alignment in loopback test
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023, at 12:18, edward.cree@amd.com wrote:
>  drivers/net/ethernet/sfc/selftest.c | 45 +++++++++++++++++------------
>  1 file changed, 27 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/net/ethernet/sfc/selftest.c 
> b/drivers/net/ethernet/sfc/selftest.c
> index 3c5227afd497..74b42efe7267 100644
> --- a/drivers/net/ethernet/sfc/selftest.c
> +++ b/drivers/net/ethernet/sfc/selftest.c
> @@ -42,12 +42,16 @@
>   * Falcon only performs RSS on TCP/UDP packets.
>   */
>  struct efx_loopback_payload {
> +	char pad[2]; /* Ensures ip is 4-byte aligned */
>  	struct ethhdr header;
>  	struct iphdr ip;
>  	struct udphdr udp;
>  	__be16 iteration;
>  	char msg[64];
>  } __packed;

There should probably be an extra __aligned(4) after the __packed,
so that the compiler knows the start of the structure is aligned,
otherwise (depending on the architecture and compiler), any access
to a member can still turn into multiple single-byte accesses.

I would also expect to still see a warning without that extra
attribute. Aside from this, the patch looks good to me.

     Arnd

