Return-Path: <netdev+bounces-264044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHZ3DfGiqGnKwAAAu9opvQ
	(envelope-from <netdev+bounces-264044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 22:24:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A87207EE2
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 22:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1752C303C2BF
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 21:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF4F384249;
	Wed,  4 Mar 2026 21:23:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB0A37F00C
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 21:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772659438; cv=none; b=JKuCk53SnKXFKNs/TenX26Sf0TSs0uhoHHvQ+d+1XgL8tuOwYiGPt3diDMvqwizwoRecGOdYI34cEhLEg/bckg+7yan9mvMYs/wNlFOQfbwRg9PlVKZsziXDgHth8Ed60MNvxHai9SrOPp0DSU3QgrHqWX+qOnYCTuCLlhswqyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772659438; c=relaxed/simple;
	bh=xq0KJBpv1h21TY7b677nnzRlQZCeQWLqlWV6VJ63oBU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YdUo7imGLRdPNG9JhPuTcJt9WJ9GV39IWd/6NhTlJ+DD1j3VprC3/o3+Z5hg3NSWgm3DINmVl7hbhPZXfxvphmuhsQUxWhSlY2kQXMYbUiggZko5NLRLKxuX5FnmOUO2/iG4iKazIt1BzUv9ZwdpTZWiMIMvskYZhjU+fw76I2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-483abed83b6so62057325e9.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 13:23:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772659436; x=1773264236;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkdPeJofE3BWM3ZoX8aOsExlgaSYOax8hV89d1tqZ/4=;
        b=ie9RWdnqyzT5zG7/prDQuAJIIeeIrP5eNxogXIXoI6Uw7Mk2uGj2a65L6D9z+kVZkl
         3mZANsGJl3gleH9fSuuLDVjnc6rGxjGWPa2uCGSnrwaxVx1MuFijnWf/sfU8KxOkVeru
         yVkbv8DL77iqiHAtZr9TXfOs0k0iFCj0MDBejzwqIFQdBLS+nPa3QLmYioH//k9bLmkS
         OoL9rrOjHEjmvOV8z3Kjk3ydYBBABt1scIPLGMaFiztPr7SCftKNJSMOZJnlhVMPNusm
         gFEqGSGqK38TSw8WEQihsFcfTv3Nu2C9rLmm5DPdsMjR4jnZjk4I55AMC+T5zYHy2Sc0
         FAUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNY/msCD4e4XJx0T5grbyrtuwEcJc7xqsixwmF7h7t9UJVkROgVRXhrdMsQf0lQvtTYehzcn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcuL847g06YTHJX5/i0TY/hNpWRFcDzu4pQz9HkhW3PyE6kDr+
	5wdOy8lJmMS3wHXuhwM6gHSe/LwOJyxNVIjDMRfHkHRdp1+UNnGmJzDw
X-Gm-Gg: ATEYQzzigGFcr5DptUyQKabM9z4NeR3dcw5PAqGR49N7WkR21YI6zIqY8D2qvWCkUhu
	BnrnD9ktRf3HZzeTaIi+1E40SOrHSXsBz7qFFYoR+uw9V0jo8V7fHTz7MTmuI8Ri3pwZQbBpCa6
	MoPU/a/vQJaWKhRdT9oaVviOtJnHRSw6dlCbsoarn/9MN0TPEcA/Ypa5NED9sV1noUmbNC9C0R/
	YM5/PWdFGbvF4YjVcMxP5VvIkDEN0DgSiLdJf4E1ibx/Gq0YXr4NIWcO5Y1yKImLGcFw0MI4CXj
	iR43kCg3ydBCjoF5e+VYRpQmyJPPspW1Bj61Lrkot0N8GM3x5FhMxl8brU0GSq0hKRZAj3Oc6/P
	MIKG6HJ9k3odPYTzIjya6yK3zOMcTlTXFuyJ27+Z6V1kFHGBptJiJWN/Msx2XhGGkxwqQsUYJ75
	FYVFXJA6ozJ/6rkQVcvgfgw8nq13n+oPlkynXI2LyGrl49d2T3FRNs
X-Received: by 2002:a05:600c:8b53:b0:47e:e8c2:905f with SMTP id 5b1f17b1804b1-48519832511mr54735035e9.8.1772659435566;
        Wed, 04 Mar 2026 13:23:55 -0800 (PST)
Received: from [192.168.88.241] (37-48-33-87.nat.epc.tmcz.cz. [37.48.33.87])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485187c81adsm77668235e9.6.2026.03.04.13.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 13:23:55 -0800 (PST)
Message-ID: <0d1f4fcc-82dc-42c2-839a-f903128ccfac@ovn.org>
Date: Wed, 4 Mar 2026 22:23:53 +0100
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
 Simon Horman <horms@kernel.org>, dev@openvswitch.org
Subject: Re: [PATCH net-next v5] net: openvswitch: clean up some kernel-doc
 warnings
To: Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org
References: <20260304012437.469151-1-rdunlap@infradead.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260304012437.469151-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 82A87207EE2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_FROM(0.00)[bounces-264044-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ovn.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/4/26 2:24 AM, Randy Dunlap wrote:
> Fix some kernel-doc warnings in openvswitch.h:
> 
> Mark enum placeholders that are not used as "private" so that kernel-doc
> comments are not needed for them.
> 
> Correct names for 2 enum values:
> Warning: include/uapi/linux/openvswitch.h:300 Excess enum value
>  '@OVS_VPORT_UPCALL_SUCCESS' description in 'ovs_vport_upcall_attr'
> Warning: include/uapi/linux/openvswitch.h:300 Excess enum value
>  '@OVS_VPORT_UPCALL_FAIL' description in 'ovs_vport_upcall_attr'
> 
> Convert one comment from "/**" kernel-doc to a plain C "/*" comment:
> Warning: include/uapi/linux/openvswitch.h:638 This comment starts with
>  '/**', but isn't a kernel-doc comment.
>  * Omit attributes for notifications.
> 
> Add more kernel-doc:
> - add kernel-doc for kernel-only enums;
> - add missing kernel-doc for enum ovs_datapath_attr;
> - add missing kernel-doc for enum ovs_flow_attr;
> - add missing kernel-doc for enum ovs_sample_attr;
> - add kernel-doc for enum ovs_check_pkt_len_attr;
> - add kernel-doc for enum ovs_action_attr;
> - add kernel-doc for enum ovs_action_push_eth;
> - add kernel-doc for enum ovs_vport_attr;
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> v5: fix one description (thanks, Ilya);
>     put periods at the end of enum short desriptions;

I don't see this change in the code.  Did you not include it in the patch?
It's a minor thing.  Not sure it's worth a re-spin.

There is also a couple checkpatch warnings for lines with 81 characters, but
I'm not sure if it makes sense to wrap those.  May become harder to read.

Either way:

Acked-by: Ilya Maximets <i.maximets@ovn.org>

