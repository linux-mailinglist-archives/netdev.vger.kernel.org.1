Return-Path: <netdev+bounces-303413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XszzLXJaRGpytQoAu9opvQ
	(envelope-from <netdev+bounces-303413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 02:08:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1705A6E8C4C
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 02:08:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OGxc+NpG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303413-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303413-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C35C3023F83
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 00:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8282913AF2;
	Wed,  1 Jul 2026 00:07:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAE840D589
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 00:07:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864463; cv=none; b=d6xF/H+cPGVfm5C7+tMYGtVgxy2gTJ3nU0CZZYEu8r3JbTPZPgY8SxJ/HnpgHtU4GZIQVXZQxKFPDKfrlpKKnlDaN6WPUwzoLhgfghD2E6z6B2fBaEWnV0iSUGnnwUuorG+nTYUrjXFYwKxYI/eXnryjWDCBn94ezZ0RXUHtlHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864463; c=relaxed/simple;
	bh=lC+k+6mNle6sj5AuGdZt4d9WTpneeUI+q286W11Koso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hr+6bGHyecTCiHJz8GGvIQYMwgJ1AzBksxEACVWGn4aLA+Udo5TsEBSos7uj1t+EzefilT4MKoelapXDJeQ1lQRISbvTwDA70tY4EPP5HbBzlzlc7/gJI5ljBqYL0DF5bZ91x24ig8kmMG+T12NuDxewRi07whdecvEb6Z1us5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGxc+NpG; arc=none smtp.client-ip=209.85.216.45
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36b9d265355so62649a91.2
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 17:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782864461; x=1783469261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NRsFNTp0mbWr+vlnr7zhHF/IOCJEISt4xOaBSTIIlKc=;
        b=OGxc+NpGOmU5VBQR4YX7pojFZaMLGpqNMFoHHLKnEJR+aBWkcOJodtXepu6Px17Fai
         9zmaKf/MO3UruBNl+wrcOMTl+ng5o4RrsJBwhHZRiQ6yy+v3QrO+/JPFykYLnSyj0w0y
         PZOqSs5yuCoD24xfI1bd93ASt0ZzsvyL7e8Nmu4r3BE0y0uruswAk0Af3QeECDcMuDjg
         vCmrrCevNijsTNHS6+dTfGRNj2n6F1p+kDrg6Ejct6MtdSJGhUSbIqgO6XJLcll0z9tv
         LJRNowaZEdavi+2NE7KpNG8ASh9Wt4wk21Ftn5SCfm1gb33UTW35VTATHngmZihmHyfL
         8+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782864461; x=1783469261;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NRsFNTp0mbWr+vlnr7zhHF/IOCJEISt4xOaBSTIIlKc=;
        b=g59XHCaczkhMYgIC+c0ZS/wNOc7s1KorJak8ZqFSD1QKA3ke6SE90YBaN6yryLXK4I
         q8Uk0o2Lj0+kbhfvahvKqEDRJ6fWde34cBTb/blZrjP9w8b0dD64RZFlxTFHKrzFPxYr
         /kuF6wfJZdRFhhAg9Uvll/BU3FbTIj+iR0U+hEc08+hmJA8iY3oygLMCKPnHgjWsAZ3y
         1WstgiWbApih8HAsP8BlJwdXCFUgTnImy5SB2q4NuD+G+xRVRDFASttAl4DVb2fFWoaI
         CmXjezt4qZ/WXrYrOf03pr9Wb2vQFPoW/7RmzCNPndnf8ihbTvXmTQElRqL7Uvjrb6Y2
         gOJA==
X-Forwarded-Encrypted: i=1; AHgh+Rr/ZtGiKi0ihG76MXIz0YZpmaF8aMB5aXSvxfy+VXSmfN7OyIP23mDccsbeduUmMNTEy/SqnzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuMnpykwom1wlRcif82pt79B2VvQFF9Hlele7/3K5nXBGbCSu9
	AWKdmYIcr+ji6KKDqCLyPrrk+sKti6QihYY7jGe+6e2O0/HoBVR/ey9K
X-Gm-Gg: AfdE7ckz+2JvKEjFBu5q3xKclqTQiotRr+LE/pge5pf+EF6NAB2RkcfLjLdyu6lMvr/
	+aXu6iKMPZ9lzHctug0C31oNCR4u/T/8AKJAaHoNpWTvW+UI4j7Z4wgEEf0/SiWt9Plycqkqncd
	R/2FVsBtd4MVzFnphqDRER53/5ngBcjHb0kQzZTSrLi5T90FmcILYyouL4f64NJa8Y0iABiCKEK
	Z/9jQWOlin3/T4j39WvPnzy/psDpF145fvW4dv9ScTaXof3P5ZxsL4bfpLKsnhE0+Jc0QwPd5Xj
	tI8uweE7YD145j33S8oLpdhaRK8EGE7JCkZZqWERRadNvZCCpNcrl700FwMpnN19ELL7NQ9Hwrz
	/XauLMgjdvtZpEZiI03tDH1nu1bhnkoUC+zRkaN3s2JulibtBLBC+NV4YCfEtrnNxye0VyYrMuy
	EKBZ95K89ovg==
X-Received: by 2002:a17:90b:3944:b0:37f:7210:ccd7 with SMTP id 98e67ed59e1d1-3805272a521mr4755526a91.20.1782864461559;
        Tue, 30 Jun 2026 17:07:41 -0700 (PDT)
Received: from john-p8 ([98.97.43.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38095ea2e2dsm737009a91.16.2026.06.30.17.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 17:07:40 -0700 (PDT)
Date: Tue, 30 Jun 2026 17:07:38 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Varun R Mallya <varunrmallya@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 1/2] bpf, sockmap: disallow update and delete
 from tc, xdp, socket_filter and flow_dissector
Message-ID: <akRZ_e7DJh2aP-2i@john-p8>
References: <20260630145410.3648099-1-rhkrqnwk98@gmail.com>
 <20260630145410.3648099-2-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260630145410.3648099-2-rhkrqnwk98@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:shuah@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:sdf@fomichev.me,m:jiayuan.chen@linux.dev,m:varunrmallya@gmail.com,m:ihor.solodrai@linux.dev,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-303413-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,davemloft.net,linux.dev,etsalapatis.com,fomichev.me,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,john-p8:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1705A6E8C4C

On Tue, Jun 30, 2026 at 02:54:05PM +0000, Sechang Lim wrote:
>sock_map_update_common() and __sock_map_delete() hold stab->lock and call
>sock_map_unref() -> sock_map_del_link(), which takes sk_callback_lock for
>write. That gives the order stab->lock -> sk_callback_lock.
>
>The reverse order comes from the SK_SKB stream parser.
>sk_psock_strp_data_ready() holds sk_callback_lock for read, and after the
>verdict tcp_bpf_strp_read_sock() acks the consumed data inline via
>__tcp_cleanup_rbuf(). The ACK goes out egress, where a sched_cls program
>deletes from the sockmap and takes stab->lock:
>
>  WARNING: possible circular locking dependency detected

[...]

>A tc, xdp, socket_filter or flow_dissector program has no reason to
>update or delete a sockmap, and redirect does not go through here. Drop
>them from may_update_sockmap() so the verifier rejects it. It also
>closes the matching sockhash inversion.
>
>Suggested-by: John Fastabend <john.fastabend@gmail.com>
>Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
>---

Great lets get this merged and we will separately fix the sockops
issue reported by the bots.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

