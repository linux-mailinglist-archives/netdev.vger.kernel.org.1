Return-Path: <netdev+bounces-290720-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sM6GHYUSEGryTAYAu9opvQ
	(envelope-from <netdev+bounces-290720-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 10:23:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D085B07C6
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 10:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12A78301B021
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 08:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199E93A6B83;
	Fri, 22 May 2026 08:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKVXbQH1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB7E3A783D;
	Fri, 22 May 2026 08:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779438144; cv=none; b=GxW2CJ7wJYBd763MFRupmsFDeERqEicrco67N2gkvXR6MKK/6VQfxwIjUjVDetyF/JX6a2xdBm0B8XMgIp1ymUBg/d7523uK0pc3bAz+iSRbYedX5wgwVb02lUUBMbMHAcaV2TdJ/2dRntvI++F4zbuuR0+U9BSGYSdfKn5szfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779438144; c=relaxed/simple;
	bh=YNMgYaWmuKhZktoTfR8VA5YeAlNIBLuoSvjsQJbcAEY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LK4OAF2TWT9VQQ+iPhoeXHOC4uQe+YklVDdh2elePCHFajR0uyt3ndI9m5ONlQhWyrbgfuDQfhjInWIko4jFZLzggZZsk5egkFR2nnLt6lZM/6BPHOcGGPM6tb8rYMHDDPB1aosdjKsJXWQAMrLXw2nOhymcbCbhUpFAnKVMxpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKVXbQH1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1671F00A3D;
	Fri, 22 May 2026 08:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779438143;
	bh=YNMgYaWmuKhZktoTfR8VA5YeAlNIBLuoSvjsQJbcAEY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BKVXbQH1qXCtOFy7SpntmxQSwJoWTlhJRo6RB78aCe3fr9OXEnsMEBuuTA557cW7I
	 X2LsT49stZynNrvVU1gghJcZ9ZbinsUDcEtQw11p01pOdD4LF1qU/JtbddS1FU/2sI
	 RoVoEn7C4aU7wETZITdvO/q7OLRjhLwJvgiZvNh+D89xOShzQZir4Hzss0FtiMEHiw
	 HGN0l/d3hJnwkqNn/2XidLVSIdlbac8auwEzV1W+iojXjaED608X86ZTb5kyq8ErFG
	 LzQ4M2hEC1lK5GCBBCeeX1NwQRfmRo0nO9D+r0L25fcFFSwsVE0czu8brtkwnLQm2/
	 Fhl85SUPSXNuA==
Content-Type: multipart/mixed; boundary="===============2178938720958764145=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b5c171e50d47d65d8bd9edc67d002f02f9843a5ab2677183f57756ff25c8a2f3@mail.kernel.org>
In-Reply-To: <20260522074601.1658705-6-kuniyu@google.com>
References: <20260522074601.1658705-6-kuniyu@google.com>
Subject: Re: [PATCH v2 bpf-next 05/11] bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
From: bot+bpf-ci@kernel.org
To: kuniyu@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com
Cc: yonghong.song@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,edumazet@google.com,ncardwell@google.com,willemb@google.com,ukyab@berkeley.edu,kuniyu@google.com,kuni1840@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 22 May 2026 08:22:23 +0000 (UTC)
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290720-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org,kernel.org,iogearbox.net,meta.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,kernel.org,iogearbox.net,linux.dev,gmail.com];
	MIME_TRACE(0.00)[0:+,1:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	NEURAL_HAM(-0.00)[-0.965];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.kernel.org:mid]
X-Rspamd-Queue-Id: 75D085B07C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============2178938720958764145==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

PiBkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvZmlsdGVyLmMgYi9uZXQvY29yZS9maWx0ZXIuYwo+IGlu
ZGV4IGZhOGE3YzdkODZlYi4uMzYwODAzNjYzMmE4IDEwMDY0NAo+IC0tLSBhL25ldC9jb3JlL2Zp
bHRlci5jCj4gKysrIGIvbmV0L2NvcmUvZmlsdGVyLmMKPiBAQCAtMTIzODgsNiArMTIzODgsMjIg
QEAgX19icGZfa2Z1bmMgaW50IGJwZl9za19hc3NpZ25fdGNwX3JlcXNrKHN0cnVjdCBfX3NrX2J1
ZmYgKnMsIHN0cnVjdCBzb2NrICpzaywKPiAgI2VuZGlmCj4gIH0KPgo+ICtfX2JwZl9rZnVuYyBp
bnQgYnBmX3NvY2tfb3BzX3RjcF9zZXRfcmN2bG93YXQoc3RydWN0IGJwZl9zb2NrX29wc19rZXJu
ICpza29wcywKPiArCQkJCQkgICAgICBpbnQgcmN2bG93YXQpCj4gK3sKPiArI2lmZGVmIENPTkZJ
R19JTkVUCj4gKwlpZiAoc2tvcHMtPm9wICE9IEJQRl9TT0NLX09QU19SQ1ZRX0NCKQo+ICsJCXJl
dHVybiAtRU9QTk9UU1VQUDsKPiArCj4gKwlpZiAocmN2bG93YXQgPCAwKQo+ICsJCXJjdmxvd2F0
ID0gSU5UX01BWDsKPiArCj4gKwlyZXR1cm4gX190Y3Bfc2V0X3Jjdmxvd2F0KHNrb3BzLT5zaywg
cmN2bG93YXQsICFza29wcy0+c2tiKTsKCkNvdWxkIHRoaXMgcmVwcm9kdWNlIHRoZSBNUFRDUCBz
dWJmbG93IGlzc3VlIGZyb20gY29tbWl0IGZjZjQ2OTJmYTM5ZQooIm1wdGNwOiBwcmV2ZW50IEJQ
RiBhY2Nlc3NpbmcgbG93YXQgZnJvbSBhIHN1YmZsb3cgc29ja2V0LiIpPwoKSW4gdGhlIHYxIHJl
dmlldywgQmrDtnJuIFTDtnBlbCBhc2tlZCB3aGV0aGVyIEJQRiBwcm9ncmFtcyBjb3VsZCBjYWxs
IHRoaXMKa2Z1bmMgb24gTVBUQ1Agc3ViZmxvdyBzb2NrZXRzLiBUaGUgcmVzcG9uc2Ugd2FzICJJ
J2xsIHJhdGhlciBkcm9wIHN1cHBvcnQKZm9yIE1QVENQIGZvciBub3csIiBidXQgdGhlcmUncyBu
byBjaGVjayBoZXJlIHRvIHByZXZlbnQgdGhpcyBrZnVuYyBmcm9tCmJlaW5nIGNhbGxlZCBvbiBN
UFRDUCBzdWJmbG93cy4KCldpdGhvdXQgYSBjaGVjayBsaWtlOgoKICAgIGlmIChza19pc19tcHRj
cChza29wcy0+c2spKQogICAgICAgIHJldHVybiAtRU9QTk9UU1VQUDsKCm9yIGEgcHJvdG9jb2wg
Y2hlY2ssIHRoaXMgY29kZSBjb3VsZCB0cmlnZ2VyIHRoZSBzYW1lIHdhcm5pbmcgdGhhdApmY2Y0
NjkyZmEzOWUgd2FzIGRlc2lnbmVkIHRvIHByZXZlbnQuCgo+ICsjZWxzZQo+ICsJcmV0dXJuIC1F
T1BOT1RTVVBQOwo+ICsjZW5kaWYKPiArfQo+ICsKPiAgX19icGZfa2Z1bmMgaW50IGJwZl9zb2Nr
X29wc19lbmFibGVfdHhfdHN0YW1wKHN0cnVjdCBicGZfc29ja19vcHNfa2VybiAqc2tvcHMsCj4g
IAkJCQkJICAgICAgdTY0IGZsYWdzKQo+ICB7CgpbIC4uLiBdCgoKLS0tCkFJIHJldmlld2VkIHlv
dXIgcGF0Y2guIFBsZWFzZSBmaXggdGhlIGJ1ZyBvciBlbWFpbCByZXBseSB3aHkgaXQncyBub3Qg
YSBidWcuClNlZTogaHR0cHM6Ly9naXRodWIuY29tL2tlcm5lbC1wYXRjaGVzL3ZtdGVzdC9ibG9i
L21hc3Rlci9jaS9jbGF1ZGUvUkVBRE1FLm1kCgpDSSBydW4gc3VtbWFyeTogaHR0cHM6Ly9naXRo
dWIuY29tL2tlcm5lbC1wYXRjaGVzL2JwZi9hY3Rpb25zL3J1bnMvMjYyNzU2NzQ1NzI=

--===============2178938720958764145==--

