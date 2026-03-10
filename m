Return-Path: <netdev+bounces-265922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CbMLRnVr2kfcgIAu9opvQ
	(envelope-from <netdev+bounces-265922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:23:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC842473F0
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92DA03011141
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4503EFD02;
	Tue, 10 Mar 2026 08:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="BtEF451r"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725C43EDACC;
	Tue, 10 Mar 2026 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773131030; cv=none; b=Z9+MRKOVgmMRgien6as1837FIFo9AxmuFTuR2ax5/MVB7CdHEAH7HUUTdGXDHYBQr5WduqPmqMTGxpdSWYg7WnzdEDi1NXAbA3pH3gk+pqTfMGygF4cLq8SwbNP+IHb1KII3Yi2FcFNPTB8FZ4e482qEL/0OxurWd8BVzfoqD/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773131030; c=relaxed/simple;
	bh=68kmuTh1HUb9TfiYx1TGrOBMDqAWf8mVxCXZzMB8E5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HcF7MEkS8Hl9nHxa1wjs/2DN4RYpCrRzJ82ZsF5e89npZC6EQzLLMEVYJe2t1M5L1BOlM7vlbVp85AfWutMJ/4mqtJkP8blArwyZytH+6VqGcxDPdvqN1HficD4hOS6VX844jOxwNBj6+xxx/CfnjwPApKl6KXA0KRqnufahmfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=BtEF451r; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=He/ofyBIwtIerpJYZrP3hEc9kU38bgNzXPwSzkc0hKo=; b=BtEF451rSJECerD/TlPgG2R59F
	m99+kDKKAHD4V0puWgqZAFPNDTFEZfPy2IqgabW35/4abbG9PgxC9rxGgIncM5yQYQyGdwiY8Hhwi
	Ncofn38pX2Jkp3047AkvDcbT536/yy8d38iwSE3BpbVxWyhH+wZKvgtNJZtsNQcMorzIw1/ChwCB2
	XUaMSVAKI8fO5lmMzdbo1Rbw+2JrgMsKGI36LuQH185+eALacANRdrTOf10M5KzA76Cg4gTD6vkw5
	Ufzira53ROVtALGciq5cVqr7j6eaWyTDbE2paL540OwOj1ujAlKCUk5QLr9LjpHjDIhYUqYHFvHVP
	P/d6ToBA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vzsNN-0001hg-02;
	Tue, 10 Mar 2026 09:23:37 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1vzsNL-000OJd-39;
	Tue, 10 Mar 2026 09:23:36 +0100
Message-ID: <9516c64a-56ce-41f4-8f28-46099895a6b2@iogearbox.net>
Date: Tue, 10 Mar 2026 09:23:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v4] bpf: fix constant blinding bypass for PROBE_MEM32
 stores
To: Sachin Kumar <xcyfun@protonmail.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc: "ast@kernel.org" <ast@kernel.org>, "andrii@kernel.org"
 <andrii@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "jolsa@kernel.org" <jolsa@kernel.org>, "haoluo@google.com"
 <haoluo@google.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "martin.lau@linux.dev" <martin.lau@linux.dev>,
 "song@kernel.org" <song@kernel.org>,
 "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
 "eddyz87@gmail.com" <eddyz87@gmail.com>, "sdf@fomichev.me"
 <sdf@fomichev.me>, "puranjay@kernel.org" <puranjay@kernel.org>,
 "emil@etsalapatis.com" <emil@etsalapatis.com>
References: <Y6IT5VvNRchPBLI5D7JZHBzZrU9rb0ycRJPJzJSXGj7kJlX8RJwZFSM2YZjcDxoQKABkxt1T8Os2gi23PYyFuQe6KkZGWVyfz8K5afdy9ak=@protonmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <Y6IT5VvNRchPBLI5D7JZHBzZrU9rb0ycRJPJzJSXGj7kJlX8RJwZFSM2YZjcDxoQKABkxt1T8Os2gi23PYyFuQe6KkZGWVyfz8K5afdy9ak=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27936/Tue Mar 10 07:24:39 2026)
X-Rspamd-Queue-Id: 5AC842473F0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-265922-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[protonmail.com,vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,google.com,gmail.com,linux.dev,fomichev.me,etsalapatis.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,iogearbox.net:dkim,iogearbox.net:email,iogearbox.net:mid,protonmail.com:email]
X-Rspamd-Action: no action

On 3/9/26 7:25 PM, Sachin Kumar wrote:
> BPF_ST | BPF_PROBE_MEM32 immediate stores are not handled by
> bpf_jit_blind_insn(), allowing user-controlled 32-bit immediates to
> survive unblinded into JIT-compiled native code when bpf_jit_harden >= 1.
> 
> The root cause is that convert_ctx_accesses() rewrites BPF_ST|BPF_MEM
> to BPF_ST|BPF_PROBE_MEM32 for arena pointer stores during verification,
> before bpf_jit_blind_constants() runs during JIT compilation. The
> blinding switch only matches BPF_ST|BPF_MEM (mode 0x60), not
> BPF_ST|BPF_PROBE_MEM32 (mode 0xa0). The instruction falls through
> unblinded.
> 
> Add BPF_ST|BPF_PROBE_MEM32 cases to bpf_jit_blind_insn() alongside the
> existing BPF_ST|BPF_MEM cases. The blinding transformation is identical:
> load the blinded immediate into BPF_REG_AX via mov+xor, then convert
> the immediate store to a register store (BPF_STX).
> 
> The rewritten STX instruction must preserve the BPF_PROBE_MEM32 mode so
> the architecture JIT emits the correct arena addressing (R12-based on
> x86-64). Cannot use the BPF_STX_MEM() macro here because it hardcodes
> BPF_MEM mode; construct the instruction directly instead.
> 
> Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the verifier.")
> Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Sachin Kumar <xcyfun@protonmail.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>

