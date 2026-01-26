Return-Path: <netdev+bounces-253465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIVCAsZdd2n8eQEAu9opvQ
	(envelope-from <netdev+bounces-253465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 13:27:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8496488328
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 13:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AE0C30495ED
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77603358D1;
	Mon, 26 Jan 2026 12:25:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA0F3358BF
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 12:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769430356; cv=none; b=r0OYog+8+pcaiibotauu3d8nFTXaHgBBSkwL8iokRXb+adIfiQP6kj2vOJz3mur09cGhFGy74rVlLf0hBFEtrGzdAgZtAvHVL3czXMm2DEekLhs/ChL2BUEtIGcM7kV4FPfMTVxQtWPwjdZXSpP/EvP/GyMnl3WQZfrLcWITkQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769430356; c=relaxed/simple;
	bh=Tol2D0UUKgnElwspHO4oAoPbXyUIAtSVUeDa/3dmqNE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nQdh7OGnd6OFKL6fdGnXzPlRvAQzCrqhY6GhA65CSPB1tTp1ql3xAGO5VVxo4d5bU1jZCRwCppncTGxdaG2D3TdTvmrGNia7XbEOYt/Wf6rCF8+8lqjiIw5SzMGqslSQaw8TziJdsivq51ejjyvJkZHHA4YkblSo7nq4Svtjjv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-432d2670932so4115042f8f.2
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 04:25:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769430353; x=1770035153;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MTYGg5SKUzZv66l3pNcVuWuyE3pu8jkipLOkl4ABZ8=;
        b=D4L2gVQdDQm4wOy6kc5st6kSXm7D5YUqeI7HUM3Cv3TJWWgh5Le8ZHvDOnMJNj7IWD
         ZSqITa9zQaC6u+0JOkZhUUae3cxVhvHbNKRJLJTq0kw1NYMhHmxaW9YWWMmu3Hf1FekE
         V7k7yPRKLqdRy7ng3gcDxB2Tn0br8ygfweWQJawC+e/6vZDTKHLWrHgQuHr3I/HNxXAj
         S7fytK3GVkN4Gj9+15LCfSE+zc3Y3hJhGc1vjfjd6bYvRAqfqYFAeSZUjR6eGC/+2ot9
         LkM14vt13O1rbASIp360bi2k/fXchoXPRNeOlfRh6w1SCs4pzI87OZ9PoTK6Di+iJaod
         s9CA==
X-Forwarded-Encrypted: i=1; AJvYcCXmdr0nvq98PmaRCDPsB11hkybWIuYdtukEC9PruqCH9Aan7Ta6F1yODMRnOusrRMJRkoJchJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YynK8zPccuBUjPs6dIcnq/uHg50qeQ25cSOwhLB4Rnu9Ot4/f66
	nD8sz85ghuFza/lSF3X2S+IauxQ9bLBU2fmt8hUpOJFvATXvmzVAknD2
X-Gm-Gg: AZuq6aLInqj4Id2+JLhB6Pcn5yXAeR/k6DhbExz+TzEVFllJuTZZG/mcBiIVVTzP3za
	GhM2beAmEMC+MuTCtTgAbNH/NGTGshnkNop+UIgY1A1aoUUnxBRvB27vGsCTEj1G3r4G2tE0nj3
	84IA57iro7Gpmp/xqlKmWls5JnlxkM5rXp/BmZlvokBsgfMJoMsWOdB3TFbQfkBzR0Q3wlL2lyI
	f86qqroiumwmeHFqWBfuv8xUpE0wszHIxIgbZjcxqvjXGJIXQa1+PI5mkfS6pFYS32HjRV42Zav
	ZZxUesW2qWZhnyCAJ4Wi+g17bR8Ocgdw6o5wNqb9hOGkkhno7fR45jPo2eAhIL1i6W3JRrxsQ0I
	FoPnTj3uGFFvO4rso8djQ5xX7J0nX74bYUV9FbT6mojGPnzgPMmDpTVqRLoTmzpfX/BCvxK/S0B
	Laz5OTMD65CHfbbKm+v+XtAE9TiOiIrRjKVqumL9S1j/sZRiM=
X-Received: by 2002:a05:6000:2486:b0:42b:2ee0:569f with SMTP id ffacd0b85a97d-435ca193bd6mr7503212f8f.33.1769430353117;
        Mon, 26 Jan 2026 04:25:53 -0800 (PST)
Received: from [192.168.88.241] (89-24-32-126.nat.epc.tmcz.cz. [89.24.32.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f745c5sm30780216f8f.32.2026.01.26.04.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 04:25:52 -0800 (PST)
Message-ID: <f1fdd80c-e93b-4c48-a354-af560dae3368@ovn.org>
Date: Mon, 26 Jan 2026 13:25:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, dev@openvswitch.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/7] net: openvswitch: fix load tearing with
 u64_stats
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
References: <20260123162159.2877941-1-mmyangfl@gmail.com>
 <20260123162159.2877941-5-mmyangfl@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260123162159.2877941-5-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253465-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[ovn.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8496488328
X-Rspamd-Action: no action

On 1/23/26 5:21 PM, David Yang wrote:
> On 64bit arches, struct u64_stats_sync is empty and provides no help
> against load/store tearing. struct copying should not be considered
> tear-free. Use u64_stats_reads() instead.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  net/openvswitch/datapath.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> index d5b6e2002bc1..8ba94df7f942 100644
> --- a/net/openvswitch/datapath.c
> +++ b/net/openvswitch/datapath.c
> @@ -770,7 +770,8 @@ static void get_dp_stats(const struct datapath *dp, struct ovs_dp_stats *stats,
>  
>  		do {
>  			start = u64_stats_fetch_begin(&percpu_stats->syncp);
> -			local_stats = *percpu_stats;
> +			u64_stats_reads(&local_stats, percpu_stats,
> +					sizeof(local_stats));

I suppose, you'll either need to use offset of 'syncp' field here,
or copy fields one by one, which is not great.

Best regards, Ilya Maximets.

>  		} while (u64_stats_fetch_retry(&percpu_stats->syncp, start));
>  
>  		stats->n_hit += local_stats.n_hit;


