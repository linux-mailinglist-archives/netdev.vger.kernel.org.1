Return-Path: <netdev+bounces-301456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6tLlOgnNOmpQHQgAu9opvQ
	(envelope-from <netdev+bounces-301456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:14:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9386B9633
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:14:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nkFCth7c;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301456-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301456-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 43EA53004D8C
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 18:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4083397331;
	Tue, 23 Jun 2026 18:13:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BBA395ADE;
	Tue, 23 Jun 2026 18:13:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782238419; cv=none; b=sfuWdVBIlhqje4FQLcDFJgEEXj36mfmVM5JLBxYnefOKlkFfJf4xx2keviRzZG5HNQdUEbzb23BOC9r99WM5x9SMtmSQjBGU7dsZ02manwCkwPCN8iG9lthiIpvf+oKoP+fx9A68j2UDxX03vYuISKSkMYV0Hhyy/R6XPbgGHt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782238419; c=relaxed/simple;
	bh=2BYU39LdGXzbenZgXp/y0l1HaIUy+XRfN9J4cOzJJkE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=eBBnn2tWgF0clIqEPfSGwbO2HLoClF6Fd5OdsEN8a0zBWD4HjyDYytXeHSHCJ7383XRjxdRaK+E4QcbK+ovK8yUSbpLUAfsIUcI+YmExpnFmJOiHjp3m7oVpOaxI8kYOS/Q6e8Y1uGYXH6Cnd5VvnSWbN9QEOS+xR4dKArRje6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkFCth7c; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89721F000E9;
	Tue, 23 Jun 2026 18:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782238418;
	bh=2BYU39LdGXzbenZgXp/y0l1HaIUy+XRfN9J4cOzJJkE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nkFCth7c+aqnmLnj6u5OA9T3Id184hzHteyLNSWFRBKEIWEKnwVgWEwMAyKSM4RJN
	 m9IBYIdceGQzEp0fNWx0P9jeGEo6TGxg10J8u62ecb42m0B04ira5BPdT/3ArP9/kA
	 UUhctaugfEF75meeM+dgSxb5Fus1xB9vQ/XezZVnRMC7jhTchenf8IEofcHVL7+tZS
	 g97EscZHJoUAInlBm7h3X5fwRSZ9MTbnQyNrgW1Ur6RTnZQzLUB0l0ewAO3AktuUr/
	 wP8jwpbGZ+GkhBg73OgTyk2+FJuFj7G2SX6RWO4P7NG9ee99kzRnQDDI6dU2UzvidD
	 PUCQZki7i+w7Q==
Content-Type: multipart/mixed; boundary="===============1340697840049190165=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a3c35deadc171002028e32736cb695c35656e9adaa353bd6268316f66a5f7bec@mail.kernel.org>
In-Reply-To: <20260622-vmscape-bhb-v12-11-76cbda0ae3e5@linux.intel.com>
References: <20260622-vmscape-bhb-v12-11-76cbda0ae3e5@linux.intel.com>
Subject: Re: [PATCH v12 11/12] x86/vmscape: Resolve conflict between attack-vectors and vmscape=force
From: bot+bpf-ci@kernel.org
To: pawan.kumar.gupta@linux.intel.com,x86@kernel.org,jon@nutanix.com,nik.borisov@suse.com,hpa@zytor.com,jpoimboe@kernel.org,david.kaplan@amd.com,seanjc@google.com,bp@alien8.de,dave.hansen@linux.intel.com,peterz@infradead.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,kpsingh@kernel.org,jolsa@kernel.org,davem@davemloft.net,david.laight.linux@gmail.com,luto@kernel.org,tglx@kernel.org,mingo@redhat.com,dsahern@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,haoluo@google.com,pbonzini@redhat.com,corbet@lwn.net,jbaron@akamai.com,aliceryhl@google.com,rostedt@goodmis.org,ardb@kernel.org,skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,kvm@vger.kernel.org,asit.k.mallick@intel.com,tao1.zhang@intel.com,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-doc@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 23 Jun 2026 18:13:37 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301456-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,akamai.com,goodmis.org,linuxfoundation.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pawan.kumar.gupta@linux.intel.com,m:x86@kernel.org,m:jon@nutanix.com,m:nik.borisov@suse.com,m:hpa@zytor.com,m:jpoimboe@kernel.org,m:david.kaplan@amd.com,m:seanjc@google.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:peterz@infradead.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:kpsingh@kernel.org,m:jolsa@kernel.org,m:davem@davemloft.net,m:david.laight.linux@gmail.com,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:dsahern@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:haoluo@google.com,m:pbonzini@redhat.com,m:corbet@lwn.net,m:jbaron@akamai.com,m:aliceryhl@google.com,m:rostedt@goodmis.org,m:ardb@kernel.org,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:asit.k.mallick@intel.com,m:tao1.zhang@intel.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:martin.lau@kernel.o
 rg,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:davidlaightlinux@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	RCPT_COUNT_GT_50(0.00)[51];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,vger.kernel.org:from_smtp,intel.com:email,nutanix.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA9386B9633

--===============1340697840049190165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> x86/vmscape: Resolve conflict between attack-vectors and vmscape=force
>
> vmscape=force option currently defaults to AUTO mitigation. This lets
> attack-vector controls to override the vmscape mitigation. Preventing the
> user from being able to force VMSCAPE mitigation.
>
> When vmscape mitigation is forced, allow it be deployed irrespective of
> attack vectors. Introduce VMSCAPE_MITIGATION_ON that wins over
> attack-vector controls.
>
> Tested-by: Jon Kohler <jon@nutanix.com>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

This appears to fix a behavioral bug where vmscape=force mapped to
VMSCAPE_MITIGATION_AUTO, which is gated by should_mitigate_vuln(), so
attack-vector controls could override a user-forced mitigation.

Should this carry a Fixes: tag?

The force -> VMSCAPE_MITIGATION_AUTO mapping that allowed the override
predates this series. The earlier refactor 68d94c61c09a ("x86/vmscape:
Move mitigation selection to a switch()") only moved the logic into a
switch() and did not introduce the conflict, so it does not look like the
right Fixes: target. A precise commit to point at could not be confirmed
from this tree.

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28046221590
--===============1340697840049190165==--

