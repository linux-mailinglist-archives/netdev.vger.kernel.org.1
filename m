Return-Path: <netdev+bounces-124053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DABB967B76
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 19:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD55E1F2142F
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 17:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4FC183087;
	Sun,  1 Sep 2024 17:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U5f3XyFF"
X-Original-To: netdev@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24593B79C
	for <netdev@vger.kernel.org>; Sun,  1 Sep 2024 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725211552; cv=none; b=dKcjkfLe9tQFrCYfe8OJeZhYOSOjAhPDp2ks6pDNP2vPyHGXgM8HYKKGF1qDpXLqzLUeBQob0XBQ7Yf3qVixPW9YCo0SbXba8meE4ssu+FuUaUFNAiOPXj9iS6AOaPBO5L2ynUKEfA+S7ZUxAMVe6u4JvKd5kPSsjj14IwbkVx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725211552; c=relaxed/simple;
	bh=kDFpK5vE4/kZq/p8s8G7MO9+8ntZfo83TIaVcX1fxlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8Ibfy3E/tqX5z3Xlh+SWVquz+WkO7lEPo0eWrhvM93F1D+cCXRr2pmzdXSaF+YX/WpD80Qw3PGjMJOly1WqkXm4lyw/ydk95aLO+CcYlBzT6MbiSBigekqdSgbVudCdkXquDJADVE022M4ccjt0TU+JXC8kMGraqwL0oafJ++Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U5f3XyFF; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id CB99413801FF;
	Sun,  1 Sep 2024 13:25:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 01 Sep 2024 13:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725211548; x=
	1725297948; bh=Qj35xw4PIX7cqpLGUDG9Gv3VFYTxMXffDVXWswylcUQ=; b=U
	5f3XyFFgtvVFfRHQRcvxf5HHoKFrPdiVb5qaK621rzcpe/cgNRL5VqgmflQPvBhe
	ROflGAhwnTN/e9euFuCo06Lmrla+TLb1PeKNcfko4wZLjOKD8txupmO46u1GIWqO
	PXAwYIxvryZb1p60MCspiwOYvevM80NabTXfY4ucv7W2MPB63o4+bDCPbjXc8Fj+
	cR7rJESBLJB2f5hT3/g4wW6goPDjTCvi1mnicIyLL2TjzCBT3MZUgetX18Dg4ADm
	zlRlQUTOeHCPgX4BarasdfHESbcIg7Mv4gFNkzFoUqIA+AXlxqoolsZshzssk4wf
	8NoBsssYr36Xr8Qm+DMiA==
X-ME-Sender: <xms:nKPUZlK1YGLF3P71FsGTSzZ82n5htvyWQlSjirpPv8pmVQyl9LDYUQ>
    <xme:nKPUZhL8olF79b0tfcnkkDSlhV7y73n9U0C8hNOyhC_H78ka4WCH181MHWYo1kFkf
    EwW2vzoERTeVLA>
X-ME-Received: <xmr:nKPUZtvX1SRDKSq-amoOGsZDtyEjDg-ITTgrJXPo1C4CoipOV2rrUVOcbyz0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudegjedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpeduledvjeejhefgvdetheefheetjeejfeetjeev
    ieejgfeujeffleffgeekffeuieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghh
    sehiughoshgthhdrohhrghdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepohhmihgurdgvhhhtvghmrghmhhgrghhhihhghhhisehmvghnlhho
    shgvtghurhhithihrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepughsrghhvghrnhesghhmrghilhdrtghomhdprhgt
    phhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprggurh
    hirghnrdholhhivhgvrhesmhgvnhhlohhsvggtuhhrihhthidrtghomh
X-ME-Proxy: <xmx:nKPUZmYWw_sFoXFxhsuBh_ntZNFbWpWRhbDlDrilDz-txIWzP3oU3Q>
    <xmx:nKPUZsbxe87bzipUP9u7pRhKmh54GVVHN20diT3K0vqN8luWnekv9w>
    <xmx:nKPUZqBxbF0byi8mH22FnlvPviLD90jokE-Q6NmVHqtO2m4Wf3--VA>
    <xmx:nKPUZqayXyfGdyAJlTTOIRVJAFg_T_EAEpDbGJO8HBKzlWcyU4zfqA>
    <xmx:nKPUZjWwOsRFHsxQKQbjV2spEkbKrNRNWpgi_xilCpGIg7fIZegtIoZK>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Sep 2024 13:25:48 -0400 (EDT)
Date: Sun, 1 Sep 2024 20:25:46 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, edumazet@google.com,
	adrian.oliver@menlosecurity.com
Subject: Re: [PATCH v3] net/ipv6: Fix soft lockups in fib6_select_path under
 high next hop churn
Message-ID: <ZtSjmgk5olK6sfOE@shredder.mtl.com>
References: <20240829222803.448995-1-omid.ehtemamhaghighi@menlosecurity.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240829222803.448995-1-omid.ehtemamhaghighi@menlosecurity.com>

Subject prefix should be "[PATCH net]". See:

https://docs.kernel.org/process/maintainer-netdev.html

On Thu, Aug 29, 2024 at 03:28:03PM -0700, Omid Ehtemam-Haghighi wrote:
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
> To fix this issue, I applied RCU primitives in the problematic code

Use imperative mood:

https://docs.kernel.org/process/submitting-patches.html#describe-your-changes

> sections, which successfully resolved the issue within our testing
> parameters and in the production environment where the issue was first
> observed. Additionally, all references to fib6_siblings have been updated
> to annotate or use the RCU APIs.
> 
> A test script that reproduces this issue is included with this patch. The
> script periodically updates the routing table while generating a heavy load
> of outgoing IPv6 traffic through multiple iperf3 clients. I have tested
> this script on various machines, ranging from low to high performance, as
> detailed in the comment section of the test script. It consistently induces
> soft lockups within a minute.
> 
> Kernel log:
> 
>  0 [ffffbd13003e8d30] machine_kexec at ffffffff8ceaf3eb
>  1 [ffffbd13003e8d90] __crash_kexec at ffffffff8d0120e3
>  2 [ffffbd13003e8e58] panic at ffffffff8cef65d4
>  3 [ffffbd13003e8ed8] watchdog_timer_fn at ffffffff8d05cb03
>  4 [ffffbd13003e8f08] __hrtimer_run_queues at ffffffff8cfec62f
>  5 [ffffbd13003e8f70] hrtimer_interrupt at ffffffff8cfed756
>  6 [ffffbd13003e8fd0] __sysvec_apic_timer_interrupt at ffffffff8cea01af
>  7 [ffffbd13003e8ff0] sysvec_apic_timer_interrupt at ffffffff8df1b83d
> -- <IRQ stack> --
>  8 [ffffbd13003d3708] asm_sysvec_apic_timer_interrupt at ffffffff8e000ecb
>     [exception RIP: fib6_select_path+299]
>     RIP: ffffffff8ddafe7b  RSP: ffffbd13003d37b8  RFLAGS: 00000287
>     RAX: ffff975850b43600  RBX: ffff975850b40200  RCX: 0000000000000000
>     RDX: 000000003fffffff  RSI: 0000000051d383e4  RDI: ffff975850b43618
>     RBP: ffffbd13003d3800   R8: 0000000000000000   R9: ffff975850b40200
>     R10: 0000000000000000  R11: 0000000000000000  R12: ffffbd13003d3830
>     R13: ffff975850b436a8  R14: ffff975850b43600  R15: 0000000000000007
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  9 [ffffbd13003d3808] ip6_pol_route at ffffffff8ddb030c
> 10 [ffffbd13003d3888] ip6_pol_route_input at ffffffff8ddb068c
> 11 [ffffbd13003d3898] fib6_rule_lookup at ffffffff8ddf02b5
> 12 [ffffbd13003d3928] ip6_route_input at ffffffff8ddb0f47
> 13 [ffffbd13003d3a18] ip6_rcv_finish_core.constprop.0 at ffffffff8dd950d0
> 14 [ffffbd13003d3a30] ip6_list_rcv_finish.constprop.0 at ffffffff8dd96274
> 15 [ffffbd13003d3a98] ip6_sublist_rcv at ffffffff8dd96474
> 16 [ffffbd13003d3af8] ipv6_list_rcv at ffffffff8dd96615
> 17 [ffffbd13003d3b60] __netif_receive_skb_list_core at ffffffff8dc16fec
> 18 [ffffbd13003d3be0] netif_receive_skb_list_internal at ffffffff8dc176b3
> 19 [ffffbd13003d3c50] napi_gro_receive at ffffffff8dc565b9
> 20 [ffffbd13003d3c80] ice_receive_skb at ffffffffc087e4f5 [ice]
> 21 [ffffbd13003d3c90] ice_clean_rx_irq at ffffffffc0881b80 [ice]
> 22 [ffffbd13003d3d20] ice_napi_poll at ffffffffc088232f [ice]
> 23 [ffffbd13003d3d80] __napi_poll at ffffffff8dc18000
> 24 [ffffbd13003d3db8] net_rx_action at ffffffff8dc18581
> 25 [ffffbd13003d3e40] __do_softirq at ffffffff8df352e9
> 26 [ffffbd13003d3eb0] run_ksoftirqd at ffffffff8ceffe47
> 27 [ffffbd13003d3ec0] smpboot_thread_fn at ffffffff8cf36a30
> 28 [ffffbd13003d3ee8] kthread at ffffffff8cf2b39f
> 29 [ffffbd13003d3f28] ret_from_fork at ffffffff8ce5fa64
> 30 [ffffbd13003d3f50] ret_from_fork_asm at ffffffff8ce03cbb
> 
> Fixes: 51ebd3181572 ("ipv6: add support of equal cost multipath (ECMP)")

Would be more appropriate to blame commit 66f5d6ce53e6 ("ipv6: replace
rwlock with rcu and spinlock in fib6_table"). Before this commit readers
could not traverse the siblings list in the data path while writers
modified it in the control path.

> Reported-by: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>
> Tested-by: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>
> Signed-off-by: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Ido Schimmel <idosch@idosch.org>
> ---
> v2 -> v3:
> 	* Removed redundant rcu_read_lock()/rcu_read_unlock() pairs
> 	* Revised the test script based on Ido Schimmel's feedback
> 	* Updated the test script to ensure compatibility with the latest iperf3 version
> 	* Fixed new warnings generated with 'C=2' in the previous version
> 	* Other review comments addressed
> 
> v1 -> v2:
> 	* list_del_rcu() is applied exclusively to legacy multipath code
> 	* All occurrences of fib6_siblings have been modified to utilize RCU
> 	  APIs for annotation and usage.
> 	* Additionally, a test script for reproducing the reported
> 	  issue is included
> ---
>  net/ipv6/ip6_fib.c                            |  22 +-
>  net/ipv6/route.c                              |  30 ++-
>  tools/testing/selftests/net/Makefile          |   1 +
>  .../net/ipv6_route_update_soft_lockup.sh      | 226 ++++++++++++++++++
>  4 files changed, 261 insertions(+), 18 deletions(-)
>  create mode 100755 tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh
> 
> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index eb111d20615c..002cddc5d3b5 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -518,7 +518,7 @@ int fib6_tables_dump(struct net *net, struct notifier_block *nb,
>  static int fib6_dump_node(struct fib6_walker *w)
>  {
>  	int res;
> -	struct fib6_info *rt;
> +	struct fib6_info *rt, *sibling, *last_sibling;
>  
>  	for_each_fib6_walker_rt(w) {
>  		res = rt6_dump_route(rt, w->args, w->skip_in_node);
> @@ -540,10 +540,14 @@ static int fib6_dump_node(struct fib6_walker *w)
>  		 * last sibling of this route (no need to dump the
>  		 * sibling routes again)
>  		 */
> -		if (rt->fib6_nsiblings)
> -			rt = list_last_entry(&rt->fib6_siblings,
> -					     struct fib6_info,
> -					     fib6_siblings);
> +		if (rt->fib6_nsiblings) {
> +			last_sibling = rt;
> +			list_for_each_entry_rcu(sibling, &rt->fib6_siblings,
> +						fib6_siblings)
> +				last_sibling = sibling;
> +
> +			rt = last_sibling;
> +		}
>  	}
>  	w->leaf = NULL;
>  	return 0;

Are you sure this hunk is needed? Seems this function is always called
with the table lock held.

> @@ -1190,8 +1194,8 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
>  		while (sibling) {
>  			if (sibling->fib6_metric == rt->fib6_metric &&
>  			    rt6_qualify_for_ecmp(sibling)) {
> -				list_add_tail(&rt->fib6_siblings,
> -					      &sibling->fib6_siblings);
> +				list_add_tail_rcu(&rt->fib6_siblings,
> +						  &sibling->fib6_siblings);
>  				break;
>  			}
>  			sibling = rcu_dereference_protected(sibling->fib6_next,
> @@ -1252,7 +1256,7 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
>  							 fib6_siblings)
>  					sibling->fib6_nsiblings--;
>  				rt->fib6_nsiblings = 0;
> -				list_del_init(&rt->fib6_siblings);
> +				list_del_rcu(&rt->fib6_siblings);
>  				rt6_multipath_rebalance(next_sibling);
>  				return err;
>  			}
> @@ -1970,7 +1974,7 @@ static void fib6_del_route(struct fib6_table *table, struct fib6_node *fn,
>  					 &rt->fib6_siblings, fib6_siblings)
>  			sibling->fib6_nsiblings--;
>  		rt->fib6_nsiblings = 0;
> -		list_del_init(&rt->fib6_siblings);
> +		list_del_rcu(&rt->fib6_siblings);
>  		rt6_multipath_rebalance(next_sibling);
>  	}
>  
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 219701caba1e..12dc1acb6463 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -413,7 +413,7 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
>  		      struct flowi6 *fl6, int oif, bool have_oif_match,
>  		      const struct sk_buff *skb, int strict)
>  {
> -	struct fib6_info *sibling, *next_sibling;
> +	struct fib6_info *sibling;
>  	struct fib6_info *match = res->f6i;
>  
>  	if (!match->nh && (!match->fib6_nsiblings || have_oif_match))
> @@ -440,8 +440,10 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
>  	if (fl6->mp_hash <= atomic_read(&match->fib6_nh->fib_nh_upper_bound))
>  		goto out;
>  
> -	list_for_each_entry_safe(sibling, next_sibling, &match->fib6_siblings,
> -				 fib6_siblings) {
> +	rcu_read_lock();

fib6_select_path() should already be called with rcu_read_lock()

> +
> +	list_for_each_entry_rcu(sibling, &match->fib6_siblings,
> +				fib6_siblings) {
>  		const struct fib6_nh *nh = sibling->fib6_nh;
>  		int nh_upper_bound;
>  
> @@ -454,6 +456,8 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
>  		break;
>  	}
>  
> +	rcu_read_unlock();
> +
>  out:
>  	res->f6i = match;
>  	res->nh = match->fib6_nh;
> @@ -5195,14 +5199,18 @@ static void ip6_route_mpath_notify(struct fib6_info *rt,
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
> +
> +	rcu_read_unlock();
>  }
>  
>  static bool ip6_route_mpath_should_notify(const struct fib6_info *rt)
> @@ -5547,17 +5555,21 @@ static size_t rt6_nlmsg_size(struct fib6_info *f6i)
>  		nexthop_for_each_fib6_nh(f6i->nh, rt6_nh_nlmsg_size,
>  					 &nexthop_len);
>  	} else {
> -		struct fib6_info *sibling, *next_sibling;
> +		struct fib6_info *sibling;
>  		struct fib6_nh *nh = f6i->fib6_nh;
>  
>  		nexthop_len = 0;
>  		if (f6i->fib6_nsiblings) {
>  			rt6_nh_nlmsg_size(nh, &nexthop_len);
>  
> -			list_for_each_entry_safe(sibling, next_sibling,
> -						 &f6i->fib6_siblings, fib6_siblings) {
> +			rcu_read_lock();
> +
> +			list_for_each_entry_rcu(sibling, &f6i->fib6_siblings,
> +						fib6_siblings) {
>  				rt6_nh_nlmsg_size(sibling->fib6_nh, &nexthop_len);
>  			}
> +
> +			rcu_read_unlock();
>  		}
>  		nexthop_len += lwtunnel_get_encap_size(nh->fib_nh_lws);
>  	}

What about rt6_fill_node() ? It's not always called with the table lock
held

> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index 8eaffd7a641c..95e5e5cd1195 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -94,6 +94,7 @@ TEST_PROGS += fdb_flush.sh
>  TEST_PROGS += fq_band_pktlimit.sh
>  TEST_PROGS += vlan_hw_filter.sh
>  TEST_PROGS += bpf_offload.py
> +TEST_PROGS += ipv6_route_update_soft_lockup.sh
>  
>  TEST_FILES := settings
>  TEST_FILES += in_netns.sh lib.sh net_helper.sh setup_loopback.sh setup_veth.sh
> diff --git a/tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh b/tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh
> new file mode 100755
> index 000000000000..f55488e4645c
> --- /dev/null
> +++ b/tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh
> @@ -0,0 +1,226 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Testing for potential kernel soft lockup during IPv6 routing table
> +# refresh under heavy outgoing IPv6 traffic. If a kernel soft lockup
> +# occurs, a kernel panic will be triggered to prevent associated issues.
> +#
> +#
> +#                            Test Environment Layout
> +#
> +# ┌-----------------┐                                             ┌------------------┐
> +# |     SOURCE_NS   |                                             |     SINK_NS      |
> +# |    NAMESPACE    |                                             |    NAMESPACE     |
> +# |(iperf3 clients) |                                             | (iperf3 servers) |
> +# |                 |                                             |                  |
> +# |                 |                                             |                  |
> +# |     ┌-----------|                             nexthops        |---------┐        |
> +# |     |veth_source|<------------------------------------------->|veth_sink|<-┐     |
> +# |     └-----------| 2001:0DB8:1::0:1/96     2001:0DB8:1::1:1/96 |---------┘  |     |
> +# |                 |         ^               2001:0DB8:1::1:2/96 |            |     |
> +# |                 |         .                       .           |            | fwd |
> +# |   ┌---------┐   |         .                       .           |            |     |
> +# |   |   IPv6  |   |         .                       .           |            V     |
> +# |   | routing |   |         .               2001:0DB8:1::1:80/96|         ┌-----┐  |
> +# |   |  table  |   |         .                                   |         | lo  |  |
> +# |   | nexthop |   |         .                                   └---------┴-----┴--┘
> +# |   | update  |   |         ..................................> 2001:0DB8:2::1:1/128
> +# |   └-------- ┘   |
> +# └-----------------┘
> +#
> +# The test script sets up two network namespaces, source_ns and sink_ns,
> +# connected via a veth link. Within source_ns, it continuously updates the
> +# IPv6 routing table by flushing and inserting IPV6_NEXTHOP_ADDR_COUNT nexthop
> +# IPs destined for SINK_LOOPBACK_IP_ADDR in sink_ns. This refresh occurs at a
> +# rate of 1/ROUTING_TABLE_REFRESH_PERIOD per second for TEST_DURATION seconds.
> +#
> +# Simultaneously, multiple iperf3 clients within source_ns generate heavy
> +# outgoing IPv6 traffic. Each client is assigned a unique port number starting
> +# at 5000 and incrementing sequentially. Each client targets a unique iperf3
> +# server running in sink_ns, connected to the SINK_LOOPBACK_IFACE interface
> +# using the same port number.
> +#
> +# The number of iperf3 servers and clients is set to half of the total
> +# available cores on each machine.
> +#
> +# NOTE:  We have tested this script on machines with various CPU specifications,
> +# ranging from lower to higher performance as listed below. The test script
> +# effectively triggered a kernel soft lockup on machines running an unpatched
> +# kernel in under a minute:
> +#
> +# - 1x Intel Xeon E-2278G 8-Core Processor @ 3.40GHz
> +# - 1x Intel Xeon E-2378G Processor 8-Core @ 2.80GHz
> +# - 1x AMD EPYC 7401P 24-Core Processor @ 2.00GHz
> +# - 1x AMD EPYC 7402P 24-Core Processor @ 2.80GHz
> +# - 2x Intel Xeon Gold 5120 14-Core Processor @ 2.20GHz
> +# - 1x Ampere Altra Q80-30 80-Core Processor @ 3.00GHz
> +# - 2x Intel Xeon Gold 5120 14-Core Processor @ 2.20GHz
> +# - 2x Intel Xeon Silver 4214 24-Core Processor @ 2.20GHz
> +# - 1x AMD EPYC 7502P 32-Core @ 2.50GHz
> +# - 1x Intel Xeon Gold 6314U 32-Core Processor @ 2.30GHz
> +# - 2x Intel Xeon Gold 6338 32-Core Processor @ 2.00GHz
> +#
> +# On less performant machines, you may need to increase the TEST_DURATION
> +# parameter to enhance the likelihood of encountering a race condition leading
> +# to a kernel soft lockup and avoid a false negative result.
> +
> +source lib.sh
> +
> +TEST_DURATION=120
> +ROUTING_TABLE_REFRESH_PERIOD=0.01
> +
> +IPERF3_BITRATE="300m"
> +
> +
> +IPV6_NEXTHOP_ADDR_COUNT="128"
> +IPV6_NEXTHOP_ADDR_MASK="96"
> +IPV6_NEXTHOP_PREFIX="2001:0DB8:1"
> +
> +
> +SOURCE_TEST_IFACE="veth_source"
> +SOURCE_TEST_IP_ADDR="2001:0DB8:1::0:1/96"
> +
> +SINK_TEST_IFACE="veth_sink"
> +# ${SINK_TEST_IFACE} is populated with the following range of IPv6 addresses:
> +# 2001:0DB8:1::1:1  to 2001:0DB8:1::1:${IPV6_NEXTHOP_ADDR_COUNT}
> +SINK_LOOPBACK_IFACE="lo"
> +SINK_LOOPBACK_IP_MASK="128"
> +SINK_LOOPBACK_IP_ADDR="2001:0DB8:2::1:1"
> +
> +nexthop_ip_list=""
> +termination_signal=""
> +kernel_softlokup_panic_prev_val=""
> +
> +cleanup() {
> +	echo "info: cleaning up namespaces and terminating all processes within them..."
> +
> +	kill -9 $(pgrep -f "iperf3") > /dev/null 2>&1
> +	sleep 1
> +	kill -9 $(pgrep -f "ip netns list | grep -q ${source_ns}") > /dev/null 2>&1
> +	sleep 1
> +
> +	# Check if any iperf3 instances are still running. This could occur if a core has entered an infinite loop and
> +	# the timeout for the soft lockup to be detected has not expired yet, but either the test interval has already
> +	# elapsed or the test is terminated manually (Ctrl+C)
> +	if pgrep -f "iperf3" > /dev/null; then
> +		echo "FAIL: unable to terminate some iperf3 instances. Soft lockup is underway. A kernel panic is on the way!"
> +		exit ${ksft_fail}
> +	else
> +		if [ "$termination_signal" == "SIGINT" ]; then
> +			echo "SKIP: Termination due to ^C (SIGINT)"
> +		elif [ "$termination_signal" == "SIGALRM" ]; then
> +			echo "PASS: No kernel soft lockup occurred during this ${TEST_DURATION} second test"
> +		fi
> +	fi
> +
> +	cleanup_ns ${source_ns} ${sink_ns}
> +
> +	sysctl -qw kernel.softlockup_panic=${kernel_softlokup_panic_prev_val}
> +}
> +
> +setup_prepare() {
> +	setup_ns source_ns sink_ns
> +
> +	ip -n ${source_ns} link add name ${SOURCE_TEST_IFACE} type veth peer name ${SINK_TEST_IFACE} netns ${sink_ns}
> +
> +	# Setting up the Source namespace
> +	ip -n ${source_ns} addr add ${SOURCE_TEST_IP_ADDR} dev ${SOURCE_TEST_IFACE}
> +	ip -n ${source_ns} link set dev ${SOURCE_TEST_IFACE} qlen 10000
> +	ip -n ${source_ns} link set dev ${SOURCE_TEST_IFACE} up
> +	ip netns exec ${source_ns} sysctl -qw net.ipv6.fib_multipath_hash_policy=1
> +
> +	# Setting up the Sink namespace
> +	ip -n ${sink_ns} addr add ${SINK_LOOPBACK_IP_ADDR}/${SINK_LOOPBACK_IP_MASK} dev ${SINK_LOOPBACK_IFACE}
> +	ip -n ${sink_ns} link set dev ${SINK_LOOPBACK_IFACE} up
> +	ip netns exec ${sink_ns} sysctl -qw net.ipv6.conf.${SINK_LOOPBACK_IFACE}.forwarding=1
> +
> +	ip -n ${sink_ns} link set ${SINK_TEST_IFACE} up
> +	ip netns exec ${sink_ns} sysctl -qw net.ipv6.conf.${SINK_TEST_IFACE}.forwarding=1
> +
> +
> +	# Populating Nexthop IPv6 addresses on the test interface of the sink_ns namespace
> +	echo "info: populating ${IPV6_NEXTHOP_ADDR_COUNT} IPv6 addresses on the ${SINK_TEST_IFACE} interface ..."
> +	for IP in $(seq 1 ${IPV6_NEXTHOP_ADDR_COUNT}); do
> +		ip -n ${sink_ns} addr add ${IPV6_NEXTHOP_PREFIX}::$(printf "1:%x" "${IP}")/${IPV6_NEXTHOP_ADDR_MASK} dev ${SINK_TEST_IFACE};
> +	done
> +
> +	# Preparing list of nexthops
> +	for IP in $(seq 1 ${IPV6_NEXTHOP_ADDR_COUNT}); do
> +		nexthop_ip_list=$nexthop_ip_list" nexthop via ${IPV6_NEXTHOP_PREFIX}::$(printf "1:%x" $IP) dev ${SOURCE_TEST_IFACE} weight 1"
> +	done
> +}
> +
> +
> +test_soft_lockup_during_routing_table_refresh() {
> +	# Start num_of_iperf_servers iperf3 servers in the sink_ns namespace, each listening on ports
> +	# starting at 5001 and incrementing sequentially.
> +	echo "info: starting ${num_of_iperf_servers} iperf3 servers in the sink_ns namespace ..."
> +	for i in $(seq 1 ${num_of_iperf_servers}); do
> +		cmd="iperf3 --bind ${SINK_LOOPBACK_IP_ADDR} -s -p $(printf '5%03d' ${i}) > /dev/null 2>&1"
> +		ip netns exec ${sink_ns} bash -c "while true; do ${cmd}; done &"
> +	done
> +
> +	# Wait for a while for the iperf3 servers to become ready
> +	sleep 2
> +
> +	# Continuously refresh the routing table in background in the Source namespase
> +	ip netns exec ${source_ns} bash -c "
> +		while \$(ip netns list | grep -q ${source_ns}); do
> +			ip -6 route add ${SINK_LOOPBACK_IP_ADDR}/${SINK_LOOPBACK_IP_MASK} ${nexthop_ip_list};
> +			sleep ${ROUTING_TABLE_REFRESH_PERIOD};
> +			ip -6 route delete ${SINK_LOOPBACK_IP_ADDR}/${SINK_LOOPBACK_IP_MASK};
> +		done &"
> +
> +	# Start num_of_iperf_servers iperf3 clients in the source_ns namespace, each sending TCP traffic on sequential ports starting at 5001
> +	echo "info: starting ${num_of_iperf_servers} iperf3 clients in the source_ns namespace ..."
> +	for i in $(seq 1 ${num_of_iperf_servers}); do
> +		cmd="iperf3 -c ${SINK_LOOPBACK_IP_ADDR} -p $(printf '5%03d' ${i}) --length 64 --bitrate ${IPERF3_BITRATE} -t 0 > /dev/null 2>&1"
> +		ip netns exec ${source_ns} bash -c "while true; do ${cmd}; done &"
> +	done
> +
> +	echo "info: IPv6 routing table is being updated at the rate of $(echo "1/${ROUTING_TABLE_REFRESH_PERIOD}" | bc)/s for ${TEST_DURATION} seconds ..."
> +	echo "info: A kernel soft lockup, if detected, results in a kernel panic!"
> +
> +	wait
> +}
> +
> +# Make sure 'iperf3' is installed, skip the test otherwise
> +if [ ! -x "$(command -v "iperf3")" ]; then
> +	echo "SKIP: 'iperf3' is not installed. Skipping the test."
> +	exit ${ksft_skip}
> +fi
> +
> +# Determine the number of cores on the machine
> +num_of_iperf_servers=$(( $(nproc)/2 ))
> +
> +# Check if we are running on a multi-core machine, skip the test otherwise
> +if [ "${num_of_iperf_servers}" -eq 0 ]; then
> +	echo "SKIP: This test is not valid on a single core machine!"
> +	exit ${ksft_skip}
> +fi
> +
> +# Since the kernel soft lockup we're testing against causes at least one core
> +# to enter an infinite loop, making the host unstable and likely affecting
> +# subsequent tests, we trigger a kernel panic instead of reporting a failure.
> +kernel_softlokup_panic_prev_val=$(sysctl -n kernel.softlockup_panic)
> +sysctl -qw kernel.softlockup_panic=1
> +
> +handle_sigint() {
> +	termination_signal="SIGINT"
> +	cleanup
> +	exit ${ksft_skip}
> +}
> +
> +handle_sigalrm() {
> +	termination_signal="SIGALRM"
> +	cleanup
> +	exit ${ksft_pass}
> +}
> +
> +trap handle_sigint SIGINT
> +trap handle_sigalrm SIGALRM
> +
> +(sleep ${TEST_DURATION} && kill -s SIGALRM $$)&
> +
> +setup_prepare
> +test_soft_lockup_during_routing_table_refresh
> -- 
> 2.43.0
> 

