Return-Path: <netdev+bounces-302409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y5PhAUVaQWrznwkAu9opvQ
	(envelope-from <netdev+bounces-302409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 19:30:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC546D48A9
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 19:30:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="XK09RP/D";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302409-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302409-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D4E2300BC90
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 17:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324B32BE056;
	Sun, 28 Jun 2026 17:30:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C2228CF5D
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 17:30:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782667842; cv=none; b=LoqyMiQs2n4/GDZdCrVyuRaaG+IIazSGGmDApGtqznykQLoSZL3aQyyX3vijdJkYbCW89w38Y/SH/l6CimHHpS4K9I7mzveFZPf8hjd5SINjeb5TtLth28iywmk8x6uwXb0rYsoa+fhEE5qTntiZoNbvYZAVApgMRXQjzmXCrzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782667842; c=relaxed/simple;
	bh=UOd4PCagrSfLiLuMPu95jDgkFbBWwM/hA8HenaYlzCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C99AcQrGqT3PiNLGsDkDtc1/14DI2mmQPTR2UIiK0kLAxwM5mibXX65vq8nG2dV8ZecZg0U3004DU2860Sr8d1UAfoaMWib7Ob9IQr99c25Hl/eKg33nLt7XZitSWxgG/tS271kgE3VuyWdM5JxLmjbKruAp/yQsayXyB/1gc/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XK09RP/D; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF431F000E9;
	Sun, 28 Jun 2026 17:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782667840;
	bh=vXC5hPpLV+1Ac/7F0+Js4zR9vJrTp00r7bbjd3kswpI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XK09RP/DrrXfmh0fXaiaXPeYViGF2ETbt+JMAsdp7yawpjRAR291VNy/uHE+kRInE
	 FvB9Wu4VSqge6oRAuMjEhG8obws78s314T/betPSVN7P6I13gLuYjfAX3shMHC9kYM
	 AbkjV7sis+VQjEnpUZWpJQaGxmv404ly8G5PlpA0VVR94yfL9kzv2MEKp/Trc9/vMF
	 yuZwUP7b75IvZ0NaqNc6oHwr9TOWTSBmAbybi1o02eLmAlI45OI+/jL060xIvDXd/2
	 f+xKA92QkWU4smu8NHqUSixWtHaoye7Ceu4BN+d5e1Ghmv7lkFLA6WCqhAe6TxDjFD
	 MJwUSaomIvJ1w==
Message-ID: <6b9df322-718e-4515-a944-48122ed8574c@kernel.org>
Date: Sun, 28 Jun 2026 11:30:39 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute-next v3] ipaddress: add support for showing IPv4
 devconf attributes
Content-Language: en-US
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
References: <20260614182515.8765-1-fmancera@suse.de>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260614182515.8765-1-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302409-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:fmancera@suse.de,m:netdev@vger.kernel.org,m:stephen@networkplumber.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,suse.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3FC546D48A9

On 6/14/26 12:25 PM, Fernando Fernandez Mancera wrote:
> This patch introduces support for showing IPv4 devconf attributes on
> detailed output of an interface e.g "ip -d link show dev enp1s0".
> 
> Additionally, this refactors 'print_af_spec()' to sequentially process
> both AF_INET and AF_INET6 attributes rather than returning early if
> AF_INET6 is missing.

refactors should be a separate patch.

> 
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
> v2: changed print_string to print_bool for boolean attributes
> v3: use print_bool for JSON output only
> ---
>  ip/ipaddress.c | 313 ++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 273 insertions(+), 40 deletions(-)
> 
> diff --git a/ip/ipaddress.c b/ip/ipaddress.c
> index 6017bc83..1530b836 100644
> --- a/ip/ipaddress.c
> +++ b/ip/ipaddress.c
> @@ -23,6 +23,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/if_arp.h>
>  #include <linux/if_infiniband.h>
> +#include <linux/ip.h>
>  #include <linux/sockios.h>
>  #include <linux/net_namespace.h>
>  
> @@ -294,53 +295,285 @@ static void print_linktype(FILE *fp, struct rtattr *tb)
>  	close_json_object();
>  }
>  
> +static void print_inet(FILE *fp, struct rtattr *inet_attr)
> +{
> +	struct rtattr *tb[IFLA_INET_MAX + 1];
> +
> +	parse_rtattr_nested(tb, IFLA_INET_MAX, inet_attr);
> +
> +	if (tb[IFLA_INET_CONF]) {
> +		int *conf = RTA_DATA(tb[IFLA_INET_CONF]);
> +		int max_elements = RTA_PAYLOAD(tb[IFLA_INET_CONF]) / sizeof(int);
> +
> +		if (max_elements >= IPV4_DEVCONF_FORWARDING) {
> +			print_bool(PRINT_JSON, "forwarding", NULL,
> +				   conf[IPV4_DEVCONF_FORWARDING - 1]);
> +			print_string(PRINT_FP, "forwarding", "forwarding %s ",
> +				     conf[IPV4_DEVCONF_FORWARDING - 1] ? "on" : "off");
> +		}
> +
> +		if (max_elements >= IPV4_DEVCONF_MC_FORWARDING) {
> +			print_bool(PRINT_JSON, "mc_forwarding", NULL,
> +				   conf[IPV4_DEVCONF_MC_FORWARDING - 1]);
> +			print_string(PRINT_FP, "mc_forwarding", "mc_forwarding %s ",
> +				     conf[IPV4_DEVCONF_MC_FORWARDING - 1] ? "on" : "off");
> +		}
> +
> +		if (max_elements >= IPV4_DEVCONF_PROXY_ARP) {
> +			print_bool(PRINT_JSON, "proxy_arp", NULL,
> +				   conf[IPV4_DEVCONF_PROXY_ARP - 1]);
> +			print_string(PRINT_FP, "proxy_arp", "proxy_arp %s ",
> +				     conf[IPV4_DEVCONF_PROXY_ARP - 1] ? "on" : "off");
> +		}
> +
> +		if (max_elements >= IPV4_DEVCONF_ACCEPT_REDIRECTS) {
> +			print_bool(PRINT_JSON, "accept_redirects", NULL,
> +				   conf[IPV4_DEVCONF_ACCEPT_REDIRECTS - 1]);
> +			print_string(PRINT_FP, "accept_redirects",
> +				     "accept_redirects %s ",
> +				     conf[IPV4_DEVCONF_ACCEPT_REDIRECTS - 1] ? "on" : "off");

As I stated in the last patch for devconf:

"iproute2 follows netdev with coding standards and those need to be
followed as long as humans are in the loop. Please make sure follow on
patches adhere to roughly 80 columns with a little extra if it improves
readability (and of course strings are not broken across lines)."

Use print_on_off for example for these or use a temp variable for the
attributes.



