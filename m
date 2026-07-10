Return-Path: <netdev+bounces-306491-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id omh5BLa/UGoT4gIAu9opvQ
	(envelope-from <netdev+bounces-306491-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:47:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CA27393CC
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:47:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=FZUpuGPg;
	dmarc=pass (policy=none) header.from=debian.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306491-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306491-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 222D5301C13C
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 09:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CA43BFE5B;
	Fri, 10 Jul 2026 09:46:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED8B3F8714;
	Fri, 10 Jul 2026 09:46:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676796; cv=none; b=aQWtgfKkTWg6dmXeG4ve1FEPbhl2eZJMciBkyfXUANXUDMPNQ7c2O5KyhW6OpCIx5+9UOBxGgGBqBSmNrL5LKW40Ph/C9H21UdERmbqVX0H+GabgUVVGRZ18cKLeN+kUFke2b0I9gzvPCmVE3PAQcuLYGS4GhJ+rvplylMXF7SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676796; c=relaxed/simple;
	bh=p0NxnEfNhAwI3WU6RORtdiyzcTedpHqA7e3KLA5Iz9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiCnEcZViS17mcxKEsrqVkrhomnWMbeyiTuvJN0MuZMhLz6jPL7mp+d0mA8cLWmeHW93xf/A+ZUMl7RrRB9htfKVAHqnpTmWrZ3dDC26HMyJ4BH45Oj/+2l+iiClOMnURDnRvdsK+h5nKVipdz6wRpOlDh6iQudbMJXsKUXAffc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=FZUpuGPg; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=EhQ2I3q+YKXCeDbrDh0iyFCogiPPaeKikSbK+vrN1dw=; b=FZUpuGPgcJ8W1THWtOu4Ws40n/
	z3AwvmpFtwZNYbJZabWERR4bcOXC6P0nKqZLY2nJhOZ/8K9Ezmx+jqBxqANeUgWDXUdjaPUY5kXVB
	sZPTVtZm1OY1Vo3AtV7iDXY5hRrMB1TzWHzj2/+FykulOvLoW1xSqFme7ux++QmUGeTr51C+zmnj9
	rsJVdMOTbfYkLYvRDFMsvp283Ts2CXBLZc66+WL7tlNXyyJtmZIXG7R/ctYBNBZXCp3PfcrVq9qEe
	sOPX9Znkjmgmduy5haFpT+SXyS42n3CnLEsEl7YRKZ4D//1DTetIhzyTHY3j0niaeYuYvnZBPYSuq
	pcYIXXvg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wi7oM-004OCb-1L;
	Fri, 10 Jul 2026 09:46:22 +0000
Date: Fri, 10 Jul 2026 02:46:17 -0700
From: Breno Leitao <leitao@debian.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	asantostc@gmail.com, gustavold@gmail.com, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next v2 0/8] netconsole: stop charging netpoll users
 for netconsole-only data
Message-ID: <alC5pjeFfFnBuipL@gmail.com>
References: <20260702-netconsole_move_more-v2-0-1ebedd921dcb@debian.org>
 <akuUkNgyjVOTHMuz@gmail.com>
 <1bfad1f6-6947-47a4-9dc0-72b4c16fc395@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1bfad1f6-6947-47a4-9dc0-72b4c16fc395@redhat.com>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306491-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,lunn.ch,vger.kernel.org,gmail.com,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:asantostc@gmail.com,m:gustavold@gmail.com,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0CA27393CC

On Thu, Jul 09, 2026 at 12:20:24PM +0200, Paolo Abeni wrote:
> > @@ -335,17 +340,15 @@ static void refill_skbs_work_handler(struct work_struct *work)
> >  static void netconsole_skb_pool_init(struct netconsole_target *nt)
> >  {
> > -	skb_queue_head_init(&nt->np.skb_pool);
> > -	INIT_WORK(&nt->np.refill_wq, refill_skbs_work_handler);
> > -	refill_skbs(&nt->np);
> > +	skb_queue_head_init(&nt->skb_pool);
> > +	INIT_WORK(&nt->refill_wq, refill_skbs_work_handler);
> > +	refill_skbs(nt);
> >  }
> Can this race with target teardown?
> If a network device linked to a deactivated target is unregistered, it queues
> the target on target_cleanup_list and schedules
> netconsole_process_cleanups_core(), which executes netconsole_skb_pool_flush()
> under rtnl_lock.

Let me think about it.

Sashiko said:

> Can this race with target teardown?
> If a network device linked to a deactivated target is unregistered, it
> queues the target on target_cleanup_list and schedules
> netconsole_process_cleanups_core(), which executes
> netconsole_skb_pool_flush() under rtnl_lock.

Correct. This is the summary of the code:



static void netconsole_process_cleanups_core(void) {
	ASSERT_RTNL();
	mutex_lock(&target_cleanup_list_lock);
	list_for_each_entry_safe(nt, tmp, &target_cleanup_list, list) {
		netconsole_skb_pool_flush(nt);
	..
}

> Concurrently, if a user enables the target via configfs
> enabled_store(), netconsole_skb_pool_init() is called.

Correct. The code is:

static ssize_t enabled_store(struct config_item *item,
	dynamic_netconsole_mutex_lock();
	netconsole_skb_pool_init(nt);
	...
}


> Because this initialization happens before acquiring rtnl_lock inside
> netpoll_setup(), enabled_store() can execute INIT_WORK() and
> skb_queue_head_init() simultaneously with the cleanup thread executing
> cancel_work_sync() and skb_queue_purge_reason() on the exact same
> fields.

So, it seems they can execute in parallel, given that the device might
be in the cleanup list, and, configfs might be toggling it up.

I don't think this is a big issue, given worst case scenario, the pool
will not be populated, but this seems a clear regression.

> Does this initialization need to be moved inside the rtnl_lock
> protected region to avoid data corruption?

This refactor genuinely did move the pool init out of netpoll_setup()'s
RTNL coverage — before the series, __netpoll_setup() did the
skb_queue_head_init/INIT_WORK under RTNL, giving blanket mutual
exclusion with the notifier.

I don't think I want to have the initialization under RTNL, given this
is a heavy lift. At the same time, I don't have a clear view on how to
solve it. Maybe getting the target_cleanup_list_lock() at skb pool
initializion (which seems ugly as hell).

Anyway, let me spend some tokens on it, and see if I can figure out
a better plan.

Thanks for raising this up,
--breno

--
pw-bot: cr

