Return-Path: <netdev+bounces-298712-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yY3ZJ4AuLGo9NAQAu9opvQ
	(envelope-from <netdev+bounces-298712-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:06:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDB067AB64
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:06:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=SMUt6rQe;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298712-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298712-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 692F631E7572
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CCD3947B8;
	Fri, 12 Jun 2026 16:05:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFB9371CE3;
	Fri, 12 Jun 2026 16:05:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280313; cv=none; b=pmwRKDoH3HIAThmnOxzKgO3H9BUEUfR/iGlOrcDpmHg0rnVwB7jegxhDCd0VV+YpEEw00BOKvQzx/6NqOgZZfOKmlUFc7iGvJ3fZmV3nNEXCKs8Mssc1lWEShbtpxsUHP3QfHCLvOH3aFP+awHEre3I2nj34Q3SzmrheXxdbUYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280313; c=relaxed/simple;
	bh=WALi1ImsyCD2+C1Y84w274LjqRrutLjlm9Y/X1vIdRs=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=aoJTZ33OWkAcBRXHQ3dEzLSdsU9iouFByalJ3PFbRoeVg0nYciqr8vErHeLc/XU7G/Y/+oIYSZ5EnW++Lm4dCDqktahaNcxblLvDvf4kX3Vt22nfpA3gG4v4apjHfp1iXzHTf4qMjwPIqICGKq3Ir0T4IcaEkyvne04uJv7S6bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SMUt6rQe; arc=none smtp.client-ip=192.198.163.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781280312; x=1812816312;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=WALi1ImsyCD2+C1Y84w274LjqRrutLjlm9Y/X1vIdRs=;
  b=SMUt6rQeDF71DsMQw1eEyThuAI9IBFumUFyhQ5XRkiqfExH18SOZp05y
   cZN8BVPIWOxzgBD0VGgX+zzWuqrs1bf2LnXK3C/m8JTFmU+iOV1sZVU2+
   NQ04NGuKOgpElGKR9ZNa6foRiCQNwBuH2QMHkgcPYcILYQnGuZEE6dTGc
   vFzg7bgXftACq4jc/qiDEbnUHafF2bRRKSbjo7TTRwEvWZz3QR6tjCy/W
   f2QMl9bf1ZTGHHI6KaeudUWuRJ6bC6X4loUeiAoSL/v+8e1g+DC5OJq3S
   6lJxid1b+Y+DupqMn8kezJ4hy3VOH2/amOUsjCIISZmajnl+urI1TjAog
   Q==;
X-CSE-ConnectionGUID: bBVIEGpSTcm5unn0xTQsVg==
X-CSE-MsgGUID: XVGe2+F1Teid6BA5HlWwmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11815"; a="82220089"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="82220089"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 09:04:50 -0700
X-CSE-ConnectionGUID: 0JZGA0RWTk63XjHvOd7jKA==
X-CSE-MsgGUID: FY5IMTCvSkCK5dobxYuQVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="245746560"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.110.161]) ([10.125.110.161])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 09:04:50 -0700
Content-Type: multipart/mixed; boundary="------------ALBAYeTYCeqQriFsrKlZ6ptS"
Message-ID: <876077cc-db6a-4517-9d81-cdfbb43e599e@intel.com>
Date: Fri, 12 Jun 2026 09:04:48 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] binder: Make shrinker rely solely on per-VMA lock
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Alice Ryhl <aliceryhl@google.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
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
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <131c6a49-9177-418b-a653-8f13942fb8d3@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.06 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:surenb@google.com,m:aliceryhl@google.com,m:dave.hansen@linux.intel.com,m:linux-kernel@vger.kernel.org,m:akpm@linux-foundation.org,m:arve@android.com,m:cmllamas@google.com,m:christian@brauner.io,m:dsahern@kernel.org,m:davem@davemloft.net,m:gregkh@linuxfoundation.org,m:Liam.Howlett@oracle.com,m:linux-mm@kvack.org,m:ljs@kernel.org,m:netdev@vger.kernel.org,m:shakeel.butt@linux.dev,m:tkjos@android.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298712-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dave.hansen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.hansen@intel.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0FDB067AB64

This is a multi-part message in MIME format.
--------------ALBAYeTYCeqQriFsrKlZ6ptS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/26 08:41, Vlastimil Babka (SUSE) wrote:
>>> If the vma lookup fails because the mmap write lock is held, but the vma
>>> actually exists (has not been unmapped), then this code might "successfully"
>>> remove the page without invoking zap_vma_range(). This means that the
>>> page does not actually get freed and will just hang around forever until
>>> the process owning the vma exits or Binder needs this page and maps a
>>> new page on top of the page.
>> Yeah, I think if lock_vma_under_rcu() returns NULL you just need to
>> jump to err_mmap_read_lock_failed, like we currently do if
>> mmap_read_trylock() fails.
> I don't think that will be enough as well, as the current code AFAICS does
> something meaninfgul when mmap_read_trylock() suceeds but vma_lookup returns
> NULL because there's no vma at that address. Now we would just assume the
> trylock failed even if the reason was that vma lookup found nothing for the
> address. The problem is that lock_vma_under_rcu() can't distinguish those
> two outcomes, so we would need something that does?

I spent way too much time staring at this yesterday.

I think the key to distinguishing between:

	vma==NULL because there's no VMA
and
	vma==NULL because of a trylock failure

is binder_alloc_is_mapped(). It won't return false until vm_ops->close()
finishes. vm_ops->close() shouldn't be able to happen while
lock_vma_under_rcu() is held. So if you've got a non-NULL VMA, you've
also got a stable is binder_alloc_is_mapped().

So, if you've got a vma!=NULL *and* binder_alloc_is_mapped()==true, I
think you can be pretty sure you've got the right VMA.

If you have vma==NULL and binder_alloc_is_mapped()==true, you can be
pretty sure that you hit some kind of transient lock_vma_under_rcu()
failure.

I came up with the attached patch. More eyeballs would be welcome.
There's a _lot_ going on here.
--------------ALBAYeTYCeqQriFsrKlZ6ptS
Content-Type: text/x-patch; charset=UTF-8; name="binder-try-vma-lock.patch"
Content-Disposition: attachment; filename="binder-try-vma-lock.patch"
Content-Transfer-Encoding: base64

CkZyb206IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb20+Cgp0bDtk
cjogbG9ja192bWFfdW5kZXJfcmN1KCkgaXMgYWxyZWFkeSBhIHRyeWxvY2suIE5vIG5lZWQg
dG8gZG8gYm90aAppdCBhbmQgbW1hcF9yZWFkX3RyeWxvY2soKS4KCkxvbmcgVmVyc2lvbjoK
Cj09IEJhY2tncm91bmQgPT0KCkhpc3RvcmljYWxseSwgYmluZGVyIHVzZWQgYW4gbW1hcF9y
ZWFkX3RyeWxvY2soKSBpbiBpdHMgc2hyaW5rZXIgY29kZS4KVGhpcyBlbnN1cmVzIHRoYXQg
cmVjbGFpbSBpcyBub3QgYmxvY2tlZCBvbiBhbiBtbWFwX2xvY2suIENvbW1pdAo5NWJjMmQ0
YTkwMjAgKCJiaW5kZXI6IHVzZSBwZXItdm1hIGxvY2sgaW4gcGFnZSByZWNsYWltaW5nIikg
YWRkZWQKc3VwcG9ydCBmb3IgdGhlIHBlci1WTUEgbG9jaywgYnV0IGxlZnQgbW1hcF9yZWFk
X3RyeWxvY2soKSBhcyBhCmZhbGxiYWNrLgoKVGhpcyBmYWxsYmFjayB3YXMgcmVxdWlyZWQg
d2hlbiBwZXItVk1BIGxvY2tpbmcgY291bGQgZmFpbApwZXJzaXN0ZW50eSwgYnV0IHRoYXQg
aXMgbm8gbG9uZ2VyIHRoZSBjYXNlLgoKPT0gUHJvYmxlbSA9PQoKVGhlIGZhbGxiYWNrIGlz
IG5vdCB3b3J0aCB0aGUgY29tcGxleGl0eSBoZXJlLiBsb2NrX3ZtYV91bmRlcl9yY3UoKSBp
cwplc3NlbnRpYWxseSBhbHJlYWR5IGEgbm9uLWJsb2NraW5nIHRyeWxvY2suIFRoZSBtYWlu
IHJlYXNvbiBpdCBmYWlscwppcyBhbHNvIHRoZSByZWFzb24gbW1hcF9yZWFkX3RyeWxvY2so
KSBmYWlsczogc29tZXRoaW5nIGlzIGhvbGRpbmcKbW1hcF93cml0ZV9sb2NrKCkuCgpUaGUg
b25seSByZW1lZHkgZm9yIGEgY29sbGlzaW9uIHdpdGggbW1hcF93cml0ZV9sb2NrKCkgaXMg
dG8gd2FpdCwKd2hpY2ggdGhpcyBjb2RlIGNhbiBub3QgZG8uIFNvIHRoZSAiZmFsbGJhY2si
IGFmdGVyCmxvY2tfdm1hX3VuZGVyX3JjdSgpIGZhaWx1cmUgaXMgbm90IHJlYWxseSBhIGZh
bGxiYWNrOiBpdCBpcyByZWFsbHkKbGlrZWx5IHRvIGp1c3QgYmUgcmV0cnlpbmcgaW4gdmFp
bi4gVGhhdCByZXRyeSBpbiBhbiBvZiBpdHNlbGYgaXNuJ3QKaG9ycmlibGUuIEJ1dCBpdCBh
ZGRzIGNvbXBsZXhpdHkuCgo9PSBTb2x1dGlvbiA9PQoKTm93IHRoYXQgcGVyLVZNQSBsb2Nr
cyBhcmUgdW5pdmVyc2FsbHkgYXZhaWxhYmxlLCBsb2NrX3ZtYV91bmRlcl9yY3UoKQp3aWxs
IG5vdCBwZXJzaXN0ZW50bHkgZmFpbC4gUmVseSBvbiBpdCBhbG9uZSBhbmQgc2ltcGxpZnkg
dGhlIGNvZGUuCgpUaGUgb25lIHdyaW5rbGUgaXMgdGhhdCBsb2NrX3ZtYV91bmRlcl9yY3Uo
KSBjYW4gcmV0dXJuIE5VTEwgZXZlbiBpZgp0aGVyZSBpcyBhIFZNQSBhdCAncGFnZV9hZGRy
Jy4gQnV0IHRoZSBsYXRlciBwYWdlIHphcHBpbmcgY29kZQoqbXVzdCogcnVuIGlmIHRoZSBw
YWdlIG1pZ2h0IGJlIG1hcHBlZCBpbiB0byBhIFZNQS4gU3RvcCByZWx5aW5nIG9uCnZtYV9s
b29rdXAoKSBmb3IgdGhpcy4gSnVzdCByZWx5IG9uIGJpbmRlcl9hbGxvY19pc19tYXBwZWQo
KS4KCj09IERpc2N1c3Npb24gPT0KCkkgdGhpbmsgdGhlcmUgZW5kIHVwIGJlaW5nIGZvdXIg
cG9zc2libGUgY2FzZXMgdG8gaGFuZGxlLiBUaGUgZmlyc3QKdHdvIGFyZSBzdHJhaWdodGZv
cndhcmQuIE5vdGUgdGhhdCAibWFwcGVkIiBpcyBzaG9ydGhhbmQgZm9yCmJpbmRlcl9hbGxv
Y19pc19tYXBwZWQoKS4KCiAgICAgICAgIXZtYSAmJiAhbWFwcGVkOiByZWNsYWltLCBubyB6
YXAKICAgICAgICAgdm1hICYmICBtYXBwZWQ6IHJlY2xhaW0sIHdpdGggemFwCgpUaGUgbmV4
dCBvbmUgaXMgYXJndWFibHkgd3JvbmcgaW4gdGhlIGNvZGUgdG9kYXk6CgogICAgICAgICB2
bWEgJiYgIW1hcHBlZDogV3JvbmcgVk1BLiBTa2lwIGFuZCByZXRyeS4KCkl0IGluZHVjZXMg
TFJVX1NLSVAgYmVoYXZpb3IgZnJvbSBhbm90aGVyIFZNQSBnZXR0aW5nIG1hcHBlZC4gVGhh
dApzZWVtcyB3cm9uZy4gSXQgaXMgcG9zc2libGUgdG8gY29udGludWUgdGhpcyBiZWhhdmlv
ciwgYnV0IGl0IGFsc28Kc2VlbXMgYSBiaXQgc2lsbHkgdG8gZ28gdG8gYW55IGxlbmd0aHMg
dG8ga2VlcCBkb2luZyBpdCBpZiBpdCBpcwphIGJ1Zy4KClRoZSBsYXN0IGNhc2UgY29tZXMg
ZnJvbSBub3JtYWwgbG9ja192bWFfdW5kZXJfcmN1KCkgYmVoYXZpb3IgbGlrZQpsaWtlIG92
ZXJmbG93cyB0aGF0IGlzIHRyYW5zaWVudC4gSXQgY2FuIF9zYWZlbHlfIGJlIGhhbmRsZWQg
YnkKTFJVX1NLSVAuIFRoaXMgY2FzZSBpcyBuZXcuCgogICAgICAgICF2bWEgJiYgIG1hcHBl
ZDogVk1BIGxvY2sgcmFjZS4gU2tpcCBhbmQgcmV0cnkuCgpTaWduZWQtb2ZmLWJ5OiBEYXZl
IEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPgpDYzogU3VyZW4gQmFnaGRh
c2FyeWFuIDxzdXJlbmJAZ29vZ2xlLmNvbT4KQ2M6IExvcmVuem8gU3RvYWtlcyA8bGpzQGtl
cm5lbC5vcmc+CkNjOiBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3Jn
PgpDYzogIkxpYW0gUi4gSG93bGV0dCIgPExpYW0uSG93bGV0dEBvcmFjbGUuY29tPgpDYzog
Vmxhc3RpbWlsIEJhYmthIDx2YmFia2FAa2VybmVsLm9yZz4KQ2M6IFNoYWtlZWwgQnV0dCA8
c2hha2VlbC5idXR0QGxpbnV4LmRldj4KQ2M6IGxpbnV4LW1tQGt2YWNrLm9yZwpDYzogR3Jl
ZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4KQ2M6IEFydmUg
SGrDuG5uZXbDpWcgPGFydmVAYW5kcm9pZC5jb20+CkNjOiBUb2RkIEtqb3MgPHRram9zQGFu
ZHJvaWQuY29tPgpDYzogQ2hyaXN0aWFuIEJyYXVuZXIgPGNocmlzdGlhbkBicmF1bmVyLmlv
PgpDYzogQ2FybG9zIExsYW1hcyA8Y21sbGFtYXNAZ29vZ2xlLmNvbT4KQ2M6IEFsaWNlIFJ5
aGwgPGFsaWNlcnlobEBnb29nbGUuY29tPgpDYzogIkRhdmlkIFMuIE1pbGxlciIgPGRhdmVt
QGRhdmVtbG9mdC5uZXQ+CkNjOiBEYXZpZCBBaGVybiA8ZHNhaGVybkBrZXJuZWwub3JnPgpD
YzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZwoKLS0tCgpDaGFuZ2VzIGZyb20gdjE6CiAqIE1v
dmUgZm9yd2FyZCBldmVuIGlmICd2bWEnIGlzIE5VTEwgaW4gYmluZGVyX2FsbG9jX2ZyZWVf
cGFnZSgpLgogICBUaGlzIGNhbiBoYXBwZW4gaWYgdGhlIFZNQSBpcyB1bm1hcHBlZCAoU2Fz
aGlrbykuCiAqIFJlbmFtZSBnb3RvIGxhYmVsIHRvIGJlIG1vcmUgYWNjdXJhdGUgZm9yIG5l
dyBsb2NrIHNjaGVtZQoKQ2hhbmdlcyBmcm9tIHYyOgogKiBSZW1vdmUgcmV2aWV3IHRhZ3Mu
IFRoZXJlJ3MgdG9vIG11Y2ggY2h1cm4gaW4gaGVyZSB0byBrZWVwIHRoZW0uCiAqIFJlbHkg
b24gYmluZGVyX2FsbG9jX2ZyZWVfcGFnZSgpIGluc3RlYWQgb2YgVk1BIGxvb2t1cHMgYWxv
bmUgdG8KICAgZGV0ZXJtaW5lIGlmIHRoZSByYW5nZSBtdXN0IGJlIHphcHBlZC4KCi0tLQoK
IGIvZHJpdmVycy9hbmRyb2lkL2JpbmRlcl9hbGxvYy5jIHwgICA0MiArKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRp
b25zKCspLCAyNiBkZWxldGlvbnMoLSkKCmRpZmYgLXB1TiBkcml2ZXJzL2FuZHJvaWQvYmlu
ZGVyX2FsbG9jLmN+YmluZGVyLXRyeS12bWEtbG9jayBkcml2ZXJzL2FuZHJvaWQvYmluZGVy
X2FsbG9jLmMKLS0tIGEvZHJpdmVycy9hbmRyb2lkL2JpbmRlcl9hbGxvYy5jfmJpbmRlci10
cnktdm1hLWxvY2sJMjAyNi0wNi0xMCAxNTo1Nzo1NS4yNzQ0MTIwMTggLTA3MDAKKysrIGIv
ZHJpdmVycy9hbmRyb2lkL2JpbmRlcl9hbGxvYy5jCTIwMjYtMDYtMTEgMTU6MTc6MjUuMjQw
NDczMDEwIC0wNzAwCkBAIC0xMTQyLDcgKzExNDIsNyBAQCBlbnVtIGxydV9zdGF0dXMgYmlu
ZGVyX2FsbG9jX2ZyZWVfcGFnZShzCiAJc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWE7CiAJ
c3RydWN0IHBhZ2UgKnBhZ2VfdG9fZnJlZTsKIAl1bnNpZ25lZCBsb25nIHBhZ2VfYWRkcjsK
LQlpbnQgbW1fbG9ja2VkID0gMDsKKwlib29sIG1hcHBlZDsKIAlzaXplX3QgaW5kZXg7CiAK
IAlpZiAoIW1tZ2V0X25vdF96ZXJvKG1tKSkKQEAgLTExNTEsMjYgKzExNTEsMjEgQEAgZW51
bSBscnVfc3RhdHVzIGJpbmRlcl9hbGxvY19mcmVlX3BhZ2UocwogCWluZGV4ID0gbWRhdGEt
PnBhZ2VfaW5kZXg7CiAJcGFnZV9hZGRyID0gYWxsb2MtPnZtX3N0YXJ0ICsgaW5kZXggKiBQ
QUdFX1NJWkU7CiAKLQkvKiBhdHRlbXB0IHBlci12bWEgbG9jayBmaXJzdCAqLwogCXZtYSA9
IGxvY2tfdm1hX3VuZGVyX3JjdShtbSwgcGFnZV9hZGRyKTsKLQlpZiAoIXZtYSkgewotCQkv
KiBmYWxsIGJhY2sgdG8gbW1hcF9sb2NrICovCi0JCWlmICghbW1hcF9yZWFkX3RyeWxvY2so
bW0pKQotCQkJZ290byBlcnJfbW1hcF9yZWFkX2xvY2tfZmFpbGVkOwotCQltbV9sb2NrZWQg
PSAxOwotCQl2bWEgPSB2bWFfbG9va3VwKG1tLCBwYWdlX2FkZHIpOwotCX0KIAogCWlmICgh
bXV0ZXhfdHJ5bG9jaygmYWxsb2MtPm11dGV4KSkKLQkJZ290byBlcnJfZ2V0X2FsbG9jX211
dGV4X2ZhaWxlZDsKKwkJZ290byBlcnJfdm1hX2VuZF9yZWFkOwogCiAJLyoKLQkgKiBTaW5j
ZSBhIGJpbmRlcl9hbGxvYyBjYW4gb25seSBiZSBtYXBwZWQgb25jZSwgd2UgZW5zdXJlCi0J
ICogdGhlIHZtYSBjb3JyZXNwb25kcyB0byB0aGlzIG1hcHBpbmcgYnkgY2hlY2tpbmcgd2hl
dGhlcgotCSAqIHRoZSBiaW5kZXJfYWxsb2MgaXMgc3RpbGwgbWFwcGVkLgorCSAqIG1hcHBl
ZD09dHJ1ZSBtZWFucyBhIFZNQSBzaG91bGQgYmUgcHJlc2VudC4gQW55CisJICogaW5jb25z
aXN0ZW5jeSBzaG91bGQgYmUgdHJhbnNpZW50LiAgU2tpcCB0aGUgcGFnZQorCSAqIGFuZCB0
cnkgYWdhaW4gbGF0ZXIuCiAJICovCi0JaWYgKHZtYSAmJiAhYmluZGVyX2FsbG9jX2lzX21h
cHBlZChhbGxvYykpCi0JCWdvdG8gZXJyX2ludmFsaWRfdm1hOworCW1hcHBlZCA9IGJpbmRl
cl9hbGxvY19pc19tYXBwZWQoYWxsb2MpOworCWlmICghdm1hICYmIG1hcHBlZCkKKwkJZ290
byBlcnJfdm1hX2luY29uc2lzdGVudDsKKworCS8qIG1hcHBlZD09dHJ1ZSBub3cgaW1wbGll
cyBhIHZhbGlkICd2bWEnICovCiAKIAl0cmFjZV9iaW5kZXJfdW5tYXBfa2VybmVsX3N0YXJ0
KGFsbG9jLCBpbmRleCk7CiAKQEAgLTExODIsMzIgKzExNzcsMjcgQEAgZW51bSBscnVfc3Rh
dHVzIGJpbmRlcl9hbGxvY19mcmVlX3BhZ2UocwogCWxpc3RfbHJ1X2lzb2xhdGUobHJ1LCBp
dGVtKTsKIAlzcGluX3VubG9jaygmbHJ1LT5sb2NrKTsKIAotCWlmICh2bWEpIHsKKwlpZiAo
bWFwcGVkKSB7CiAJCXRyYWNlX2JpbmRlcl91bm1hcF91c2VyX3N0YXJ0KGFsbG9jLCBpbmRl
eCk7CiAKIAkJemFwX3ZtYV9yYW5nZSh2bWEsIHBhZ2VfYWRkciwgUEFHRV9TSVpFKTsKIAog
CQl0cmFjZV9iaW5kZXJfdW5tYXBfdXNlcl9lbmQoYWxsb2MsIGluZGV4KTsKKworCQl2bWFf
ZW5kX3JlYWQodm1hKTsKIAl9CiAKIAltdXRleF91bmxvY2soJmFsbG9jLT5tdXRleCk7Ci0J
aWYgKG1tX2xvY2tlZCkKLQkJbW1hcF9yZWFkX3VubG9jayhtbSk7Ci0JZWxzZQotCQl2bWFf
ZW5kX3JlYWQodm1hKTsKIAltbXB1dF9hc3luYyhtbSk7CiAJYmluZGVyX2ZyZWVfcGFnZShw
YWdlX3RvX2ZyZWUpOwogCiAJcmV0dXJuIExSVV9SRU1PVkVEX1JFVFJZOwogCi1lcnJfaW52
YWxpZF92bWE6CitlcnJfdm1hX2luY29uc2lzdGVudDoKIAltdXRleF91bmxvY2soJmFsbG9j
LT5tdXRleCk7Ci1lcnJfZ2V0X2FsbG9jX211dGV4X2ZhaWxlZDoKLQlpZiAobW1fbG9ja2Vk
KQotCQltbWFwX3JlYWRfdW5sb2NrKG1tKTsKLQllbHNlCitlcnJfdm1hX2VuZF9yZWFkOgor
CWlmICh2bWEpCiAJCXZtYV9lbmRfcmVhZCh2bWEpOwotZXJyX21tYXBfcmVhZF9sb2NrX2Zh
aWxlZDoKIAltbXB1dF9hc3luYyhtbSk7CiBlcnJfbW1nZXQ6CiAJcmV0dXJuIExSVV9TS0lQ
OwpfCg==

--------------ALBAYeTYCeqQriFsrKlZ6ptS--

