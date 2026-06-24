Return-Path: <netdev+bounces-301735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PTbFON0LPGq6jAgAu9opvQ
	(envelope-from <netdev+bounces-301735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 18:54:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 432ED6C0203
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 18:54:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=kAnOEHjT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301735-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301735-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 643D730AED86
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 16:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915FA33F586;
	Wed, 24 Jun 2026 16:51:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A1933F589
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 16:51:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782319896; cv=pass; b=rX+9vfL0kj33KLrRNkMLKWkTwlkgdH4n9QWE9/tBjN/LyM9fBmMvJdgxnJtiy1pihxjDRHo0UXxuWAOiubvauB+jgp4B3UimUwqT6m9+ryLAH3Br7HnQOOP3HQeT86w7tQ0Z/Lqf6kHoLtS8m5Ka7G6eBVjMPEuj1xHdqkVPt4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782319896; c=relaxed/simple;
	bh=XO7ayNyXb2pSZhnjhn46wUBhW5V/MLqoWWtgqnxYRbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tbA/2rrJVl5qQIjHPAUZsf2u+kvggvqj535uePv/P4DXSA/J1V2/T6womse86MF4amQbPOxl943rGuO8g0K+6KHXwabSz3nUimv7D5a+37uD9VPn4vu9XilLS0GII4Lk3IbT+o/xQhKH131aV0NyQIAE2Xs3ZCI1rrlbfxZr5vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kAnOEHjT; arc=pass smtp.client-ip=209.85.160.174
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51a0188b92fso12888651cf.3
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 09:51:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782319893; cv=none;
        d=google.com; s=arc-20240605;
        b=CnM8DCGS1wlUT8lb93gNYpvZIlerfzr/GkLxAIXAx5b78X23WlcmHMJMi/nO0UVfFs
         7hRT/cqFnzUkvImhQ1txANCbYm/y9uX/NFw+TeiW4OiwizLqg6T7R0+Kl82tfQCoapd2
         lX87P+0gpVn+2fmxOSmdeQVZ5q5HcyLHgaz4kGmlILvxU6ThbHuR21xiNZPBjAKql5MT
         BsL4mUXf2v5ZHseV57OZm0u9BEjaK24MBhgJxQwJaNo1UrlAJzM2t3yrLMsJJG2Zplb/
         CF8/yLgNddhSK2FL/yN2qmfgnuRcmsdR37dYR4UMVWb44bSIVWZm7+GhN4i98mLu/QVH
         bEmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XO7ayNyXb2pSZhnjhn46wUBhW5V/MLqoWWtgqnxYRbI=;
        fh=i1G1RK3FI1TTUntqGMeVkKaD6qX9gZPPxqh+laBDny4=;
        b=gslkAfWcEd88/GOK2CAhHtyhsd9IHpBStYK5tjmvDAbDeR/DBs9kptgfBuznq64Slu
         tANJj4O80oqGu6Z2rYCvcORAaBaIILNi+tChcqqd0a/U5RKbIEwZDe4ckRLCwcEdG/r+
         a6QcKXeaAJ17St2z1uuxb0qMrf86TjFoZ99AN7SbvuZ+qIZG9acah71sZWIFRdvAxOIK
         l3LevW4voHEhbTxchk4YwXGYBiU5SebR1+lH4HdEMLoDNlC7Wewu8ZmpGxkx4oF4L41Q
         bhvpRSo33dMo7zF8aurnS+UX3JWqyqc8gRj7KiSuDzzKqMfh1fnoM/6fojdtvYb+Ukc0
         sSig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782319893; x=1782924693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XO7ayNyXb2pSZhnjhn46wUBhW5V/MLqoWWtgqnxYRbI=;
        b=kAnOEHjTlQEtIBxZvXbN96DoHg/Q4Qh71IH7qbXDCDiYNAI34UZDD4b2hp0f6xWu//
         Qk6gdkTj1mIs6m/fZaZsnjhmXIR0VG0AYCcLVt9g+NaWJm1WhRg7qzBd+Nmsv8BWRT1o
         +fcnwwWL4cHJWPqwSJxPHiPgDQL8XBSLldnBJaUmBJqnNc+f/5ENkCB0q1kDfwwngsvG
         WSADxd508GTHo0X0Vnd9flqmJD2ezSXQiU5BbXTDMImdzh+qPfdin6yQshDmjcixyJXN
         qSOsF5ZlUDbn8ilC0yNbZzlRu6fh23JA1i8thyy+FEtujv6SpoWxXzr5/l4eIoLZavU2
         RaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782319893; x=1782924693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XO7ayNyXb2pSZhnjhn46wUBhW5V/MLqoWWtgqnxYRbI=;
        b=m3hMuRPcZATGJV9yAIK78rlcKFEwt/uVM71w4Eg3zxGh5P5zUtSR8ONPsSOkGxOevJ
         oNhWktsGy38NkzGPfjNj9XdYHUvFiwSiQxH8xdbqDpTvpuAqy+P1Ng6zHsbm6C2X9nke
         ZHH0tHEWiFw/e6vilE5M10RpMwNstsM52rtI7UX4mFzbvYzIKt/UafYwP5F6679929vI
         SE8Fr8t0Hju825W32NUaFrYn55QLD27OaVGTlmrj35YQOk0JpOOzKCA2+W8xSWpga9iS
         g3iD48QyQiwmD/Nz5Aj3ixZe5GoQ6+ixzly1AfXQPBujNBoWZPXiUTh585u9mdTbmb9k
         Ng/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8gFzRgiigXys884Ikt/rHV442qjdvTLGRldKhrBXM3fHBlmocuoWFb74/lteLsGt6pGe3JbRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsSjfO2eakO6lsjHJ12gKZHFpTPC1hnXej7+DEaSdPI+Hv7QML
	vFehxZwyI24JtbGGAnma70+gfm/F5TSvvVQuuyPcSFEH1WPDhe6uvWIyrOMu81cmpOy7FXRUoMc
	Gba+eU0QfwX9Ivl64y574bF7JxjpsewH94K7kbi8m
X-Gm-Gg: AfdE7cnUV+RxRaZ/0RpNPAV68r1AJ2JfXbhjiJ74v45IU75EzUVDrTLp3wRHGeqPN5c
	glhXzIu/+cTuM6l4oWwGY5Q5dT7yaqak2n6OsAJWDGIgeVK8XeBSP8zrQihTNdzOYFa1O4zo6FX
	SHBiiT2zoyC3SiYn+vzWXru2mWIuGck+vhXMLMzCd3griSmUBTCEQQnAGpdk16zTuLidiDxQelz
	M0fALX5S0KGsLBp20D+MNWGjkJzvgtmnvgKppzKNO0+bSp/UdlxRMKMm7B9k4BMdhTx4/swUWI8
	iVQpYHlVLGBtaraV1O3eT4R9+GwPs+RHcg/lIPesxV6g+RUGBquXJSXowYi4mKp/dRHcFS3y4R1
	Hg25hZg5hwxu71Nvg9vw5
X-Received: by 2002:a05:622a:2590:b0:516:de71:e21b with SMTP id
 d75a77b69052e-51a61d25db2mr61192301cf.9.1782319892258; Wed, 24 Jun 2026
 09:51:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624090135.95763-1-samsun1006219@gmail.com>
 <CANn89iKD=4_A+7K2erw5AZPnzvBrQqTKXJyfKN5ZfNpAYZ+y3A@mail.gmail.com>
 <CAEkJfYN4Uep_WEzZyaDGkW5p4rW+oVRqq2DgBt2xiYp9ARt0GA@mail.gmail.com>
 <CANn89iJ5wKuvKy=Ed-JkeyzKYaEoA_8S=mEMBicMjEPxLCY0Vw@mail.gmail.com>
 <CANn89iKhPmbJW_6DA1_okSGsr_e_Jz47qns-nFcZpnQZ-nAUOA@mail.gmail.com>
 <CAEkJfYMXsNuJjKWJ5nvvw0afSP77F0WWT0gfj2-sQM3VyZ0brQ@mail.gmail.com>
 <CANn89iKgwNmTZ98MW92VVgC5zPqtQDBFBFspCphKpS-5i6+-7A@mail.gmail.com> <CAEkJfYMZvy1XWuA_y13NfwXef+wUh4jaiQpkzHfr4=HDbr2HAQ@mail.gmail.com>
In-Reply-To: <CAEkJfYMZvy1XWuA_y13NfwXef+wUh4jaiQpkzHfr4=HDbr2HAQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Jun 2026 09:51:20 -0700
X-Gm-Features: AVVi8CcRtk3nZU-gjsk4_MTOebnjGiI-vE1_HHmJg05zWCSgjZ8Jp6c103Jm8_0
Message-ID: <CANn89iKMHnErYim5pcANAwbakk6VSRCxmJTC6V02xHpwoKiM1g@mail.gmail.com>
Subject: Re: [BUG] KFENCE: use-after-free read in udp_tunnel_nic_device_sync_work
To: Sam Sun <samsun1006219@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:samsun1006219@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzkaller@googlegroups.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301735-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 432ED6C0203

On Wed, Jun 24, 2026 at 9:36=E2=80=AFAM Sam Sun <samsun1006219@gmail.com> w=
rote:
>

> I tested the refcount version, and I could no longer reproduce the bug wi=
th
> the C reproducer. I think this patch fixes the specific lifetime problem
> exposed by the reproducer.
>

Nice, thanks for testing it. I will cook an official patch then.

