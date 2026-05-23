Return-Path: <netdev+bounces-291130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id f7WYDp7iEWqQrgYAu9opvQ
	(envelope-from <netdev+bounces-291130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 19:23:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D7A5C0019
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 19:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D2BB300D853
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 17:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51E9314A9E;
	Sat, 23 May 2026 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMHogzmz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312553128D9
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779557018; cv=none; b=N5YNkvBXh3Z72ju02Av+wYyDArSkuL2ULEorM6BF/PHDPgfanwhxsZ9jKbiITlYNdz2Qgv+8njXH8wGFg/KguXd98Z+xlOd7B/0tA13nH34WyP3oBdHh3XKfMLPAWRPXyyr3EurTcv6Ac+AZfWigTwWmW4dUYE9WR3oSSPRHEyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779557018; c=relaxed/simple;
	bh=Fi4+ue6MQehKHGj6eR0P1A4AvxISsRbzoo/k8cV2AcM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=q2/oy4XJJKqbXoq6+Rr+BTnOV6WbaN6NGbdzKl/SK3ISCogZWGz/ci0LQOgQgXHbcckW3Z6dLS7P9JoSd2zcQnW5Bes6s4qdUxTqKJV2GqG6dFh79aCiDaywBP9yHJV0/dXbhHNCTVibdCCSi+07aT2Ny/kx1dOGTOY7gwCKMnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sMHogzmz; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7b6ae2ea4a1so85448467b3.2
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 10:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779557016; x=1780161816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AH8I42OgtO38xei/x0QO150kONrNvsRLDU4qo5q/+2g=;
        b=sMHogzmzUJr8JJlpxA8s//WIx7vaBLTM9NzlUkjRZeUnKNhoTMpnOALbyta8inDD7+
         Qxhtjuj+JBMMBcV1VWXPqbKfJqzKgNYSgIfvGpESFmDGvN8Pr3qgIQRFsy0gWAlO83aw
         UvSqezG/QoErvh125dEH22JycHa16nXHWtAW2PVGdQZuDQH8wElottWeXXqrGKKfgjM3
         3Sm5euB5reTP3UkS0otK9/AKJAP7gYJUctyTS8bWytb+TA6rhHb5mRDqrsOCnTmiMtBb
         884t+fsL7jJoP5ZK1W4LKu4/L5Sk3EYlN/14b+mDaA5VP46i1QoR8IXASlrgOUhjDmbq
         T6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779557016; x=1780161816;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AH8I42OgtO38xei/x0QO150kONrNvsRLDU4qo5q/+2g=;
        b=Xvkin6KpAQvNuWkqluSxLzZhrYvMm6UOBa+uNpGMHbrV5bX8d3Xzlo0aYp69at4api
         ACBqRDnaGqaRS+imY0VTLajdOY/oZchSH3sNSYmTA7a0wUMLCFZ52h4QdzM4SbQS2RGr
         1OqpP7ZEWPlyLY5LZ+PBre6ckN5D/7ejVrlEUV2PtBhUIr8mbZpHOcw94PTL1rzfuRu6
         izdh5Hy6Mv37d6QoDKwwjNNOFYMaX2mL8jqmEkM0xjybcGG9CLbYboGBA5jrgSmIlKKF
         yhWP0Qz8jn8dEZc8iDBIXrc6q/o5JkHBPGw1pyp1iZa02E/u4nQsDsgbqNF7A+yXtkak
         PtAg==
X-Forwarded-Encrypted: i=1; AFNElJ9RnsA6KgolYMzQOseMrOYtnB0xuCvEj3vY+epCPwC5ow2EUUjNh+94HRTb+4fTxQTm33+9U8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK0ZRgwG46mMTNca9p2/PMyDj5Y/SciPIjRxwvT8EzrnBLr0qJ
	koOPqsroKq3kXfUHqshgttETKNH/0gj3UIAW5rKXIyNCxFuGG6drFO1u
X-Gm-Gg: Acq92OHmbUtTHkWHbWhvISkPigEc4NAk2OoRzJrxwBv5lb0yuiXrU+qzpURMd9WMFTQ
	7h85iK4G/tFlzcHq4l4DieUjiuf9vh8R7vNVSY+GVRjmlvdIcY8rWuQlIxf4Re++2Mf2ThpzUtk
	m+pcJS+exuSqja2/7xuDCcqQ1ZBVN54hZHiLe9gC/86kI6m19i1Hhq0CKw13X8x3HxhN5KKgesW
	lHxXHKvv77ujekLB9Dz2exNk/NKcY+9BLZIVxh3Eo7m3e5vYuP7Rh84TbSwsxVo+0n7V9oK6cEu
	yQMeUE/zJhzkTqLfFSxyrD6TRYP2p8sJxj3KihWFC/OEETpiWyNO7BJXa3Ccn8wzLT6g+w3YiW1
	FurEXDIQby7inZMr1bY4fa/7gGDUNJfoIdu8NoVjMMp4Bj2zlMaYV87PdZfGWdSuVUTSsNAT6s0
	MB/ArAmfxT0P36rBYdkWV12dkt0bgQSEN5qOVEKJV0rsPD6DZepwNWKetMCWrkS+unUSbP9DqHW
	Gpf+ZTykDZuKFtn3g==
X-Received: by 2002:a05:690c:d1d:b0:7b4:dc3a:79c5 with SMTP id 00721157ae682-7d3340d954amr105142577b3.12.1779557016220;
        Sat, 23 May 2026 10:23:36 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d389d17ffbsm23895387b3.14.2026.05.23.10.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 10:23:35 -0700 (PDT)
Date: Sat, 23 May 2026 13:23:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Qi Tang <tpluszz77@gmail.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com, 
 David Ahern <dsahern@kernel.org>, 
 Simon Horman <horms@kernel.org>
Cc: willemdebruijn.kernel@gmail.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Qi Tang <tpluszz77@gmail.com>, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1d8a1f48355f5@gmail.com>
In-Reply-To: <20260523143245.2281415-1-tpluszz77@gmail.com>
References: <20260523143245.2281415-1-tpluszz77@gmail.com>
Subject: Re: [PATCH net v5] ipv6: validate extension header length before
 copying to cmsg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291130-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,kernel.org,redhat.com,google.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.401];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 78D7A5C0019
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Qi Tang wrote:
> ip6_datagram_recv_specific_ctl() builds IPV6_{HOPOPTS,DSTOPTS,RTHDR}
> cmsgs (and their IPV6_2292* legacy counterparts) by trusting the
> on-wire hdrlen byte (ptr[1]) when computing the put_cmsg() length.
> The length was validated only at parse time (ipv6_parse_hopopts(),
> etc.).  An nftables payload-write expression can rewrite hdrlen after
> parsing and before the skb reaches recvmsg; the write itself is
> in-bounds but put_cmsg() then reads up to ((hdrlen+1) << 3) = 2040
> bytes from an 8-byte header.  nftables is reachable from an
> unprivileged user namespace, so this is an unprivileged
> slab-out-of-bounds read:
> 
>   BUG: KASAN: slab-out-of-bounds in put_cmsg+0x3ac/0x540
>    put_cmsg+0x3ac/0x540
>    udpv6_recvmsg+0xca0/0x1250
>    sock_recvmsg+0xdf/0x190
>    ____sys_recvmsg+0x1b1/0x620
> 
> Add ipv6_get_exthdr_len() which validates that at least two bytes
> are accessible before reading the hdrlen field, then checks the
> computed length against skb_tail_pointer(skb), returning 0 on
> failure.  Extension headers are kept in the linear skb area by
> pskb_may_pull() during input, so skb_tail_pointer() is the correct
> bound.
> 
> Use ipv6_get_exthdr_len() at all non-AH call sites: the five
> standalone cmsg blocks (HbH, 2292HbH, 2292DSTOPTS x2, 2292RTHDR)
> and the three standard cases in the extension-header walk loop
> (DSTOPTS, ROUTING, default).  AH retains an inline bounds check
> because its length formula differs ((ptr[1]+2)<<2).
> 
> The walk loop also gets a pre-read bounds check at the top to
> validate ptr before any case accesses ptr[0] or ptr[1].
> 
> When the walk loop detects a corrupted header, return from the
> function instead of continuing to process later socket options.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
> Changes v4 -> v5 (Jakub Kicinski):
>   - Switch (ptr + len <= tail) to (len <= tail - ptr) form in
>     ipv6_get_exthdr_len() to avoid pointer arithmetic concerns.

Please do send the net-next patch replacing the open constants with
offsetof and such.


> @@ -664,26 +679,37 @@ void ip6_datagram_recv_specific_ctl(struct sock *sk, struct msghdr *msg,
>  			unsigned int len;
>  			u8 *ptr = nh + off;
>  
> +			if (ptr + 2 > skb_tail_pointer(skb))
> +				return;
> +
>  			switch (nexthdr) {
>  			case IPPROTO_DSTOPTS:
>  				nexthdr = ptr[0];
> -				len = (ptr[1] + 1) << 3;
> +				len = ipv6_get_exthdr_len(skb, ptr);
> +				if (!len)
> +					return;
>  				if (np->rxopt.bits.dstopts)
>  					put_cmsg(msg, SOL_IPV6, IPV6_DSTOPTS, len, ptr);
>  				break;
>  			case IPPROTO_ROUTING:
>  				nexthdr = ptr[0];
> -				len = (ptr[1] + 1) << 3;
> +				len = ipv6_get_exthdr_len(skb, ptr);
> +				if (!len)
> +					return;

Optional: instead of return, jump out of the while loop and continue
processing other cmsg not based on exthdrs.

>  				if (np->rxopt.bits.srcrt)
>  					put_cmsg(msg, SOL_IPV6, IPV6_RTHDR, len, ptr);
>  				break;
>  			case IPPROTO_AH:
>  				nexthdr = ptr[0];
>  				len = (ptr[1] + 2) << 2;
> +				if (ptr + len > skb_tail_pointer(skb))
> +					return;
>  				break;
>  			default:
>  				nexthdr = ptr[0];
> -				len = (ptr[1] + 1) << 3;
> +				len = ipv6_get_exthdr_len(skb, ptr);
> +				if (!len)
> +					return;
>  				break;
>  			}
>  


