Return-Path: <netdev+bounces-299847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VE/kNHFNMWpMgQUAu9opvQ
	(envelope-from <netdev+bounces-299847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:19:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 501AD68FDA5
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:19:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gcS+eXT1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299847-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299847-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D99F6305DAC0
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 13:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1D631D375;
	Tue, 16 Jun 2026 13:17:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DA631D367
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 13:17:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781615874; cv=none; b=JEc8R450E5Pmpo6KAsnSX304wYPSKd3yZETdtRJGnHz7pgd02dz8cV2ECxEzJGe+t/Rp9OiS9pQCDM/RR4dL1vjQ5FLCvEImhcSixjjVSCJWImr63J4M8VQSN0UlwwVuLu5Y80CLnDA8dTZLJ+j2PF/UHMUmFp/23bhlssT7RJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781615874; c=relaxed/simple;
	bh=EGERGdCx2kYeS7W9iwSbT/bvqw0eSLVjuKRazBmEJAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1lQDNvMhU0Z7Ys+gmfiUVxwTXRm69lBDmCd8m9Ky+pIrL2FUZmjr5qbANVDoqwhnr2vreYLMTNQctA8akewA6NFsp7cK1KQXJEvtd1+Eduys0UposkMDKLg1WxyKSFaV+87RNToG+DapgL7CgqvLmBZjkBdghb8SLf+pjrKrrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcS+eXT1; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so43838075e9.1
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 06:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781615867; x=1782220667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=85JsgvYD1YLd3UTUsIZxYoHmTb8gB/2tl6mfyWcf1Bg=;
        b=gcS+eXT1DV6Kk1SiY7/E/IqA9dag6Mp38ZE4sRl4baYb2SXdnpMJTHsk/z8fXqLK7Z
         EI5aD0epiICHZNv4RDDf1g2UfWFLrLC/DfiYJ8mPQQ/B8EgN0zyWSQkkH5oLY7jBoByW
         9alOdozBbCr9yb6n8vWnoWKjZNZOlZZEvaaBKv5DKDgxhHzyOT0zlTyCj+5nsXSF/+vz
         A3XP4Qh0RRLDqimUZsgzLSjZ+Ez+5RrLXWl1kw8BzUkSQlVBOuxH3jPz3DX1j4PHPgZ+
         jH20l0y6fPrd1BMqRkTscinXjP1zrKAXoWa1ExUVEJT3aRBpqiJOLZDDXSFbB+5T4jIl
         3D1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781615867; x=1782220667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85JsgvYD1YLd3UTUsIZxYoHmTb8gB/2tl6mfyWcf1Bg=;
        b=NTuKGadyLj9XoNRSRoI3TKveZ81JLO0aUUBAWWjExbcwmHqv2q7yjFNoLDrtFnWbxN
         RRjPIYtJuV4ZwXE208HVVNuIyqlgFku228d9Fr1Sg821ynPnj+PXZuv6o4C31SouAAfO
         EkcAJV0ESzhT0++vX0vvxuZc4DibrD59lBIb2tjgO0AhZyc0qbPeR3uMOz6mYoNFOJah
         Qv8kxwaHJ/P99qgBKsCBvPe9us/2eA+DTI/oqN4aoEHNbqARzi7M/vwNdL76iAB3CZUP
         Xg6V2BHRCWKW6QklP7gSdokTExd2NvPnpk9KeuWxupVENF+Wpk3sWlyJ64LhC5tXyhHN
         Anzw==
X-Forwarded-Encrypted: i=1; AFNElJ/r4eme+p6jqlNpwPgbDRYoCWHId0CSKYQuLz+PmZxsO72kMSWh7vrnOewfMKCqm7EPpr+vY3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7r3xSyf8pBW58Xz6DpSw61ZafArQhVvBZW8KuHCzTJAQGJWLq
	ti1+dxI3UIeNMEOoqFgoOhxDDU/RGcgesQqQFmVZ1QX8I8XQGbLoa9eu
X-Gm-Gg: Acq92OE8608VogkR8lK5EDEQlFXAf+jXr7IA3ko7L+IhKUUAzCi4RDt1ENw9rf+lts0
	rpf+Zai0YWux0OoSFtk8fficHMys0QfOH2rzX79AEZCGIqIvMn5iMbySBrrR1QtFktK4EEfoDv3
	7qrgUFIZygQl8cDH9OsrxcYOGawKkWfPxxLTBHK60qaEnncVnavZUQZu+bG/6uxsUQpOYyg0mki
	+JsPpC0WTFu6bsVA5151haX4tdYhnI/jCJo7r2BXqud0nPJ0b3J+HUNNqEXUJunKtnVzePdOHuE
	ZuF78ELDZ/x+AxmP+OFt/vc/vPeS+s7xFapum1fqG5qPpErRdKLrD3h29sfgLhLIr7EQr4t4s2Y
	2BSW+lWxA4wvMDRqTifh0GtquhDVsnh0iir684KraWU2/rOwDeLH7Ig2HqMWOL+2XO/p9y6BgcV
	BiTB2qB65ugEqAt1D4o5zoJ7656LQyXt6vLxDS09z5ad4PAzmvMTCks7R98UgGYW+Ic7P+JWZiO
	xmtawMmeMWDZOc5SA0Ni7vn2gyawVhC8NCIJDRLo2GsXm4E808F56gUcuf5pTpmPx6YNIn7NPdH
	2J104hqfWM9c7rxCOZYfqO8Yb82SMYaXSdEmFCh4n94=
X-Received: by 2002:a05:600c:810b:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-4922fac1214mr55599015e9.6.1781615866488;
        Tue, 16 Jun 2026 06:17:46 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e004325bddd753d2e35.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:4325:bddd:753d:2e35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a4601esm67361305e9.1.2026.06.16.06.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:17:45 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:17:43 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	toke@redhat.com, lorenzo@kernel.org
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Cover partial copy of
 non-linear test_run output
Message-ID: <ajFM97xoXuDAUsuw@mail.gmail.com>
References: <20260616093103.471444-1-sun.jian.kdev@gmail.com>
 <20260616093103.471444-3-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616093103.471444-3-sun.jian.kdev@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299847-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sun.jian.kdev@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:toke@redhat.com,m:lorenzo@kernel.org,m:sunjiankdev@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[paulchaignon@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,google.com,redhat.com,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ctx.data:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 501AD68FDA5

On Tue, Jun 16, 2026 at 05:31:03PM +0800, Sun Jian wrote:
> prog_run_opts already verifies that BPF_PROG_TEST_RUN returns -ENOSPC
> for a short data_out buffer while still reporting the full output size
> through data_size_out.
> 
> Add the same coverage for non-linear test_run output. Use pass-through
> TC and XDP programs with a 9000-byte packet, a 64-byte linear data area,
> and a 100-byte data_out buffer. The expected output spans both the linear
> data and the first fragment.
> 
> Verify that test_run returns -ENOSPC, reports the full packet length
> through data_size_out, and copies the packet prefix into data_out for
> both non-linear skb and XDP frags paths.
> 
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/prog_run_opts.c  | 72 +++++++++++++++++++
>  .../selftests/bpf/progs/test_pkt_access.c     | 12 ++++
>  2 files changed, 84 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> index 01f1d1b6715a..71af1ff02023 100644
> --- a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> +++ b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> @@ -4,6 +4,10 @@
>  
>  #include "test_pkt_access.skel.h"
>  
> +#define NONLINEAR_PKT_LEN 9000
> +#define NONLINEAR_LINEAR_DATA_LEN 64
> +#define SHORT_OUT_LEN 100
> +
>  static const __u32 duration;
>  
>  static void check_run_cnt(int prog_fd, __u64 run_cnt)
> @@ -20,6 +24,71 @@ static void check_run_cnt(int prog_fd, __u64 run_cnt)
>  	      "incorrect number of repetitions, want %llu have %llu\n", run_cnt, info.run_cnt);
>  }
>  
> +static void init_pkt(__u8 *pkt, size_t len)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < len; i++)
> +		pkt[i] = i & 0xff;
> +}
> +
> +static void test_skb_nonlinear_data_out_partial(struct test_pkt_access *skel)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +	__u8 pkt[NONLINEAR_PKT_LEN];
> +	__u8 out[SHORT_OUT_LEN];
> +	struct __sk_buff skb = {};
> +	int prog_fd, err;
> +
> +	init_pkt(pkt, sizeof(pkt));

Can't we reuse pkt_v4 by reducing the linear area to ETH_HLEN?

> +	memset(out, 0xa5, sizeof(out));

Why is this needed?

> +
> +	skb.data_end = NONLINEAR_LINEAR_DATA_LEN;
> +
> +	topts.data_in = pkt;
> +	topts.data_size_in = sizeof(pkt);
> +	topts.data_out = out;
> +	topts.data_size_out = sizeof(out);
> +	topts.ctx_in = &skb;
> +	topts.ctx_size_in = sizeof(skb);
> +
> +	prog_fd = bpf_program__fd(skel->progs.tc_pass_prog);
> +	err = bpf_prog_test_run_opts(prog_fd, &topts);
> +
> +	ASSERT_EQ(err, -ENOSPC, "skb_nonlinear_partial_err");
> +	ASSERT_EQ(topts.data_size_out, sizeof(pkt), "skb_nonlinear_partial_data_size_out");
> +	ASSERT_OK(memcmp(out, pkt, sizeof(out)), "skb_nonlinear_partial_data_out");
> +}
> +
> +static void test_xdp_nonlinear_data_out_partial(struct test_pkt_access *skel)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +	__u8 pkt[NONLINEAR_PKT_LEN];
> +	__u8 out[SHORT_OUT_LEN];
> +	struct xdp_md ctx = {};
> +	int prog_fd, err;
> +
> +	init_pkt(pkt, sizeof(pkt));
> +	memset(out, 0xa5, sizeof(out));
> +
> +	ctx.data = 0;
> +	ctx.data_end = NONLINEAR_LINEAR_DATA_LEN;
> +
> +	topts.data_in = pkt;
> +	topts.data_size_in = sizeof(pkt);
> +	topts.data_out = out;
> +	topts.data_size_out = sizeof(out);
> +	topts.ctx_in = &ctx;
> +	topts.ctx_size_in = sizeof(ctx);
> +
> +	prog_fd = bpf_program__fd(skel->progs.xdp_frags_pass_prog);
> +	err = bpf_prog_test_run_opts(prog_fd, &topts);
> +
> +	ASSERT_EQ(err, -ENOSPC, "xdp_nonlinear_partial_err");
> +	ASSERT_EQ(topts.data_size_out, sizeof(pkt), "xdp_nonlinear_partial_data_size_out");
> +	ASSERT_OK(memcmp(out, pkt, sizeof(out)), "xdp_nonlinear_partial_data_out");
> +}
> +
>  void test_prog_run_opts(void)
>  {
>  	struct test_pkt_access *skel;
> @@ -69,6 +138,9 @@ void test_prog_run_opts(void)
>  	run_cnt += topts.repeat;
>  	check_run_cnt(prog_fd, run_cnt);
>  
> +	test_skb_nonlinear_data_out_partial(skel);
> +	test_xdp_nonlinear_data_out_partial(skel);
> +
>  cleanup:
>  	if (skel)
>  		test_pkt_access__destroy(skel);
> diff --git a/tools/testing/selftests/bpf/progs/test_pkt_access.c b/tools/testing/selftests/bpf/progs/test_pkt_access.c
> index bce7173152c6..cd284401eebd 100644
> --- a/tools/testing/selftests/bpf/progs/test_pkt_access.c
> +++ b/tools/testing/selftests/bpf/progs/test_pkt_access.c
> @@ -150,3 +150,15 @@ int test_pkt_access(struct __sk_buff *skb)
>  
>  	return TC_ACT_UNSPEC;
>  }
> +
> +SEC("tc")
> +int tc_pass_prog(struct __sk_buff *skb)
> +{
> +	return TC_ACT_OK;
> +}

Once we're reusing pkt_v4, maybe we can also reuse the existing BPF
program?

> +
> +SEC("xdp.frags")
> +int xdp_frags_pass_prog(struct xdp_md *ctx)
> +{
> +	return XDP_PASS;
> +}
> -- 
> 2.43.0
> 

