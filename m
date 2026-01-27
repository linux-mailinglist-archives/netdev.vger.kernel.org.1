Return-Path: <netdev+bounces-253671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFF2F70ueGl7oQEAu9opvQ
	(envelope-from <netdev+bounces-253671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:19:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E048F7E9
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3067C30136BD
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3036D2D5C95;
	Tue, 27 Jan 2026 03:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFQYRZH3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C65E1D8DFB;
	Tue, 27 Jan 2026 03:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769483838; cv=none; b=VuGkEer9BChdzGI2TfvoYLWxs6YcpkXvo8LiBfXHnYayx6TmzIuO3ggaCWBfKZTQdqKJ599xHI3kgVktu+NLgaXJx5I9NVgnBh1pPbObfUYxbFa18L4VUpOPSNR/lVgsPYwW+C9cjG6ISj5P2P79aFDO7h5cxbvzczFX5fcFg+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769483838; c=relaxed/simple;
	bh=dnJcFhSRUQLJ1ApFWP2PZZv4CeRhdXayeV0WZw3iT70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgThKrr3x3cYRyfN4OFiNvBnkXxeBoWYse8SZ8EjNM9/32EgMg89iLlePStu6diHP4utSyIviqcc+ztVQ0XrThjuiErdJwIsnzamiQp+c5TVXqoVXKoVvS1nkCTZERZfDNoSPwyPnXMCz/6jX0Y6CI/x60UOmCREGaXGys5AUlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFQYRZH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49848C116C6;
	Tue, 27 Jan 2026 03:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769483837;
	bh=dnJcFhSRUQLJ1ApFWP2PZZv4CeRhdXayeV0WZw3iT70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dFQYRZH3KpdkqeQGFxLgHD78VoOv2zl7OKVLpQn1ANHrxxo+Ab9bVxcP/vFP9cTES
	 kbkOkI3GBCdrkTJe/9zwS5G4Dufii99CQ0ZX2osZm2OxyVZEyl5quhYjvGRXMxbOAN
	 Jl7IzV8mciBalcV5kJNU9MHKV72Miyvu4NR8fHru2f376Tivjso1SKIHYNJCZnN26o
	 FLNnoXqn1QAqAz3+hMlMkBudE5YkbZVTRzzqoMYbLmK+GGYvEOdwZuFrwp9CHeuk72
	 qadio22g7FH+fqprV83nbqz7ACeJZjEWKoauZNfHR+lyV36uM8WMz7LfPgXqSoK7hL
	 lj28jv0W1S1Wg==
From: Jakub Kicinski <kuba@kernel.org>
To: gakula@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [net-next] octeontx2-pf: cn10k/cn20k: Update count_eot in NPA_LF_AURA_BATCH_FREE0
Date: Mon, 26 Jan 2026 19:16:00 -0800
Message-ID: <20260127031600.3841572-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126073015.29333-1-gakula@marvell.com>
References: <20260126073015.29333-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253671-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url]
X-Rspamd-Queue-Id: B7E048F7E9
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-pf: cn10k/cn20k: Update count_eot in NPA_LF_AURA_BATCH_FREE0

This commit extends the count_eot calculation for CN20K devices where
the field is 2 bits wide, while maintaining CN10K compatibility where
only bit 0 is used.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index 8cdfc36d79d2..c6023e1ce92b 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> @@ -789,8 +789,15 @@ static inline void __cn10k_aura_freeptr(struct otx2_nic *pfvf, u64 aura,
>  	tar_addr = (__force u64)otx2_get_regaddr(pfvf, NPA_LF_AURA_BATCH_FREE0);
>  	/* LMTID is same as AURA Id */
>  	val = (lmt_info->lmt_id & 0x7FF) | BIT_ULL(63);
> -	/* Set if [127:64] of last 128bit word has a valid pointer */
> -	count_eot = (num_ptrs % 2) ? 0ULL : 1ULL;
> +	/* Meaning of count_eot
> +	 * CN10K: count_eot = 0 if the number of pointers to free is even,
> +	 *	  count_eot = 1 if the number of pointers to free is odd.
> +	 *
> +	 * CN20K: count_eot represents the least significant 2 bits of the
> +	 *	  total number of valid pointers to free.
> +	 *        Example: if 7 pointers are freed (0b111), count_eot = 0b11.
> +	 */
> +	count_eot = (num_ptrs - 1) & 0x3ULL;

The new count_eot formula looks correct for passing to hardware, but does
it break the size calculation further down in this function? The old code
produced count_eot values of only 0 or 1, while the new formula can produce
0, 1, 2, or 3.

Later in this same function there is:

    if (!count_eot)
        size++;

With the old formula, for num_ptrs=3 (2 buffers), count_eot was 0, so size
got incremented from 1 to 2, which is correct for 24 bytes needing 2
128-bit words.

With the new formula, for num_ptrs=3, count_eot becomes 2, which is truthy,
so size stays at 1. But 3 u64 values still require 2 128-bit words.

This appears to cause incorrect LMTST size for num_ptrs values of 3, 7, 11,
and 15, where the driver would tell hardware about fewer 128-bit words than
are actually present.

Should the size adjustment check be updated to something like:

    if (!(count_eot & 1))
        size++;

to preserve the original behavior of incrementing size when the buffer
count (num_ptrs - 1) is even?
-- 
pw-bot: cr

