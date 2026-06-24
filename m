Return-Path: <netdev+bounces-301703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BNRvGMP7O2rZhQgAu9opvQ
	(envelope-from <netdev+bounces-301703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 17:46:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D01D76BFC2E
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 17:46:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=C64OKh33;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301703-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301703-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F3DE3011056
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 15:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3126F3DB310;
	Wed, 24 Jun 2026 15:45:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C9D302742
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 15:45:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782315958; cv=none; b=hDJegVSal0P5EnSZ0gpg7Ox19fdBz6HEEEw5w2OmZIYuwVlv4gyug3xw1pRQx+hrEnmN84QZqzvpipcZr9GDJSa72FVMmZFD/Ku9z/6FnNdi591/Jr+XeW7mMfBvjddNWPk22DuFO4iwpLv/zHEg38WnEh94pS5wPs4XrlCX4K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782315958; c=relaxed/simple;
	bh=XS4cXPoFYvBnGja9W7ZfoGm9rgCHoBtJF3SZvGBRGag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrjT6Y7Abvo5oP+PiiWbdz3Msu9JekjK4rQAHkzwREoN8uYir5Lsj61NcNBliM4btNa1YI91nOpedjL8IDOpTWDEv7enTb+IBEthWKztm3HPjo9giK2iuVCtf7pPb7zbaBCKoaDen5QlqXhvpTi0urSKvzuCiCSe1jx9cAmiDHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C64OKh33; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356F81F000E9;
	Wed, 24 Jun 2026 15:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782315956;
	bh=5raUOPHCS85WUgQHYMDf0LuoM3ZQ2QYkF6jPBJ4qiTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C64OKh33mZ6EORsDD7WBtCyXRckNlNqFsMCbxBD1MiVAAnaNOvSkEQldjiRPXGoDN
	 tJiGvVyOqiNoTXTeCxfTPGrrldCcIAVoRyfVac3gn2JUKa2qdl4YLFBJzAWLFQ8bDD
	 NTzCoRQSUdQd3P3bJGMcTizlDG7rCHGP3EMs1PRIv/jNqxa9Jfo6iPSBJ5iFpXL7t8
	 uIjMtb22cOUeH2Y6GM9JrG5QtuZLX71RzMMSWE2aOR+R5HDI5yj7O7pi+wgL1uzZXh
	 PJnchlJ5IWP/G1VyQDmjYfPS8Uerbul2pwE9bUmAxGUXc5XRUZJwJcwuQL+UHZV/Oy
	 rFjMBgTYa0g3w==
From: Simon Horman <horms@kernel.org>
To: 635381823cyj@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	moomichen@tencent.com
Subject: Re: [PATCH] xfrm: iptfs: propagate SKBFL_SHARED_FRAG in iptfs_skb_add_frags()
Date: Wed, 24 Jun 2026 16:45:31 +0100
Message-ID: <20260624154531.1140374-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623092258.70507-1-635381823cyj@gmail.com>
References: <20260623092258.70507-1-635381823cyj@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301703-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:635381823cyj@gmail.com,m:horms@kernel.org,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:moomichen@tencent.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D01D76BFC2E

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
xfrm: iptfs: propagate SKBFL_SHARED_FRAG in iptfs_skb_add_frags()

This patch sets SKBFL_SHARED_FRAG on the destination SKB after
iptfs_skb_add_frags() transfers frag references from a frag walk, to
prevent ESP's no-COW fast path from decrypting in place over pages still
referenced by the outer IPTFS SKB.

> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index ad810d1f97c0..0e0dcf47a470 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ -496,6 +496,10 @@ static int iptfs_skb_add_frags(struct sk_buff *skb,
>  		walk->past += frag->len;	/* careful, use src bv_len */
>  		walk->fragi++;
>  	}
> +
> +	if (skb_shinfo(skb)->nr_frags)
> +		skb_shinfo(skb)->flags |= SKBFL_SHARED_FRAG;
> +
>  	return len;
>  }

[High]
Does this placement cover every path that adds frags to the destination
SKB?  The new assignment sits after the while loop, but the loop has an
earlier exit that returns once the requested length is satisfied
mid-frag:

    while (len && walk->fragi < walk->nr_frags) {
        skb_frag_t *frag = &walk->frags[walk->fragi];
        skb_frag_t *tofrag = &shinfo->frags[shinfo->nr_frags];

        *tofrag = *frag;
        if (offset) {
            tofrag->offset += offset;
            tofrag->len -= offset;
            offset = 0;
        }
        __skb_frag_ref(tofrag);
        shinfo->nr_frags++;

        /* see if we are done */
        fraglen = tofrag->len;
        if (len < fraglen) {
            tofrag->len = len;
            skb->len += len;
            skb->data_len += len;
            return 0;
        }
        ...
    }

By this point __skb_frag_ref(tofrag) has run and shinfo->nr_frags has
been incremented, so frags have been attached, but the early return 0
bypasses the new SKBFL_SHARED_FRAG assignment.

The caller iptfs_pskb_add_frags() typically requests fewer bytes than
the current source frag holds, so this early-return path is the common
termination of the loop.  In that case the destination SKB still appears
to ESP as having privately owned frags, and the nested transport-mode
esp_input() no-COW path described in the commit message can still
decrypt in place over pages referenced by the outer IPTFS SKB.

Would it be more robust to set the flag immediately after
__skb_frag_ref(tofrag) / shinfo->nr_frags++, or duplicate the assignment
before the inner return 0, so every path that attaches a frag also
propagates SKBFL_SHARED_FRAG?

