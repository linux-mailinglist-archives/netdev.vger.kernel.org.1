Return-Path: <netdev+bounces-274772-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KK7pOoL8zmn7sAYAu9opvQ
	(envelope-from <netdev+bounces-274772-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:32:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 684A538F3D2
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 372213013B6E
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 23:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE017364053;
	Thu,  2 Apr 2026 23:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3ACAYsY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C208423ED6A
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775172636; cv=pass; b=kR9yLwqXa6R8C/eSXA9mFG9wzlE9S+MugZeudsTPNCcr1VTz56CoYrvwhlBMfvZdP2BzDu+V/ZzeWrDeSWOTPe/NgZnmcVj5O5Qq1ni9dRO22KyySVhnYI3H99t/Hp04Ov9bDPnNcCGtUYg011WLphvbz/EMlvK8x4JQBVkbS3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775172636; c=relaxed/simple;
	bh=JbUP87vEKVaqyp4f8DtXNZITW0zWjhu5ZVPcgNumnAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcCwT6t26WeRM6FHgafGAPSDYoG8KEhfmCbR1RPZUAUES3oM0kk1ZQaYhFxNuSiHc8LSydZRDsz3AsPQpB0rdFCbrBnzCAjg+4e/yMpUOheIgSl+4FFMKRMLF8yu1W01AAFj8vps24GRWHrbjNu73osAaJL/6SNw1SiCsLC4EkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3ACAYsY; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-66bd4f7b2d3so1719972a12.3
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 16:30:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775172633; cv=none;
        d=google.com; s=arc-20240605;
        b=lPK/HU4yGcuaeMO8lNt84mjduROSGfH2CHNi7i293Ez+xxJgnz0sWGEsm7zohpbXPu
         AdfEJzuxlbozhnHBDsgYzh1EGKhVGxxmAQRskDV+lPRKWEO61jdkiHsrdbjRNWnjCUjD
         l8y3CKxax/8Ivl8bSqWzi3swJ/9VAWD9EKaKnBixcO4cYy5DFgbtrlcym7Witi0CZVE8
         ED/9GfkJqNJuYrHVHvWO2YefR2AKPyChyEzqumKQbyIQjnZkVsO63gvk+AZuTh8jGm9/
         Ra27ARknLeDvGMhZtIkoId+syf5sClTRc2PXafYb+2+web3BSFH5guJtX+g02P2a/YaP
         J9aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JbUP87vEKVaqyp4f8DtXNZITW0zWjhu5ZVPcgNumnAM=;
        fh=p/C+dzbD7q561ana2ut90Nj2xCnH058uxU+YSEqF264=;
        b=P3E7fLm0CA4ptSLLqF4+Nu8v+qfhqaeOlce40+Koq39F208C/PaI8dqLOO3E4RlA6Z
         6Mt2SsjT56AtnOcVKIKk/OIxhz9fGkE3uxH9rv3n+MwgLAT+HD/kuyrm9pH4wFOGeSPA
         W/0Z/NQW8CaZCS4ZX47HQRCvAwfcFGDxlmd57BdjeMhlUfASioHz0bAQFMsSyL6Lj3ZY
         kNsCNW8RMLIP54NsprlRWvGV/c9TWiMPs3dlQzb7ZyEuz32MKkoFcoDNJWKTZFcCghQ8
         +5ci+smaempxw+UVppPeYoKtGjbfdb1mHBHiTuCo9Hq//ZdO1qkDpiSnz2HSClucL5KK
         ie2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775172633; x=1775777433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbUP87vEKVaqyp4f8DtXNZITW0zWjhu5ZVPcgNumnAM=;
        b=S3ACAYsYVUMD1RX/YFs1/I4HDTqCtJ5wJkN/+zeLIxCNU7+jW5DKeO1ByzV1sDfuy4
         9JMXPiSWeS0oXp3e7cnTVx0mqahzxTkPGeKcLD4vFoaNFkVrRmMw+SjFpIor99hIMebl
         iqg/PVVc523RHQtWX2Q9FqMAWX7F/cwjadFIYpOStxcgayqTm7y8PjOUrh7KqI6oksny
         bV5ppEgnZsyOmn+1zjTZmcZx9u3OiOe6tspWLdAkcnUL0z2qVFzjXI9JiPqQT/hGLiFt
         DZpLhX5PJTL5zngsx4hxNTCOoHATsTs9GFFAmIsL+JTMNgzTXhGRFg7hcVQDxaDMAVwg
         Rfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775172633; x=1775777433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JbUP87vEKVaqyp4f8DtXNZITW0zWjhu5ZVPcgNumnAM=;
        b=fAekjt0l4lazb+T6v+IcfUytVaoBYus98qpedGvmSgvPESJGtSwL4ZzVZhAF/l6tvl
         CvLK/9o110BICq4hBt2o9yyubDQcYCH7Frxdg8qNDiLo/nvjntVp7GGgPVj14UCPcb1J
         icl+BzD2xW5XjhHjvAmL5IyBVFBAzdxRTf1y3mkwuNdVcujP0EzgruAhBUV5MGjiWWa9
         sttj3cfohyqStc7hBkG2NrenfKprYTgCnTTDlzM84mx5qLg3F0nPJ+N4e7qFR8GApIpJ
         BgjXV0+rYB0yFbG28CwEcRQX1rhH+HngJ+TlV9T6rIWpRFC93auTGW4ghYHAV9EY+jGs
         lyng==
X-Forwarded-Encrypted: i=1; AJvYcCUVzMjDL7S0+N4JoN9WWQIjys89QRxyKq4Urt99SOOjNKN51i5AGBanSaF7b/emSTS5h15TAjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfHhGldwbmddFE0QvBSaf2jXYA+MU42MIQc9HSjApebtIHUGBo
	WUFlo1Fh83mDbEv8w3bUbv75JDV/N/6FMKQVoNW/oqQ6JUt9qliHd1lb34loY8A5QbJIeFUw0KW
	nZz1yOi6EeCigbg/tuVzoh0DB8j7+NZQ=
X-Gm-Gg: AeBDiesbpbQRft461Pt59wunEK1f/eGv4T+GOHlsqK9AKx2nFvQR76ufY1uOitO3+4X
	KdGN+PNPQ0rL7crGz8ivpEAGS2G6lPh/NWmTpytcU1ZDB3K6IdB7GHIBorpw0TokuNdqNSrc1D9
	TtSlBT0bLKREs295LEnLxPFaVG3/IEW/qR3BQgwGm7qeTzamViBIgoFzQPbK0KGLVcRGoL5pNM9
	Mg6MCj8uaeAn5sNOdihQbNYT4ZmSSHuSgdxXGyCT44RkshD1MdCrl8a/L8ibLM1kxN/HlFO3F9i
	f8buLes=
X-Received: by 2002:a05:6402:4510:b0:66c:2fdf:7613 with SMTP id
 4fb4d7f45d1cf-66e3f701e2emr406667a12.16.1775172632884; Thu, 02 Apr 2026
 16:30:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402044637.73531-1-laurencerowe@gmail.com>
 <ac47PYPeL0IyRtY6@sgarzare-redhat> <CAOycyLTy=ZT0AXiwPrbEfyxX_ZZgwzaetKOqP9cNywTO1_wNZw@mail.gmail.com>
In-Reply-To: <CAOycyLTy=ZT0AXiwPrbEfyxX_ZZgwzaetKOqP9cNywTO1_wNZw@mail.gmail.com>
From: Laurence Rowe <laurencerowe@gmail.com>
Date: Thu, 2 Apr 2026 16:30:20 -0700
X-Gm-Features: AQROBzAn_1Pe7hfjJrx-zqQ_xxG_tmvCIn21DwEYx30CeJR1P5ajlpmcc4tsRPk
Message-ID: <CAOycyLR-otKw4jTcNpo3pUBbDx9DVJyPU7b0T6uHib6mSrAvVg@mail.gmail.com>
Subject: Re: [PATCH] vsock: avoid timeout for non-blocking accept() with empty backlog
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	Bobby Eshleman <bobbyeshleman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274772-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laurencerowe@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 684A538F3D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 12:22=E2=80=AFPM Laurence Rowe <laurencerowe@gmail.c=
om> wrote:
>
> On Thu, Apr 2, 2026 at 5:03=E2=80=AFAM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
>
> > >Scheduling a timeout for a non-blocking accept with an empty backlog
> > >meant AF_VSOCK sockets used by epoll network servers incurred hundreds
> > >of microseconds of additional latency per accept loop compared to
> > >AF_INET or AF_UNIX sockets.
> >
> > Not related to this patch, but should we do something similar (in
> > another patch) also in vsock_connect() or doesn't matter since usually
> > it's always blocking?
>
> Looking at vsock_connect it's not immediately obvious to me whether it
> is affected
> in the same way. I'll capture some ftraces and follow up after
> updating this patch.

This does not seem to be a problem for vsock_connect since it checks
for `if (flags & O_NONBLOCK) {` in the while loop before calling
`schedule_timeout`.

Timings and ftraces:

https://github.com/lrowe/linux-vsock-accept-timeout-investigation?tab=3Drea=
dme-ov-file#a-quick-look-at-connect

Laurence

