Return-Path: <netdev+bounces-261389-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SF1aN2ZeoGlViwQAu9opvQ
	(envelope-from <netdev+bounces-261389-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:53:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0431A8017
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E59BA308AA16
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C057A3DA7DD;
	Thu, 26 Feb 2026 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdPYyW5r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195543ED127
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117409; cv=pass; b=ZIPXyxGk0+3zAtTzOa1dSTvOHpI3zlWP2uq+hH4hBhXSImn6wjqPNwGUGHywMzZLGwSrArUsg0OA/ra/qE62BBkpXUOscT4ZPDZpaBAG6DPmazE9umjXB1Jl4DmqrxizLBZhyzjA1JhKQi0kXWm6qdgyX24K3mVCKFfFRF5h8+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117409; c=relaxed/simple;
	bh=KekDczAjttjdPIAASj6jFpKhDjUrSax8QhJzWPfsV7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qI+zEQxOEuTeli0M7oTvNBYecXB5fj8om2CicqRgJHvXMPWAIXrY9iKCmfZXQRY0fq8ryZo1MhBedr7XDo+u3yHDutP8TQJYXhohgaQzqeZpMnU3RFgGlH3flwYOhrDlMoJM7TL8XZOvjNlh1dEepPoAb5LOn07XDKhqBkY1CIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdPYyW5r; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a1046f62d0so1036112e87.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 06:50:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772117406; cv=none;
        d=google.com; s=arc-20240605;
        b=K+pmNXC2OcnfxdOxjErLFroFhnhChgSxqdfm2sny41xld0YaHToCHSxZUg+r9uJt/o
         iEtX5kA09597n+pY+hudRVk5NngolEQ0lhYu7x4bxTLch2coDMPJD76VX75Cn2TzRAMw
         +obqQk+mEUso4IAT3ybNfRDw+2zXVYPx+osKnWO8VCuD3N5yqLMwq1F7SVSMc7uF/PEW
         5vDfymX32KxST8bOH2NUL2BK5hnPMwV+5jFU6qmqdzoyeZeEen5uzLu1inSI5WV0W64g
         n10rAeWXv/fpxOK9qBYIF6eeJXO9I5UUzSxZNioJRn7+reh6dYOBaby4JndSsq7M7PGW
         QZ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ecLlC2Pj1S2xYZyAS5QAxZieaItgxfHsGP8vcA3A8mA=;
        fh=colE8CGCXdswpA8Jgb25aFckMsz4On4UbemyOeFeSHE=;
        b=h/ftUC22HnQBpRejzuaQKIoKCPWq2jze6qa2762uYagkHaurGBzw8x4dIP/uy2HhZf
         AZgnRb10VupP4ZuFn5pxd3boGYowb3exAXDl2tG52WevssR8wBb28vQ8dtfddaWwu6fp
         B4tuSoSjK8b/hvUuJkMfJOOnlvUZnl7zP5498u3zGECKQEujx3IlB57UkxZsLedwBNQE
         De9OIq710RELllBjQQP4hxy7FBOkTqk7ddSudmsuEsVK1tROINpUkNM2q7x7W5T6PNTG
         J/EnmAG49Y84VKlj69YzFHUvLdhKAAuN+yxg7lQ26E3euW1oV8jYwhf3REklABz0Lhuv
         w2Pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772117406; x=1772722206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecLlC2Pj1S2xYZyAS5QAxZieaItgxfHsGP8vcA3A8mA=;
        b=RdPYyW5riy4FOeIOdyjJyQeujVWJiwwhzTOL+9bk1LFsVQcivpOaprXkVBUm7FEp6z
         INfF46gVwjyC49J5GUwlL8IOot4UDi2phQqau++OfJuZQirewu2XI8osOuEu1dTmKz0z
         clUSDYbzL5pEMGIiiGonUw712pOwMI6ep+OKSDW6WT/H9Q/JeIsTRzAau3HJJ1vzihD7
         12kOb8I8F3S02eMQkosSMkFnwUmgYVlNsBZz+WrX0lAfOcNEeukdcuLDyvGe7uU5wQ/5
         CwKL7doi5J0ITE3BDMx3m03iqw0PkPMolGJoy6zhWg8G/peryZkeHBrVWwJy2f0cv/rH
         71og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772117406; x=1772722206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ecLlC2Pj1S2xYZyAS5QAxZieaItgxfHsGP8vcA3A8mA=;
        b=nOPm+bEULh/VDEHqivCknmAB+9POxWS/+J3k46ExOwBaLTrnyb5LOjqF9QVrDfXeO4
         s3YZj3caRxlNWGSuWSV0gio3YxRTbNDMCca3re6ybnq3K7KXQOlb7scKY+2ALylVq6cu
         bDS+AqpKpsySqgP3m1FxuAClYu3cPQamx/fWkM/qbCLbbdQyopHVSjYEAKbxrmPteHRb
         KSgbx1cA1Jq9PUF+jWoV2inqc9NPWR6oifY/0ajTKTdbRShlIhsVUQz292TNCyZW/R9N
         EUCbIB2x8qDNHeEt66tf/rAgr+xH3AFJqmYF/vvWsxa4qkvMGfJ0SJ1pfEsbk5CNtTS3
         qvkg==
X-Forwarded-Encrypted: i=1; AJvYcCU/UBuby9P6jp1IpUeb8zh0yEtQEUwo0LWL5UrFdZCNsn5NpwQaHY1l1DUNm1E7z2lDNHj1dFo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9IBUU3fAvr0kTHGJtgqznSKIsAq/BlUAD/Cjg7cCa9tgxR/up
	8BeRA54pORllz4mOUkDmz5MRe1nufawo/bOEXfIhrbFAZtQQEIZa5YVJGkH2fS9hCluHYPhQ6+8
	nq/4ATkPIZyz16UHeGph8wT9KyEdbcUU=
X-Gm-Gg: ATEYQzxEj67mpoOrti7wcOsKGXhORgZ/EU0GeoKuHtanhcOkE2sKUyR60EJju07aM7g
	AefasFz6CUqw6DkPjM50SdHgx1AarW+Ev7aJoyMvznoZ/wn33C1be64abMgKSjSenGMyQHbJH5f
	e9g+Zf4vTA4Zy/HB80NfkJgf/Fd04gvRj5P8KyTegjDQPwOCGkhn1rivandjJhLU09vzZof/YN8
	HiCTLE7l1nECZdoFAzPSGef/4H68AWke9hZj6h8VXpcgVZPyA/fp/UfSUwar49VY339KP5k8pR8
	J+Le//xrSr3rxVxXzQgeqWx7Mr91gPDEqlfHN09E5pjaDsNcnKlPJlgjY+SeOEJ5+pIbzFC8LaK
	LHPTAB0azX4zpsRVSKYqHaXAKsgg=
X-Received: by 2002:ac2:4f15:0:b0:59f:84ed:f1d with SMTP id
 2adb3069b0e04-5a109a8a3a3mr918865e87.14.1772117405854; Thu, 26 Feb 2026
 06:50:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226111721.25454-1-yuuchihsu@gmail.com> <CANn89i+rJeZHoGna5PGWN31UGDO3jy1xx-rWs0SA23H6mU6qKw@mail.gmail.com>
In-Reply-To: <CANn89i+rJeZHoGna5PGWN31UGDO3jy1xx-rWs0SA23H6mU6qKw@mail.gmail.com>
From: Sam Su <yuuchihsu@gmail.com>
Date: Thu, 26 Feb 2026 22:49:51 +0800
X-Gm-Features: AaiRm52xUwANJjZ_usW7QciNefjd9_CIm1_D3Nx375ksfqWn3AZL4KtPINaeUR8
Message-ID: <CAPAzCqEtb9r6pP+A-RjnAKeLbHJJs3Cc3PuGcmNSR9GpaCLjdg@mail.gmail.com>
Subject: Re: [PATCH] net: ipv6: fix ARM64 alignment fault in fib_multipath_hash_from_keys()
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261389-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,google.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuuchihsu@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,lkml];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F0431A8017
X-Rspamd-Action: no action

Eric Dumazet <edumazet@google.com> =E6=96=BC 2026=E5=B9=B42=E6=9C=8826=E6=
=97=A5=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=888:02=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, Feb 26, 2026 at 12:18=E2=80=AFPM Yung Chih Su <yuuchihsu@gmail.co=
m> wrote:
> >
> > struct sysctl_fib_multipath_hash_seed contains two u32 fields (user_see=
d
> > and mp_seed), making it an 8-byte structure with a 4-byte alignment req=
uirement.
> >
> > In fib_multipath_hash_from_keys(), the code evaluates the entire struct
> > atomically via READ_ONCE():
> >
> > mp_seed =3D READ_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed).mp_seed=
;
> > While this silently works on GCC by falling back to unaligned regular l=
oads
> > (e.g., LDR/LDUR) which the ARM64 kernel tolerates, it causes a fatal ke=
rnel
> > panic when compiled with Clang and LTO enabled.
> >
> > Commit e35123d83ee3 ("arm64: lto: Strengthen READ_ONCE() to acquire whe=
n
> > CONFIG_LTO=3Dy") strengthens READ_ONCE() to use Load-Acquire instructio=
ns
> > (ldar / ldapr) to prevent compiler reordering bugs under Clang LTO.
> >
> > Since the macro evaluates the full 8-byte struct, Clang emits a 64-bit
> > ldar instruction. ARM64 architecture strictly requires ldar to be
> > naturally aligned. Executing a 64-bit ldar on a 4-byte aligned address
> > (e.g., ending in 0xEC) triggers a strict Alignment Fault (FSC =3D 0x21)=
.
> >
> > Fix this by moving the READ_ONCE() directly to the specific u32 member:
> >
> > mp_seed =3D READ_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed.mp_seed)=
;
> > This instructs the compiler to emit a 32-bit load (ldar Wn or ldr Wn),
> > which perfectly satisfies the 4-byte alignment requirement and resolves
> > the crash.
> >
> > Fixes: [4ee2a8cace3fb9a34aea6a56426f89d26dd514f3] ("net: ipv4: Add a sy=
sctl to set multipath hash seed")
> > Signed-off-by: Yung Chih Su <yuuchihsu@gmail.com>
> > ---
> >  include/net/ip_fib.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
> > index b4495c38e0a0..318593743b6e 100644
> > --- a/include/net/ip_fib.h
> > +++ b/include/net/ip_fib.h
> > @@ -559,7 +559,7 @@ static inline u32 fib_multipath_hash_from_keys(cons=
t struct net *net,
> >         siphash_aligned_key_t hash_key;
> >         u32 mp_seed;
> >
> > -       mp_seed =3D READ_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed)=
.mp_seed;
> > +       mp_seed =3D READ_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed.=
mp_seed);
> >         fib_multipath_hash_construct_key(&hash_key, mp_seed);
> >
> >         return flow_hash_from_keys_seed(keys, &hash_key);
>
> What about proc_fib_multipath_hash_set_seed() ?
>
> It has :
>
> WRITE_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed, new);
>
> Which is IMO strange, regardless of ARM64 clang and whats not.

Hi Eric,

Thank you for taking a look and catching this!

You are absolutely right. If READ_ONCE() on this 4-byte aligned struct
causes an unaligned load-acquire (ldar) fault on ARM64, the
WRITE_ONCE() in proc_fib_multipath_hash_set_seed() will inevitably
cause an unaligned store-release (stlr) fault when a user tries to
modify the sysctl. Using WRITE_ONCE() on an entire struct here is
indeed structurally flawed and unsafe.

To fix the write side properly, I should write the members
individually to ensure safe 32-bit atomic operations. I am thinking of
updating proc_fib_multipath_hash_set_seed() to something like this:

    WRITE_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed.user_seed,
new.user_seed);
    WRITE_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed.mp_seed, new.mp_see=
d);

I would like to take a little bit of time to reproduce the
WRITE_ONCE() crash on my ARM64 device and thoroughly test this
proposed fix to ensure everything works correctly.
Once I confirm the fix is solid and runs perfectly on the hardware, I
will submit the v2 patch addressing both the read and write sides of
this unaligned struct issue.
Thanks again for the insightful review!

Best regards,
Yung Chih.

