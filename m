Return-Path: <netdev+bounces-290460-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP5GJ60TD2otFAYAu9opvQ
	(envelope-from <netdev+bounces-290460-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:16:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 421F15A7059
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1E44327475C
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740FF3FFAA6;
	Thu, 21 May 2026 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RiZZRc3e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091063FE666
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370877; cv=pass; b=h3vUQYW9uOoLvXMgj+2SVDHkm9Cvc2qPpW8pWQA3GddF3+KXD7tYPCxQGV36EkBsma8X5dVY30vbP1FyY9TFoRrkx1uFmrYQ7XKX79h10poZ7X/3LpHPko0BropXhFVX7jzo+dUq5qL66ta+l8ZWxKILUu33+OyMhsSAL24vcZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370877; c=relaxed/simple;
	bh=Iztqdv46z3L/RfMJPUbTwKC4ovY74G3OQJ4DxuJSyZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=byfG9KpfI6eRYXjK5CW9REvxgAmAkbQff218n6FsdWgBtCCXuFyLTCNLCdOxRlY8voVjAKr2zn0Ld+htAiZiRrehCbfqZQDfFEcjgsIkDlfbVT0B6QVbpHjhfyVyy8ANfhq2bzBVdtOv8gnIiw2MQo+qW4/IDQ2Pzwp/Ja5cCK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RiZZRc3e; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50fb1ad3734so75170421cf.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:41:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779370875; cv=none;
        d=google.com; s=arc-20240605;
        b=QKeIgl3CzCSPfcvwTNe7KML2lU5Erp/vWPceaJ2sSczuRLMPW15WESonf9rKgwR+Hw
         Cme3ughKLv2Ik5d/DbWW3wNoCjBUKoYlSQMiVGmw2ZrKnPOXjwNIvMlgHR+yIuIKA3uR
         sr8K3B3Qdb67uUqWRPYUm/sQuexM7VojIvrSlwfGQwfSH+fDJ/B3zBITNhS4xDLs+n+D
         5I8+xE9yDZwi55hJmHDYH4q/SMgPN0IpknGQ4nldxyXI7nW1UKX8GJ91Ejs2VVddBNfy
         Lgcbl6iJFJM2D5FGvUItQwVrLeb9VcX0bFSqcvFXGbslor33Yk7IZfXcPKPj41lYa9qF
         IQ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Iztqdv46z3L/RfMJPUbTwKC4ovY74G3OQJ4DxuJSyZE=;
        fh=UDezsRZnMklTW8j5qah0+vBL8lgBLbmGrna7WoJv538=;
        b=Pzg7AF/ZnCQtYzfdGukDKnGl1ydLo5fHXm9KsZ5B9ZxYA1M14qo4uZo7kcUAniU6vm
         LAtx64eOPDy3ErimyYJcGPYHP85Zob8AxWC/lPFdYC8TE1W+gJo/CLqu7zAJu39oq10c
         qVZ3lnNfj4slL0TNuxnO1tv0L1zufQBmPrHKTZhTSv9oo5L8Ayy7w3wiMI8u+HJdGxKf
         CtIQeLkxgvGpsUmGgDfLqWMofzXjyC2CIsXWjpyNs/9Jj8fYu0sVuwpKY/V3R2eVI3so
         b4QY1EVlSDAPrs8iRGn/qRfTnd8MguYOCLg76bpUxkArCelgsjahEIxTECA6zAOX/d5h
         DyGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779370875; x=1779975675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iztqdv46z3L/RfMJPUbTwKC4ovY74G3OQJ4DxuJSyZE=;
        b=RiZZRc3ekxIQHkymaOmXXpZ0g0XbYZA3217XuLkfdLdFG3fkFqDHnkBFYYNHqoYLNT
         ZaViUx6uQnh95iI2yHC0sC9MiVbzA677Ua/1KpUlWItdk5ZLoQMZDn4MBQHGbHiPGK9k
         Vg1m97EWFN3bXdQRbVCgxNAoWS/LdWcVQplXixNmmim/lxvOSwNNm/qEpo2NLmXU7TeV
         P1mylS62iik8HMXlDn+sbsH/dzda003xEO9sv3of5cfCuNtrSArbNjBSobsZqpMTYwzo
         9+Zp4DCbRF/Hl+5OVLgSHJPw3iR3E12faKgrGz7CmDk7jLk/6CXBLCUqA2KKE1jzc4XB
         0uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779370875; x=1779975675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Iztqdv46z3L/RfMJPUbTwKC4ovY74G3OQJ4DxuJSyZE=;
        b=nQEurYlIl+CoKk0fgiimk1voBRCSQi1KJarFFqhaqtAGXECqRFUsdxSLkB6IlhKa47
         cyxuIAcMHSCs3iSUfsviJgweGsNwpFDTr7zOIErjabutIml8CYJTeTPO7pDx7JDFZ1rX
         rq748qOgrxU810OnYegDcSDcM35b3guWzB/3jOe6XHUI93eso63cQHN2tPzaboFl0/eM
         9sBl5sbv53CuVnFzLp6YTv3R+w1gqPTJmr1ZyOPgGP9aQois70ua32RZGeCxMu6zzgBc
         9+vemMzUPxM5fFqudmpI7iW6yphfzprhXHh96ujiqAp0rh6ZaqqfkdGGQUxd29jevlEn
         arjw==
X-Forwarded-Encrypted: i=1; AFNElJ8SrAR+e67oH6ow8NIef+xrvkWddftCApWUyxEklPe09/FCV4nGvjpT/9Fxq09PnZoTrpiNWjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRLE7XFbNiK4gVmCBx/wkzD8DryNVy1/LqNKJFGL//Um8RZJ1R
	1DiA2jVErb2cfP2VpXsc+pnVO++HuD4jKHhd/CdnSrivRToNlNrYG5kDDNiYyshkRXinIXE/Pah
	4yt58PTa6oQb3Y/ltMkqe0lPAFg4gJ01ZzqpRugpPLNm+zrLF2I28uILSSBc=
X-Gm-Gg: Acq92OFcj6YRGKT6nVFvI/wdffTdGEv9v8wqtCtej1i01sNH2qvbTemw8jlUZ2RYeW5
	FgC7wV33F68yo47U9iD/ERFIchkRbzfD+DZlp8uqxvuac3WagebdqJ4DySINz4qvWlvlO3EsFQr
	yuJXU3W1m1aoJxwRxER5/mYYMot8M5VQUtwMFJGN77EsF0XhRkLrfBjzolt3+2I/ClHlRaQdu5N
	mwgbdZa37x6Qs2dC4bA0grYXmZ1H4b7GgLsJRZ8MEdQ0wuGtVWsCScvQl3QtdGTToPs1qlS0Aog
	65SjgfEbMmD0guLcgQqhuTOLUErLprqRdvEmHWJBiKm1sW8j04QaNQpcoUOqhqI+rcW1uIojZAk
	9ZnIi8ep4iWQPPM63aIUG3eUlmUKKIuiKlxqPS4LH0ImUBSYHW/7jjOwbWXpavdwC
X-Received: by 2002:a05:622a:5c89:b0:50d:6fd3:421 with SMTP id
 d75a77b69052e-516c5847b1emr35783761cf.6.1779370874163; Thu, 21 May 2026
 06:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517192856.3925-1-rosenp@gmail.com> <20260520165746.7ed10c7b@kernel.org>
 <CAKxU2N_vHyqZK8tBbYLo49iOUJSO56rgqbSdw3CnCUZjbs1qNw@mail.gmail.com>
In-Reply-To: <CAKxU2N_vHyqZK8tBbYLo49iOUJSO56rgqbSdw3CnCUZjbs1qNw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 May 2026 06:41:03 -0700
X-Gm-Features: AVHnY4KJHFfpbD1HQt-b9agKuVmI3qI3wyMZwjK6KWYSJA-YQqQ9wKOAjm-1zko
Message-ID: <CANn89iK7i4u5nWxQCuURmSCJt8Sn+Q9x_ME8X+J0pF2_4OGuZg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ucc_geth: Batch RX packets before stack handoff
To: Rosen Penev <rosenp@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, 
	"open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER" <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290460-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 421F15A7059
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 5:39=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> On Wed, May 20, 2026 at 4:57=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Sun, 17 May 2026 12:28:56 -0700 Rosen Penev wrote:
> > > Collect received skbs on a local list during RX polling and pass the
> > > completed batch to netif_receive_skb_list(). This lets the networking
> > > stack process packets from a poll cycle in bulk instead of handing ea=
ch
> > > skb up individually.
> >
> > GRO should be even better.
> GRO will result in slower routing performance because there is no
> hardware checksum.

Then provide a knob or something, instead of trying to avoid GRO.

For end hosts (forwarding not enabled), checksum will need to be
computed anyway.
GRO should be faster for them.

Note that GRO also uses netif_receive_skb_list_internal()

