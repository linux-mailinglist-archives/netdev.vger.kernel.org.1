Return-Path: <netdev+bounces-251883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIkoAnvZcGnCaQAAu9opvQ
	(envelope-from <netdev+bounces-251883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:49:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C349657E94
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D987D6C94C7
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030534921B8;
	Wed, 21 Jan 2026 13:27:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E85F425CF9
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769002077; cv=none; b=Tz8vbZVx+5NTR037UIOypt4vZ1d8n9+uT864LM1olUYj3R8f2jBGvw12HcqANyRadh/pWRZVG/O+ASKPqWeasZO2nhnlM4PyMO4UxDU5vvz6+NX1WInzDlc7kV04ri4AKddB8xYkcKimwdmmwat6iAVfuqaTXWmjbb3qh4LBHls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769002077; c=relaxed/simple;
	bh=+xLDP7DX7iz20dWhxbuzm73inOklopBrSRyKFFW+WAs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rkxMz9IJntwHP25zNYsAEkPa1hZdK0J0y1cxjHD4u7qxwCIo93RrdoJ6/vQH2QpfqnzEJaBjtVGbYxDLwbVKkioxZZXiMx8/ovlTPpvsrqoOQhae/u6fuhfby3vI/0/fAUQU+GSXuVb6kfAd5iO4BNgHDQqL+vQS+53HQwrDbEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-42fbc305882so3779318f8f.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 05:27:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769002074; x=1769606874;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWO5Uw8XBJXe4ZNQIQY5/AKSRQT+aTg8/6WbXvOnHBg=;
        b=F2SD5OTTDiwNJdeUSfQ1j3yBI5N0IEm6dn3puqmHdwREkrtlJbsNMHNcFEff1vfj0w
         P3JpuSPO4VGNJ3RuJKhwrOF7Gmd4fDn2Q1hQysEs/jo7qNo1cKsHdoOAp8AdwwOX23lD
         tM7Y2DPrkt6ERmur7OEmRHJ9oAstCPLmgF+jM2eMbwBh3AbKN7PNVP93YFet9cAfYKpF
         OFT3QlQbOJAaJvt3M6e0nFD06MRF8rXK9I/8WgckT/UA//YSV1O9mJKl1A6vli1oPRoS
         PKWsADPROpDfMpYUq1gchEwAu4Vm4C3hCLZzomrAYb6pyuKZWtU/CxcnYGOeussbcwo0
         uJgA==
X-Forwarded-Encrypted: i=1; AJvYcCXzT5oRhfrn859sV/pJ5BtqEsjVI0bxphKc9YpgfiStgXGvMXN49nq+BCvsiSJNB7H/Nl8lcxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHhNBXWrf+62Yt8t95xWWuJ/2kvaxu9uXabE1BS8gr3D3DdfJC
	7hjK7MoCPtAMbQ6QPecxYQbHO+GlIlZbGT261E/MVyvd08trprJaCf8D
X-Gm-Gg: AZuq6aKGikYwe86N7KNFzbPtF3ZyHupMFYo2A8+22IbDDvIyviJJ/WbrtZ3qJEJq6LM
	FGioFQwNmDPVTt6rRQWTXTMWa0TNbgRIl+zkeWjsSZxFJOcy4Nhm7+6YODwfEsQvxeG+0YapbIE
	VjIkCzXityiUA8vqxOiJea2ya2u4S1EN+uzkSRKuBNNwgjWxy2BUzWOiQyNnvi90hKFKRA44yww
	WcVOJDZVMEu+kXfNSXtO1zK+2LZa51kEblvoHIm9TsvO5UDdKU38pkQC+4S1u5g94mS1oD0N28C
	MXRveXGkyOJ+0UnBCNSjSlzU8i+kw2NQ6pPTrV9O6b+fX2VtZxYpqzfBJn3iu8sa0qf0bv7zSk6
	NrDXJoRxfwwNZFdaIHlTfFgeoMkVonLKtRCZfSBScobDEsaWCcm55QU1kurzR4vFLoZ47a+rI4J
	vD2i2EY4QibZVpvWv4BbyyljLu73rTsjbOt1s8+37GcKxc/5s=
X-Received: by 2002:a05:6000:2511:b0:431:8ec:9372 with SMTP id ffacd0b85a97d-43569bd24e8mr23826997f8f.55.1769002073599;
        Wed, 21 Jan 2026 05:27:53 -0800 (PST)
Received: from [192.168.88.241] (89-24-32-126.nat.epc.tmcz.cz. [89.24.32.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997ed8bsm37397405f8f.36.2026.01.21.05.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 05:27:53 -0800 (PST)
Message-ID: <a71f371d-7f80-4660-ab4c-b022468c6dff@ovn.org>
Date: Wed, 21 Jan 2026 14:27:51 +0100
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
 Simon Horman <horms@kernel.org>, wangchuanlei <wangchuanlei@inspur.com>,
 dev@openvswitch.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: openvswitch: fix data race in
 ovs_vport_get_upcall_stats
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
References: <20260121072932.2360971-1-mmyangfl@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260121072932.2360971-1-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.26 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251883-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[ovn.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,ovn.org:email,ovn.org:mid]
X-Rspamd-Queue-Id: C349657E94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/21/26 8:29 AM, David Yang wrote:
> In ovs_vport_get_upcall_stats(), some statistics protected by
> u64_stats_sync, are read and accumulated in ignorance of possible
> u64_stats_fetch_retry() events. These statistics are already accumulated
> by u64_stats_inc(). Fix this by reading them into temporary variables
> first.
> 
> Fixes: 1933ea365aa7 ("net: openvswitch: Add support to count upcall packets")
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
> v1: https://lore.kernel.org/r/20260119181339.1847451-1-mmyangfl@gmail.com
>   - use u64 instead of __u64
>  net/openvswitch/vport.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
> index 6bbbc16ab778..f0ce8ce1dce0 100644
> --- a/net/openvswitch/vport.c
> +++ b/net/openvswitch/vport.c
> @@ -310,22 +310,23 @@ void ovs_vport_get_stats(struct vport *vport, struct ovs_vport_stats *stats)
>   */
>  int ovs_vport_get_upcall_stats(struct vport *vport, struct sk_buff *skb)
>  {
> +	u64 tx_success = 0, tx_fail = 0;
>  	struct nlattr *nla;
>  	int i;
>  
> -	__u64 tx_success = 0;
> -	__u64 tx_fail = 0;
> -
>  	for_each_possible_cpu(i) {
>  		const struct vport_upcall_stats_percpu *stats;
> +		u64 n_success, n_fail;
>  		unsigned int start;
>  
>  		stats = per_cpu_ptr(vport->upcall_stats, i);
>  		do {
>  			start = u64_stats_fetch_begin(&stats->syncp);
> -			tx_success += u64_stats_read(&stats->n_success);
> -			tx_fail += u64_stats_read(&stats->n_fail);
> +			n_success = u64_stats_read(&stats->n_success);
> +			n_fail = u64_stats_read(&stats->n_fail);
>  		} while (u64_stats_fetch_retry(&stats->syncp, start));

Would be good to have an empty line here for readability, but a new version
just for this seems a bit excessive.

Either way:

Acked-by: Ilya Maximets <i.maximets@ovn.org>

> +		tx_success += n_success;
> +		tx_fail += n_fail;
>  	}
>  
>  	nla = nla_nest_start_noflag(skb, OVS_VPORT_ATTR_UPCALL_STATS);


