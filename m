Return-Path: <netdev+bounces-292951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Kv1EYr9GGoEpggAu9opvQ
	(envelope-from <netdev+bounces-292951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 04:44:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7C65FC743
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 04:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 039703144D22
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 02:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CD3368962;
	Fri, 29 May 2026 02:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vfw8CF+R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9363C367B95;
	Fri, 29 May 2026 02:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780022400; cv=none; b=BPoIRiTBxRel+6qvNrEi2+hBlBdkuuld0D+C0nTIXAe72V+HiHjH8Mj82vFwBkMz5kRtCZiK0kpjFi6KAo/OqpjCKoLWomk0M5XXjYXZaFQf+gXVxc//oR/G226yZp/fJPuCXHbTQ0HnM2hm1Rt+O8QPEWlQaaCeZ1hRYOwrStI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780022400; c=relaxed/simple;
	bh=075je7S1BU2/0OGg0oE59Kh1QkYPj6LObR5HrRt6pfs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=sVD2XOq3otARtXvB5EnjrPBek+GPDwfedaBYGFz4PQLAbVI2Pnakc3OOk7JkG3We3HE4A4AbXAE82c1FO9/Ck50VVl0KuKY6mXpbKskTgmBIwA/oXoa/gUGoeiHypue719Ytv4O2m0bIEnoqEZa1udLkfYA70IHW0AJQYisSvPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vfw8CF+R; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DCB1F000E9;
	Fri, 29 May 2026 02:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780022399;
	bh=y15mtP+QSwwUAaTYdZUAx0zp90zXxZscnm1INoXdovw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Vfw8CF+R68cYhFoIw+sC3GgXHdOs1DoR4vQoEnKKG/a++sEgJodH70auhIxf7MGdo
	 7Vp6FFwf5c1QZvlUZ+SMFQ3dMCr6Jf9uqro23eolfKGNJzH90jtfZdZRx5P+6SOlks
	 6DgidWKJ/mdxC74sGw3TN3aDRHsS0C5gtEqb12y8cUhKbvYJrmrn5R9ItpI0DwsgLD
	 QNmSXsYvZRKxsH++rJdv3/3wa6LBfbeku7Tf2Ducv0j2P4g06HNgzOaNdT2wg1KzHr
	 QGACbjogPKNQ2wJy/2uqCCHhWRYa1P62PX/fjpCgdl5CXAYh3kW9mpBq2rMXCmhzX6
	 IY6WIpDPzo8zQ==
Content-Type: multipart/mixed; boundary="===============7833193762766572003=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b1db271a265c878bb5dc67f0989703c26859064a15343cdf70d880200f5fa165@mail.kernel.org>
In-Reply-To: <20260529014936.2811085-12-ameryhung@gmail.com>
References: <20260529014936.2811085-12-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v6 11/13] selftests/bpf: Test using slice after invalidating dynptr clone
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@kernel.org,mykyta.yatsenko5@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 29 May 2026 02:39:59 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com,linux.dev];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-292951-lists,netdev=lfdr.de,bpf-ci];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20]
X-Rspamd-Queue-Id: CA7C65FC743
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============7833193762766572003==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
> index 730357cd0c9a..77f1c0550c9b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
> @@ -8,6 +8,10 @@
>  #include "bpf_qdisc_fifo.skel.h"
>  #include "bpf_qdisc_fq.skel.h"
>  #include "bpf_qdisc_fail__incompl_ops.skel.h"
> +#include "bpf_qdisc_fail__invalid_dynptr.skel.h"
> +#include "bpf_qdisc_fail__invalid_dynptr_slice.skel.h"
> +#include "bpf_qdisc_fail__invalid_dynptr_cross_frame.skel.h"
> +#include "bpf_qdisc_dynptr_use_after_invalidate_clone.skel.h"

Three of these four skeleton headers are generated from progs source
files that do not exist yet at this commit.  Only
bpf_qdisc_dynptr_use_after_invalidate_clone.c is added here:

  git ls-tree -r 96063d161a74 -- progs/
    bpf_qdisc_dynptr_use_after_invalidate_clone.c

The progs source files bpf_qdisc_fail__invalid_dynptr.c,
bpf_qdisc_fail__invalid_dynptr_slice.c and
bpf_qdisc_fail__invalid_dynptr_cross_frame.c are only added later in
c8e177e9eaaf ("selftests/bpf: Test using dynptr after freeing the
underlying object").

The selftests Makefile generates .skel.h only from existing progs/*.c:

  TRUNNER_BPF_SRCS := $(notdir $(wildcard $(TRUNNER_BPF_PROGS_DIR)/*.c))
  TRUNNER_BPF_SKELS := $(patsubst %.c,$(TRUNNER_OUTPUT)/%.skel.h, \
                                  $(TRUNNER_BPF_SRCS))

With the three sources missing, their .skel.h headers are never
generated, so compiling prog_tests/bpf_qdisc.c fails with something
like:

  fatal error: bpf_qdisc_fail__invalid_dynptr.skel.h: No such file or
  directory

Does this break the selftests build at this commit?  The build appears
to stay broken across 96063d161a74..c8e177e9eaaf until the later commit
adds the three progs sources.

Could the three invalid_dynptr* includes (and their matching RUN_TESTS
calls below) move to the same commit that adds their progs sources, so
each patch builds on its own?

> @@ -223,6 +227,10 @@ void test_ns_bpf_qdisc(void)
>  		test_qdisc_attach_to_non_root();
>  	if (test__start_subtest("incompl_ops"))
>  		test_incompl_ops();
> +	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr);
> +	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr_cross_frame);
> +	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr_slice);
> +	RUN_TESTS(bpf_qdisc_dynptr_use_after_invalidate_clone);
>  }

The wiring for bpf_qdisc_dynptr_use_after_invalidate_clone itself looks
self-contained and correct in this commit; only the three
invalid_dynptr* references arrive before their sources.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26613892466
--===============7833193762766572003==--

