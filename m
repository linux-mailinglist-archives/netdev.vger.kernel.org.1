Return-Path: <netdev+bounces-18475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B07C1757539
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 09:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 982041C20C27
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 07:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5325660;
	Tue, 18 Jul 2023 07:23:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4967810EA
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 07:23:03 +0000 (UTC)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72733EC;
	Tue, 18 Jul 2023 00:22:59 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 7B9B532007E8;
	Tue, 18 Jul 2023 03:22:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 18 Jul 2023 03:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1689664974; x=1689751374; bh=hcOqxuJYpCUDm
	7OSYb+0ENGEvGMeG3JMgPYd+FVq3rQ=; b=Y6YPCbVC28+5y/DrY50kJ6mKnb2sO
	p2boWneE1mrO7RG3KQ0MSleQ8HgpBlfDKZ4Xt1r7mVo4vAC0lBx61cFngf80KIFh
	Hgne9EG8VZXt/eCGzC7r6MyvIosIwFW22u0T038RtdoTPIwCQu6eQKq5GF01ZKAt
	Zbaa4pqN/VVjrdEmi66yk5WSrdcwLBaerf8LYRFWWgcK3PvSmO2gJKAA2TcRC0mo
	XmBiOusDZ1kdWdGBRDmrM2hlPnOi31KXaYBUnpdQs/nZJ0AlSHR5XJXhENl8WET2
	ayhMrpvTbPZKR0AAD+I1W4aPbfi6Jwz3+uAIRst91g6bOWPNq//b3eqGA==
X-ME-Sender: <xms:zT22ZI1ObB4JDO5-CqtzUoqc-_DqGkhwnbPxlyocESFVG36ABT6BYw>
    <xme:zT22ZDE8ojq80m7km4xPkq-7NtLNVa3fMWEqqBxQ62s1nZiasmziQ128_JaslgR0D
    -OtnZiQo3FBg1A>
X-ME-Received: <xmr:zT22ZA7_s6t1fC0AcCyS6FZX-rguUONOOAHg75LZ_uviI7rOgzZ1pWbzbX-6cAm7e5AHPpnqix0cg2sxKA_FpOd1h7Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgeefgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:zT22ZB2ZlVzsiW2avGsNc1I4app7W8VkS-UkLdoU9DI8BDN-tTl3tw>
    <xmx:zT22ZLEDQlxBqoYjympO5nGMnnOria844Ldra4MhKxfojh-7B2StZA>
    <xmx:zT22ZK80f_3jFaYy-41p6MoTUCLFpAB-jXuUrY4DEzHJYNzCAxZTYw>
    <xmx:zj22ZCA7Zwv8z9M_y2CICA2eiwLO6KBYnY1AAw8RHgzxUVwvKq_VmA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jul 2023 03:22:52 -0400 (EDT)
Date: Tue, 18 Jul 2023 10:22:50 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	petrm@nvidia.com
Subject: Re: [PROBLEM] selftests: net/forwarding/*.sh: 'Command line is not
 complete. Try option "help"'
Message-ID: <ZLY9yiaVwCGy5H3R@shredder>
References: <856d454e-f83c-20cf-e166-6dc06cbc1543@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <856d454e-f83c-20cf-e166-6dc06cbc1543@alu.unizg.hr>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 17, 2023 at 10:51:04PM +0200, Mirsad Todorovac wrote:
> Tests fail with error message:
> 
> Command line is not complete. Try option "help"
> Failed to create netif
> 
> The script
> 
> # tools/testing/seltests/net/forwarding/bridge_igmp.sh
> 
> bash `set -x` ends with an error:
> 
> ++ create_netif_veth
> ++ local i
> ++ (( i = 1 ))
> ++ (( i <= NUM_NETIFS ))
> ++ local j=2
> ++ ip link show dev
> ++ [[ 255 -ne 0 ]]
> ++ ip link add type veth peer name
> Command line is not complete. Try option "help"
> ++ [[ 255 -ne 0 ]]
> ++ echo 'Failed to create netif'
> Failed to create netif
> ++ exit 1
> 
> The problem seems to be linked with this piece of code of "lib.sh":
> 
> create_netif_veth()
> {
>         local i
> 
>         for ((i = 1; i <= NUM_NETIFS; ++i)); do
>                 local j=$((i+1))
> 
>                 ip link show dev ${NETIFS[p$i]} &> /dev/null
>                 if [[ $? -ne 0 ]]; then
>                         ip link add ${NETIFS[p$i]} type veth \
>                                 peer name ${NETIFS[p$j]}
>                         if [[ $? -ne 0 ]]; then
>                                 echo "Failed to create netif"
>                                 exit 1
>                         fi
>                 fi
>                 i=$j
>         done
> }
> 
> Somehow, ${NETIFS[p$i]} is evaluated to an empty string?

You need to provide a configuration file in
tools/testing/selftests/net/forwarding/forwarding.config. See
tools/testing/selftests/net/forwarding/forwarding.config.sample for
example.

Another option is to provide the interfaces on the command line.

./bridge_igmp.sh veth0 veth1 veth2 veth3

If no configuration file is present, we can try to assume that the
tests are meant to be run with veth pairs and not with physical
loopbacks. Something like:

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 71f7c0c49677..5b0183013017 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -16,8 +16,6 @@ TEAMD=${TEAMD:=teamd}
 WAIT_TIME=${WAIT_TIME:=5}
 PAUSE_ON_FAIL=${PAUSE_ON_FAIL:=no}
 PAUSE_ON_CLEANUP=${PAUSE_ON_CLEANUP:=no}
-NETIF_TYPE=${NETIF_TYPE:=veth}
-NETIF_CREATE=${NETIF_CREATE:=yes}
 MCD=${MCD:=smcrouted}
 MC_CLI=${MC_CLI:=smcroutectl}
 PING_COUNT=${PING_COUNT:=10}
@@ -30,6 +28,20 @@ REQUIRE_MZ=${REQUIRE_MZ:=yes}
 REQUIRE_MTOOLS=${REQUIRE_MTOOLS:=no}
 STABLE_MAC_ADDRS=${STABLE_MAC_ADDRS:=no}
 TCPDUMP_EXTRA_FLAGS=${TCPDUMP_EXTRA_FLAGS:=}
+NETIF_TYPE=${NETIF_TYPE:=veth}
+NETIF_CREATE=${NETIF_CREATE:=yes}
+declare -A NETIFS=(
+       [p1]=veth0
+       [p2]=veth1
+       [p3]=veth2
+       [p4]=veth3
+       [p5]=veth4
+       [p6]=veth5
+       [p7]=veth6
+       [p8]=veth7
+       [p9]=veth8
+       [p10]=veth9
+)
 
 relative_path="${BASH_SOURCE%/*}"
 if [[ "$relative_path" == "${BASH_SOURCE}" ]]; then

