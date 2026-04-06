Return-Path: <netdev+bounces-275771-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOaTCow71GlqsQcAu9opvQ
	(envelope-from <netdev+bounces-275771-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 01:02:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CBA3A7FE8
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 01:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79D0F30156D0
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 23:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F6B358D00;
	Mon,  6 Apr 2026 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZBzCB14q"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD4E38C40B
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 23:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775516551; cv=none; b=YwvYAUxcu+m7CYua4P8piAHWUxFyH7gLgPZJli8/90xqQAQkJp1SExs9udoFguAX7rmJfSOlzYZUA9mMRE/Cr0KR6hXe8s8GtBMot6DIjJsbVwHeVTTkt+XJ3s8KfP6DjKsX+ts9fFxsNBtIC3YaXZ9GepM/pSsOCbJxv1fhBWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775516551; c=relaxed/simple;
	bh=Q5zRmNCGgjmb+k1Ko/d6Ib9Ro3BF12D/TVnqoD65jV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXGBEzD8ksvpbR+1CNt/Exof1cp3xbc9Iuqk4ZkKbnddB1ZZmEp4nYrE4rQ8Govr2zaOuZZfQFiyXESD6xUft7GD0AIJNNebLCJUDnSYRHkUAZWo7FtpqXbM3PkvjN1QkKTEPRFLH0eQGPBSfX5t3FLPmMwKaczNBIy/xJOx1kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZBzCB14q; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 6 Apr 2026 16:01:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775516538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kpuNbGzT5QRjxkn9LQ1+Gyc83mOaDfValyGOkjAk9Ww=;
	b=ZBzCB14q4snVlgWtOHXvPmVWA0BfWt6xES9HKjlqUkvHFuipvdatHY0cZSCnxcoZuwhVZ6
	F5Kb8WwBmwjlirTkets3IikXoMt7kqxAioBsDFxzMQ5mLRoCW0hhau9vldJC7cNsZ+ubh0
	YzaMAuDNv3K4O44NEDNve6i27tEXhxw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add tests for sock_ops ctx
 access with same src/dst register
Message-ID: <20264622473.hwTx.martin.lau@linux.dev>
References: <20260406031330.187630-1-jiayuan.chen@linux.dev>
 <20260406031330.187630-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406031330.187630-2-jiayuan.chen@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275771-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,iogearbox.net,gmail.com,fomichev.me,kernel.org,linux.dev,davemloft.net,google.com,redhat.com];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 84CBA3A7FE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 11:12:51AM +0800, Jiayuan Chen wrote:
> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_ops_get_sk.c b/tools/testing/selftests/bpf/prog_tests/sock_ops_get_sk.c
> new file mode 100644
> index 0000000000000..e086f7abb197e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/sock_ops_get_sk.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include "cgroup_helpers.h"
> +#include "network_helpers.h"
> +#include "sock_ops_get_sk.skel.h"
> +
> +/* See progs/sock_ops_get_sk.c for the bug description. */
> +static void run_sock_ops_test(struct sock_ops_get_sk *skel, int cgroup_fd,

skel is not used. sashiko has flagged it also.

pw-bot: cr

> +			      int prog_fd)
> +{
> +	int server_fd, client_fd, err;
> +
> +	err = bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0);
> +	if (!ASSERT_OK(err, "prog_attach"))
> +		return;
> +
> +	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
> +	if (!ASSERT_GE(server_fd, 0, "start_server"))
> +		goto detach;
> +
> +	/* Trigger TCP handshake which causes TCP_NEW_SYN_RECV state where
> +	 * is_fullsock == 0 and is_locked_tcp_sock == 0.
> +	 */
> +	client_fd = connect_to_fd(server_fd, 0);
> +	if (!ASSERT_GE(client_fd, 0, "connect_to_fd"))
> +		goto close_server;
> +
> +	close(client_fd);
> +
> +close_server:
> +	close(server_fd);
> +detach:
> +	bpf_prog_detach(cgroup_fd, BPF_CGROUP_SOCK_OPS);
> +}
> +
> +void test_sock_ops_get_sk(void)

Add a "ns" in the naming so that test_progs will start a new netns.

Like 'void test_ns_sock_ops_get_sk(void)'.

> +{
> +	struct sock_ops_get_sk *skel;
> +	int cgroup_fd;
> +
> +	cgroup_fd = test__join_cgroup("/sock_ops_get_sk");
> +	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))

nit. Use ASSERT_OK_FD check. Same for the other fd checks in this file.

