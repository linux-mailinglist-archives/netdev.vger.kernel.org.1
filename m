Return-Path: <netdev+bounces-258139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGRYOPNwi2lhUQAAu9opvQ
	(envelope-from <netdev+bounces-258139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 18:54:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E95B11E235
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 18:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ADD873016EF0
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 17:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA6638A9A0;
	Tue, 10 Feb 2026 17:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cx1dN0hH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB668209F43;
	Tue, 10 Feb 2026 17:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770746094; cv=none; b=tlTuFRjG+Gjg8pAybz91eEnLpAR1QBMviXq/JnpfIKxxvcnL6PP4ayIiIsmIMbVdYutKXi5+fpdDm7aGBOoWBRKPKSVjNo8exi0duud3UDVCIdqlBgd/YCUuJmbb7loHgvfUYW2wpur4OrZz3Y6sZQ7vqTLoxvFP93C8JxZJBpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770746094; c=relaxed/simple;
	bh=rYeZ3klsKY1YG7OtbH4ZTtsskEDYDxBsjAqO/hHR+9k=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uhlZ3Q1/QfkudY43L0zz6L9Cdju/+eY6EghMn8D1yG/oxG+w27vfRVs5TCKbcXUcSb/1IKK1ktgUe49hypGTtFQCAf2hhdsm/vaPilusxaDZsMJR+sbuL/LEKnrHdy6apn4QEL4UcYbQYEGeqcBNd5pxd1kq91mo56zMUpFPXis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cx1dN0hH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E21C116C6;
	Tue, 10 Feb 2026 17:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770746094;
	bh=rYeZ3klsKY1YG7OtbH4ZTtsskEDYDxBsjAqO/hHR+9k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=cx1dN0hH4qmxVFBUbAzYn93ccRvQOifix5jd509zwFydIY81ObDTydph8BhYG6uXK
	 YALA37O9ksudu7K+ySHS7HtaJmhBdc4RYL+4LlC7SaeRf7mI65f08brJ2TFxhmLS4m
	 UDpJaiJ8Q4stCbYslb+msp0tc6A3Ii3otUg/r1qo2XzfW+XKJa0AfzPjR/JMNJSKMP
	 go+obanrDrS5dXgqSL5TF1+7JXfXrW5D3BLNMT1bbYUp3HT9OfrN+282ukm+ssGrFD
	 VVDxJNlB5vJy5Wh9NgCygB9/iWqnae0eKDtlrfsNRi405duPQp/VwCYsuNOiMKGrh5
	 dSBZXL+dCj1hA==
Content-Type: multipart/mixed; boundary="===============2885316481438239449=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0900ad8e7ac913e4af38568dc5f51849e2110f7a986b115e134f4b5391ad9da1@mail.kernel.org>
In-Reply-To: <20260210-bpf-xdp-meta-rxcksum-v1-1-e5d55caa0541@kernel.org>
References: <20260210-bpf-xdp-meta-rxcksum-v1-1-e5d55caa0541@kernel.org>
Subject: Re: [PATCH bpf-next 1/5] netlink: specs: Add XDP RX checksum capability to XDP metadata specs
From: bot+bpf-ci@kernel.org
To: lorenzo@kernel.org,donald.hunter@gmail.com,kuba@kernel.org,davem@davemloft.net,edumazet@google.com,pabeni@redhat.com,horms@kernel.org,ast@kernel.org,daniel@iogearbox.net,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,andrew+netdev@lunn.ch,anthony.l.nguyen@intel.com,przemyslaw.kitszel@intel.com,aleksander.lobakin@intel.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,maciej.fijalkowski@intel.com
Cc: jakub@cloudflare.com,netdev@vger.kernel.org,bpf@vger.kernel.org,intel-wired-lan@lists.osuosl.org,linux-kselftest@vger.kernel.org,lorenzo@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 10 Feb 2026 17:54:53 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev];
	FREEMAIL_CC(0.00)[cloudflare.com,vger.kernel.org,lists.osuosl.org,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	TAGGED_FROM(0.00)[bounces-258139-lists,netdev=lfdr.de,bpf-ci];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.kernel.org:mid]
X-Rspamd-Queue-Id: 7E95B11E235
X-Rspamd-Action: no action

--===============2885316481438239449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> index 330ece2eabdb..dc62d572e3ac 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> @@ -110,6 +110,13 @@ int rx(struct xdp_md *ctx)
>  	else
>  		meta->hint_valid |= XDP_META_FIELD_VLAN_TAG;
>
> +	err = bpf_xdp_metadata_rx_checksum(ctx, &meta->ip_summed,
> +					   &meta->cksum_meta);

This call to bpf_xdp_metadata_rx_checksum() appears to be missing its extern
declaration. The other kfuncs in this file have declarations like:

extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
                                         __u64 *timestamp) __ksym;
extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
                                    enum xdp_rss_hash_type *rss_type) __ksym;
extern int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
                                        __be16 *vlan_proto,
                                        __u16 *vlan_tci) __ksym;

Should there be a corresponding declaration for bpf_xdp_metadata_rx_checksum?

> +	if (err)
> +		meta->rx_cksum_err = err;
> +	else
> +		meta->hint_valid |= XDP_META_FIELD_CHECKSUM;
> +
>  	__sync_add_and_fetch(&pkts_redir, 1);
>  	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
>  }

> diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c

[ ... ]

> @@ -254,6 +277,11 @@ static void verify_xdp_metadata(void *data, clockid_t clock_id)
>  		printf("No rx_vlan_tci or rx_vlan_proto, err=%d\n",
>  		       meta->rx_vlan_tag_err);
>  	}
> +
> +	if (meta->hint_valid & XDP_META_FIELD_CHECKSUM)
> +		print_rx_cksum(meta->ip_summed, meta->cksum_meta);
> +	else
> +		printf("No rx_chsum, err=%d\n", meta->rx_cksum_err);
                       ^^^^^^

Minor typo: "rx_chsum" should be "rx_cksum" to match the variable naming
(rx_cksum_err) and be consistent with other similar messages.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21875603263

AI-authorship-score: low
AI-authorship-explanation: The commit is from an established kernel maintainer and follows existing code patterns, with the errors being typical human oversights (missing declaration, typo) rather than AI-generated issues.
issues-found: 2
issue-severity-score: medium
issue-severity-explanation: Missing extern declaration for kfunc will cause compilation failure of the BPF selftest program, plus a minor typo in error output.

--===============2885316481438239449==--

