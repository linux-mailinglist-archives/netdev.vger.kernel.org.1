Return-Path: <netdev+bounces-137267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDD59A538E
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 12:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB5C282A84
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 10:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6166182877;
	Sun, 20 Oct 2024 10:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mO5Ckfux"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E232B28689
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 10:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729421721; cv=none; b=DcUd+N376y+zvdN3YiyF6Oe5mTMauyBzbYwAOhPqbFJXkIf10s2NtRA92F/RfbKuAnzvzLUpFACCiIY18fsEf3cmQRP6uu7E5qawNAEFWmyixtDmkCtIDPwHwv9BwsBtajcSV/CWSro+oQjy83a3YB8e9U0u3kOVto+pwJ2C8ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729421721; c=relaxed/simple;
	bh=tjOVzTeUrmLERFlysrHs39Q/vDMVBXn166qckYr8zJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0cXqi8j4ff93hYEpw6gCA5Q3r61EOYeuT5SykbVribaWv5yBYmwsRzlout5qsJryG9p6t/qtJYI/ubFQNpwBYeg6SZ2TnhmgniP3lwVlA1BmQ5rOo8Oas9yH6Gj9JaoNrdvCEUMVVDgGD29DiMkMnQ1cUdLHYY7bJQ6Ly/wc+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mO5Ckfux; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CD6A511400F8;
	Sun, 20 Oct 2024 06:55:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 20 Oct 2024 06:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729421715; x=
	1729508115; bh=KTXUqIoWyAjcTWVZwHLhbXFXe6F8clZldtIUa6GKjx0=; b=m
	O5CkfuxF/tHYizfig+YvAdKuFuvaYhowNpQYAF9qVpnIsv6ogklG+uQu7K+tt/MH
	TJJY1fLqlkwBOaJ0la2kOvfc+hyQyGNhOGVvAQxz9pgnDSs3uILnB0H/BX/29PsB
	BbQI4NhmDfCSC3y1n+pgKYuB8fE+EIZNs3ihQ6Xd75fXM8FjME3pyJV3wgzaJe7X
	iOLaODIEy4gQp+ixr+roH8YQ+mFw/SyAKUwr5HWF5Dm3H0u+LYwmu3/oa36dfjZX
	KP00t/NsCvQAPZ1P7Xw6UceJGwc3mSAjUuHoFIAVsJEgAmbbohunnY0NxBublADN
	XRMRdpEWtEVoG3RtmHxpQ==
X-ME-Sender: <xms:k-EUZ01HoDGc8whJaJp9-v5mLYJJKf6QamgIg8HOZ7NYpZYCMkonfQ>
    <xme:k-EUZ_GlP-rLXdRkbeAa2RZvH1Ltf0Ze0V_x1V_3WroNSjAc3BMchBEwSnb57dL-V
    B8_ACTBm9w8Gx0>
X-ME-Received: <xmr:k-EUZ86FvNs0spQ7iBbpYH1SSHcd3FkevK4g_LU3cSS1-yVI59C59VNcYbAj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehjedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpefgvdekudfggeeitdeffeegueehvdeifeeffefg
    ledvteeuffegtdejleegvdffueenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghh
    sehiughoshgthhdrohhrghdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepohhmihgurdgvhhhtvghmrghmhhgrghhhihhghhhisehmvghnlhho
    shgvtghurhhithihrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprggurhhirghnrdholhhivhgvrhesmhgvnhhlohhs
    vggtuhhrihhthidrtghomhdprhgtphhtthhopehkvghrnhgvlhesrgholhhivhgvrhdrtg
    grpdhrtghpthhtohepughsrghhvghrnhesghhmrghilhdrtghomhdprhgtphhtthhopegv
    ughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhunhhihihusegrmh
    griihonhdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:k-EUZ914RzLdDKqKtj2-alebwiKjg26lEGXyprgsEWwTmK944XFF5Q>
    <xmx:k-EUZ3HIBO1ly9XrkIql5eyXmG5_UmxUKZCPzyCCQ8H0hQSO2MRUFw>
    <xmx:k-EUZ296MX4Ybk7aYouOCk8-VpwZ-jgc-o_oTvfytK5eK4ZyWCzCRQ>
    <xmx:k-EUZ8lsAsLGMaR9jH9xDEk7xKvpefoBkKSIlZLylk5XchY4hPjSgg>
    <xmx:k-EUZ22OEn06fcbTzK4ucK8OpCEZ9VuHO0QFYogePY8hq_Hu0KBgg-5K>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Oct 2024 06:55:14 -0400 (EDT)
Date: Sun, 20 Oct 2024 13:55:13 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>
Cc: netdev@vger.kernel.org, adrian.oliver@menlosecurity.com,
	Adrian Oliver <kernel@aoliver.ca>, David Ahern <dsahern@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v5] ipv6: Fix soft lockups in fib6_select_path under
 high next hop churn
Message-ID: <ZxThkZZBCAnuJf8Y@shredder.mtl.com>
References: <20241019034958.197329-1-omid.ehtemamhaghighi@menlosecurity.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241019034958.197329-1-omid.ehtemamhaghighi@menlosecurity.com>

On Fri, Oct 18, 2024 at 08:49:58PM -0700, Omid Ehtemam-Haghighi wrote:
> Soft lockups have been observed on a cluster of Linux-based edge routers
> located in a highly dynamic environment. Using the `bird` service, these
> routers continuously update BGP-advertised routes due to frequently
> changing nexthop destinations, while also managing significant IPv6
> traffic. The lockups occur during the traversal of the multipath
> circular linked-list in the `fib6_select_path` function, particularly
> while iterating through the siblings in the list. The issue typically
> arises when the nodes of the linked list are unexpectedly deleted
> concurrently on a different core—indicated by their 'next' and
> 'previous' elements pointing back to the node itself and their reference
> count dropping to zero. This results in an infinite loop, leading to a
> soft lockup that triggers a system panic via the watchdog timer.
> 
> Apply RCU primitives in the problematic code sections to resolve the
> issue. Where necessary, update the references to fib6_siblings to
> annotate or use the RCU APIs.
> 
> Include a test script that reproduces the issue. The script
> periodically updates the routing table while generating a heavy load
> of outgoing IPv6 traffic through multiple iperf3 clients. It
> consistently induces infinite soft lockups within a couple of minutes.

[...]

> Fixes: 66f5d6ce53e6 ("ipv6: replace rwlock with rcu and spinlock in fib6_table")
> Reported-by: Adrian Oliver <kernel@aoliver.ca>
> Tested-by: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>
> Signed-off-by: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>

You can drop your Tested-by given you authored the patch. It's implicit.

> Cc: David Ahern <dsahern@gmail.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Ido Schimmel <idosch@idosch.org>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: Paolo Abeni <pabeni@redhat.com>

Please use scripts/get_maintainer.pl to get the full list of people to
copy.

[...]

> @@ -5195,14 +5195,18 @@ static void ip6_route_mpath_notify(struct fib6_info *rt,
>  	 * nexthop. Since sibling routes are always added at the end of
>  	 * the list, find the first sibling of the last route appended
>  	 */
> +	rcu_read_lock();
> +
>  	if ((nlflags & NLM_F_APPEND) && rt_last && rt_last->fib6_nsiblings) {
> -		rt = list_first_entry(&rt_last->fib6_siblings,
> -				      struct fib6_info,
> -				      fib6_siblings);
> +		rt = list_first_or_null_rcu(&rt_last->fib6_siblings,
> +					    struct fib6_info,
> +					    fib6_siblings);
>  	}
>  
>  	if (rt)
>  		inet6_rt_notify(RTM_NEWROUTE, rt, info, nlflags);

Ran your test with a debug config [1] and got the following splat [2].
Fixed by [3]. Beside ip6_route_mpath_notify() all the callers of
inet6_rt_notify() already call it from an atomic context.

> +
> +	rcu_read_unlock();
>  }

[1] https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style

[2]
BUG: sleeping function called from invalid context at include/linux/sched/mm.h:321
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 3730, name: ip
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
2 locks held by ip/3730:
 #0: ffffffff86fc7c30 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x377/0xf60
 #1: ffffffff8655b3e0 (rcu_read_lock){....}-{1:2}, at: ip6_route_mpath_notify+0x75/0x330
CPU: 5 UID: 0 PID: 3730 Comm: ip Tainted: G        W          6.12.0-rc3-custom-virtme-g38827a50efa3 #134
Tainted: [W]=WARN
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
Call Trace:
 <TASK>
 dump_stack_lvl+0xba/0x110
 __might_resched.cold+0x1ed/0x253
 kmem_cache_alloc_node_noprof+0x2ab/0x310
 __alloc_skb+0x2da/0x3a0
 inet6_rt_notify+0xf6/0x2a0
 ip6_route_mpath_notify+0x12c/0x330
 ip6_route_multipath_add+0xcc7/0x1f70
 inet6_rtm_newroute+0xfb/0x170
 rtnetlink_rcv_msg+0x3cc/0xf60
 netlink_rcv_skb+0x171/0x450
 netlink_unicast+0x539/0x7f0
 netlink_sendmsg+0x8c1/0xd80
 ____sys_sendmsg+0x8f9/0xc20
 ___sys_sendmsg+0x197/0x1e0
 __sys_sendmsg+0x122/0x1f0
 do_syscall_64+0xbb/0x1d0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

[3]
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index d1065a0edc19..b9b986bda943 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6192,7 +6192,7 @@ void inet6_rt_notify(int event, struct fib6_info *rt, struct nl_info *info,
        err = -ENOBUFS;
        seq = info->nlh ? info->nlh->nlmsg_seq : 0;
 
-       skb = nlmsg_new(rt6_nlmsg_size(rt), gfp_any());
+       skb = nlmsg_new(rt6_nlmsg_size(rt), GFP_ATOMIC);
        if (!skb)
                goto errout;
 
@@ -6205,7 +6205,7 @@ void inet6_rt_notify(int event, struct fib6_info *rt, struct nl_info *info,
                goto errout;
        }
        rtnl_notify(skb, net, info->portid, RTNLGRP_IPV6_ROUTE,
-                   info->nlh, gfp_any());
+                   info->nlh, GFP_ATOMIC);
        return;
 errout:
        rtnl_set_sk_err(net, RTNLGRP_IPV6_ROUTE, err);

[...]

> diff --git a/tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh b/tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh
> new file mode 100755
> index 000000000000..d257fbf0b0a3
> --- /dev/null
> +++ b/tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh

[...]

> +	# Check if any iperf3 instances are still running. This could occur if a core has entered an infinite loop and
> +	# the timeout for the soft lockup to be detected has not expired yet, but either the test interval has already
> +	# elapsed or the test is terminated manually (Ctrl+C)

I didn't thoroughly review the test and only ran it to make sure it's
passing, but I suggest wrapping some of the comments there to 80
characters to avoid checkpatch warnings.

