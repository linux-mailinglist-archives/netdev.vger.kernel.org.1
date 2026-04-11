Return-Path: <netdev+bounces-277645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id B3Y3Caez2WkasQgAu9opvQ
	(envelope-from <netdev+bounces-277645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 04:36:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB4A3DE0A6
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 04:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3B42301DE13
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 02:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AD021E091;
	Sat, 11 Apr 2026 02:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2Ovoltu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD83D18A6D4;
	Sat, 11 Apr 2026 02:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775874979; cv=none; b=UHw2u1JcJOhFJMpVHhFphGQbXElr3mUcb9LiQAdEBIGbA5aYv+MzgKpUz6iaGbRyBF3KiI7P994Uos1QZa/hhES3BGtrANN6r+s4vxMl4Od4Gs3Jp1TPQDuu68bmeDYKLrJas71SffxP86T7Op3GTuuRgtkXj91c4lYFeUQOKyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775874979; c=relaxed/simple;
	bh=eO4Mvhsq4Mq/cpZl11DpNXyx10kT44I69he5RD7wc/8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=OcPtgFG8nxW4/oFDt/Hs9HRFrvBx8WbOZeOXT26zu1wOIGIpmbPGVMEBQuql9w19QH+Tspc6U+Zs8jMnKMe2KlW7D9gihKVRPA4UO5fB2GHhgxdps85y8CE3XJjfiGlXHMj49sjnnI7Qc4pkWEzR5CVIbpSUMSWAJnOE1U/65EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2Ovoltu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BD1C19421;
	Sat, 11 Apr 2026 02:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775874979;
	bh=eO4Mvhsq4Mq/cpZl11DpNXyx10kT44I69he5RD7wc/8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=t2OvoltuLUfVmjp7FcjEDwNKu8oookSya+80UUes3jhoNG6mqGSUWQFP66YhZlnjk
	 L/GIaIw8MBpg/U7G5HZrSmjDFGbisqoKUpz59dkOLzZkcnPXRow5Lyq8850ruczK2E
	 PeYsuAH4nDFZyx6+l1hy+ZyFFxjLyWwqTSwaCL5YvB/1N1b96qg+ItqBivX67kexqI
	 cldb3A+WcpQkPovYxWM6tENLktQajaqTLLE526ciDFXuHSQRHo4xMU/VB/1jMu0oCC
	 AyvB0hFICISy3Ct+saH3uYbvTqjQrY7uRwEchbTZ1fUu1/gXvDHKhsbfkxmK8/Uy2I
	 T+apnZe7Vo9Vw==
Content-Type: multipart/mixed; boundary="===============3484057471282728357=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <efdb35c2d8151489fb031ad63ce8bd6000b8bbaa2bf5a523c927907399c93ab0@mail.kernel.org>
In-Reply-To: <20260411015419.114016-3-ameryhung@gmail.com>
References: <20260411015419.114016-3-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Use kmalloc_nolock() universally in local storage
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,memxor@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 11 Apr 2026 02:36:18 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277645-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com,linux.dev];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid]
X-Rspamd-Queue-Id: 6BB4A3DE0A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============3484057471282728357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index cad17ca8552f..bc687b9d25a9 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c

[ ... ]

> @@ -75,18 +75,12 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
>  	if (mem_charge(smap, owner, smap->elem_size))
>  		return NULL;
>
> -	if (smap->use_kmalloc_nolock) {
> -		selem = bpf_map_kmalloc_nolock(&smap->map, smap->elem_size,
> -					       __GFP_ZERO, NUMA_NO_NODE);
> -	} else {
> -		selem = bpf_map_kzalloc(&smap->map, smap->elem_size,
> -					gfp_flags | __GFP_NOWARN);
> -	}
> +	selem = bpf_map_kmalloc_nolock(&smap->map, smap->elem_size,
> +				       __GFP_ZERO, NUMA_NO_NODE);

With this change, socket and inode local storage now always go through
kmalloc_nolock(). kmalloc_nolock_noprof() in mm/slub.c has a hard size
limit:

    if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
        return NULL;

KMALLOC_MAX_CACHE_SIZE is 1 << (PAGE_SHIFT + 1), which is 8KB on
x86_64 with 4KB pages. But BPF_LOCAL_STORAGE_MAX_VALUE_SIZE in
bpf_local_storage.h is calculated from KMALLOC_MAX_SIZE (not
KMALLOC_MAX_CACHE_SIZE):

    #define BPF_LOCAL_STORAGE_MAX_VALUE_SIZE \
        min_t(u32, \
              (KMALLOC_MAX_SIZE - MAX_BPF_STACK - \
               sizeof(struct bpf_local_storage_elem)), \
              (U16_MAX - sizeof(struct bpf_local_storage_elem)))

This allows value sizes up to ~65KB. Before this patch, socket and
inode storage used bpf_map_kzalloc() (backed by regular kmalloc)
which could handle those large sizes. After this patch, any
elem_size above KMALLOC_MAX_CACHE_SIZE will silently fail: the map
creation succeeds via bpf_local_storage_map_alloc_check() but every
element allocation returns NULL.

Should BPF_LOCAL_STORAGE_MAX_VALUE_SIZE be updated to use
KMALLOC_MAX_CACHE_SIZE instead of KMALLOC_MAX_SIZE now that all
storage types go through kmalloc_nolock()?

Slava Imameev raised the same concern for task storage in
https://lore.kernel.org/bpf/20260410014341.47043-1-slava.imameev@crowdstrike.com/

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24272235145
--===============3484057471282728357==--

