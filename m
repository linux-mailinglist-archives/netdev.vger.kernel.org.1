Return-Path: <netdev+bounces-288609-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id X940Np1LCGq5iQMAu9opvQ
	(envelope-from <netdev+bounces-288609-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 12:49:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F6555B33A
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 12:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C53F300F9CB
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 10:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C7739E176;
	Sat, 16 May 2026 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNYtLhh5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CC227EC7C
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778928537; cv=pass; b=ncSn7DthWKPANZ1RsO7pN0EC4OBIhow0cANQkoxcTWfljyklW+jhnW1v1R8y61TZ3l+EYfD7OknXDnreojrWgBSvUFiAS0rS+ukTq7GIDZPg3lE6vDEUAHTLO08k2cbcSvP0MXzDZrms//kPgebw5m0QN8rzPkBYnd9rbTYhl6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778928537; c=relaxed/simple;
	bh=n/AVyKlJGTsYHXsiXwBdHgBJFjZOldWnzK92bPN/bbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSncXXCfZWjDO+OXoZBfdFiX/CHEC9z2llNOfjQ2n1d3Dt/DTntDmstZ4R8wq6Vde+kmnc/nwY6V6kULzsjnHoXjhBGVD3iAGtRT9D0MLJRMDrg/gGQ9MWrki6muY0iVlCX+RVyKjk/rzLNWXp/PRd7QaX/GRURq4lxmrjKFBTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pNYtLhh5; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7bdec52f48dso2338297b3.0
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 03:48:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778928535; cv=none;
        d=google.com; s=arc-20240605;
        b=H72AGfkAaN/eUgnyVw10fKHo25MlJMTv0ahFJOqzojg+UcMiDL9DftMDzgyHePf1QK
         YWDvvBR4jPV0+UeBhObDhe9G9dzLb2OyBYZ5iFjGuZDgU/MEvJnhAGa3W0t55pgRr76F
         1sjQTmg9x0WOWSfWW3Ig1BrfOpMt6v5+W11zQ0NTTszVEw1qhAgeGgqt9ALm938QgbTq
         2b+WF9+tZ1gzm1jMG1/BRlwDV4eQpzN/HZzuVs2YMu9xRGlv0ypfAaeKM3eTGENfHGEE
         2lnJXgCRq5ccDr5DsQG+SB5dODFpt+Pr5e86Fj7PiC3NLYUzRFyhFysyMDCK6ps1OYNI
         +VRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n/AVyKlJGTsYHXsiXwBdHgBJFjZOldWnzK92bPN/bbw=;
        fh=2XFcmFmCYdDBv36x3LOgbl/B2vqa0dB2DmXQDDa3IG8=;
        b=faHiKBPpXpBv8g2/6ElYyqYezbSZ080AgXmZjRlAc8ay6ONx2Z3njIhthoAbsyVaCZ
         BThbE46cZ6fE6gmig4QGvCzxpoQSydTxDOJZ/MeqMbyH8bm2GljhPTP1LuCHXAJpNDiu
         nSNCIPJlBSyVmxHaWnb+jYz0S3RV1V5IjtJ2jpt2CIPn6i7qiMHb2F2T7p27l+rSQ4CU
         kOpsDZVQ6gCNVMmgAEI7s9fC5skHU5LNoyHjkCnV78CLinvIkwRvzYfbu/EJVf/WfF9v
         7yH205p0/zwkGLwRfdSY8HMyJp1VkXtTBooN2SBULI0VLNPWXRZ5BeG3Ha10U2hkiYxb
         /+lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778928535; x=1779533335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/AVyKlJGTsYHXsiXwBdHgBJFjZOldWnzK92bPN/bbw=;
        b=pNYtLhh5Z7Szpf+lmmbK5DyYZo09+EFqC9DuBQrPsp4WWjDm4UOApB/IjtyGCU2Jgg
         s879xPqgRqLMyrnJMxYTEl6FsidKqoJEIcn4lxrtvZFLlqhdtUP53YBaWKFTtHVIY7Kv
         CJWXP+/ph1nPWfZUjE9gRgq7L51vDPXnceo1FYZnQeDo+GeZovYXLPuB1WUT7dxBtojP
         7MhF+wm24KlkZAMocLkOwMwU6DejpPquPiDBkrYZQLdL0iwZSU3L/SRVf4g2260FYSyO
         r4xv9CE4FAzsN2GlsXS88f9+bXBKJAwmNKIx+/GoN1WAB6tQGOuejZoObLYWzuAkPq7M
         13WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778928535; x=1779533335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n/AVyKlJGTsYHXsiXwBdHgBJFjZOldWnzK92bPN/bbw=;
        b=VFoxhCOTqHJHtKU+wSz6zMs6dCY2QFCN1UICNMhxxYUcPx7YSxvau3ps3H7XRp2MuJ
         ua00mBfpJ+XfICddK34I6cXjBrsvH9V5EHNWIYFpHM43h+MedXYDzVLjg5ZnwSOAEZdg
         PqhsogA++hD0gemlS2BqmQ68vF/uNt4L6k5zT9hi6Lrv/a/TQHUD8IqIGyo2BNDIDt3T
         6DTVYDd44PLnKL0gYXDxPzCXrJMto7Pbm5EtEQ/06p4tCkXHoCZ/J4U6GNj2VNkIRlsz
         UYx1tjdH0At2enevnbWMW4UBaN2yvw02VqtAmeR2epWMI6mSkL1PYExGSAufUERTawiz
         YanQ==
X-Forwarded-Encrypted: i=1; AFNElJ8/eUX0A4UH5qKiWX4o3UVJ6lu3xpx97YVIyL6RYwHaOmg9I+tQlZHz9fmwb4naPWBqOYFLx9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQPrr/YGfMe8K/fg05iWJ21WVdRh/D9V0ugCn/Y7G2IWY6ZASP
	5/zDXbogbcuXDSXIuhcBPHzIbuCJR/413cC+lA+uxEtdGmo0hDhakRk/lXYQJ+wPJ1ZoOti6DPV
	bSiv531J3ZifPFamWNm432nLAd94kMv8=
X-Gm-Gg: Acq92OE1IbSyd+qBkCLriKhi2OH3s9JipO7EPVjUbzERQ5XgUd3NF2/6GK23vzKXSHd
	EAQs3QlGao0dnTCi3bBjjqTA/NUbU9/dZbT9vH1ZY04LjEI5b7MiBe1G49z8Tjn+MmT62fv90aC
	IeRhfPyqwvCHfr6B8N9GiMr3qVkdP+NnSyMwFJxTLFiuYW8/D57KiwjXD3TCUKKAA5nPZp7TYmJ
	V1u14AuSvkM6wJ9UEEvgD5J+yIbwZrN/ZxpCYHGAnOyJcYJ4OxJ+MM+O8c1ELhpW3S3hGHC/6/s
	+4O94dM=
X-Received: by 2002:a05:690c:c36b:b0:7ba:ded4:df69 with SMTP id
 00721157ae682-7c9463a27d4mr60332307b3.1.1778928534930; Sat, 16 May 2026
 03:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87se8mytvv.fsf@toke.dk> <20260512144512.9960-1-bernard.f6bvp@gmail.com>
 <20260512163648.7367a640@kernel.org> <CAFAa3YDcBsCnEJ1t+a3iHhzxW65HX+QNkZWPKHvDYp_V+UwZYQ@mail.gmail.com>
 <20260515181411.28af7ffc@kernel.org>
In-Reply-To: <20260515181411.28af7ffc@kernel.org>
From: Bernard Pidoux <bernard.f6bvp@gmail.com>
Date: Sat, 16 May 2026 12:48:43 +0200
X-Gm-Features: AVHnY4IZ0c2IDo5kgo9E787Nd7IrItMcCAVJ5vxd7c8NHwfo2rpdQii2G5jAbXo
Message-ID: <CAFAa3YDf4Zq9bH44FMS43E=FnMrvXF1ry9pdTQqT4ZvrqhzZBw@mail.gmail.com>
Subject: Re: [PATCH net-deletions] net: remove ax25 and amateur radio
 (hamradio) subsystem
To: kuba@kernel.org
Cc: toke@toke.dk, stable@vger.kernel.org, davem@davemloft.net, 
	netdev@vger.kernel.org, pabeni@redhat.com, gregkh@linuxfoundation.org, 
	linux-hams@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 34F6555B33A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288609-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernardf6bvp@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

On Fri, 16 May 2026 Jakub Kicinski wrote:
> It's a GitHub repo so PR is probably appropriate there.

Done. I have submitted the five rose fixes as a pull request to the
mod-orphan repository:

https://github.com/linux-netdev/mod-orphan/pull/1

The PR contains six commits:

1. rose: build with hamradio_compat.h on pre-7.0 kernels
(compat shim for struct sockaddr_unsized, required by af_rose.c)
2. rose: fix dev_put() leak in rose_loopback_timer()
3. rose: hold loopback neighbour reference across timer callback
4. rose: fix race between loopback timer and module removal
5. rose: clear neighbour pointer after rose_neigh_put() in state machines
6. rose: guard rose_neigh_put() against NULL in timer expiry

All five fixes have been built and tested successfully against kernel
6.17.0-23-generic (pre-7.0): insmod, functional operation, and rmmod
all completed cleanly with no crash or leak detected.

73 de Bernard Pidoux F6BVP


Le sam. 16 mai 2026 =C3=A0 03:14, Jakub Kicinski <kuba@kernel.org> a =C3=A9=
crit :
>
> On Fri, 15 May 2026 16:52:43 +0200 Bernard Pidoux wrote:
> > I am happy to submit these two fixes as patches to mod-orphan if that
> > is the right approach. Please let me know.
>
> It's a GitHub repo so PR is probably appropriate there.

