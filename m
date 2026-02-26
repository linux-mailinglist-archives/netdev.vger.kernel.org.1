Return-Path: <netdev+bounces-261317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEZ9Dj43oGkqgwQAu9opvQ
	(envelope-from <netdev+bounces-261317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:06:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C63E01A58E0
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93F46307D82B
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5658C3803C6;
	Thu, 26 Feb 2026 12:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ao5mVLq6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D4F18BC3D
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 12:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772107367; cv=pass; b=YqzJsUzcGhI5Bi4M4cFff4AGInTUtE3F0YLLM7YiYMo+/2vtvcqTWc/ZKV5M/2YVB8+u8AQ+qY9Zf+e1cERjraaNEqN32aE5BDo0He9T8c7/Y9ppQofPkg2Qbq9Ok7TmNWPuAASxzbxbrjfoV7DKHfXDH6PxXWal8p3yTdAK6/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772107367; c=relaxed/simple;
	bh=fHxx47e62Ab7AB98KxFyfkkORZp6y4ke1RxkXL5ZGIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHhNi3xWN7pnkBpHyuc7FVRbGR6PMtH9PlIjOm/HRdDyAFWfbfT6m3JHPIPyELlFxS81TJozNZEMEV4aKvWfKTcrNjq3yPsAWyRofa93b8wAf13Q0QyECShfD8QnsmEG1nZ+/cleLNwSVKDGp+IWg7K2zxr1qTSt70FtPH91KBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ao5mVLq6; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-506989e8516so7745091cf.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 04:02:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772107365; cv=none;
        d=google.com; s=arc-20240605;
        b=RKDG9g65C76KCovmJ5LuMVFazSTHGuz6Ji3tHTdpb88DANjDgL13VLGbB3I12OJPpP
         Be8JG925em6aDdECGWV3CdUZ5kOoGbnzgoosvU14pceEdDGT0SFzYjqmrlG8lFpUB3fa
         ahX30p7IprGFSOveHqG9tt+Cn93ZUh8YkTe5w021afz6pkXsHRDExVVrR5OQWRYODrH8
         hRc5EXHSfcM6/eOl8TBOCFdgFegRuk9Npb+Ofg+IoSqNzv/wtbS+svlXloYaRnZBaj/l
         U6dCJCgppg3h5YUZgu+iW32t+QJkIGcFf7W+b1sxesljaYGKRUhA5HXuUuUghBhKP77C
         nxnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WTO8df51m5646oak+wdzFx9B/WJc7HZU55MTR+mSHDU=;
        fh=n3icroo2Gbj/o0+qWLCbvZ70kfxAWJocRKUBsTC2NPw=;
        b=AaRLqmfOKy7JT+vq6LWzzDC0HL1DWJkRaDKEeM7jZZYKo/sRCdU2coH4r+HDRg6ZK6
         H7lTB55EIv7bHjKmo6r5J8UXgINIyHEnVeeLFiBdnOQhDp/iqPtVAZcBoXr/et5HGBj6
         aFeqyU45rGKcl3jHSbC/YyoH4yu7FLJj3/C3a5gz8MYHO9y3NA41FzgUJrf1aI+qh98C
         OUZ1+PZkFrBvQy4lO+tR3nNijNbfrK5+F824wYyutsMfosmpddQQ1cjU5wpQB5XruTKs
         cdSSRe4kV4cMkyasHMyVOagznCuP3v1P7ibvaIOhWWhqKd9szFI3cF/AnADdur2UzGzF
         DSXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772107365; x=1772712165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTO8df51m5646oak+wdzFx9B/WJc7HZU55MTR+mSHDU=;
        b=ao5mVLq6QFnmB2NeyDzwo/+IorfyoFeg/cddjuoQKY2Z697rT+W7Sc+DtOZ+QkVtaX
         ksfuRbra5FivJAZacCrVlqdKQJS0bTVNKDXUkIFG6aUZnMoMPWE94ybw9mjJnfLYoOzP
         RIwbzT4xKnR83zblzVGufazrMk/To6c1EocV3P2M9kpmHNewE9Fz9f0XCYkbSiqBEBPH
         SKTUdjprYEnDh+w5Dx+eDlS/wa/gpFxZX39RmHqom6LncwIte9osOa0aYmH6YZP89J15
         fcLJCTLamKC1/wANUlZGywIxuUOZEZMMLxfjgDo/Mdwdy+RveHDX404mdRJ4a0DNv1Br
         qe6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772107365; x=1772712165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WTO8df51m5646oak+wdzFx9B/WJc7HZU55MTR+mSHDU=;
        b=cYfValWm29zPYx9tz+QevJr8rRpdqzjdvazXaLO81xEVViNqL1QXtuXnwpLk+Z2qS5
         MfGztFoIxUnCbOs9td2jZ5F0hpNyvpg9hgEp0nO7xYhgB0tq9zwi9jM6C7lE69BThxA2
         eccJK8IPNILQTyXEj4ACYnwSX0iM45i1kig5ANGRG9FPjLjw/Cn+H0uN0k8f2dnvvL2Y
         eK+en6z4pvm2auhhEvmfTXYWo8jjG4fwq8nA7P2LSKaPpVhCQZkUpFwWDSWDafaziWNR
         3FARxklblnhr8WloSPQA+C28481p9CELTOguXncw69jCYcnhwG6ORORmXVFJqXyigV9m
         YFtA==
X-Forwarded-Encrypted: i=1; AJvYcCVD5EQGxkEauXmDwEZN6IXuqglo81Ay9dPR6jyslMPwkKWnlBsWuYCoZQFStbz2lZN5Pi2p2a8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrCwdUMqJ+Pq5q5yGqdQCuVuUiTxxD6UgIjwV6+tiYZAxn83jk
	JqYSWpipgBOoM0BFcp+P54Wm5XnuDqk8/2dTdunAbatlq8INfoX1HjQpKrOEUeYz9fVL2rHEU4A
	PZ3cE9oE0o0kAU7oR3Z70MKAP1JboyQOrovyKDWiE
X-Gm-Gg: ATEYQzxbg06TOz/KvGeInQ0pbvO9nfF7+1iFccrWiXqy1uUC/IzvxLWVGnXkmJjRCVG
	HrGHQQs7Cl1zo2FVKUKHM/nUeMax37B+NFdqYYPu1rN9qiViH+Dhb2Y9xfO0FYITfh7ld7yqUvg
	SsQqXc2sRHtVBaKVQgZYYCmC07+Tnlci8WfQF9oOhg67kP5hucQtMRKu51KgwIu1lpUgPymoL94
	JIErWMFVNzAHvC4JtV0WCCM1rFJ7L+bpVft1FZqywAODjrZ3ZFvopmDei6aCGGjkoHQBCn53bLI
	XGTzm0HrX943yxYZT6Y2xbGZO/dUYpKezKXLgX6yDoUchNqYSwc=
X-Received: by 2002:ac8:7c4e:0:b0:506:1c3b:c896 with SMTP id
 d75a77b69052e-50745ed2822mr19991151cf.11.1772107364456; Thu, 26 Feb 2026
 04:02:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226111721.25454-1-yuuchihsu@gmail.com>
In-Reply-To: <20260226111721.25454-1-yuuchihsu@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Feb 2026 13:02:31 +0100
X-Gm-Features: AaiRm53OMr1sZRwTFEY50Od6VH3Wz_vM8hHKwZUR308MKmTdUom4P_0a0eb-MOs
Message-ID: <CANn89i+rJeZHoGna5PGWN31UGDO3jy1xx-rWs0SA23H6mU6qKw@mail.gmail.com>
Subject: Re: [PATCH] net: ipv6: fix ARM64 alignment fault in fib_multipath_hash_from_keys()
To: Yung Chih Su <yuuchihsu@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261317-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,google.com,vger.kernel.org,lists.linux.dev];
	TAGGED_RCPT(0.00)[netdev,lkml];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C63E01A58E0
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 12:18=E2=80=AFPM Yung Chih Su <yuuchihsu@gmail.com>=
 wrote:
>
> struct sysctl_fib_multipath_hash_seed contains two u32 fields (user_seed
> and mp_seed), making it an 8-byte structure with a 4-byte alignment requi=
rement.
>
> In fib_multipath_hash_from_keys(), the code evaluates the entire struct
> atomically via READ_ONCE():
>
> mp_seed =3D READ_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed).mp_seed;
> While this silently works on GCC by falling back to unaligned regular loa=
ds
> (e.g., LDR/LDUR) which the ARM64 kernel tolerates, it causes a fatal kern=
el
> panic when compiled with Clang and LTO enabled.
>
> Commit e35123d83ee3 ("arm64: lto: Strengthen READ_ONCE() to acquire when
> CONFIG_LTO=3Dy") strengthens READ_ONCE() to use Load-Acquire instructions
> (ldar / ldapr) to prevent compiler reordering bugs under Clang LTO.
>
> Since the macro evaluates the full 8-byte struct, Clang emits a 64-bit
> ldar instruction. ARM64 architecture strictly requires ldar to be
> naturally aligned. Executing a 64-bit ldar on a 4-byte aligned address
> (e.g., ending in 0xEC) triggers a strict Alignment Fault (FSC =3D 0x21).
>
> Fix this by moving the READ_ONCE() directly to the specific u32 member:
>
> mp_seed =3D READ_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed.mp_seed);
> This instructs the compiler to emit a 32-bit load (ldar Wn or ldr Wn),
> which perfectly satisfies the 4-byte alignment requirement and resolves
> the crash.
>
> Fixes: [4ee2a8cace3fb9a34aea6a56426f89d26dd514f3] ("net: ipv4: Add a sysc=
tl to set multipath hash seed")
> Signed-off-by: Yung Chih Su <yuuchihsu@gmail.com>
> ---
>  include/net/ip_fib.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
> index b4495c38e0a0..318593743b6e 100644
> --- a/include/net/ip_fib.h
> +++ b/include/net/ip_fib.h
> @@ -559,7 +559,7 @@ static inline u32 fib_multipath_hash_from_keys(const =
struct net *net,
>         siphash_aligned_key_t hash_key;
>         u32 mp_seed;
>
> -       mp_seed =3D READ_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed).m=
p_seed;
> +       mp_seed =3D READ_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed.mp=
_seed);
>         fib_multipath_hash_construct_key(&hash_key, mp_seed);
>
>         return flow_hash_from_keys_seed(keys, &hash_key);

What about proc_fib_multipath_hash_set_seed() ?

It has :

WRITE_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed, new);

Which is IMO strange, regardless of ARM64 clang and whats not.

