Return-Path: <netdev+bounces-300867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AqMzBsJqN2oUNgcAu9opvQ
	(envelope-from <netdev+bounces-300867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 06:38:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 706DC6AA357
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 06:38:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="CN/zN6+7";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300867-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300867-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C73A9300CC8C
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 04:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27A8217723;
	Sun, 21 Jun 2026 04:38:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720991E2606
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 04:38:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782016700; cv=pass; b=jIubVuFaCxGerAqaNY1cxgTyt9Yde5FS8eGVzAga6nGaoHqX8uw7FM5lXKdMs1c+Noiws0kjSjr9J5AK3suo55PTle2giz6ZId2YhcWGU52Vr+Vn/bDM6sN+KbayO8hNGIXCE4zd4o73iXg0kvL7Q+qRsGUI8fh8IdM+Znv5I6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782016700; c=relaxed/simple;
	bh=EJxtDV7gRcooDwZbQgNBF2cK3ueyJxZXEPPUByfCjqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUxslvAgkWofIgzAFsUSBxkShemKMfVFboZXizxUGm5k25SDlNQJ2OuAv8Ax0pR9qaYpoY67ZqykqGfJWOsk2AacccGP2ZMQRMXACX1gYT+T0W+esGMohbl5KDE5/OVms3NBYs1XfvKptzFpBYkXhYNv+1UPsHS1b9nowDaHNQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CN/zN6+7; arc=pass smtp.client-ip=209.85.167.170
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4863a7dac63so1778245b6e.1
        for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 21:38:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782016698; cv=none;
        d=google.com; s=arc-20240605;
        b=igdfqOG/9b3sJG0QFy6qXROWn4aMDrsfr56V4r3j3iv3JxPS/kOaOjTIZK+FqX2GUW
         YY75Wsir+iPyn4edmtWv81P8PyxkLbklq0p8HDOcq2v9MpmixtOdDS2ESeNnkvZVQVjx
         Wmk9sHpNdrHtRPhv7eh2qPDayjDxvAX4lDuG7cakiVpvKPJiZummx+e5sh4yDbLrzhoV
         sI3FGBTP1cdE9Msts2rMyKEALBpVEdgAlNTaNW9azT5lvzw4PeFwE6CYZLS7e3E+h1Kx
         tq7OliQACoagSoIq0HArhidzL3j6/aCcWnRwOybOR8ak933tQ/CnzeDDiw2XOdAZjIIt
         G2fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EJxtDV7gRcooDwZbQgNBF2cK3ueyJxZXEPPUByfCjqo=;
        fh=fnvQq7PIRAyFw85K8KGyya151awBJyYlFeYToGb8QzM=;
        b=UQXUQJPE+wI1wQNx5c1y17h12SIKatXg/mzzdFM0fFtv0GzGnWCwP3wJdH988XTQJi
         JuVp8HtqTBBtVksxQo/MjH/LZn9rphF1K3Cx/zXKyLMO+a+JhYxttEBPbUBvg+w8avZB
         i466FCJxr2dhu+Y9YwvGrophgPpxe4RFRjwuefCYgn6WBq/ZUWVcI24s9PiGs+ISRoJ8
         JcVYXBKAmdrNL8VAI+gUP1ZltPJI2zOndwUsZaH696vBg+LYY1eq+WNqOTjCURkQo6RZ
         sf1qunimH4anxJGLrUM66jDLZbaw3Y3XwEmLQam020XkJVeQSg04d/I9aEj31ylK3FEn
         p28g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782016698; x=1782621498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJxtDV7gRcooDwZbQgNBF2cK3ueyJxZXEPPUByfCjqo=;
        b=CN/zN6+7Wh89JRdoyXJChmNXeUkN/snK4fRrWSZqQDqOjqkmAY5cNcbTHyiTQJtpg4
         bHmbvUkHjmQb+ue7T8GLMemSgHDLnC+ZEZ+tIABkUFkUVXhRZA/hOKItdgLz6ui8s++o
         zak9BTDUz2j1nmbwIO9Z7MVy9zCyjKOMT07/KkOud31nSMOm1qJyf9po/RRlMxtiV1Ay
         8xr2Y/2BI4jxTE3XrVLjXIqrqPutqqhvhTh+cIv3cIMs08dQZN5p6I426xGFe5kwZ2ky
         F7QROBnvYqU4knFsrUHH6Et0ARzMENCFfvu6VFCxZmQaK4E3DmPxIsJ3qMPUAd082qgB
         FUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782016698; x=1782621498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EJxtDV7gRcooDwZbQgNBF2cK3ueyJxZXEPPUByfCjqo=;
        b=Hs0vbE1Mo0lJV2CV0Rcp1Ixjdq+PMluJi/OOWI7EyYGKrC2q87of0tq0BPeHGtdTTS
         HpezRJq13R4phQw471DUOYB4f5BRiRw4H48koiq49iwYDgnEvsZzfEKA0zUi6d2kTt4I
         fr9/Zf8Zf80lzgWxv2VrAzF8HuZmfZFqSE7XjIpA4hvwSgBSx/Ts/vL2Zyo0ix0MXOLT
         jj0IwAiQWfrvihVhzvkxeZFkT2C7sUfIX0SXNX+22SfKYyKvH9+0MChguv66ZzQtKE9h
         Q0rdq7Gm6cyrQ/AUWSMygT8jytkoRhxrxbzL8+1Zh0m/fgrlFe5lyshctgAqdRB6SJdp
         huqQ==
X-Forwarded-Encrypted: i=1; AFNElJ/j+JORWHWPREzgQevPAawbwpX7pkNngWV7BpgzlEcBKheqhigjliA47kNrlPQBR9wyFHfb1GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztkk+TrsJMAvcJPznWfB575eC5v0Ap2dnVoshUVEtM7PT4J1MT
	WCbzkU3nJX7HCGEsfiYnpNqO5V2kyztXSppOEPfOdQC/kTncv9iCl/ofrMonO6PM0B8qsPTm3Y9
	7EjvKHiwksWsps/86+GhoCvX9wIhnz/0=
X-Gm-Gg: AfdE7clvHIcLEyDw1C8arwEx37hK7MtGHeHKsaIxN+DUIJS1u8g543d7TIdjqD/CGaF
	xzCeekVjJNlmzH9SndfHhZAYs1mgDTCoSPDpGD8yjSZ03PAJSNqdQaIOivbtfnRgXk2ffeu6hyR
	jrchO19gTIt1XgS3hSWkauN/GC3qnxgLRXDo/ybkxSiVHIpukGFEsWsY6UoslAHMp6hMXarCG0Z
	AA7IjBKhyA0uTuH7kGg4QFvjZeS1c7V0z1YfOe1naiM05l8nRjKHVj68n6U9aX+E4yJrF7G+LJJ
	61ISHPA=
X-Received: by 2002:a05:6808:5184:b0:485:3a3f:c2d6 with SMTP id
 5614622812f47-4896ac49370mr10179839b6e.31.1782016698386; Sat, 20 Jun 2026
 21:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1781552725.git.shitalkumar.gandhi@cambiumnetworks.com> <20260618175619.671a4025@kernel.org>
In-Reply-To: <20260618175619.671a4025@kernel.org>
From: =?UTF-8?B?5ZGC6Iqz6aiw?= <wellslutw@gmail.com>
Date: Sun, 21 Jun 2026 12:38:06 +0800
X-Gm-Features: AVVi8CfEMSql90-47Llaeftqgnx9UW857Bzs5oSWs2H_NCK0B7Bv9RAiYk9kI0Y
Message-ID: <CAFnkrs=kE3thiFLaOULGv3n_KgR-r5T4vB7hxJsZL4iAihO31g@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] net: ethernet: sunplus: spl2sw: fix of_node
 refcount leaks
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shitalkumar Gandhi <shital.gandhi45@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300867-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:shital.gandhi45@gmail.com,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shitalkumar.gandhi@cambiumnetworks.com,m:shitalgandhi45@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[wellslutw@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org,cambiumnetworks.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wellslutw@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 706DC6AA357

Hi Jakub,

I'm sorry that I can't test the fix.
I've left from Suplus and don't have the relevant hardware.


Best regards,
Wells Lu

Jakub Kicinski <kuba@kernel.org> =E6=96=BC 2026=E5=B9=B46=E6=9C=8819=E6=97=
=A5=E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=888:56=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, 16 Jun 2026 01:20:30 +0530 Shitalkumar Gandhi wrote:
> > This series fixes of_node refcount leaks in the Sunplus SP7021 ethernet
> > driver, found by inspection. Compile-tested only; no SP7021 hardware
> > available here.
> >
> > Patch 1/2 fixes the phy_node leak in the remove path.
> > Patch 2/2 fixes multiple leaks in the probe path and depends on the
> > cleanup contract from patch 1/2.
>
> Wells Lu, please review.
> --
> mping: SUNPLUS ETHERNET DRIVER

