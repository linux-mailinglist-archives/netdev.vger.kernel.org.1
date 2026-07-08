Return-Path: <netdev+bounces-305635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GemACKnCTWql9wEAu9opvQ
	(envelope-from <netdev+bounces-305635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 05:23:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6914A7215C9
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 05:23:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=lOC67acm;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305635-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305635-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A57330214DB
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 03:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CE536B076;
	Wed,  8 Jul 2026 03:23:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9363271FD
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 03:23:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783480990; cv=none; b=TIHjnApKpb5O0vst5k5gNlE9hml/aJP3ZYnTmHg6t4sgvoO2JExS1aEzAJbiDWL6m9HwUn+/7jJFhse0KSaPqAxVvHRDfmNAltOsfMY0zD8NjE6w8xlZbB1mtQBDOsf/39QSre75kFwDsOC5VlllB+xTQsfDX+2fzPmHNfdW5mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783480990; c=relaxed/simple;
	bh=LR8ZkF3VK3DQ+1b3NahwIArIM/D2QpLWCJHiyLBsbcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HfjDoQccUY8Lc+NI4QwyTzDOQMpUsG6LZeaY0d3MsVR5ECo2IUUayeXUXBe2bBJYJKd7YFXiuMPfYZ+roTEcPLh2bkvER4fGAeWN8iwH3d6MmN6T5/v7Sn3WfSbPckO9w4cA/KkO0h1qBLXQLEbeW/dYixM6kA72O0euGgIHhw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lOC67acm; arc=none smtp.client-ip=91.218.175.170
Message-ID: <2ea29553-b0bd-4d12-9ff9-9b6f99267fc0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783480976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1a2UG4qiDNeOYHH404Fpdk2UN9XF1jE5+XaJZ48Ojg=;
	b=lOC67acmeaf3tcUhfAAiGGXM1A7NuahPyQs2Iqpm2I9o709r5Bl+5AZJILRy7VASo9jNQy
	nyBP76d6/n3pXWbVAXKatcYwgjSGewR+JmrUKwd0R7iKokj12CJUrnQHJht7Ijm98t6fTi
	TWpMHY8r43iaQweeu8Ho5Gb8XNUDr5Q=
Date: Wed, 8 Jul 2026 11:22:44 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add XDP dispatcher FineIBT
 regression test
Content-Language: en-US
To: David Windsor <dwindsor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <c5a6bff16c0885d3ec756a1cdfb623636d0bdb4a.1783479101.git.dwindsor@gmail.com>
 <f6df1bf381517f7ff6927d82de7680e7826adf94.1783479101.git.dwindsor@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <f6df1bf381517f7ff6927d82de7680e7826adf94.1783479101.git.dwindsor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dwindsor@gmail.com,m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:shuah@kernel.org,m:peterz@infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305635-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,etsalapatis.com,redhat.com,alien8.de,linux.intel.com,zytor.com,davemloft.net,fomichev.me,infradead.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6914A7215C9

On 8/7/26 10:57, David Windsor wrote:
> Add a regression test for the x86 BPF dispatcher's indirect-jump fallback
> under FineIBT.
> 
> This test can crash the kernel on an unfixed FineIBT build and so should
> be run in a VM.
> 
> Signed-off-by: David Windsor <dwindsor@gmail.com>
> ---
>  .../bpf/prog_tests/xdp_dispatcher_fineibt.c   | 47 +++++++++++++++++++
>  .../bpf/progs/xdp_dispatcher_fineibt.c        | 18 +++++++
>  2 files changed, 65 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_dispatcher_fineibt.c
>  create mode 100644 tools/testing/selftests/bpf/progs/xdp_dispatcher_fineibt.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_dispatcher_fineibt.c b/tools/testing/selftests/bpf/prog_tests/xdp_dispatcher_fineibt.c
> new file mode 100644
> index 000000000000..2d3fc4034eb9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_dispatcher_fineibt.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 David Windsor */
> +
> +/*
> + * Regression test for the x86 BPF dispatcher's indirect-jump fallback
> + * under FineIBT.
> + *
> + * WARNING
> + * -------
> + *  This test can crash the kernel, thus should be run in a VM.
> + */
> +#include <uapi/linux/if_link.h>
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +#include "xdp_dispatcher_fineibt.skel.h"
> +
> +#define IFINDEX_LO		1
> +
> +void test_xdp_dispatcher_fineibt(void)
> +{
> +	struct xdp_dispatcher_fineibt *skel;
> +	int err, attached_fd, unattached_fd;
> +
> +	LIBBPF_OPTS(bpf_test_run_opts, topts,
> +		.data_in = &pkt_v4,
> +		.data_size_in = sizeof(pkt_v4),
> +	);
> +
> +	skel = xdp_dispatcher_fineibt__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> +		return;
> +
> +	attached_fd = bpf_program__fd(skel->progs.xdp_dispatcher_attached);
> +	unattached_fd = bpf_program__fd(skel->progs.xdp_dispatcher_unattached);
> +
> +	err = bpf_xdp_attach(IFINDEX_LO, attached_fd, XDP_FLAGS_SKB_MODE, NULL);
> +	if (!ASSERT_OK(err, "attach_prog"))
> +		goto out;
> +
> +	err = bpf_prog_test_run_opts(unattached_fd, &topts);
> +	ASSERT_OK(err, "unattached_test_run");
> +	ASSERT_EQ(topts.retval, XDP_PASS, "unattached_retval");
> +
> +	bpf_xdp_detach(IFINDEX_LO, XDP_FLAGS_SKB_MODE, NULL);
> +out:
> +	xdp_dispatcher_fineibt__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/xdp_dispatcher_fineibt.c b/tools/testing/selftests/bpf/progs/xdp_dispatcher_fineibt.c
> new file mode 100644
> index 000000000000..b49b84f01c8e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/xdp_dispatcher_fineibt.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 David Windsor */
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +SEC("xdp")
> +int xdp_dispatcher_attached(struct xdp_md *ctx)
> +{
> +	return XDP_PASS;
> +}
> +
> +SEC("xdp")
> +int xdp_dispatcher_unattached(struct xdp_md *ctx)
> +{
> +	return XDP_PASS;
> +}
> +
> +char _license[] SEC("license") = "GPL";


Instead of creating xdp_dispatcher_fineibt.c, better to reuse
xdp_dummy.c. Then, in xdp_dispatcher_fineibt.c, you can create two
xdp_dummy skels, one for attaching, one for running.

And, add the test to xdp_attach.c instead of new file
prog_tests/xdp_dispatcher_fineibt.c?

Thanks,
Leon


