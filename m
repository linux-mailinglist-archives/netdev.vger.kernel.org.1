Return-Path: <netdev+bounces-41884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F3B7CC182
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 13:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2FE91C20CC8
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256F94177A;
	Tue, 17 Oct 2023 11:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KZY8H3h/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9019F38FA7
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 11:06:44 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900E1EA;
	Tue, 17 Oct 2023 04:06:43 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 03B355C0312;
	Tue, 17 Oct 2023 07:06:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 17 Oct 2023 07:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697540803; x=1697627203; bh=C2g91EpF8bnTE
	31MfUeHv6PZqy/bsGdqol8WloDU6eA=; b=KZY8H3h/tBfdYVyxwK6V9SBOE4PmN
	pDfZ7iPTqILvMnmOAYaS6vTd50ShLLE681pmAYgcwKBB7IPbjp8Gj7UIGso5KuDc
	AtQibc8s6ESRmgLDWC6ahvcl9DnDaC64XFR3EqRikoEMsOFKZ/sY3KnyTE2J6EQD
	zNU7thKlnVWnUH75QTzwExR70jw0ZxYEgNg7ZHh1FCc6LfEHecRAz9jDswzIyZCt
	POKzNeguHFE4pbUSbUSF0I93PDJHf0BiqNiMPm2WfiucrUWD8k1KSW5nlXnUvvea
	75ozhkM7xUHDBD0e7urS9GtsVUCaKuLbXDFGpPWPRzYU9MxX+krQ3F15w==
X-ME-Sender: <xms:wmouZfdKN6FlycrVMbLu_O3bAZO4JaCW9UGSH7MAxov0_FDizFkogw>
    <xme:wmouZVPxjud5no2ROux1M8Oa3Z7kPcrY3xyaAj3hKhss-Z-AcEJQ4UHmz_OVYWywA
    LQVjVjfJJZ6OqE>
X-ME-Received: <xmr:wmouZYiqkW5hQB-L-UKe23fSsEGnaHWj_wn-DhnuPm9xmWO1yE4yHJVRoVOBVMZE3jYatfpEGRPrbngcJ6FENFXVylU68g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjedvgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:wmouZQ84f13oKCo8CfDRKQ1toUj02h8k-v6_ToZMDlqwxGGgoVq9cA>
    <xmx:wmouZbscoAdvYzIM6kJavE29JJVxS0gmrGmGVTDOwK9BrfdUdCgabg>
    <xmx:wmouZfHZRkAvHgxqcs2gEh-_T6k9WTgE0GmHAIfmLEPrMF5ep934mQ>
    <xmx:w2ouZTNdZiRrsC36NE4pgZiww-z1v_4e9u-1IdHYMD_kNZmOld0snQ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Oct 2023 07:06:42 -0400 (EDT)
Date: Tue, 17 Oct 2023 14:06:39 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Johannes Nixdorf <jnixdorf-oss@avm.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	David Ahern <dsahern@gmail.com>, Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Oleksij Rempel <linux@rempel-privat.de>,
	Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v5 4/5] net: bridge: Set strict_start_type for
 br_policy
Message-ID: <ZS5qv6WEv5J1tYTU@shredder>
References: <20231016-fdb_limit-v5-0-32cddff87758@avm.de>
 <20231016-fdb_limit-v5-4-32cddff87758@avm.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-fdb_limit-v5-4-32cddff87758@avm.de>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 03:27:23PM +0200, Johannes Nixdorf wrote:
> Set any new attributes added to br_policy to be parsed strictly, to
> prevent userspace from passing garbage.
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

