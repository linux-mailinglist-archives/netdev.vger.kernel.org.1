Return-Path: <netdev+bounces-304231-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zSsBNkGWRmoaZQsAu9opvQ
	(envelope-from <netdev+bounces-304231-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 18:48:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7582F6FA90D
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 18:48:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZdqqvMX1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304231-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304231-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 052F930302D1
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 16:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BB0349CF2;
	Thu,  2 Jul 2026 16:39:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C12344D8C
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 16:39:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010353; cv=pass; b=mPx2n2p5d4UHSVtmeCB+KZuiOEktfOTzypV70Y9frPcQSWi97HsWKfso/qjB+046+/IPwEky1wQaYvFK5KJDYmY4QPNREtA8KFwbBa+pzbmg38vQeQeIhN2VMdirwGWbWbEROybEh36R3241L4iOM4RxBOthf83qQ2ApHNYPiKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010353; c=relaxed/simple;
	bh=kOZ8synxEF/3k4EYSZuoWFK5xyfsCIntb32ef8ucf3k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=hMQC6ZyEoUjeTUEt4aww/FkVevXzqA88/fOdGtSQRrEvEYO/g4fnD/MI7RaeNQDcm6mYEGnRtxdsIK5CTfjPpvVuXUJpXRsiLcdwNlR5Be3H0GdUlRtg9OA8ut1Mfo/V2Mr+Kltym1TI/Yb8kIPPM0B8jOwW4AZ5X5jHdrY1f64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdqqvMX1; arc=pass smtp.client-ip=209.85.215.179
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso817217a12.2
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 09:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783010352; cv=none;
        d=google.com; s=arc-20260327;
        b=jdc/ffqbpJY93/UVv8G9JClX9UJVUJsUI6+vByCnR44SU3tdiYN2BMGp+SQbR4T3xz
         KmuIRFUYMrkA/oQhQs7jAM1+dIDWFAqu8rEqWmb2pJj2z4w4aASY2xximqyDpG2m8Uhy
         EFsqwSkHgYwJRtQairFpfPiBO+2U4L6hWETXHv+xt8iBSOVSSNjm0VDH5BQ+4C9n/BuV
         DEvZycuE9SY9JYGtAlvmhP7kFbC91G0oAtI3NF+Sc9QdxIsTnQGbNTfpuiJ2uqp6x+rl
         qmcB6GPzYbYvHIkcC4V2GIncGUFabYFDHyvM3/YU7+02ypCzHkgJiwn2vi2TDgx+msSX
         u2FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=HFGik6+4OsATJQFBbFq4zeNGr+l450c3fMwz9itVayQ=;
        fh=LA4LcAFJW1hdgErMl9J5PiNYKwHmwZGVLMslXPNJDxI=;
        b=BGOpUNz9Z0j0z/ho/fVsP2lLk5T+043YcJQLFbaVWmg2iwK7TCxpkJtqsVAZmrB+Pr
         RE1VxnvQma8QIbI5cfPEtMoYr6x+akz7qtWTXcYW1iMxsLkUPhNKyVqLVKFjhoXs0RKu
         sWrU8fP85Co3y9MGQpKAyGpzmcMtL/G/uShb2A6fLVApEJMS1j0DmlhEtsYuUBcCwPSZ
         9GYEg8ohk3mQFzeqHHsm0GTrIPa/fy32DvesnPIBE867M3WM7G2HLMUsdV4m6qyoXN5J
         sVLXmiLXAU+iWpmpsUlBLGHqwGwUuaUfgElddumeMyX1/rXvIH0pYE+3fDDa9NAOgujE
         OylA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783010352; x=1783615152; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HFGik6+4OsATJQFBbFq4zeNGr+l450c3fMwz9itVayQ=;
        b=ZdqqvMX1k7CcPYyRt2hWpU+h7WSDpkBEB4mhJ1OEJFG891v8wcrJe01IQOCwdrzRia
         FVGYOGeDArSn1ySn4uV6aN6HpyCdwnkf8JirlSTk3RlLwNxrMrKuv82T+/KWkaDm5kHm
         gKd9wP/l9cDtmHQBlutjoOdnwYLEDiqvQznFOu5Isrst3bquEl/EtoYdNzi7JAcrLsO2
         cRne0wXr4Su2TtxzMY/QFeNf1onfspTFhTNypdEQVB4W6nbCa242rXhBvq1uDAedmtAG
         JsbmZX1dPsQ3hKMrIwcKC7zqKpKuMTDUaUsEFmqHREiF7rSxiPanHLvLbqoQBjo7dHlZ
         I1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783010352; x=1783615152;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HFGik6+4OsATJQFBbFq4zeNGr+l450c3fMwz9itVayQ=;
        b=EWL/1cCdzldlmLFu2Y8nsQLn1rGyxw4JUaL9y4JTLG5BM48Sq58atYzq7/fvXxrNcp
         qk9zMG9b3Dz2vf5DlHoj4wH0rQeW8qU5cta4PpK5cnS6KfMmkzdm/GCxPF8oZQxrhj5h
         qzy4wx1sn8YoNY1CWdNxmnTnRE/r+KtY936FlQqclRTLJkfR9gAupFGHbRLL/jSEust5
         v13MJU7pJ0rxhtxRtxD9p2nxbTuwDNn+DNV5w0EcepjkqwugPr3xZcBT1sTqJw0dVl49
         9r3AnmLUn7y5ikICH1eNOjgmd5sUxvsMKPvQ3uBOKNE1shIvyNn7qIFZQMMtJUDfgmKI
         5zFQ==
X-Forwarded-Encrypted: i=1; AFNElJ8H+hy8ohcnRsB9OJS7CO2kG/S7hczjKGJL2BJoxywxj3cQGVU1zoBGZCgwhYHpjMhP5ix9h+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX7n92ih/5km84Dp9xa/AK4bgoEGnbc65Q8vB/NLkg5ijCLtc8
	xk+MGINUhLs7COQ7x8jLhva7PAlmV/7g4Y8Wava/rmDA9w7m50ap7QQ/QcGOHipoTWL1hq/DSKQ
	Bt8KGHwEL19lDmEDL5bv1CprPH9YGAd0=
X-Gm-Gg: AfdE7cm0DdTdvScCK3rXhpdxcOsn8ykv7/PaKCZpURv3dz31IOGidIxeYbKKDNfuhOZ
	kE4uoGsshifZHFvk/aqhk+WySsseclIICQXrzmp8aDEDqcOwTyM+sCIs9jIKpe4wjSXaL6vZdw8
	BiymDyvLPee+LtV+pd0Xl3uIP0xmaMHe4WwTBlOQ8oSK9DCzSofFmAHkfOL2dkcsxZMZVFk+h8J
	7wQ4USw2iZ0TrfVhGt5sz8OkpGMWgl3TVI5W1zVNmkXjEQE+/0/Ed0DDV3RggfqFMvDmvd35xuW
	jgum2tLmbg18szeUMPIOnnNU8dLfGMaymJ2ldsPRc9Lcq+GPe0Mtbw/XaYVNbfG77Bh+lOuMs4V
	KY1VHY7PxhAbnuCWAK7FERNs+
X-Received: by 2002:a05:6a20:549d:b0:39f:2dd0:65d5 with SMTP id
 adf61e73a8af0-3bff4222b55mr7906831637.39.1783010351482; Thu, 02 Jul 2026
 09:39:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Jul 2026 09:39:00 -0700
X-Gm-Features: AVVi8CeLgejTui-Kppz8NKnSDw3ifQGD3gc9ZGh2g-tg_Ec2Wak7dGPaK2nnMCY
Message-ID: <CAADnVQKsM8iOGO3ZL3LgbWigOBBMrGbTYZ_k_Ktz=+cVkvRLXg@mail.gmail.com>
Subject: [ANN] Summer vacations and "Won't Fix" bugs
To: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304231-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7582F6FA90D

Hi Everyone,

The summer is upon us and many BPF maintainers are going to take very
long vacations "surprisingly" at the same time during July and August.

As signs on freeways say: "Expect delays" in patch processing and
please don't spam few overloaded maintainers and reviewers.

We see a lot of AI generated patches where human took AI generated bug
finding, AI produced a patch and human sent it to the list without
much thinking since AI "bug" sounded real and AI "patch" looked legit.
This is not cool. It doesn't move the BPF project forward. It's a
wheel spin and a noise in the long run. 3 out of 4 such patches are
wrong. They consume maintainer's time and distract from real bugs and
features. Don't be the one who spreads AI slop. Submitters must
review such patches first. Use another LLM to review it and ask "Does
this need to be fixed?" If it's a race condition and the reproducer
requires adding mdelay() to the kernel the chances of hitting such a
bug are the same as HW crashing due to cosmic rays. Typical solar
flares cause more kernel crashes in the datacenter than these bugs.
These are "Won't Fix" bugs.

Similarly a patch to fix a "bug" without a reproducer is going to be
ignored, because it's a sign that AI couldn't craft a reproducer and
description of the "bug" is a hallucination. No matter how plausible
it sounds.

We see newcomers sending such AI slop to multiple subsystems at the
same time (netdev, bpf, etc). It's a red flag and a sign that the
submitter has no depth in either area. They are merely forwarding AI
to the list. Such patches are the lowest priority and might be
ignored.

Landing 100 patches to fix 100 never-in-real-life bugs is not a
success story. Lines-of-code and number-of-patches-landed is not a
metric that businesses evaluate employees over. Expect more "Won't Fix".
Maintainers are not going to help you increase these pointless metrics.

Also developers who sent 10+ patches are no longer occasional
contributors they _must_ review other patches.  See
https://lore.kernel.org/bpf/CAADnVQ+TKKptnNB25V3=bcdybh5G6c2DyW2sYtXvyRaVnPN8MA@mail.gmail.com/
"As a prerequisite for merging a patch, the submitting developer is
expected to complete a comprehensive review of another developer's
patch of comparable scope and complexity."

If you don't review other patches and merely forward AI to the list
expect that your patches will be ignored.

Have a great summer.

