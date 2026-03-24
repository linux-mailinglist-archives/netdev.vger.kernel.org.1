Return-Path: <netdev+bounces-271253-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qC6UCMLhwmmPnAQAu9opvQ
	(envelope-from <netdev+bounces-271253-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:10:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D9131B417
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3693E3078FA0
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40843B38B5;
	Tue, 24 Mar 2026 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZ++px7B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0348E3B2FD9;
	Tue, 24 Mar 2026 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379371; cv=none; b=XrKiGGA98Uw0YPCOsNGJtMAcOiIZhSdtL/lauE6GHZA9ZKg7lViWlv1R5uVLnc8oNgt+nAM8J0RLPmGSkfJ8VPqOflq2gd1Oj1yWa4IreIawhP232py4nM6TWrVoLOPIRm64glsyS0p+cpETHbnaEBGj7DNGd9mzp1VS4l4E0Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379371; c=relaxed/simple;
	bh=cLvyemoKai7DTqe2H3sBJp82HfUQPEIuN1t/PEFDUqs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IaefGNDpxUN9munFumo78zVsaeuQPoNAwhQwUzWBaM3Dxqb7kHTpM/6SRWeHj/Ftt7yB/0Krj8aIJRrn15F7SPZBuE5BKhDHDpGucntgRYyvEbEFoFNhGY1ITdTHfqLM3JoWnhhfeOLOp7h2DGBdJadDC/yfVWOmOAEEoEnw844=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZ++px7B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62B5C2BCB7;
	Tue, 24 Mar 2026 19:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774379370;
	bh=cLvyemoKai7DTqe2H3sBJp82HfUQPEIuN1t/PEFDUqs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=FZ++px7BhBiiCpXKxydrJ8NGgV8kq5/IL5Aq7Oj2ZjMOrldJWmMMnzk06HAR6pJgu
	 OF3Iyq27KBFAk2botQsmkwJFqHVu85QGTOZtwdEkVDBZCXuFFPjFoh8ls8r31JWUqY
	 NIfAzaj1UsFzqpsp07vqOMA7QNmOQg10dY/O2BqoqZgVUzXdZNHBaLZhKWuno3dVTH
	 YnDskexGUVxjCTh2UGQ6WaBbcV+N2lGPQK4chbeIeSujWJg2TtUr/+XxC7scWxXV0l
	 vdtwbTQr2Q/7btVhU5V+CK4mbNnzWRcOk2wt//LDXkIQ8pY9UeKBmiarC/oJcJn8r1
	 UWmoztiU1bMnA==
Content-Type: multipart/mixed; boundary="===============5100326488123237701=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <458ec30c147d396db9a3f7a4be989d538ba8d9256b3df20cea088ade38d98cbc@mail.kernel.org>
In-Reply-To: <20260324-vmscape-bhb-v8-10-68bb524b3ab9@linux.intel.com>
References: <20260324-vmscape-bhb-v8-10-68bb524b3ab9@linux.intel.com>
Subject: Re: [PATCH v8 10/10] x86/vmscape: Add cmdline vmscape=on to override attack vector controls
From: bot+bpf-ci@kernel.org
To: pawan.kumar.gupta@linux.intel.com,x86@kernel.org,jon@nutanix.com,nik.borisov@suse.com,hpa@zytor.com,jpoimboe@kernel.org,david.kaplan@amd.com,seanjc@google.com,bp@alien8.de,dave.hansen@linux.intel.com,peterz@infradead.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,kpsingh@kernel.org,jolsa@kernel.org,davem@davemloft.net,david.laight.linux@gmail.com,luto@kernel.org,tglx@kernel.org,mingo@redhat.com,dsahern@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,haoluo@google.com,pbonzini@redhat.com,corbet@lwn.net
Cc: linux-kernel@vger.kernel.org,kvm@vger.kernel.org,asit.k.mallick@intel.com,tao1.zhang@intel.com,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-doc@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 24 Mar 2026 19:09:29 +0000 (UTC)
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
	TAGGED_FROM(0.00)[bounces-271253-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[46];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 93D9131B417
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============5100326488123237701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/Documentation/admin-guide/hw-vuln/vmscape.rst b/Documentation/admin-guide/hw-vuln/vmscape.rst
> --- a/Documentation/admin-guide/hw-vuln/vmscape.rst
> +++ b/Documentation/admin-guide/hw-vuln/vmscape.rst
> @@ -117,3 +117,7 @@
>
>     Choose the mitigation based on the VMSCAPE variant the CPU is affected by.
>     (default when CONFIG_MITIGATION_VMSCAPE=y)
> +
> + * ``vmscape=on``:
> +
> +   Same as `auto`, except that it overrides attack vector controls.

Should `auto` use double backticks here (``auto``) to match the rest of
the file? All other inline code references in this document use RST
literal markup with double backticks.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23506000396
--===============5100326488123237701==--

