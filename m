Return-Path: <netdev+bounces-275458-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2I4dEts/0mnOUgcAu9opvQ
	(envelope-from <netdev+bounces-275458-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 12:56:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A3C39E14E
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 12:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3A3B3007F75
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 10:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5999C33D512;
	Sun,  5 Apr 2026 10:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2F8qdLM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F243375C5
	for <netdev@vger.kernel.org>; Sun,  5 Apr 2026 10:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775386584; cv=pass; b=T51WCyATNOA6Ck7mAsA7Szc17lW5usTp/CXlc8gQq/BubJTsE1/MvHdstrBmc5lMiQ7JW1MY/zINCgkLPRjmJJqXHeAmAf376te60U6q2e2F0E0osurdQ7aYoQtuca9f4yySXH9g1Owa5xitBmxR4/gnHtAxWaSS3lb4jGaZHUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775386584; c=relaxed/simple;
	bh=g/jv9EaGL1NHzbKG+vzp85KtXF9DSPspNvmDLimdZak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYFTZztvtvsB6MrDii1nxmMC80E4XSzpW79H0gOg+d1iRRTjWR92+8zbEbsLIPnG285ndEulJv6MADYwcKa3SsuAs+4IvNxkfXEGYkzitwIzuqfq7XfF3pQgMXvuPEkeB1SSK33JCDuI8NyMDrSH9MZAtyaUnKCambRg8dd+xuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2F8qdLM; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79853c0f5b9so51915217b3.0
        for <netdev@vger.kernel.org>; Sun, 05 Apr 2026 03:56:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775386582; cv=none;
        d=google.com; s=arc-20240605;
        b=cEJek9Cscz7NXNOA5mWNGpO5u9SBXWGxe8rg3WspiZpGeoEn2jGCZ01oxSG9XRb9D+
         KkwQIu+eW4KKLvPzrv2bHDpsPgaS+F2v/eNOdXDSLwdj3acXhTnkNKlyt3M5NMRyJ1or
         C1RTjvZTN3hoGgcjU6E0h9ZQ18+PC++WusM7CCsYoc3UYNdlISFBQ+ga7hCssQcfnPsH
         UAKwhrvp8uj8itUaspTBc3ZbfVfn9tM7ck7hZiiGeHA/x+wycvNn5Mp3Gl0M5aSfl7V6
         h7A0p/wgp2ge7YTPyYlAMHHqhBMmvZ6nGKuIbujoJBmrcg+7myKj7teoVYgGZ2LbFGqI
         wyeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=g/jv9EaGL1NHzbKG+vzp85KtXF9DSPspNvmDLimdZak=;
        fh=VkeprCwKgO6b4dI424FPaMkpFJP/g0YpSZ/bMczAWwY=;
        b=VqOAAsmo3dfbyDnhEzNq9I9v+W1iRIcbtC03cEP+2S39p5fK33jSPq+T9BsNXnAJ5F
         nsMkyx2gkS5yBTBAVu9LzA8n3MFWeNvK5SipvmGapDv7itu+xa74+SnsXMhodtcbW/uq
         +dEkn1s7px2Xkk7UfkfO4MlRzHtatgXhsc9nxug27IUDUdevgdkSpQ9nRpF17mpEbB7h
         lV9N91hhlxq+0N6flj9FR7RbSRuW3H6n1kEgKHuVf4Fd1Q6gw5scuphgCBPhFVR3Ybqk
         +/IPC3Bu9gphiZR0aoUN5waskkx1+tfid+ds990LKtUJNR1/k35smvOsvJ+MSL8p28Q0
         Fqyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775386582; x=1775991382; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g/jv9EaGL1NHzbKG+vzp85KtXF9DSPspNvmDLimdZak=;
        b=J2F8qdLMAmeIk1NfKZKzh1JG0r2qLOKtji0wWViUOdk3ylIqhOfMGtzReZvUBhpm+o
         IM+wlNs9cFIpkrHpjQv9N3pjXuxOBwpsQvp1BpIhMixAJ5OQGq34Lpms7C2KNw5ozrhy
         B22jTgzP7OWQN6igfqpNl7QGMpL4y6UcTv1eEMcG7xD7OcIUE3U67d2TIU5evalqdSLs
         F411ROODQKj61xFszSUEhc6hWGjkOtmbPU6iGK3q8kmCQ3892mamKh1T02orNi/a90Kh
         2soaNjj8A+wb/AQbEJLuhTh9mXpoVT0DDSasjxCDISWFsbUIZRWK5vx1NkqMG0TMSqVe
         SMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775386582; x=1775991382;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/jv9EaGL1NHzbKG+vzp85KtXF9DSPspNvmDLimdZak=;
        b=kiiuL1wGE+NrXrHXbior6oG7d+v7kIV/mXW7VVD4qpYFTLcG9nQJ9StUO/qp7DVHb7
         UljeVH8H/fzA/zXQe/mrDjGKEmm4Z/sI9gfCBZ/J00ZxJ1suVPBRvyW/NR8G9Y7xBARe
         x7CGSHO6hwb7qrTEnVjnUhtDoV3jMHogGToG8U7pe23o9SrqfDeoBsMsmpoZ4eH/jG7F
         lmJ+bVIzbiDtdKIV22UwzUT672yYwvIL3K9Pr90QA5rOqOOoHsBYDyfn0hci3RWPKJQM
         3GSZ5WJxEcEsb0tU/fjMqYvewf+NytghxRw/LlBf7JVsqo/j2fJw+XxrEDH5oFEbQVrD
         POWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ+QBon66qhXD72zgFbh7TlqW1dQ/Zm525vAZahOrZiyOKOOmIFK+9Wc2KJfUPnYGgoW41nFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4VroxxujXhC2W5IOv/f1+oUJT2nl/+xQoK3BohghJF3FwPFjt
	YRdlPK3VVY2dr0wMi/TreeIXxKf9CvDoKj7lzxr0RvzFTYEnru3xxi5fLEKyufKDp62XAGU6QHL
	u2bLufnVOJERGeWgVp6xQF8VZRfW1hvo=
X-Gm-Gg: AeBDievacM5XQrP/wdPKvFw1Njwg/6KNBKReTAJbYsZX61EdPQLF00cnHD3Parknw4b
	U5nxrmTpEJ7hi2mtpTeSiPBVCLiO+t2kqBkmMxQz6Z8dJnwuJmUiSqRZ/kizqq8Jakq2tGnLJeI
	s+lLs735CJDnuQBtAvrMkBnm/HqY61qNwPQqFjwuDNsYDSKyzaicTLN6t25W4iSPO4qoaRHvLXU
	fwvmbBhjPYE2DolyaR8hlg7tuDCwDeaTzdlj/zm0g8UZA1wH/0asxVkm3LqZh+L1FYbpixahVdr
	zpey1zreBVTmuv8y+HyDbguU305MKrgkB9nKT28=
X-Received: by 2002:a05:690c:4b89:b0:79c:c51c:7f4c with SMTP id
 00721157ae682-7a4d34d76e3mr93257527b3.11.1775386582198; Sun, 05 Apr 2026
 03:56:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404225023.1254-1-rayfraytech@gmail.com> <975ec123-e3df-41d5-bb15-f3af8af2c340@lunn.ch>
In-Reply-To: <975ec123-e3df-41d5-bb15-f3af8af2c340@lunn.ch>
From: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
Date: Sun, 5 Apr 2026 12:56:11 +0200
X-Gm-Features: AQROBzBUb8njSHuRsIfNvPcNjSrTGW9k_WO4GuTGt3J0p3YykGqE8cU1FpfGVXE
Message-ID: <CAJioSGcBb3eRtgQXHWx+Bhw4M422dyAo-0yXO-XwU7h4hmwmEQ@mail.gmail.com>
Subject: Re: [PATCH net v2] tg3: Add PowerEdge R740xd to AER quirk list
To: Andrew Lunn <andrew@lunn.ch>
Cc: pavan.chebbi@broadcom.com, mchan@broadcom.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, lszubowi@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275458-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rayfraytech@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B7A3C39E14E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 05, 2026 at 01:03:00AM +0200, Andrew Lunn wrote:
> When you look at tg3_restart_aer_quirk_table[] they are all Dell.
> Are there any Dell systems which actually work? Would it make sense
> to mark all Dell systems as broken and enable the quirk?

That's a good point. I don't know if there are Dell systems where
the quirk would cause harm. Do you know if it's safe to apply the
quirk to all Dell systems, or should we be cautious and keep the
per-model approach?

Best regards,
Oskar Ray-Frayssinet

