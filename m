Return-Path: <netdev+bounces-305815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Es6gInlQTmp5KgIAu9opvQ
	(envelope-from <netdev+bounces-305815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 15:28:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 880F3726CAB
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 15:28:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=GZ8n7awj;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305815-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305815-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D123F3006027
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 13:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DB733ADB9;
	Wed,  8 Jul 2026 13:25:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EC62868AB
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 13:25:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517102; cv=pass; b=fpMjMajnSIUndP95M6Nmx+YGRxrBUy0IwHaMPiUyTcNqtfU8VYvPqzFDkF5mMAv44J2qj0iHHWGbMp6J5yVcdHRTcRnb/Kf37DcpCpk7nYZ3osoPTG44AgPMs84parQ7wjkaqhJQSYAJNaVMNuqi5XnHP4wvSlDPBflmt+5CIkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517102; c=relaxed/simple;
	bh=CW2i7fo0pWIUPuJSiYHXQ2V4W+okSr4LfTOZ+koLDdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZZCkFZAHvOSPT5151obUEhUQ149VLGspFgB5XYG3wZ4aIEZDlGea8vkUuvAXreZGIan3Qks8VdMHppzoTcYQj/CIWVZ3NPWBPS4jsQuyIL7okyAI/QBJ90FymGgWQS48ktikHLYZPiv7jr7LtPFtpRY0PtXLglr+ASHS75vaOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GZ8n7awj; arc=pass smtp.client-ip=209.85.160.175
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c167c58f2so3822561cf.0
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 06:25:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783517100; cv=none;
        d=google.com; s=arc-20260327;
        b=GU+k3D3QNDy0NjHrZ2pSUVjjtYKP2e6dNati70mvgayYfY3tAJ7sHPqFOmMNSSEffn
         WkGTe6h/SA1vqwnZ4wXH74E3Lk2BnKLTIRRO81Kpza8p6+28iTkogbGxybFGHS9l5UKH
         C24aV2FTDOtyRzp5jzsRaF8MJbK2CL9UH/sPo+ALqxlQ9Z+0ooDsrUzqE10+d1Qy8qK1
         xiZ8hK2bNzAiWAazARUM6a8ekwOZSeZ+zPigY6q8bVCnhZvFL2ZRjknLuZHwZp4wLycd
         NoeeqmpWFtBgxaIVaW5iAhtCG8RACsA+TTYlwX8jpax4Cp1BtAbWSBE/J9nYYH8nTK0y
         GmKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ch/nUQqu3dJxazOvqEujUD4Z4+uKmVKQLrbRPqE0hIs=;
        fh=KlCWNeHHciiIOIPDvc2pL5b8Zbp+7TkW6+2+7qELYP4=;
        b=Op2R3UxzX8ar0MoL9UXCWnzPFYsqnfRqJr2ckUkZelK+uxOYtGJ6GE7NhOLSVhCJwV
         eRM3clHXY9lCupucUXbFVTCZTWjWlWS28GRk6Np/VHymEQ6yHgN6sqoT45n2EIYEs8va
         wAPbIRasVtpYBnd2UI8Qauv6b+7/D90l8hwfLAEYRnsTMElZNRnaScgZTjUc3K3XT3PO
         hau9e+hg5EdgRPvf4SbvBo45u7e4Bin+xXcQpI8Pi59eZQH3G+uSTyiaFbbjnfHcwho/
         k00RK3jMeq6vSM6jdFBIgW0fjVA4KD2jgW6WXVRsjfWjbmvm6J5CLNONkv3iiRXybno7
         P1QA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783517100; x=1784121900; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ch/nUQqu3dJxazOvqEujUD4Z4+uKmVKQLrbRPqE0hIs=;
        b=GZ8n7awjMzB04UoG09oQMNyWWIz4nWXHJ9Hej6cp/C6P7sD7isP05neQtdp57GiBQZ
         S0xYz9k7XCp2GRghCuTbrZhChLY3SKNEentjLb4Fnm7Gj3YSIuMRs4G7PZiOJp4RdMt8
         cLM+E5VqXe88jc9q+ZHZ144qFJSQWlIcrMzGIOOe7hjaUlgaz7Xk2wxVgLaglsUwjCfJ
         mEDPfLN9EbD8IobQUeO9cumYK209ookg+8PQnV7Qdd4VFp3mNkCnuyj+HWj5Wf7LpkAY
         3svQv6mlZIctHpRe2szfzMxYsn8H6YnVkfu+L0g37WCwfN1F73CLfbQTSjrLQcaiyoLw
         w8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783517100; x=1784121900;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ch/nUQqu3dJxazOvqEujUD4Z4+uKmVKQLrbRPqE0hIs=;
        b=CiG9IvK3245SQLmjQ1CdubgP2TaI7J3/9dO/HGKVl4R3a6YIzeygFxKueBH1+L0fHA
         DaHh3VYHI3jSIY8Gy5o3L9MdNVbtE++PLdvjiZqjEYqv5cM0EqsdivyoP5J7niOMs1pq
         3lj4H7GcImxpZDcO7ylR32TxyF8DanYRRsWGDOWGGHKCi4nwmP/dnzj49HTzF/XSk0Rw
         q6Sem0bKSQyhONuMRqBUZQC7wM3ySpL19iX2xX7osKhOWRkGZ2SAo+oUlsWJncAWVl8P
         Au7OobLIkrxNqt69/jkXXzRXp4q9xAJ17llc1p4Qmm3EyfwEq3O2QmGdb5i4sPMXa9Aj
         YsAw==
X-Gm-Message-State: AOJu0YxGSnpymD+h16HTsbK17Sc0+z4nGCCmWzpDXOpGNWvToydJLO6D
	dxvJo8lsXQ323Ym2XZKRT/OCpAlsZn1KmZrZtllR6jWCtmZFvbnM+OG705Q6Jw6PoGJ3WWP1oG0
	tlIJrbbJgY8Y+io5OPJ2BfH/N8bCDZIsbMxneeKjO/4LL+OZfPgvbjYAgfeE=
X-Gm-Gg: AfdE7ckmMiWvG/AMWo88GGQQkjKxgE/WmeboWGkqhN4sTMjIweBjjX+qMRNm+pSYfJV
	PZS/nCZFOLylD3fjABPvEHGgpBAI6kuynNuIqQRIwQIkAS11JncqOHZhYSoDYewYwE2js/13HAw
	UW7cM81tN5PJ7YVE7DSa33u7OYUo7IBp3T6b1mKNhe2Muq8FRyzh0qlgbOBkC8WYdqSR3CjnFZT
	2wxQ8WszY6Wnq1DnZUVasUhRl7BLk0FySRYbobXboz/17uR/7/voIdZRBZRQ4ReSdepxTM+bLnL
	aAEZbOylRqrAfoCW0caoKT6ekUAHQkp0kt05+R5SMRBGb1SU3fueZgGV4MnEka3yg2UY/9xR9NA
	oLXhNUqg=
X-Received: by 2002:a05:622a:28b:b0:517:9003:e1a with SMTP id
 d75a77b69052e-51c8b2dcc60mr26600651cf.21.1783517099505; Wed, 08 Jul 2026
 06:24:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708123933.1303291-1-idosch@nvidia.com>
In-Reply-To: <20260708123933.1303291-1-idosch@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 8 Jul 2026 15:24:48 +0200
X-Gm-Features: AVVi8Ce34S2-Vb-buoutlV6ioNGoI5aiFjFLLp7OHBokposEbGcnDFi3bVn_x-I
Message-ID: <CANn89i+VjCxn=ymHOps34LZwg0wpn-Xd-=C5pLxuv9_O9uvJUw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] mlxsw: Make the driver ops-locked
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, petrm@nvidia.com, andrew+netdev@lunn.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-305815-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:petrm@nvidia.com,m:andrew+netdev@lunn.ch,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 880F3726CAB

On Wed, Jul 8, 2026 at 2:41=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> Make the driver ops-locked in order to allow ethtool operations to be
> invoked without RTNL being held.
>
> An ops-locked driver has most of its NDOs, all of its ethtool operations
> and some net device notifications run with the netdev instance lock
> held.
>
> In the specific case of mlxsw, the driver is not using any functions
> that acquire this lock nor functions that expect the lock to be held for
> an ops-locked driver. Therefore, converting its NDOs to run with the
> lock being held is trivial except for a small quirk which is handled in
> patch #1.
>
> The driver does not generate any net device notifications, so there is
> no risk of nested notifications of the ops-locked types. For the
> notifications that run under the instance lock, RTNL is also held, and
> the driver does not acquire the instance lock itself, so no changes are
> required in its notifier handling.
>
> Ethtool operations can be invoked without RTNL except for two operations
> that are annotated in patch #2.
>
> Lastly, patch #3 converts the driver to be ops-locked.
>
> A probe on rtnl_lock() shows it is no longer taken when dumping
> statistics:
>
>  # perf probe --add rtnl_lock
>
> Before:
>
>  # perf stat -e probe:rtnl_lock -- ethtool -S swp1 --all-groups
>  [...]
>                   1      probe:rtnl_lock
>
> After:
>
>  # perf stat -e probe:rtnl_lock -- ethtool -S swp1 --all-groups
>  [...]
>                   0      probe:rtnl_lock
>

We probably want to add noinline_for_tracing to rtnl_lock() and friends...

