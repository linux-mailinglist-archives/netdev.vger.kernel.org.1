Return-Path: <netdev+bounces-275577-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ON08Jsyd02nGjgcAu9opvQ
	(envelope-from <netdev+bounces-275577-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 13:49:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0971F3A3245
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 13:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 485E930131E7
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 11:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34617332ED0;
	Mon,  6 Apr 2026 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcOglI5j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EA033291F
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 11:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775476168; cv=pass; b=IdTYn0RCD/k/BRIdYfJXfhZLkDcgOIog03gTpRbrxb2zREUVzAvOUMaMs6h1Gao884dDVw7yFCYE7eiuwNfMoNN7zw7WfqvVNl4WuWM+FalYUZGIogIZvrgmEALwHqUl9vRwnZbJvZICeUY0FtinpRaMzVxPpDUE7fLJVz3pErk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775476168; c=relaxed/simple;
	bh=hiCrAkfJhWTW9PZ93bl3KXczpdHUgPTttVV+nD7Ho8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=noxQ5iWCQbSMaN3oSTmMdXl4ru69nCA0Rd2YcMOpE5Uf8DpFbuGIA8JLX98kuaobqFf9qYRH4bcxDbg18fU+35uqPSQp3/eIAhcEsQlcyTb+4XPu9owuWRBq5T5KYLjLYWZeYBiJrFlEsc/HS6YEzrd6c/0XXBmZNWtJs48oKdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcOglI5j; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so4647443e87.0
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 04:49:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775476165; cv=none;
        d=google.com; s=arc-20240605;
        b=kIIApCb7tw698vH9yMcoQALDktaC/vG4U9rX02uM6Ff0TX7bl7LqfhKh3z59LbhZbq
         Ihr8vhJcZMOZuhhuS8CuwA3H9z8qixGlDj4u6jwOTeoM8VMGrdutneChEMAEmTdchKC8
         /lwLtRDdA1IyShwIuKRlscapJy/aeU3XQAsEBewLr2evIIs1WRa3+J7sUlEgrOMah4EM
         U1gdmBM/NrnhrN6ArZxiNZeBtLl0OBLvCnVkbxp/zhAZ/42zKI3qEoFgnRNWzrsie6R2
         E4Y0U8sw7exsiBYGJGpSxICXfgYoTtcqW4PSz4Ms0akd/ddXvafft5ZLzqnoMb56nCim
         c7tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hiCrAkfJhWTW9PZ93bl3KXczpdHUgPTttVV+nD7Ho8U=;
        fh=4Z3TWazabsSXUxsTaYNutLd7+RmcaoLGM4DOvXvBHrQ=;
        b=Uu+vt/Vj8fgMVR9FHnfAQdxxOZvXtdsSpKy3vaOtXpYBZHQ2mRfFNw9owZXDhIu8+n
         YU1L4PnDC/j2hKqfkuR3Oqm5fZnbnwfY1TPkOIR4jspLb9+cs3nav41DiRLhm+qGukJN
         RvuQLL3hZknMbXCNj24hwWYrT4HabMbTe3sGXU3cKcW6E47sOF2+JxMzP4xueBbMdLmy
         A7ywNtvVRFcQip13RCNOUn05tNX4afFWF8waZ/UkYdSsvuYtKP0U79jwqKh0sSSYR/Bx
         m4nxbTh2M3O3IpWRF4ARcwA+FsF2FSYNA90SLDXPOjELnZ5/X19HBCeuthfJmpSRFusI
         h/aQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775476165; x=1776080965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiCrAkfJhWTW9PZ93bl3KXczpdHUgPTttVV+nD7Ho8U=;
        b=fcOglI5jsehh0OLUav3l6WtazkrOY07ZdrKYZhaSfYnDDce09kMYQOECHjgzyCUOqz
         F5giq+P/FamImBrc8JJtm7s0Kd5zIAlQ8X2qks6FXtx+npP/dfz+wjhQZL//mnntiX63
         WQfmalsWt5uHT7DL6yAlDvTILL/f1n9zINg/SJ+tPcRRqp90nCDCPkWFGWFSfuG7DlLS
         Wz8FoYEMkmvxcMQvMW/2GXBkFDGFDBS3IojoZWF9Yl6QuBSfB9c5ZH6BCSA0k3YT4ek4
         P3XH+e3IDk7svYTBG25Kjk+i76D9fUNT1Ko5Lz1xoqUOi2egnNiZ7i+cO9/yrb014uGp
         XXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775476165; x=1776080965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hiCrAkfJhWTW9PZ93bl3KXczpdHUgPTttVV+nD7Ho8U=;
        b=ZfsnC0GCDny3ikHpb5CWi+a1pw1GtBK98dDoA7hIX6stV+kQiW6ENz+r2GeWzD2gK5
         sbgjJGvKfFlcW9ZCnmZ6Wt7MhjBXiTP6BELu5PPgMpA2zzuY/byzNs6OCll5vdOoX3PX
         xSI6DFaNSbDhoh16ph6TDpukGZk9AzjYOS5KK6A3O30WVCkBVVfcRtKO9/NA+HTTuYor
         7JkByd+CPD03WZ3ivrFZVO+4C5kIjOk/zswpZmMT+z9MxK+MNpCNTeqWHfWd2SvwjgY2
         mPNUUql9VOZZFp1H1DlPvQK/qMIAoezpPDSUy+SsmAGU6tdh/jomqH9/VhrPG7JT0GZK
         ICyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQgg0j1cfNYbf3ihCxHs9yeJg/KtfculHoOHMsTVCy2deUFQz3m0z6ttsUBEGRKT6/Vtjyekw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUIg21mvTK6xUmr/HafmBEpqvl7vm/hzF18gFflxKrb74FYenB
	m7OBK+paxvs6RlvIl+2J/QoUYHFPxRL6cNTNmaoOQFGnkit8GndlEH6yhZgtCTt793uAccyJwwT
	iU5I3bMosCtX1UHtWa6XnSZUkzx/2SyY=
X-Gm-Gg: AeBDiet4pMzerErtI1blURs41wxT66yQt0el1nEcDtvUkiwI3bXSHgsLnjFOSkUX5ZM
	ddHx3GfEVygtRajTKseUw2dtZ4wMZ5Jqa/xpMuvrhl5/kGl8WWgBP7u2XoGQMCBd1rQdPlZdXv3
	fP946Q+xMJvJtLMU5WuBOEisEKcNisIkxnXIKIFjoWVTyQUvfVuHIPyIGSOklTw3JvBCntxG1eK
	vfcgZt2uePsxQLAhCuFDCthux4cQwDYRMLGbd63N+pO4ls8ASauzUBQR9IJ6l5bhiWmN7F3qg4w
	B2qUk/w=
X-Received: by 2002:a05:6512:3044:b0:59e:57d2:75f0 with SMTP id
 2adb3069b0e04-5a33758ad0fmr4630910e87.32.1775476164770; Mon, 06 Apr 2026
 04:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404150452.83904-1-kerneljasonxing@gmail.com>
 <20260404150452.83904-3-kerneljasonxing@gmail.com> <willemdebruijn.kernel.c2ef8ef43869@gmail.com>
In-Reply-To: <willemdebruijn.kernel.c2ef8ef43869@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 6 Apr 2026 19:48:45 +0800
X-Gm-Features: AQROBzBLd1qJZJR7_3XJ4RB9kCGoLhjqb3qGP5BJWelUsV1v58MJj_BN8Rtdwv4
Message-ID: <CAL+tcoAdsBBVa36ocMqiuUT4goratVdnNNcHfKcwcwm2h7cujQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/4] tcp: advance the tsflags check to save cycles
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, 
	martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275577-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,tencent.com:email]
X-Rspamd-Queue-Id: 0971F3A3245
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 6, 2026 at 10:23=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Check the tsflags first to see if the socket timestamping is enabled.
> > If so, then try to fetch the last skb from either write queue or
> > retransmission queue.
>
> This message does not explain why this change is made.

Oh, right, I should've added more direct benefits.

Thanks,
Jason

