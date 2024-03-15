Return-Path: <netdev+bounces-80018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7CB87C7A8
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 03:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5773282227
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 02:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814CE6FA9;
	Fri, 15 Mar 2024 02:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1HnPqT0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0FE944F
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 02:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710470732; cv=none; b=uMgSIBdxDIDYpNSGBA0yNABKRNTFjyYJD9XunYZGqvWrRqn6ValX3riqNKVjchSrkuC9ClLpu0npQU6WuQvZOhrqz4hKkAzsvg+zKB5MI4A50rf/OUzvZ/8p+EkYp0g65Ju3HaMhsK0s8r9QZtehS5nJbwUVzFJ00nw4hZdVjDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710470732; c=relaxed/simple;
	bh=nrqstIYQv8wLB0Fb8FY1KeWno9/TiQAuPO8tnCwrrDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZnbXQCq5YCen26yNyRtRBcqZ38jpnYkAbFm3FJtE9FeeZImC9Xn12H++/fiOXy3/4O1NcOLiYAvWGE2zqwglmP6uoskH3pURO2QiUAcCBA8jJLqDiHs3xLmt0akvFJDrWvyTiWk2Wqu2WFDSJsysSBB972GK3pTcAW9U662XKBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1HnPqT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6288AC433C7;
	Fri, 15 Mar 2024 02:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710470731;
	bh=nrqstIYQv8wLB0Fb8FY1KeWno9/TiQAuPO8tnCwrrDs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u1HnPqT0EDalAmTW4Xxb4AOJ/MZqSepNX0UH1uLtYq/7D4TofKDH2dLUOK6ycqkJ+
	 +pNpZYMQiqDBTOhY87jSi6R3n0AK7IpOhVpfh6zbFDAdCzPfmPe2XZT7MnNeu/hxws
	 +BFoCztjwuzacNPNF5Odjs6A3NhyyFZ68rPfH9nQcADmEpj2xIuWqIBvA5LdJy/dNf
	 443tv48/yyeX4iEs7eE/b6rtHjWhh5LQOKLc2am/6cSb2SIRclFo60u9hTPkr6laCb
	 y3e9GO2Lf66ORAgtHx+0vB0rgij8h9vVuhS7wob1sLuu2bywJQfKtXEzDeyVZEI3KY
	 W482b4L0yR6wg==
Message-ID: <e83198a3-d529-4271-9315-f7eda9477840@kernel.org>
Date: Thu, 14 Mar 2024 20:45:30 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ip link: hsr: Add support for passing information
 about INTERLINK device
Content-Language: en-US
To: Lukasz Majewski <lukma@denx.de>, Andrew Lunn <andrew@lunn.ch>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
References: <20240308145729.490863-1-lukma@denx.de>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240308145729.490863-1-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/8/24 7:57 AM, Lukasz Majewski wrote:
> diff --git a/ip/iplink_hsr.c b/ip/iplink_hsr.c
> index 76f24a6a..dc802ed9 100644
> --- a/ip/iplink_hsr.c
> +++ b/ip/iplink_hsr.c
> @@ -21,12 +21,15 @@ static void print_usage(FILE *f)
>  {
>  	fprintf(f,
>  		"Usage:\tip link add name NAME type hsr slave1 SLAVE1-IF slave2 SLAVE2-IF\n"
> -		"\t[ supervision ADDR-BYTE ] [version VERSION] [proto PROTOCOL]\n"
> +		"\t[ interlink INTERLINK-IF ] [ supervision ADDR-BYTE ] [ version VERSION ]\n"
> +		"\t[ proto PROTOCOL ]\n"
>  		"\n"
>  		"NAME\n"
>  		"	name of new hsr device (e.g. hsr0)\n"
>  		"SLAVE1-IF, SLAVE2-IF\n"
>  		"	the two slave devices bound to the HSR device\n"
> +		"INTERLINK-IF\n"
> +		"	the interlink device bound to the HSR network to connect SAN device\n"
>  		"ADDR-BYTE\n"
>  		"	0-255; the last byte of the multicast address used for HSR supervision\n"
>  		"	frames (default = 0)\n"
> @@ -82,6 +85,12 @@ static int hsr_parse_opt(struct link_util *lu, int argc, char **argv,
>  			if (ifindex == 0)
>  				invarg("No such interface", *argv);
>  			addattr_l(n, 1024, IFLA_HSR_SLAVE2, &ifindex, 4);
> +		} else if (strcmp(*argv, "interlink") == 0) {
> +			NEXT_ARG();
> +			ifindex = ll_name_to_index(*argv);
> +			if (ifindex == 0)
> +				invarg("No such interface", *argv);
> +			addattr_l(n, 1024, IFLA_HSR_INTERLINK, &ifindex, 4);
>  		} else if (matches(*argv, "help") == 0) {
>  			usage();
>  			return -1;
> @@ -109,6 +118,9 @@ static void hsr_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>  	if (tb[IFLA_HSR_SLAVE2] &&
>  	    RTA_PAYLOAD(tb[IFLA_HSR_SLAVE2]) < sizeof(__u32))
>  		return;
> +	if (tb[IFLA_HSR_INTERLINK] &&
> +	    RTA_PAYLOAD(tb[IFLA_HSR_INTERLINK]) < sizeof(__u32))
> +		return;
>  	if (tb[IFLA_HSR_SEQ_NR] &&
>  	    RTA_PAYLOAD(tb[IFLA_HSR_SEQ_NR]) < sizeof(__u16))
>  		return;
> @@ -132,6 +144,10 @@ static void hsr_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>  	else
>  		print_null(PRINT_ANY, "slave2", "slave2 %s ", "<none>");
>  
> +	if (tb[IFLA_HSR_INTERLINK])
> +		print_color_string(PRINT_ANY, COLOR_IFNAME, "interlink", "interlink %s ",
> +				   ll_index_to_name(rta_getattr_u32(tb[IFLA_HSR_INTERLINK])));
> +
>  	if (tb[IFLA_HSR_SEQ_NR])
>  		print_int(PRINT_ANY,
>  			  "seq_nr",


Please update the man page as well, man/man8/ip-link.8.in.

pw-bot: cr

