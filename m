Return-Path: <netdev+bounces-150997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5D69EC4E8
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 07:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C121A160E65
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 06:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66891C4A02;
	Wed, 11 Dec 2024 06:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="v3FMDf8v"
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22911C3314
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 06:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733899166; cv=none; b=VpA0MacAMpb90GGuxEzl+DxxRbFO/WlvWN4NiuBThdgLEjGac5HXu67JAKa2r0oik7PBg3zBbBZbVoHXHKb9Vyw+H9lI7UPbJkPYO0uOdtxWAYegHH3WGTzwe9xQVgyCVuF4Q+1PJc/m4qxXVuifNH+Y7SyURYVypgV6yHQyNpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733899166; c=relaxed/simple;
	bh=WqoQQp+GHA1hCXwmP1vqLKdbTxemr+uf4q80HBGBbuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWh7+a2I9SqG8NeHOHXGye5G4Un1SzolnkbY/U8TVG0QIgMjjMsFSm0mj+QePm3elKxPIcMx3EUiY6TIHKfEb4wFsUaVGACNNvEw0lJ9R5qR71CXHoFuVGs7VvyUExYsoyb0ooLi/rvnNE+DhRFcABx9EeM22au1tglyzgP68QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=v3FMDf8v; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733899156; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=JcIJxRjSmxCAZ7oEPIBHJ64ISvx+Dso5bOBscp9nLto=;
	b=v3FMDf8vAkjaYRqy4RGIIsfyR08Pmp4BUto7t+FDs7VdohJwOuJc4slnPZlG9Yfa7GwZKPpeG3f2rxWiAen3PnH2k/Dhmiu7Szvj290X6XfvgjCgHnJidlyOAHJvXspzDRCH7oKKjpLUxkWXb+TdidlwD+lEOtt9oTzegB2aiKg=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WLHNeFu_1733899155 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Dec 2024 14:39:15 +0800
Date: Wed, 11 Dec 2024 14:39:14 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 11/12] net: homa: create homa_plumbing.c
 homa_utils.c
Message-ID: <20241211063914.GA34839@j66a10360.sqa.eu95>
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

IMMO, Regardless of the scenario you expect to use it in, writing code that
is clearly buggy is always perplexing.

> +	snprintf(buffer, sizeof(buffer)-1, "unknown(%u)", type);
> +	buffer[sizeof(buffer)-1] = 0;
> +	return buffer;
> +}
> -- 
> 2.34.1
> 

