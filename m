Return-Path: <netdev+bounces-295449-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OU74Kvf/IWrKRQEAu9opvQ
	(envelope-from <netdev+bounces-295449-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:45:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F4051643D6D
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:45:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WGNilSBX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295449-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295449-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E2A5300B061
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 22:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D67377563;
	Thu,  4 Jun 2026 22:43:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1763C30D41B;
	Thu,  4 Jun 2026 22:43:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780612985; cv=none; b=liE/9d1BEsIPGv+SXRxc55MlI2nLii5L9YV9/ybC/eFya9r6+LeCAuAIDQCQmPYCxgq0XJFk3FwrVidNmPfSKKZ9UirfZF69utEVmnCIG1NB0j+9joMnGZxDacP8BnONx1Dpz1stx3bOj9mZ5MIw4chzEB3g9Th9y3+W4wrlT08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780612985; c=relaxed/simple;
	bh=Db9wdRPKjPE7855xf63DHIL7X8Ugh1m9xnvsEd91SAo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FMIUxyS4SkvMm3SwlYhT8sXIzpJmHSAjhR3BZDVs90e/iE5Yak5Ar2X61HQ0lUPx84G1FLzcbfGeJR14fErzTqEjGSTJEdzAs9kc5ZhZb0IRGIXBSDeePpIY/9Di+OFVjdnG47VUR56qdtk+xsjXLLsIEVrcnjajzfBvOSWQmIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGNilSBX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BFC1F00898;
	Thu,  4 Jun 2026 22:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780612983;
	bh=cTUbeG2FpWCVx39wt4Fgk9em3WS6NstBKWxgz1/mblo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=WGNilSBX0//qGFxf10UGO/A1LYr0XeBdcrpeOHM45WlkQBz438NuJxls+yiasUNkN
	 gBQJhFJnnKbU2cA5Nz7wiDFzQL7UwT6a+W+TK2Aors5xYOc2KmaTPMJDlsLKiivbZB
	 joxZKFzvj9lNe4pbJqlaBZ1k/4T/p5QV/z+uOa3VO+VFlFicYxGBCK4s9VDJm3ZnfO
	 JcDj2SLTGwTfxZ9Eg1uT6toe760u0eOG6QNxYY+jqgtcvH9Ti3fIXFrdcXlzRafRoL
	 +zk8BvuPc88t4fNDv95xLFzLy0U3n/5uTY2FUqDIly9gR1bEx2eTKja/8//0eNUeOF
	 0FNsC1zB/cslw==
Content-Type: multipart/mixed; boundary="===============0256608978134634985=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <415a2c450e8270973620a79c0a25fe0227ef595a9aa3c0950904db67c4c81acf@mail.kernel.org>
In-Reply-To: <20260604220904.1032145-2-ameryhung@gmail.com>
References: <20260604220904.1032145-2-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Fix dead error check on acquire_reference() in check_kfunc_call
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@kernel.org,mykyta.yatsenko5@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  4 Jun 2026 22:43:03 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295449-lists,netdev=lfdr.de,bpf-ci];
	FORGED_RECIPIENTS(0.00)[m:ameryhung@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:mykyta.yatsenko5@gmail.com,m:kernel-team@meta.com,m:ast@kernel.org,m:yonghong.song@linux.dev,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:alexeistarovoitov@gmail.com,m:mykytayatsenko5@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F4051643D6D

--===============0256608978134634985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     bpf: Fix dead error check on acquire_reference() in check_kfunc_call
>
>     acquire_reference() returns a signed int that may be a negative errno
>     but was converted to unsigned, which makes the subsequent error check
>     deadcode. Fix it by declaring 'id' as int so the error path is taken
>     correctly.
>
>     Signed-off-by: Amery Hung <ameryhung@gmail.com>

This looks like a bug fix, but it does not carry a Fixes: tag.  The dead
error check appears to have been introduced when check_kfunc_call() began
using the function-scoped 'u32 i, nargs, ptr_type_id, id;' declaration in
place of the earlier block-local 'int id'.

Should this include:

  Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking and fix dynptr UAF bug")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26983135146
--===============0256608978134634985==--

