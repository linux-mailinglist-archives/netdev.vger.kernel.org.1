Return-Path: <netdev+bounces-279858-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPA/Fq1h5mm6vgEAu9opvQ
	(envelope-from <netdev+bounces-279858-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:26:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87398431309
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC0783697FC4
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F1B33DEF2;
	Mon, 20 Apr 2026 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddaCCu1m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F73D336EE1
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699847; cv=none; b=ZQDrxkNBY3+hhG5gwVnG/m+keP09ecHkFR+RMkkgksIglH9xDf6Caxcj5hhismxINQ1OHQocdMUixzuwNV32+zOjayrTanu2ikLDMD5iizemeS2j0MWll9RYP4MbObczfn2hfcCxIKjBwac5eOzEMPIONFCu7h2iX3Nsb7cHhtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699847; c=relaxed/simple;
	bh=1k1hp7u43c9TkJzzlgOWfZ4UDE8HfeeU5PBzOa6ytCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyDCPqAQwopoYxx5YjHOYfmIN7L3z1f4WQvNeixvbMt8Es2VnwJN2o6GlKgdATqlpupDTOpMSsDV4b7TWypMbfQrEb9ho0TJSIDzH6D3dATyo0nTZEsinmz4luNOG4Ccs09z7KrZYzsb3q8ZjzEOiZdQ6y9uZ1sXGX58CW5lDgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddaCCu1m; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7dca4debedaso2036676a34.2
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 08:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776699845; x=1777304645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HMCNN46uzvkkx+pdzNFwcf4+qGVUVpMcwYXyw94YpJA=;
        b=ddaCCu1mxfBzDYB2X/p0fburKPAT65PTMdudfokAeUhIlkTD4afM8MFwjvCsf3Cs6U
         iZYZJqq8dpZwcIJvzVdqYE0SoifFK+oFiSasZoVVXVT0ozrc+/pBG6lkhAYjjPgIwD8G
         2yTjPsH/2nlHlQ38YI3F15Q+fO4BMWE9aYHS4UTpgXDnq/oLWxCxfuXDcoathnrmCSrr
         SP0Z0F7/6mGnqoGNbjPR2yXwp8jNpu3SJMjv0SJj6oQBRoC3pXI5Xn4Jj5/7fiydOzF4
         f661Go+L7Po5qbqE4r30R+Oz0MK4ZjDNS3oFzRRfzscNdS1f0Zaw3GQwiAxSNKbUGXsu
         nBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776699845; x=1777304645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMCNN46uzvkkx+pdzNFwcf4+qGVUVpMcwYXyw94YpJA=;
        b=ClBL/0FhTlKORkitqXsY4/1Gl7BfHctPx+kLBOkAg35fqTkLsRACAGQCRtZ9GUHzOg
         PVsZ1bPlq3G0hpz4MWwJygabhwJKri6n5YYma0Cm6bu2NKzOgyhim8K622EDYidKDRjT
         0sP2Nh73vBhuDHvjmwpCCyddkaOAk4JUe9ZHu8p4FvUKTo2PDs44KJIYmtrhdR3cTNPY
         6dJbio7WAscGWC5d7O2u6aNVq6FurmsZJ4Bo2PKgvh9gGXwJqHFVJUf+DuZsAYWsMp00
         e5NHjTYSw/T+0pBaxVN/w41Vw85UjBKbtbxzD1G4s+VMl659uZrKqMkDHz64Fk69mStt
         Dj0w==
X-Forwarded-Encrypted: i=1; AFNElJ8R42pcRHnfKikRBiUz9p6u4lokWk6rJgydW1mzCNC4nmlX0RshwJyByh2PFArY3Kz+r4R6tuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdPmM2/LfnMdSTjc9WCsnwS+5Xe1SN02N+KqX1QA6pjYZJf6Jl
	ot56Sn64JwYHOPEYdgGQqOhhn7O/86+yoQsaUnlEcX3GLwiPbIkZ5J5Q
X-Gm-Gg: AeBDieuoxW4+ik90ZYSEJgFjoFmrr+FSQfzl/I/MkYYdu7j2mb+ntRvKX78lNpP1vQX
	rTWC6lwii1jUi8yFkD8hjiNR1DlUUP0SS/7ZNfOSB3ROSOuZ5CUj7WtGkrRO+xBDzur3ee/g7p6
	6MhF4T7FDzdnMG0CXpiZCo2uonZiWC8+n9KfYtWu1tUyID4GTzw5cYClxlWqSNf5A2hx5TVqfpW
	8/jDCPP43hI8/0hLQ7Wyb0iUJm1vxUUzCK3f+3eHysss1Ajvhh7g+nZbJ5NR3lA35MykLPwnMNk
	2wcqSg8WpwuiEAVMJUuNSFoSHYyxjQdL+N88YCNmx8I/39Ldl7dKm1Az4XzBdE9QUXrwUBg5u9b
	PSD//IC1zc9tDFnJ1Z32jFcFg7UJ7f6EDNpha13if4HWKas4wYHTx52UweRPRGoASjA6Nx2T0Gy
	YWpAB4h2tN8muQOcT00ZDs0rOutnVIZG417gPWZw==
X-Received: by 2002:a05:6830:310d:b0:7dc:283:8988 with SMTP id 46e09a7af769-7dc951f3503mr8846792a34.19.1776699845320;
        Mon, 20 Apr 2026 08:44:05 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:7::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc975034e7sm8780521a34.6.2026.04.20.08.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 08:44:04 -0700 (PDT)
Date: Mon, 20 Apr 2026 08:44:04 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net 2/4] xsk: free the skb when hitting the upper bound
 MAX_SKB_FRAGS
Message-ID: <aeZJh5O7oWG6zYXt@devvm17672.vll0.facebook.com>
References: <20260418045644.28612-1-kerneljasonxing@gmail.com>
 <20260418045644.28612-3-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260418045644.28612-3-kerneljasonxing@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279858-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devvm17672.vll0.facebook.com:mid]
X-Rspamd-Queue-Id: 87398431309
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/18, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Fix it by explicitly adding kfree_skb() before returning back to its
> caller.
> 
> How to reproduce it in virtio_net:
> 1. the current skb is the first one (which means xs->skb is NULL) and
>    hit the limit MAX_SKB_FRAGS.
> 2. xsk_build_skb_zerocopy() returns -EOVERFLOW.
> 3. the caller xsk_build_skb() clears skb by using 'skb = NULL;'. This
>    is why bug can be triggered.
> 4. there is no chance to free this skb anymore.
> 
> Note that if in this case the xs->skb is not NULL, xsk_build_skb() will
> call xsk_drop_skb(xs->skb) to do the right thing.
> 
> Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/xsk.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 8fcde34aec7b..5d3dbb118730 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -778,8 +778,11 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  	addr = buffer - pool->addrs;
>  
>  	for (copied = 0, i = skb_shinfo(skb)->nr_frags; copied < len; i++) {
> -		if (unlikely(i >= MAX_SKB_FRAGS))
> +		if (unlikely(i >= MAX_SKB_FRAGS)) {
> +			if (!xs->skb)
> +				kfree_skb(skb);
>  			return ERR_PTR(-EOVERFLOW);
> +		}
>  
>  		page = pool->umem->pgs[addr >> PAGE_SHIFT];
>  		get_page(page);
> -- 
> 2.41.3
> 

As mentioned for patch 1, need to do something with that
xsk_skb_init_misc... Otherwise we hit destructor with xsk_cq_submit_addr_locked
here as well

