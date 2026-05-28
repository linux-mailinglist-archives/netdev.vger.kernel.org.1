Return-Path: <netdev+bounces-292669-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OnCCp4pGGrneggAu9opvQ
	(envelope-from <netdev+bounces-292669-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:40:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB6B5F168E
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AE73301AD0F
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB483B960B;
	Thu, 28 May 2026 11:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SY+/wCGt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQdCIHD8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB7C12CDA5
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968150; cv=none; b=QFeYC9XGZ618VZq150cP2mazgvVQIMv8TLep9FVM7LI5Gv2AIEdaQt6fwRh1tf0GdxD150zfFAa7SJMpyW2cnOPPFZ6pGPlRNS+esbQLx6+D4m3CdyZr8Z9JCuhXcOBX9PgpN+bSNsH3g+gsQ3J4y497kSFqJ4mw0u81LRcdm5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968150; c=relaxed/simple;
	bh=YZ9hKs7HJHmsQPFuxOoHvVl9arpy1Cwy0p94fVXbDEA=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=V0Xcw0i1+lqpbqaJOlu1XL82LKo4ld/TA7/gidQtQPGetGVfaVRjfdbuJItYFSrWXY/BTsdymXN3Ch0QejmU5Lk6a+DO+H1HsBU8w5KnbcmkPzQteLouudR7H2HGJrGdybuRJdJhIg3smb1nlX7nC+jnDP/8YrC/HAs5wfG6q68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SY+/wCGt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AQdCIHD8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779968147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGWLGChAYAynhyDsF8aTNHhuqaFs15VJeVnxYZMOBEs=;
	b=SY+/wCGtCMF5paDCt7dzQnTyTXdoJu6+rRFXLT9ziLo7pgGyio0rSXjK8Hvngq5QS0KkTR
	M736X4xeiNpzhDxJjJjJOoO+QcUzY45/YywelWpJo9Z0s8B/QtiwaMFB6OAORC/x7QYaTF
	N3uv0x2XHz32xdlrxaPgXoWSAXqBwzs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-CtAUoD64O8e3uQgwu6T66g-1; Thu, 28 May 2026 07:35:46 -0400
X-MC-Unique: CtAUoD64O8e3uQgwu6T66g-1
X-Mimecast-MFC-AGG-ID: CtAUoD64O8e3uQgwu6T66g_1779968145
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49058e91639so37633675e9.3
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 04:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779968145; x=1780572945; darn=vger.kernel.org;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGWLGChAYAynhyDsF8aTNHhuqaFs15VJeVnxYZMOBEs=;
        b=AQdCIHD8wZKvDCygCdkk/gSDTBa1lALn/2kEdA9jHqF7AxHmO8wUZYb9aPKOndv5PM
         JE0UTTSjy7BmlS/aEOyImFrv2rmdP0d41UgV3JySotmpRMmQFeJgMFTRSOKXkrTCAK/F
         QvPWwnqvvaAydE0iC3Q8M9U7kpS+9xlY4AcWBmCj+9DfBnd3vg8nbQHkyuiXbc0DBQp5
         5PsZEdd5RlUr06ITr2HaxQL8USE2M8HL8xggeFCGgxRBP3NxdcL6nQnRbMkIcykzBQ5a
         cCJtb5opCqxtaYHYTGvTYhPdZQMA5UlSR+WqZ0KEJbSqDhWALizHz0vWiO7W+021V5Uq
         U1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779968145; x=1780572945;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QGWLGChAYAynhyDsF8aTNHhuqaFs15VJeVnxYZMOBEs=;
        b=KYr79YyJHfb+u3NQ7q9enneB5j7BldixLq2Qqbrrw9tyNJ9sTaiFzKMJuU9mgcWNc0
         z8Kp6uMkRvoU3Db8kBmMlbLIykOmtmatY2afYo2yZCzWnOQPIYYjDrLm8O466y8dwtVr
         kTs3xCudrYiV3qNcLCOrXKyFEeSPpvP5DNkxVLXWvLFZTe2W/59yCEJpgV46mEwh/86W
         GLPSfJ2eVQjI/dTjT4ij8Q5GzyhhAiaFy+l2kpy27fqDm1R2kZEL4d1TMp25xJgx7u/u
         N9UcDgF3jMbfsyGnAsF1mezq5S7+J7CJRleNUe74I6i4NRe3Icgb4mTPdn9WoE0J82Bq
         vykQ==
X-Gm-Message-State: AOJu0Yx5WTDsesHAfx9aSpqOesTDpj7G61G4Q5F/6AsMSU2LEDx3x52m
	p5H/EgbEXNBuCLLBCt7adK/wanAo4Silz5dB3D0L69W9pWTj34IRWOaefIgOsMJ7sDRs0IE2Rdz
	W4+fwFhQQYIVd6gPnBmObRmElbmQzo4ADVh/+kIMGlufkFvUoxCAf20Pl/Q==
X-Gm-Gg: Acq92OGoM+7FMwWcOMwoHMaX2LnxhoVlVD4dCq8M5FcXE9Ke9Hx+Pu6+o/n7Nie85+d
	0lKmDuGbJA6PA8spiDLl3xj2UdXnvwwFWUwfJcpSoR4voKFCNG7+tIs8FWbm7/CS+OPHy+6omij
	3B+2BuwAqc7UvuCBcL5AQJbegtg2sjg3z+aBTnibMI/LurBl0N8WXDYVR6DsY1Jmmsxj+hSSDtr
	27oTfOyDIYrltV37waCD+XU1DpQsxtoIKyFNII+PJ03cf8PfSmLysPF3+H6vWv+Ah1TzydL6HIa
	BKucV7wLvICgv4LHaCP3e9ydwCUeVUGmcj5TqPyiET3fqrk6X+BtwwUIrj0O1XYY/UZzeL+nvjo
	LNvYzz2XHBYjK2l3Z7UVGiR9xX77lq4yWwL2sFzIY2EaETcTtL1lc9lTnoT7G
X-Received: by 2002:a05:600c:4e4b:b0:48a:6fd4:d3d3 with SMTP id 5b1f17b1804b1-49069da61b8mr243431795e9.20.1779968145340;
        Thu, 28 May 2026 04:35:45 -0700 (PDT)
X-Received: by 2002:a05:600c:4e4b:b0:48a:6fd4:d3d3 with SMTP id 5b1f17b1804b1-49069da61b8mr243431385e9.20.1779968144850;
        Thu, 28 May 2026 04:35:44 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5a2908sm13493090f8f.18.2026.05.28.04.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 04:35:44 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, yuhuang@redhat.com, justin.iurman@gmail.com,
 horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, idosch@nvidia.com, dsahern@kernel.org, Chris Adams
 <linux@cmadams.net>, david@gibson.dropbear.id.au
Subject: Re: [PATCH net] Revert "ipv6: preserve insertion order for
 same-scope addresses"
Message-ID: <20260528133524.28d531e6@elisabeth>
In-Reply-To: <20260528111123.4667-1-fmancera@suse.de>
References: <20260528111123.4667-1-fmancera@suse.de>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Thu, 28 May 2026 13:35:43 +0200 (CEST)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,gmail.com,kernel.org,google.com,davemloft.net,nvidia.com,cmadams.net,gibson.dropbear.id.au];
	TAGGED_FROM(0.00)[bounces-292669-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:email,cmadams.net:email]
X-Rspamd-Queue-Id: 7CB6B5F168E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 13:11:23 +0200
Fernando Fernandez Mancera <fmancera@suse.de> wrote:

> Chris Adams reported that preserving insertion order for same-scope
> addresses is causing SSH connections to be dropped after stopping a VM
> while running NetworkManager.
> 
> NetworkManager is caching the networking information from the system and
> later operating with it. It relies on the order of IPv6 addresses to
> configure routes for outgoing traffic.

I think this paragraph should make it clear that NetworkManager relies
on a _reversed_ order (first inserted is returned last), and that it's
the opposite compared to IPv4.

> Revert to the previous ordering.

See my concern from:

  https://lore.kernel.org/all/20260528131250.1352ab48@elisabeth/

(sorry, I sent that email moments after you sent this patch it seems). It
fixes the issue for NetworkManager assuming it's the only issue, but it
causes a regression for others.

If this revert is the only practical solution, so be it. I'm just wondering
if it really is.

> This reverts commit cb3de96eea66f5e4a580086c6a1be46e765f97f4.
> 
> Fixes: cb3de96eea66 ("ipv6: preserve insertion order for same-scope addresses")
> Reported-by: Chris Adams <linux@cmadams.net>
> Closes: https://lore.kernel.org/netdev/20260521135310.GC977@cmadams.net/
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
>  net/ipv6/addrconf.c                  | 2 +-
>  tools/testing/selftests/net/ioam6.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 5476b6536eb7..bb84a78b80f6 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -1013,7 +1013,7 @@ ipv6_link_dev_addr(struct inet6_dev *idev, struct inet6_ifaddr *ifp)
>  	list_for_each(p, &idev->addr_list) {
>  		struct inet6_ifaddr *ifa
>  			= list_entry(p, struct inet6_ifaddr, if_list);
> -		if (ifp_scope > ipv6_addr_src_scope(&ifa->addr))
> +		if (ifp_scope >= ipv6_addr_src_scope(&ifa->addr))
>  			break;
>  	}
>  
> diff --git a/tools/testing/selftests/net/ioam6.sh b/tools/testing/selftests/net/ioam6.sh
> index b2b99889942f..845c26dd01a9 100755
> --- a/tools/testing/selftests/net/ioam6.sh
> +++ b/tools/testing/selftests/net/ioam6.sh
> @@ -273,8 +273,8 @@ setup()
>    ip -netns $ioam_node_beta link set ioam-veth-betaR name veth1 &>/dev/null
>    ip -netns $ioam_node_gamma link set ioam-veth-gamma name veth0 &>/dev/null
>  
> -  ip -netns $ioam_node_alpha addr add 2001:db8:1::2/64 dev veth0 &>/dev/null
>    ip -netns $ioam_node_alpha addr add 2001:db8:1::50/64 dev veth0 &>/dev/null
> +  ip -netns $ioam_node_alpha addr add 2001:db8:1::2/64 dev veth0 &>/dev/null
>    ip -netns $ioam_node_alpha link set veth0 up &>/dev/null
>    ip -netns $ioam_node_alpha link set lo up &>/dev/null
>    ip -netns $ioam_node_alpha route add 2001:db8:2::/64 \

-- 
Stefano


