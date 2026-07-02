Return-Path: <netdev+bounces-303903-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ShQPIBiqRWpoDgsAu9opvQ
	(envelope-from <netdev+bounces-303903-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 02:00:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 168276F283C
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 02:00:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QMT4kgVW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303903-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303903-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7641304D2AF
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 00:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7C13769E1;
	Thu,  2 Jul 2026 00:00:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D1C390C89;
	Thu,  2 Jul 2026 00:00:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782950419; cv=none; b=C86JTFLIz4JDnQj/ziEOnA7wLkCM+r9ZBCpSR51f34zVnczIC8E/EWj0m6L/vupv9Dao+SVCQvqn5b07+fYp9pc1I133FR6T6cipA7j2x+RqWI3RUaqmOQ8PT6wXQU4MFBzOexXV9mnOf1fsTT6AmMwN4HWkKJ5gCQls4GyFlCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782950419; c=relaxed/simple;
	bh=jqjbeFdIpVRXhFcW3JHkxpTxn2W1/ZUCXSwYSed7u3E=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XdgI/g9gQ39CucrxkJSlReLciunrrSvE3A0nf559YF+OEyje7lTSAx5nKtWOOaBtx7aV74pW2gRikT+qjQsBD767rzLKc1lkW9wCGvRhn+Zdqz4sOp3y6PlTAImcebkAaSAdeQcVxRELeaCnLcRDLqC5xI/kr+vOf1Tt/UtXISM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMT4kgVW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5DC1F00ACF;
	Thu,  2 Jul 2026 00:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782950418;
	bh=jqjbeFdIpVRXhFcW3JHkxpTxn2W1/ZUCXSwYSed7u3E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=QMT4kgVWFI7QkeYtoq9/QtdxTQy6Tq1TAnZHIL2FV1UXIHs9mMQmLu/6QoslqWFyZ
	 tR0QsRtp1v1Pz/uvQwEm35yQzZGF/d/FrXXH11OtuCoSFlVTyky0OtiaFA5UxfESHV
	 3W/UB0QBxqKJsVfQNwrTFkwKx72MsqmbAKDFNZ1mUSRsENGiQ2hRVZkP+7nTQ5S7VC
	 tprrtUY7X2qJnatmnTOhplRhUKrziu8PVGlej2FB8hVL7wWKBsX4PKTtCuO0BB/UcF
	 iB2PrRWhHlVFyz+d4iVA8fXdyiHjMhI1kCFGg+nzURDA1gHan8N+eQqIGkOGdlN85P
	 abQV2U+cDZxdw==
Content-Type: multipart/mixed; boundary="===============4278333573925749137=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <03d8ce102b71c68c30e98be36feaebe539055195c2323ec3b3fd84f157487afd@mail.kernel.org>
In-Reply-To: <20260702-sockmap-lookup-udp-leak-v3-3-ff8de8782468@rbox.co>
References: <20260702-sockmap-lookup-udp-leak-v3-3-ff8de8782468@rbox.co>
Subject: Re: [PATCH bpf v3 3/4] selftests/bpf: Adapt sockmap update error handling
From: bot+bpf-ci@kernel.org
To: mhal@rbox.co,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,john.fastabend@gmail.com,jakub@cloudflare.com,jiayuan.chen@linux.dev,edumazet@google.com,kuniyu@google.com,pabeni@redhat.com,willemb@google.com,davem@davemloft.net,kuba@kernel.org,horms@kernel.org,cong.wang@bytedance.com
Cc: mhal@rbox.co,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  2 Jul 2026 00:00:18 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.56 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-303903-lists,netdev=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[rbox.co,kernel.org,iogearbox.net,gmail.com,linux.dev,etsalapatis.com,cloudflare.com,google.com,redhat.com,davemloft.net,bytedance.com];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_RECIPIENTS(0.00)[m:mhal@rbox.co,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:edumazet@google.com,m:kuniyu@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:cong.wang@bytedance.com,m:bpf@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:martin.lau@kernel.org,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[rbox.co,vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 168276F283C

--===============4278333573925749137==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

PiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvc29j
a21hcF9saXN0ZW4uYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3Nv
Y2ttYXBfbGlzdGVuLmMKPiBpbmRleCBjYzBjNjhiYWI5MDcuLmI4NzExOGFhYjdjNCAxMDA2NDQK
PiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy9zb2NrbWFwX2xp
c3Rlbi5jCj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvc29j
a21hcF9saXN0ZW4uYwoKWyAuLi4gXQoKPiBAQCAtOTMsOCArOTAsMTIgQEAgc3RhdGljIHZvaWQg
dGVzdF9pbnNlcnRfYm91bmQoc3RydWN0IHRlc3Rfc29ja21hcF9saXN0ZW4gKnNrZWwgX19hbHdh
eXNfdW51c2VkLAo+ICAJZXJybm8gPSAwOwo+ICAJdmFsdWUgPSBzOwo+ICAJZXJyID0gYnBmX21h
cF91cGRhdGVfZWxlbShtYXBmZCwgJmtleSwgJnZhbHVlLCBCUEZfTk9FWElTVCk7Cj4gLQlpZiAo
IWVyciB8fCBlcnJubyAhPSBFT1BOT1RTVVBQKQo+IC0JCUZBSUxfRVJSTk8oIm1hcF91cGRhdGU6
IGV4cGVjdGVkIEVPUE5PVFNVUFAiKTsKPiArCWlmIChzb3R5cGUgPT0gU09DS19TVFJFQU0pIHsK
PiArCQlBU1NFUlRfRVJSKGVyciwgIm1hcF91cGRhdGUiKTsKPiArCQlBU1NFUlRfRVEoZXJybm8s
IEVPUE5PVFNVUFAsICJlcnJubyIpOwo+ICsJfSBlbHNlIGlmIChlcnIpIHsKPiArCQlBU1NFUlRf
T0soZXJyLCAibWFwX3VwZGF0ZSIpOwo+ICsJfQoKVGhpcyBpc24ndCBhIGJ1ZywgYnV0IGNvdWxk
IHRoZSBVRFAgYnJhbmNoIGp1c3QgYmUgYGVsc2UgQVNTRVJUX09LKGVyciwKIm1hcF91cGRhdGUi
KTtgIOKAlCB0aGUgYGlmIChlcnIpYCBndWFyZCBsb29rcyByZWR1bmRhbnQgc2luY2UgQVNTRVJU
X09LIGlzCmEgbm8tb3Agb24gc3VjY2Vzcz8KCj4gIGNsb3NlOgo+ICAJeGNsb3NlKHMpOwo+ICB9
CgpbIC4uLiBdCgoKLS0tCkFJIHJldmlld2VkIHlvdXIgcGF0Y2guIFBsZWFzZSBmaXggdGhlIGJ1
ZyBvciBlbWFpbCByZXBseSB3aHkgaXQncyBub3QgYSBidWcuClNlZTogaHR0cHM6Ly9naXRodWIu
Y29tL2tlcm5lbC1wYXRjaGVzL3ZtdGVzdC9ibG9iL21hc3Rlci9jaS9jbGF1ZGUvUkVBRE1FLm1k
CgpDSSBydW4gc3VtbWFyeTogaHR0cHM6Ly9naXRodWIuY29tL2tlcm5lbC1wYXRjaGVzL2JwZi9h
Y3Rpb25zL3J1bnMvMjg1NTQ5MTExOTI=

--===============4278333573925749137==--

