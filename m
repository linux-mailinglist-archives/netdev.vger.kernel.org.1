Return-Path: <netdev+bounces-299660-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IcPJL3ONMGpmUQUAu9opvQ
	(envelope-from <netdev+bounces-299660-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:40:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8F268A9CB
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:40:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Xbyw/3RK";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299660-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299660-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89133302960C
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EEA361651;
	Mon, 15 Jun 2026 23:38:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCE535F612;
	Mon, 15 Jun 2026 23:38:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781566736; cv=none; b=s6EmLcuocJsYW0cW2PbohhMN1swXXoBJFKxKKq9FObCoCNNQJoKi1o0itPywIgEhvNIslXWIjnscsSjJcNolVmiJeIIanocM7Agqqj//9jqqd2e7CI00FOlAFy5vK9Q9iE4exkqdx9+SertMPwSccpf82yoqbslsAHOpcyl5HhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781566736; c=relaxed/simple;
	bh=053NQzP8MKaf32vV11JVQw9lgVY3kxlCeNgU0l+ZPkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZLiJ/AQClyUNIIsp8s+guNQ9Nmjwr5pszVvEFW1ap944ljsHOOlHe6NCGyY5DgT6e1A/s/918LgYcAPxGHS7G+2N8RbJYELR0xw3pgWGse4Ok2sXCn4Z9mNdIguTBR50HXnaY0WRCKgo1YLXNUCqWgBNlJro/uwJK5LxzDFLtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xbyw/3RK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00691F000E9;
	Mon, 15 Jun 2026 23:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781566735;
	bh=Mk/A8NBZnHrP/DoBw8rAAPGWS9cLwNDHBt31WGq6Oxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xbyw/3RKxlibO5AAXqHzTtPtb/oN0aXxF0HZH9UjR+mzLFOazl7h2TOX3e/R3LH8N
	 FWuJbAHsexi500Z1sARpCCyKXW3ZvnxVV/umdb+wpC5B8Tit4/6U41B9XIndhJgr+7
	 Ipz57jOg5kqjHk4ESDfjJzXSr5tvocvgJu2fbsgilHr28P9SPed0W2hY2ZuYWdvlBI
	 n13AIHIgXTQUTtKzV32a3Xumb/AvO9d87YYhM4tsHjkCsWA5qMrPi5oxTv2Pj4XwrK
	 Lqxa09OXSeH4ZyRVjo7VgNfC8Htam5Is/ZVMZLQDUyHJRpKklwT8JL+qlp1PHftU40
	 dy5R1FGiTldug==
From: Jakub Kicinski <kuba@kernel.org>
To: jensemil.schulzostergaard@microchip.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	horatiu.vultur@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	daniel.machon@microchip.com,
	Steen.Hegelund@microchip.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next 8/9] net: sparx5: add L3 FIB, nexthop and neighbour entry management
Date: Mon, 15 Jun 2026 16:38:52 -0700
Message-ID: <20260615233852.1042358-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612-sparx5_l3_routing-v1-8-fc3c10160f49@microchip.com>
References: <20260612-sparx5_l3_routing-v1-8-fc3c10160f49@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299660-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jensemil.schulzostergaard@microchip.com,m:kuba@kernel.org,m:horatiu.vultur@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:daniel.machon@microchip.com,m:Steen.Hegelund@microchip.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-hardening@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D8F268A9CB

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Subject: net: sparx5: add L3 FIB, nexthop and neighbour entry management

Add the data path for L3 unicast route offloading for IPv4 and IPv6 FIB
and nexthop groups.

> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_router.c b/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
> @@ -396,6 +400,14 @@ static bool sparx5_rr_fib_info_should_ignore(struct sparx5_rr_fib_info *fi)
>  		       (IPV6_ADDR_MULTICAST | IPV6_ADDR_LINKLOCAL);
>  }
>  
> +#if IS_ENABLED(CONFIG_IPV6)
> +static void sparx5_rr_rt6_release(struct fib6_info *rt)
> +{
> +	if (!rt->nh)
> +		rt->fib6_nh->fib_nh_flags &= ~RTNH_F_OFFLOAD;
> +
> +	fib6_info_release(rt);
> +}

[Severity: High]
Does this non-atomic flag modification race with the core IPv6 stack?

The driver clears RTNH_F_OFFLOAD directly from an async worker thread
without holding the rtnl_lock. Since the core networking stack updates
these flags under the rtnl_lock, could this lockless non-atomic operation
cause torn writes and overwrite state updates like RTNH_F_DEAD?

[ ... ]

> @@ -826,6 +1143,14 @@ static void sparx5_rr_neigh_entry_destroy(struct sparx5 *sparx5,
>  	kfree(entry);
>  }
>  
> +static void sparx5_rr_neigh_entry_put(struct sparx5 *sparx5,
> +				      struct sparx5_rr_neigh_entry *neigh_entry)
> +{
> +	if (neigh_entry && list_empty(&neigh_entry->nexthop_list) &&
> +	    !neigh_entry->hw_route.vrule_id_valid)
> +		sparx5_rr_neigh_entry_destroy(sparx5, neigh_entry);
> +}

[Severity: High]
Can a neighbour entry leak permanently if its subnet route is deleted while
a gateway nexthop still references it?

When the subnet route is deleted, sparx5_rr_fib_entry_destroy() sets
neigh_entry->fib_entry = NULL and disables the VCAP rule. However, if an
ARP update arrives while the gateway route still references the neighbour,
sparx5_rr_neigh_event_work() re-enables the VCAP rule by setting
vrule_id_valid to true.

Later, when the gateway route is deleted, sparx5_rr_neigh_entry_put() will
skip destroying the neighbour because vrule_id_valid is true. The neighbour
would be left with an empty nexthop_list and a NULL fib_entry, meaning it
cannot be found during teardown by sparx5_rr_fib_flush(). Does this leak
the dev_tracker and hardware VCAP rule?

[ ... ]

> @@ -2126,6 +2753,8 @@ static int sparx5_rr_fib_replace(struct sparx5 *sparx5,
>  	/* Release and allow any previous fib_info to be deleted */
>  	sparx5_rr_fib_info_put(&old_fi);
>  
> +	fib_entry->type = sparx5_rr_rtm_type2fib_type(fi_type);
> +
>  	err = sparx5_rr_entry_nexthop_group_update(sparx5, fib_entry);

[Severity: Critical]
Could this in-place type update corrupt the LPM list?

If sparx5_rr_fib_replace() changes the route type from UNICAST to LOCAL,
the entry remains in the fib_lpm4_list or fib_lpm6_list. Later, when the
route is deleted, sparx5_rr_fib_entry_destroy() calls
sparx5_rr_fib_lpm_remove(), which has this check:

static void sparx5_rr_fib_lpm_remove(struct sparx5_rr_fib_entry *fib_entry)
{
        if (fib_entry->type != SPARX5_RR_FIB_TYPE_UNICAST)
                return;

        list_del(&fib_entry->fib_lpm_node);
}

Since the type is now LOCAL, the function returns early and skips the
list_del() operation. The entry is then freed, leaving a dangling pointer
in the linked list. Conversely, replacing a LOCAL route with a UNICAST
route appears to cause a NULL pointer dereference in list_del() because
it was never added to the list.

[ ... ]

> @@ -2247,6 +2873,28 @@ static int sparx5_rr_fib6_nexthop_prune(struct sparx5 *sparx5,
> +	old_nrt6 = fib_entry->fi.fe6_info.nrt6;
> +	new_nrt6 = old_nrt6 >= f6i->nrt6 ? old_nrt6 - f6i->nrt6 : 0;
> +
> +	rt_arr = kzalloc_objs(struct fib6_info *, new_nrt6);
> +	if (!rt_arr)
> +		return -ENOMEM;
> +
> +	for (int i = 0; i < old_nrt6; i++) {
> +		struct fib6_info *fi = old_rt_arr[i];
> +
> +		if (sparx5_rr_fib6_rt_exists(f6i, fi)) {
> +			sparx5_rr_rt6_release(fi);
> +			continue;
> +		}
> +
> +		rt_arr[j++] = fi;
> +	}

[Severity: Critical]
Is there a risk of a heap buffer overflow in this loop?

The new array size is calculated as the difference between the old count
and the count of nexthops to remove. However, if the deletion request
contains nexthops that do not perfectly match the tracked nexthops,
sparx5_rr_fib6_rt_exists() will return false.

The loop then copies these non-matching elements into rt_arr. Could the
index j exceed new_nrt6 in this scenario, writing past the end of the
dynamically allocated buffer?

[ ... ]

> @@ -2939,6 +3032,12 @@ int sparx5_rr_router_init(struct sparx5 *sparx5)
>  err_unreg_inet_addr_val_notifier:
>  	unregister_inetaddr_validator_notifier(&r->inetaddr_valid_nb);
>  err_unreg_inet_notifier:
>  	unregister_inetaddr_notifier(&r->inetaddr_nb);
> +err_unreg_fib_notifier:
> +	unregister_fib_notifier(&init_net, &r->fib_nb);
>  err_workqueue_destroy:
>  	destroy_workqueue(r->sparx5_router_owq);
> +err_fib_ht_destroy:
> +	rhashtable_destroy(&r->fib_ht);
> +err_neigh_ht_destroy:
> +	rhashtable_destroy(&r->neigh_ht);

[Severity: High]
Does this error path leak all offloaded route hardware and software
structures?

If an error occurs after register_fib_notifier() has successfully run, the
error path calls destroy_workqueue(). This allows the initial FIB dump to
finish populating routes into the hardware and the r->fib_ht structure.

However, the error path subsequently calls rhashtable_destroy() without
first calling sparx5_rr_fib_flush(). Since rhashtable_destroy() only frees
the hash buckets and not the elements, does this permanently leak all the
inserted fib_entry objects, their dev_trackers, and their hardware VCAP
rules upon a module load failure?

