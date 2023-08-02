Return-Path: <netdev+bounces-23650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AF276CEAA
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3BD281B6B
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 13:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5677748E;
	Wed,  2 Aug 2023 13:30:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90252746C
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 13:30:40 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06151BF9
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 06:30:38 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 9BD045C0114;
	Wed,  2 Aug 2023 09:30:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 02 Aug 2023 09:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1690983034; x=1691069434; bh=Se4vkJiLMujX1
	hWtC0LkiKZ1N+nHiXONUDKEUSkblLI=; b=fGOA9Sk4/cfeDlqQNF1vvqL2Y1bQf
	wYqIP1XgqOKj9zMHlQlRgLaCC+VLGCLd7ErVgbHkT73I1a9VOW7377khx1j3vev7
	AFK0Rep49f8mbRCd2u5wUlghnh94ho7yoiyhu9uwssw8eoztaH91iX/hXK4jrG4D
	Z7GL4Ttwg9b8O4eT0zKABgu1ZKwjOMFi2q44xhdgwQSd0eIOvHXHtig1mSlhElIC
	Qbgpy+N8FvUxeB/JR08GpVhLVsD2hXjfNa5UKE4RU6F+6PNdt+ZVmMXAwQBT1/bf
	wuMMkoY0RNR/5FIGfq4QP9decZsXN5JsAiV5vHxoi60wxg6W3NtMJ028Q==
X-ME-Sender: <xms:elrKZFcXjGzQe9VNBJ9PoxB6_e_xfCWPZmQXk3Y848hEEuSZ6_L8PA>
    <xme:elrKZDM2yFK9jkxTTOz6M2gVTKc7UnDlD4bEjbSWqZVniSq7eBNyAKcEcm8x-5WR5
    X7SsaIiA5H2KN0>
X-ME-Received: <xmr:elrKZOg9VUjFuIKDzHZTnybi9G_-IF3Gdb2i4i11MBbVw7RTg-SDp4LjB4ihWMH1TbQG0_reFoz_3aJFctEl8DhMJzSOpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeekgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpeehhfdtjedviefffeduuddvffegteeiieeguefgudffvdfftdefheeijedthfej
    keenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:elrKZO83rej7jkaSslHPkmR85v0hMMBOLZC3hYDFgSc8olcOsCM5vA>
    <xmx:elrKZBtPmcDwmB4u0y8y7x7yPZH-3ClBhZdVk6rbWvzzLMtIjS-jBA>
    <xmx:elrKZNGMI5aF4hKwGSWpkQpgm3oNWtIkTMrjnZ_bbae8SdEReX_3QQ>
    <xmx:elrKZC-zxzZue8PoCY3i8TeFkgUHvjd3-_cZ1CJQwuBxBOnc0vycqg>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Aug 2023 09:30:33 -0400 (EDT)
Date: Wed, 2 Aug 2023 16:30:30 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Petr Machata <petrm@nvidia.com>, vladimir.oltean@nxp.com
Cc: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, razor@blackwall.org,
	mirsad.todorovac@alu.unizg.hr
Subject: Re: [PATCH net 10/17] selftests: forwarding: ethtool_mm: Skip when
 using veth pairs
Message-ID: <ZMpadrHS4Sp3zE9F@shredder>
References: <20230802075118.409395-1-idosch@nvidia.com>
 <20230802075118.409395-11-idosch@nvidia.com>
 <20230802105243.nqwugrz5aof5fbbk@skbuf>
 <87fs51eig3.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fs51eig3.fsf@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 02, 2023 at 02:27:49PM +0200, Petr Machata wrote:
> 
> Vladimir Oltean <vladimir.oltean@nxp.com> writes:
> 
> > Hi Ido,
> >
> > On Wed, Aug 02, 2023 at 10:51:11AM +0300, Ido Schimmel wrote:
> >> MAC Merge cannot be tested with veth pairs, resulting in failures:
> >> 
> >>  # ./ethtool_mm.sh
> >>  [...]
> >>  TEST: Manual configuration with verification: swp1 to swp2          [FAIL]
> >>          Verification did not succeed
> >> 
> >> Fix by skipping the test when used with veth pairs.
> >> 
> >> Fixes: e6991384ace5 ("selftests: forwarding: add a test for MAC Merge layer")
> >> Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> >> Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
> >> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> >> Reviewed-by: Petr Machata <petrm@nvidia.com>
> >> Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> >> ---
> >
> > That will skip the selftest just for veth pairs. This will skip it for
> > any device that doesn't support the MAC Merge layer:
> >
> > diff --git a/tools/testing/selftests/net/forwarding/ethtool_mm.sh b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
> > index c580ad623848..5432848a3c59 100755
> > --- a/tools/testing/selftests/net/forwarding/ethtool_mm.sh
> > +++ b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
> > @@ -224,6 +224,8 @@ h1_create()
> >  		hw 1
> >
> >  	ethtool --set-mm $h1 pmac-enabled on tx-enabled off verify-enabled off
> > +
> > +	h1_created=yes
> >  }
> >
> >  h2_create()
> > @@ -236,10 +238,16 @@ h2_create()
> >  		queues 1@0 1@1 1@2 1@3 \
> >  		fp P E E E \
> >  		hw 1
> > +
> > +	h2_created=yes
> >  }
> >
> >  h1_destroy()
> >  {
> > +	if ! [[ $h1_created = yes ]]; then
> > +		return
> > +	fi
> > +
> >  	ethtool --set-mm $h1 pmac-enabled off tx-enabled off verify-enabled off
> >
> >  	tc qdisc del dev $h1 root
> > @@ -249,6 +257,10 @@ h1_destroy()
> >
> >  h2_destroy()
> >  {
> > +	if ! [[ $h2_created = yes ]]; then
> > +		return
> > +	fi
> > +
> >  	tc qdisc del dev $h2 root
> >
> >  	ethtool --set-mm $h2 pmac-enabled off tx-enabled off verify-enabled off
> > @@ -266,6 +278,14 @@ setup_prepare()
> >  	h1=${NETIFS[p1]}
> >  	h2=${NETIFS[p2]}
> >
> > +	for netif in ${NETIFS[@]}; do
> > +		ethtool --show-mm $netif 2>&1 &> /dev/null
> > +		if [[ $? -ne 0 ]]; then
> > +			echo "SKIP: $netif does not support MAC Merge"
> > +			exit $ksft_skip
> > +		fi
> > +	done
> > +
> 
> Ido, if you decide to go this route, just hoist the loop to the global
> scope before registering the trap, then you don't need tho hX_created
> business.

I think the idea was to run this check after verifying that ethtool
supports MAC Merge in setup_prepare(). How about moving all these checks
before doing any configuration and registering a trap handler?

diff --git a/tools/testing/selftests/net/forwarding/ethtool_mm.sh b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
index 4331e2161e8d..39e736f30322 100755
--- a/tools/testing/selftests/net/forwarding/ethtool_mm.sh
+++ b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
@@ -258,11 +258,6 @@ h2_destroy()
 
 setup_prepare()
 {
-       check_ethtool_mm_support
-       check_tc_fp_support
-       require_command lldptool
-       bail_on_lldpad "autoconfigure the MAC Merge layer" "configure it manually"
-
        h1=${NETIFS[p1]}
        h2=${NETIFS[p2]}
 
@@ -278,7 +273,18 @@ cleanup()
        h1_destroy
 }
 
-skip_on_veth
+check_ethtool_mm_support
+check_tc_fp_support
+require_command lldptool
+bail_on_lldpad "autoconfigure the MAC Merge layer" "configure it manually"
+
+for netif in ${NETIFS[@]}; do
+       ethtool --show-mm $netif 2>&1 &> /dev/null
+       if [[ $? -ne 0 ]]; then
+               echo "SKIP: $netif does not support MAC Merge"
+               exit $ksft_skip
+       fi
+done
 
 trap cleanup EXIT

> 
> >  	h1_create
> >  	h2_create
> >  }
> 
> 

