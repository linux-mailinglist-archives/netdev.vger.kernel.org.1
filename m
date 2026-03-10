Return-Path: <netdev+bounces-265880-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EwGOLGJr2lvaAIAu9opvQ
	(envelope-from <netdev+bounces-265880-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:02:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A28162448EA
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BBD7301AAAE
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4FC3B3C18;
	Tue, 10 Mar 2026 03:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTUdtqMZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9B23AA1BB
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 03:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773111726; cv=none; b=YspLqebYgXI1oORGUjc4tJRm7jNs8nhva8ZNNkHUYAh4aVls7ARi1t2pJio7/9LwDyKQ4yPea68YtTlUwTrneVV7IClIne/nGwPz1ACvJnBMVUBhi3KiwkTIn8qQ696uFICtdDHwQJYwotjrg0H/eoeeZZDkoyMw4FVCaSeuw8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773111726; c=relaxed/simple;
	bh=/HorepIizoh0hKhgpr99KvxAfLGwEIYusSEtJs8vCNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDY61EF/nlD/8G29uQM2if76q0+eikNLQufUUzJhHB16h0xo8TdP3mdTm+BPxhnoQFnJS4BVewSkL2yKS8fz3DkR6pqvDnj+lMLX7YiRtiZWiogdV0EjzYOZDEVx0D/3BVylqUXKGPomV8hglhz78J7PusKIT8QuXpNssA1kpAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTUdtqMZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ae4d48dc2fso39702085ad.3
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 20:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773111724; x=1773716524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LEwKSMSqIEpe5269DAkL86L1DhMYaTmIOzSUDoQBS/g=;
        b=JTUdtqMZ/bVTnc0LWC9LdPJe/SsQ5os4nohO30T6eloEh10wyj8r17b17uJLmWrJw5
         BFMUCFxxQOzwDpW5tXMH9pvHbRLZA1MzSofzxs2BQ1Y7F5vD0ZLxtvDmPK9sZenfKR+T
         v/K+RpwofJjNvoQMrYB/c/kFgohOJP7ujqVuvHvCZI1iRB0rX7xQkcee07SyO48byioO
         DREuJB4GbjRQwfV3yvjSPxq3K9P6n8+z3p0wJbfIraNn824b1ZuXzgsXtO4L4o4lRoH0
         ro+vJL2BmBqfnyzhC0v6ZmQys/50kiGq0NsApmD3bexadnEoAc5n4CCJ+C43lGV+nWCe
         FynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773111724; x=1773716524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LEwKSMSqIEpe5269DAkL86L1DhMYaTmIOzSUDoQBS/g=;
        b=p3gXpSTVio0LsUHYbqWnPTGH89ZYtSAIbQcGSntNu9IwHzvgRcTDt41VwTjjXaY8pg
         xEEp7aJLbb57IxkkpDXgrpQcC8Z9afjdKUJleyiF2n9VzVJT1TwDZCQDKJcLNWYJEvER
         iu/XjcSNPPX9Elq5rlTaHYJ/9KAftDMbEPTDOgD4+V0KP0xeoBQMHaGjZ2Dm4dW+czCv
         Bzpa856xRZgsjQjq1lDL6sVVmK0sX+0ssyX+b+KEbjycs8Vrdj9A1vchnqxqTBsmL0AU
         6kCPRLJrjASGDiIfWRhaK2X8TtO1LcokZkyUAGlWUfm7okx51/Uf7wARqhJkMGuGwXr0
         +wuA==
X-Gm-Message-State: AOJu0YxypxBXw/cXnwTF/xkcjKPi2gBp6JrzASgc2vUdDI1NFhI5pbDH
	wBHFLVwVegDDQNZ7M+JVUn23Q2UA1NMhaVwSb4nybuVNXkHC99HrQebj
X-Gm-Gg: ATEYQzxgkgThwIq78T0lMCEiI5oEl0iULk/DWqso/LMfHMdm2dLDep8KmkqgxdTHope
	COAliaWoWUWa9IgELxHwVy8x49+tZrpnIzsP+Rm5hlikVae7kBOnNL+iDgkFerxU1RUZV7Viroz
	qqZ/dXGLEzT9kOWpDd1vPLWGCzux9uxhOlojKUDxc95NjjGwniIMLAaccGNT2v6YWozZB1Dqtxu
	RtTP9Epb+uHYwqZOf+7ExU7H738dlVyhqjmLybFlOsmORCxIcLurUq+0B+ZNFGZ0uXWWLIzgLUM
	kxiu+HQmHoxzym0E56uhvuJ9EEtT2stnCJYvhXgboO/DCTUyXlJ9+GpXpWxKY4/Ol/Fo3VxDAUl
	S3ho2mk0rH8iCuT3wofiyeJ+YEOStqXWapNkTahhSKvV6rMuG8Saw0CuNv9SPuHS5pqebHsZqlO
	bkMQdMdzMFMW07gpTdBtgzWdXTzac=
X-Received: by 2002:a17:903:4b27:b0:2ae:6317:56e3 with SMTP id d9443c01a7336-2ae824f4d54mr124977875ad.28.1773111724083;
        Mon, 09 Mar 2026 20:02:04 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e9b9c6sm149702665ad.29.2026.03.09.20.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 20:02:02 -0700 (PDT)
Date: Tue, 10 Mar 2026 03:01:55 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Mahesh Bandewar <maheshb@google.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv3 net 1/3] bonding: set AD_RX_PORT_DISABLED when
 disabling a port
Message-ID: <aa-Jo1mn3Cs5FN90@fedora>
References: <20260226125331.28147-1-liuhangbin@gmail.com>
 <20260226125331.28147-2-liuhangbin@gmail.com>
 <942584.1772155015@famine>
 <aaEB6X6WPs7EBM33@fedora>
 <949695.1772167347@famine>
 <aaE32DlfrX9S5KNT@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaE32DlfrX9S5KNT@fedora>
X-Rspamd-Queue-Id: A28162448EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265880-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,if3:email]
X-Rspamd-Action: no action

Hi Jay,

Any comments for this?

Thanks
Hangbin
On Fri, Feb 27, 2026 at 06:21:20AM +0000, Hangbin Liu wrote:
> > 	Such a backup interface is typically carrier up and able to send
> > or receive packets.  The peer generally won't send packets to the backup
> > interface, however, as no traffic is sent from the backup, and the MAC
> > for the bond uses a different interface, so no forwarding entries will
> > direct to the backup interface.
> > 
> > 	There are a couple of special cases, like LLDP, that are handled
> > as an exception, but in general, if a peer does send packets to the
> > backup interface (due to a switch flood, for example), they're dropped.
> 
> OK, this makes sense to me.
> 
> > 
> > >> 	Where I'm going with this is that, when multiple aggregator
> > >> support was originally implemented, the theory was to keep aggregators
> > >> other than the active agg in a state such that they could be put into
> > >> service immediately, without having to do LACPDU exchanges in order to
> > >> transition into the appropriate state.  A hot standby, basically,
> > >> analogous to an active-backup mode backup interface with link state up.
> > >
> > >This sounds good. But without LACPDU exchange, the hot standby actor and
>                          ^^ I mean with LACPDU exchange..
> > >partner should be in collecting/distributing state. What should we do when
> > >partner start send packets to us?
> > 
> > 	Did you mean "should not be in c/d state" above?  I.e., without
> > LACPDU exchage, ... not in c/d state?
> > 
> > 	Regardless, as above, the situation is generally equivalent to a
> > backup interface in active-backup mode: incoming traffic that isn't a
> > special case is dropped.  Normal traffic (bearing the bond source MAC)
> > isn't sent, as that would update the peer's forwarding table.
> > 
> > 	Nothing in the standard prohibits us from having multiple
> > aggregators in c/d state simultaneously.  A configuration with two
> > separate bonds, each with interfaces successfully aggregated together
> > with their respective peers, wherein those two bonds are placed into a
> > third bond in active-backup mode is essentially the same thing as what
> > we're discussing.
> 
> In theory this looks good. But in fact, when we do failover and set the
> previous active port to disabled via
>   - __disable_port(port)
>     - slave->rx_disabled = 1
> 
> This will stop the failover port back to c/d state. For example, in my
> testing (see details in patch 03), we have 4 ports, eth0, eth1, eth2, eth3.
> eth0 and eth1 are agg1, eth2 and eth3 are agg2. If we do failover on eth1,
> when eth1 come up, the final state will be:
> 
> 3: eth0@if3: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP mode DEFAULT group default qlen 1000
>     bond_slave state BACKUP ad_aggregator_id 1 ad_actor_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> ad_partner_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> actor_port_prio 10
> 
> 4: eth1@if4: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP mode DEFAULT group default qlen 1000
>     bond_slave state BACKUP ad_aggregator_id 1 ad_actor_oper_port_state_str <active,short_timeout,aggregating> ad_partner_oper_port_state_str <active,short_timeout,aggregating,in_sync> actor_port_prio 255
> 
> 5: eth2@if3: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP mode DEFAULT group default qlen 1000
>     bond_slave state ACTIVE ad_aggregator_id 2 ad_actor_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> ad_partner_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> actor_port_prio 1000
> 
> 6: eth3@if4: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP mode DEFAULT group default qlen 1000
>     bond_slave state ACTIVE ad_aggregator_id 2 ad_actor_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> ad_partner_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> actor_port_prio 255
> 
> 7: bond0: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
>     bond mode 802.3ad actor_port_prio ad_aggregator 2
> 
> So you can see the eth0 state is c/d, while eth1 state is active, aggregating.
> Do you think it's a correct state?
> 
> Thanks
> Hangbin

