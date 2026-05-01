Return-Path: <netdev+bounces-283257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id m3uVAkHn9Gm9FgIAu9opvQ
	(envelope-from <netdev+bounces-283257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 19:47:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A514AEA20
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 19:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51B9F30066B1
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 17:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB784258EC2;
	Fri,  1 May 2026 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epC2OfdX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B929221ADC7
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777657661; cv=none; b=uB6CPY57S7icftBy76VBNlXHAWx+6nT0lFF6rLseP6jETXKH56UaSgJoLWczxmgWDeQsgCUyHh0yPe3sZeM5yZnL1hBhhDOAAE58SFfk4rOsR169GB98NuiQ0W+h84RLnN2g8F6t+rnJ5HuuWi8XS+HCRCDTnxUNjPGj7e7aoFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777657661; c=relaxed/simple;
	bh=bhJldRImlh0oNHY8ZrSWdYN+3XaJAItl0r7oPTpjHeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CG6Tm4aaGCSdi1g6stOQWemnLvsbg+30ffGMQUEOxDZ+guFwBc318UDMEpESkZe5VeNPvEoosl+yPMljZlqpHff47QFL6VMriWJhT6bqO7p6DCT5J853VdiQSVRE5mnKnON+A3933T+GAyr4bUN/N11AZBHhaJS0LCnFCAnHwng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epC2OfdX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BFBC2BCB4;
	Fri,  1 May 2026 17:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777657661;
	bh=bhJldRImlh0oNHY8ZrSWdYN+3XaJAItl0r7oPTpjHeE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=epC2OfdXe9IgrtyoAYoYf1JvwrJGbXa0QpgVJgeSp/Kc4HP2T4yuIZrSz6E52lqLH
	 Qd8yoyyeqFYKkDmf67Xy6PfmZUcmas4aGzv7ga/jSAbFbL/f+bVT8Q4KEibmNDLMlp
	 +tiX1pV+AM44YvNjWxLyTRr+x0Q3IeIPGkDIo/kGPG/BbZ6A9NGS6w16An4NkFcPSr
	 bTHdBx/w+W9O7tsUqZqWBpiXh+7VrXdD8FvCU8TXm3T+KCpAh4S2ffJgTwDraplivN
	 FwtM5kKuEWc5EfA8VfON6aoIwIfdQMNmmGqfO+84a/QrMBwXqrVN3MGoqUY5IlisQY
	 AuKSo9DvX90aw==
Message-ID: <1c2fb5a2-6756-4a76-91b3-f1ef578ba8a3@kernel.org>
Date: Fri, 1 May 2026 11:47:40 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 1/5] netshaper: Extract parse_scope() and
 parse_rate() helpers
Content-Language: en-US
To: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org, pabeni@redhat.com, kuba@kernel.org,
 ernis@linux.microsoft.com
References: <20260501011611.3533573-1-mohsin.bashr@gmail.com>
 <20260501011611.3533573-2-mohsin.bashr@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260501011611.3533573-2-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 82A514AEA20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283257-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On 4/30/26 7:16 PM, Mohsin Bashir wrote:
> diff --git a/netshaper/netshaper.c b/netshaper/netshaper.c
> index 47fb805e..1603e6e5 100644
> --- a/netshaper/netshaper.c
> +++ b/netshaper/netshaper.c
> @@ -47,6 +47,28 @@ static const char *net_shaper_scope_names[NET_SHAPER_SCOPE_MAX + 1] = {
>  	"node"
>  };
>  
> +static int parse_scope(const char *str)
> +{
> +	if (strcmp(str, "netdev") == 0)
> +		return NET_SHAPER_SCOPE_NETDEV;
> +	if (strcmp(str, "queue") == 0)
> +		return NET_SHAPER_SCOPE_QUEUE;
> +	if (strcmp(str, "node") == 0)
> +		return NET_SHAPER_SCOPE_NODE;
> +	return -1;

net_shaper_scope_names exists. Create 1 table used for both parsing and
printing.

> +}
> +
> +static int parse_rate(const char *str, __u64 *rate_bps)
> +{
> +	if (get_rate64(rate_bps, str)) {
> +		fprintf(stderr, "Invalid rate value \"%s\"\n", str);
> +		return -1;
> +	}
> +	/* get_rate64 returns bytes/sec, convert to bits/sec */
> +	*rate_bps *= 8;

no magic numbers. Add a define for BITS_PER_BYTE to include/utils.h
above BIT()

