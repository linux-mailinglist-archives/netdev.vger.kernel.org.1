Return-Path: <netdev+bounces-284916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COmINcNf+2kuaQMAu9opvQ
	(envelope-from <netdev+bounces-284916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:35:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 736724DD580
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D0E73025C55
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 15:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D8448C40D;
	Wed,  6 May 2026 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ec+PuHRY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F3948C3FB;
	Wed,  6 May 2026 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081245; cv=none; b=gcSFxNw/ISwqpjUM1Sta1b9W9V18U7+05VMYTs2mXWbNNOOj/8WmUUg0N9rE1+0YHBPla1qtUzqbzOuRyPxB3jJdYmcgX4+PovlA3czfMDWZEfMQx/hcJzYowQwRRBaOBRuKJKLiKxkCzrv93cuJYWZoMu3pw/4mA4TwuWBFuZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081245; c=relaxed/simple;
	bh=E/wBMWyg5ITF+73x7jx0/FTQEvjOe5VW+C9miyOx3Rg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=TJ2aDYLTUupyW1tIx2vWP1qrxdrSIJycpxlT9fO92IhOdph8uDji0OiuG+DpZcjU2XYZ/+C8MmQANe1e/LPrjvZQw4VlZ9wQKkvO4yz4wUhyvBQRtknp0J1tLcAo0kozOs2CBTOnLOuuQPKPchQrLwBN/KrSMhCo1DwEGgtccuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ec+PuHRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1C1C2BCB0;
	Wed,  6 May 2026 15:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778081245;
	bh=E/wBMWyg5ITF+73x7jx0/FTQEvjOe5VW+C9miyOx3Rg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Ec+PuHRY3GrZ6DkM4jGjD1tdPpxruRo4o98ea+IhgQC0GAQuw52IUbbat0oDyIPh4
	 urFYBPhF748DXnznr9I8y6uLC9w+Rz02wa82vyY6LsAkam+thfvolBQ3pd4Ov+Vfly
	 eHU15G/lGcYibmch7R5tOd8ilDwdHHZRUcmbAS6DFRSGTBY7tRQu6AGEgn3b89Zf6b
	 GvK6OLGcQ9lelE6tL3qiGj65fwGe0tFMFrdkI5+GHTelt1rYyDJWmYfKRoQKnDHABS
	 jmwr6Xs/rhIdC/QyJZrnPWJ8d7UxztODHg/MkExA6AbmdK5Y7bLlS3ThfN2P/V9iKE
	 /N5xbRRc2pvqQ==
Content-Type: multipart/mixed; boundary="===============3941001768256425371=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6083c00dc3cc6e72f6a4d0d2ad6632f0950bf12b5c09e873d614128db8758cd9@mail.kernel.org>
In-Reply-To: <20260506142709.2298255-3-ameryhung@gmail.com>
References: <20260506142709.2298255-3-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v4 02/12] bpf: Unify dynptr handling in the verifier
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@kernel.org,mykyta.yatsenko5@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  6 May 2026 15:27:25 +0000 (UTC)
X-Rspamd-Queue-Id: 736724DD580
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284916-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com,linux.dev];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

--===============3941001768256425371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 976e2b2f40e8..f330e9cf297e 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -1376,6 +1376,13 @@ struct bpf_map_desc {
>  	int uid;
>  };
>
> +/* The last initialized dynptr; Populated by process_dynptr_func() */
> +struct bpf_dynptr_desc {
> +	enum bpf_dynptr_type type;
> +	u32 id;
> +	u32 ref_obj_id;
> +};
> +

A review comment from Mykyta Yatsenko requested that a comment be added
to the ref_obj_id field explaining what it's for:

  https://lore.kernel.org/bpf/87ikb2tkta.fsf@gmail.com/

The author mentioned in v3 that comments for id, ref_obj_id, and parent_id
would be added in a later refactor patch. However, should this struct have
inline documentation now for clarity, particularly for the ref_obj_id field?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25442456702
--===============3941001768256425371==--

