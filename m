Return-Path: <netdev+bounces-20461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE46575FA1C
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 16:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E21D1C20B83
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 14:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2635C747E;
	Mon, 24 Jul 2023 14:45:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B329566E
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 14:45:55 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547CB19A;
	Mon, 24 Jul 2023 07:45:53 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 0D4FB5C0061;
	Mon, 24 Jul 2023 10:45:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 24 Jul 2023 10:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1690209950; x=1690296350; bh=JonMW/RttbU7c
	j/gvymAJ0f+J/+wO0y76uBsx5y83Q0=; b=ZP/iFU+u97xsr5Ff/zAD0vtdCWaZc
	3IAKV2Bl8nfQDpPrSgkROFCLiKHUsyvFqmUB1KkRc/iUUZoNieb8vjFOElEmUYn0
	J0J6x3iqxtECaytroUsibWlzDPTd508iNzX9ehDhCa2K4e/309He3JrknrN5S0yn
	NsRoSwSakt1aCnFldyo2q6ADge5GSadAmGtUMlVhtU5pGEjt69C4+ql8ISUsd0qZ
	uDHqCHy+p+/SVahhmOyARsnCZLixeexXeLJ3cfxJFkpBvv3xGm7kI+iw6H0ID2Rk
	9+xxlVWFMAfv7ziVoJxUUOz5FI7ImsJPtEbZAe37Ecy5P08Ae55LIQKlg==
X-ME-Sender: <xms:nI6-ZOebbLoTjQAT2sEQD4qJKPN91Q4h2JfxMD7AdG0yVSSeVK7W5A>
    <xme:nI6-ZIMHOkfTFx_DrRy2-YgqeGOGhW-QumkJc-iBoFIheQV-mQmZkVIUT4vI6e1eW
    1_0iEB8ubeimUM>
X-ME-Received: <xmr:nI6-ZPg8mfS5zSHw2p8YtxrUDdMTnkYloDt5PQUB72pFWlmPvhH5ie-Agz2u>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrheekgdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpefhffejgefhjeehjeevheevhfetveevfefgueduueeivdeijeeihfegheeljefg
    ueenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:nI6-ZL8xiVtSdcB66pDPAXaki2vHz3LAcyMrxdFwRPPN1QhkQ6EzMA>
    <xmx:nI6-ZKuMc_ZB2sYWweCJWahCalcp8ogShGTGZPFNd41taVJNCROjDA>
    <xmx:nI6-ZCEjHzgKWKS_tKVXiaN64HMVc1k35zT_L8lFOX3ol3ACMhggfQ>
    <xmx:no6-ZH94kAPqKB4shfcVnahLg4WRDm4qcmGjzQoxkLsNvFaghn8aIw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Jul 2023 10:45:47 -0400 (EDT)
Date: Mon, 24 Jul 2023 17:45:42 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v1 01/11] selftests: forwarding:
 custom_multipath_hash.sh: add cleanup for SIGTERM sent by timeout
Message-ID: <ZL6OljQubhVtQjcD@shredder>
References: <20230722003609.380549-1-mirsad.todorovac@alu.unizg.hr>
 <ZLzj5oYrbHGvCMkq@shredder>
 <0550924e-dce9-f90d-df8a-db810fd2499f@alu.unizg.hr>
 <adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jul 23, 2023 at 11:37:46PM +0200, Mirsad Todorovac wrote:
> Some tests however exited with error:
> 
> marvin@defiant:~/linux/kernel/linux_torvalds$ grep "not ok" ../kselftest-6.5-rc2-net-forwarding-11.log
> not ok 3 selftests: net/forwarding: bridge_mdb.sh # exit=1
> not ok 5 selftests: net/forwarding: bridge_mdb_max.sh # exit=1
> not ok 11 selftests: net/forwarding: bridge_vlan_mcast.sh # exit=1

I can't reproduce these three.

Do you have systemd-networkd running? If so, by default it tries to
take over interfaces unless you tell it not to. For example, on my
system I have:

$ cat /etc/systemd/network/10-ignore.link 
[Match]
OriginalName=*

[Link]
MACAddressPolicy=none

This tells systemd not to assign a persistent MAC address on virtual
interfaces.

And (redacted):

$ cat /etc/systemd/network/80-dhcp.network 
[Match]
...

This tells systemd to only manage the interfaces matching the match
criteria and ignore the rest.

> not ok 15 selftests: net/forwarding: ethtool_extended_state.sh # exit=1
> not ok 17 selftests: net/forwarding: ethtool.sh # exit=1
> not ok 25 selftests: net/forwarding: hw_stats_l3_gre.sh # exit=1

Fixed these three.

> not ok 26 selftests: net/forwarding: ip6_forward_instats_vrf.sh # exit=1

Fixed.

> not ok 80 selftests: net/forwarding: tc_actions.sh # exit=1
> not ok 83 selftests: net/forwarding: tc_flower.sh # exit=1
> not ok 84 selftests: net/forwarding: tc_flower_l2_miss.sh # exit=1
> not ok 89 selftests: net/forwarding: tc_tunnel_key.sh # exit=1

Can't reproduce these.

Pushed the fixes on top of the fixes from yesterday:

https://github.com/idosch/linux/commits/submit/sefltests_fix_v1

