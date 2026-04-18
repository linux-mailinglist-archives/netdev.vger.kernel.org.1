Return-Path: <netdev+bounces-279518-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHoZMCyv42mOJwEAu9opvQ
	(envelope-from <netdev+bounces-279518-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 18:19:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D26042191B
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 18:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A1A1300F12B
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 16:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442C82F3C0E;
	Sat, 18 Apr 2026 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rjz+mFBF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDFC2F12AC;
	Sat, 18 Apr 2026 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776529194; cv=none; b=bPEThXJ/gTSYG87xvsdfXJU0UJGRZ1Qrb9JPWtnymWGZ3yv9oGhlho4fVZL5L7i/dnxg8nTGuRIdHtCu1wmcUaDmH2pOAhoLj439alk3IpeUEy3QAWCfZ6dxZmsQGijFRJYxRxKouvIseusCwbjaYXgf6kFLOn3jGS+JCgcm7Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776529194; c=relaxed/simple;
	bh=+npb7yycakVj5kROmx4vW2WQQc/lWqJspiCFNC1O7FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGL40Mph2D0HpDSouy0MvhEHurI7PBXDrDSIe4rBBrAIgF/nm56PwEXmByADnrs68hLGuxIxHx/rohqQmwkXewqJxcg1ReyN+CQYFC4cRV5desynKEbrHZ1IulDXOMAtwbRcN6NeFx09+XgXbUAFLH8PkE7HDraDAwDtQpST26E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rjz+mFBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DDDC19424;
	Sat, 18 Apr 2026 16:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776529193;
	bh=+npb7yycakVj5kROmx4vW2WQQc/lWqJspiCFNC1O7FY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rjz+mFBF9Xjb8n6cOLse9y0HDK3O3CcYzoaEkU50tJZu4bh30kum7rrGQTR4UWxmH
	 xX+lwl/v5UlUEs5xuKcST+EZNMjamLNboHT4LRZvAMvaHcachd264d09lL5bAxZ2qu
	 XYMFlvXHkqk3b9oTI7Yw4M7X8S/sYHXFVbUfgiPA9mVDpdHi0tX0B9xA1SBWJ4JW94
	 g0T0fsVOXFUnYvV2tQDEJaVUSNyUctYCJHgWoPouiKMnMtGNvQ8l31vRqfudtge12i
	 r1a2qhHPz8NyfU7hwYB5zNidfkQwYjSPnPCKPHRMS6mg+qW21sEFaiLhadvJcapG5V
	 HE+NegcFvT0hA==
From: Simon Horman <horms@kernel.org>
To: rkannoth@marvell.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sgoutham@marvell.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	dan.carpenter@linaro.org,
	error27@gmail.com
Subject: Re: [PATCH net 3/3] octeontx2-af: npc: cn20k: Return error when defrag rollback free fails
Date: Sat, 18 Apr 2026 17:18:20 +0100
Message-ID: <20260418161819.366980-2-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416035352.333808-4-rkannoth@marvell.com>
References: <20260416035352.333808-4-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,marvell.com,davemloft.net,google.com,redhat.com,lunn.ch,linaro.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-279518-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D26042191B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
octeontx2-af: npc: cn20k: Return error when defrag rollback free fails

This commit attempts to fix a bug where an error code wasn't returned
when a rollback failure occurred during partial allocation in
npc_defrag_alloc_free_slots(). It sets rc to -EFAULT if the
__npc_subbank_free() call fails.

Link: https://lore.kernel.org/netdev/adjNJEpILRZATB2N@stanley.mountain/

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> index 2fcd0ee2b1e10..df192729ac1d4 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> @@ -3541,6 +3541,7 @@ static int npc_defrag_alloc_free_slots(struct rvu *rvu,
>  			dev_err(rvu->dev,
>  				"%s: Error to free mcam idx=%u\n",
>  				__func__, save[i]);
> +			rc = -EFAULT;
>  			break;
>  		}
>  	}

While this ensures an error is returned if the rollback fails, does the
function still incorrectly return success when the rollback succeeds?

Earlier in the function, if the allocation cannot fulfill the requested slots,
the code jumps to the rollback loop:

	if (alloc_cnt1 + alloc_cnt2 != cnt) {
		...
		goto fail_free_alloc;
	}

Inside the fail_free_alloc loop, the rc variable is overwritten by the
subbank lookup:

fail_free_alloc:
	for (i = 0; i < alloc_cnt1 + alloc_cnt2; i++) {
		rc = npc_mcam_idx_2_subbank_idx(rvu, save[i], &sb, &sb_off);

If the subbank lookup and the subsequent __npc_subbank_free() succeed,
rc will be 0.

Since the loop finishes normally without hitting the newly added rc = -EFAULT
path, does the function end up returning 0 at the end of the fail_free_alloc
block?

Could this cause the caller to incorrectly assume that all slots were
successfully allocated, leading to operations on the freed or uninitialized
slots in the save array? Using a separate variable for the loop operations
or explicitly setting an error code like -ENOSPC before the goto might help
preserve the failure state.

