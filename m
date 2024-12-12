Return-Path: <netdev+bounces-151343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFE39EE470
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 11:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3D62829CE
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 10:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200CB20B7F3;
	Thu, 12 Dec 2024 10:46:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868FD1F0E42
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 10:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734000375; cv=none; b=gcgkWRiEWSjfwrhUvzJNh2OjqznPENE0DwT9RlWgJRW9hYVGj4Bzb99/Vjq/4cK4sKTuwmRIoQhDcP/Q09IEvOznd6SFvSHw9hn2V4E0Xy3W+ixMfcgyB4/lcxRvi0APmC+xhFT231cCw0E3PZPb3yiwlzqHukR+x4q0gyTkS9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734000375; c=relaxed/simple;
	bh=vFHvHyjw8Pzj5uQMmfEKwV/QcuKo8q6n0RTSNSh0H4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F5WkgWEGaP684gbZ+hzF7oA3EZ6ZUMQ8zr8X90vjnbvCClSMa2DnZDUxfibmh9vxJ8wOAKrtBT2It9lybqtlRKVm7Y0CWH+TaRRQ2LmJr0EeWS32WtYZmwwRjC+nI7QkxjPU0uxTwbmLt3AJQN4lz9U0xRgZtP22pcVctqTVzAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <f.pfitzner@pengutronix.de>)
	id 1tLghm-0007G9-Qg; Thu, 12 Dec 2024 11:46:02 +0100
Message-ID: <f1aac209-9001-428d-b210-495fe3b28e75@pengutronix.de>
Date: Thu, 12 Dec 2024 11:46:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 iproute] bridge: dump mcast querier state
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com, razor@blackwall.org,
 bridge@lists.linux-foundation.org, roopa@nvidia.com,
 stephen@networkplumber.org, entwicklung@pengutronix.de
References: <20241211072223.87370-1-f.pfitzner@pengutronix.de>
Content-Language: en-US, de-DE
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
In-Reply-To: <20241211072223.87370-1-f.pfitzner@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: f.pfitzner@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Forgot to mention the Acked-by from [1] in the trailer:

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

[1] 
https://lore.kernel.org/netdev/12a687d5-cc87-4993-aec2-07ea799ce334@blackwall.org/#t

On 11.12.24 08:22, Fabian Pfitzner wrote:
> Kernel support for dumping the multicast querier state was added in this
> commit [1]. As some people might be interested to get this information
> from userspace, this commit implements the necessary changes to show it
> via
>
> ip -d link show [dev]
>
> The querier state shows the following information for IPv4 and IPv6
> respectively:
>
> 1) The ip address of the current querier in the network. This could be
>     ourselves or an external querier.
> 2) The port on which the querier was seen
> 3) Querier timeout in seconds
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c7fa1d9b1fb179375e889ff076a1566ecc997bfc
>
> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
> ---
>
> v1->v2
> 	- refactor code
> 	- link to v1: https://lore.kernel.org/netdev/20241025142836.19946-1-f.pfitzner@pengutronix.de/
> v2->v3
> 	- use print_color_string for addresses
> 	- link to v2: https://lore.kernel.org/netdev/20241030222136.3395120-1-f.pfitzner@pengutronix.de/
> v3->v4
> 	- drop new line between bqtb and other_time declarations
> 	- link to v3: https://lore.kernel.org/netdev/20241101115039.2604631-1-f.pfitzner@pengutronix.de/
>
>   ip/iplink_bridge.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 59 insertions(+)
>
> diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
> index f01ffe15..1fe89551 100644
> --- a/ip/iplink_bridge.c
> +++ b/ip/iplink_bridge.c
> @@ -661,6 +661,65 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>   			   "mcast_querier %u ",
>   			   rta_getattr_u8(tb[IFLA_BR_MCAST_QUERIER]));
>
> +	if (tb[IFLA_BR_MCAST_QUERIER_STATE]) {
> +		struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
> +		SPRINT_BUF(other_time);
> +
> +		parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, tb[IFLA_BR_MCAST_QUERIER_STATE]);
> +		memset(other_time, 0, sizeof(other_time));
> +
> +		open_json_object("mcast_querier_state_ipv4");
> +		if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
> +			print_string(PRINT_FP,
> +				NULL,
> +				"%s ",
> +				"mcast_querier_ipv4_addr");
> +			print_color_string(PRINT_ANY,
> +				COLOR_INET,
> +				"mcast_querier_ipv4_addr",
> +				"%s ",
> +				format_host_rta(AF_INET, bqtb[BRIDGE_QUERIER_IP_ADDRESS]));
> +		}
> +		if (bqtb[BRIDGE_QUERIER_IP_PORT])
> +			print_uint(PRINT_ANY,
> +				"mcast_querier_ipv4_port",
> +				"mcast_querier_ipv4_port %u ",
> +				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
> +		if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER])
> +			print_string(PRINT_ANY,
> +				"mcast_querier_ipv4_other_timer",
> +				"mcast_querier_ipv4_other_timer %s ",
> +				sprint_time64(
> +					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]),
> +									other_time));
> +		close_json_object();
> +		open_json_object("mcast_querier_state_ipv6");
> +		if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
> +			print_string(PRINT_FP,
> +				NULL,
> +				"%s ",
> +				"mcast_querier_ipv6_addr");
> +			print_color_string(PRINT_ANY,
> +				COLOR_INET6,
> +				"mcast_querier_ipv6_addr",
> +				"%s ",
> +				format_host_rta(AF_INET6, bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]));
> +		}
> +		if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
> +			print_uint(PRINT_ANY,
> +				"mcast_querier_ipv6_port",
> +				"mcast_querier_ipv6_port %u ",
> +				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
> +		if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER])
> +			print_string(PRINT_ANY,
> +				"mcast_querier_ipv6_other_timer",
> +				"mcast_querier_ipv6_other_timer %s ",
> +				sprint_time64(
> +					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]),
> +									other_time));
> +		close_json_object();
> +	}
> +
>   	if (tb[IFLA_BR_MCAST_HASH_ELASTICITY])
>   		print_uint(PRINT_ANY,
>   			   "mcast_hash_elasticity",
> --
> 2.39.5
>
>
>
-- 
Pengutronix e.K.                           | Fabian Pfitzner             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |


