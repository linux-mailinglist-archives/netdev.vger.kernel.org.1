Return-Path: <netdev+bounces-288220-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8jZYCd3VBmpjoQIAu9opvQ
	(envelope-from <netdev+bounces-288220-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:14:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD8954B1F5
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24A6E3013AA5
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2FB3FBEB0;
	Fri, 15 May 2026 08:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iX6TxfvU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EC03F0A81;
	Fri, 15 May 2026 08:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778832849; cv=none; b=EHsT8BJc7/cqcQa0Ebk0pV8RBIPMZzwjokm4xhugrXzk+FoP4ScN+1SFZ1yVNB5iLS8ht66nVpZm0sYLoEXXoxvjaWmESuOFG2mmO1QS0tOQptLTqJnXEDJBJUDyjOoKLI1w4cvz6Pbce28ZwbFjDLOjRzaXas7d9EHBEIQO3nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778832849; c=relaxed/simple;
	bh=zqrtEYBR5vL3fQvzItspsHtrj6rrxUy1zU0ZiWZxKNA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LBXwEnD/oDDOK9mLgYFzl3X3tv7UlsiBEYcnTWi4nv/QWlVHzNybfYcUBuQBrIkNPQF+vo99C08OXVEnSZTTTeY3h+KUATu9NO492sReb9DwHv+ayGykMgtJ/T3F+/zuLkTJs2IZnEJ6VwQv6PDLawo5CZ9qZhF2WaNbEFzHmGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iX6TxfvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A06C2BCB8;
	Fri, 15 May 2026 08:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778832848;
	bh=zqrtEYBR5vL3fQvzItspsHtrj6rrxUy1zU0ZiWZxKNA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=iX6TxfvUXpX2CvR8meTchQMTcG7wLxoqun6yTlJOQV9Ey9sfoF89x3yjUyl3T85FL
	 2dnpEUtEwbpInhrV4JPJ5Mn807ICEk/lczubU4gGuAgQ0nk2QYkhN05qzAPE4hK4zR
	 V5QRNAIWzy0U0KAtTWwsQzx69k51KR45vL4zxcZ7SbGogpeP7i1dkuoHqe+eh5BSbw
	 ojAfnimy0sLCBGWxxCe1qXyh047/u8b1ACwgdtYZckSCM7pRxtIylJOZAAcBt35/4w
	 RpkFDcuU+JXSq793gHEFodvJoif2zAMGYVyx2mTf3JzHs6IBfYCHCTNiPc/TJPX0i6
	 dNJ3dBPElxMYQ==
Content-Type: multipart/mixed; boundary="===============5085312704577427323=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2e08eb1ca27a9a2f8ad29e1c24f779b579621b0a648589f7044799d91c5e00f5@mail.kernel.org>
In-Reply-To: <20260515071504.2054786-2-yuyanghuang@google.com>
References: <20260515071504.2054786-2-yuyanghuang@google.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: align syscall writeback behavior with caller-declared size
From: bot+bpf-ci@kernel.org
To: yuyanghuang@google.com,yuyanghuang@google.com
Cc: davem@davemloft.net,ast@kernel.org,andrew+netdev@lunn.ch,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,edumazet@google.com,kuba@kernel.org,jolsa@kernel.org,john.fastabend@gmail.com,memxor@gmail.com,martin.lau@linux.dev,razor@blackwall.org,pabeni@redhat.com,shuah@kernel.org,horms@kernel.org,song@kernel.org,sdf@fomichev.me,yonghong.song@linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,netdev@vger.kernel.org,maze@google.com,lorenzo@google.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 15 May 2026 08:14:08 +0000 (UTC)
X-Rspamd-Queue-Id: 2AD8954B1F5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288220-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,lunn.ch,iogearbox.net,gmail.com,google.com,linux.dev,blackwall.org,redhat.com,fomichev.me,vger.kernel.org,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

--===============5085312704577427323==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

PiAgICAgYnBmOiBhbGlnbiBzeXNjYWxsIHdyaXRlYmFjayBiZWhhdmlvciB3aXRoIGNhbGxlci1k
ZWNsYXJlZCBzaXplCj4KPiAgICAgVGhlIGJwZihjbWQsIGF0dHIsIHNpemUpIHN5c2NhbGwgY29w
aWVzIHVwIHRvICdzaXplJyBieXRlcyBvbiBpbnB1dCwgYnV0Cj4gICAgIHNldmVyYWwgY29tbWFu
ZHMgd3JpdGUgb3V0cHV0cyBiYWNrIHRvIHVzZXJzcGFjZSB1bmNvbmRpdGlvbmFsbHkuIEJlY2F1
c2UKPiAgICAgY29weV90b191c2VyKCkgZG9lcyBub3QgZmF1bHQgb24gYWRqYWNlbnQgbWFwcGVk
IG1lbW9yeSwgYSBzaG9ydCB1c2Vyc3BhY2UKPiAgICAgYnVmZmVyIHJlc3VsdHMgaW4gb3V0LW9m
LWJvdW5kcyB3cml0ZXMsIHBvdGVudGlhbGx5IG92ZXJ3cml0aW5nIGFkamFjZW50Cj4gICAgIHVz
ZXJzcGFjZSBtZW1vcnkuCj4KPiAgICAgQWRkcmVzcyB0aGlzIGJ5IGludHJvZHVjaW5nIHR3byBw
b2xpY2llcyBiYXNlZCBvbiBmaWVsZCB0eXBlOgo+Cj4gICAgIDEpIE1hbmRhdG9yeSBmaWVsZHMg
KG9yaWdpbmFsIEFCSSk6IFJldHVybiAtRUlOVkFMIGluIF9fc3lzX2JwZigpIGlmIHRoZQo+ICAg
ICAgICBidWZmZXIgc2l6ZSBkb2VzIG5vdCBjb3ZlciB0aGVtLiBUaGlzIGhhcmRlbnMgdGhlIHN5
c2NhbGwgZnJvbnQtZ2F0ZQo+ICAgICAgICBmb3IgdGhlIGZvbGxvd2luZyBjb21tYW5kczoKPiAg
ICAgICAgLSBCUEZfUFJPR19RVUVSWSAobWluIHNpemU6IHF1ZXJ5LnByb2dfY250KQo+ICAgICAg
ICAtIEJQRl9QUk9HX1RFU1RfUlVOIChtaW4gc2l6ZTogdGVzdC5kdXJhdGlvbikKPiAgICAgICAg
LSBCUEZfKl9HRVRfTkVYVF9JRCAobWluIHNpemU6IG5leHRfaWQpCj4gICAgICAgIC0gQlBGX09C
Sl9HRVRfSU5GT19CWV9GRCAobWluIHNpemU6IGluZm8uaW5mb19sZW4pCj4gICAgICAgIC0gQlBG
X1RBU0tfRkRfUVVFUlkgKG1pbmltdW0gc2l6ZTogdGFza19mZF9xdWVyeS5wcm9iZV9hZGRyKQo+
ICAgICAgICAtIEJQRl9NQVBfKl9CQVRDSCAobWluIHNpemU6IGJhdGNoLmZsYWdzKQo+Cj4gICAg
IDIpIE9wdGlvbmFsIGZpZWxkcyAobGF0ZXIgcmV2aXNpb25zKTogU2tpcCB3cml0ZWJhY2sgaWYg
dGhlIGJ1ZmZlciBzaXplCj4gICAgICAgIGRvZXMgbm90IGNvdmVyIHRoZSBmaWVsZC4gVGhpcyBp
cyBhcHBsaWVkIHRvIEJQRl9QUk9HX1FVRVJZJ3MKPiAgICAgICAgJ3F1ZXJ5LnJldmlzaW9uJy4g
T2xkZXIgdXNlcnNwYWNlIHBhc3NpbmcgYSBzbWFsbGVyIHNpemUgKGUuZy4sIDQwCj4gICAgICAg
IGJ5dGVzKSB3aWxsIGhhdmUgdGhlIHdyaXRlIHNhZmVseSBza2lwcGVkLiBUaGlzIHNpemUtZ2F0
aW5nIHBhdHRlcm4KPiAgICAgICAgbWlycm9ycyB0aGUgZXhpc3RpbmcgcHJlY2VkZW50IHVzZWQg
Zm9yICdsb2dfdHJ1ZV9zaXplJyAodmVyaWZpZXIuYykKPiAgICAgICAgYW5kICdidGZfbG9nX3Ry
dWVfc2l6ZScgKGJ0Zi5jKS4KPgo+ICAgICBUbyBzdXBwb3J0IHRoaXMsIHRoZSB1c2VyLWRlY2xh
cmVkICdzaXplJyBpcyBwbHVtYmVkIGZyb20gX19zeXNfYnBmKCkKPiAgICAgdGhyb3VnaCB0aGUg
cXVlcnkgZGlzcGF0Y2hlcnMgKGNncm91cCwgdGN4LCBuZXRraXQpIHRvIHRoZSB1bmRlcmx5aW5n
Cj4gICAgIHdyaXRlYmFjayBoZWxwZXJzIGluIGNncm91cC5jIGFuZCBtcHJvZy5jLgo+Cj4gICAg
IENjOiBNYWNpZWogxbtlbmN6eWtvd3NraSA8bWF6ZUBnb29nbGUuY29tPgo+ICAgICBDYzogTG9y
ZW56byBDb2xpdHRpIDxsb3JlbnpvQGdvb2dsZS5jb20+Cj4gICAgIFNpZ25lZC1vZmYtYnk6IFl1
eWFuZyBIdWFuZyA8eXV5YW5naHVhbmdAZ29vZ2xlLmNvbT4KPiAgICAgTGluazogaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvci9DQU5QM1JHZlpUWE1fdT1FX2F0b29tUFpYdXRvUUowMm5PTWtDQ1It
WUJaYk9tMnN1V0FAbWFpbC5nbWFpbC5jb20KClRoaXMgbG9va3MgbGlrZSBhIGJ1ZyBmaXggZm9y
IGFuIG91dC1vZi1ib3VuZHMgd3JpdGUgdnVsbmVyYWJpbGl0eS4KU2hvdWxkIHRoaXMgaW5jbHVk
ZSBhIEZpeGVzOiB0YWcgdG8gaWRlbnRpZnkgd2hpY2ggY29tbWl0IGludHJvZHVjZWQgdGhlCnVu
Y29uZGl0aW9uYWwgY29weV90b191c2VyKCkgY2FsbHMgZm9yIHF1ZXJ5LnJldmlzaW9uIHdpdGhv
dXQgY2hlY2tpbmcKdGhlIHVzZXItcHJvdmlkZWQgYnVmZmVyIHNpemU/CgogIEZpeGVzOiAzZmUy
MTNjMDQwYjMgKCJhZGRpbmcgY2kgZmlsZXMiKQoKCi0tLQpBSSByZXZpZXdlZCB5b3VyIHBhdGNo
LiBQbGVhc2UgZml4IHRoZSBidWcgb3IgZW1haWwgcmVwbHkgd2h5IGl0J3Mgbm90IGEgYnVnLgpT
ZWU6IGh0dHBzOi8vZ2l0aHViLmNvbS9rZXJuZWwtcGF0Y2hlcy92bXRlc3QvYmxvYi9tYXN0ZXIv
Y2kvY2xhdWRlL1JFQURNRS5tZAoKQ0kgcnVuIHN1bW1hcnk6IGh0dHBzOi8vZ2l0aHViLmNvbS9r
ZXJuZWwtcGF0Y2hlcy9icGYvYWN0aW9ucy9ydW5zLzI1OTA1OTI4MzMx

--===============5085312704577427323==--

