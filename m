Return-Path: <netdev+bounces-290682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MF6gIUvtD2omRgYAu9opvQ
	(envelope-from <netdev+bounces-290682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 07:44:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F5A5AF3C5
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 07:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03670302BBB5
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 05:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FB53A1A2D;
	Fri, 22 May 2026 05:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoiqBeF9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AA139D6FD
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 05:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779428467; cv=none; b=rU6Iar2uOum09hnAOLoOkBgv6v4hmFHOkNLxFSE4jwIR84VWBOheOWVSbc5qswM0V+Rd4HemurIyJW3auusKq7TuDl2rIanViRRT0SgwhwOTxlLW0HJ9PR0qC3tFiKpOEuFiv/MatRV8lEMr5TolalpbqOdgg+0PEwhRFrBEnfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779428467; c=relaxed/simple;
	bh=7BukE1lYqgUHUUwtz1gAmazYBI49l7hQ/livEgLx44Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hE2xFeko98qgoS1Ya7QAma3QSWDk77xmeSPDMrIyg5qOXUAMpk9p9JSD6We+gj6eygOsWBp3KGdsOV2o46GpArvKSsTbH7yws5kyjLPJIOxr/xd9rZ5XsSwEP0J/6x97MK3CmHoOmEOZcfMnA5qWsFlSGLaOMTU5ML+2jkaxP8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoiqBeF9; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ba4a1a0325so44248125ad.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 22:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779428465; x=1780033265; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LAcpGt9A50v8TVjUmtkbhcVP3i52hTzkHXHZgVlleSQ=;
        b=FoiqBeF9uJreE7bVec7zm9hGOTrUYdNQb0oWv01T1tgibxIBgI+HIUroG9lDU/7y8e
         7A5vrwaeLf8rWbvzzoC378WJjdr/xXxy6w/iL31ct5xWR8S3cqfcXbvXl8AJWPv8id+z
         XQ3TThjeH8HUbGRKw0yGsQdX48OegV7p27N3AKb57BVD0fStr8Tdqiks5Ioe4Xa6mjfZ
         s6NYkUDCaWCoR/DfzZ5T3FN5n/8D+rrRz2ziauHbXhjROXmtCBwNfv4q7A8YKOnZATww
         iMGQ+NuYRlH1SUODVgqYpHX1uhJG1WR8UaVeiYh3e6OKMLaaiw6XiTiBWfkOWJLoZ/K9
         mBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779428465; x=1780033265;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LAcpGt9A50v8TVjUmtkbhcVP3i52hTzkHXHZgVlleSQ=;
        b=H8yEncHDEDDLAyH5QMv/D8rbegD8E+yUA5sKftn0M1R1ACAZnxiUXkQgJebuzdFNpS
         Ip2d127Kg6/fGCOzbBqrGBby2lF+C5y27JuV7NxWKWalpUxHJNV3qJ3wUcTw6QmTjvl3
         ABtz1zopmsQ3Nyi60qIvBonVrvEkhdjGBGiM1tpvFCto2uemxko8iUuEMcg9C+A8I2md
         /3CJdKi51JXQTpx6SgrvWOKk5Cdt1ereHreS9jkEsEG5lDYA0WDeBfZM+NU5INoMuMg2
         dzRZxaoUj13l9qB4wniwsNv/YRUZDw6TuG2ILMGPCWIxnuF5hyqJriIwmBIwYicJSy23
         mnug==
X-Gm-Message-State: AOJu0Yz31COXdVE70JLJC1KRy3N/ImNFbwCuLh7OQQrwjc62eP2Or4Oc
	YHYkQivCCEJnllJ1sO97cnRB+eRSIYbMbu7P2q0YyPEXX5uJMCey34yv
X-Gm-Gg: Acq92OH+gcgLAbOb0FYuSSFLqEf6qOjd38pEua/34IhrP3DJgPvW9gBu0KdQeT4ptly
	ly+8cmS9fny4SEoDjfvC4iXsr8P4kVuVq9MUvPwGgfQbrAY2K5KWeBW4jjbRmT7I+L4SLkB4V5k
	dC9MLhI0gYJMNGD+barOOS7n7MVyTAYJH4skZt0i1aOrr33y+CXfvJ6XhOC0Oi5yLlNOurPw+BW
	/j9nU27i1eoYbzyTT9nHDZFFYECADutszKg7dCxyZjtiW2PYHRAU4FeQUU5bZlMdZL7rOt1FA7g
	VSk+j2AqgIIo65rn8i4NelRksvRsl46kOdPSeCLHq/aEQZsteNeCbUfPalS4Ti46VKy0TIeZ04K
	ry6SaXq+BFQeYk6FLJyNGNT0mLfNFnLfo4tyVLx9+BOpbPU9OKdc4Pl7nyCJnXSrfCSwtcMLzmC
	yfsqeW2Iqdt0PPXuCZYwfZ/nAec13cVmxc+2kAdcm31otjZl1Q4oJSVWkbCdvEp4g=
X-Received: by 2002:a17:902:c94a:b0:2bd:9728:5e42 with SMTP id d9443c01a7336-2beb074b967mr22794405ad.31.1779428464695;
        Thu, 21 May 2026 22:41:04 -0700 (PDT)
Received: from [10.188.79.203] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b3085sm3806315ad.53.2026.05.21.22.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 22:41:03 -0700 (PDT)
Message-ID: <ccd74b6e068e0ef02d429f3ede50afbdec516715.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 09/14] bpf: Fold ref_obj_id into id and
 introduce virtual references
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Date: Thu, 21 May 2026 22:40:59 -0700
In-Reply-To: <20260519181314.2731658-10-ameryhung@gmail.com>
References: <20260519181314.2731658-1-ameryhung@gmail.com>
	 <20260519181314.2731658-10-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	TAGGED_FROM(0.00)[bounces-290682-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,r0.id:url]
X-Rspamd-Queue-Id: 26F5A5AF3C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-05-19 at 11:13 -0700, Amery Hung wrote:
> Remove ref_obj_id from bpf_reg_state by folding its role into the
> existing id field. Previously, id tracked pointer identity for null
> checking while ref_obj_id tracked the owning reference for lifetime
> management. These are now unified: acquire helpers and kfuncs set id
> to the acquired reference id, and release paths use id directly.
>
> To handle cases where objects share the same lifetime but need distinct
> identities, pointer casting (bpf_sk_fullsock, bpf_tcp_sock) and
> referenced dynptr clones, introduce virtual references. A virtual
> reference is a bpf_reference_state entry with is_virtual=3Dtrue that
> serves as a lifetime anchor. It has no backing register or stack slot
> and exists only in acquired_refs.
>
> For pointer casting, the first cast from a referenced pointer creates a
> virtual reference, converts the source to a non-referenced pointer with
> parent_id pointing to the virtual ref, and gives the cast result its own
> unique id with the same parent_id. Chained casts reuse the same virtual
> ref. Each pointer retains a unique id for independent null checking via
> mark_ptr_or_null_regs, while releasing any of them releases the shared
> virtual ref and invalidates all siblings.
>
> For referenced dynptrs, the constructor creates a virtual reference
> instead of a regular one. All clones share the same parent_id (the
> virtual ref) but get unique ids for independent slice tracking.
> Releasing a referenced dynptr releases the virtual reference, which in
> turn invalidates all clones and their derived slices.
>
> The release_reference() DFS is extended to detect virtual refs whose
> parent is being released and report them as leaked references, matching
> the existing behavior for regular refs encountered during cascading.
>
> Also add reg_is_referenced() which checks if a register is referenced
> either directly (id in the reference table) or indirectly (parent_id
> points to a virtual ref). This replaces all former ref_obj_id checks.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Consider two modifications:
- A different approach for pointer cast helpers handling:
  fork the verifier state at the cast call site:
  - Push a NULL branch for later exploration.
  - Continue with the non-NULL branch: strip PTR_MAYBE_NULL from r0
    and set r0.id =3D source register's id.
  - All cast results share the same id as the original acquired pointer.
    No new reference entries, no parent_id on cast results.
    Because reference_id is shared, release of any of the original or
    cast pointers invalidates all other pointers.
- unmark_stack_slots_dynptr() deciding which reference id to free
  basing on the pointer type:

    release_reference(env, dynptr_type_referenced(reg->dynptr.type)
                           ? reg->parent_id
                           : reg->id);

With these two modifications the following simplifications are possible:
- `is_virtual` flag is no longer necessary.
- `reg_is_referenced()` reduces to `find_reference_state(reg->id) !=3D NULL=
`.
- `acquire_virtual_reference()` merges into `acquire_reference()` with a
  parent_id parameter.
- `cast_from_ref_obj()` is no longer necessary.

See the branch [1] for the complete implementation, with commits on
top of this series (two fixups, two commits for the changes described above=
).
Existing selftests are passing with these changes.

[1] https://github.com/eddyz87/bpf/tree/refobj-id-v5-suggestion

Wdyt?

