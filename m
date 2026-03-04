Return-Path: <netdev+bounces-263741-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JXzC68KqGn2nQAAu9opvQ
	(envelope-from <netdev+bounces-263741-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:34:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA02D1FE685
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A8A6303300E
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 10:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAFC3A256F;
	Wed,  4 Mar 2026 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="neawUVPs"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE143A4510
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 10:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772620460; cv=none; b=es0RfRoxrPGeVgmXBV9O0HH3/e5IV4NAFqDwjDeUxFvxbZLpBJo4VLNRnh1QsYtPxoihjO5h9hO9c8xeoEdaoAp43N6JraUWxpN/dvJ42TS7x31vt13GEm9YfK76a9zwAOmuJDtpshJ+a7c30IZZFvjB5hGXqM3bZIptSd5D9TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772620460; c=relaxed/simple;
	bh=BchV9tgwhQ1C7uqCgKnhewSo8nKCzaaMLBh8ajYJQyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g5O5jmCMJODYhhRvP6Agp7V67gWws9tQIAOcoJuCMP3Mgzuepz9ieF/fI0vZzfA8tJosBFxw7/m53wClmTOGo+odLtFsZGTtuI2n8oehYy+OONHTIdQ4T+NOBNJ3jSHF+nImfFLOEF+U8zBbl23PWt072C1yH2KPHzNWVrdnoYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=neawUVPs; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8f6755ed-d2ae-42ba-8052-2e6fba3d5c69@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772620456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hWNia4y10bqjN6HPGAzDBrD60vXyvc5C3ZJR9DKS+jI=;
	b=neawUVPsgfqZ5AyFpvB5bNZpbCBnPVFj99NEZg89NCMBmiszeypNRHUfJm8FCCeqUAUfou
	8Q6W2H2klVufKB0iWUhMmCmbRZMLTCRPbrdXPJnxVC4k+TCWRZHxuePyCWsTeKw9vKue/T
	sy5GuOVmnl6GS5wnUVd80GzJEJ8EU5U=
Date: Wed, 4 Mar 2026 18:33:56 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v10 bpf-next 2/2] selftests/bpf: Add selftests for the
 invocation of bpf_lwt_xmit_push_encap
Content-Language: en-US
To: Feng Yang <yangfeng59949@163.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 posk@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260304094429.168521-1-yangfeng59949@163.com>
 <20260304094429.168521-3-yangfeng59949@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260304094429.168521-3-yangfeng59949@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: CA02D1FE685
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[163.com,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263741-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,kylinos.cn:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 4/3/26 17:44, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> Calling bpf_lwt_xmit_push_encap will not cause a crash when dst is missing.
> 
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
>  .../selftests/bpf/prog_tests/lwt_misc.c       |  9 ++++++++
>  tools/testing/selftests/bpf/progs/lwt_misc.c  | 22 +++++++++++++++++++
>  2 files changed, 31 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/lwt_misc.c
>  create mode 100644 tools/testing/selftests/bpf/progs/lwt_misc.c
> 

Unnecessary to create new files.

Move the adding test to verifier_lwt.c. prog_tests/verifier.c will run
the test.

Thanks,
Leon

> diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_misc.c b/tools/testing/selftests/bpf/prog_tests/lwt_misc.c
> new file mode 100644
> index 000000000000..6940fca38512
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/lwt_misc.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include "lwt_misc.skel.h"
> +
> +void test_lwt_misc(void)
> +{
> +	RUN_TESTS(lwt_misc);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/lwt_misc.c b/tools/testing/selftests/bpf/progs/lwt_misc.c
> new file mode 100644
> index 000000000000..aa638a4f2922
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/lwt_misc.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +SEC("lwt_xmit")
> +__success __retval(0)
> +int test_missing_dst_call_bpf_lwt_xmit_push_encap(struct __sk_buff *skb)
> +{
> +	struct iphdr iph;
> +
> +	__builtin_memset(&iph, 0, sizeof(struct iphdr));
> +	iph.ihl = 5;
> +	iph.version = 4;
> +
> +	bpf_lwt_push_encap(skb, BPF_LWT_ENCAP_IP, &iph, sizeof(struct iphdr));
> +
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";


