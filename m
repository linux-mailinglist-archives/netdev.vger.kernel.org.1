Return-Path: <netdev+bounces-280773-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHv6EPQp6mnfvgIAu9opvQ
	(envelope-from <netdev+bounces-280773-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 16:17:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 342274538E3
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 16:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F2C1301FA7F
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 14:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03640313272;
	Thu, 23 Apr 2026 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bzi2+y7+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEFF310784
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776953608; cv=pass; b=CPKCmrcfMN28kLefwmjNgEg1CFUTSPe2J6NKggKpkQm6feNryhQ6rCbiaG4bOYljwemyuhYvnVscR2sIdE4ys+MLrupjZUpJ5cykWaP6VB6C+LQS2kf6vQ8c6HIfXRUuBP5jDZwnyLCvDun/p9aAeYUnJiC3MR1Bap/Cw5YPH24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776953608; c=relaxed/simple;
	bh=0bQ460NutEAohgKlKg7pb3QgzIUI2qAzqE+haI/6PXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQMCt0TZzsUz3RFUD+8Zw+TGTzsOtpWzFld+lfM2MBHhBZC/C/DG/WTzUH/O1zhucu6g1Y2s5AdX5wmKShBnWjyloxl27XhtqzpCWHD1VKfOYvhYO9hWszK/nTOaN0SYT3r5c25r/1SfB30a6z23n1c+wVFQfCmF3YVgsmG0d5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bzi2+y7+; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8e0a768331cso766456385a.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 07:13:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776953606; cv=none;
        d=google.com; s=arc-20240605;
        b=EA5mmEe9Cbz1RVw10yxNbsHZZMsjMv9V67rv5tAGauwtn7WiQJPuj5iFsveA2kxuE9
         6Y9PX6Lecfwdg7N9R6MJTUlknrlzpEeOn3YytCl8mkucYNH0GVwrPCct4gL8gnflQhS2
         Wpl7SGrhf1DyTD/bAczCiBWg8eV3OGuLo/fp9V+n+x3qS0+vUlu5hGkVe7UeK7MFQatT
         +5//WXjjIf9tk4TDe1+M9JNs0YT5w1Z3K9fb6vNBSnC6ugjlGlM5XM934t7bCklCCRqH
         60AO5yoIuJuIzlMt0vkRQ168PVcTdEnwd5NxFtuwvxHfsGY9Gp3LNG4yk/g+ym52I7A+
         27nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tIH0jZvzU45bMZufBbfy9KVkWm/IEExPt3ODNJE4bi8=;
        fh=JbqZAJzQ+M/t9YIAekhs5j5LY2AfaJq37BAIxaLN92I=;
        b=IyBlx/fZ9fNqawn83IzWbcVLr7eP/wLJ0aKV19jvIR5EfSImq7koyBkOvELjf0mQk+
         c9TbioyedhALOSovoWtNkyUUC7fg8swjsE8yH6geYlIwUQWgaKE1jqXWxAiFJzHJPK2Y
         KT2IgOblv85RI3YuzJ+k/SFFGa4XCZtAgV/98pAbZ65Go231QVjka/j5d8UcmfXanrVC
         Xt/GNEV+Yd8hkKyJU8q/glg+3QGjHMPQwS2B3UR1G1mlTR0VFN64JgOHzwKEv/6m8iN9
         E8KwaPL6E4yg41EUgrsNHPzP8PEg/AaIJ35wRhSWDatnpB8pAf0oNOIyCzF4EQrjYV3H
         CeXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776953606; x=1777558406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIH0jZvzU45bMZufBbfy9KVkWm/IEExPt3ODNJE4bi8=;
        b=bzi2+y7+7mJz7vNGAkPSIj0NiOMJLlMiju2lUy8sgBioha0vZOXCeQJ4i7Jm8OduT7
         WoVCdeMmMkI17/cOQxL60Nr8EmF853NWYUyd+ruifvldZVc+FufNUZup8YEHdv/8astf
         CKBwACAnB4i16T5Af6n393VxX4aWb07g+mx7y/ObnVL0LG3Hhf1VdEffvkvuMg5swXDt
         kOmQQwoidy3UsOoJJUMKLUGEPSJ1jaw3dVkU5q2lErc2gF/dP/KgVSo8ybtKnoM1dBo4
         JRIvBMYqWLHZZ/ipU3c7FgPeE56Nb3QpaUmCx5MML6aq8OEp6+u0ShUXBU/4+5a4/s47
         Tiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776953606; x=1777558406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tIH0jZvzU45bMZufBbfy9KVkWm/IEExPt3ODNJE4bi8=;
        b=O7kzNEmvnuCMNaUXIHgI87LletMs4Xthdto01bQPVtYD5mIqWg2LKF9TSOCt4Ud6TG
         0KV1plSSiPeq81NF3xsHT426nefdEaQupyoHI5TAa3h7nDr+1Hk2fhK7o15A1spcT/9p
         zi7OrbdzJmRvGfcUuO59Zk+YhrjWCqc9fE29dQL4nRjd4dol2k4L+Kr/xMAESsbUa04S
         eIU3vIn6hqf9n0Oj5hOdv7AYVwAjMdIpYe2iZWX8WlS2kLDSuzRuoh0556wv9KAK1Jai
         LrgnZhzrEb+/Mcz5jK0M7EVjqa7ClQwfO5FU+4gWzGOui5RNlOKPqKaPcawMAIKsvFVb
         SGqg==
X-Forwarded-Encrypted: i=1; AFNElJ+e2a7LgP5lJDLt2cX8Jf8EeX7o7UUsLJa6MuE3eddXrBV8bKS43cGgS1cxtQCKAx8J6tIT2Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQp1lIlQKqKj3ISnNF/SoZzKwzNYeutxzLUUr/gvmwMJokgmdK
	SInAH6A9NeJQTYhUPXIocx+slRwVZom6Dgd9rm98XhOA4qZWyQKbiFb9xFyDK4Z+BBnG0CcK7E2
	0Q1Cuy4Vr+3U884ndRahzI2tqaFGitLMlJQPuNJi3
X-Gm-Gg: AeBDies89hAvbbaKB+V1CwL2BWFB+hCm9b6OeEUH3Bwn3K33pwf2050L8cdOfcpJcNj
	Vz6VDsNBvLLofqVy7XU1mXxGDT7VbEOClBCHTXvWUW/6lWMZs3Ixw2R00chU6EGAZrY8fZKPLWS
	9LLR/+7iM9XT2De2Rr3wvqLKQAZUUTJhL6LHQ+cTmJOhruTztQDEt+qr4oiNWy/cuxW1x2SE0YE
	n+GhCBBMFNkW7/OzC/rozA0ayXusB5Ap3XGjHP1QHEvlqHDqoH4/NHEfUEoZsaqsrSXHLY66IU9
	G2le6lWmAw9crZqZA1yx/LowUBfHpWsF8BFzMWW+WOB/uji4II7npJZ8YPaOYKNQmK6zE4C2v0e
	zv/CXbFWZ
X-Received: by 2002:a05:622a:120e:b0:50f:b7b3:2ec4 with SMTP id
 d75a77b69052e-50fb7b33128mr136077101cf.25.1776953605685; Thu, 23 Apr 2026
 07:13:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423134147.1933565-1-eulgyukim@snu.ac.kr>
In-Reply-To: <20260423134147.1933565-1-eulgyukim@snu.ac.kr>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 23 Apr 2026 07:13:14 -0700
X-Gm-Features: AQROBzCQJWs7emvNW0lR8Wma2OF_--1-GrVK63kADmpiKgoV_HX9NkwXYAhdI5Y
Message-ID: <CANn89i+QSs6=GucTJfGqR+a8=NtgupFdrVqYNt9ZyZQi8WS8oA@mail.gmail.com>
Subject: Re: [BUG] KASAN: slab-use-after-free Write in sk_skb_reason_drop
To: Eulgyu Kim <eulgyukim@snu.ac.kr>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, byoungyoung@snu.ac.kr, 
	jjy600901@snu.ac.kr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280773-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[snu.ac.kr:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 342274538E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 6:41=E2=80=AFAM Eulgyu Kim <eulgyukim@snu.ac.kr> wr=
ote:
>
> Hello,
>
> We encountered a "KASAN: slab-use-after-free Write in sk_skb_reason_drop"
> on kernel version v7.0.
>
> As this memory corruption bug seems to require `CAP_NET_ADMIN`,
> we report this in public mailing list.
>
> We have included the following items below:
> - C reproducer (~100 lines)
> - kernel delay patch
> - KASAN crash log
>
> To reliably trigger the race condition bug, we patched the kernel
> to inject a delay at a specific point.
>
> The kernel config used is the same as the syzbot configuration.
>
> Unfortunately, we do not have a fix ready for this bug yet.
> As this issue was identified via fuzzing and we have limited background,
> we find it challenging to propose a correct fix or evaluate
> its potential severity.
>
> We hope this report helps address the issue. Please let us know
> if any further information is needed.

It seems we need to add a barrier on tfile->napi_mutex
to prevent tun_napi_del() messing with concurrent  tun_get_user()

Something like:

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index b183189f185354051bded95f43bd77ee4f7cde24..e85f9db4afe724e25f45e9b142f=
a678a244a533e
100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -289,8 +289,11 @@ static void tun_napi_disable(struct tun_file *tfile)

 static void tun_napi_del(struct tun_file *tfile)
 {
-       if (tfile->napi_enabled)
+       if (tfile->napi_enabled) {
+               mutex_lock(&tfile->napi_mutex);
                netif_napi_del(&tfile->napi);
+               mutex_unlock(&tfile->napi_mutex);
+       }
 }

 static bool tun_napi_frags_enabled(const struct tun_file *tfile)

