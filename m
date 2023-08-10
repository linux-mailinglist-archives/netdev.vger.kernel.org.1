Return-Path: <netdev+bounces-26434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D78CC777BDC
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143801C215C0
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9680D200DF;
	Thu, 10 Aug 2023 15:08:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF7F1E1A2
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 15:08:39 +0000 (UTC)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE55426A6
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:08:38 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 6C031320093D;
	Thu, 10 Aug 2023 11:08:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 10 Aug 2023 11:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1691680113; x=1691766513; bh=MpD+eoPCJwkHI
	BXe8HrzlAQoNe4GtcLMA9mcKVj9RZ8=; b=v/7A5J+hFF8kFUnOnLlML7kL8kDMt
	OkD4jwBfQr7bUzgsSvZRzN5Ak37//OCiEiODT5GsDf+siRda3R2BHM7gERo4nRLD
	/2my67+AApTK9CgJgje72iBv5f+NSywJKF6Dc3R8wnpEeGN+YD1MoRQNd6gb24+E
	eF2aD7IRYNj3fYIYhA65ZgDl0asdyeNbO12xGOWrayGiEU0/7BCcYtel+hsSyXhW
	b+UWQ2Ppob/kg2xD97ueU5ryIvdUkWi6Ig40jxfg9jHVQINmlUPRVADm+uOTwy+u
	qxbdDdYjbLHUrbC4pF2ALB6cmPvHl42n1ekyhj9BGWuoSimTsNhIWQ4Dg==
X-ME-Sender: <xms:cf3UZPTKZvFqPPkIWmjYuNObHUIktkBE8ruGRFPVRHO0xiVA1wKSMg>
    <xme:cf3UZAy-ARyDDhIS7_MDiK06-KIFHif7ItjdTDbH0zg5M-w52KsCi5w-PEYR0xTiM
    UN5hjJBJVKGVGQ>
X-ME-Received: <xmr:cf3UZE0L7Q-4nv0LSGcUZ9hgoO2gL6KWTJMBSQV4brvvsT_V9qU5NnknVt7T6NfnjEZbNyRUoieQhPQNrl61dJ85MXThjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleeigdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpeehhfdtjedviefffeduuddvffegteeiieeguefgudffvdfftdefheeijedthfej
    keenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:cf3UZPBp9DV8Wn-F72HlqRyfIzPxWMshf8TwE8bVJdI-Ut_fav4TsQ>
    <xmx:cf3UZIh_wpWDPoAknfNHuGls68dNvkcJkcq1ki5qA10sxKOoaqjI1A>
    <xmx:cf3UZDoZq4RCsIKucYErA5ztm3NTAESt1TInjnNe8zheAvJZmRyqAw>
    <xmx:cf3UZBVh2Rvn3xZRTKhw-Y5xkH7QY7pc3p9GVVvqXtq8y8NSK7dLPA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Aug 2023 11:08:32 -0400 (EDT)
Date: Thu, 10 Aug 2023 18:08:28 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Thomas Haller <thaller@redhat.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCHv2 net-next 2/2] ipv4/fib: send notify when delete source
 address routes
Message-ID: <ZNT9bPpuCLVY7nnP@shredder>
References: <20230809140234.3879929-1-liuhangbin@gmail.com>
 <20230809140234.3879929-3-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809140234.3879929-3-liuhangbin@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 10:02:34PM +0800, Hangbin Liu wrote:
> After deleting an interface address in fib_del_ifaddr(), the function
> scans the fib_info list for stray entries and calls fib_flush() and
> fib_table_flush(). Then the stray entries will be deleted silently and no
> RTM_DELROUTE notification will be sent.
> 
> This lack of notification can make routing daemons like NetworkManager,
> miss the routing changes. e.g.

[...]

> To fix this issue, let's add a new bit in "struct fib_info" to track the
> deleted prefer source address routes, and only send notify for them.

In the other thread Thomas mentioned that NM already requests a route
dump following address deletion [1]. If so, can Thomas or you please
explain how this patch is going to help NM? Is the intention to optimize
things and avoid the dump request (which can only work on new kernels)?

[1] https://lore.kernel.org/netdev/07fcfd504148b3c721fda716ad0a549662708407.camel@redhat.com/

