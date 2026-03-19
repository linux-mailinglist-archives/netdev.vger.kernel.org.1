Return-Path: <netdev+bounces-269560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIVQHBIvvGnquAIAu9opvQ
	(envelope-from <netdev+bounces-269560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:14:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DB22CFA9C
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B700C334A4DA
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E433EF65F;
	Thu, 19 Mar 2026 16:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqyw1/zO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1613EE1C5;
	Thu, 19 Mar 2026 16:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939414; cv=none; b=YgyIldxTNXY/E+vKA+PSYT93510HssQ1Fty7lO+VC/c0gGynn39AbQjW/HDQ4VfVU4ypdO28+syuML9EQdhVaayIvTUGXYSMxmkN2JzWxE3clR6coIBtgm5lX/1zA/IUV7u19Pb8tLT4Zrq8yb4rtVK1f6IH/kJe5+bkE35cerk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939414; c=relaxed/simple;
	bh=oQ+Jh+vCTFs9cVLDvDiEzq/xMAEFTVzQ/NgiP3kT8A4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SwPFfQbH3zhOodYP7VcU355E0HpATeBVJEdnbw8PEGfFfZITbZF6qYc3lBZZfsgpsMYmqoxNorB/j9DNknxHcQoZa8VBR9SpdofaiHoQPJOSAVfXV8eSNMtbhyM89CS+KvC+rUb56ao92tkLGLhcnCQOEQj60AvqD5UKp3mT3f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqyw1/zO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1583C19424;
	Thu, 19 Mar 2026 16:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773939413;
	bh=oQ+Jh+vCTFs9cVLDvDiEzq/xMAEFTVzQ/NgiP3kT8A4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=cqyw1/zOzJTa/8Q7yDX+a6eNmUK176csXCEVCSg5AikQ+YSs6rlP1re+tc+mGOEpd
	 FSuPVDirjPJyTiZqfjBbLJ3lOn6TpqochRo/Q02ywDuIQEnVTzm75le1drHtq5b3eE
	 6pItstVO/nLELiULryOiTq/bSVLvsEX+puA5LlCXbRrF30rST5/+hJV3GlUNn2RIPB
	 AG7Nkvn8SjnlLUlgFNDXbUWZ2SCk8BQBsrNvttv9zLj3EnC5uAAoAvqfOx6hMAFyjn
	 AtUJhxooVtkp/PQiBu2v2zZRvEDWBr+WlfEl/7ihUjq5kik3qQ0pwrGd19sCreQEi4
	 WIQ2TSVYapbfQ==
Content-Type: multipart/mixed; boundary="===============8422952437576566334=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dfba37ee6cd5de8954bbc57d18af3e4865e35cdda8535d890ae6380e4a1cc0af@mail.kernel.org>
In-Reply-To: <20260319-vmscape-bhb-v7-7-b76a777a98af@linux.intel.com>
References: <20260319-vmscape-bhb-v7-7-b76a777a98af@linux.intel.com>
Subject: Re: [PATCH v7 07/10] x86/vmscape: Use static_call() for predictor flush
From: bot+bpf-ci@kernel.org
To: pawan.kumar.gupta@linux.intel.com,x86@kernel.org,nik.borisov@suse.com,hpa@zytor.com,jpoimboe@kernel.org,david.kaplan@amd.com,seanjc@google.com,bp@alien8.de,dave.hansen@linux.intel.com,peterz@infradead.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,kpsingh@kernel.org,jolsa@kernel.org,davem@davemloft.net,david.laight.linux@gmail.com,luto@kernel.org,tglx@kernel.org,mingo@redhat.com,dsahern@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,haoluo@google.com,pbonzini@redhat.com,corbet@lwn.net
Cc: linux-kernel@vger.kernel.org,kvm@vger.kernel.org,asit.k.mallick@intel.com,tao1.zhang@intel.com,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-doc@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 19 Mar 2026 16:56:52 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269560-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,suse.com,zytor.com,amd.com,google.com,alien8.de,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[45];
	NEURAL_HAM(-0.00)[-0.982];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.kernel.org:mid]
X-Rspamd-Queue-Id: B4DB22CFA9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============8422952437576566334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 68e2df3e3bf58..b75eda114503a 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -144,6 +144,17 @@ EXPORT_SYMBOL_GPL(cpu_buf_idle_clear);
>   */
>  DEFINE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
>
> +/*
> + * Controls CPU Fill buffer clear before VMenter. This is a subset of
> + * X86_FEATURE_CLEAR_CPU_BUF, and should only be enabled when KVM-only
> + * mitigation is required.
> + */
> +DEFINE_STATIC_KEY_FALSE(cpu_buf_vm_clear);
> +EXPORT_SYMBOL_GPL(cpu_buf_vm_clear);

cpu_buf_vm_clear is defined and exported here but appears to have no
users. There is no declaration in any header, and nothing in this
patch series references it.

The comment describes CPU fill buffer clearing before VMenter, which
seems unrelated to the predictor flush static_call conversion that
this patch is doing. Was this included by mistake, or is it intended
for a follow-up series?

> +
> +DEFINE_STATIC_CALL_NULL(vmscape_predictor_flush, write_ibpb);
> +EXPORT_STATIC_CALL_GPL(vmscape_predictor_flush);

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23303796353
--===============8422952437576566334==--

