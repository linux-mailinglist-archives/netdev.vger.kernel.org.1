Return-Path: <netdev+bounces-280506-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC+SFYL56GnLSQIAu9opvQ
	(envelope-from <netdev+bounces-280506-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:38:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4ED1448C56
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 945D13056FF4
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379543806A2;
	Wed, 22 Apr 2026 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qiizJ9R+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f68.google.com (mail-oa1-f68.google.com [209.85.160.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3343803E9
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875515; cv=none; b=QeXyROQkcoJSR0k2wFDmpL/YaoLqw+LPBxFLULy/sboI8DphHNWPfdiLEGh8TlFj+lZux3XS5TPTJBqVKf8xH1hcNRHnNmnIQAc0YYwpLrxUcqpQ/HXJQjcIZZdWQuPG8e//osWl+4LWTJIlSUVnybMkkHX6GO7Jz6bdOSx+hdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875515; c=relaxed/simple;
	bh=cZIYcDfBSA2vCxhBpbusjqUzJv4vZW92FwUZ2AfApJE=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:Subject:Content-Type; b=R6m9ROISPnI3wsXVxWiCD5ubQp3kE2PkILutG9RAqHZ2hcKzuL/75qQVrDUknE3Tf+QYtf+ulqWd3Z6Iy1dn02KTmPfAUp3BLsKIE5lDvB4eIQpg7dj5T8iENcsZh1ILjN6TJXTQIESIpg2AM+pcBXWEfy+Bilm0K7VHBJ8+m5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qiizJ9R+; arc=none smtp.client-ip=209.85.160.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f68.google.com with SMTP id 586e51a60fabf-40423dbe98bso2387489fac.2
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776875513; x=1777480313; darn=vger.kernel.org;
        h=subject:in-reply-to:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZUh71n0Q6RWY3ShIg6hTY09S3jUTXCR0PyZUSnqcVx8=;
        b=qiizJ9R+bKTXsgo2P5lR9TQaNZYsUlSURFuMa2CDSuiRwqKdBnBG3LBHP6HY1HJzGP
         pIPkPIIYaOJCNdo9lM3pu5gP2nl9px8cCFgIUbfHWUoT7VXfB1gGd8O9RpG++16A1V5d
         Nbbr9VxttvOSXUxiuvSx2+fTZR7Z9I6jUX3eKxAf0vspDHDuGltFKf7GF0pDmbftxtzz
         0YNIvKlxj0+nn8H1Os808ju1MHCgpVM2r9AFxzzAgXBmbfBkK5XLAOOchDjoFWvrpLdD
         iVmlBJgNUYJIq3Osi2jR2tcb+hiLwJ/3tHiaHHEQJQi18WVcnee8ozREfH8fn86mQqR3
         VbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776875513; x=1777480313;
        h=subject:in-reply-to:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUh71n0Q6RWY3ShIg6hTY09S3jUTXCR0PyZUSnqcVx8=;
        b=cpWg0AtfVRnpvvZ3muFL/YTf9iZtSZNA8O2uemAomcQlVlZC4avHjtWkzloe0yo/SP
         5kqbHVjoFV2a+glbtDiRJWa7kVWjvl0ygpPCZq4/jNfu9rVwhA/17oWMMLIljucTOm85
         GrYaz9b3tGGf8t6Ejj+p1dyJfv/7icWZ4c8Aud35VN0AWjGyr58Ic0Ox00xY+uhe3Zrv
         4VRf/k3nuX55H/Q+HQsfz7ex/CEd9Oh73P+oLT+frzExBFBehC+OEWtjWXEjq/+FLr+j
         w/kBCNukrQ+36c0RHfB3wWWUkNGgnW/E0XG3R+1/N85+vTG1PD0E2dxvAwKquUrtgUHY
         JvIQ==
X-Forwarded-Encrypted: i=1; AFNElJ+IIdvP8Psj5E9u9gT0MYRqlH0X0AkdksvutSXGr7yGaGZOCievypcdIKVZ5eb5cnbxjeIpUSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZkvWbyQJFx8OCtjxre7QxIU0hIEz7eBt7fwM6/jaIZX8XE7Zv
	0PJ6St64Nn7L9pBnQGVYkWB53xQUEmyHGvwS9902wMWrjFhkKqd40cRf
X-Gm-Gg: AeBDiesS4UjQ+ycvME0rEM5j2jo6nNAiFH8RYwvMaBE24q8AZyCEP5js6DEzK2JZzXk
	i/Kv472o4BI7JkZL/qRlBFSfO3qgArhlDAlfqUzeUc+w/zkqcVdHRHnfLE88yMa76xvOTjAn5l9
	7lPs3oQbcepdX1i1RvPvLRrb8heWXgD3utwOL7JPANoxJ86eKpaEml581IHXsnwzop5OUSL9e0t
	96nfWJxyvmqMPnSg7Sg//ZaoVZ6TgOl+zP9HaiA7g6JPE9af0axp2b2eRXwdjtsc4+1s4VHPWh2
	b32UDrgjDZ01AKMfzR8dre9rjhZgyvMKhbE7p9LRCx3xY+QoSBL+9Hzoy1RjNtD/Lp4BSGxtcBK
	N0gE6K8IFa6TMcK/ZKJJG3aI0Aqqksnb55wAFdLmPUXxpfCVi9k9fW4PQOAuXuT8OdogODUF7kB
	GbDDpkWVkwFfDMqDBbHOr/tGlx0GdF
X-Received: by 2002:a05:6871:1cd:b0:417:2daf:6aa1 with SMTP id 586e51a60fabf-42aded7a82bmr13421229fac.37.1776875495405;
        Wed, 22 Apr 2026 09:31:35 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:49::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b9acc056esm15535973fac.17.2026.04.22.09.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:31:35 -0700 (PDT)
Date: Wed, 22 Apr 2026 09:31:34 -0700
Message-ID: <e4d5cf5e4bdde4dc2a015967f97f89be.sdf.kernel@gmail.com>
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
In-Reply-To: <20260422033650.68457-7-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net v3 6/8] xsk: free the skb when hitting the upper bound
 MAX_SKB_FRAGS
Content-Type: text/plain
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280506-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,fomichev.me:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4ED1448C56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
> index c49b58199d2f..5e6326e076ab 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -776,8 +776,11 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
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

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

