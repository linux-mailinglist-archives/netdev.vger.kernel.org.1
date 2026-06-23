Return-Path: <netdev+bounces-301362-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id weLJBoJ8Ompm+AcAu9opvQ
	(envelope-from <netdev+bounces-301362-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 14:30:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC0A6B717F
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 14:30:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=arBH+uTK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301362-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301362-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51A7A306708C
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 12:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589B83D647E;
	Tue, 23 Jun 2026 12:29:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F4F344DB9;
	Tue, 23 Jun 2026 12:29:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782217758; cv=none; b=kv2lFNFObocre7KHD5QbHk8ETreVhjQ3JylbKs7Xqd/k6RvTxHLg7ZWhlYzTrENVPVkWlj44W9nt2w0cQf1tmLv9E+Ykbdv1eW11O1OQiw801sA5xE8VhTRPt/iy/p3nNuNCObeP33uGBS+kNS+bqsH0Ec/zwBUQ9BBPD6HPr90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782217758; c=relaxed/simple;
	bh=GEHMk1MA6K6TwBF71zdNKyey1sfGalpW8VXt5R1gxqA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=htuiCIO4l12It4COfyK1Pz+4Uc02q1wA5zRssmTAG9EjAIBgNYVoQQWXYlSrdhv1us3TVYgfPdDLxaxfhiJwU/wW8p684JNE/QWsTusv++HwT4q/ff+G7KYCQOEJubP6ZJU5BrZrJEjaxuJ7YwRsrIiF2zHuRkWS9SLXCcyyOlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arBH+uTK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CF61F00A3A;
	Tue, 23 Jun 2026 12:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782217757;
	bh=GEHMk1MA6K6TwBF71zdNKyey1sfGalpW8VXt5R1gxqA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=arBH+uTKfknaykjzbwL1FfpyiT8xhOcMjL2AcHUXlbBmEENDHWaadoxrm535uPOOO
	 XE1iX8GbG/xZLN6j35b0pRrvXlkJfnZKaCVpgJFRm/FLUBH5qGezlPaMKrzjjNh1Qb
	 tXLXrOYGMoXE1yHnPqnjuA+JN1/8JlusNBl5903aDAhuRuyUvW23oZYRg5OudLMzkS
	 xKaJh2kOg7gMsltBBI+2tmXJ2fCa6aTJ4UYC9WywvunR6sTOQVsykYeUmdmw1mZVo2
	 ghY6sqNjOEI1tGem9MAlu8pLVjfB7g/bmLf5TAaKJh3xtZpv1ZNslXaEXfWDNTmNhB
	 7jx1ru3eoIcag==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alvin Sun <alvin.sun@linux.dev>, Miguel Ojeda <ojeda@kernel.org>, Boqun
 Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6r?=
 =?utf-8?Q?n?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu
 <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Daniel Almeida <daniel.almeida@collabora.com>, Arnd
 Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, Breno
 Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, Dave Ertman
 <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, Leon
 Romanovsky <leon@kernel.org>, Igor Korotin <igor.korotin@linux.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Arve
 =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Todd Kjos
 <tkjos@android.com>, Christian
 Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org,
 nova-gpu@lists.linux.dev, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, Alvin Sun <alvin.sun@linux.dev>
Subject: Re: [PATCH v4 9/9] rust: macros: remove `THIS_MODULE` static from
 `module!`
In-Reply-To: <20260623-fix-fops-owner-v4-9-0daf5f077d5c@linux.dev>
References: <20260623-fix-fops-owner-v4-0-0daf5f077d5c@linux.dev>
 <20260623-fix-fops-owner-v4-9-0daf5f077d5c@linux.dev>
Date: Tue, 23 Jun 2026 14:28:11 +0200
Message-ID: <87echxe90k.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:alvin.sun@linux.dev,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:mcgrof@kernel.org,m:petr.pavlu@suse.com,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:atomlin@atomlin.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:daniel.almeida@collabora.com,m:arnd@arndb.de,m:brendan.higgins@linux.dev,m:david@davidgow.net,m:raemoar63@gmail.com,m:leitao@debian.org,m:axboe@kernel.dk,m:david.m.ertman@intel.com,m:ira.weiny@intel.com,m:leon@kernel.org,m:igor.korotin@linux.dev,m:fujita.tomonori@gmail.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:arve@android.com,m:tkjos@android.com,m:brauner@kernel.org,m:cmllamas@google.com,m:rust-for-linux@vger.kernel.org,m:linux-modules@vger.kernel.org,m:driver-core@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:nova-gpu@lists.linux.dev,m:linux-kselftest@vger.ker
 nel.org,m:kunit-dev@googlegroups.com,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-pci@vger.kernel.org,m:fujitatomonori@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.dev,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,suse.com,atomlin.com,linuxfoundation.org,gmail.com,ffwll.ch,collabora.com,arndb.de,davidgow.net,debian.org,kernel.dk,intel.com,android.com];
	FORGED_SENDER(0.00)[a.hindborg@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[48];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301362-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AFC0A6B717F

Alvin Sun <alvin.sun@linux.dev> writes:

> All users have been migrated to `ModuleMetadata::THIS_MODULE` const or
> `this_module::<LocalModule>()` helper. The `static THIS_MODULE`
> generated by the `module!` macro is no longer referenced anywhere,
> so remove it to avoid having two sources of the same `ThisModule`
> pointer.
>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




