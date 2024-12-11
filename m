Return-Path: <netdev+bounces-150973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF9D9EC3AB
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 04:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47DBF285D3F
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124472397A6;
	Wed, 11 Dec 2024 03:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhEJtpQ/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03202358A9
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 03:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733888636; cv=none; b=F+vj8VIacUbPI5CkoiLyuY/nKqlz1TmaE2zhN2q3fFtwG2aNk1oaemMhgKICalFb5h6HTjS5w463af6Z/yeXr8FOoWaytZspeVHN6r7j/AqsjncVPN6qFPgmP9Aqe5lEQfpEhluJ0lJwnlez5mWt0QBP5S4o5/Q2khjVC6xiwXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733888636; c=relaxed/simple;
	bh=sdaM6GcyHX7D36rAIgFvRLjb/QFNvhEsn3fidgzFJ1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VDmKgDKi42TsvWvRYyF1uz4sUc7CMsfgrau8AgmX4W7WvRd/7o/VwQv0tRLd+PNtPkNIwaa/+2iS67J7x2Rs6Lx2zZvKjsfuCGU4JUr6Em4c/n2wskuVRGsQhNiXKfIq0xfIA66PsOMvHG+OhHgvBvoJ7unJfQs1eHvZaGeTrIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhEJtpQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1866CC4CED2;
	Wed, 11 Dec 2024 03:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733888635;
	bh=sdaM6GcyHX7D36rAIgFvRLjb/QFNvhEsn3fidgzFJ1Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WhEJtpQ/qk/IYqJ272gkwouLFfb72UEsAmMrb/imcYL6xXGTkQWss/dCbtvexbCju
	 rl0OGbs1hYi/MnDzFU/cRW2Oum3zk4sheMrWQh/3ja9yJO3S6Od3weUjIZBP7JuP8k
	 0t30OMlsuLZBVut6+GcVAPw9+AF5BujZ01gEZ1qhJXatP++dEH91JCMQ96QkLAAalo
	 7+mr1teJeRMmmGjlv8JqTl4N5SV5OGypaGkatHlBz8+sBVHeJB7DlBTXITa6IAEHOu
	 uavmQKQsxk4PKPhqd84elWqbVaoou7+kNB9RXDvPIkBP5ympf491/xrcuVhvrSwSzC
	 oztOhM+03PzvA==
Message-ID: <94af658b-51d6-4e71-9070-3e6a244fe8b1@kernel.org>
Date: Tue, 10 Dec 2024 20:43:54 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [iproute2-next v2] ip: link: rmnet: add support for flag handling
Content-Language: en-US
To: Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
 stephen@networkplumber.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, jiri@resnulli.us, andrew@lunn.ch
Cc: luka.perkov@sartura.hr
References: <20241207220621.3279646-1-robert.marko@sartura.hr>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241207220621.3279646-1-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/7/24 3:05 PM, Robert Marko wrote:
> @@ -26,18 +32,79 @@ static void explain(void)
>  	print_explain(stderr);
>  }
>  
> +static int on_off(const char *msg, const char *arg)
> +{
> +	fprintf(stderr, "Error: argument of \"%s\" must be \"on\" or \"off\", not \"%s\"\n", msg, arg);
> +	return -1;
> +}
> +

not needed once you use ...

>  static int rmnet_parse_opt(struct link_util *lu, int argc, char **argv,
>  			   struct nlmsghdr *n)
>  {
> +	struct ifla_rmnet_flags flags = { 0 };
>  	__u16 mux_id;
>  
>  	while (argc > 0) {
> -		if (matches(*argv, "mux_id") == 0) {
> +		if (strcmp(*argv, "mux_id") == 0) {
>  			NEXT_ARG();
>  			if (get_u16(&mux_id, *argv, 0))
>  				invarg("mux_id is invalid", *argv);
>  			addattr16(n, 1024, IFLA_RMNET_MUX_ID, mux_id);
> -		} else if (matches(*argv, "help") == 0) {
> +		} else if (strcmp(*argv, "ingress-deaggregation") == 0) {
> +			NEXT_ARG();
> +			flags.mask |= RMNET_FLAGS_INGRESS_DEAGGREGATION;
> +			if (strcmp(*argv, "on") == 0)
> +				flags.flags |= RMNET_FLAGS_INGRESS_DEAGGREGATION;
> +			else if (strcmp(*argv, "off") == 0)
> +				flags.flags &= ~RMNET_FLAGS_INGRESS_DEAGGREGATION;
> +			else
> +				return on_off("ingress-deaggregation", *argv);

... parse_on_off for all of the on/off options and then check the return
code. See other users of the function.

--
pw-bot: cr


