Return-Path: <netdev+bounces-305871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M+P8FOt0TmqINAIAu9opvQ
	(envelope-from <netdev+bounces-305871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 18:03:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC32C728694
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 18:03:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nIqsbGe4;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305871-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305871-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CF8C302B744
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 15:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9338B36B048;
	Wed,  8 Jul 2026 15:33:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3667136F91B
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 15:33:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524793; cv=none; b=V+cjU+HfcQMxvbj/FRQRz+aJNQgx4k0+3tAXerDDhP872z9dErBR/bDkb8pEyWz+kLtTYXtroQvL+ppvaTQLNnlDjnzNw9pNAFFo9cTAhSNEmvTGoSKLDglWIChOZWMqSSOm21VeruXe4q3CLE0oi/L2Zr/RRhrlTjCbGKhfZlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524793; c=relaxed/simple;
	bh=FvCFINBQlUqbvLJs7w+0X27zgAhwPrD/f9x/7MunZtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDEMGZhqDWou3q+73abE/xVeoIw7nR2uPXuCpFmJ8rkQmv2B66MqLg/58XoEaHN6dUPaEBsBTnaielvqHeTx085UdNOxrVqURXKGPgDZ7KYDe5EtMDOJwLK1uXfo/t0Tu7dDJMS4UndiH9LCpoze1TyfP8m4sM7MGNst5bZZtzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIqsbGe4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897F41F000E9;
	Wed,  8 Jul 2026 15:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783524791;
	bh=PEoInttfigly9DIKrnQFetKSy0G/G8k39ORl5O2OvC0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nIqsbGe4ywlajFxchC3jrF/ONzNjl0V8y/UfWjdXfwAI6MnnYISbAxh4oI+1pN/vR
	 P1mAcixQ1wznwxmvT9wSs3+KcPCFTI41WYI02RfrgzBzZulP7VGRHTChs980YkjdTK
	 YCQpbWy7ki8EDjEh8kyYAuolQivE+hUwxTxzN1CuugB9oxRN9JnYyMnb09ExLaNoEv
	 H01HyDUyz10BrfKNcKzcaXof19FwWMv9fcIdzLZ9s6ktH7nKmKQXFEJpvNUcCvdqqI
	 cmGyfsVGTOK40hKFn7aQ98QLKETa6PzuDcD0iyJFMzOMfkXz27MP6H1GbnfHqNI0ao
	 AKp34JWnnhKag==
Message-ID: <95c5e510-34c3-4ba3-9173-3d3954628948@kernel.org>
Date: Wed, 8 Jul 2026 09:33:10 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] ip: add OVPN device mode support
Content-Language: en-US
To: Marco Baffo <marco@mandelbit.com>, netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Antonio Quartulli <antonio@openvpn.net>
References: <20260703111419.842059-1-marco@mandelbit.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260703111419.842059-1-marco@mandelbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305871-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:marco@mandelbit.com,m:netdev@vger.kernel.org,m:stephen@networkplumber.org,m:antonio@openvpn.net,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mandelbit.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC32C728694

On 7/3/26 5:14 AM, Marco Baffo wrote:
> Allow selecting point-to-point or multi-peer mode when creating an
> OVPN device.

iproute2 does not currently support ovpn, so this patch is doing more
than just selecting a mode. It adds support to create ovpn netdevices
via iproute2. Enhance the commit message.

> 
> Signed-off-by: Marco Baffo <marco@mandelbit.com>
> ---
>  ip/Makefile           |  2 +-
>  ip/iplink.c           |  2 +-
>  ip/iplink_ovpn.c      | 87 +++++++++++++++++++++++++++++++++++++++++++
>  man/man8/ip-link.8.in | 24 ++++++++++++
>  4 files changed, 113 insertions(+), 2 deletions(-)
>  create mode 100644 ip/iplink_ovpn.c
> 
> diff --git a/ip/Makefile b/ip/Makefile
> index 3535ba78..978f6841 100644
> --- a/ip/Makefile
> +++ b/ip/Makefile
> @@ -13,7 +13,7 @@ IPOBJ=ip.o ipaddress.o ipaddrlabel.o iproute.o iprule.o ipnetns.o \
>      ipvrf.o iplink_xstats.o ipseg6.o iplink_netdevsim.o iplink_rmnet.o \
>      ipnexthop.o ipmptcp.o iplink_bareudp.o iplink_wwan.o ipioam6.o \
>      iplink_amt.o iplink_batadv.o iplink_gtp.o iplink_virt_wifi.o \
> -    iplink_netkit.o ipstats.o
> +    iplink_netkit.o ipstats.o iplink_ovpn.o
>  
>  RTMONOBJ=rtmon.o
>  
> diff --git a/ip/iplink.c b/ip/iplink.c
> index 3f0b46c9..c6aee8b6 100644
> --- a/ip/iplink.c
> +++ b/ip/iplink.c
> @@ -42,7 +42,7 @@ void iplink_types_usage(void)
>  		"          ifb | ip6erspan | ip6gre | ip6gretap | ip6tnl |\n"
>  		"          ipip | ipoib | ipvlan | ipvtap |\n"
>  		"          macsec | macvlan | macvtap | netdevsim |\n"
> -		"          netkit | nlmon | pfcp | rmnet | sit | team | team_slave |\n"
> +		"          netkit | nlmon | ovpn | pfcp | rmnet | sit | team | team_slave |\n"
>  		"          vcan | veth | vlan | vrf | vti | vxcan | vxlan | wwan |\n"
>  		"          xfrm | virt_wifi }\n");
>  }
> diff --git a/ip/iplink_ovpn.c b/ip/iplink_ovpn.c
> new file mode 100644
> index 00000000..08e59526
> --- /dev/null
> +++ b/ip/iplink_ovpn.c
> @@ -0,0 +1,87 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * iplink_ovpn.c	OpenVPN DCO device support
> + *
> + * Author: Marco Baffo <marco@mandelbit.com>
> + *
> + */
> +
> +#include <stdio.h>
> +#include <string.h>
> +#include <linux/if_link.h>
> +
> +#include "utils.h"
> +#include "ip_common.h"
> +
> +static void print_explain(FILE *f)
> +{
> +	fprintf(f,
> +		"Usage: ... ovpn [ mode { p2p | mp } ]\n"
> +		"\n"
> +		"MODE := p2p | mp\n"
> +		"(p2p is the default if mode is not specified)\n");
> +}
> +
> +static int ovpn_parse_opt(struct link_util *lu, int argc, char **argv,
> +			  struct nlmsghdr *n)
> +{
> +	while (argc > 0) {
> +		if (matches(*argv, "mode") == 0) {
> +			__u8 mode;
> +
> +			NEXT_ARG();
> +			if (strcmp(*argv, "p2p") == 0)
> +				mode = OVPN_MODE_P2P;
> +			else if (strcmp(*argv, "mp") == 0)
> +				mode = OVPN_MODE_MP;

the options need to be a table used for both setting and displaying value.


