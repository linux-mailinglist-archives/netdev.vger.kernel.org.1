Return-Path: <netdev+bounces-262528-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SQQvHVAwpWnp5QUAu9opvQ
	(envelope-from <netdev+bounces-262528-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 07:38:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2511D381E
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 07:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38EC530292FF
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 06:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61213382D3;
	Mon,  2 Mar 2026 06:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyPjOXMN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6913172618
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 06:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772433376; cv=pass; b=t/rqolLb98g2oTDPanaRQyR+jRm7ABweYl+DUWR0wAQ8A6/7k6/1BryHR+x1zWiWOH52USAaEZ41LUFPvKhBXIFOOrxHkAstIRu6jMOUCpnh4msYq5bu24vQbLAfguzSCJUbnLyAawTkSddKRK0SWAGGPR6Vom0m6VaVPPTls/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772433376; c=relaxed/simple;
	bh=2mzkZ+7ay5mPOTVxHTRghXB7Yvl5MwH5CneKgQvRVOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CHenufigxCZc787urUpvcm4Z1Dpev6RW2Bx5JsvwNnR3G2DfYukwPfydwpLbBxn32cv36w/shM3AdQFWeFwhFYOdOPoQcRhjlCFdn1pEoP0z/FRDlpMfJiy0A5YQbWTz+wVNzLPJB4KR+l/CN989JYQNcJCjgFtD9nmhLyYKTlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyPjOXMN; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-389f933034cso50941041fa.2
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 22:36:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772433373; cv=none;
        d=google.com; s=arc-20240605;
        b=DDGQ+9dJI/lIiS/B/R+wv5GlCrc5HvA+6f0aJLjVHXyW1dBnKwV2zezJcFBg2Dredx
         ZoF5ATgXi1342ym/wxsaHSgaM3UlJUt354FfGN53NjZt3jgZ39tiWBxbwiNFl0JIEdjJ
         L3m5xXpG4bAx/yKv2H1ptlkfN9g74mTWavTMeVGRd/fG9ArSHVzFy8fCdNW4Y5VrQhFy
         wxfg8XvXaRPIr8NllWhan20WnBN4rToda2tqqAlmFUKRoktek8IQr7h9kU7ROU76hqCU
         cdCsbLXqF3xD46ckcUyd0FYr/MWptLWIRLMySc+VVAe04MsNVvUdW+flL3aB4xo0o248
         Xsgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9pmNPDeirZpzNt2b2qSmOZwVDIdXzjn8yvY6dGccuss=;
        fh=om7SFUHtyde21PzcP7OB6EYQ7teHhxWzyvXIm54iymg=;
        b=QwcpxGfXAV/ivBkNE/p3LNOhZgjpHCPA9h74kcQzBSOlURTN7w+n7SqHjvR6DgrfA/
         10m0ZuU4zQOAroj+qbxkikGMd5RbbO9DHYjtjGrYifqkRnYdUdKqM4bU1u5KLJDbZOgN
         YANP3JD9Hh/tu0R27c4jORQDJDBW8AoL9NYw6ejOP5Y/EfcUrpeBFwklZ2vfUotK0zrP
         IUh71aA2edLfb/N7ril7fvXJrN4KaL3W65xVMzmmF8OqTcxe4qcujm2s/eG5D1y76M2Z
         eCXJvMyne4FdKDhgjXmeLqGLThkobxd3hBHp+CrRxWroBRTRXbX5o+HBGMefz3WWK2K3
         +bGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772433373; x=1773038173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pmNPDeirZpzNt2b2qSmOZwVDIdXzjn8yvY6dGccuss=;
        b=lyPjOXMNlT3eYiz+EGbhGLVnQpSY0/XvpTOEVmi5CDQiNYhxXAPkb61SdJl2F7r3Uf
         dx+kyUOOgRhzzfDd7YuENd0xO2GRhttHPPRvKtE7Y3HgQwKjfFfqiTgfIy3KdKfkTp6E
         K1pc8rJPnAqTVQqFlQ5lUGHNDpTEFPTcu1Qj48YwRc23VUVVQE74eu3NyR68eloKgvzw
         YGtgBkj87iHKDZ8a+7mrr3nqQm0MO9UCMFtvjGbWZXJhhKLdKmu/xan8kHRG8xXM/a2f
         EeCRAosHD8dv/X+vELYp+Mrq0MSKtb/HI2dSSF7ZdRn93rxjIMhaKlq/oAOlt3IN2Uxe
         VdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772433373; x=1773038173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9pmNPDeirZpzNt2b2qSmOZwVDIdXzjn8yvY6dGccuss=;
        b=J/v/Cl8vnm0rRo7nD69svesiTvqoqyO6nsvP0WMOYXn8GtgLUe7cKbbqXOzf5vJd3X
         6sYMHYV9o+tI+tdLkLHmyGE93zXDmQ5ml7QELyuMzadsSVjpBzB8cAKuHS4F/Zc3CtVW
         Q80tuRZ+4oMq4BiuYh7DpSZlShzyd69UU0vhUHqlUFXvrUwUIYSe0mbZsM2GdLHJ812B
         UdNcAb/D30NpuFh41+pyObPJUj5S8sPNZtQxjIXjXdooPe1EiS84hRZUxcbSlwBs6LfJ
         8d4gRVDPzMPII3aRRl91nceaXU33XSRd4yEmXAzpXuhMbAzOAevHG2aWGtODQ0rMADZj
         /2ng==
X-Forwarded-Encrypted: i=1; AJvYcCWs+bdwmlzUWouznZWc4mBoc+FBszydMYQURKGyUOumhdJlM7cDoyt6gEyz89RbkpoBneEhrio=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRIZTYtUbwIkVhfeQXjlOs1M0168Yq8feMXgripsv8LT1msz9/
	RUpBznamG8tyqvH/BFUAwfzwvre6Jw9xHLkb3zIOxwKMEiiI8RgxzdpHcu8DRJyTUzDjedJqoLn
	vo4JRUfOjYiGrVzj7TRLaCuhS2QMnlgg=
X-Gm-Gg: ATEYQzzyAvbUfQjX9arh0irES6VH+zdB4Q8S000OsvR0TPU+Uo+yOn6GJSR36AjNuB/
	CTWa3EAQhgaWyHHrX1qm11uhY+8BsNdxIpRxf4cL9bp0wXFNOb7M23KjUmipiYfcoqyLxQEjrEU
	hMm95kjGX4DQBb94IoeUkZH6cPHRfLkbFqkwC8uTCSAokyZ/Pi+zlIr+1Qo+JcAUUQuJcN4zut8
	11rXyqaS/3blx7uYQnd48GsBPuMPcFAbadjoykxbxWq5DjOBcz3/U/IcB5SxuDW3ULpFPvZp9YK
	DqADyRv1iY6B+C9+Xg7J9HBp4jE8WykVtxzYtx8PAfSAr8/118RCu+/iFunrjgv5uoowHlJNfIp
	IdDHNZP8Vtw7p/wwNJ7HxUY3dHBc=
X-Received: by 2002:a05:651c:2123:b0:382:4d6b:993b with SMTP id
 38308e7fff4ca-389ff365a4bmr80217491fa.35.1772433372378; Sun, 01 Mar 2026
 22:36:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302060247.7066-1-yuuchihsu@gmail.com> <CANn89i+O5b0xfcP5GLtUopqHz2ppewK9zSr4995jsjCPM+3AFQ@mail.gmail.com>
In-Reply-To: <CANn89i+O5b0xfcP5GLtUopqHz2ppewK9zSr4995jsjCPM+3AFQ@mail.gmail.com>
From: Sam Su <yuuchihsu@gmail.com>
Date: Mon, 2 Mar 2026 14:36:00 +0800
X-Gm-Features: AaiRm5370M-3aS4oZ0cTBd8XDVVI1Uw-ouldM7nEfiGAhn2Xv88YDaO3hyfPcuM
Message-ID: <CAPAzCqHgoiMBC0=r0vAH6jP=J=HVVxDbnQjAUOcgR6MHE2mNsQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: ipv4: fix ARM64 alignment fault in multipath hash seed
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262528-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,google.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuuchihsu@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,lkml];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B2511D381E
X-Rspamd-Action: no action

Hi Eric,

Got it! Thank you so much for the clarification and all your help with
the review.

Best regards,
Yung Chih.

Eric Dumazet <edumazet@google.com> =E6=96=BC 2026=E5=B9=B43=E6=9C=882=E6=97=
=A5=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=882:12=E5=AF=AB=E9=81=93=EF=BC=9A

>
> On Mon, Mar 2, 2026 at 7:03=E2=80=AFAM Yung Chih Su <yuuchihsu@gmail.com>=
 wrote:
> >
> > `struct sysctl_fib_multipath_hash_seed` contains two u32 fields
> > (user_seed and mp_seed), making it an 8-byte structure with a 4-byte
> > alignment requirement.
> >
> > In `fib_multipath_hash_from_keys()`, the code evaluates the entire
> > struct atomically via `READ_ONCE()`:
> >
> >     mp_seed =3D READ_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed).mp_=
seed;
> >
> > While this silently works on GCC by falling back to unaligned regular
> > loads which the ARM64 kernel tolerates, it causes a fatal kernel panic
> > when compiled with Clang and LTO enabled.
> >
> > Commit e35123d83ee3 ("arm64: lto: Strengthen READ_ONCE() to acquire
> > when CONFIG_LTO=3Dy") strengthens `READ_ONCE()` to use Load-Acquire
> > instructions (`ldar` / `ldapr`) to prevent compiler reordering bugs
> > under Clang LTO. Since the macro evaluates the full 8-byte struct,
> > Clang emits a 64-bit `ldar` instruction. ARM64 architecture strictly
> > requires `ldar` to be naturally aligned, thus executing it on a 4-byte
> > aligned address triggers a strict Alignment Fault (FSC =3D 0x21).
> >
> > Fix the read side by moving the `READ_ONCE()` directly to the `u32`
> > member, which emits a safe 32-bit `ldar Wn`.
> >
> > Furthermore, Eric Dumazet pointed out that `WRITE_ONCE()` on the entire
> > struct in `proc_fib_multipath_hash_set_seed()` is also flawed. Analysis
> > shows that Clang splits this 8-byte write into two separate 32-bit
> > `str` instructions. While this avoids an alignment fault, it destroys
> > atomicity and exposes a tear-write vulnerability. Fix this by
> > explicitly splitting the write into two 32-bit `WRITE_ONCE()`
> > operations.
> >
> > Finally, add the missing `READ_ONCE()` when reading `user_seed` in
> > `proc_fib_multipath_hash_seed()` to ensure proper pairing and
> > concurrency safety.
> >
> > Fixes: 4ee2a8cace3f ("net: ipv4: Add a sysctl to set multipath hash see=
d")
> > Suggested-by: Eric Dumazet <edumazet@google.com>
>
> Nit: Use of Suggested-by: implies I made the original suggestion for
> this patch (before the V1)
> I simply gave a feedback on your V1. The idea of the patch came from you =
:)
>
> So next time, do not add a "Suggested-by:", as the expected step is
> that I add a Reviewed-by tag when I am happy with a new version,
> if I see it in time before it is merged.
>
> No need for a V3, this is simply a reminder for your next patches.
>
> > Signed-off-by: Yung Chih Su <yuuchihsu@gmail.com>
> > ---
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
>
> Thanks !

