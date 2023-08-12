Return-Path: <netdev+bounces-27009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E217D779E0B
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 10:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226F01C20A17
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 08:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4851CCC1;
	Sat, 12 Aug 2023 08:23:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE551CCC0
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 08:23:53 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24208271E
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 01:23:52 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 8D7515C0041;
	Sat, 12 Aug 2023 04:23:51 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 12 Aug 2023 04:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1691828631; x=1691915031; bh=ql
	ZpWiGRxeMKh6KMLhIJefRYKErXBWUMGgaNN0TSTAo=; b=CU8T7ps5YYN0+x/LyY
	C5bJRDu5oTmQRjk/ol1NP/b2nefOqowVMeSO71UmOnxEvOMxplvrDXJ1u3l4CEBq
	luSi90/gALScKiiPndNWDsE4VYzrIPVrnEhirUd96wdhuZzardUkUF64GQUmfm8t
	hlXjFR9YSH+K3LLXR0TY1B/O6WV5dTm1m66ePkLme+OWDchrNhUwFZVvEp8VtGo5
	2libLGABIcCL+VOK9SKvHn/smGn2nFP+LzP+DWEEIkK4S60VhJdq5KFH1Km2U9Yl
	w6QgwMAyMhWt+y2DmGKpN28kynbrzBMv4YSnOd/Yo/g4QOiNNfAY85Ke0T3BFIwo
	ALfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1691828631; x=1691915031; bh=qlZpWiGRxeMKh
	6KMLhIJefRYKErXBWUMGgaNN0TSTAo=; b=yN52cGVS1Mgr4+Dk6obMup+HjRT9Q
	YUIOe/+HTOTOoJc77Hi5T/QdAkYrs8boWDtOzFq+2zjfk8n9YfXES5WDLO6EuPsC
	4gtzb8g321VDZng/h8sFluBVqwgDhhJWrDuyY7cj8jRyMJsQZslSWCryTRw9FH7e
	r5xPsRpELv56l/SjaIR7KZxLBSJt8Wm+DJI4G/9IF1HMiiPRhFviTjfBqFVCQldy
	icZ0kFOG9u/qLCVO612bQrvfwh5C4s9HUlSCDNl1vIsadoeVw+s7ZlMWDJHw8/Dt
	Vx/S4SdfBzyevjykaurn4amMuE9DsDA/GDSABITBF3RYk8IdN5K6D2NXQ==
X-ME-Sender: <xms:l0HXZHgiYe3sz3gzVOkJkwNebopa2bOQvHSatKsIFDIWqiqpTLQIbQ>
    <xme:l0HXZECZ6XVqEgpxeGSpUGFMf2Ar3Uacy1Yh7G8RFm6IMTrcGKKQo3ccE9RnAC565
    dVmGaAeX48Ou6iwTkc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddttddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:l0HXZHEYhtLvyFyaUL6M_CKaEe1QhJI-7neH5hWd7vz9xQlRj6vhHA>
    <xmx:l0HXZERaHehvN8pnpiA_lzy1vyJNPvJE5bAhuuJy95HcT2OM4mHFVQ>
    <xmx:l0HXZExLjJ6b_8crL1u2K1KvHUG8IrXKUTycQYJXKWzDCEV8dIDpCw>
    <xmx:l0HXZHzz6yZt-2UlIW4kdOV4rHGm54elc7UMRLf9lMIS-iudCjhIvA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 44E0DB60089; Sat, 12 Aug 2023 04:23:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <ceec28d4-48e2-4de1-9f26-bfd3c61fde45@app.fastmail.com>
In-Reply-To: 
 <dfe2eb3d6ad3204079df63ae123b82d49b0c90e2.1687545312.git.ecree.xilinx@gmail.com>
References: <cover.1687545312.git.ecree.xilinx@gmail.com>
 <dfe2eb3d6ad3204079df63ae123b82d49b0c90e2.1687545312.git.ecree.xilinx@gmail.com>
Date: Sat, 12 Aug 2023 10:23:30 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "edward.cree" <edward.cree@amd.com>, linux-net-drivers@amd.com,
 "David S . Miller" <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>,
 "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>
Cc: "Edward Cree" <ecree.xilinx@gmail.com>, Netdev <netdev@vger.kernel.org>,
 "Martin Habets" <habetsm.xilinx@gmail.com>,
 "Kees Cook" <keescook@chromium.org>
Subject: Re: [PATCH v2 net-next 1/3] sfc: use padding to fix alignment in loopback test
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023, at 20:38, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
>
> Add two bytes of padding to the start of struct efx_loopback_payload,
>  which are not sent on the wire.  This ensures the 'ip' member is
>  4-byte aligned, preventing the following W=1 warning:
> net/ethernet/sfc/selftest.c:46:15: error: field ip within 'struct 
> efx_loopback_payload' is less aligned than 'struct iphdr' and is 
> usually due to 'struct efx_loopback_payload' being packed, which can 
> lead to unaligned accesses [-Werror,-Wunaligned-access]
>         struct iphdr ip;
>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
>  drivers/net/ethernet/sfc/selftest.c | 47 +++++++++++++++++------------
>  1 file changed, 28 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/net/ethernet/sfc/selftest.c 
> b/drivers/net/ethernet/sfc/selftest.c
> index 3c5227afd497..96d856b9043c 100644
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
> -} __packed;
> +} __packed __aligned(4);

Unfortunately, the same warning now came back after commit
55c1528f9b97f ("sfc: fix field-spanning memcpy in selftest"), which
does:

 struct efx_loopback_payload {
        char pad[2]; /* Ensures ip is 4-byte aligned */
-       struct ethhdr header;
-       struct iphdr ip;
-       struct udphdr udp;
-       __be16 iteration;
-       char msg[64];
+       struct_group_attr(packet, __packed,
+               struct ethhdr header;
+               struct iphdr ip;
+               struct udphdr udp;
+               __be16 iteration;
+               char msg[64];
+       );
 } __packed __aligned(4);

I'm out of ideas for how to fix both warnings at the same time,
with the struct group we get the iphdr at an invalid offset from
the start of the inner structure, but without it the memcpy
find the field overflow.

My original patch would probably fix it, but as you pointed
out that was rather ugly.

     Arnd

