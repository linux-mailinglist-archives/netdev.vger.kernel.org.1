Return-Path: <netdev+bounces-263624-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDf9Jhvep2lnkgAAu9opvQ
	(envelope-from <netdev+bounces-263624-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:24:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E901FB90F
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 836AD30179D6
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 07:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09882EBDFA;
	Wed,  4 Mar 2026 07:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRSp7Qh/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A84351C0F
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609026; cv=pass; b=mLcxiTnYDvcrOm7lfPSN7LO41hvqNUndj+icrhjy4QH2WcZxjQ3K27sCH+YGKa+JitR2VaEttjypV7ivT9kVAjSoPvtDDiBYBheHPeWLFgVo+cztxnR1cIywEzNoIB+S8/K3q7z0dWJLBvhLx+hNPFlxZifEW/iL3kFDkMnr2Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609026; c=relaxed/simple;
	bh=w8yUQbtJsEkCj9oWcla6ivUT68glsDXwhJhpf+KWMOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YU2he4lNYpV40Q63A2Jtzz4g2EYC2CFOzcNmmZy54wDKUeELXRfGqC0KnfaWRINrJLEVGNnpR4YkC/hQDqLvW/H0anqPGqOSqHjmYyrar/lSsiFJ7+u1AZWwlf6G7Q20+lX4sJ3+jiSXKV93G7Du1/s/TYasNvXGije0uaRQ/M0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRSp7Qh/; arc=pass smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-89a1d7cc7f0so227936d6.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 23:23:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772609024; cv=none;
        d=google.com; s=arc-20240605;
        b=HJnMRaR7+xRPY8GbFJUvHY8lIM6j9HmAU8EOMvTTwCnQYWYzKLwCN/d7ebqFZeJ+j7
         Vl7JMAVQAm2Ln7ykYEJ27EObFkyTZGfG2dbpBP8+vq6ofskyd/QhZtSfXuAnJ0LwYyru
         vF4RcJE3UQHPMEEVUKoKt/ss/9lXzxVFTTm5Q+rQUoaQSh5J3Y2yaDbBt65Ur3QmzIKg
         HpnHRH+c6h1AA5GwU4YfmZ9Z7Lu8MxuXuz2zWmbmAXrF2X/vel3IgZahhRBv+bPS6mjg
         UNTAY+RB/r0OP47hcM/e9eXHQ38nbLagm5zinURafRHsTKfiGuZFxrhSxTWEWGejXoYJ
         VoGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w8yUQbtJsEkCj9oWcla6ivUT68glsDXwhJhpf+KWMOU=;
        fh=uhv+flI/fqUYmbWqUWLE8mlDKZlIhYiuXK6Q9YFgNtA=;
        b=BlxHfPOA1JfFmNOJo9zIvH4xAkT5WLYypiFKefty93ZWxUc1oYz35EOPOqBjs9v3Ki
         cWbPxkFS5hBZO4xeun5alAe0eMNoTf/gADyXpkeU6Yw2FOxjf5cH0UH5ob0PnjTgPnsN
         SHJjj3KeyLOAvCCSU7Nb96+Is4JA3EFZzIAc7jOpSnAdYq9jzT7MocW8FmPpI+phsKlF
         yYQK4t4bXmNyEmiMUx4xt/LoUIguKL1AzNVBEgXFCCJu8qXih5/HhqBP5Cw2OJQNWaMy
         cvVp/AL9FxPSxpNCzd3TK5PrcNIkQb90pGsOXwVRizc2GCSjix7Y9jrHSuciIqLzcXYt
         YV6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772609024; x=1773213824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8yUQbtJsEkCj9oWcla6ivUT68glsDXwhJhpf+KWMOU=;
        b=MRSp7Qh/O2/KZAeZmNsBXMp2ueRKf8yYXqYIFJC0an+0/1kk/1Yf1dffhhIiu6m8V4
         Z41OFoPiA8P+Ndfq9NWHuREyqtAAIOEQUq/Tt+8JCjsRBiJVXdQpgb30S7GLdWSUM8BR
         PvfGgz+hRqXy9zwIawjv0AK7MhsRaN0y0w55C0gIdBvJoCQ0AP8ggnADAUQyugecg6EC
         wkgsZi/ZRz4sdgxObWAIUd0/6BJ0r+aCbTnOAbHk1NO7Y70hzqjmNc5Kb5AGGJ9x7qUm
         sS/sIil3Ou1SXbrlFWEunhDSL23GHt969tI73imI0UICmi0maA7CTrTuQ/+FyD/8yfZ5
         70vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772609024; x=1773213824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w8yUQbtJsEkCj9oWcla6ivUT68glsDXwhJhpf+KWMOU=;
        b=h2xmKXiWgyQMb+llnt6z6pGvht4WnGZBgKT/W+c/3fTlmSrVHPFtwFxBX6cUuv5mZm
         jOUfyKY+5Iaq7hbNTffkFGaeyRXirlOZEOWmT/0iEEvc0J7kaAVF6oT+iFvjhv90jNkT
         Grv3CHgyGQQiHB6LlGVRwpWYP17Su+WZLWh7+koH8LddDuLiDl+kJT79hYYbFTc6FK/u
         s7sv9GDItsb/tBf6Rr0g7GE0fMCYFUlXQIeF3NQmkScdWhdX5N6Fgb31q0gEQfvd4OKn
         ovjNQqMNZtPtfCS9+fi1OEYhzjJErV7cnJ2RPnahmYFW2hJhZJWZGUTrqNb4z6cOmn2z
         HmRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk/erLplD6HoEVpKGkEPcErxmCZnLG343qaNOzvGxDR+mtm8CLpgzAlZw24Trk5/WYlFna3S8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUjz8IPzcK1BztJtlO/eif9FqDamFWtHYWRcCNFdAe+deZoR0i
	NUnw1dtKanyK759N6wcptE1TJzTCTwMJj5kGxopTCMcsPAT3b3Cn1Jj/nT7quHSQvhAoNIB/Rmr
	DGSYVmMM/YJeQjtpN3aOildwBVfMVBmw=
X-Gm-Gg: ATEYQzydoKD9Fho5szdpj3ocY7mlkOfhPkW4r2cZ6kYgx1uxMuhZVQlgsXKf7xlyrdX
	z9RD5supFsOC4PAs26tNFJdBvSVZCVu4diyA64bfYxmGj6dpPQtMJ3HBzq7DO8Y/E8lfAa2o9fQ
	dVcnXE46LqDc4fRNLDfU/MyuRiS67P6+YTnkAFo7ilM8/fFFAdE41CN1WHKIXu9tVVgsDv62qbh
	42WFYvaCBPoDtR23fQOtWgvp0sGjTSfaaE7pR4j7E0ePw67UP0gwZhHc2hbkdJmBb5vYYjYSgZf
	/GQmVaxbDM9foykovVNXtFhoMsZo2/G3rHrOB59raBUOb7qtkNgjvbxzS76Mi5sq/CUG
X-Received: by 2002:a05:6214:2583:b0:89a:c8c:3121 with SMTP id
 6a1803df08f44-89a19cee158mr13714996d6.40.1772609024455; Tue, 03 Mar 2026
 23:23:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301011749.1671856-1-sashal@kernel.org>
In-Reply-To: <20260301011749.1671856-1-sashal@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Tue, 3 Mar 2026 23:23:33 -0800
X-Gm-Features: AaiRm50CgErMZzS_ze7kCt_8oImY4S0b0P0oRP5fkeSHF9z9hr1Wm9mnfCaQPkY
Message-ID: <CADkSEUj-2N8TrsEBMogJ6PtHRsGPxVnxuJh5pmOijVd1KPfG_A@mail.gmail.com>
Subject: Re: FAILED: Patch "net: arcnet: com20020-pci: fix support for 2.5Mbit
 cards" failed to apply to 6.18-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 18E901FB90F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263624-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi, Sasha,

On Sat, Feb 28, 2026 at 5:17=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
> The patch below does not apply to the 6.18-stable tree.
This patch applies cleanly to 6.18.15, 6.12.74, 6.6.127, 6.1.164,
5.15.201, and 5.10.251, but I was notified that it failed to apply to
all of these kernels. It is not in the latest git tree for any of
those versions, although my other two "failed" patches have now been
merged. Was 6.18.y perhaps also affected by the <=3D 6.12.y issue with
the patch with \0 in its subject causing merging to stop?

Am I correct in assuming that the patch did not make it into <=3D 6.12.y
because patches in those kernels are backported from 6.18.y? This
would mean both 6.18.y and older kernels may be missing other patches,
and they need a new RC.

Ethan

