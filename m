Return-Path: <netdev+bounces-280890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDhnOVGw6mkWCgAAu9opvQ
	(envelope-from <netdev+bounces-280890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 01:50:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C6A458676
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 01:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7C8E3014870
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 23:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D7F377023;
	Thu, 23 Apr 2026 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqI1CcaQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0319355F44
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 23:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776988239; cv=none; b=LPz6WpfEEthevzJQ6jfkiJyVvRjhCEo31aXqw6LBAF4nBiwyrSzXJou6e8FhbLPXKxdkTYtPpdl8srSPDwMLQ2guPQCBWBmCwPlazSFluMIxb8T+KtbwM9QZMOCkuk6nnUk2Tru9UoaI6VBoc3AKC7YffoWeG2UynbhgNUKsjeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776988239; c=relaxed/simple;
	bh=qr2WiQQecuPaUYPjW2Trq7UfNJ9ovwMsgiNRaFaPQVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aoiXOamLb4297sGMICaEUtAxFlU1ZZYC895dX8Sy4q/CpdJLN4z98jbsAk7HRNqHtzXxHzmJza1gj7VRVs4j/XYRinNZyjD6QRG0Ef5muC98wtYnUdCvUY1SMiU57M8CH44/IMiH5PqUurVOvgFNBeV+bHODPSvXenifC5Cz6TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqI1CcaQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488ad135063so64006665e9.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 16:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776988236; x=1777593036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SoJDwPkMJRXAjZ4TZQiCf67HQrUPSbE7YmfZk1PoVRk=;
        b=AqI1CcaQyMh8YEbrdq0G8YCEsRf3xh+tYkfL4vUaPR1OSE96UrMGoYD9aLYczCJKM8
         ofZL5QOKbeHZlxs50fkkPHgF7GdKfL7YlQawGgW+SWJh8AA8FlXhrFilKI48YfKqjFJr
         qk7UZvO0DapMtkky7N3ewiRvT56WLvDUVshhuRx5kzD50MH8wcJQk177JF5SSKfNe1qU
         ytekYc5hLLqfRdxQI3uM7loXgErTRfLc/3i7lpPl1GV5IUe4vvRMBSneEF2gc+JYYioJ
         qGif7jC3O1bVYVCQsMHNRL891Q8iz+ntun4Or7pElbS9+EmkazsjykRxZZirtozhP6V/
         BtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776988236; x=1777593036;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SoJDwPkMJRXAjZ4TZQiCf67HQrUPSbE7YmfZk1PoVRk=;
        b=h87TpyqLCy6X+AjXPkix4rKa2dAlStVcKoEmh98CA7+dw8U39IzsLg2S6bMefbdbsN
         L8FbQBaFWMU9EOeq9D5xg3wO3p++cLiOb23xtLDpD5zJaU7rfiA2Yj6ooP3oP4or21gB
         GLJb0YD25KQb/VE/vYviGdYzhnwi1S4PCWYXSh0hqKySTZe6gdU7bXt5gxOG75kbHCl/
         5/jh4JSabw12BJBjUDzyAKGCCYhBo1paC7wgq3Y07cF0gamdmWRX++0zHsTbmCdMWTPA
         HPHgCUjeU4yXeFDdtIQL3Ey5ybv7lUaF2kubJDnmdEoJaOYv5jfwpuhFNKW2ajdETRiW
         Y5aA==
X-Gm-Message-State: AOJu0YyUCRrZs6STHqo5GL46iAcM95CvqSLkX6V3oS2iqKLhE9lMNQ7a
	eYMCAQGm3cI2lErDB8VzNi3ytRry78f3R3rVV4fXwvvFgpcpZYWXG2FJk9Lufnci
X-Gm-Gg: AeBDiesXic4QY7i2VDNrWk8DJ4/YhgM1DPs517FjMpQHvgdi8/joq4xWerig8QmQoZt
	UPQ25SGC20Tr9CwXrXBPmdx8syoxYz4Y33K6Ahzc4UCuaCmhE3alJBIEZCIeXnC5phSR59Hjd6L
	SqRWzb8in+jLkVuY3beCIO+rjFkQl/nzZGG4Ak89nDTm1F3hFMOowIFuwmx3qRIa+Jmsl8fedlm
	IdVirDICSrWjrsA6xFEMvGtGtreGsxWPm58LOXyXONOSm/IgXOLRIEU+Y2PDmtwXt+SG02R91G0
	/97UJ9GmYCzw8Gdt7ideHII6o7trUbnAtCr3cahmehmRTc5XOx8jtR3Rep7+ujYreI5k6yQOVwm
	/kjaltRdGAnDLyrzRnGu6EDCvdiGSlDgzftWHDuqHADkKJfMy4TFnJ6z4SPYYC87OZb+GDZtewB
	M/DCWysMeAvlSFxHX+dffw1YpJANX7SxPnIq7fFMS3Ytwt+q3HE+Y6YzbQ5PmspnRoy+wl/Sb8w
	C98iWecrK6NTaTQN4yY8UKeVMHY8s4O
X-Received: by 2002:a05:600c:a108:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-488fb78ba6fmr352461715e9.24.1776988236004;
        Thu, 23 Apr 2026 16:50:36 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891f98728dsm97277615e9.23.2026.04.23.16.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 16:50:35 -0700 (PDT)
Message-ID: <8cc73c03-afb6-4b7d-97ea-e05d9cc56c2d@gmail.com>
Date: Fri, 24 Apr 2026 00:50:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v1 1/1] bpf: Fix sk_local_storage diag dumping
 uninitialized special fields
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@kernel.org, kernel-team@meta.com
References: <20260423222356.155387-1-ameryhung@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260423222356.155387-1-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 64C6A458676
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	TAGGED_FROM(0.00)[bounces-280890-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mykytayatsenko5@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]



On 4/23/26 11:23 PM, Amery Hung wrote:
> Call check_and_init_map_value() after the copy_map_value() to zero out
> special field regions. diag_get() copies sk_local_storage map values
> into a netlink message using copy_map_value{_locked}(), which
> intentionally skip special fields. However, the destination buffer from
> nla_reserve_64bit() is not zeroed and the skipped regions contain
> uninitialized skb data can be sent to userspace.
> 
> Fixes: 1ed4d92458a9 ("bpf: INET_DIAG support in bpf_sk_storage")
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>   net/core/bpf_sk_storage.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index 14eb7812bda4..b50d26a542ed 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -558,6 +558,7 @@ static int diag_get(struct bpf_local_storage_data *sdata, struct sk_buff *skb)
>   				      sdata->data, true);
>   	else
>   		copy_map_value(&smap->map, nla_data(nla_value), sdata->data);
> +	check_and_init_map_value(&smap->map, nla_data(nla_value));
>   

I think check_and_init_map_value() should be moved before the
copy_map_value(), because copy_map_value_locked() already uses
spin lock special field, which if uninitialized can deadlock?

>   	nla_nest_end(skb, nla_stg);
>   	return 0;


