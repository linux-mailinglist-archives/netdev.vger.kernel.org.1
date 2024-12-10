Return-Path: <netdev+bounces-150525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 287779EA88A
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 07:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20DD61888396
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 06:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61EC226197;
	Tue, 10 Dec 2024 06:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZqD2QKuX"
X-Original-To: netdev@vger.kernel.org
Received: from out199-11.us.a.mail.aliyun.com (out199-11.us.a.mail.aliyun.com [47.90.199.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB12C22617B
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 06:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733810931; cv=none; b=qHYpo3y9ujOuV3kD/wx4Rabdp3nq3eZjsnQxJQ17I3E7OBWbFH1Vty7aDOqk6TrLMrC+A19flBos3Or6zWxesUQ6mqeZeNX87p6TI85X7QbeofzjAvAG1cmB8zHXZsn+p1oMYejJxieonh/CcqeErKdLvolDE4Yy3Gv04Yw+a48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733810931; c=relaxed/simple;
	bh=6iVbNRD4ofzXpFZgEsqsS8z1gQoF688iwrX27feXYuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbpTZrMJrzPuRoNAMEKnAL6fwBOX7HpaeBe84ngRvd9ywZfo0/WHJSJJtfDyWHk4QG045+c2iq3OPs/9iNrDn+GTUAeblTI31DD8dbNsyVsye7sEFr62qtfeQvtN4HJg5NbFAQk9Oj7OoUkHsSj/uhtyIy64YDD+GVRs5HPAl+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZqD2QKuX; arc=none smtp.client-ip=47.90.199.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733810915; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=NJ8yCM77zOLN6w3f3J633Bu5lTpjdvuxPHAaG3MmRYc=;
	b=ZqD2QKuXR1VIP3OJeUebNeLjpA0EJNzWUjzGsoE3HfBBhC/GhHrVtHy5lrzsdkV4S7HYIrh1/54Ya8kHqZDl9rMn8mLarLqY+LY3QDp7HSMkqFYmLlGtg4M5LQPTMpbLhp43lKX0da91miSP4fP/gLCMaw8JkDeZ/mFCeycUuzQ=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WLDqaQh_1733810914 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Dec 2024 14:08:35 +0800
Date: Tue, 10 Dec 2024 14:08:34 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 11/12] net: homa: create homa_plumbing.c
 homa_utils.c
Message-ID: <20241210060834.GB83318@j66a10360.sqa.eu95>
References: <20241209175131.3839-1-ouster@cs.stanford.edu>
 <20241209175131.3839-13-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209175131.3839-13-ouster@cs.stanford.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Dec 09, 2024 at 09:51:29AM -0800, John Ousterhout wrote:
> homa_plumbing.c contains functions that connect Homa to the rest of
> the Linux kernel, such as dispatch tables used by Linux and the
> top-level functions that Linux invokes from those dispatch tables.
> 
> Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
> ---
>  net/homa/homa_plumbing.c | 1024 ++++++++++++++++++++++++++++++++++++++
>  net/homa/homa_utils.c    |  177 +++++++
>  2 files changed, 1201 insertions(+)
>  create mode 100644 net/homa/homa_plumbing.c
>  create mode 100644 net/homa/homa_utils.c
> 
> diff --git a/net/homa/homa_plumbing.c b/net/homa/homa_plumbing.c
> new file mode 100644
> index 000000000000..b0ddaecc0e3c
> --- /dev/null
> +++ b/net/homa/homa_plumbing.c
> @@ -0,0 +1,1024 @@
> +// SPDX-License-Identifier: BSD-2-Clause
> +
> +/* This file consists mostly of "glue" that hooks Homa into the rest of
> + * the Linux kernel. The guts of the protocol are in other files.
> + */
> +
> +/**
> + * homa_softirq() - This function is invoked at SoftIRQ level to handle
> + * incoming packets.
> + * @skb:   The incoming packet.
> + * Return: Always 0
> + */
> +int homa_softirq(struct sk_buff *skb)
> +{
> +	struct sk_buff *packets, *other_pkts, *next;
> +	struct sk_buff **prev_link, **other_link;
> +	struct homa *homa = global_homa;
> +	struct common_header *h;
> +	int first_packet = 1;
> +	int header_offset;
> +	int pull_length;
> +
> +	/* skb may actually contain many distinct packets, linked through
> +	 * skb_shinfo(skb)->frag_list by the Homa GRO mechanism. Make a
> +	 * pass through the list to process all of the short packets,
> +	 * leaving the longer packets in the list. Also, perform various
> +	 * prep/cleanup/error checking functions.
> +	 */
> +	skb->next = skb_shinfo(skb)->frag_list;
> +	skb_shinfo(skb)->frag_list = NULL;
> +	packets = skb;
> +	prev_link = &packets;
> +	for (skb = packets; skb; skb = next) {
> +		next = skb->next;
> +
> +		/* Make the header available at skb->data, even if the packet
> +		 * is fragmented. One complication: it's possible that the IP
> +		 * header hasn't yet been removed (this happens for GRO packets
> +		 * on the frag_list, since they aren't handled explicitly by IP.
> +		 */
> +		header_offset = skb_transport_header(skb) - skb->data;
> +		pull_length = HOMA_MAX_HEADER + header_offset;
> +		if (pull_length > skb->len)
> +			pull_length = skb->len;
> +		if (!pskb_may_pull(skb, pull_length))
> +			goto discard;
> +		if (header_offset)
> +			__skb_pull(skb, header_offset);
> +
> +		/* Reject packets that are too short or have bogus types. */
> +		h = (struct common_header *)skb->data;
> +		if (unlikely(skb->len < sizeof(struct common_header) ||
> +			     h->type < DATA || h->type >= BOGUS ||
> +			     skb->len < header_lengths[h->type - DATA]))
> +			goto discard;
> +
> +		if (first_packet)
> +			first_packet = 0;
Looks useless.
> +
> +		/* Process the packet now if it is a control packet or
> +		 * if it contains an entire short message.
> +		 */
> +		if (h->type != DATA || ntohl(((struct data_header *)h)
> +				->message_length) < 1400) {

Why 1400? Maybe compare with skb->len?

> +			*prev_link = skb->next;
> +			skb->next = NULL;
> +			homa_dispatch_pkts(skb, homa);
> +		} else {
> +			prev_link = &skb->next;
> +		}
> +		continue;
> +
> +discard:
> +		*prev_link = skb->next;
> +		kfree_skb(skb);
> +	}
> +
> +	/* Now process the longer packets. Each iteration of this loop
> +	 * collects all of the packets for a particular RPC and dispatches
> +	 * them.
> +	 */
> +	while (packets) {
> +		struct in6_addr saddr, saddr2;
> +		struct common_header *h2;
> +		struct sk_buff *skb2;
> +
> +		skb = packets;
> +		prev_link = &skb->next;
> +		saddr = skb_canonical_ipv6_saddr(skb);
> +		other_pkts = NULL;
> +		other_link = &other_pkts;
> +		h = (struct common_header *)skb->data;
> +		for (skb2 = skb->next; skb2; skb2 = next) {
> +			next = skb2->next;
> +			h2 = (struct common_header *)skb2->data;
> +			if (h2->sender_id == h->sender_id) {
> +				saddr2 = skb_canonical_ipv6_saddr(skb2);
> +				if (ipv6_addr_equal(&saddr, &saddr2)) {

Does two skbs with the same ID and source address must come from the
same RPC? if so, why is there an additional check for dport in
homa_find_server_rpc().

Anyway, the judgment of whether the skb comes from the same RPC
should be consistent, using a unified function or macro definition.

> +					*prev_link = skb2;
> +					prev_link = &skb2->next;
> +					continue;
> +				}
> +			}
> +			*other_link = skb2;
> +			other_link = &skb2->next;
> +		}
> +		*prev_link = NULL;
> +		*other_link = NULL;
> +		homa_dispatch_pkts(packets, homa);
Is it really necessary to gather packets belonging to the same RPC for
processing together, just to save some time finding the RPC ?

If each packet is independent, it instead introduces a lot of
unnecessary cycles.

> +		packets = other_pkts;
> +	}
> +	return 0;
> +}
> +
> +/**
> + * homa_backlog_rcv() - Invoked to handle packets saved on a socket's
> + * backlog because it was locked when the packets first arrived.
> + * @sk:     Homa socket that owns the packet's destination port.
> + * @skb:    The incoming packet. This function takes ownership of the packet
> + *          (we'll delete it).
> + *
> + * Return:  Always returns 0.
> + */
> +int homa_backlog_rcv(struct sock *sk, struct sk_buff *skb)
> +{
> +	pr_warn("unimplemented backlog_rcv invoked on Homa socket\n");
maybe just warn once, using pr_warn_once();
> +	kfree_skb(skb);
> +	return 0;
> +}
> +
> +/**
> + * homa_err_handler_v4() - Invoked by IP to handle an incoming error
> + * packet, such as ICMP UNREACHABLE.
> + * @skb:   The incoming packet.
> + * @info:  Information about the error that occurred?
> + *
> + * Return: zero, or a negative errno if the error couldn't be handled here.
> + */
> +int homa_err_handler_v4(struct sk_buff *skb, u32 info)
> +{
> +	const struct in6_addr saddr = skb_canonical_ipv6_saddr(skb);
> +	const struct iphdr *iph = ip_hdr(skb);
What's this for? only used in ICMP_PORT_UNREACH with re-assignment.
> +	struct homa *homa = global_homa;
> +	int type = icmp_hdr(skb)->type;
> +	int code = icmp_hdr(skb)->code;
> +
> +	if (type == ICMP_DEST_UNREACH && code == ICMP_PORT_UNREACH) {
> +		char *icmp = (char *)icmp_hdr(skb);
> +		struct common_header *h;
> +
> +		iph = (struct iphdr *)(icmp + sizeof(struct icmphdr));
> +		h = (struct common_header *)(icmp + sizeof(struct icmphdr)
> +				+ iph->ihl * 4);

You need to ensure that the comm_header can be accessed linearly. The
icmp_socket_deliver() only guarantees that the full IP header plus 8 bytes
can be accessed linearly.

> +		homa_abort_rpcs(homa, &saddr, ntohs(h->dport), -ENOTCONN);
> +	} else if (type == ICMP_DEST_UNREACH) {
> +		int error;
> +
> +		if (code == ICMP_PROT_UNREACH)
> +			error = -EPROTONOSUPPORT;
> +		else
> +			error = -EHOSTUNREACH;
> +		homa_abort_rpcs(homa, &saddr, 0, error);
> +	} else {
> +		pr_notice("%s invoked with info %x, ICMP type %d, ICMP code %d\n",
> +			  __func__, info, type, code);
> +	}
> +	return 0;
> +}
> +
> +/**
> + * homa_err_handler_v6() - Invoked by IP to handle an incoming error
> + * packet, such as ICMP UNREACHABLE.
> + * @skb:    The incoming packet.
> + * @opt:    Not used.
> + * @type:   Type of ICMP packet.
> + * @code:   Additional information about the error.
> + * @offset: Not used.
> + * @info:   Information about the error that occurred?
> + *
> + * Return: zero, or a negative errno if the error couldn't be handled here.
> + */
> +int homa_err_handler_v6(struct sk_buff *skb, struct inet6_skb_parm *opt,
> +			u8 type,  u8 code,  int offset,  __be32 info)
> +{
> +	const struct ipv6hdr *iph = (const struct ipv6hdr *)skb->data;
> +	struct homa *homa = global_homa;
> +
> +	if (type == ICMPV6_DEST_UNREACH && code == ICMPV6_PORT_UNREACH) {
> +		char *icmp = (char *)icmp_hdr(skb);
> +		struct common_header *h;
> +
> +		iph = (struct ipv6hdr *)(icmp + sizeof(struct icmphdr));
> +		h = (struct common_header *)(icmp + sizeof(struct icmphdr)
> +				+ HOMA_IPV6_HEADER_LENGTH);
> +		homa_abort_rpcs(homa, &iph->daddr, ntohs(h->dport), -ENOTCONN);

This cannot be right; ICMPv6 and ICMP are differ. At this point,
there is no icmphdr anymore, you should obtain the common header from
skb->data + offset.

Also need to ensure that the comm_header can be accessed linearly, only
8 bytes of common_header was checked in icmpv6_notify().

> +	} else if (type == ICMPV6_DEST_UNREACH) {
> +		int error;
> +
> +		if (code == ICMP_PROT_UNREACH)
> +			error = -EPROTONOSUPPORT;
> +		else
> +			error = -EHOSTUNREACH;
> +		homa_abort_rpcs(homa, &iph->daddr, 0, error);
> +	}
> +	return 0;
> +}
> +
> +/**
> + * homa_poll() - Invoked by Linux as part of implementing select, poll,
> + * epoll, etc.
> + * @file:  Open file that is participating in a poll, select, etc.
> + * @sock:  A Homa socket, associated with @file.
> + * @wait:  This table will be registered with the socket, so that it
> + *         is notified when the socket's ready state changes.
> + *
> + * Return: A mask of bits such as EPOLLIN, which indicate the current
> + *         state of the socket.
> + */
> +__poll_t homa_poll(struct file *file, struct socket *sock,
> +		   struct poll_table_struct *wait)
> +{
> +	struct sock *sk = sock->sk;
> +	__u32 mask;
> +
> +	/* It seems to be standard practice for poll functions *not* to
> +	 * acquire the socket lock, so we don't do it here; not sure
> +	 * why...
> +	 */
> +
That's true. sock_poll_wait will first add the socket to a waiting
queue, so that even if an incomplete state is read subsequently, once
the complete state is updated, wake_up_interruptible_sync_poll() will
notify the socket to poll again. (From sk_data_ready .etc)

> +	sock_poll_wait(file, sock, wait);
> +	mask = POLLOUT | POLLWRNORM;
> +
> +	if (!list_empty(&homa_sk(sk)->ready_requests) ||
> +	    !list_empty(&homa_sk(sk)->ready_responses))
> +		mask |= POLLIN | POLLRDNORM;
> +	return (__poll_t)mask;
> +}

 Always writable? At least, you should check the state of the
 socket. For example, is a socket that has already been shutdown still
 writable? Alternatively, how does Homa notify the user when it
 receives an ICMP error? You need to carefully consider the return
 value of this poll. This is very important for the behavior of the
 application.

> +
> +/**
> + * homa_hrtimer() - This function is invoked by the hrtimer mechanism to
> + * wake up the timer thread. Runs at IRQ level.
> + * @timer:   The timer that triggered; not used.
> + *
> + * Return:   Always HRTIMER_RESTART.
> + */
> +enum hrtimer_restart homa_hrtimer(struct hrtimer *timer)
> +{
> +	wake_up_process(timer_kthread);
> +	return HRTIMER_NORESTART;
> +}
> +
> +/**
> + * homa_timer_main() - Top-level function for the timer thread.
> + * @transport:  Pointer to struct homa.
> + *
> + * Return:         Always 0.
> + */
> +int homa_timer_main(void *transport)
> +{
> +	struct homa *homa = (struct homa *)transport;
> +	struct hrtimer hrtimer;
> +	ktime_t tick_interval;
> +	u64 nsec;
> +
> +	hrtimer_init(&hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	hrtimer.function = &homa_hrtimer;
> +	nsec = 1000000;                   /* 1 ms */
> +	tick_interval = ns_to_ktime(nsec);
> +	while (1) {
> +		set_current_state(TASK_UNINTERRUPTIBLE);
> +		if (!exiting) {
> +			hrtimer_start(&hrtimer, tick_interval,
> +				      HRTIMER_MODE_REL);
> +			schedule();
> +		}
> +		__set_current_state(TASK_RUNNING);
> +		if (exiting)
> +			break;
> +		homa_timer(homa);
> +	}
> +	hrtimer_cancel(&hrtimer);
> +	kthread_complete_and_exit(&timer_thread_done, 0);
> +	return 0;
> +}
> +
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_AUTHOR("John Ousterhout <ouster@cs.stanford.edu>");
> +MODULE_DESCRIPTION("Homa transport protocol");
> +MODULE_VERSION("1.0");
> +
> +/* Arrange for this module to be loaded automatically when a Homa socket is
> + * opened. Apparently symbols don't work in the macros below, so must use
> + * numeric values for IPPROTO_HOMA (146) and SOCK_DGRAM(2).
> + */
> +MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_INET, 146, 2);
> +MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_INET6, 146, 2);
> diff --git a/net/homa/homa_utils.c b/net/homa/homa_utils.c
> new file mode 100644
> index 000000000000..6a4f98a2f344
> --- /dev/null
> +++ b/net/homa/homa_utils.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: BSD-2-Clause
> +
> +/* This file contains miscellaneous utility functions for Homa, such
> + * as initializing and destroying homa structs.
> + */
> +
> +#include "homa_impl.h"
> +#include "homa_peer.h"
> +#include "homa_rpc.h"
> +#include "homa_stub.h"
> +
> +struct completion homa_pacer_kthread_done;
> +
> +/**
> + * homa_init() - Constructor for homa objects.
> + * @homa:   Object to initialize.
> + *
> + * Return:  0 on success, or a negative errno if there was an error. Even
> + *          if an error occurs, it is safe (and necessary) to call
> + *          homa_destroy at some point.
> + */
> +int homa_init(struct homa *homa)
> +{
> +	int err;
> +
> +	homa->pacer_kthread = NULL;
> +	init_completion(&homa_pacer_kthread_done);
> +	atomic64_set(&homa->next_outgoing_id, 2);
> +	atomic64_set(&homa->link_idle_time, sched_clock());
> +	spin_lock_init(&homa->pacer_mutex);
> +	homa->pacer_fifo_fraction = 50;
> +	homa->pacer_fifo_count = 1;
> +	homa->pacer_wake_time = 0;
> +	spin_lock_init(&homa->throttle_lock);
> +	INIT_LIST_HEAD_RCU(&homa->throttled_rpcs);
> +	homa->throttle_add = 0;
> +	homa->throttle_min_bytes = 200;
> +	homa->next_client_port = HOMA_MIN_DEFAULT_PORT;
> +	homa->port_map = kmalloc(sizeof(*homa->port_map), GFP_KERNEL);
> +	if (!homa->port_map) {
> +		pr_err("%s couldn't create port_map: kmalloc failure",
> +		       __func__);
> +		return -ENOMEM;
> +	}
> +	homa_socktab_init(homa->port_map);
> +	homa->peers = kmalloc(sizeof(*homa->peers), GFP_KERNEL);
> +	if (!homa->peers) {
> +		pr_err("%s couldn't create peers: kmalloc failure", __func__);
> +		return -ENOMEM;
> +	}
> +	err = homa_peertab_init(homa->peers);
> +	if (err) {
> +		pr_err("%s couldn't initialize peer table (errno %d)\n",
> +		       __func__, -err);
> +		return err;
> +	}
> +
> +	/* Wild guesses to initialize configuration values... */
> +	homa->link_mbps = 25000;
> +	homa->resend_ticks = 5;
> +	homa->resend_interval = 5;
> +	homa->timeout_ticks = 100;
> +	homa->timeout_resends = 5;
> +	homa->request_ack_ticks = 2;
> +	homa->reap_limit = 10;
> +	homa->dead_buffs_limit = 5000;
> +	homa->max_dead_buffs = 0;
> +	homa->pacer_kthread = kthread_run(homa_pacer_main, homa,
> +					  "homa_pacer");
> +	if (IS_ERR(homa->pacer_kthread)) {
> +		err = PTR_ERR(homa->pacer_kthread);
> +		homa->pacer_kthread = NULL;
> +		pr_err("couldn't create homa pacer thread: error %d\n", err);
> +		return err;
> +	}
> +	homa->pacer_exit = false;
> +	homa->max_nic_queue_ns = 5000;
> +	homa->ns_per_mbyte = 0;
> +	homa->max_gso_size = 10000;
> +	homa->gso_force_software = 0;
> +	homa->max_gro_skbs = 20;
> +	homa->gro_policy = HOMA_GRO_NORMAL;
> +	homa->timer_ticks = 0;
> +	homa->flags = 0;
> +	homa->bpage_lease_usecs = 10000;
> +	homa->next_id = 0;
> +	homa_outgoing_sysctl_changed(homa);
> +	homa_incoming_sysctl_changed(homa);
> +	return 0;
> +}
> +
> +/**
> + * homa_destroy() -  Destructor for homa objects.
> + * @homa:      Object to destroy.
> + */
> +void homa_destroy(struct homa *homa)
> +{
> +	if (homa->pacer_kthread) {
> +		homa_pacer_stop(homa);
> +		wait_for_completion(&homa_pacer_kthread_done);
> +	}
> +
> +	/* The order of the following statements matters! */
> +	if (homa->port_map) {
> +		homa_socktab_destroy(homa->port_map);
> +		kfree(homa->port_map);
> +		homa->port_map = NULL;
> +	}
> +	if (homa->peers) {
> +		homa_peertab_destroy(homa->peers);
> +		kfree(homa->peers);
> +		homa->peers = NULL;
> +	}
> +}
> +
> +/**
> + * homa_spin() - Delay (without sleeping) for a given time interval.
> + * @ns:   How long to delay (in nanoseconds)
> + */
> +void homa_spin(int ns)
> +{
> +	__u64 end;
> +
> +	end = sched_clock() + ns;
> +	while (sched_clock() < end)
> +		/* Empty loop body.*/
> +		;
> +}
> +
> +/**
> + * homa_throttle_lock_slow() - This function implements the slow path for
> + * acquiring the throttle lock. It is invoked when the lock isn't immediately
> + * available. It waits for the lock, but also records statistics about
> + * the waiting time.
> + * @homa:    Overall data about the Homa protocol implementation.
> + */
> +void homa_throttle_lock_slow(struct homa *homa)
> +	__acquires(&homa->throttle_lock)
> +{
> +	spin_lock_bh(&homa->throttle_lock);
> +}
> +
> +/**
> + * homa_symbol_for_type() - Returns a printable string describing a packet type.
> + * @type:  A value from those defined by &homa_packet_type.
> + *
> + * Return: A static string holding the packet type corresponding to @type.
> + */
> +char *homa_symbol_for_type(uint8_t type)
> +{
> +	static char buffer[20];
> +
> +	switch (type) {
> +	case DATA:
> +		return "DATA";
> +	case RESEND:
> +		return "RESEND";
> +	case UNKNOWN:
> +		return "UNKNOWN";
> +	case BUSY:
> +		return "BUSY";
> +	case NEED_ACK:
> +		return "NEED_ACK";
> +	case ACK:
> +		return "ACK";
> +	}
> +
> +	/* Using a static buffer can produce garbled text under concurrency,
> +	 * but (a) it's unlikely (this code only executes if the opcode is
> +	 * bogus), (b) this is mostly for testing and debugging, and (c) the
> +	 * code below ensures that the string cannot run past the end of the
> +	 * buffer, so the code is safe.
> +	 */
> +	snprintf(buffer, sizeof(buffer)-1, "unknown(%u)", type);
> +	buffer[sizeof(buffer)-1] = 0;
> +	return buffer;
> +}
> -- 
> 2.34.1
> 

