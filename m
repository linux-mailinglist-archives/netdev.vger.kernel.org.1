Return-Path: <netdev+bounces-275860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLtCO0N91GniuQcAu9opvQ
	(envelope-from <netdev+bounces-275860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 05:42:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAB93A97AE
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 05:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1CDA300B602
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 03:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D7E37418F;
	Tue,  7 Apr 2026 03:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUuSvAL6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA664334681
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 03:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775533376; cv=none; b=iKsXi7KNOyPMWisLoxl0Hvb3b9dthswsgrf1IEq5diqmj5pIhUQ4TE7600Jv/RtaUThWvbbbTL45e+445Ng8G6Kd+Np1Pveaoa3zfxzse4WmcqiMhA3ZviBqsTTQRvpS8P49BRiezTZl68uS8lbTzResdGQwj6SI3K99qTDCSpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775533376; c=relaxed/simple;
	bh=PY5ILjxCJ5TPuG6N0E7dhyIq1ZD+5631r/TnZxOEGqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCsUSIMDMvHORBLjxSsGXHXQNjZNIT4K1mvd8uhnxre4FmqfhlUulJ7Nlm1Ojj00u0y9rI/YEuyQbeyGf55WwQ1mey86sIfMRhp0B8Iy3mYEFuYy5MnvOF2EECM3lnpCgPErzPU0GAbU7ihlOFlpFIbt3EWx5Zj1IOnSYcmXTlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUuSvAL6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C6BC116C6
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 03:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775533376;
	bh=PY5ILjxCJ5TPuG6N0E7dhyIq1ZD+5631r/TnZxOEGqs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VUuSvAL6MmfiGvHoOHm1xPJTU1DpfVTVCk887C9HA01fbUJW6Tn4Fv5E1Z0skVC+y
	 tw9NfzwKG518J0Cy3ragAO9/m1rCZPVNl6niPRDV6KGeu7Riv7qn4vWPieLAko20YA
	 oBTlrTZAzHKo0FyLxQqUY5YWyG7wC3rSK+g1Xrm6CkY2hZC03LD8YOYDDgHTJLPo21
	 /keuIjDMez7M5VOmT8AuEWU8quzzgnYmoNW1tOTAWyZQkTSP7itfIz8azH/EHnY1P4
	 cLOJ+2Ts7dwqkaf60zoiaL4BK3sJz8QfoUMx212SquwTnyJqCMFDNvntBeGdooqfkQ
	 8WzkHTXYJFM3Q==
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-899a9f445cbso59346066d6.0
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 20:42:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCqHb0uLQRTARglCgGyuLe25hLCcICV0QY+ioS8XFRy04T1+gm8p0ShFboTMIRc4Cg5FDSAJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu4C91Id/mxueXdnkastBWTH5axwsYW4v30jnXA+kjGeejI7Yy
	hqT5We7hbCrnipoYfwPApTcWTGGjZbaMPTOaAn+BkD/WzNdtmQUL6K9BjB3BYdN+tEzQylxu2RM
	Nby3Z3N2QBnWiFQ/9xZdWlsprIRe1gDM=
X-Received: by 2002:a05:6214:20aa:b0:8a9:9cdc:9ab9 with SMTP id
 6a1803df08f44-8a99cdc9b7fmr142559486d6.24.1775533375703; Mon, 06 Apr 2026
 20:42:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406195014.112521-1-jp.kobryn@linux.dev>
In-Reply-To: <20260406195014.112521-1-jp.kobryn@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Tue, 7 Apr 2026 11:42:43 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xqmXGon8d9bwD_6QnRvpa+4uXDw4vGrv_C1BZC59DOQQ@mail.gmail.com>
X-Gm-Features: AQROBzCUXfyDhGLk2aQzGMeYjrCKkTpaMIsiEwO5P_TRgb51gwzU8_3avOm2lko
Message-ID: <CAGsJ_4xqmXGon8d9bwD_6QnRvpa+4uXDw4vGrv_C1BZC59DOQQ@mail.gmail.com>
Subject: Re: [PATCH v4] mm/vmpressure: skip socket pressure for costly order reclaim
To: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
Cc: linux-mm@kvack.org, willy@infradead.org, hannes@cmpxchg.org, 
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, kasong@tencent.com, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, riel@surriel.com, kuba@kernel.org, edumazet@google.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	wanglian@kylinos.cn, chentao@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275860-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baohua@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4BAB93A97AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 3:50=E2=80=AFAM JP Kobryn (Meta) <jp.kobryn@linux.de=
v> wrote:
>
> When reclaim is triggered by high order allocations on a fragmented syste=
m,
> vmpressure() can report poor reclaim efficiency even though the system ha=
s
> plenty of free memory. This is because many pages are scanned, but few ar=
e
> found to actually reclaim - the pages are actively in use and don't need =
to
> be freed. The resulting scan:reclaim ratio causes vmpressure() to assert
> socket pressure, throttling TCP throughput unnecessarily.
>
> Costly order allocations (above PAGE_ALLOC_COSTLY_ORDER) rely heavily on
> compaction to succeed, so poor reclaim efficiency at these orders does no=
t
> necessarily indicate memory pressure. The kernel already treats this orde=
r
> as the boundary where reclaim is no longer expected to succeed and
> compaction may take over.
>
> Make vmpressure() order-aware through an additional parameter sourced fro=
m
> scan_control at existing call sites. Socket pressure is now only asserted
> when order <=3D PAGE_ALLOC_COSTLY_ORDER.
>
> Memcg reclaim is unaffected since try_to_free_mem_cgroup_pages() always
> uses order 0, which passes the filter unconditionally. Similarly,
> vmpressure_prio() now passes order 0 internally when calling vmpressure()=
,
> ensuring critical pressure from low reclaim priority is not suppressed by
> the order filter.
>
> The patch was motivated by a case of impacted net throughput in productio=
n.
> On one affected host, the memory state at the time showed ~15GB available=
,
> zero cgroup pressure, and the following buddyinfo state:
>
> Order FreePages
> 0:    133,970
> 1:    29,230
> 2:    17,351
> 3:    18,984
> 7+:   0
>
> Using bpf, it was found that 94% of vmpressure calls on this host were fr=
om
> order-7 kswapd reclaim.
>
> TCP minimum recv window is rcv_ssthresh:19712.
>
> Before patch:
> 723 out of 3,843 (19%) TCP connections stuck at minimum recv window
>
> After live-patching and ~30min elapsed:
> 0 out of 3,470 TCP connections stuck at minimum recv window
>
> Signed-off-by: JP Kobryn (Meta) <jp.kobryn@linux.dev>
> Reviewed-by: Rik van Riel <riel@surriel.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Jakub Kicinski <kuba@kernel.org>

This patch looks sensible to me

Reviewed-by: Barry Song <baohua@kernel.org>

This is a one-sided costly order and should be treated as costly for
reclamation. On the other hand, nominally non-costly orders (e.g.,
order-3) can also become costly. I previously raised this issue here:

https://lore.kernel.org/linux-mm/20251013101636.69220-1-21cnbao@gmail.com/

Burst network traffic can make phones heat up.

More recently, with help from Wang Lian and Kunwu Chan (Cc'ed),
we developed a simple model that reliably reproduces this
behavior, where we observe significant CPU utilization by
kswapd due to 3-order burst allocation from the network.

I may revisit this discussion soon.

Best Regards
Barry

