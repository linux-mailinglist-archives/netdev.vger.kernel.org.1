Return-Path: <netdev+bounces-273087-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMwGEHouymkA6AUAu9opvQ
	(envelope-from <netdev+bounces-273087-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:04:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABC7356D70
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 185E03021E4A
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 07:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26923A8FF6;
	Mon, 30 Mar 2026 07:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qq9R3UCy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jfh/HxAJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0963A8757
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 07:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774857393; cv=none; b=DiT7WyLj2Uu9ldgWXfBnl2/LYScjtMsP+ZaCX94EqIT1qxpINGMa+0fJPjYsj/A5VVFv6lEo73DliqRIbxlYLRauVrD8Ib53KVO9mORbSGkasKqsaIhnARI4eUjqryEm4hUYj5u51q4hsi970ENuN6tLQsYlKckzMHWQTIlU3q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774857393; c=relaxed/simple;
	bh=aU+2NNvo4O7/xXKAgg9ewUdbqnZsagjlNGGoyKaRs14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dbgXnA1rlG+qS4JSo9jJAA3Qb6hfUidIQp6asfghRbJ9HhXJdIPx984vpirT37vbt9gt0pveSiN52xQ31PmxER1qSMFoQWO661OfbEU16mbz/olGqEoHmFH+SBrXbvxA/U5vM0qnKmvlzzChPEVpYEIYWzR35t6CfyYw4jY17L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qq9R3UCy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jfh/HxAJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774857391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+kIlzFsIxp6fqIHyjYLxiN/9v3HI4JuGZ1vO55yaAPU=;
	b=Qq9R3UCyhuyXJbItj5FcHYRMSLI32Q1z1FI0Nz9Y6eWkWw+xP9EfyA5JSjMnWieN2FRH9p
	ZjC1Tlv+5d+mP4NpuOBNx2cRvkZ4Qe7p/wqfJ57UkCcIWtGVuGerOT39Cdz7TVWFuPvE5l
	9BhhANOkrOiyUQxR282vwR/AaJwLcR8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-lViY2wzgMyy1sh7mA_Whgg-1; Mon, 30 Mar 2026 03:56:30 -0400
X-MC-Unique: lViY2wzgMyy1sh7mA_Whgg-1
X-Mimecast-MFC-AGG-ID: lViY2wzgMyy1sh7mA_Whgg_1774857389
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48553fdd03dso23351335e9.0
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 00:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774857389; x=1775462189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+kIlzFsIxp6fqIHyjYLxiN/9v3HI4JuGZ1vO55yaAPU=;
        b=Jfh/HxAJ/0t3sDpG8AsaJ4l+PWFXaoxbj3ba4JJzvvrBQuQltPnqLVuCx2VENK9Lqc
         34GKbMog4d+AZDpncD7x8Eq87O/27oBN30TXigZD70UyEviV80ZW61ZRa3kFWvlgqz2n
         A3Ly9jbF/aKggUfdfXYDax8396xJb83LX14OEbDvdPtxneZTg69/FrcR3acrQb1KWqzq
         23LakXfOWjPO+N29xBO4baTREbyyt4V8iV0UX13YaFwB4rqG9GgM6A9SEtrb6WdOqdL5
         QqXLsZtJ4lo8ywlp+O0vLuqhgevC6Zeb4bhpFnIQLLBRA9rXC8HJRfm0PlOgBtSjCTZx
         Y7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774857389; x=1775462189;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+kIlzFsIxp6fqIHyjYLxiN/9v3HI4JuGZ1vO55yaAPU=;
        b=U7gulRHI+IYSnOOhbjQjmlTnwHpAk43DGPbytBxpsaSIWzw3ig+wTETJH4mXnQ4bGF
         H9/IJ2CUms76PfdODcoF3BdT6VWU63XEf74E/8er1GfFfY5CQVkvfARbzwuQoAwIwlTl
         zhqLu0IbV8eGezQ9pUZtSsP/DqHmMx7+ggpLjO2Nb4bEsEDsPFbGTK+zDMgDUAFaxz+D
         W+Vr0avoabALbbK+u1Fkm+xVbbvMAs1MI9RFwunlVrYWYHZvvYG0fts6yW82kDyjI1NI
         g4CwvULzpzTxVWNR83/+jFGx3xSu+8I/hwHUR0ls0kf+mzZPMzLC5ZOLAoIOwxlMdRMd
         5ztg==
X-Gm-Message-State: AOJu0YxD3sP6ibXwteezwqNSs3UagCHWWBeQ8u6DQzN3QsJIyRnCF9DH
	94DspuIKz9lU80Sz9MArCvIrwaMftmGGvVpP4apoMs6VoeYo9V0eV7fcgGTi9KbLaHQLioq3ulr
	5L2uBpNPXqDUwfnLNworV3gbFYmfCqYVryyPv6WROFUrapDmTJFXYbSGjMg==
X-Gm-Gg: ATEYQzxWZxif9PJ68A+nxWsqSJdHZCsYAWsokVPB47TuSryVlb6NcBiXuZ1I6ZdfkGJ
	bqLIjgJG78tG9HdLT+PTFxabJOCg/vemGj9Yk42c1iFndWcErx+DG7TZYqpwTDlnv1Ft/pgu0D6
	0XVyi9Tcq7vV8fhiKs7uNIDxufrdDMZlBj/OY7b204w1eQK8fjjK8PHugisIrpYa0lTtzWjOQaI
	JBuvotdcAPs9n1enafwQGYfExJZbycolgMaXHiiCNbAAOg7AAdBlXhstmiFvPRZqS6DNsbmogkl
	Yjn94+U9+S4Isxn7AdFTpjnhcaGLgE8QEsqs+BVXEjqxUCxFra+sOUC55A+63blc+8PyLn/l+id
	094nrQxigV5bYrC/FcFmY9riFmn69jG7D/+XmJdGT+ooKh3Xt8zHv+X16
X-Received: by 2002:a05:600c:3b8f:b0:485:3b00:f93b with SMTP id 5b1f17b1804b1-48727f17f7bmr210372655e9.31.1774857388974;
        Mon, 30 Mar 2026 00:56:28 -0700 (PDT)
X-Received: by 2002:a05:600c:3b8f:b0:485:3b00:f93b with SMTP id 5b1f17b1804b1-48727f17f7bmr210372305e9.31.1774857388490;
        Mon, 30 Mar 2026 00:56:28 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.222])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4873069961esm166932665e9.12.2026.03.30.00.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 00:56:28 -0700 (PDT)
Message-ID: <f73c3cf9-18e9-4109-b173-d6000cb0cf88@redhat.com>
Date: Mon, 30 Mar 2026 09:56:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ipv6: repeat route lookup with saddr set for ECMP
To: Maximilian Moehl <maximilian@moehl.eu>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260329091201.63646-1-maximilian@moehl.eu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260329091201.63646-1-maximilian@moehl.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273087-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,moehl.eu:email,moehl.eu:url]
X-Rspamd-Queue-Id: 8ABC7356D70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/29/26 11:12 AM, Maximilian Moehl wrote:
> When the routing decision involves ECMP, the initial hash is calculated
> with saddr being :: and the decision which interface to select from an
> ECMP group is based on that hash. If the route lookup has to be
> repeated, e.g. because a route was updated, the hash is calculated with
> saddr set to the previously selected address. This can cause the
> selected interface to change, breaking ongoing connections.
> 
> To ensure the initial interface selection is based on an actual saddr
> the route lookup is repeated after the source address selection if a
> hash was calculated.
> 
> Signed-off-by: Maximilian Moehl <maximilian@moehl.eu>
> Link: https://lore.kernel.org/all/aOYLRyIlc7XU7-7n@shredder/
> ---
> I've created a write-up of what I've done, including the steps taken
> to test the patch: https://moehl.eu/blog/linux-ipv6-ecmp-instability.html
> 
>  net/ipv6/ip6_output.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 8e2a6b28cea7..465fce51d017 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1148,6 +1148,18 @@ static int ip6_dst_lookup_tail(struct net *net, const struct sock *sk,
>  			*dst = NULL;
>  		}
>  
> +		/* If ECMP was involved the initial hash was calculted
> +		 * with saddr=:: which can result in instability
> +		 * when it is later re-calculated with the selected
> +		 * saddr. Lookup the route again with the chosen
> +		 * saddr to get a stable result.
> +		 */
> +		if (fl6->mp_hash) {
> +			fl6->mp_hash = 0;
> +			dst_release(*dst);
> +			*dst = NULL;
> +		}
> +
>  		if (fl6->flowi6_oif)
>  			flags |= RT6_LOOKUP_F_IFACE;
>  	}

This apparently breaks ipv6 fib tests (fib_tests.sh):

# IPv6 multipath load balance test
#      TEST: IPv6 multipath loadbalance                          [FAIL]

see
https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style
on how to reproduce the tests.

Also this would deserve additional testcases.

Without diving much inside the code I have the feeling this change is
plugged into the wrong place: multipath selection logic should be
encapsulated by fib6_select_path().

/P


