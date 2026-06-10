Return-Path: <netdev+bounces-297361-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qDDtLgKwKGrOIAMAu9opvQ
	(envelope-from <netdev+bounces-297361-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 02:29:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2427E664F5C
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 02:29:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gD4XRvPs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297361-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297361-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39684302E43B
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE36418E025;
	Wed, 10 Jun 2026 00:29:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA4D40D599;
	Wed, 10 Jun 2026 00:29:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781051374; cv=none; b=lwd+zONMLDiBdNhrpqNQBx10JORPadvXPBvbV7oOBaVioX/wvv8KRwRZRbPtOp6wyPzKDngM3K5HwN5uQSWKIE6NO509GYA9F48lPYVdNd90YnsqLuVaaAxAH3yeUOdUeALTdtuMNRl8w+xIbBdibpMZLUlyOJQwMcceZonZZIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781051374; c=relaxed/simple;
	bh=F+1/o+UqMcCM9HUTyV3DMTvgGNUaqEficLVv7JbzUms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQhyGeHOhN9oOFd29WIpMcn4kkUfSk1E7xoDmVH2UZa2R+38+BHCWX6P4ZLl57BaDwS+RJMJKVzCKTdIScVck8KUEXBI2TlaJAvMhe82G+FjvPaq06Ei18e/Kfaag7doNz+as0ppgdU6nzB00FASR9uXmnWEiiY9dypGLawzx64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gD4XRvPs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DD21F00893;
	Wed, 10 Jun 2026 00:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781051373;
	bh=wFTizx5+9kzGsZ2xx17/doYVD6tuBQ2hb8y5I9uZfDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gD4XRvPsaxH183b2Nd/QJ8moRzyNq655zlI1qb7iCIC7kkiGlDADdlg2QBkTFY08F
	 MV2AOx0syjgmAtnwUp9XTsiVm9cvMUaKlbJMmxx/Yg+ZhLihDmDlxu/FVPwtPitHQ3
	 2/wOnTAPnb2DsCqPpHzyTjAmSW9v4hHEu2NocT2VhMPttI3OoayEhy2uaMIt2/2B7Q
	 E+yp/iFQDT1QR70QXm7C9Gt9aEc6UKebdJhRvBLODHX10R2l50Tc3NNnOH9RZFM5zo
	 1Pto22py0xQSHibEUIWlcuCxylGwfS/oVOpcr24zp8xN8kVUE3lIob2kPTt3xlItVq
	 6exeRjtsEEFdA==
From: Jakub Kicinski <kuba@kernel.org>
To: rkannoth@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	naveenm@marvell.com,
	netdev@vger.kernel.org,
	sbhatta@marvell.com,
	sgoutham@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net] octeontx2-af: npc: Fix size of entry2cntr_map
Date: Tue,  9 Jun 2026 17:29:22 -0700
Message-ID: <20260610002921.1366276-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605055839.3549559-1-rkannoth@marvell.com>
References: <20260605055839.3549559-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297361-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rkannoth@marvell.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:naveenm@marvell.com,m:netdev@vger.kernel.org,m:sbhatta@marvell.com,m:sgoutham@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2427E664F5C

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
octeontx2-af: npc: Fix size of entry2cntr_map

octeontx2-af: Fix out of bound access in entry2counter array.
KASAN prints below splat. This is caused by allocating counter for
reserved mcam entry for cpt 2nd pass entry. But mcam->entry2cntr_map
is not allocated for reserved entries.

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> index d301a3f0f87a8..12f525b5df7bb 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> @@ -2181,7 +2181,7 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
>  	/* Alloc memory for MCAM entry to counter mapping and for tracking
>  	 * counter's reference count.
>  	 */
> -	mcam->entry2cntr_map = kcalloc(mcam->bmap_entries, sizeof(u16),
> +	mcam->entry2cntr_map = kcalloc(mcam->total_entries, sizeof(u16),
>  				       GFP_KERNEL);

[Severity: High]
Now that entry2cntr_map is allocated to total_entries to allow counters on
reserved entries, do the cleanup loops also need to be updated?

Looking at __npc_mcam_free_counter() and
rvu_mbox_handler_npc_mcam_unmap_counter(), they appear to only iterate up to
mcam->bmap_entries and search the unreserved bitmap:

__npc_mcam_free_counter() {
        ...
        while (entry < mcam->bmap_entries) {
                if (!mcam->cntr_refcnt[req->cntr])
                        break;
                index = find_next_bit(mcam->bmap, mcam->bmap_entries, entry);
        ...
}

Does this skip unmapping counters that are attached to reserved MCAM entries?

If so, could the hardware STAT_ACT register remain active and leak the
counter's reference count, causing cross-tenant statistics corruption when
the counter is later reallocated?

>  	if (!mcam->entry2cntr_map)
>  		goto free_cntr_map;

-- 
pw-bot: cr

