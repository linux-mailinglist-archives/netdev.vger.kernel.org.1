Return-Path: <netdev+bounces-274409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB+EBqgdzml7lAYAu9opvQ
	(envelope-from <netdev+bounces-274409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 09:41:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C532385542
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 09:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FCC8300C98A
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 07:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9494537BE92;
	Thu,  2 Apr 2026 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QH7rZVGT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B29C363C59
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775115313; cv=pass; b=IzOGhy6tg8gj8wf8UioL6jQWuBx6mNWQCCPQs8rsogTVRt2uHtALiNEDTGcWuRMN5lvBWbR43FriIYCxu4mdyk1M/41O2Dqo4swdnuli8oJZ4OkEmMtyrxevslBACQSre1D8tpSTe9s6C3Og+qogvicJirD1HygOO6af5UIj+xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775115313; c=relaxed/simple;
	bh=4WZbWdaZj+aiRXHDL/W0FOItC6o0fL8KJ89SbAOpabg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6/i38OcQhq2P1hGaqpGTEekpyE32MmVB7DuNiluGexLWs9Lx1PZLUdanzyBDzc+oQM8J0rwE60ddLo7KxW9tPWm3nbTUGF6LEprsIqFetWt1J9Tf1q2ORlrP/EN7fwHICWN9lowEY4bHnnT8RCrSLrgB6Ta457v+4Yy1MROgc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QH7rZVGT; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6501725d888so463054d50.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 00:35:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775115311; cv=none;
        d=google.com; s=arc-20240605;
        b=KMVLY8TcNFRpCSUN6d0aslc1U8MW8ErVUFfl0SmS7uosc9zrUEon648D52gPxUSeKh
         Sd5P5teC7qB3UyTe2HXpjj9hBp95bL9RTUv8gZfDLYDQrmy12EklE97lIrsfIgzmnaaq
         0PasZxLwYHFqQeys+v/Fd65BXA7DnFBoGPp0QTTJQUz+KJsgHLJydAp+lhSMFfus+Q84
         emIcPTWThBMFnn7BHm6SGjAuF8xT5qMd67Y1U/yLMT6CzgzURamYXnFliTSI8aza+vIC
         ZOALEFkBu3s4kh0GrLC7P93y4WC3R5sBWOGOPSlVsWPhPyEN6xvVTN4xJTgHy484Z6Vt
         W5kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4WZbWdaZj+aiRXHDL/W0FOItC6o0fL8KJ89SbAOpabg=;
        fh=S91A05Dp+6fdykv8lHWEy4Ja4mDRUNj7NFAYJj1aEpc=;
        b=eTzqbGyXvk4qbLhj0wWqwmsyGe26R8S1R3nam0s7upUo44XmCwNkoEnH6fLKZ/HjlT
         isbERIOWQvMWUrYhho7WNhHU4/CdAneWvb8R2N9WNvJtW0D8CbI6CiAXTmB0dPGA3MR+
         N752iuVYELudMdCrRbP7Z0vmjfX0/sVDFwblsBdThxMvvNLAmG74d4rXlURsbmAitEv9
         GijikrkLWgZjkxR/rEh9kpTFGyJLY/2itUomj3a9XQHGuxDJsPsQk/my3SIMQLZ8Zv6q
         LyRa8UbO8r4bFLqBUEN0xpPEqj3bVvrgs0NBlXxHUur8fPBCVGkbKtQIylPGetK72ebO
         ZZEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775115311; x=1775720111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WZbWdaZj+aiRXHDL/W0FOItC6o0fL8KJ89SbAOpabg=;
        b=QH7rZVGTbWA4f9+JjY/cDmQztxTl89aBMg6BCTWz1Tw7VeFCCzyELTOojtaBixeXVm
         k1A+6eRSmILRttX+P6mQy1HIqNZh+SE1tmzNVFgpkqODrtonGXsBeJRh/4mlv7zN4Ov8
         VQe1D15RXu0GBUjdPTHcUdMLSfVTnpm0pF8lfEq5AhIsEyD3hKPtBVcQorIZef9FuayS
         vhPFE93Xuw49dbepnSY6/Fa9pof1d+EgSQewvJummVmBt0gmOnfaMRzel7dGkECGLM6Q
         7OlVZ/MShIGRm3e20PWls5bClF6wKYN3WaD3wpEUy2je4CVGauktPCSXjJfiON1/a3D2
         97eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775115311; x=1775720111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4WZbWdaZj+aiRXHDL/W0FOItC6o0fL8KJ89SbAOpabg=;
        b=cOsZLxAx1YCD2SO52h7EgAD9OMrvRu1Kw2HabKSZVfaZhRN53aLmKFUKFEeQPb2P3R
         j7jJA/f+bRGdf5s1yRGtzZmNKDTZOK8C49kVfzzCwrM5IgC7J191AGNW6sigR1W84D3S
         JO+bjNxhJijvWvLLvpP5+cB/g9q+RHdkLE2g5JHMGlR4BAiIdUFV71BuFgYGxczHvKPV
         NGWxD1mUGR9wBtzFNPQOR1Z6rEGs2kR7y+dx0b50BXqVVibRryDLr8rNY5CKnKwNNegp
         +tpM1ojw0awLRh6oAYdMqug0WbCAdfR309VlVolHe06LVPH/OBej0HkS3XmFrar4h4+V
         zaFA==
X-Forwarded-Encrypted: i=1; AJvYcCUXBe8O09Q7XDyNpeWkLUHDCHt4sKRLYybGxju4WjOJ+u+LJkGzxVujU/UWUNfVfJluyStaMaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG/N5s55cOx40s6Giun1HSR6NqK1BQPwICCs9wFTb1N/dWuohk
	Jlux56ep83tKvi8mTmpDGeJ5LnHYxe7vKQL/1Rc0Je01YeVGXMmtgQd16z0ODBjsC3qG3m9kCaA
	hVwLf61FPYf5UrV0pxrRvMep00JiTRIU=
X-Gm-Gg: AeBDievtwjFSFuyevAId8Yy/ZiEx+GCZoBj/20ZRJhjJN7sO6zCkJz1nTi7s1/v3dmk
	CERdmvXzAh9PuSRZsfXblO0luSdRStIvq0MVXDvowFUO7xx6vqhHymHgkzbentFYry1vtaA16zR
	WCldoKrFCZWFKfJl/qepTBYpeYx48xR1UzIWtix5RllIzJqkvVzyIYTJOAu2Gcg/YghmIVUWb0M
	UTJVLCPN1uqdkifhiuaiBsTZgiOjuvlUtjVomfxY6gZk1grOSWwyJC6VZP66Gm4RKY7vD1Ttd4w
	JeHea0e+s1f/ntJCzEGDUXsl1XmqNFWLMuIJr+AFapcfsH8uVDJrCU8u0OY=
X-Received: by 2002:a05:690c:d88:b0:79a:bde3:7085 with SMTP id
 00721157ae682-7a2100bf842mr76036047b3.14.1775115311413; Thu, 02 Apr 2026
 00:35:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260329161751.1914272-1-sun.jian.kdev@gmail.com>
 <ac2ccb5NBAB3Zq1D@devbig1721.ftw5.facebook.com> <CABFUUZEdh2-bpYG+inQeUwxs9UC7D-xm5tR4RtAsPHrG58WBSg@mail.gmail.com>
 <ac33zzsqHlFc4GgE@devbig1721.ftw5.facebook.com>
In-Reply-To: <ac33zzsqHlFc4GgE@devbig1721.ftw5.facebook.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Thu, 2 Apr 2026 15:35:00 +0800
X-Gm-Features: AQROBzAGyqvst9G7qZ8r8l7tiSSlbGVenVi6I-ak5gjRimBy2L_G50SUsSx8bGU
Message-ID: <CABFUUZEv6_nwAAqicfG7SgO_9nY2Q-V2ZPxMsMLq7Sp=VNkfqQ@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/bpf: Reject malformed IPv4/IPv6 skb test input
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274409-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,619b9ef527f510a57cfc];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 8C532385542
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 1:13=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On Thu, Apr 02, 2026 at 10:54:41AM +0800, sun jian wrote:
> > Ack, I'll respin a v2.
> >
> > BTW, v1 was mainly meant as a minimal proof of the fix, so I
> > kept the existing structure intact.
>
> This is already v2.
>
> The minimal proof of the fix is a selftest for a tricky case
> like this, instead of spamming the list, and now also the
> AI-review tokens, with an unlandable patch.
>
> It is a few line change, and I don't see how duplicating the
> existing switch case makes the RFC review easier.

You=E2=80=98re right, I just noticed that I mixed up the version number.
I'll respin a v3 and include the selftest.

Sun Jian

