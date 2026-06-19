Return-Path: <netdev+bounces-300756-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DGLsEOGrNWrL2wYAu9opvQ
	(envelope-from <netdev+bounces-300756-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 22:51:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDFB6A7B8B
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 22:51:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IU2bkaQA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300756-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300756-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 258EB30A3EF6
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 20:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B36C3C3BF1;
	Fri, 19 Jun 2026 20:50:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B723C0604;
	Fri, 19 Jun 2026 20:50:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902245; cv=none; b=pAg8Dlc/8mwkNC66th6YDWyjRgaRrW2k4Cvag6SHAeq6fKD5r6zjMjj9xST3WKWPf33f3HUIKaPrSLAZy4XS+/pJOazbPND8fjArijm4nHyLgOH4ze0K/6hsUJj2sAIrpYcMdcDcivj2A/4lmr+YLmFkiHN8bZPVM3UzdfmlqyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902245; c=relaxed/simple;
	bh=ajgvYhqUtWSFk9GBi9nR3h0PR5l1Tcuumuxmv3cYT38=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=o6dbKukyqczOIbHVPDZUdnxsbRSSBfy0Vp1zW1h9UyizHs5AarHidmTM3eEuwCqY8RCOB3lN+jlbk3p0RVSrtmOtUEpkM4sw2qGcsLPRQUE3elg6w+ySFtzANLSGO+JgTdc2w70WUK2Vti12bEPodhUHbqCpSJAjvHq1ljCWr6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IU2bkaQA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBD61F00A3A;
	Fri, 19 Jun 2026 20:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781902244;
	bh=DHbc+zUM7ND1EZuKKgb/Vu7RbRDJAn82TUt8szpPF8A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IU2bkaQA6EnI75YHVhRky4huHYuYkhAJsE61pqD7R9qgLyNISkG/XSHEgPgy1fl20
	 pZZjzajPyAbIjP4vcIj0Bp3n5LUFlbL9qELi0BMfqagXIPyTa8RNbh/XCiQH6ShMwO
	 U7X7lBgo2XppJDRBzDNTX4ZlhA2TbyaWjXGZvariNm9402KrEzTs/gkO1c++ySjZoI
	 Zg4u7NlGyw4E7hb7U9YG/ZKRT++b2ml7i9qZfYFXtoi/YG3I/jHqvqVujtPN2quPt+
	 Dl/32WjNsrinbYHbZYoVFfi39M/w4ZIsTbvgkHba1p/mRfuXD0pyA3qCoHYiF3J6KV
	 Kk7w5/0fG4XLQ==
Content-Type: multipart/mixed; boundary="===============2092253668122568770=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dd9c6b6d282bc710c610e6f431562c211cab0e58b5c8a1469c3604c334570996@mail.kernel.org>
In-Reply-To: <20260619195759.41254-3-siddharthcibi@icloud.com>
References: <20260619195759.41254-3-siddharthcibi@icloud.com>
Subject: Re: [PATCH 2/2] selftests/bpf: validate rx_queue_index in xdp_metadata
From: bot+bpf-ci@kernel.org
To: siddharthcibi@icloud.com,ast@kernel.org
Cc: siddharthcibi@icloud.com,daniel@iogearbox.net,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,netdev@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 19 Jun 2026 20:50:43 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	TAGGED_FROM(0.00)[bounces-300756-lists,netdev=lfdr.de,bpf-ci];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[icloud.com,iogearbox.net,davemloft.net,kernel.org,gmail.com,fomichev.me,linux.dev,etsalapatis.com,vger.kernel.org,meta.com];
	FORGED_RECIPIENTS(0.00)[m:siddharthcibi@icloud.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:martin.lau@kernel.org,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[icloud.com,kernel.org];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[icloud.com:email,vger.kernel.org:from_smtp,mail.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9DDFB6A7B8B

--===============2092253668122568770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Extend xdp_metadata selftest coverage to validate that
> ctx->rx_queue_index is preserved and observable after XDP redirect
> execution.
>
> Capture rx_queue_index in metadata and assert that it matches the
> expected queue during packet verification.
>
> Signed-off-by: Siddharth_Cibi <siddharthcibi@icloud.com>

The changelog says the test validates that ctx->rx_queue_index is
"preserved and observable after XDP redirect execution".

Looking at the program in progs/xdp_metadata.c, rx() reads
ctx->rx_queue_index and then redirects into an XSKMAP:

	meta->rx_queue_index = ctx->rx_queue_index;
	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);

The AF_XDP delivery path copies the frame and metadata straight into
the umem and does not re-run an XDP program after the redirect, so the
value stored in meta->rx_queue_index is the one read in the original
ingress context rather than a value restored on a later re-execution.

Does the assert in verify_xsk_metadata() actually exercise a
redirect-restore path, or does it pass purely from the value captured
in the ingress program?

This isn't a bug, but could the changelog describe which redirect path
the test exercises, since the AF_XDP (XSKMAP) path does not re-run an
XDP program after the redirect?

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> index 5c31054ad4a4..f8cabbbe7bb7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> @@ -309,7 +309,8 @@ static int verify_xsk_metadata(struct xsk *xsk, bool sent_from_af_xdp)
>
>  	if (!ASSERT_NEQ(meta->rx_hash, 0, "rx_hash"))
>  		return -1;
> -
> +	if (!ASSERT_EQ(meta->rx_queue_index, QUEUE_ID, "rx_queue_index"))
> +        	return -1;

This isn't a bug, but the new return is indented with eight spaces
followed by a tab, while the other return -1; statements in
verify_xsk_metadata() use two tabs. Could it use tabs to match the
surrounding lines?

>  	if (!sent_from_af_xdp) {
>  		if (!ASSERT_NEQ(meta->rx_hash_type & XDP_RSS_TYPE_L4, 0, "rx_hash_type"))
>  			return -1;
> diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
> index 09bb8a038d52..62ae83860d7f 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
> @@ -98,7 +98,7 @@ int rx(struct xdp_md *ctx)
>  	bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_type);
>  	bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_proto,
>  				     &meta->rx_vlan_tci);
> -
> +	meta->rx_queue_index = ctx->rx_queue_index;
>  	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27846609854
--===============2092253668122568770==--

