Return-Path: <netdev+bounces-258633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KC/gBIlKj2moPQEAu9opvQ
	(envelope-from <netdev+bounces-258633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 17:00:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4ED137C10
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 17:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2F4B304A33E
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 16:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E740C36212C;
	Fri, 13 Feb 2026 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PO6qpfob"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BA12DF142;
	Fri, 13 Feb 2026 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770998404; cv=none; b=F5EnQcB3DtYHY2lk1Vz+K2mEMO8iERUc4LiyocfM/BFaWPjnASOtsWiL70FfMcReHC0L1xgMZXnHLRqG1xNiBgFz5CUmGdLHyRMBLpG/Jt8a28r+HvwpNOtTieNssvysf3Aq8rv8XryToqfQpKmRRNk6cd7LKIWd+5WE26ceGp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770998404; c=relaxed/simple;
	bh=htj5CG4XbCYS2OBEp+fFy3//ixph86NvzHpZtlK6GQQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pRrPcvS3JR0hjRSNZId450MmDI2TgqOCYKwkujAU8AVAZnlpMjeO4vP1QXxPmrcVybuthl0806tI/NZHPpFmkr3Dt/bHsy9mDv2ZKcrb48CpKc8j3F3eWEwZLJ5tuitqAOzg+2O8vB2KrDj4RLmz1QRBh+TkjUZGW3W1m1ptKGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PO6qpfob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB3CC116C6;
	Fri, 13 Feb 2026 16:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770998404;
	bh=htj5CG4XbCYS2OBEp+fFy3//ixph86NvzHpZtlK6GQQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=PO6qpfobnSGAdk5XoP2L4ve2cC7Zh5Wy7K7Wmdk+3PRTmW8WAajrsjjBh4pWvnfVv
	 3KsFzXhjYuzkvrKhDcihTH1zf41Aq+mHCe9MzdGusSnn/oYxI2hHhs6zn4YijNmyCe
	 N9bNe1fnulUAeaeIXxWGZwfPcP/rh2a+PWqFFJ9Ds5kOKfG55IMcL1idJqGBAI2SNs
	 oIH1mDsnm7YKskJQdZkR8HeGtTbUZylkQNIPztLDRcW9wL8PLejA/Zpx6kz7eQy8Q2
	 K5xeBlj9aT9VdXxsDfrELCMKpnnqI4327uh0CL2CtTVeAeRnQqKXxLePre1FWofSx5
	 me940Cvtj3aOQ==
Content-Type: multipart/mixed; boundary="===============8899739924151597861=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <72f306ad97f0194172e87121cacbf50a40a9110f002e295a23630b6a3e68ff09@mail.kernel.org>
In-Reply-To: <20260213-bpf-xdp-meta-rxcksum-v2-1-a82c4802afbe@kernel.org>
References: <20260213-bpf-xdp-meta-rxcksum-v2-1-a82c4802afbe@kernel.org>
Subject: Re: [PATCH bpf-next v2 1/5] netlink: specs: Add XDP RX checksum capability to XDP metadata specs
From: bot+bpf-ci@kernel.org
To: lorenzo@kernel.org,donald.hunter@gmail.com,kuba@kernel.org,davem@davemloft.net,edumazet@google.com,pabeni@redhat.com,horms@kernel.org,ast@kernel.org,daniel@iogearbox.net,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,andrew+netdev@lunn.ch,anthony.l.nguyen@intel.com,przemyslaw.kitszel@intel.com,aleksander.lobakin@intel.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,maciej.fijalkowski@intel.com
Cc: jakub@cloudflare.com,netdev@vger.kernel.org,bpf@vger.kernel.org,intel-wired-lan@lists.osuosl.org,linux-kselftest@vger.kernel.org,lorenzo@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 13 Feb 2026 16:00:03 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev];
	FREEMAIL_CC(0.00)[cloudflare.com,vger.kernel.org,lists.osuosl.org,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	TAGGED_FROM(0.00)[bounces-258633-lists,netdev=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[40];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB4ED137C10
X-Rspamd-Action: no action

--===============8899739924151597861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Moreover, introduce xmo_rx_checksum netdev callback in order allow the
> eBPF program bounded to the device to retrieve the RX checksum result

This isn't a bug, but "in order allow" should be "in order to allow",
and "bounded" should be "bound".

> diff --git a/net/core/xdp.c b/net/core/xdp.c
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c

[ ... ]

> +/**
> + * bpf_xdp_metadata_rx_checksum - Read XDP frame RX checksum.
> + * @ctx: XDP context pointer.
> + * @ip_summed: Return value pointer indicating checksum result.
> + * @cksum_meta: Return value pointer indicating checksum result metadata.
> + *
> + * In case of success, ``ip_summed`` is set to the RX checksum result. Possible
> + * values are:
> + * ``XDP_CHECKSUM_NONE``
> + * ``XDP_CHECKSUM_UNNECESSARY``
> + * ``XDP_CHECKSUM_COMPLETE``
> + *
> + * In case of success, ``cksum_meta`` contains the hw computed checksum value
> + * for ``XDP_CHECKSUM_COMPLETE`` or the ``csum_level`` for
> + * ``XDP_CHECKSUM_UNNECESSARY``. It is set to 0 for ``XDP_CHECKSUM_NONE``
> + *
> + * Return:
> + * * Returns 0 on success or ``-errno`` on error.
> + * * ``-EOPNOTSUPP`` : means device driver does not implement kfunc
> + * * ``-ENODATA``    : means no RX-timestamp available for this frame
                                      ^^^^^^^^^^^^

Should this say "RX-checksum" instead of "RX-timestamp"? This looks
like it was copied from bpf_xdp_metadata_rx_timestamp().

> + */
> +__bpf_kfunc int bpf_xdp_metadata_rx_checksum(const struct xdp_md *ctx,
> +					     enum xdp_checksum *ip_summed,
> +					     u32 *cksum_meta)
> +{
> +	return -EOPNOTSUPP;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21992879200

AI-authorship-score: low
AI-authorship-explanation: Grammar mistakes and copy-paste error in kdoc are characteristic of human authorship by a non-native English speaker; Lorenzo Bianconi is an established kernel contributor.
issues-found: 2
issue-severity-score: low
issue-severity-explanation: Both issues are documentation errors: a copy-paste error in the kdoc (-ENODATA description says RX-timestamp instead of RX-checksum) and commit message grammar mistakes; neither affects runtime behavior.

--===============8899739924151597861==--

