Return-Path: <netdev+bounces-262195-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA4mLjVKo2nW/AQAu9opvQ
	(envelope-from <netdev+bounces-262195-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:04:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6548E1C7DBD
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8CF033491FD
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 19:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A468335DA5D;
	Sat, 28 Feb 2026 18:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeOnKB9t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDBF33D511
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 18:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772304210; cv=none; b=UeHDeTU9TbxfY7WFHSprb2JKDzUvj9iuQrshrBzKCDdrUMrwZHb8lWwYpz/fbqVBxtzhyAsOT7i3iX+aJvvd2ZVHj3PJeN7sGKsW/SDVJMs6wZj44EcYLonna8ueloOroLIc4MjSv8Dm/UHfdc/V0YmuwhDK7cKFEUBop6+M5Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772304210; c=relaxed/simple;
	bh=irvnFrO1m1ePZjBMkyFmsAXF5Y+2ju6MYE+ttpeufFo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Adl1NA0hvpA7kkyBh6wVmm6zSVrZCqyr63gaee1rhxi+lvqX6XhRYAoxdldbN290iw2ezCSbARYqhimncZr48poY3Un3fOfXBmn/qKYIzwY1nlYtKhtpr3oqSd2k1CVryg9x8xw1EH8Dups1+H4AVhz527lF/ubudHVag6uRk58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeOnKB9t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D64C116D0;
	Sat, 28 Feb 2026 18:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772304210;
	bh=irvnFrO1m1ePZjBMkyFmsAXF5Y+2ju6MYE+ttpeufFo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LeOnKB9tK5rNk2SxRytrkhRy3yL3ow0Nu9wg5er9nXYkgRzFaHWCOIClwNFPcmt/J
	 DTvs4jptmWku78yWxU9w78uoFc1EJ3uJM7dTROPXgrA0JLnB7MDT59JwpJKTV/UAaq
	 Q6/kwzOkcQsXCWDN2fOegnjMJConJsiJPgRP1RM75zP46QV1G/SDk7zNJpSRrXmF68
	 iYIBS7mQD4CWF+D6EY/k2CVxsL9AVEUR6E81nfAkMJ5qzNtgKFjmGckXiN7T/J/sZI
	 YPNexieKwIBVut67RMBkOQrnHU4iIQAgmdKpfOGQQrl5MBVY+iQRReyzil37EJSSON
	 ZG26aCOBQPVTw==
Date: Sat, 28 Feb 2026 10:43:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, tgraf@infradead.org, horms@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
 davem@davemloft.net
Subject: Re: [PATCH 1/2 net-next v2] ipv4: validate IPV4_DEVCONF attributes
 properly
Message-ID: <20260228104328.260172d2@kernel.org>
In-Reply-To: <20260226133949.17070-1-fmancera@suse.de>
References: <20260226133949.17070-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-262195-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6548E1C7DBD
X-Rspamd-Action: no action

On Thu, 26 Feb 2026 14:39:48 +0100 Fernando Fernandez Mancera wrote:
> As the IPV4_DEVCONF netlink attributes are not being validated, it is
> possible to use netlink to set read-only values like mc_forwarding. In
> addition, valid ranges are not being validated neither but that is less
> relevant as they aren't in sysctl.
> 
> To avoid similar situations in the future, define a NLA policy for
> IPV4_DEVCONF attributes which are nested in IFLA_INET_CONF.

Very nice, I think we should drop the Fixes tag tho.
Adding missed validation is always tricky, we don't really want people
to backport this to stable releases, the risk of regression (of broken
user space) is too high. Unless there's some crash this prevents, in
which case we'd need a more targeted fix for just those values in net.

> Please note that MEDIUM_ID is defined as NLA_U32 too because currently
> its usage through netlink is broken for its valid value -1. Modifying
> the type to NLA_S32 would break existing users of set/get netlink
> operation.

Say more? The policy type not matching the accessor used by the kernel
is probably fine in this case (since there's a common accessor used for
all attrs). If it helps the policy, we can use a different type.

> +static const struct nla_policy inet_devconf_policy[IPV4_DEVCONF_MAX + 1] = {
> +	[IPV4_DEVCONF_FORWARDING]			  = NLA_POLICY_RANGE(NLA_U32,
> +									     0, 1),
> +	[IPV4_DEVCONF_MC_FORWARDING]			  = { .type = NLA_REJECT },
> +	[IPV4_DEVCONF_PROXY_ARP]			  = NLA_POLICY_RANGE(NLA_U32,
> +									     0, 1),
> +	[IPV4_DEVCONF_ACCEPT_REDIRECTS]			  = NLA_POLICY_RANGE(NLA_U32,
> +									     0, 1),
> +	[IPV4_DEVCONF_SECURE_REDIRECTS]			  = NLA_POLICY_RANGE(NLA_U32,
> +									     0, 1),
> +	[IPV4_DEVCONF_SEND_REDIRECTS]			  = NLA_POLICY_RANGE(NLA_U32,
> +									     0, 1),
> +	[IPV4_DEVCONF_SHARED_MEDIA]			  = NLA_POLICY_RANGE(NLA_U32,
> +									     0, 1),
> +	[IPV4_DEVCONF_RP_FILTER]			  = NLA_POLICY_RANGE(NLA_U32,
> +									     0, 2),
> +	[IPV4_DEVCONF_ACCEPT_SOURCE_ROUTE]		  = NLA_POLICY_RANGE(NLA_U32,
> +									     0, 1),
> +	[IPV4_DEVCONF_BOOTP_RELAY]			  = NLA_POLICY_RANGE(NLA_U32,
> +									     0, 1),
> +	[IPV4_DEVCONF_LOG_MARTIANS]			  = NLA_POLICY_RANGE(NLA_U32,
> +									     0, 1),
> +	[IPV4_DEVCONF_TAG]				  = { .type = NLA_U32 },
> +	[IPV4_DEVCONF_ARPFILTER]			  = NLA_POLICY_RANGE(NLA_U32,
> +									     0, 1),
> +	[IPV4_DEVCONF_MEDIUM_ID]			  = { .type = NLA_U32 },
> +	[IPV4_DEVCONF_NOXFRM]				  = NLA_POLICY_RANGE(NLA_U32,
> +									     0, 1),
> +	[IPV4_DEVCONF_NOPOLICY]				  = NLA_POLICY_RANGE(NLA_U32,
> +									     0, 1),
> +	[IPV4_DEVCONF_FORCE_IGMP_VERSION]		  = NLA_POLICY_RANGE(NLA_U32,
> +									     0, 3),
> +	[IPV4_DEVCONF_ARP_ANNOUNCE]			  = NLA_POLICY_RANGE(NLA_U32,
> +									     0, 2),
> +	[IPV4_DEVCONF_ARP_IGNORE]			  = NLA_POLICY_RANGE(NLA_U32,
> +									     0, 8),
> +	[IPV4_DEVCONF_PROMOTE_SECONDARIES]		  = NLA_POLICY_RANGE(NLA_U32,
> +									     0, 1),
> +	[IPV4_DEVCONF_ARP_ACCEPT]			  = NLA_POLICY_RANGE(NLA_U32,
> +									     0, 1),
> +	[IPV4_DEVCONF_ARP_NOTIFY]			  = NLA_POLICY_RANGE(NLA_U32,
> +									     0, 1),
> +	[IPV4_DEVCONF_ACCEPT_LOCAL]			  = NLA_POLICY_RANGE(NLA_U32,
> +									     0, 1),
> +	[IPV4_DEVCONF_SRC_VMARK]			  = NLA_POLICY_RANGE(NLA_U32,
> +									     0, 1),
> +	[IPV4_DEVCONF_PROXY_ARP_PVLAN]			  = NLA_POLICY_RANGE(NLA_U32,
> +									     0, 1),
> +	[IPV4_DEVCONF_ROUTE_LOCALNET]			  = NLA_POLICY_RANGE(NLA_U32,
> +									     0, 1),
> +	[IPV4_DEVCONF_IGMPV2_UNSOLICITED_REPORT_INTERVAL] = { .type = NLA_U32 },
> +	[IPV4_DEVCONF_IGMPV3_UNSOLICITED_REPORT_INTERVAL] = { .type = NLA_U32 },
> +	[IPV4_DEVCONF_IGNORE_ROUTES_WITH_LINKDOWN]	  = NLA_POLICY_RANGE(NLA_U32,
> +									     0, 1),

The indentation is rather awkward, please adjust to fit the common case
on one line and special case the long ones.

	// mis-adjust when needed
	[IPV4_DEVCONF_PROMOTE_SECONDARIES] = NLA_POLICY_RANGE(NLA_U32, 0, 1),
	// common / normal case
	[IPV4_DEVCONF_ARP_ACCEPT]	= NLA_POLICY_RANGE(NLA_U32, 0, 1),
	[IPV4_DEVCONF_ARP_NOTIFY]	= NLA_POLICY_RANGE(NLA_U32, 0, 1),
	[IPV4_DEVCONF_ACCEPT_LOCAL]	= NLA_POLICY_RANGE(NLA_U32, 0, 1),
	...
	// overflow type fully to next line if doesn't fit even mis-adjusted
	[IPV4_DEVCONF_IGMPV2_UNSOLICITED_REPORT_INTERVAL] =
		{ .type = NLA_U32 },
	[IPV4_DEVCONF_IGMPV3_UNSOLICITED_REPORT_INTERVAL] =
		{ .type = NLA_U32 },
	[IPV4_DEVCONF_IGNORE_ROUTES_WITH_LINKDOWN] =
		NLA_POLICY_RANGE(NLA_U32, 0, 1),
-- 
pw-bot: cr

