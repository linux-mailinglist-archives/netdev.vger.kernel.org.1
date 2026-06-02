Return-Path: <netdev+bounces-294312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ovCZKWwQH2rLewAAu9opvQ
	(envelope-from <netdev+bounces-294312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 19:18:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 761C1630A12
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 19:18:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b=nd7zPxXG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294312-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294312-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6D4E30976DA
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 17:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B223F58E5;
	Tue,  2 Jun 2026 17:11:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197983F5BD6
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 17:11:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420275; cv=none; b=Kz6ziIPsw7smmdVeJgJNSMpm2DRK8Hosadc7ZOg8n9DgDuFwI57lAKZ1l6hegPC66v03ftVm8haDbB5VaaZbFeoeklEEjMUVW4GwqaGvQOO15QuLEG69k19pyLBie9qcCbUpvVwChLcAA5/3IKBJiEkRDWVDhX0ltY6vq+dvQJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420275; c=relaxed/simple;
	bh=PNMcwBaq3HWYoO3KsicsKTXAF3/1eGOdICmPWCtyf9A=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=GtemgvWBEFz0WjLNArj1ij4wSaktJXKUN0SIGNeSRJfIjqbwyvE3wMjgZ1MTYX3FGGv2dYy2Z1GU6Qz2zod7Sp2NSfSgptSeU9pOvC4jQ/d42sy0yCTDSiFPFtUn8OXLlTmoCupjOBadheN/xEcdvFUYMtC0YQt+4vGluMsRIE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=nd7zPxXG; arc=none smtp.client-ip=74.125.82.196
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-304545f5206so15972913eec.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 10:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780420273; x=1781025073; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0j05WBgNKiBOQ3j1mPmoNzDYYpZls9Mm5jzp1fNRRDY=;
        b=nd7zPxXGdX+bnnaZZKs7yqrvNYLKEKTvox7fHrHIYM538vSdbmNbX4ciXg2nbpBqcY
         XDAcxVl+EDR0+VnBOfmQU3fvZA2ar9GEoUz+LbH4c15LLEZun0zbiknivHaCql43l2Xj
         1DdfDMVYFIjpLH52fRUr/iPL824e28Qq2JF53RtJVkoRC7xugt49fpQym9IDLoFSMx4B
         LNnN0ddmc5LkwOulXvSHUm0PEbPqFvxnxG8l9hNzmaUovz0gVCQiJEDN5QhYHUwUvMZO
         W3VvcpnDAab/gSSOy2BMFn9w+xYa9ULv5VmUOLDHNKUq9mdBHGZHSAonhufW9TikryyM
         yh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420273; x=1781025073;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0j05WBgNKiBOQ3j1mPmoNzDYYpZls9Mm5jzp1fNRRDY=;
        b=NolbsBbkjqcUPHcGI4Q19Fe6EshMfXyJFGBdbimSNcBIvWsn5Htg37H25lpgSTT+ox
         yPWkMyvqSOxogJAqqTrfEXtwRiTP4QRb/Ox8lH3MhAcr/dpaLR5n44XUsaafR+IELl7x
         e/0ESXl/1BzSIot6g32X4haEg5hS5gszO53T9Csz9AcKcYaKj44R1BRTBD5q5PHis4ze
         6ka8mvtn4YupFRcuL/OxNMMC2MmobElBuUUqXRGDQFJHhroO1t7fSq/p5k5cUdRbONAc
         r9SQgiwWvF3qT00lEDF7Yt0nenJsOVhpZcv475lpFaji7tDOmNKkoHugF9m5vDBzbVrr
         gPXA==
X-Forwarded-Encrypted: i=1; AFNElJ9SC4UKVd8zBj190hNvZw506RSetPvX5GDDX83KI1SDp06OOnVMsp40u/tqn2kKr1M7cJcl+C8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWon6bVzMhGsTgMm5ZxF+TDcM6/Sdv9Yx2UtXV4YCT/pKsSoQ9
	BVnMi1t8v3XaSuhkSw77q3I/vinkP7Os5oqCAWD+lIgdudKHGLcJsLWfLo4ujfi+KUI=
X-Gm-Gg: Acq92OE6W5JJL07bwkATusYednJzk1H6+cdiOuQZSsKA/853ZCWyHXKandn7exh1W82
	LoNZ7YmKJeI0aYY2hmlYwjUP1/CdkkOsW1onC8UWF7tD+GKizdUjV02ARZWyfCcayKSUghq+ebC
	CQ/Rne+yRKTQ10E8ln5wwrC+KEKrZAXSCb5CXGirnTCv3j95OTpqjaOCxsCp/FespnzJcX15h7R
	s8HQY61e3UdXyjNHvflkd7kpdTcJ+7vsP3ca2o9QOz8mUd+A7eb3lhSeqN08cXrHi/DDKmUZH13
	iFY1Esdz9WhTSz8o/zTWeb+XvEAkneCQ63vfLWQEOJTOwtgs/S3umQTo9Mw9YrpkbWunRonRo+b
	XCA2NX6ELtHTOoXRjo9SPgJJW3eFeyITyn7ags8zy8K5O4Ig/ToTTdUEbdw+e8PxKB6apCjCQ/I
	Qt09OrowZ+/lqqtE06q2UI0oDhOPzUpKTzfQ==
X-Received: by 2002:a05:7300:a44c:b0:2da:a813:a5fd with SMTP id 5a478bee46e88-304fa5a7ac4mr7756107eec.22.1780420273037;
        Tue, 02 Jun 2026 10:11:13 -0700 (PDT)
Received: from localhost ([163.114.132.129])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f54db05csm241990c88.8.2026.06.02.10.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 10:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Jun 2026 13:11:08 -0400
Message-Id: <DIYQB8597KMS.2FSGCPOI9LPCW@etsalapatis.com>
To: "Ren Wei" <n05ec@lzu.edu.cn>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <davem@davemloft.net>,
 <kuba@kernel.org>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
 <sdf@fomichev.me>, <andrii@kernel.org>, <martin.lau@linux.dev>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <toke@redhat.com>,
 <liuhangbin@gmail.com>, <yuantan098@gmail.com>, <zcliangcn@gmail.com>,
 <bird@lzu.edu.cn>, <zzhan461@ucr.edu>
Subject: Re: [PATCH bpf v2] bpf: devmap: reject fragmented frames in
 clone-based broadcasts
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <21c2d153dd25603d359069a02bf06779b51f6423.1780385378.git.zzhan461@ucr.edu>
In-Reply-To: <21c2d153dd25603d359069a02bf06779b51f6423.1780385378.git.zzhan461@ucr.edu>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:toke@redhat.com,m:liuhangbin@gmail.com,m:yuantan098@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:zzhan461@ucr.edu,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294312-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	DMARC_NA(0.00)[etsalapatis.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,linux.dev,redhat.com,lzu.edu.cn,ucr.edu];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lzu.edu.cn:email,ucr.edu:email,etsalapatis.com:mid,etsalapatis.com:from_mime,etsalapatis.com:email,etsalapatis-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 761C1630A12

On Tue Jun 2, 2026 at 4:43 AM EDT, Ren Wei wrote:
> From: Zhao Zhang <zzhan461@ucr.edu>
>
> Devmap broadcast redirects clone the packet for all but the last
> destination.
>
> For native XDP, that clone path copies only the linear xdp_frame data,
> while fragmented frames keep skb_shared_info in tailroom outside the
> linear area. Cloning such a frame leaves XDP_FLAGS_HAS_FRAGS set but
> without valid frag metadata, and the later free path can interpret
> uninitialized tail data as skb_shared_info, leading to an out-of-bounds
> access during frame return.
>
> Reject fragmented native XDP frames in dev_map_enqueue_clone().
>
> Add the same restriction to the generic XDP clone path in
> dev_map_redirect_clone(). Generic XDP represents fragmented packets as
> nonlinear skbs, and rejecting them here keeps clone-based broadcast
> support aligned between native and generic XDP.
>
> Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support=
")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Zhao Zhang <zzhan461@ucr.edu>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> changes in v2:
> - Add the same fragmented-packet restriction to generic XDP
>   dev_map_redirect_clone() so clone-based broadcast behavior stays
>   aligned with the native XDP path.
> - v1 link: https://lore.kernel.org/all/4b596825bccc64d03e0c2e0db4dceb12c7=
f5cf47.1780176829.git.zzhan461@ucr.edu/
>
>  kernel/bpf/devmap.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index cc0a43ebab6b..5b9eac5342a9 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -581,6 +581,10 @@ static int dev_map_enqueue_clone(struct bpf_dtab_net=
dev *obj,
>  {
>  	struct xdp_frame *nxdpf;
> =20
> +	/* Frags live outside the linear frame and cannot be cloned safely. */
> +	if (unlikely(xdp_frame_has_frags(xdpf)))
> +		return -EOPNOTSUPP;
> +
>  	nxdpf =3D xdpf_clone(xdpf);
>  	if (!nxdpf)
>  		return -ENOMEM;
> @@ -726,6 +730,9 @@ static int dev_map_redirect_clone(struct bpf_dtab_net=
dev *dst,
>  	struct sk_buff *nskb;
>  	int err;
> =20
> +	if (unlikely(skb_is_nonlinear(skb)))
> +		return -EOPNOTSUPP;
> +
>  	nskb =3D skb_clone(skb, GFP_ATOMIC);
>  	if (!nskb)
>  		return -ENOMEM;


