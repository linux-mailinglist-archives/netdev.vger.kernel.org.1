Return-Path: <netdev+bounces-279131-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6G5tGHUz4Wm4qQAAu9opvQ
	(envelope-from <netdev+bounces-279131-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 21:07:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB8A413FB0
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 21:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 755DB305F7F1
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 19:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3252930F927;
	Thu, 16 Apr 2026 19:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uYpWJ3Av"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D282FF672
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 19:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776366392; cv=none; b=T1yhgEz4MOnp3gXpYYjxrna7iGLqK4uK43rErc8TNZH7Lw56kIguU17W3cekpZfUtM2LqjaxbLK8Sz30ngc3T6A5V3UNKlgCIeDS3Gn5zEMEtYRuqg772174+1oURCGtEAqko0LQIxNBaPVt1H49VAeDOb67qNTCIkGrR7RTFhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776366392; c=relaxed/simple;
	bh=t2BU4POuNqnQHfs1v7jsAchuyRFNIXmVxb2kXc0/Yr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dI0QFGOfuvTWqpC/wR4mvE5tKvZB9RtBNPw7Ivwhhmt6s+f/wKzRfZEk4UwZasNbS6yUUJibFUEexmFTUcZ1fWBsGva1NCa6tpr8oUbICZORdEkLrsfXRRIJB8hlgUlR6Aq0n2+Y++3jQfsmh+PzmHkHk19FIrXoLM8p3z8G9JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uYpWJ3Av; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 16 Apr 2026 12:06:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776366387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KKcufqME6AclWOFSO2Pn6FBNuFdVFsZOL3F1tIQrun8=;
	b=uYpWJ3AvnglL9gowTEPCFHr5rS3M/bKDfOJc6Zt7jlmhEMLTVSQ1Kn1x+DyimYbmr615FE
	b4aoy+ytRdu1mZKA53vfSV5V/PnW2CBvxGXWtf5B0oe9AHL/DV4MDqAvfMgTGiJg3aDdNT
	wqbz7hytcBdUoegyOeZiNizyxMENf20=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: KaFai Wan <kafai.wan@linux.dev>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, jiayuan.chen@linux.dev, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Test TCP_NODELAY in TCP hdr
 opt callbacks
Message-ID: <2026416184330.-HAW.martin.lau@linux.dev>
References: <20260416112308.1820332-1-kafai.wan@linux.dev>
 <20260416112308.1820332-3-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416112308.1820332-3-kafai.wan@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279131-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[iogearbox.net,gmail.com,fomichev.me,kernel.org,linux.dev,davemloft.net,google.com,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9FB8A413FB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 07:23:08PM +0800, KaFai Wan wrote:
> index 56685fc03c7e..2d738c0c4259 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
> @@ -513,6 +513,59 @@ static void misc(void)
>  	bpf_link__destroy(link);
>  }
>  
> +static void hdr_sockopt(void)
> +{
> +	const char send_msg[] = "MISC!!!";
> +	char recv_msg[sizeof(send_msg)];
> +	const unsigned int nr_data = 2;
> +	struct bpf_link *link;
> +	struct sk_fds sk_fds;
> +	int i, ret, true_val = 1;
> +
> +	lport_linum_map_fd = bpf_map__fd(misc_skel->maps.lport_linum_map);
> +
> +	link = bpf_program__attach_cgroup(misc_skel->progs.misc_hdr_sockopt, cg_fd);
> +	if (!ASSERT_OK_PTR(link, "attach_cgroup(misc_hdr_sockopt)"))
> +		return;
> +
> +	if (sk_fds_connect(&sk_fds, false)) {
> +		bpf_link__destroy(link);
> +		return;
> +	}
> +
> +	ret = setsockopt(sk_fds.active_fd, SOL_TCP, TCP_NODELAY, &true_val, sizeof(true_val));
> +	if (!ASSERT_OK(ret, "setsockopt(TCP_NODELAY) active"))
> +		goto check_linum;
> +
> +	ret = setsockopt(sk_fds.passive_fd, SOL_TCP, TCP_NODELAY, &true_val, sizeof(true_val));

Why are these two setsockopt(TCP_NODELAY) calls needed?

Instead of creating a new "void hdr_sockopt(void)", can the test be done in the
existing "void misc(void)" by doing bpf_setsockopt(TCP_NODELAY) in the
misc_estab() bpf prog?

The PASSIVE_ESTABLISHED_CB can do the bpf_setsockopt(TCP_NODELAY, 0)
if it wants to keep the same expectation on Nagle. The
BPF_SOCK_OPS_HDR_OPT_LEN_CB and BPF_SOCK_OPS_WRITE_HDR_OPT_CB
can do bpf_setsockopt(TCP_NODELAY, 1) to test recursion and
the error return value.

>  void test_tcp_hdr_options(void)
> diff --git a/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c b/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
> index d487153a839d..a8cf7c4e7ed2 100644
> --- a/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
> +++ b/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
> @@ -28,6 +28,12 @@ unsigned int nr_data = 0;
>  unsigned int nr_syn = 0;
>  unsigned int nr_fin = 0;
>  unsigned int nr_hwtstamp = 0;
> +unsigned int nr_hdr_sockopt_estab = 0;
> +unsigned int nr_hdr_sockopt_estab_err = 0;
> +unsigned int nr_hdr_sockopt_len = 0;
> +unsigned int nr_hdr_sockopt_len_err = 0;
> +unsigned int nr_hdr_sockopt_write = 0;
> +unsigned int nr_hdr_sockopt_write_err = 0;

nr_hdr_sockopt_estab, nr_hdr_sockopt_len, and nr_hdr_sockopt_write
are unnecessary. These tests have already been covered in some ways.

Mostly a nit. The new counters are used in both connections. Note the
existing nr_xxx is exclusively used in either active or passive,
so there is no parallel counting in practice.

Instead of counting, just use a bool nodelay_est_ok,
nodelay_hdr_len_err, nodelay_write_err and assert them
to be true in userspace.

