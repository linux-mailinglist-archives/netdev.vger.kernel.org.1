Return-Path: <netdev+bounces-267762-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bsxUJH2HtWn11QAAu9opvQ
	(envelope-from <netdev+bounces-267762-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:06:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 045CE28DC64
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C82D301738C
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8D82F83A0;
	Sat, 14 Mar 2026 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdllJmcA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C3E2DEA8C
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773504375; cv=none; b=gCF2Shdle0/TBdt41QzPlE8RuGQCROg58FvWoH5qfvVKYpYeVgJ3jT67EAtuDoQKsnb5zPUqVgYoMdUJOqIAuCcorJ+eGLGKMgWfrHIRaGJm0Sp6ueHlO+Dp1Ggo9iIjVLFYQPGIhWMBbMq6xkOQPIKYjVxXNPUKDlS71BY9ex8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773504375; c=relaxed/simple;
	bh=5iT9f/SQfYrkwdPGbepNnEtTWPIA6guAy88FhJub868=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ewHZq6FSmw6ytrDomTmMho7xH0wme+VYw6r5YXfkj00j98OzuSPfvQ3rUqORa0uxtAOARHp1tmSf6cYFanB6E1Zmmcxnuifclq3wcgLZ6aza5w8zd023rwxvBvD+0HbtnR2muyVhYeNKAcB2Yg12C2eLTz7/mAVh+AC6fiacmps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdllJmcA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0EDBC116C6;
	Sat, 14 Mar 2026 16:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773504375;
	bh=5iT9f/SQfYrkwdPGbepNnEtTWPIA6guAy88FhJub868=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HdllJmcARJv8aPShIldh6My2Qwkimi8CpUEeJK1N/jka0+PG2H9XjFyWgVbTmFzMu
	 c7jU1dMTmg4KJB1sTovyRPl0ByUSgNh8T0B26BUXU+bHFE/4PFfJ/7++KaUE7LSviU
	 8dzYQvVQKm54QOunglS+CzlI6bF7CUCR8QSjuSHtUtleuNz/dSqaKVhVVc//ljQzUZ
	 6I7GNIpJ9xE042EpvPBCK3hMRLJ/2DgyZlnWh9CKP6gVNqUNEwJiNgpzN/Sjsmf6DP
	 Km0/Ec620rMMqYF/CsCHy9g1xm2cq7hFE8OoYkDxlLY8qrXpsTCavUQdSRmaOay3vV
	 O/00MzlHej4sQ==
Date: Sat, 14 Mar 2026 09:06:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 tgraf@infradead.org, horms@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net
Subject: Re: [PATCH net v4] ipv4: bump rt_genid when a relevant devconf
 value changes through netlink
Message-ID: <20260314090614.116f38cc@kernel.org>
In-Reply-To: <633f5de1-daeb-48ac-aba1-92b3c3ccf5c8@suse.de>
References: <20260313144555.4956-1-fmancera@suse.de>
	<1644761b-4960-431f-bf3d-5593007212fc@kernel.org>
	<633f5de1-daeb-48ac-aba1-92b3c3ccf5c8@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-267762-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 045CE28DC64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026 16:13:20 +0100 Fernando Fernandez Mancera wrote:
> > Also, you are flushing the cache for more values than sysfs does.  
> 
> I don't think so. The problem is that the handling of sysctl is 
> scattered in several places.
> 
> IPV4_DEVCONF_FORWARDING is flushed at devinet_sysctl_forward().
> 
> IPV4_DEVCONF_NOXFRM, IPV4_DEVCONF_NOPOLICY, 
> IPV4_DEVCONF_PROMOTE_SECONDARIES, IPV4_DEVCONF_ROUTE_LOCALNET, and 
> IPV4_DEVCONF_DROP_UNICAST_IN_L2_MULTICAST are flushed at 
> ipv4_doint_and_flush() used by macro DEVINET_SYSCTL_FLUSHING_ENTRY.
> 
> Finally, IPV4_DEVCONF_BC_FORWARDING and IPV4_DEVCONF_ACCEPT_LOCAL are 
> flushed at devinet_conf_proc().
> 
> Yes, I know, the fact that they are scattered around is quite confusing. 
> This could be all unified in a single place but that would be too much 
> for net tree IMHO.
> 
> Please let me know if I am missing something.

I think David means that for some knobs procfs only flushes when value
changes "in one direct", eg

                if (i == IPV4_DEVCONF_ACCEPT_LOCAL - 1 ||                       
                    i == IPV4_DEVCONF_ROUTE_LOCALNET - 1)                       
                        if ((new_value == 0) && (old_value != 0))               
                                rt_cache_flush(net);       

which means only flush on the 1 -> 0 transition.

