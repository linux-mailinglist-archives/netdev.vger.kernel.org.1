Return-Path: <netdev+bounces-291027-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eG+9DbExEWpFigYAu9opvQ
	(envelope-from <netdev+bounces-291027-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 06:48:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 736DD5BD23C
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 06:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85466301727E
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 04:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01AF13B7AE;
	Sat, 23 May 2026 04:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZYZ1iIUQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6313326290
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 04:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779511725; cv=pass; b=IPuWsDcAvQn5Qjeejx4rp+poYaulvIOmrCLvCZKmafwSin/kxyqiHbwsTIDBSmGp/w9GP9KuOsJzLqJ2JYD/wogFdvmzW8NKXzBJl/BbRQg9qTbVRB7VWo8iRlUxDiE261BfhPQItcQ/hav3w4mcfrEEK1SvCQClbNZLpuT+VVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779511725; c=relaxed/simple;
	bh=jmasaC7BFV7FucBVWD3xDkqx+jHbGpy1vPv1Ad8i/zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsR55WFDqN7Tji4oNyQAG9tGKZcSf260A3iCLf5Yb7GMJke4XAzDR3IDFS0/W+MsZV5DiyJP5HGrEoPKF9/BuP0oFswrSqqkLNGE5ds1IZmt6xl6f2FWL+FRGT5xpPQhBLzCmlnvcE0o3BijhvFliv74WOh40LLo1cradCh3ScU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZYZ1iIUQ; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-9144163319fso789076885a.2
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 21:48:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779511723; cv=none;
        d=google.com; s=arc-20240605;
        b=gsfCwwTOgF9fyNC7F9fljvaVHtraRvdY5ezCB/JANUpssiI4lUwV3oDQ/9f2+zIy+P
         PuklgUA002hHUGy1iiTQs63tZ4Qm2UQ721nufwYBdiD1iw0lQcPLeufKk2gPF5l/hmbw
         riSUnFdInjTDDVy6EVw5x0mzzLo3qFhFxRn9iGkhPYrTfBqLc9i6kf/gW/nfDhNv9d6z
         C1YcCPCYLq3B2Gd28ffyCiFn5NGJ6mAABEGBRZOJDyT3iHbafjSShgVy+kZUGo5NfkBA
         VyJwAf3tF/yzoejBlho+yCfvlo//Z9v6SSZw6Ja+9k9YsKM+nYkJIYXg5M18iAJVxCxU
         O/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hvr90Zp1niDKu0ILN8c2RkvDAwkHhINjolqUy/3DM9Q=;
        fh=oor6I1vuHxZcMiRT2dI4vQ0K8wwagoYQJyXScSkxLqY=;
        b=jmTGAIZreajnjs17X6/6xJVSvix+jQcDgQ+Gsf3bpiHm1qlvY8R87Std3TyuEeX1cK
         HpHffELC3jqvhHpbs1FIbOrzwu+4uIhhZ2mribkx+blA1TIiW6z91198F8welFwpvkxl
         d7qhEurMn9Bo4wjVNyXF5J8JpLdT7TjMS/mqeTq/N2XJXUdIx0I2+5r5CrXV/UJmA8w2
         8AWB7AWaYcIZu/5v1Y/P58Ix3yo7S+QbKb7AQxl6+ShZvXOfS9Ha9B/pjZ70rNfdv7Vo
         +IVBvzf3xYoVepktC9FttEiLywrdbcxYk1hoBXsL0QgW7FxHJoVHuk63X1LwFMK8OcPx
         O6dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779511723; x=1780116523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hvr90Zp1niDKu0ILN8c2RkvDAwkHhINjolqUy/3DM9Q=;
        b=ZYZ1iIUQvvve8Qdhr6b1QY8z0tum5J2iah9vgOtMYHI0HndGSKRNAIjU5H0g9jKc2y
         6b5yhTT7uEqTXQofNJ3kW+Rqps79TXN18GWTrXM2uuE9LYzf+08MInP0KOYe3cXeVONe
         I6nNt1annhXWDL/FLPDpRWqysIHUJF9mNtSYyQDNLwB2XicIXw4DEdaHG4T49eEB8u9E
         dgkLwrjYVep/YSgbGf6gJYu7tKAYiI/EQZj/gyFVFkTk/PdStzF59/9py6XisTVvRkCK
         Xy88j6mpd9wi09DKR0U710V6xc1ljaS0UJ4CBl9FuCBr6dL98ignmDdPTRda1lgAVWtN
         ppPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779511723; x=1780116523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hvr90Zp1niDKu0ILN8c2RkvDAwkHhINjolqUy/3DM9Q=;
        b=MgcTHsQ4SfFRg2hxnVK1F5RrkKxCwyeG2rzOQMorfVFZXHYwjpBTDTUPKdtUuN3urM
         6DlWBbBJ42Z1Datam3jxHcmT+PYkuDcjAXnvgTdiL6dXLyrbAWiB03YXFqO5gv7zMkcB
         DwvNVnHHPAFGHYOeSM5g7ExFhk26Na7BARSTgnXQMOrQrI9hcgGqC4hti7pgWsLaiV9t
         Ctai/XqqOUj8/RifUCXhc9aWjud7uwYCmecFhWhEi4kYAxU4tTC43RWrKFqEtk+maSBx
         s7vgyRk6R2Er55pjdPvTVvMyozR01iEiL5/nfJZlF8aCdQFpMEReGZxY6xMp9gavuzh9
         hFQQ==
X-Forwarded-Encrypted: i=1; AFNElJ8xeV6+FHfq0wbZkDdwzuIW6VDr3UI96xVRY3VFoU/tB/q2tpALBgDa51I/G54QzBabSkzu/+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnooE4RJszEfWMFriO+06lWN4MHN0lqxHYfdxGRp3rFl28jKCj
	8IjtKGLBqVlwsv7aK5iuarqYDtpAofCs64fPCKI8pMofbSZskMqN2EvAshGegrWhU04pH4MlRB8
	ziAOaXWO6UnEJu+ztVSLimQaM1eqrrVtsgM9wRMb8
X-Gm-Gg: Acq92OHPSTfFqSyJeGx4BWizVbENlxFIQc9kD+RbH+ezfwKa/l6oUrAuLUd4i4ifzBS
	Ufm0EIAeh2leJ+YtxBerybWOCJSkJW9fXnPTjBHOkD6OBGNHuzetq3D45NinB04jNQAB935lRAW
	5GC60XMEvc5JzqngJpcxNqIwFvZxYJvsrsyd6mrLLxvOSWM5YZETfu44zXNJMSzVLRnsydM0yMS
	dEkEnrwCbhRWQTChTVnjU/+gJu1HtKvhGDz0/7jAMr25C2CyRZmd6VeapyO3CXb/F8io5adf8Dn
	/Z4H2ja4dPOr04Ofsi5O5F6hjE/4ivSm/Zer4jK8k9D++VH2XC5oEOSO6SXWCi2fIuJxNSsGo6s
	fe3ctrBCAKSTvKC3obIxqsFqLNg/MuYLsDLabDocBHuPYpOW/vWwhw6diJyTW+URV
X-Received: by 2002:a05:620a:6504:b0:8cf:f1d9:ba20 with SMTP id
 af79cd13be357-914b46c93ecmr880467385a.8.1779511722770; Fri, 22 May 2026
 21:48:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522173002.2181677-1-edumazet@google.com> <20260522142942.36973ef6@kernel.org>
In-Reply-To: <20260522142942.36973ef6@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 22 May 2026 21:48:31 -0700
X-Gm-Features: AVHnY4LZgg284wWwE_OFjlDhcx4I7Yb3CSvcoKcCwcwRV4wd1HpfyK-j9Kg62EQ
Message-ID: <CANn89iJKXfDn23sqqXDMLJObLgvWJyqk2A==FpJWkwJuP-H+9Q@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 0/5] rtnetlink: RTNL avoidance in
 rtnl_getlink() and rtnl_dump_ifinfo()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-291027-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 736DD5BD23C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 2:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 22 May 2026 17:29:57 +0000 Eric Dumazet wrote:
> > Many shell scripts invoke iproute2 commands specifying a device by
> > its name.
> >
> > This series improves their performance avoiding RTNL acquisition
> > for their (repeated) name->index conversion.
> >
> > v3: insert patch 2/3 in the series (Jakub reported a KASAN splat)
> > v4: Addressed Sashiko's feedback.
> >     added 2 patches for rtnl_dump_ifinfo().
>
> The CI looks fried, various errors:
>
> # 0.02 [+0.02] RTNETLINK answers: File exists
> # 0.02 [+0.00] Failed to create netif
>
> # CMD: ip -d -j link show dev eth8
> #   EXIT: 1
> #   STDOUT: []
> #   STDERR: RTNETLINK answers: Message too long
> #           Cannot send link get request: Message too long
>
> At boot we hit:
>
> [    0.661578] ------------[ cut here ]------------
> [    0.661608] WARNING: net/core/rtnetlink.c:4296 at rtnl_getlink+0x457/0=
x5e0, CPU#3: ip/71

Ah right, first patch went wrong, I missed that we call
nla_nest_cancel() when there was no altnames to dump.

