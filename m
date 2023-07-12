Return-Path: <netdev+bounces-17228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A94750DC9
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 18:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2448C28170C
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1191B214FC;
	Wed, 12 Jul 2023 16:15:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B56214E0
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 16:15:11 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4E9199E
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 09:14:53 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id E9C8D5C00D3;
	Wed, 12 Jul 2023 12:14:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 12 Jul 2023 12:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1689178491; x=1689264891; bh=65HYPJVnC3Dun
	dRznANcrTpdyqqmDNHjpqvmQrnP+nU=; b=cWdEMFNEqC8Au0EfKRNw7JCCLNGo0
	IvgSyrZ68knCNfzf5s0OnoYgH1jvBXnbDnjKaxA6sqqMeUu8WmngXq0qXixXAxyV
	X/NVxydIWUYgLwQpJaIk1ReSJAvfEEnTClrSAz2lBw15tOgk3xe0dEQaPhQj2Pgs
	C6fICBpUsh5Yjx1bOXiUVcxZKdGKM/I1cGZijtaRvBZGA3vT9XNBVy5FEXnZsKow
	hM0DkO0xgIL+4fpyed6xXIohcyyRTnGECwA2+VS7NEAPxHvAHUSqnY8+s3WF5E8b
	nCTjiDyue5KbagHo4iXnpuTTfJWxjU+luGOSZ+mkeEc2s9qpXGxtpBMhA==
X-ME-Sender: <xms:e9GuZDV9HPmkNW7ESPM6R76BynOco_41OAekjgWoVXlr69XVX0Pn2A>
    <xme:e9GuZLkJcVQXGV9fLxZqwy4o-CmI-i0qUIry9Srdkg1INboLJuxUorWooRjcurLkm
    8j8pl-B60R4zcQ>
X-ME-Received: <xmr:e9GuZPaxyd4GcobgDXD07ITXT_CkzGlRq8Usw1NdgayRh9CAehFUqr_K72N76M0g_TmeWP7UUCa7cw2qNY1_xivNslA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfedvgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpeehhfdtjedviefffeduuddvffegteeiieeguefgudffvdfftdefheeijedthfej
    keenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:e9GuZOU1b7km81Y_p3ba8uDHvEwG9VwEagtcoyCwgly4avrqrPK3lQ>
    <xmx:e9GuZNl0JWDj5s1MGz91z-fIXpThT1E0901WL4_CVXOnFy6YBVEzJQ>
    <xmx:e9GuZLdS4P1J2sPmshWmLiB_UHJsjHXtBm5A_VnjUtb42w4BctqsLw>
    <xmx:e9GuZOiZgVzAgSXM1LQpS7U697jVu7qQZOT7ebJuALCAyn5d2tmtjA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jul 2023 12:14:50 -0400 (EDT)
Date: Wed, 12 Jul 2023 19:14:46 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	bridge@lists.linux-foundation.org,
	Harry Coin <hcoin@quietfountain.com>
Subject: Re: [PATCH v2 net] bridge: Add extack warning when enabling STP in
 netns.
Message-ID: <ZK7RdhQ6fBkOY/F+@shredder>
References: <20230712154449.6093-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712154449.6093-1-kuniyu@amazon.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 08:44:49AM -0700, Kuniyuki Iwashima wrote:
> When we create an L2 loop on a bridge in netns, we will see packets storm
> even if STP is enabled.
> 
>   # unshare -n
>   # ip link add br0 type bridge
>   # ip link add veth0 type veth peer name veth1
>   # ip link set veth0 master br0 up
>   # ip link set veth1 master br0 up
>   # ip link set br0 type bridge stp_state 1
>   # ip link set br0 up
>   # sleep 30
>   # ip -s link show br0
>   2: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
>       link/ether b6:61:98:1c:1c:b5 brd ff:ff:ff:ff:ff:ff
>       RX: bytes  packets  errors  dropped missed  mcast
>       956553768  12861249 0       0       0       12861249  <-. Keep
>       TX: bytes  packets  errors  dropped carrier collsns     |  increasing
>       1027834    11951    0       0       0       0         <-'   rapidly
> 
> This is because llc_rcv() drops all packets in non-root netns and BPDU
> is dropped.
> 
> Let's add extack warning when enabling STP in netns.
> 
>   # unshare -n
>   # ip link add br0 type bridge
>   # ip link set br0 type bridge stp_state 1
>   Warning: bridge: STP does not work in non-root netns.
> 
> Note this commit will be reverted later when we namespacify the whole LLC
> infra.
> 
> Fixes: e730c15519d0 ("[NET]: Make packet reception network namespace safe")
> Suggested-by: Harry Coin <hcoin@quietfountain.com>
> Link: https://lore.kernel.org/netdev/0f531295-e289-022d-5add-5ceffa0df9bc@quietfountain.com/
> Suggested-by: Ido Schimmel <idosch@idosch.org>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

