Return-Path: <netdev+bounces-271254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACdyIOXhwmmPnAQAu9opvQ
	(envelope-from <netdev+bounces-271254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:11:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E51E931B435
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90817306B3A5
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3159E3A6EF6;
	Tue, 24 Mar 2026 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJoQNi48"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED013B6BF3;
	Tue, 24 Mar 2026 19:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379373; cv=none; b=ZfwkkzRGJ0eBhj8sAARoUHi8bcOioQHiRMCHi5NNZLHZaLcIO8dxR2n9UwZDVV6W+8EETyDVlL/8uP6lIIDlL1ZY8GFns5jHYmSy2nVuRjiIE+QrieLPf85wtGpg/QdMeD0Oe37brWzqvdPC7B6F3RHDKCQcwIGM48/4D35B0uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379373; c=relaxed/simple;
	bh=xOEwiz0qRG3DaZGsPLHHyoPEIJexNoCMzyHC38ks2uk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ua/kjPXy4Xl8oWT6iL5febjXYrJuaByrDYGrTLjo/Kfg+9v6m58xRDY0Q0Nqty3ySarMD9tL9LXUKyHRfo5VJAM9AnbzY1trVEYyGRMjhpOwwVNSdBFY6gyQwLpRKt/A8LaaOzHiF+viRKqACOci5uLqhWkThgfgV5eOWrlulxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJoQNi48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4DEC19424;
	Tue, 24 Mar 2026 19:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774379372;
	bh=xOEwiz0qRG3DaZGsPLHHyoPEIJexNoCMzyHC38ks2uk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=FJoQNi48GOmo9oKCJnQBVvAQgwqVK0RL6kXZbpgxpHvgDufEYg2V6RZqxv81C6mtz
	 GgHxp8rHJouaF8jfdinFelm181DcNisWg6S46aOxtRo+Ul11EuLxGsA31S99iJvXS2
	 0wBtCB3D99XhqMmw35JboK86iaIuOGlQ/d07p97aF2f9AuDR8xzrD/pBhGyODmmeEF
	 VJ0lkPNjq7CXIT4t3GWcWxxH5OLt1IQgsn04iXLboTvO2Oih1YMHBQ1XiqKM5Pz5EV
	 hwFOhlepNHNOm/mSmYVcNu82nWkFz7U+RasX82AWU0FEfAXQ7zdAUStvd047o1XLvg
	 p5m3T5JuLIYrQ==
Content-Type: multipart/mixed; boundary="===============6618981801720707195=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <901294cad0355c079f343400e594daf91c8c07f0ad0ef41064c746d96e8907bd@mail.kernel.org>
In-Reply-To: <20260324-vmscape-bhb-v8-7-68bb524b3ab9@linux.intel.com>
References: <20260324-vmscape-bhb-v8-7-68bb524b3ab9@linux.intel.com>
Subject: Re: [PATCH v8 07/10] x86/vmscape: Use static_call() for predictor flush
From: bot+bpf-ci@kernel.org
To: pawan.kumar.gupta@linux.intel.com,x86@kernel.org,jon@nutanix.com,nik.borisov@suse.com,hpa@zytor.com,jpoimboe@kernel.org,david.kaplan@amd.com,seanjc@google.com,bp@alien8.de,dave.hansen@linux.intel.com,peterz@infradead.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,kpsingh@kernel.org,jolsa@kernel.org,davem@davemloft.net,david.laight.linux@gmail.com,luto@kernel.org,tglx@kernel.org,mingo@redhat.com,dsahern@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,haoluo@google.com,pbonzini@redhat.com,corbet@lwn.net
Cc: linux-kernel@vger.kernel.org,kvm@vger.kernel.org,asit.k.mallick@intel.com,tao1.zhang@intel.com,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-doc@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 24 Mar 2026 19:09:31 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271254-lists,netdev=lfdr.de,bpf-ci];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.kernel.org:mid]
X-Rspamd-Queue-Id: E51E931B435
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============6618981801720707195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index dbe104df339b8..b4d529dd6d305 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -503,7 +503,7 @@
>  #define X86_FEATURE_CLEAR_CPU_BUF_VM	(21*32+13) /* Clear CPU buffers using VERW before VMRUN */
> -#define X86_FEATURE_IBPB_EXIT_TO_USER	(21*32+14) /* Use IBPB on exit-to-userspace, see VMSCAPE bug */
> +/* Free */
>  #define X86_FEATURE_ABMC		(21*32+15) /* Assignable Bandwidth Monitoring Counters */

Should the corresponding entry in
tools/arch/x86/include/asm/cpufeatures.h also be updated to match?
It still has:

#define X86_FEATURE_IBPB_EXIT_TO_USER	(21*32+14)

tools/perf/check-headers.sh checks this file for sync with the main
header.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23506000396
--===============6618981801720707195==--

