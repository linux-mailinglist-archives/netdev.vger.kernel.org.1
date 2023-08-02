Return-Path: <netdev+bounces-23719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9573176D50A
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 19:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE53281E45
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1327F9FF;
	Wed,  2 Aug 2023 17:22:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51D8DF66
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 17:22:46 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133791717
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 10:22:37 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 7255A5C0100;
	Wed,  2 Aug 2023 13:22:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 02 Aug 2023 13:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1690996954; x=1691083354; bh=Eka4zEXYLQSnW
	dPeC84EWEvPD4dIQ4U1VX9OAkuvMT0=; b=y+XmrZ6KeH+ygpR79nLE1HrrKefSP
	vzJEMtvjX5z/dc3tDpIvtqUuMtZ7RxrCV+kZI9f1vkKboXwjUe9JjDLUc9q6ivKL
	X9sJS5NxR54kkJbHJrXZth4mwZ6Xmyqay+06JGnp1KwHNORVTczBE5Gzji4byqCV
	tLYXrJIjIyIY1DGtgPVpbil7GihtqJpURNQLxbvodCsLZXVVKT4alDoCLxz8a71M
	eMdVUoHnQ9GF3YH9vpDYMU73EQmszQfYQPvCmwfS7b8rnNPVrLEk1lg0Xn5/jRNF
	Vxxum6wVcDuYrO4Ow71jjSoGuEE1J3S6e4hxz666OybdV/tWflvcJmFYw==
X-ME-Sender: <xms:2pDKZMwW0UizNKVp0gpTv0R6Q_qLxPIg5r8YArc7JhxK94YYcmMPqg>
    <xme:2pDKZAQZiA_7ahiijazQjZSYsN9rAZswPmPbCONBe5Ptml8Nmazw_HQZ34AKsMgz3
    1rh-LTxPRJdiec>
X-ME-Received: <xmr:2pDKZOWWfGJGeZ991HZMDQJwOGdGwXWJtEG5MDij2ipSvB-SY0M0UnNPqgDpQlYxzfEv4C-Ap_QvU7bKlC4iHYRMPu0BrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkedtgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:2pDKZKhpndTgWB_AhxKK0Sz-wChzKPWO8RE20-f9o_dXit6z1QscOA>
    <xmx:2pDKZOCwFkd7KxBrgyRfm3Bg3785FkguqwSz3YSZb81c7QNseKDwXQ>
    <xmx:2pDKZLIr-XZO1oem4i2XgOGcu4ypDDK2WY5d2mW_dNu2axno-XdWnQ>
    <xmx:2pDKZJOVpNw9Y_Doib2LFq2zFCAY59lrZwnc7eOTo7Wmi11G0RAoFw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Aug 2023 13:22:33 -0400 (EDT)
Date: Wed, 2 Aug 2023 20:22:29 +0300
From: Ido Schimmel <idosch@idosch.org>
To: David Ahern <dsahern@gmail.com>
Cc: Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org, stephen@networkplumber.org,
	razor@blackwall.org
Subject: Re: [PATCH iproute2-next] bridge: Add backup nexthop ID support
Message-ID: <ZMqQ1W+TxoPOAodC@shredder>
References: <20230801152138.132719-1-idosch@nvidia.com>
 <87sf91enuf.fsf@nvidia.com>
 <ZMpNRzXKIS7ZzSVN@shredder>
 <16c562ce-433d-ac78-95ad-101bef710efc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16c562ce-433d-ac78-95ad-101bef710efc@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 02, 2023 at 09:35:12AM -0600, David Ahern wrote:
> ugh, please send a fix.

Will send a fix tomorrow. Seems to be fixed by [1], but we might need
something similar for the bucket dump.

[1]
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 93f14d39fef6..1bd92acbc6c5 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3170,7 +3170,7 @@ static int nh_valid_dump_req(const struct nlmsghdr *nlh,
 }
 
 struct rtm_dump_nh_ctx {
-       u32 idx;
+       u64 idx;
 };
 
 static struct rtm_dump_nh_ctx *
@@ -3192,7 +3192,7 @@ static int rtm_dump_walk_nexthops(struct sk_buff *skb,
                                  void *data)
 {
        struct rb_node *node;
-       int s_idx;
+       u64 s_idx;
        int err;
 
        s_idx = ctx->idx;

