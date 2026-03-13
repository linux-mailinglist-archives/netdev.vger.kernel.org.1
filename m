Return-Path: <netdev+bounces-267456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAAIFSQUtGlkgwAAu9opvQ
	(envelope-from <netdev+bounces-267456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:41:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE642284164
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA3C3311D0C7
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 13:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B9339F17D;
	Fri, 13 Mar 2026 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ibl/Eflx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F5A39EF2C;
	Fri, 13 Mar 2026 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408416; cv=none; b=BzFTDMliOd6iJCCnUY/o5mwplxDFg6olAJLo1shxjZA0MBXDSn59dNC4cZ7du2K0CX7wOaI0QXw/LoVvPq8uaOrZkZObTLgoaN6Mriq5w3YDY5Jj/ajDaVX9tbfpiXDx9KwBPsDM0j8zY8j5z3z6MLc1WMTLXj65AhPsbGeUD98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408416; c=relaxed/simple;
	bh=F9cOpm8W4P/nWFLXyOd/EvHTLgFjGGk8Em0lkrGtBaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1Tdk6vZvY5Xl7fCckc9/AjrdTyhBnCM8U0zWjGb9us8UMBUdYhDsGCUQA2TQedYCw1/tXTlgnm5Wi0WsLsOWkIWinZKDFJQNGmm/JAVnabTTk14QS+ljJ93S3qP+vaoMkIYTS5vGT1H6aWRm+wyylVDMcdbq1saIyEZt3cEnco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ibl/Eflx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57948C2BC86;
	Fri, 13 Mar 2026 13:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773408416;
	bh=F9cOpm8W4P/nWFLXyOd/EvHTLgFjGGk8Em0lkrGtBaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ibl/EflxRAb1s/BT2MHYRKpmtqYS73HREXhQgZx8x0LcHDJXgosjHtLczbZaOCMH1
	 5Tsyz6DIYA/ZTPA1VG+sUVG5BbErRSsISmHfMdLxjEfAxaICS+0OOFlIHeOGQznebB
	 geR3Bs9MsQ01rLEPPheFrzz9ZVv5bG79TPTCwiKb7OAtXjgYAD9akGZtYr+2WuHOWW
	 MdF5R4qLOn7ggSnyn3qNZDyKuVNs+NRRO2O2a2PRBK/Fn5AwN2tWyBnZnodNC6ivi2
	 oXcKKk04A5vMivrYpcEwP4yzANTrnEquzSc4ofcaMH4slibHBSv5S/Mtjq7S8MZSUB
	 eqmrs6ivFWLmQ==
Date: Fri, 13 Mar 2026 13:26:51 +0000
From: Simon Horman <horms@kernel.org>
To: cedric.jehasse@luminex.be
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v8 1/2] net/sched: cls_flower: remove unions
 from fl_flow_key
Message-ID: <20260313132651.GX461701@kernel.org>
References: <20260311-net-next-mv88e6xxx-tcam-v8-0-32dd5ba30002@luminex.be>
 <20260311-net-next-mv88e6xxx-tcam-v8-1-32dd5ba30002@luminex.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-net-next-mv88e6xxx-tcam-v8-1-32dd5ba30002@luminex.be>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,mojatatu.com,resnulli.us,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-267456-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE642284164
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 11:46:18AM +0100, Cedric Jehasse via B4 Relay wrote:
> From: Cedric Jehasse <cedric.jehasse@luminex.be>
> 
> When creating a flower classifier with an ipv4 address the
> flow_dissector has both FLOW_DISSECTOR_KEY_IPV4_ADDRS and
> FLOW_DISSECTOR_KEY_IPV6_ADDRS bits set in used_keys.
> This happens because ipv4/ipv6 fields are a union and
> FL_KEY_SET_IF_MASKED() will interpret either being set as both.
> 
> Removing the unions fixes this behavior without needing special handling
> for union fields.
> 
> Example of a command that caused FLOW_DISSECTOR_KEY_IPV4_ADDRS and
> FLOW_DISSECTOR_KEY_IPV6_ADDRS to be set:
> tc filter add dev p1 ingress protocol ip flower skip_sw \
>     dst_ip 224.0.1.129 action trap
> 
> Signed-off-by: Cedric Jehasse <cedric.jehasse@luminex.be>

Hi Cedric,

This doesn't seem to be the right approach to me.

It seems to me that the use of a union is intentional here, as either IPv4
or IPv6 addresses can be present in each case - never both.  And that
control.addr_type and enc_control.addr_type are intended to allow
differentiation of the address type in use for each of these unions.

> ---
>  net/sched/cls_flower.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
> index 7669371c1354..b95dbe847dde 100644
> --- a/net/sched/cls_flower.c
> +++ b/net/sched/cls_flower.c
> @@ -59,18 +59,14 @@ struct fl_flow_key {
>  	struct flow_dissector_key_eth_addrs eth;
>  	struct flow_dissector_key_vlan vlan;
>  	struct flow_dissector_key_vlan cvlan;
> -	union {
> -		struct flow_dissector_key_ipv4_addrs ipv4;
> -		struct flow_dissector_key_ipv6_addrs ipv6;
> -	};
> +	struct flow_dissector_key_ipv4_addrs ipv4;
> +	struct flow_dissector_key_ipv6_addrs ipv6;
>  	struct flow_dissector_key_ports tp;
>  	struct flow_dissector_key_icmp icmp;
>  	struct flow_dissector_key_arp arp;
>  	struct flow_dissector_key_keyid enc_key_id;
> -	union {
> -		struct flow_dissector_key_ipv4_addrs enc_ipv4;
> -		struct flow_dissector_key_ipv6_addrs enc_ipv6;
> -	};
> +	struct flow_dissector_key_ipv4_addrs enc_ipv4;
> +	struct flow_dissector_key_ipv6_addrs enc_ipv6;
>  	struct flow_dissector_key_ports enc_tp;
>  	struct flow_dissector_key_mpls mpls;
>  	struct flow_dissector_key_tcp tcp;
> 
> -- 
> 2.43.0
> 
> 

