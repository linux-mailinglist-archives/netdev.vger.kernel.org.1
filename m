Return-Path: <netdev+bounces-35410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 924007A9636
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 057EF1C20B74
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 17:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F705199DD;
	Thu, 21 Sep 2023 16:59:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF377F2
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 16:59:57 +0000 (UTC)
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854CF1BD1;
	Thu, 21 Sep 2023 09:57:09 -0700 (PDT)
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Thu, 21 Sep 2023 09:29:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1695281357; bh=JrvLZ3k9m+n64XkQmbpSU7bQlFJHydepu1VAgRC4fjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NMB2AQTpZscNAsuFSRfZScH0ybRFIyIeR53TSy4h86jjz5qDM+IzU+FIw2oL/NPcl
	 zhnc8wxUO+ZdzqqQLZ5HFVD3mlxjE1z4ClyazOPfmM3gJPEuiEQScC5o5xl2i2QhPt
	 qFtFi76Fs4cMWLI6YWP2dAXrJ9tB8LL8+dqewJFg=
Received: from localhost (unknown [172.17.88.63])
	by mail-auth.avm.de (Postfix) with ESMTPSA id 29320800AA;
	Thu, 21 Sep 2023 09:29:17 +0200 (CEST)
Date: Thu, 21 Sep 2023 09:29:17 +0200
From: Johannes Nixdorf <jnixdorf-oss@avm.de>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	David Ahern <dsahern@gmail.com>, Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <linux@rempel-privat.de>,
	Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/6] net: bridge: Add netlink knobs for
 number / max learned FDB entries
Message-ID: <ZQvwzZrqC7pjaeS1@u-jnixdorf.ads.avm.de>
References: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
 <20230919-fdb_limit-v4-4-39f0293807b8@avm.de>
 <f5aca33e-693f-9d8d-c45a-41ada00a9f03@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5aca33e-693f-9d8d-c45a-41ada00a9f03@blackwall.org>
X-purgate-ID: 149429::1695281356-9EC789BA-37F48EE5/0/0
X-purgate-type: clean
X-purgate-size: 786
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 01:50:32PM +0300, Nikolay Aleksandrov wrote:
> On 9/19/23 11:12, Johannes Nixdorf wrote:
> > [...]
> > diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> > index 505683ef9a26..f5d49a05e61b 100644
> > --- a/net/bridge/br_netlink.c
> > +++ b/net/bridge/br_netlink.c
> > @@ -1267,6 +1267,8 @@ static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
> >   	[IFLA_BR_VLAN_STATS_PER_PORT] = { .type = NLA_U8 },
> >   	[IFLA_BR_MULTI_BOOLOPT] =
> >   		NLA_POLICY_EXACT_LEN(sizeof(struct br_boolopt_multi)),
> > +	[IFLA_BR_FDB_N_LEARNED] = { .type = NLA_U32 },
> 
> hmm? I thought this one was RO.

You are right. I set this to NLA_REJECT locally for v5 now, analogously
to how IFLA_BRPORT_MCAST_N_GROUPS is specified.

> > [...]

