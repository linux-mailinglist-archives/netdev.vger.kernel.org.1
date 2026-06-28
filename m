Return-Path: <netdev+bounces-302389-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 40fLFxoIQWp0kQkAu9opvQ
	(envelope-from <netdev+bounces-302389-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 13:40:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B29606D3B1C
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 13:40:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=oSTAZ+7B;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302389-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302389-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B27E03014C36
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 11:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCADB3A3E95;
	Sun, 28 Jun 2026 11:39:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2322F37F73E
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 11:39:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782646789; cv=pass; b=EQRuHXXBHF2r5UCJKZ/rvafapsr+QWk+GfD5x9Y+wiTzjz2ZvMNv9nL6IkUkRvNWeQ70MZqVGmGn1JEWCyBOC91NYm8h2cFejq2PXgWrL2GB9RB4v3DpEO1XPm0KE2OUtnBisxAbS714NDO9QiSiGj2n3ivga1eJxhLVH7wDHbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782646789; c=relaxed/simple;
	bh=d498hBMWdU3yNFxeg0vqz25RIl2j1GJoEg3MDJBpWnU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bBy1MU+VZaPl4w4wl2pkT7nDqiAKCO2nGcAbDRZMFHphORkaoy2c60u/sTKGrHVvaGATI8o+NroRG5mLRd4NAT2neln+r6bueDyOL00b0D0BoHs1b9lAD8QUoeUwp4q6F07zN9u+ITRsNbefGhQvZxXT9/mWQAr8OF0MttqRzPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oSTAZ+7B; arc=pass smtp.client-ip=209.85.221.51
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4624a44e152so2137986f8f.2
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 04:39:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782646785; cv=none;
        d=google.com; s=arc-20260327;
        b=giftAJy2Tb0bacfcq3Vi0jqGc/4x5wD/iZa5VC5PQf+dT+tRgM/xez+yPP7bLH3rg+
         HrFLErSG8RJM3kHNayJSy4594SeFzEqtOxMA7LrAqYfCgcwE6tUPgLw5rhZRgecLsu2J
         xqds8XcJs/Ufs2l1JKVr1mjZvWhg0npyco/MAssgtW079kMrI7MUYIPO+rMF2Ir6nKTQ
         2c6OHy3n6guiZqCQf1Sa5zkGo3bdUIUiDv/e2e65ozG1eOn9KxtkgCQgwQvSrr74xMHM
         C7hv4de/1vG4o94iD7ATQLNgpH5/hQ6xWLDTsTI+YZvwlNxYSBJuCJUYXzHc1PoC+5IZ
         pCww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=1k0VeFABvfpPKot2iuI8Yf+iW1BODubQlFUp6DJBWSQ=;
        fh=8MK+xCPUZSuaN4/lOJfMiXVqCtQCUbgNI2CFLqxGkcg=;
        b=SH5ESKIiteVLp/EH8LXfATh2H58qNP0I9SphUp2whV66uHoQXY33Y+X6Rv9GrLXo/8
         K/Ob0WzwQxpwlpc7KG4cMC6/vDA4NwtV8SfN/PaaC7/By8tyok+fn9KvfF1Z069Nr9ER
         EFgNfrtbafT0a4OvZX3vp9B7wNmKoYlEKXzNZgPKV7TjgjhlvY3JrgTXXNGhTl7e93T8
         fO+kVsy2CQ2w4ZeVhjkKAF3ktqZuOXXDnnlpoYMf6aREe4Y3s5IO6CzN0LlfOPKc+lAA
         Mf4npXxyDqaPMvVF31qMOb78q3oy8kchMriwVJS7UhswQVFGQzFYvE9DKr8hdRTYxWhH
         0yyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782646785; x=1783251585; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1k0VeFABvfpPKot2iuI8Yf+iW1BODubQlFUp6DJBWSQ=;
        b=oSTAZ+7BUFaCqqvsuzotB8ngAQTb+rEB9zl8svMjzjB7b5h7hasER2XV466r4ynW2h
         aujKdUJNkJRAstFCxCptghu4IjH2l8NDqPEgvYnW+aAySXIuqXSRGUYLgMHyY6bOiYbF
         /w/QeRDgzVwUpr7bmoaVPu9yjR0vLM3259X2FTlgdre5aJ2+F4FaKK73xC63oWiafR+G
         W9OsuJh9SQ24W0GxgiJTSzUE5O+6gTImi0qVfS/2bfhgtN/X4zwfDQyTiW1weaiDKL5L
         tQBoYpfUXauZ+RNN+zeiYOnXaJlIiGuYIZ9AZTDXf2NAjj/N8pkwVT87FTxoT32nXMG/
         r+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782646785; x=1783251585;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1k0VeFABvfpPKot2iuI8Yf+iW1BODubQlFUp6DJBWSQ=;
        b=ZZbFZWR61asoJ9LnA20xaWnfJc5ZF6m7SLYQN/BL3Iife4EMLXyXRLarPCtNy0h7Pj
         CJ0bXgYF939j6sHz6L3CYnGAaa6EMM4GXWnP5BC6MJuNuRm93IPUZtLkxK/wEAsLtOQ0
         RMiOaafGJ6HComjMQRNms76d01texWBjnbOibfifQEEJXjjZMHd+FChZwLGAYkU1Ex1Y
         ZnLM14OcfoT++2m8jcSbkhtqzAzOKRqmbqSMK0rO93lqJ1MZdfuFkfUrmbhyBCjgnmFG
         XVUQ30aZ26f6p61mjnjiFcNoLgugYpoZ8/JCs+Od6WjG0/jgunQG0eWkIgX6dVrtkN4A
         WnwA==
X-Gm-Message-State: AOJu0YxTzkf39NGoI9LsMjI3DueHNE7In7TuceXW1A3FJ0JZPW807oDk
	sITJxqbxh3FlEXCoZjQ1PhRSWu95Usq1BawiFw4y2TIy8y+i/iDW/bHrkiKRgSK7BGZYeCMNTGQ
	BZIlcKhqGRXpBSoEESt1koIfnmfvM7USd1HCzwAM=
X-Gm-Gg: AfdE7ckjtj4/arGib1y7UM19PxifBtB7kepDCXPuK6pKUkdme8nt3XwQtOEuIbbMEhg
	6bCs7PheuF5y8MxgP8aLNVsFE9wvM5d39T0rq/s9UW6Hle6fulK8nJ+mRYHRIkZhH67xQNeHtPQ
	H44ba5kl+T7IJ1qI5f+nc1+KlN+zUzXIJ0uoTEpBYykyfXJySW0WNgapY/PkhbChHwNckXXtYjM
	4ZsvK1dfwOtOIOoTbYgWmXsrQAXbKxWTTxKArSmx3liFACPMBHMwmWxz4x867b8hOFl/A==
X-Received: by 2002:a05:6000:40cf:b0:46d:1433:77ec with SMTP id
 ffacd0b85a97d-46dbf021840mr22541235f8f.2.1782646785414; Sun, 28 Jun 2026
 04:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Masashi Honma <masashi.honma@gmail.com>
Date: Sun, 28 Jun 2026 20:39:34 +0900
X-Gm-Features: AVVi8CfDJaopmWM8eZVww041Hj-U2h62NQOVb61mCb6UmG7XUvpGHldL02uI0LM
Message-ID: <CAFk-A4mE9Jweo2hfX7y_85xbPyt0FqpMT1EvqX1OcYZ=LTLgRA@mail.gmail.com>
Subject: [RFC] xdp: add device context to bpf_xdp_link_attach_failed tracepoint
To: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: leon.hwang@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	kuba@kernel.org, hawk@kernel.org, andrii@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, edumazet@google.com, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302389-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[masashihonma@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:leon.hwang@linux.dev,m:ast@kernel.org,m:daniel@iogearbox.net,m:kuba@kernel.org,m:hawk@kernel.org,m:andrii@kernel.org,m:rostedt@goodmis.org,m:mhiramat@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[masashihonma@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B29606D3B1C

Hello, I am re-posting this mail because I forget to add [RFC].

The bpf_xdp_link_attach_failed tracepoint (added in commit bf4ea1d0b2cb
"xdp: Add tracepoint for xdp attaching failure") exposes the netlink
extack message produced when attaching an XDP program via BPF_LINK_CREATE
fails. This is useful because, unlike the netlink attach path, the
bpf_link attach path does not return the extack to userspace -- the caller
only gets an errno (e.g. EINVAL/ERANGE).

We would like to use this in Cilium [1][2]: when attaching the XDP
datapath program fails, surface the kernel's reason (e.g. "single-buffer
XDP requires MTU less than ...") in the agent logs instead of an opaque
errno, so operators don't have to inspect dmesg on the host.

The limitation we hit is that the tracepoint only carries the message
string, so a consumer cannot tell which device a failure belongs to.
This matters for two reasons:

  1. Correlation: with only the message, a consumer cannot reliably
      attribute a failure to a specific attach, particularly if multiple
      XDP attaches happen concurrently.
  2. Scoping: a consumer watching this tracepoint sees XDP attach
      failures system-wide and cannot limit them to the devices it
      manages.

At the call site (bpf_xdp_link_attach() in net/core/dev.c) the net_device
is in scope, so exposing it looks straightforward:

  TRACE_EVENT(bpf_xdp_link_attach_failed,
      TP_PROTO(const char *msg, const struct net_device *dev),
      TP_ARGS(msg, dev),
      TP_STRUCT__entry(
          __string(msg, msg)
          __field(int, ifindex)
      ),
      TP_fast_assign(
          __assign_str(msg);
          __entry->ifindex = dev->ifindex;
      ),
      TP_printk("ifindex=%d errmsg=%s", __entry->ifindex, __get_str(msg))
  );

  - trace_bpf_xdp_link_attach_failed(extack._msg);
  + trace_bpf_xdp_link_attach_failed(extack._msg, dev);

Before sending a formal patch I'd appreciate guidance on a few points:

  - Should the tracepoint take const struct net_device *dev (consistent
    with the other tracepoints in this file, and lets TP_printk show the
    device), or just the ifindex as an int (simpler for raw_tp BPF
    consumers, which otherwise read dev->ifindex via CO-RE)?

  - For raw_tp consumers the argument order is effectively ABI: prepending
    dev would shift the existing msg argument. I've appended dev above to
    keep msg at args[0]. Is preserving the existing argument position the
    right call, or is reordering acceptable given how new and rarely
    consumed this tracepoint is?

  - Is extending the existing tracepoint preferred, or would you rather
    keep it as-is and expose the device context some other way?

This would be my first XDP/BPF tracepoint change, so any direction is
welcome. I'm happy to send a proper patch once the shape is agreed.

Regards,
Masashi Honma

[1] https://github.com/cilium/cilium/issues/40777
[2] https://github.com/cilium/cilium/pull/46546

