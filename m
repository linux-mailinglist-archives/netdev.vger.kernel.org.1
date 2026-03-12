Return-Path: <netdev+bounces-267138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBnjCPbismmWQgAAu9opvQ
	(envelope-from <netdev+bounces-267138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:59:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C77F275113
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88A5D3011F3B
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A973B2FD5;
	Thu, 12 Mar 2026 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJPPurVV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946243876A2
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773330869; cv=pass; b=sIpHEzbzmc+qqnO6SSYsmMWHa4fUnS0aiOz6eUyGT2f0RPqm8SN5Uj6rlA7D311nD5nR517KyhZ4vuE3/OlhEINFYyLIzfaWtqmlLIeqJRU8z3iIJ4FmvMMhB3R9d0afWEIau+utglRaMxhEiT/a9yVcVvWG7vV+ja/xLkScoHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773330869; c=relaxed/simple;
	bh=xRQ9RxoOagC+UbuuVdcPrUoQX/7LiLPSKHq71FYNf3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVwUoDAcBrUtrGj7MBrPPnBN0716bIduZ0Ao/rsGocLN167j9NE6IJr/Hd8M/4yYsU0UT+X3lgQo1KKv99YQswtApbNe/kPr1JylpuF8i3xNE9qiZ7WjT9b+HKkJTczB25MQZhy1ba/X+3Ip1Xq8auViLDXSsXNPe4VcVYGMKW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJPPurVV; arc=pass smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-94ddba39060so336754241.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 08:54:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773330867; cv=none;
        d=google.com; s=arc-20240605;
        b=Ysi8tJoE3SFgLKSs8GhxKXhMgfpUuXH3OvITWrq9tcaK+1hRAnXuukWYlKS9KPIaps
         K21KHl1VfesTUMT3lXkLfQRTOGVf1NdHBYGKl2o6k5uWX3fd5Z91jFlyJd3TWYEuRFDS
         NIEshHpmPOzixE1w4fslsWFPa/H4FhH0XK/sUe0+aotiugFoJYKrRElGJ4UuMCCyOmKY
         Rn8PUbDPzOOr86LJdni0FSTRdLQvBCDVXxypa+y1/+Vx4dz/A78l4b/TqZL/hRhLL2ey
         Sk748JvpmSgGzjqt9HGnQjIHdmRqmnK0yFzg+KU5/ARJGActccWIPi6/0m3Pa+v+AAIW
         MhDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+GW9HNl3VoMD61R2LszbWalRUfrPs8bujj+OuPBOZoU=;
        fh=oJ2HJxdvjlM1WaAYIFA7WnG+knjlX++j1MlbPjBTnek=;
        b=QVq2EFisRWeH6JpPAWGxTpkmlbslSoXadHK4SzNXiX3KJbkqjXPuFrkAKBgXZcvzuM
         6UAdk4X/d49xzFhd8Skz/W9tNS81jZlCkP8dNg9tpujw+AAWt7aJgMJRnajL9ZY7lcKP
         oVhCK92hosuBAE0kpAppA5qD1zUUfDxlEQMM0zVzdZd+uDpOLdIHUIFWQg7ra2U8iSM5
         9+fAeHEom5SL2niSYhHE/j3dBNV0k7mwd+Pne5huKxUd0VBRqIxCkxlk7448b2kJply0
         Ein4BmYTOK9VG7HzjlIwKYQTZNSNV2agsIIVr57x2Nxuz70o9RyQY9iHWar/lsmZwFfm
         U8Pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773330867; x=1773935667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GW9HNl3VoMD61R2LszbWalRUfrPs8bujj+OuPBOZoU=;
        b=DJPPurVV7GBCz9ALGvZiMM0n6gdQYMG/scLWMQOLjucK20KunPCgWJowDrXWi+i8Xi
         ZKZa0B1tizfDKNqgDJjGNYkpTHXht7X54wTiKeidfabYIxsO4EWctCSdEiwK3KpJ9kuI
         +/sgGlhjBP29+2LGAyISmYx5BNLAcjsyaI92J13KSWf6yPEfL7XDzOLyrGPOLurUWFI+
         G9KJmtjp10EiMzbtK0EImVi904chB2+LVIDYWFVbOP+Qpv64A0s3E7IU9GI3TlYpqF3t
         Kx6eUye1H4F+VdqdUtp7F4/5fx6t9mRUs7djPg4XTLYYruHzbJmRe0Xz13UZJSVuJCVt
         FRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773330867; x=1773935667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+GW9HNl3VoMD61R2LszbWalRUfrPs8bujj+OuPBOZoU=;
        b=kZI0GW84lL1uMrFh6M5455awTgn/WNpA7+Du0r0t2c41Lmt37C7pwGNr63JsrRRCME
         ykGwl/zGMTm09qwe26PQaH7K/AN9MqO5PXAQvXXgjgq9jaf/OH1prHVioaS8UgzYg7TG
         I1DftTyjmGHxc9cyo7/oUkK8AEct7d6sIzuz/9AxKCNJ53yiQ/qN+Dosa6bz4n6PyruG
         uZ6DdKb8h/k3EEzNMep/ujKJtbYaft/9/zhvufAErC8Eb7e8i7S80/Ho1M+F0BEgo4dP
         9+a65vYCCuY8INPHEJXT21rMgLony7bnyhH4Xr0YuqKgCtnEY59AoamKmfubxtWZTpyk
         3zkw==
X-Forwarded-Encrypted: i=1; AJvYcCUHw6kp4gLK6BDrXj9wxLpd+Hwj8Q7KxapMSdl8ulyt/5zsn2Rv2moutlljj9gu0AvRlc0T31w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLpecmFhoP8/UzJkc0jeX0vmecCLsbQdenZSmiNXh9AtID+EZ+
	EUMRlPrA6EkB7ugb1wGrFjq2HFmRVLqbdn0RT1v66oo/vG3Y28+qQqpPw85bAean0LyqFs/5Rbe
	+Fmnp2k6NHhZYUQLQDG0uIr0Y+z/RllU=
X-Gm-Gg: ATEYQzyHcNhE2ef60oRPs+5xes3jplsZoJz5bo+kqRPX9hpoflu03K6XkTrOINS0QB9
	jyfD1Gr3SQhfUIS4zCQpSXxY00xeW5GjafHh6tC8aTThIAMVNaDPgxQGKNXeAvfFwoZ7kgJoPOn
	q/Oe6c4v5K0Xql+BGwvHW6FlPDVi9SD3qJaWe7D3eJMfGDPBm+2vDQEFZeeH5drKom304leGmO+
	ypRiNriI8Rx6d2WI6034UPJd2zijJWDyp4foYqr8jmZcZaZVMBGbbaDx1a8Q7fboCZA6Zskh9RA
	ajOSiuov
X-Received: by 2002:a05:6102:1613:b0:5f8:e323:580d with SMTP id
 ada2fe7eead31-601deb4d094mr2688557137.11.1773330867550; Thu, 12 Mar 2026
 08:54:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303140725.86260-1-seanwascoding@gmail.com> <de652c45-9492-4bb8-a173-efce703b5174@app.fastmail.com>
In-Reply-To: <de652c45-9492-4bb8-a173-efce703b5174@app.fastmail.com>
From: Sean Chang <seanwascoding@gmail.com>
Date: Thu, 12 Mar 2026 23:54:15 +0800
X-Gm-Features: AaiRm530wpXoEJ0RfVzssU0-NmTo0KDz_Aq8_bT83Nj0JX-oY45ok05huyGafjM
Message-ID: <CAAb=EJViPvhD_ndONoU=OPcD_EXpA0Mh8500NJ9g9W_X0SpYRA@mail.gmail.com>
Subject: Re: [PATCH v2] sunrpc: simplify dprintk() macros and cleanup
 redundant debug guards
To: Chuck Lever <cel@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Chuck Lever <chuck.lever@oracle.com>, 
	David Laight <david.laight.linux@gmail.com>, Anna Schumaker <anna@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, netdev@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267138-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,intel.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 7C77F275113
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 5:47=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Mar 03, 2026 at 10:07:25PM +0800, Sean Chang wrote:
> > Following David Laight's suggestion, simplify the macro definitions by
> > removing the unnecessary 'fmt' argument and using no_printk(__VA_ARGS__=
)
> > directly.
> >
> > Verification with .lst files under -O2 confirms that the compiler
> > successfully performs "dead code elimination". Even when variables
> > (like char buf[] in nfsfh.c) or static helper functions (like
> > nlmdbg_cookie2a() in svclock.c) are declared without #ifdef, they are
> > completely optimized out (no stack allocation, no symbol references in
> > the final executable) as they are only referenced within no_printk().
>
> Does this patch fixes also 202603110038.P6d14oxa-lkp@intel.com?
>

Hi Andy,
Regarding the LKP report:
I have reproduced the Sparse warning (void vs int mismatch) locally.
To resolve this, I'll use the do-while(0) form in v3 to ensure the macro
always evaluates to void:
-# define dfprintk(fac, ...)            no_printk(__VA_ARGS__)
-# define dfprintk_rcu(fac, ...)        no_printk(__VA_ARGS__)
+# define dfprintk(fac, ...)            do { no_printk(__VA_ARGS__); } whil=
e (0)
+# define dfprintk_rcu(fac, ...)        do { no_printk(__VA_ARGS__); } whil=
e (0)


On Thu, Mar 12, 2026 at 9:20=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> Has a subsystem tree been chosen through which to merge these two patches=
?
>

Hi Chuck,
To make the review and merging process easier across different
subsystems, I will
send v3 as a 3-patch series:
[PATCH v3 1/3] sunrpc: Fix dprintk type mismatch using do-while(0)
    include/linux/sunrpc/debug.h
[PATCH v3 2/3] nfsd/lockd: Remove redundant debug checks
    fs/nfsd/nfsfh.c, fs/lockd/svclock.c
[PATCH v3 3/3] sunrpc/xprtrdma: Simplify variable declarations and debug ch=
ecks
    net/sunrpc/xprtrdma/svc_rdma_transport.c

Best Regards,
Sean

