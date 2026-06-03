Return-Path: <netdev+bounces-294713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b4BUDegHIGqPuQAAu9opvQ
	(envelope-from <netdev+bounces-294713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 12:54:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EC4636BF5
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 12:54:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=J8idUhXd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294713-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294713-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8761E302BBC4
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 10:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFF1392C4B;
	Wed,  3 Jun 2026 10:54:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C4C37C930
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 10:54:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484068; cv=pass; b=YBvGnPmjEXnf4MzGR34S5Vo6aW9jpyIKhgClIfGTHGkkhTPVMPx0ofv+sx+DjZkeMK3eJASBLDN3u0ahlDBiU0wbjtdcYkUijSF9yMw2+aphbxvWp/eDsMo2zhMLjaXGbr5iKAAa+cxNKIPWLcmyDl2lhRdM6BLsLtLQtIdG4ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484068; c=relaxed/simple;
	bh=Y3I/7oXMVk27LTSdFlHetaQx/O0ckeHoTmtjYebA7R8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFcv+D4Odqa7NZmTA/XwrFWa2MQMknO0DOKh0Py4a+31fzFnpUZs9iBDIDfP59h871pFelEKvVZ8pratQVxIqYb56fnjUQYi4El2uAF2BQjNPLqMJPV9w5ETl/M6dfp0GZ8qXlbURzLgRtfS6YIP/6REnEnadDwsKg1OKsXocUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J8idUhXd; arc=pass smtp.client-ip=209.85.222.179
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-91587626a3eso146379885a.2
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 03:54:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780484066; cv=none;
        d=google.com; s=arc-20240605;
        b=fRPzZn4zfeMPw/rYevNYBeNdZBum0kEB/Kwmo4rWc+33zIUwi0cC9n3oBRMJOGnkvj
         JLMzRaD7+o2cFLXlfohpe4SM0Jidq9fKIi1UCP9KeqW1ApM3Jwzk4tRUeta2q9g5a3k5
         g5oZ6fRalPqqNanv9UCP9CF3Jf19AzzbsokyIi1nlKEioE+ToxgWLql4gYowDZPuBPtb
         lVxWOGDQFe5z39cTw0ojc9C64IEOFCoDdDy0SkC/kXjhq8SQYXK3rgGK8E7uJFJkAlNJ
         CZbKV1VoJCno784f5+oaivTd9rspyvlldo0bPRfFFa6nOPWv4OqDld+rRItafcUFRtxp
         lyGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y3I/7oXMVk27LTSdFlHetaQx/O0ckeHoTmtjYebA7R8=;
        fh=6KSv5ju2vVg6iOcb9f42BOBiXwv3gcCIDo+VxzmVeaM=;
        b=gHgzAL0I4pYkqXaurhrqIWMmmNfGqrcj8B+UNTjUHXDpHL8KyDgbOSBYL/Hg7nTnx/
         QZ4SJQjG/EFWC2SSi4bWKW613XKfSNgL1n9y3ep/heibHhxZomsQ1kdZ35sL7W0Esd0C
         cEpUKh5fuZ2B7B7eSn3mZ+BS6H6JRj/dyrXa94LWuujFCFPj5ILMMEgjXL3UF94gH3W7
         z1eizhGhST9iNX88aHNRhRmpjiWI34XTJYvE7477srdDDepIHxJlSHPTO0UmmsZA8XDM
         q2/Ha7O/wD5a0K0n/IT2Wrb650NL+PsTN3RsbJ6q7esedMbGnjyccC3yxPAVOFpVZUYc
         JD0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780484066; x=1781088866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3I/7oXMVk27LTSdFlHetaQx/O0ckeHoTmtjYebA7R8=;
        b=J8idUhXdO3SerbZ82k0xYGAtm7m/7/jq5uTelJpIZmpSK+oEZSfW7jma81MUvT6+w9
         I5dr2fDFCYymXdVcHi2OkwOnFKFHZZ7D2qWliJUaklj59utcu/V5w8y9Tw47/AT5/pMM
         YoY5LXie14VmAhSi0l1OwDnCbtWh/my7vua5Y3+mk3dNUkSx7U44LttN3i1qncFeOKgp
         2+xhkvWHktYTbIq/nF9Hsu9mDSfja4hakTOiirmj5Gs0aAudfdbZZTsyoFrQffuG2kT/
         45cF1RppHsm9IPozS19fZTQfxScPlhlfbrShxhGeetgBLaBxwDmxctJ7WcBO+opPlkqc
         Kgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780484066; x=1781088866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y3I/7oXMVk27LTSdFlHetaQx/O0ckeHoTmtjYebA7R8=;
        b=G+GxZbjgx37rBri7TKPhJjsSHjgGjlxv7smhrUQbg+OMQ+SSjUyO6QmueSt/CGfiXb
         eDmB8LRZHaxQ4vO2u468bFNFPiBUSDZ8xwMcahknS4DYFfMdBg2FyqcXKaoSin6o3IpB
         Z4jUIynlNOjs6Rrx6OD5izI2Z+mPJgi6U2Ca8he29s8jqubQzovF48cNRiPLgEFbF18s
         Wuw0X8Z3YfwMhVLYa7GlZVf7GF+mS6iuo3yWn//A+sViHqaGdkF9fXoZqjUu7LNpgWB/
         A+Bb9EHubGvKioVtTaRGT07dbw6e439LMdkqI+3ovVDtav44cHAyYgONx9ghnxU2czvJ
         0t7w==
X-Gm-Message-State: AOJu0YyUprSB9P8ERqGf56iIl33KYQLP+NNIFy4U/Z7n1+5qzXyWHaBu
	QcNIsJlE+lPpYuJv5+2MTI2Z8DSK79AhW9aIeamPr4jJGK8kHBgU+BS1hjN585uaG+yBnv8xe7d
	wTQTbYP6gVOKLELgTnadcqXqroURD6BeD/8hAeTDk
X-Gm-Gg: Acq92OF+QgANOBadUL6mzjLDF7OAUxdmKpdmmNbz7vgCwmVhG6rNYAjqqUomQ2q5PKp
	yF5xFwcSzX4zN4BJWrBvfVP33DCy5BDC8FQcCxMdt4P9WyEuJ972x2BnPibFWwU85g/xBm/D5bc
	RRALMK6cm3ZuyUujmtFiVmfcr1iP3ChaJ3D0HTXniMcVjp7EZUOhglILuYx3aFTApmNaosDY7LU
	Uaa2ULY9VTLSVQcbnyA8VqjfZHYQanRpKAasJVDBcDQy2ID2ogtWklO+L01hb7rpdj1/LEl6Hh2
	+ICz29Z/FluqCUmKMM4+aCn4M9TlBtrBPvMK8KEYkZhZ6Q3ng8NIGeZxhxbaurFJY3K0JlANAgQ
	MsMW20scmzbcHxY7NMesh9mWUDHu4hQ==
X-Received: by 2002:a05:620a:2691:b0:915:8bf1:bb10 with SMTP id
 af79cd13be357-9158bf1c98bmr376434985a.10.1780484065563; Wed, 03 Jun 2026
 03:54:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603101811.612594-1-idosch@nvidia.com>
In-Reply-To: <20260603101811.612594-1-idosch@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Jun 2026 03:54:14 -0700
X-Gm-Features: AVHnY4JggYM1FlNC2qFv79-XVXXKA-ldey1iaEZ1jq9vBDJy20CMRSbZQ00F0o0
Message-ID: <CANn89iLkCouYPvCTFxT1scP+hX8BchfLKpXtjOTLNW-gYO8e1A@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: mcast: Fix use-after-free when processing MLD queries
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, leo@depthfirst.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294713-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:leo@depthfirst.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:email,mail.gmail.com:mid,depthfirst.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 97EC4636BF5

On Wed, Jun 3, 2026 at 3:19=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> When processing an MLD query, a pointer to the multicast group address
> is retrieved when initially parsing the packet. This pointer is later
> dereferenced without being reloaded despite the fact that the skb header
> might have been reallocated following the pskb_may_pull() calls, leading
> to a use-after-free [1].
>
> Fix by copying the multicast group address when the packet is initially
> parsed.
>
> [1]
> BUG: KASAN: slab-use-after-free in __mld_query_work (net/ipv6/mcast.c:151=
2)
> Read of size 8 at addr ffff8881154b8e90 by task kworker/4:1/118
>
> Workqueue: mld mld_query_work
> Call Trace:
> <TASK>
> dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
> print_address_description.constprop.0 (mm/kasan/report.c:378)
> print_report (mm/kasan/report.c:482)
> kasan_report (mm/kasan/report.c:595)
> __mld_query_work (net/ipv6/mcast.c:1512)
> mld_query_work (net/ipv6/mcast.c:1563)
> process_one_work (kernel/workqueue.c:3314)
> worker_thread (kernel/workqueue.c:3397 kernel/workqueue.c:3478)
> kthread (kernel/kthread.c:436)
> ret_from_fork (arch/x86/kernel/process.c:158)
> ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
> </TASK>
>
> [...]
>
> Freed by task 118:
> kasan_save_stack (mm/kasan/common.c:57)
> kasan_save_track (mm/kasan/common.c:78)
> kasan_save_free_info (mm/kasan/generic.c:584)
> __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
> kfree (./include/linux/kasan.h:235 mm/slub.c:2689 mm/slub.c:6251 mm/slub.=
c:6566)
> pskb_expand_head (net/core/skbuff.c:2335)
> __pskb_pull_tail (net/core/skbuff.c:2878 (discriminator 4))
> __mld_query_work (net/ipv6/mcast.c:1495 (discriminator 1))
> mld_query_work (net/ipv6/mcast.c:1563)
> process_one_work (kernel/workqueue.c:3314)
> worker_thread (kernel/workqueue.c:3397 kernel/workqueue.c:3478)
> kthread (kernel/kthread.c:436)
> ret_from_fork (arch/x86/kernel/process.c:158)
> ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
>
> Fixes: 97300b5fdfe2 ("[MCAST] IPv6: Check packet size when process Multic=
ast")
> Reported-by: Leo Lin <leo@depthfirst.com>
> Reviewed-by: David Ahern <dahern@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

