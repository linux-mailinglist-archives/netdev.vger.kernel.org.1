Return-Path: <netdev+bounces-258990-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ0XEEEylGkNAgIAu9opvQ
	(envelope-from <netdev+bounces-258990-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 10:17:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D82CA14A4B1
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 10:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 627F1300B9D6
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 09:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A20B302163;
	Tue, 17 Feb 2026 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NilVoq0j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D392FE593;
	Tue, 17 Feb 2026 09:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771319869; cv=none; b=kO6tdpei7RrjjXhy3VvGRzclggZix9NbEW40ACSaNFCCKOQG2LnEshIqVEqwZ3o+f+C1HT68zXyrBELg4ShJ34dAN/xgbUWMbjQetmPLe0xQsWmuT8U9dzrFv0f20RQvGG688IKQ/DnRYnjr/QJMXT4ct9NzD/lH/jzPZnKCqIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771319869; c=relaxed/simple;
	bh=VD1W6Yh8O0HczIuc809B8SdiqAX3gxVye/bDQIHDEYA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rrdgF31fDSWEUNcPtTgLvq8l0OWBUjrAfLmKVY2jmhSkKBStGVMAVEXtXF1tCqgij9EkS032i1FdR5DKFQI+gzykWFK09FZFITMh8QxtXJkoJEXCBjTXuJ59Iyd7IpTWEp7pRvaNSwkV9vyygjbhJYOwdJxj+8O/pTESaNcEMI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NilVoq0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167F4C4CEF7;
	Tue, 17 Feb 2026 09:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771319868;
	bh=VD1W6Yh8O0HczIuc809B8SdiqAX3gxVye/bDQIHDEYA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=NilVoq0jUGjdtQEohI0ld8tCcQ66gDq2r5k2x1mVbRJpyBy9oDH6Jc9zv4NhD0KxC
	 s6kYqYc8OelFCQstpcUQ27bT3Vi7NJNobzFjqX/XOAKNqIdFGr80Q+WucTsiMvuJR8
	 fe5hSGXxnUZVOCrk3f3cDwPrkpwDLPPeuYPp10PbjGc0/kkn4Zj5d76g/plSpGUJvP
	 E9/ce1tZeGWhbjOqvUkKISPqRIZgS3vqF3Mudue/KOpkJfZk6JHrRbUt/Jt38If4np
	 Aumit0zQTm6LwUOxapKsyp+gBoHcP/uHEn9MPYBjTC/tEk9nalkYKiBs0aRjsL+zlQ
	 zuBpKBRm4bdkw==
Content-Type: multipart/mixed; boundary="===============2605647824317503671=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2f8cd0a2da03a180287cb70d1f399cfaf80f8c32983605f1716806bf3fe83e7e@mail.kernel.org>
In-Reply-To: <20260217-bpf-xdp-meta-rxcksum-v3-4-30024c50ba71@kernel.org>
References: <20260217-bpf-xdp-meta-rxcksum-v3-4-30024c50ba71@kernel.org>
Subject: Re: [PATCH bpf-next v3 4/5] selftests/bpf: Add selftest support for bpf_xdp_metadata_rx_checksum
From: bot+bpf-ci@kernel.org
To: lorenzo@kernel.org,donald.hunter@gmail.com,kuba@kernel.org,davem@davemloft.net,edumazet@google.com,pabeni@redhat.com,horms@kernel.org,ast@kernel.org,daniel@iogearbox.net,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,andrew+netdev@lunn.ch,anthony.l.nguyen@intel.com,przemyslaw.kitszel@intel.com,aleksander.lobakin@intel.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,maciej.fijalkowski@intel.com
Cc: jakub@cloudflare.com,netdev@vger.kernel.org,bpf@vger.kernel.org,intel-wired-lan@lists.osuosl.org,linux-kselftest@vger.kernel.org,aleksandr.loktionov@intel.com,lorenzo@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 17 Feb 2026 09:17:48 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev];
	FREEMAIL_CC(0.00)[cloudflare.com,vger.kernel.org,lists.osuosl.org,intel.com,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	TAGGED_FROM(0.00)[bounces-258990-lists,netdev=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[41];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D82CA14A4B1
X-Rspamd-Action: no action

--===============2605647824317503671==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
> --- a/tools/testing/selftests/bpf/xdp_metadata.h
> +++ b/tools/testing/selftests/bpf/xdp_metadata.h

[ ... ]

> +	struct {
> +		__u8 ip_summed;
> +		__u32 cksum_meta;
> +	};

The ip_summed field is __u8 (1 byte), but bpf_xdp_metadata_rx_checksum()
takes an enum xdp_checksum * argument, which is 4 bytes.

In the BPF program:

> diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
> --- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c

[ ... ]

> +	bpf_xdp_metadata_rx_checksum(ctx,
> +				     (enum xdp_checksum *)&meta->ip_summed,
> +				     &meta->cksum_meta);

The cast here passes a pointer to a 1-byte field where the kfunc will
perform a 4-byte store.  On little-endian this happens to work because
the value lands in the low byte and the remaining 3 bytes go into struct
padding.

On big-endian, the value would be stored in the high byte, so reading
back ip_summed as __u8 would yield 0 for any checksum result.

For comparison, the other metadata fields match their kfunc argument
sizes: rx_hash is __u32 matching u32 *, and rx_hash_type is __u32
matching enum xdp_rss_hash_type *.

Should ip_summed be __u32 (or enum xdp_checksum) to match the kfunc
signature and avoid the cast?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22091902298

AI-authorship-score: low
AI-authorship-explanation: Code and commit message follow established kernel selftest patterns consistent with a known contributor, and the type choice reflects human engineering judgment.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Type size mismatch in selftest code where a __u8 field is cast to enum xdp_checksum * (4 bytes) for a kfunc call, causing incorrect behavior on big-endian architectures.

--===============2605647824317503671==--

