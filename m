Return-Path: <netdev+bounces-267731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJfCNBxRtWm8zAAAu9opvQ
	(envelope-from <netdev+bounces-267731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 13:14:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F90328D11F
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 13:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50366301C8AF
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 12:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3C02DC321;
	Sat, 14 Mar 2026 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lpphwSJ7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D6B2949E0
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 12:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773490244; cv=pass; b=j7yHNMO2NRmnsokfmPJgxLsa1geoiZZs2X2/PceIAjmNE9T935ne4fq5mWzZGq7roPrOxVzerw8B6qmgglIrTE+1Hh0Z6E687bcgmGfiK3zg0CLo1cXgjZIuVVduyI3zVXBX8Q8vFL6IoXlWv1Qg4Ewv6VykehCGhmHckEDHLiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773490244; c=relaxed/simple;
	bh=VUaaW9YKoMX5RXv/duMulyfXlN+F8set/Og1a3fP9OI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B40AK2Lkj/4JD1J68CnU3i8xXW7o2Y86J/HRSo2lNBW452dNzdYWDfx+DYgaWVmyXOtrlBnrszaOQ7i4pg1SmQ0KVv1QSwrN7z59bMNn8TnGDfCKv5+RYdDHwdoi2lT+9MnSSTsDvF75NuVJIRvBDzO82HwH5Rm6DUF98ezKMwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lpphwSJ7; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-509149ab7d7so25814441cf.2
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 05:10:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773490242; cv=none;
        d=google.com; s=arc-20240605;
        b=WIrYTjN51L3VrEjFpQnVrEu8b1H++Sfafz8amGPbip+IofhuRwku79Dypu9e3k7P/7
         4vATqRunxaKpO1WuRKElYbyGrNypD/Ce6VcpQTsXTgLXqOKIQxVtCh86Qz5w5h827wCj
         v8cdc/43G8rRm5gVAgD852tOlGihUzwPDDyP2I2b3SqUhI/0k6ys59oQZmvB5180Rky6
         cuyUN1Q+dxlaXIJLSvwGC+z8OlEdyfxiV6frgSXpgoXDKueW2L4FIjoozEpNqD3YmgtD
         DuXv+FhSCJxtJE3wetSJZPRWknFaPUyYKfBepMDxpl8mxxw6SEsAM8lkvfL3wsy1qntr
         1Gzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VUaaW9YKoMX5RXv/duMulyfXlN+F8set/Og1a3fP9OI=;
        fh=korTvr7XNf6lHFHgpUjEi2ki76DyiavlmYhG6baTc2s=;
        b=a+BWnAXd3ndBHlBCCsKAUgIh/qqN/2T94pCcoCO57qLc8bxzPSY/Jni03AC9UYDe1L
         hmSiLThzYORrgN7dM1Hs38iFEFQSO2FyfpSQrAHugxLB/ku1eeOSzdbEgCfx+dFoM/y9
         G2qYolC/oYszsXxZ45T5GSqm8asnZObTAI0YpL2ReOGwHI24gHduSeGxq7Ciw4RFO+vu
         8PtxzciPKV1ZuhpFhK5CqF/Gy3L5YgF4jgOhHU6VtwceIvnYZ+jK1MkV9P1vfZoW2ZfU
         yy8VjqATXAHkbLDAabjxE7lT4mY7hGQuX0/VdRLONf1u6bx5toRtI6LuMDQS/CwHZfkb
         +HEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773490242; x=1774095042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUaaW9YKoMX5RXv/duMulyfXlN+F8set/Og1a3fP9OI=;
        b=lpphwSJ7Phm4vHmPdFbyj/C/QLczbFTdGCLVo6XrgapVr2Ny5GjyDm0y9/YvxIZmUX
         sbFyl1B42/ZmRaN1KL3qb8jxf549x/MgGAvfNW4pNHIeltmW01p1SvEnQ8VMi1IiTyRO
         XD8M6DX7BdY3h+l+8Ww5YbkiqUa7ba8ryN3tNQe5O4nZN/B/N8ZkSYEjjF0aAVE+w4Q2
         TDAjBArTxULKx9h5YyKMsgz6oXVwnb0nGjtXLqlNsERlBEFvJtOEn4li7CiCj647UTok
         MZs8+BhU8BsFAQKRnKN/tcNSOi8AJlKgNSz8Bfhjmc/DdQQ0/4vqjUUyBbo7Zrd7NIxw
         eq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773490242; x=1774095042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VUaaW9YKoMX5RXv/duMulyfXlN+F8set/Og1a3fP9OI=;
        b=sdqbTH6Uvftht0JLRettK+HSnoVRhyBtMSGVBoArXGZqy6X57lsvuJr+YRuYEH3mQU
         u8DRcnswvgNOP5Nye5Vh74La+a5phH9zRbqRasGfWIGKyPWvwxOZidF0LSFGYOYN/j7k
         Vz1qzKTLLXfLUpuVl6G6oKUXBKkjOJfs3+Aoue+8Dj2+4nEz5SeKlLZ1m8A2d97eNc1W
         BsdZ0jB8KDyR6V85NCX+9xOol7Lo5tbHnyysM/CqnZzfw68jUyHWbMK39g2IOfv8PYRU
         /OggHTXdBNmEHvTmmMWUOJiWjjh6MiohmwoWP5iyko9TcvcdbuzIya3Fa0rkjTD9sF16
         Z0Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUKAL5T65w98LzIFnv9Q/rK4Ghnb5NU1uuyBKua6fTH7BXe845bQBMwOcXdcWN/qblb0Kl/I+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8uIgdv3S+/TyDPu+qTlbJtl1itfpQi0XAVrbx+rkp9WwQSqJG
	fZW2zUBoHUF3P/WCHxXtHdhAS6WWkdWNIbQToBaVzj1/mxzOAPkcu/c2QF5sFV6LLTFSKkwHcxH
	7/SOiF6yDeiOA6YYkFEF683XNTWFUBeN5AhAVzVMs
X-Gm-Gg: ATEYQzyiHo7s4m3ELqByby56bvKI6suoRKhLTgpfC24tPxbyOfwk1MJJtix76fIR4hl
	28fKWPzVESmFKyh7jkPVVe1TLlG/B2kk/1tj+raTUtHFTFPPs1cUVedg+czoOE1phudyiFIYZgT
	2/5Cf0Kf9XfFY19rbuxuR5lkedaTuqVU2fxzuCG7mt6+uwCIh6V0OLs5i4WCQ2ip0KGx3CrtbPv
	W/1EjD7u7us2ZTHeo+W/5PjgNmBZvF+41pS0Og9SKeSnghb5Q7wGr0rWO63mgplO+2jKHcMCPwg
	+tibEx6I2kWafiCKyQ==
X-Received: by 2002:a05:622a:4c7:b0:509:31bd:3de4 with SMTP id
 d75a77b69052e-50957e1a06emr81652201cf.56.1773490242014; Sat, 14 Mar 2026
 05:10:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309155908.508768-1-kartikey406@gmail.com> <CADhLXY7gQ=OgC1dVdRHF31CLww+J3-KePfvoKJMm8gxRZzrUmw@mail.gmail.com>
In-Reply-To: <CADhLXY7gQ=OgC1dVdRHF31CLww+J3-KePfvoKJMm8gxRZzrUmw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 14 Mar 2026 13:10:30 +0100
X-Gm-Features: AaiRm52gcEsQOLqYFPzOydzRzWmPz3dQPD6OU7CMegtyCGUguptBCTXHy94AOjM
Message-ID: <CANn89iJ9Vc4aaZj9SUOoy5ng6LEy+J8df4EOHaHdZNk2m4FPhQ@mail.gmail.com>
Subject: Re: [PATCH v2] atm: lec: fix use-after-free in sock_def_readable()
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	mingo@kernel.org, tglx@kernel.org, jiayuan.chen@shopee.com, kees@kernel.org, 
	netdev@vger.kernel.org, dan.carpenter@linaro.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+f50072212ab792c86925@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267731-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,f50072212ab792c86925];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F90328D11F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 1:00=E2=80=AFPM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> Hi Eric,
>
> Gentle ping on the v2 patch below.
> Please let me know if you have any concerns.
>
> Thanks,
> Deepanshu Kartikey

Patch LGTM, thanks.

Reviewed-by: Eric Dumazet <edumazet@google.com>

