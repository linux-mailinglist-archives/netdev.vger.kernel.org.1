Return-Path: <netdev+bounces-299990-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NTO7BMfeMWrnrAUAu9opvQ
	(envelope-from <netdev+bounces-299990-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 01:39:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77462695BE7
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 01:39:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=EJNWet8P;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299990-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299990-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EA15301FD50
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 23:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821CB48165D;
	Tue, 16 Jun 2026 23:39:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5DE401A02
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 23:39:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781653188; cv=pass; b=qwGZXNPuX2Q7rE8Y99Ys4+YbG3EpEokJSIdJfZ3DMDNfuOyjJwavlsK/SyRx6FNF/lF0NrqrF4zfMJ83Bbd0/dXtDRA6D1pKTSlrddA9pMWKNW/mqu77T2qxH3RuJJK1iCggkGg7rlGyVH9jlGNZU8G+K5w4POly2O3FTET4w/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781653188; c=relaxed/simple;
	bh=XmOobbcIx0izCgE120HJyOufL1h/F+Iy+jEL3VrEc8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cc/oYjydqA/UptMwltFhoqf2m9uuQST6appfgux7j92TOZaG/KpLcrZyNifqQf2xE8A8U5kHWvwSW7K1tNacthu/Rl4a78464YRoXxjoov6qj4DaibvISqQGApszrteHG82+Z93RaXfqQcuRXfMX02bbW9Z8XGEtBMl6UVxwAGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJNWet8P; arc=pass smtp.client-ip=209.85.208.170
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3965adfd75fso51093611fa.1
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 16:39:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781653185; cv=none;
        d=google.com; s=arc-20240605;
        b=KOwtGDiZuNcssEtKmzZDW9vN3lHgtOEl+LAubhZkMjnfR/CaHWb9YFmiSMRMmKLYxD
         Y63OGuUHqEXVSanmbp5cdHpPl/MBBFZRK8F94vxVSZwuBWa07e0caPdC7w06RIwvx7CS
         99Wqr67Swm2QeWVIvO8nsCNBXOBK70VGJTe4JYnz9SXIeKTGK1QXE3+E97jf3W9k8JZc
         rTcfjzCX1WU3+884g3xemWm0pTcFPu5DR8Wvs7lzp4jYwqYLuivoPrdBmSWR138CA1kt
         M//OhVEdmXRFgmlzKEudo1mGLlUpFCSCJNbedVccsPpK0qpebVBm7uIjRpBpIQ4erGTo
         NOxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mddNddDaIG0ZR96uwWDwfEtHxSh587LC2kp77pM2O+Y=;
        fh=X27qq2GhPng6b31jvb291uqc3PODtrN+BoTWsncfQ+g=;
        b=AFy/pzg+nrWNw9ebAocjT2QNTjWmhXWnh7zBAh3c1gnGKrCRVGmYvHFub/3Ot+uPhs
         Txe9zjZiHcuIdV5MSNHcDqEvbJE30pChzhsRO8OgfDwCBkf6mca65jcekTSwCfmNkleS
         jLQsazrqDjfBTcWU56h640kWBJ87TcNSQ40p+Eu3bEgbeh1NJSovBZmkYoRdYl3VbItB
         shM3AGQOIxwwSKw2EJItcr8qMi0eKdmjVEs66yguMD/pOtpQQIrCRXCDA023dBBSVmeh
         Np1Zq1/593VENdIwQ3SrYAaigXuuDOrVdwY+OtHELIXYIdU4IfBY+IV/A7AEbGCYcPhI
         c83g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781653185; x=1782257985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mddNddDaIG0ZR96uwWDwfEtHxSh587LC2kp77pM2O+Y=;
        b=EJNWet8PORn0GbjICOzZGTwvvWz00W9suPQmMQFcysTSY402Zaq3BlbI4NSAKTDeyo
         DjWoelX012UeWVKg2VVHKGXc8tPL3GwL3c+VEIYA0ptg31Wy2fstEJLG/PctnjmVJIw+
         Nnk5/cWsVNQ5dYpGEInUjNkWooAWGUE+L7IaP8w77+G5FfTuPiw7QLfeLTq4oWqvU2MB
         pAi/mv61jyjWGB5vO0mgwNtMHu7pZ+KNvkKinOSDSPJzPqDqFMxj9vSRrz32HXMbPmFC
         knMFNvrxsNcgRrWINdb4Jkj2iVP93Vj591AjfyFpoHn4DhXg7uuuedhSzhpWmwLWt10C
         s/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781653185; x=1782257985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mddNddDaIG0ZR96uwWDwfEtHxSh587LC2kp77pM2O+Y=;
        b=e4ZS3LlCS0r/j5437MvfA0oMbvEiTy1TKjWTaCoTVx+LfWcudjrt1dYp+qnZwcrkiU
         +U4TvCnVPIduuL9cPYHbEwhZQIwDYCA8q+1TBFNtvdWzpn7yNUEtLQFnXQbemw5ZiIGY
         IMhXRVlj/nC8xKZTaBUbK1S+TK4BVV8kCkpMqoiRFlqULjx3vBnKyjLBOb6WCtlhwYky
         2guyw3V3JCkyirkhNh9DPCeLqLtXp9eQ2yR9v9vNM2IZC1OgXR1wnt7Ic3yJiFVB1lYe
         AhkiEPXYhNLsHWTgovrPJb2eB3DViZ+d2Y8AK6xHKwLhO0QJ4uD0vBlyK41+WklBdRxV
         8pPQ==
X-Gm-Message-State: AOJu0Yxt/FJEBVqgGw5ChZMbzb8ks7LbvZx5uXHckeEduMhsjO8mqhBz
	9TcRRmDqB/vwoAukeIUQSlUGSdXI6pegkxH5z0DJrOBBaEC9JLmxGYNILM9Yc9ZQkwxYAYiVAiT
	7UE/M8CBXQw4xbFepiIqchf+TjYPblV8=
X-Gm-Gg: Acq92OEDL2Va3iGWyWp+4tvVfWnclKvSXtpciJjV5d3H5b8vXOwoCBkaTao0dLKOrQe
	gJcjV0RFfenE5cbF+E+ulXBDXqjTwZKNaaW6dHCruXoE/fJAf1vouiXKzH9T1TO5fvWsUNc0kbh
	PeJ1XUSBJe1eelOljPEn6dPT1dv8WcQw/8a6XxQhgrf85v8JZXfLp+KZRrtNrVsBdDSYJD7yQ5j
	kawf0R38e1UuJlmESLwES0bmabNAxuaxGk9HD5MCl24eGwMdTxWi/lPW0+fCZ4KRWkpvioiGPPn
	ObdomaoxFNh8m8ZyWvzphLZN40HW1kcMWd4ZYcLP2ze5D3y7zfnAprbf1sBNPiBFw6ySKEj5f3w
	uoM7XQLy2hFYEIoB5VbIR
X-Received: by 2002:a05:6512:2346:b0:5ad:484a:7862 with SMTP id
 2adb3069b0e04-5ad484a7a4fmr118116e87.40.1781653185179; Tue, 16 Jun 2026
 16:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616154955.1492560-1-tushar.vyavahare@intel.com>
In-Reply-To: <20260616154955.1492560-1-tushar.vyavahare@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 17 Jun 2026 07:39:06 +0800
X-Gm-Features: AVVi8CdpYLkUL8a06nTZS6Iw4aJCy3VW8vs9Sfl2Gzs2tGm4_uuSjPvxJq5RF90
Message-ID: <CAL+tcoDr0gtCPeGi1yOUtg+ZD2YxEbjAy41LBgG63b8-=CStcw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] selftests/xsk: stabilize timeout test behavior
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, stfomichev@gmail.com, kernelxing@tencent.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, tirthendu.sarkar@intel.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299990-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tushar.vyavahare@intel.com,m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:maciej.fijalkowski@intel.com,m:stfomichev@gmail.com,m:kernelxing@tencent.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:tirthendu.sarkar@intel.com,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,tencent.com,davemloft.net,kernel.org,redhat.com,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77462695BE7

Hi Tushar,

On Tue, Jun 16, 2026 at 11:50=E2=80=AFPM Tushar Vyavahare
<tushar.vyavahare@intel.com> wrote:
>
> This series improves AF_XDP selftests by making timeout handling
> explicit and fixing sources of non-determinism in xsk timeout tests.
>
> Patch 1 introduces test_spec::poll_tmout and removes implicit
> dependence on RX UMEM setup state for timeout behavior.
>
> Patch 2 fixes thread harness sequencing by attaching XDP programs
> before worker startup, removing signal-based termination, and using
> barrier synchronization only for dual-thread runs.
>
> Patch 3 restores shared_umem after POLL_TXQ_FULL so test-local
> configuration does not leak into subsequent cases on shared-netdev
> runs.
>
> Together these changes make timeout handling easier to follow and
> improve selftest stability, especially on real NIC runs.

net-next is closed, but in the meantime I'll review the series ASAP.

BTW, another thing about selftests I had in my mind is that are you
planning to work on this [1]?

[1]: https://lore.kernel.org/all/20260520004244.55663-1-kerneljasonxing@gma=
il.com/

Thanks,
Jason

>
> Tushar Vyavahare (3):
>   selftests/xsk: make poll timeout mode explicit
>   selftests/xsk: fix timeout thread harness sequencing
>   selftests/xsk: restore shared_umem after POLL_TXQ_FULL
>
>  .../selftests/bpf/prog_tests/test_xsk.c       | 96 +++++++++++--------
>  .../selftests/bpf/prog_tests/test_xsk.h       |  2 +
>  2 files changed, 56 insertions(+), 42 deletions(-)
>
> --
> 2.43.0
>
>

