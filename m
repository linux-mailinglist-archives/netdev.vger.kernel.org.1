Return-Path: <netdev+bounces-283797-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNYHGX99+GkowAIAu9opvQ
	(envelope-from <netdev+bounces-283797-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 13:05:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E814BC21F
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 13:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50C4C302CD00
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 11:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306FB3AA4EF;
	Mon,  4 May 2026 11:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqaiFVQ8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0768B3A7597;
	Mon,  4 May 2026 11:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777892590; cv=none; b=iSQsrX9PGNBWJX3xXE9qqOBm7q6QGPulYpUCAQyntR3qfjw3KFd6o6YBWiquNha6AvcZ+w0YLBxckm2a7dUZ/l32Mop2gQ25nc2XOaCX6EAwN34MRoBz8Lx8zDn0ngFFJOehI59giE2Rk1zhFP5hR9kPHP5GZQfpdPOni0mrTnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777892590; c=relaxed/simple;
	bh=obeiVtyp4Aj7jNlwRQKxtGryEoah8EYRmG/dfY1J/D0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Qp9WHS23nG1PY3F9DFREXs+bV02E/+8nNfIV7noCjQEUQ3NsPrLZzv8xl/lQ0ef+UssJ65EOcmz8fYngAJo6ZTjB14FwxvaEdio8s5W0XeQKD3VvLOciLWXVyYPLIj5PYtLSWIYtVgTYu8Bm2ohUd2u6gofGBR3tQngrGSxSeTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqaiFVQ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C680C2BCB8;
	Mon,  4 May 2026 11:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777892589;
	bh=obeiVtyp4Aj7jNlwRQKxtGryEoah8EYRmG/dfY1J/D0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=gqaiFVQ8ZwcbanWBWYFRgAHWwph3f2dmY8xqXpMJbLKetZdJ7jDJ5vG20+mABkMgj
	 WC0IG1JesYdnKUfDTDEf+WiTFe8ZpQfLRIsOhxl3mP4LCKj4Ft4gn+OmjFQ8zUYAce
	 S3rXqo/z0H1VJ3wIN95Xx6aG6pQXoziB87z1Hbj/NILBzv7OfQCq9miz2GWu3heOOh
	 2nBoPMRid/b0SPZJTNUuThL8fiM/V5Z5fqG+Tl96KBwUDNV29HU2oeNQ7rHpBxwtC9
	 khm7UifZsKSPIXhMWZ9pTzzGALGKn9SYZCJUHkYVNIHpH3L0jUveWEof4S/nHA5JAb
	 LtJcYXPe4QX/Q==
Content-Type: multipart/mixed; boundary="===============2329766587970040855=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b34cad7979e008864dda72087dc003fa1228bf61210d824cdb5793e9f0f96794@mail.kernel.org>
In-Reply-To: <20260504101759.3319427-2-nhudson@akamai.com>
References: <20260504101759.3319427-2-nhudson@akamai.com>
Subject: Re: [PATCH v6 1/6] bpf: name the enum for BPF_FUNC_skb_adjust_room flags
From: bot+bpf-ci@kernel.org
To: nhudson@akamai.com,bpf@vger.kernel.org,netdev@vger.kernel.org,willemb@google.com,martin.lau@linux.dev
Cc: nhudson@akamai.com,mtottenh@akamai.com,aglasgal@akamai.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  4 May 2026 11:03:07 +0000 (UTC)
X-Rspamd-Queue-Id: D2E814BC21F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[akamai.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org,linux.dev,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-283797-lists,netdev=lfdr.de,bpf-ci];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

--===============2329766587970040855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 552bc5d9afbd..c021ed8d7b44 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6211,7 +6211,7 @@ enum {
>  };
>
>  /* BPF_FUNC_skb_adjust_room flags. */
> -enum {
> +enum bpf_adj_room_flags {
>  	BPF_F_ADJ_ROOM_FIXED_GSO	= (1ULL << 0),
>  	BPF_F_ADJ_ROOM_ENCAP_L3_IPV4	= (1ULL << 1),
>  	BPF_F_ADJ_ROOM_ENCAP_L3_IPV6	= (1ULL << 2),

Martin KaFai Lau raised a concern in v2 about demonstrating the intended
CO-RE usage, specifically suggesting bpf_core_enum_value_exists():

https://lore.kernel.org/bpf/e5a2ad16-d2ac-4fa0-be41-162227257682@linux.dev/

He also requested that similar tests be added to test_tc_tunnel.c for the
new flags, as was done for earlier BPF_F_ADJ_ROOM_* flag additions.

While v3+ added selftests for decap GSO state validation, does the current
version include tests that explicitly demonstrate the CO-RE enum lookups for
bpf_adj_room_flags that motivated naming this enum?

> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 677be9a47347..ca35ed622ed5 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25314425016
--===============2329766587970040855==--

