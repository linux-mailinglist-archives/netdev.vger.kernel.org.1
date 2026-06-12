Return-Path: <netdev+bounces-298774-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VFT5OmRULGoKPgQAu9opvQ
	(envelope-from <netdev+bounces-298774-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 20:48:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F84A67BD77
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 20:48:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=ElZWs6Fa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298774-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298774-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 153123082583
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB923093CB;
	Fri, 12 Jun 2026 18:48:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35340189B84;
	Fri, 12 Jun 2026 18:48:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781290082; cv=none; b=BspPUaQ0xwCsYAyktpdUFg4VWwh+Fzv35Kwd6vU1kE0xySazV3kogbt2fEPfFps9NVh5UJNDD7YAfGAJJbecYC8LLEWFXmn75buwR8ew5Tud6HU/mGrcIP5+d8aPSMpGLyzden2u4xY9vyU+18ykpdql+lfm6F6snePw3yHR6+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781290082; c=relaxed/simple;
	bh=htPuT7tm372smVg4DmgxAuibfc4nj8Gdpe5982tY96k=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=SFsGlWPSND6LvT/8tlr9ThFP6ZtS0klL64y9c4BWnp+T+4lV6Li0rGe3b783gjlgWOuRkuipt3KQIjgh3gXB2rzJEsLCJnjCrzjA/um/72xX31YU4Uj5hDQflwYLD2Dwv/AeaDpjbm4r7WK5glngMRQp1sISCSmSM4hY4KOzBxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ElZWs6Fa; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781290081; x=1812826081;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=htPuT7tm372smVg4DmgxAuibfc4nj8Gdpe5982tY96k=;
  b=ElZWs6FaCYL9oKaM6Qc0ZHcqHtCkbC7irGSCn1L6Qm90LHJRxXmF+5WH
   RpA5h8xdUFs+oq7MTuYpmjuoh51bwucB4Ulry2Kp/BYFcUUcD26xdFp5q
   amT23FgmlXk0qOvoa6luSPrnF4Zf1Sjj3RAbsEsPhjF0G/fzMJCWDPZLm
   VDvW2ARDxkcfWEJ9GIl/ocSJeBOvJNLA7MUlY8N1yOFrN0o7XgZ389/kM
   OPY7Iy+FtD5nkk59sf0mU6HNijrlXXRrvdH9lHvO3GXWK3Mbq/JgSYOnZ
   w4uVGb4t6VUYP+2l23nc3sYSb1bXEzYgAukgN1+S29K/M/pFp+kVpt/5l
   A==;
X-CSE-ConnectionGUID: fmkzDYL/RYW352njV6U2eg==
X-CSE-MsgGUID: 1d4k+f5wRAqKP4mzq47F9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11815"; a="99703415"
X-IronPort-AV: E=Sophos;i="6.24,201,1774335600"; 
   d="scan'208";a="99703415"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 11:48:01 -0700
X-CSE-ConnectionGUID: u7hVGyS+TsGIOUmWJ6QcfA==
X-CSE-MsgGUID: efIcFitYTtOtCzU+B/fO/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,201,1774335600"; 
   d="scan'208";a="242515111"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.110.161]) ([10.125.110.161])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 11:48:00 -0700
Content-Type: multipart/mixed; boundary="------------X9GYwTAIw7Vm1mltbbp0duDk"
Message-ID: <2da031dd-4442-45b7-9515-72ffc60e8d8c@intel.com>
Date: Fri, 12 Jun 2026 11:47:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] binder: Make shrinker rely solely on per-VMA lock
To: Suren Baghdasaryan <surenb@google.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOl?=
 =?UTF-8?Q?g?= <arve@android.com>, Carlos Llamas <cmllamas@google.com>,
 Christian Brauner <christian@brauner.io>, David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
 Lorenzo Stoakes <ljs@kernel.org>, netdev@vger.kernel.org,
 Shakeel Butt <shakeel.butt@linux.dev>, Todd Kjos <tkjos@android.com>
References: <20260610230409.A44D29FA@davehans-spike.ostc.intel.com>
 <20260610230413.D68967BC@davehans-spike.ostc.intel.com>
 <aipphZ5iCnbXVNSR@google.com>
 <CAJuCfpHmem_g7mEoic7O56LVSLkbftgWYgzexPWy7VSwp7_SiA@mail.gmail.com>
 <131c6a49-9177-418b-a653-8f13942fb8d3@kernel.org>
 <876077cc-db6a-4517-9d81-cdfbb43e599e@intel.com>
 <CAJuCfpFh60wULMkFc7hzxWNg+qmZ2R_HMw_QZe5CNcDRFuoN6A@mail.gmail.com>
 <e9e196ff-7428-43bd-8e06-dc2cf0628c9e@intel.com>
 <CAJuCfpFo_avdhpOviX7EsPqLgDJ3DfeGpth+yu1-ahfawqaSzw@mail.gmail.com>
Content-Language: en-US
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <CAJuCfpFo_avdhpOviX7EsPqLgDJ3DfeGpth+yu1-ahfawqaSzw@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.06 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:surenb@google.com,m:vbabka@kernel.org,m:aliceryhl@google.com,m:dave.hansen@linux.intel.com,m:linux-kernel@vger.kernel.org,m:akpm@linux-foundation.org,m:arve@android.com,m:cmllamas@google.com,m:christian@brauner.io,m:dsahern@kernel.org,m:davem@davemloft.net,m:gregkh@linuxfoundation.org,m:Liam.Howlett@oracle.com,m:linux-mm@kvack.org,m:ljs@kernel.org,m:netdev@vger.kernel.org,m:shakeel.butt@linux.dev,m:tkjos@android.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dave.hansen@intel.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298774-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.hansen@intel.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F84A67BD77

This is a multi-part message in MIME format.
--------------X9GYwTAIw7Vm1mltbbp0duDk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/26 10:44, Suren Baghdasaryan wrote:
>> It's not impossible, but I do think it is irrelevant. Or at least that
>> the *VMA* is irrelevant in this case. binder_alloc_is_mapped()==false
>> means that the binder VMA is gone. It's not in the maple tree, and it's
>> not coming back. If a VMA is found, it's an impostor.
> Right, but before your change we were bailing out early. With your
> change we would be generating the traces and freeing the page. I think
> that's a functional change. Was that your intention?

Yeah, it was intentional.

I think the existing behavior is buggy. It also complicates the goal of
removing the mmap lock fallback. I've broken that behavior change out
into a separate patch. (attached here)
--------------X9GYwTAIw7Vm1mltbbp0duDk
Content-Type: text/x-patch; charset=UTF-8; name="binder-impostor-fix.patch"
Content-Disposition: attachment; filename="binder-impostor-fix.patch"
Content-Transfer-Encoding: base64

CnRsO2RyOiBTdG9wIHJlbHlpbmcgb24gVk1BIGxvb2t1cHMgdG8gZGV0ZXJtaW5lIHdoZW4g
dG8gcmVjbGFpbQpwYWdlcy4gSW5zdGVhZCwgdXNlIGJpbmRlci1pbnRlcm5hbCBtZXRhZGF0
YS4KCj09IEJhY2tncm91bmQgPT0KCkVhY2ggJ3N0cnVjdCBiaW5kZXJfYWxsb2MnIGhhcyBv
bmUgYW5kIG9ubHkgb25lIHBsYWNlIHdoZXJlIGl0IGlzCnJlY29yZGVkIGFzIGhhdmluZyBi
ZWVuIG1hcHBlZC4gSXQgY2FuIGJlIG11bm1hcCgpJ2QuIEJ1dCBhZnRlciB0aGF0LApiaW5k
ZXJfYWxsb2NfbW1hcF9oYW5kbGVyKCkgd2lsbCByZXR1cm4gZXJyb3JzIGZvciBpdCBiZWlu
ZyAiYWxyZWFkeQptYXBwZWQiLiBTbywgYmluZGVyIG1tYXAoKXMgYXJlIGEgb25lLXNob3Qg
dGhpbmcuCgpCdXQsIHRoZSBvcmlnaW5hbCBtbWFwKCkgbG9jYXRpb24gaXMgc3BlY2lhbCBl
dmVuIGFmdGVyIG11bm1hcCgpLiBJdAppcyBzdGlsbCByZWNvcmRlZCBpbiBhbGxvYy0+dm1f
c3RhcnQgYW5kIG5ldmVyIGNsZWFyZWQgb3V0LgpiaW5kZXJfYWxsb2NfZnJlZV9wYWdlKCkg
Y29udGludWVzIHRvIGxvb2sgdXAgVk1BcyBhdCB0aGF0IGFkZHJlc3MuCgo9PSBQcm9ibGVt
ID09CgpUaGF0IGxlYWRzIHRvIHNvbWUgc3Vib3B0aW1hbCBiZWhhdmlvci4gVGhlIG1vbWVu
dCBhbiAiaW1wb3N0b3IiIFZNQQppcyBjcmVhdGVkIGF0IHRoZSBvbGQgYmluZGVyIGFkZHJl
c3MsIHRoZSBzaHJpbmtlciBmdW5jdGlvbiB3aWxsCmFsd2F5cyBoaXQgdGhlOgoKCWlmICh2
bWEgJiYgIWJpbmRlcl9hbGxvY19pc19tYXBwZWQoYWxsb2MpKQoKY2FzZSBhbmQgTFJVX1NL
SVAgYWxsIHBhZ2VzLgoKPT0gU29sdXRpb24gPT0KClN0b3AgdXNpbmcgdGhlIFZNQSB0byBk
cml2ZSB6YXBwaW5nIGRlY2lzaW9ucy4gSW5zdGVhZCwgdXNlCmJpbmRlcl9hbGxvY19pc19t
YXBwZWQoKS4KCj09IERpc2N1c3Npb24gPT0KCkhlcmUncyBzb21lIHBzZXVkb2NvZGUgZm9y
IGhvdyB0aGlzIGJlaGF2aW9yIGNvdWxkIGJlIHRyaWdnZXJlZDoKCglhZGRyID0gbW1hcCgu
Li4sIGxlbiwgYmluZGVyX2ZkKTsKCS8vIHBhZ2VzIGNhbiBiZSByZWNsYWltZWQKCW11bm1h
cChhZGRyLCBsZW4pOwoJLy8gcGFnZXMgY2FuIHN0aWxsIGJlIHJlY2xhaW1lZAoJbW1hcChh
ZGRyLCBsZW4sIE1BUF9BTk9OWU1PVVN8TUFQX1BSSVZBVEUsIC0xLCAuLi4pOwoJLy8gUGFn
ZXMgY2FuIG5vIGxvbmdlciBiZSByZWNsYWltZWQKClRoZXJlIGFyZSBwbGVudHkgb2Ygd2F5
cyB0aGUgY29kZSBjb3VsZCBiZSByZXN0cnVjdHVyZWQgbm93CnRoYXQgaXQgaXMgbGVzcyBk
ZXBlbmRlbnQgb24gVk1Bcy4gQnV0IEkndmUgbGVmdCB0aGF0IGZvciBmdXR1cmUKcGF0Y2hl
cy4KCi0tLQoKIGIvZHJpdmVycy9hbmRyb2lkL2JpbmRlcl9hbGxvYy5jIHwgICAxMCArLS0t
LS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDkgZGVsZXRpb25zKC0p
CgpkaWZmIC1wdU4gZHJpdmVycy9hbmRyb2lkL2JpbmRlcl9hbGxvYy5jfmJpbmRlci1pbXBv
c3Rvci1maXggZHJpdmVycy9hbmRyb2lkL2JpbmRlcl9hbGxvYy5jCi0tLSBhL2RyaXZlcnMv
YW5kcm9pZC9iaW5kZXJfYWxsb2MuY35iaW5kZXItaW1wb3N0b3ItZml4CTIwMjYtMDYtMTIg
MTA6NDY6MDYuNzA0NzA3MjMzIC0wNzAwCisrKyBiL2RyaXZlcnMvYW5kcm9pZC9iaW5kZXJf
YWxsb2MuYwkyMDI2LTA2LTEyIDExOjM0OjE1LjMwNDQ2MDUyMCAtMDcwMApAQCAtMTE2NCwx
NCArMTE2NCw2IEBAIGVudW0gbHJ1X3N0YXR1cyBiaW5kZXJfYWxsb2NfZnJlZV9wYWdlKHMK
IAlpZiAoIW11dGV4X3RyeWxvY2soJmFsbG9jLT5tdXRleCkpCiAJCWdvdG8gZXJyX2dldF9h
bGxvY19tdXRleF9mYWlsZWQ7CiAKLQkvKgotCSAqIFNpbmNlIGEgYmluZGVyX2FsbG9jIGNh
biBvbmx5IGJlIG1hcHBlZCBvbmNlLCB3ZSBlbnN1cmUKLQkgKiB0aGUgdm1hIGNvcnJlc3Bv
bmRzIHRvIHRoaXMgbWFwcGluZyBieSBjaGVja2luZyB3aGV0aGVyCi0JICogdGhlIGJpbmRl
cl9hbGxvYyBpcyBzdGlsbCBtYXBwZWQuCi0JICovCi0JaWYgKHZtYSAmJiAhYmluZGVyX2Fs
bG9jX2lzX21hcHBlZChhbGxvYykpCi0JCWdvdG8gZXJyX2ludmFsaWRfdm1hOwotCiAJdHJh
Y2VfYmluZGVyX3VubWFwX2tlcm5lbF9zdGFydChhbGxvYywgaW5kZXgpOwogCiAJcGFnZV90
b19mcmVlID0gYWxsb2MtPnBhZ2VzW2luZGV4XTsKQEAgLTExODIsNyArMTE3NCw3IEBAIGVu
dW0gbHJ1X3N0YXR1cyBiaW5kZXJfYWxsb2NfZnJlZV9wYWdlKHMKIAlsaXN0X2xydV9pc29s
YXRlKGxydSwgaXRlbSk7CiAJc3Bpbl91bmxvY2soJmxydS0+bG9jayk7CiAKLQlpZiAodm1h
KSB7CisJaWYgKGJpbmRlcl9hbGxvY19pc19tYXBwZWQoYWxsb2MpKSB7CiAJCXRyYWNlX2Jp
bmRlcl91bm1hcF91c2VyX3N0YXJ0KGFsbG9jLCBpbmRleCk7CiAKIAkJemFwX3ZtYV9yYW5n
ZSh2bWEsIHBhZ2VfYWRkciwgUEFHRV9TSVpFKTsKXwo=

--------------X9GYwTAIw7Vm1mltbbp0duDk--

