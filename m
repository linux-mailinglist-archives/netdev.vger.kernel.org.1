Return-Path: <netdev+bounces-303816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LEZqJmZyRWrHAQsAu9opvQ
	(envelope-from <netdev+bounces-303816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 22:02:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 090416F13CD
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 22:02:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XZodBLrT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303816-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303816-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C4D730D21C0
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 19:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF3B431E6C;
	Wed,  1 Jul 2026 19:58:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64AF348C5A
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 19:58:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935887; cv=pass; b=W9qrlBUBF69M+yhURa5cviqb0VHIVUMMhxeK9Rr340+cqTP7ObWiYELjvHdElNjU0WRH2gUtqJ8mTaeFVtzKEUMTEaCA8JJ20KL+0pM0eO7dPPEIexWDUCuNmsmPSoV25qW8KHjb11MwApTEwC5ORotYPIlmc+DYw0vh1bhtoH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935887; c=relaxed/simple;
	bh=i60NZHFAr/h3m8g1ycLBjS67V/ddDkK/sHBzOunEesE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lu5cL6gTpOuD2yvxC4wJ+FoBqKB3kFu8zoyYnctvzR5wDBX5l7uhbvdm1dC+unfWki9+BJu6B0UTECfGcY14hAKzZ0el6MAPfjFk/5oxdTZRutHe+RWd4Tuhcnfswk+VK9zFwBjxdO03P2o1N2WzwL23JrP+IJJIuWZ/oCZcWkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZodBLrT; arc=pass smtp.client-ip=209.85.214.175
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ca06ad2d11so9213195ad.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 12:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782935885; cv=none;
        d=google.com; s=arc-20260327;
        b=Clgg7CkP+y2UxGpnrb1rGcYzRc+Byz4AjmSyZBcLfnNdCRMIAfs+VhRIIXsRCorOv4
         TFsLXPF47zA8JVAuzFQhgPV4SkX4SFATHaErHoscmMFfLPLwEjCsRmas/ZnsVfu16//8
         LWwhyjxf5d+lIeI2zqUTWK2ydSlR6jpOqW0RF85mCJBtaKmjct14DM1rdEShDzI/yqQ2
         StobaGWdiDv6BnSZsUXzP0re9WHjg+S447Gn3lYxrs4yrlaZ5q637HAggbC9tcsdKEpd
         ocDNX3VtdwyBZyHj9H/ZwA3yc/af7sySOwSHOzauFEk48VheWeOaI8/OD24jIhvhlRIU
         2Hqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z/jk7CuiaTeF+7fFe7FXnvT1Gom1hwgxaJqMwyCP2ak=;
        fh=7dRiSEzFJMifyBqdoRFCuTVeg6MVA0WK13vnG7nmsGs=;
        b=XFIqKgI2bx5xtuzegITloLlxUi3HmMGsoB7IUI0gWjbqqWQv/uUquKCmzAd8aJ/iNe
         ys1KacBKyZ/gArn0e5PL8BBEKpc9hudxFqi+iVJMlXz+EVTecmYlUFIW9WEDHNzh0lcI
         cuDtsEsq98xKcpoHgD70D1v2WSSyuSUusGE+HrSOguZGnPT9QhKymHNCqM4D24nCT1GS
         X8GS88YKpZiZKrT7uv/rcBMtlsAiVF1Y+sL5pvBF3kqUfLfHU6/EjV/L+A/bU9QwVqir
         gdO+fHKbLgnqMCbnN0B/wdGJYfQ0f2XD+11DGQIvQ68/6j3qdf+aZKlCSIeHnFyUlyyC
         /XPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782935885; x=1783540685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/jk7CuiaTeF+7fFe7FXnvT1Gom1hwgxaJqMwyCP2ak=;
        b=XZodBLrTnLTOOKVwnMBhP+vpNxwz1pBB21LrsOnL5BiluVYIW0X+0ozcYGgTbtC016
         nxFXa0RI2G7XtKuImrG5FQIS5JpzqTbefndXnzY0+Rc0LfvmkIALUVBwlTn2QeWCADW+
         HUuGiGBbM8SbWbbanSRtF/U3lp/1i4be1aQSDsFr2fNr3UFkw9S3mmXXIuOT2W/Q1u2V
         rpr5fm8Soh4LUJXnJy4Uio7Y7Dwmq4WH9h/bOBlL/7kAl0rJwDWoTMLMbid+GyTIKkiw
         Hjn9EQZQUbivurtUxHvcnBq1TblLAOTz6hf/LeCeGsozaxM8QnxHJ1tVcbdgcczmyZ71
         Y1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782935885; x=1783540685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z/jk7CuiaTeF+7fFe7FXnvT1Gom1hwgxaJqMwyCP2ak=;
        b=f3iZxWTbfbBQYiRDn0LCi6vlYxISyAPRPdLcYVvb+h0AwLybvy3+oqP0wKfHd2r8Oe
         hiz8d8kP/HYEySXJXmLu51RSy+E0KEEJqHdQUPgYuND7ArwNYmJ9rVwVNFOCogzf2wom
         /TovViRdt3ApeOtCThOrKkncKzsiM+Yd1n9cwBJAJ/QQTEM1M2kDj6HaPh+ALYSKQ1yD
         9uaH5ia2OACasEsKbomxjbXEhNPxYn+PljB096374IhcmhQYovetdbj8DKi6c9VN9blv
         96c0WVsWaIWkd5AT4qo7OGi4aQpj505nb37lLjsXvOSl3+ejiJCyV1AL8RJoRj/S1j74
         nDHQ==
X-Forwarded-Encrypted: i=1; AHgh+RpYdwBUrPkebONm9Q6LFDSSawLeLjgokE92xbJluYuxRAhx7Wt7ueTPqZvwpuWStmbub+H6dl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4gGXIaCMWgDfybVsOtaJRaQizE56rnB+kvwK5MWpEbo4+8V+x
	YWSykoit/b/MtDuHKV61RdsY3dXB6HXTuLgWjYfasN4idPnXwTY35g2vae4Pk5dLaqRI5barzGc
	zeSuuZGD/ENtVVRP3b75gpAGhnDccmDc=
X-Gm-Gg: AfdE7cmKiH5Gk/vtq+gL/4rsqnGi5svInmMZcgSNAE0y6ubDELNBNnMARilLHAKNu/U
	7wxupx9QvtLSIpU6N3fTEgj1IPVACXkV4XhbywWlhOjJbAAoStjJ1LcJuoNtrGGDp5NfpSlwhmu
	wcpkhPFdxr1xH5IxOIK8GQ+PI7CLyOEjwcy5NEkJGfcG/CfPviQMtgMBBCztOP3VKNp8Nhy16IR
	DZ1MtfBpBQmv+B08Vylfwowt9kDzkcfGT9ese0ZZvzGyH3DQH9Q/5SZM8VaxXzm6JpkIqHE1n/q
	BGsioYRuYsnRd3XEUJe05LBBfMxF0uGH93lo4ITSGjHjdMAV9zj2Pw==
X-Received: by 2002:a17:902:e5c1:b0:2ca:c68:c554 with SMTP id
 d9443c01a7336-2ca7e90cea8mr33779245ad.38.1782935885043; Wed, 01 Jul 2026
 12:58:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630132226.C44601F000E9@smtp.kernel.org> <tencent_70F825FB8D959232DDCB5DDC991ACFB40D07@qq.com>
In-Reply-To: <tencent_70F825FB8D959232DDCB5DDC991ACFB40D07@qq.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Jul 2026 12:57:52 -0700
X-Gm-Features: AVVi8CcmJQesiAwvYWGQKOoBWRdGLDKvlSi6L3ILgPYvpbdBIlalI7TmabXmhhc
Message-ID: <CAEf4Bzb+OOrdGyxbzjh=7MUEbA5FC05E6_iwCjDXcnSO-HZ=ig@mail.gmail.com>
Subject: Re: [PATCH v5] bpf: Fix smp_processor_id() call trace for preemptible kernels
To: Edward Adam Davis <eadavis@qq.com>
Cc: sashiko-bot@kernel.org, jiayuan.chen@linux.dev, 
	sashiko-reviews@lists.linux.dev, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	emil@etsalapatis.com, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, netdev@vger.kernel.org, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[qq.com];
	FORGED_RECIPIENTS(0.00)[m:eadavis@qq.com,m:sashiko-bot@kernel.org,m:jiayuan.chen@linux.dev,m:sashiko-reviews@lists.linux.dev,m:andrii@kernel.org,m:ast@kernel.org,m:bpf@vger.kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:emil@etsalapatis.com,m:jolsa@kernel.org,m:linux-kernel@vger.kernel.org,m:martin.lau@linux.dev,m:memxor@gmail.com,m:netdev@vger.kernel.org,m:song@kernel.org,m:syzkaller-bugs@googlegroups.com,m:yonghong.song@linux.dev,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[andriinakryiko@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303816-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,lists.linux.dev,vger.kernel.org,iogearbox.net,gmail.com,etsalapatis.com,googlegroups.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 090416F13CD

On Tue, Jun 30, 2026 at 5:27=E2=80=AFPM Edward Adam Davis <eadavis@qq.com> =
wrote:
>
> bpf_mem_cache_free_rcu() maybe called in preemptible context, this
> will trigger the below warning message:
>
> BUG: using smp_processor_id() in preemptible [00000000] code: syz.0.17/58=
20
> caller is bpf_mem_cache_free_rcu+0x48/0xc0 kernel/bpf/memalloc.c:954
> Call Trace:
>  check_preemption_disabled+0xd3/0xe0 lib/smp_processor_id.c:47
>  bpf_mem_cache_free_rcu+0x48/0xc0 kernel/bpf/memalloc.c:954
>  rhtab_delete_elem+0x185a/0x1b30 kernel/bpf/hashtab.c:2969
>  __rhtab_map_lookup_and_delete_batch+0x935/0xcb0 kernel/bpf/hashtab.c:334=
9
>  bpf_map_do_batch+0x445/0x630 kernel/bpf/syscall.c:-1
>  __sys_bpf+0x906/0xd90 kernel/bpf/syscall.c:-1
>
> this_cpu_ptr() requires the caller to prevent task migration.
> These helpers currently do not enforce that requirement and may
> be invoked from preemptible contexts, leading to accesses to another
> CPU's per-CPU cache after migration. Use get_cpu_ptr()/put_cpu_ptr()
> to pin the task while accessing the per-CPU allocator state.
>
> Fixes: 5af6807bdb10 ("bpf: Introduce bpf_mem_free_rcu() similar to kfree_=
rcu().")
> Fixes: 7c8199e24fa0 ("bpf: Introduce any context BPF specific memory allo=
cator.")
> Reported-by: syzbot+fd7e415d891073b83e1f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dfd7e415d891073b83e1f
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---

from what I can see, bpf_mem_free() is called through bpf kfuncs only,
and all BPF programs run with migration disabled. So this seems like a
false positive. For per-cpu checking, it should probably check that
either preemption is disabled or migration is disabled. tl;dr, there
doesn't seem to be any

pw-bot: cr

> v1 -> v2: using guard against preemption
> v2 -> v3: replace get/put_cpu() to bpf_disable/enable_instrumentation()
> v3 -> v4: disable preempt to make this_cpu_ptr() work
> v4 -> v5: in mem free disable preemption
>

maybe throttle your patch resubmission spree a bit?..

