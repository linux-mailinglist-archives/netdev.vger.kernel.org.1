Return-Path: <netdev+bounces-293103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HAiEp6CGWobxQgAu9opvQ
	(envelope-from <netdev+bounces-293103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 14:12:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E6B602101
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 14:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D63130C7C34
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 12:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3422B3DF00E;
	Fri, 29 May 2026 12:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmadams.net header.i=@cmadams.net header.b="nUJ/3ULj"
X-Original-To: netdev@vger.kernel.org
Received: from linode.cmadams.net (linode.cmadams.net [45.33.75.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2303E00A9
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.75.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780056414; cv=none; b=Q1VMQIanTSpAjB3FGPO784il5nIOl6kKMYocsWg4n1NdDcNGe7vFzp5oy5lWkQUVUcnmDayqq/zgHiWgUolrcJX7xpfKXyAXIvmwKcZTorUoXUndQ/7FY2bQtBCEli2V4rjQwgymlXWn8gV6OFU8xTmm/bhpjhMOatORmvjRjVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780056414; c=relaxed/simple;
	bh=CmfOf/VzsMeNZaPI94AnLpxctRBbBpTYldeoUfxWmnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YT3/RMl+tDkd3Rd++RP506vEbltMn7etHJiuxOTQOKEslCRG7Ay+hWw+FUAwXSEti4PxkdQfGo87O7n16lbCg+9qn/FXM1wKwdb1Iyab2GVTdq0FIK5HduGqZ4p1juYHnWAjIS7B/wZj2mKvxH39gzQsQNb4vcmB2trkx4PEEQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmadams.net; spf=pass smtp.mailfrom=cmadams.net; dkim=pass (2048-bit key) header.d=cmadams.net header.i=@cmadams.net header.b=nUJ/3ULj; arc=none smtp.client-ip=45.33.75.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmadams.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmadams.net
Received: from localhost (localhost [127.0.0.1])
	by linode.cmadams.net (Postfix) with ESMTP id 4gRhsw0VDGz6wQT;
	Fri, 29 May 2026 07:06:44 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cmadams.net; h=
	user-agent:in-reply-to:content-disposition:content-type
	:content-type:mime-version:references:message-id:subject:subject
	:from:from:date:date:received:received; s=20220404; t=
	1780056403; x=1780920404; bh=CmfOf/VzsMeNZaPI94AnLpxctRBbBpTYlde
	oUfxWmnk=; b=nUJ/3ULjmrq1DiZLnMBrTRAbNcE+20UU3sDvtJ3MwSEu22MTjLQ
	CcumXsv0c5/Kb8wjzoZgbDTN5iN9xvR45g3IxkY40WRulQrsgEIpB6H+HyqIblaN
	mnjy5Wjj7ZiVG9nkuPwJ3KiWnR99V1KkCBWCyGCeslc1R+nLK/lFJrBT7zaHrPjJ
	gKiB0rq9dLaFnwQN6rigQBC7eDE6M7j//nHmkpRMJ6I56ZkMBYxF6DOP6v8yp0C6
	lUgRVAAh5lao7C6tBEMc23gj7Gi8XclzEk3BBNYUhPwBqLdOfrxjUcxFkWh2a8Iu
	EWk6xK8bxjapqdHkSwyxnhkXVDn4vpuDyNQ==
X-Virus-Scanned: amavisd-new at cmadams.net
Received: from linode.cmadams.net ([127.0.0.1])
 by localhost (linode.cmadams.net [127.0.0.1]) (amavisd-new, port 10031)
 with ESMTP id uZ8WMMUZnTBK; Fri, 29 May 2026 07:06:43 -0500 (CDT)
Received: from cmadams.net (localhost [127.0.0.1])
	by linode.cmadams.net (Postfix) with ESMTP id 4gRhss586Kz6tx7;
	Fri, 29 May 2026 07:06:41 -0500 (CDT)
Date: Fri, 29 May 2026 07:06:41 -0500
From: Chris Adams <linux@cmadams.net>
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org,
	yuhuang@redhat.com, justin.iurman@gmail.com, horms@kernel.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, idosch@nvidia.com, dsahern@kernel.org,
	David Gibson <david@gibson.dropbear.id.au>,
	Beniamino Galvani <bgalvani@redhat.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Andrew Lunn <andrew@lunn.ch>, ihuguet@redhat.com,
	regressions@lists.linux.dev
Subject: Re: [PATCH net v2] Revert "ipv6: preserve insertion order for
 same-scope addresses"
Message-ID: <20260529120641.GA19331@cmadams.net>
Mail-Followup-To: Stefano Brivio <sbrivio@redhat.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	netdev@vger.kernel.org, yuhuang@redhat.com, justin.iurman@gmail.com,
	horms@kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, idosch@nvidia.com,
	dsahern@kernel.org, David Gibson <david@gibson.dropbear.id.au>,
	Beniamino Galvani <bgalvani@redhat.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Andrew Lunn <andrew@lunn.ch>, ihuguet@redhat.com,
	regressions@lists.linux.dev
References: <20260529112357.5079-1-fmancera@suse.de>
 <20260529134045.56330243@elisabeth>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529134045.56330243@elisabeth>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmadams.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cmadams.net:s=20220404];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293103-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,vger.kernel.org,redhat.com,gmail.com,kernel.org,google.com,davemloft.net,nvidia.com,gibson.dropbear.id.au,leemhuis.info,lunn.ch,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@cmadams.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[cmadams.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cmadams.net:email,cmadams.net:mid,cmadams.net:dkim,suse.de:email]
X-Rspamd-Queue-Id: A1E6B602101
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Once upon a time, Stefano Brivio <sbrivio@redhat.com> said:
> On Fri, 29 May 2026 13:23:57 +0200
> Fernando Fernandez Mancera <fmancera@suse.de> wrote:
> 
> > Chris Adams reported that preserving insertion order for same-scope
> > addresses is causing SSH connections to be dropped after stopping a VM
> > while running NetworkManager.
> > 
> > NetworkManager caches the IPv6 address configuration, when a RA arrives,
> > it determines the list of addresses to configure and checks if the
> > addresses are already in the right order in the kernel. If they aren't,
> > NetworkManager removes and re-adds them to achieve the desired order.
> > 
> > As the order changes, NetworkManager is confused and reconfigures the
> > addresses on every update. In addition, this would also affect to cloud
> > tooling that relies on IPv6 addresses order to identify primary and
> > secondaries addresses.
> 
> By the way, I'm still looking into this part, trying to find
> "problematic" examples.
> 
> And I couldn't find any, yet, because it looks like there's always a
> _single_ IPv6 address being used as a secondary for a primary IPv4
> address.

I hit two cases that triggered the behavior:

- after an overnight suspend/resume cycle (not sure if there's a minimum
  time suspended)

- with a bridge NIC, after stopping a VM with a NIC on the bridge (which
  removed an fe80:: link-local address); this is the case I used to
  bisect since it was easy to script

In both cases, the next IPv6 router-advertisement received was what
triggered NetworkManager to replace the current privacy addresses.  This
could be 2-3 minutes after the trigger.

> > This reverts commit cb3de96eea66f5e4a580086c6a1be46e765f97f4.
> > 
> > Fixes: cb3de96eea66 ("ipv6: preserve insertion order for same-scope addresses")
> > Reported-by: Chris Adams <linux@cmadams.net>
> > Closes: https://lore.kernel.org/netdev/20260521135310.GC977@cmadams.net/
> > Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> > ---
> > v2: updated commit description to make it more accurate
> > ---
> >  net/ipv6/addrconf.c                  | 2 +-
> >  tools/testing/selftests/net/ioam6.sh | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> > index 5476b6536eb7..bb84a78b80f6 100644
> > --- a/net/ipv6/addrconf.c
> > +++ b/net/ipv6/addrconf.c
> > @@ -1013,7 +1013,7 @@ ipv6_link_dev_addr(struct inet6_dev *idev, struct inet6_ifaddr *ifp)
> >  	list_for_each(p, &idev->addr_list) {
> >  		struct inet6_ifaddr *ifa
> >  			= list_entry(p, struct inet6_ifaddr, if_list);
> > -		if (ifp_scope > ipv6_addr_src_scope(&ifa->addr))
> > +		if (ifp_scope >= ipv6_addr_src_scope(&ifa->addr))
> >  			break;
> >  	}
> >  
> > diff --git a/tools/testing/selftests/net/ioam6.sh b/tools/testing/selftests/net/ioam6.sh
> > index b2b99889942f..845c26dd01a9 100755
> > --- a/tools/testing/selftests/net/ioam6.sh
> > +++ b/tools/testing/selftests/net/ioam6.sh
> > @@ -273,8 +273,8 @@ setup()
> >    ip -netns $ioam_node_beta link set ioam-veth-betaR name veth1 &>/dev/null
> >    ip -netns $ioam_node_gamma link set ioam-veth-gamma name veth0 &>/dev/null
> >  
> > -  ip -netns $ioam_node_alpha addr add 2001:db8:1::2/64 dev veth0 &>/dev/null
> >    ip -netns $ioam_node_alpha addr add 2001:db8:1::50/64 dev veth0 &>/dev/null
> > +  ip -netns $ioam_node_alpha addr add 2001:db8:1::2/64 dev veth0 &>/dev/null
> >    ip -netns $ioam_node_alpha link set veth0 up &>/dev/null
> >    ip -netns $ioam_node_alpha link set lo up &>/dev/null
> >    ip -netns $ioam_node_alpha route add 2001:db8:2::/64 \
> 
> -- 
> Stefano

-- 
Chris Adams <linux@cmadams.net>

