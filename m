Return-Path: <netdev+bounces-289616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kx4lLnXUDGqinQUAu9opvQ
	(envelope-from <netdev+bounces-289616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 23:21:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31929585243
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 23:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB0EB303E4BF
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 21:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CBF3E7BA0;
	Tue, 19 May 2026 21:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGSE1Yvx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572EF3E2AB1
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 21:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225652; cv=pass; b=jG+RN450SFzWPjrnFLYebw3dcSjln+27YIBoP9nf72wIqEhdMSHE8wAl1Uf7k2SCisz7LFpGf+X2OFk//J3nkKqE181+zZyMghH2rbt9k2v++G+yPovhnwqgXLXzdooDt3CUVx7FKgwuG9Ji6y49B7DLiMNcSXILMZlV0GbeVX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225652; c=relaxed/simple;
	bh=EydiWjB1mevtI300mcfkUJQOs6W/zLaPR/361zFS7fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WTyWBps8EvHa0h9HmhHXYxcZj1DZsnKmLOJbYzTu6ZC+Ku+aNhThLFGBmriIoTHHMJAPQIu7mg3YUbXPzrDzx+3T65q92F0Ou2ZdHYDvmhTHEleZfEOtYQA4MqXoNc6rYMOG8NcH/Efg8rh77+DFYOM0k1sIjDo/WtFELLXLFB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGSE1Yvx; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bccd251d622so705660366b.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 14:20:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779225650; cv=none;
        d=google.com; s=arc-20240605;
        b=QoJM0wg8JsduILkGlAySS2iaIIIkD4qa4Xs5z8wMJmy8gJctKC1PedMOvTEfawRZzq
         UqYpktBfF0JHZkAJbQlvyWaxyx2nyqm/vm4rDq3nm3dw5L7atgd/aAGJlzmgS9n7aSB0
         pybJhyjnK/FdMEHQDTumBNWa7aB02JGaTmgKW9ZBMFXM1ulMxNkmCV5sg/zLem9tpLiG
         IDA2rZCQFtAaTV2bmZXp/hkJXGlpAUfYp8QcAMJ8+wUK1Jm+pm5g/pLgoO1SdiWltr98
         qQvRHDxGSDW8Qi1ZHIqdq7b7jK9bVXNQEEVnQ6x5YEIcggShV1oS/FMP5N5rGGw7h9hM
         HMvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P9vxktKgVOuIZUDUDVXZfXlqf/fPv6N1VBOy02Jy5Y8=;
        fh=+PYoAeCzvdCXQ5rWRVMRYawO4k+EJiNsG6a1JWRh1iE=;
        b=hKJYVwmmbNqK94jemQRSN/OjMbN45K/slroPSG0G+8EY328LaUeeHTV+1Ho1Ulu5G5
         TdV71FrRbXwVKvzwzYlb7CzLyb7lj2C2CZnzARS3Pj+juLf3e4Mu7yqC5H66WZXIZwRL
         AKBIc/Oj24RO0Y3o7VmuWImIdQj9Cjppu4cMH5OYQbQxATx4238xeu4IbmNDcyi+9+ls
         AvY4QW1iYlqXWZTnKE7VOnEKWshp1El72JNstcynVrnXmlCZvjgfnEmgIGXrK4QH7jAr
         aJ1Np1rmiUHwz6KyLxBD2yFRiOjiG3hU4pWAy2VoXvkvpQkDpfsie/Vc7wDFoqgm+zjz
         jhgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779225650; x=1779830450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9vxktKgVOuIZUDUDVXZfXlqf/fPv6N1VBOy02Jy5Y8=;
        b=PGSE1Yvx4r2V+No4oPUnvH72pTfUIIKl2eaDmtv04mBdKn7zmFa3Bxb5rjcbZyec5V
         pnYSU+T5TwLOhrN+2Z8aUeaJPclPetUDSouhgifjZ0Jugi2k6Qk2q9li1ZcpusB3WNQA
         riBbqke6pmOTI+s5Fm79cRLw5qcjmnQVB0sIqVY+uaCA/yK8NEemh+cuyBQY1plgOCN1
         paEei16apMXJH1O9My2QH6Tp+BWvGyFEa3eneVgBY9GrOisD3zTaZDikb5VNxnpgNPw/
         F7PlQYU1Ak5GRr/dzJmQ5yRUsOmTUxZHocN/vu5xSQixvhibQqyse5zkcH8+0oKV3Cd+
         IMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779225650; x=1779830450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P9vxktKgVOuIZUDUDVXZfXlqf/fPv6N1VBOy02Jy5Y8=;
        b=N05JuXe/KHy7GJylYJiq60J+1fivQfgB4o4Fdyt0z37kqeV43HsPBxRMe/v/tUTLsG
         P9pEw89SbmLsSy1H+rAg7Ijr7D4NlD6lqcGxNJ6m7bCeiVll/BI14q1ajEvMlsCJpwVp
         BpJkj5YupdemdFdYwGuQzKaxkGdy9QLBjr+9WiWWO5iOVfLMB4+qvcHs/NQlxm/tYMPl
         W46WW3/pkKUdewNZ1uKB6W1WPAuDfFlZI7E3G5j11Oo1DuaPR7nI5njd6N0VNDt5qeyn
         uNePmMDnAL6StYPtd27qUdCixSar3QfldqFw1igt1PPwcUsLseD94EjieSFI7GskgkhM
         SBsQ==
X-Gm-Message-State: AOJu0YwXZYHjECaX+0IK/MUjju43gWVenwVwY/oLNb3w9vVC5sJ8llt9
	05f6U2WhTwn4bUDLP0x3uqCckHmVTUmPdnKfQVbZuYmdOd2RoERta/om4mv0n/29YnQ1PRUiQXJ
	TsqXRMyyDWbtwzBgGzgl007tBZJmnBP2h/Jy++kg=
X-Gm-Gg: Acq92OEXKDqgpP/l6uljgFNWkYd37mENK8eyJAfL+GJY9ZceaH8YIJ4LjYzd8Ezlg8k
	RAbe5bO4lGeHThq5SGBqi/esMlQ6BbK3Nqe5hsaIHS+h01WhHAHSdjkEF38KNx49NyyBYIS/9Ll
	Oj8TYok0jZp9Ub8Vc/vgve8YsCMpeRI9WLLZUrazhiCacj+9hz+eilOk8iH12Y6R18YJ2XxnYh3
	Hn/HOisBxshbs2SgaGb8u6B9RDVgcSgehr6uXR/+XtBht/s3s86QSNaAjPwGWVGPcGmi50fVZ4G
	tmek2zkjEO40Y61H7vmtidvyaa5ejrwk3glYrlO3+sVNrMNfvvNv398eqSVjseUiDaJCsNQvpYh
	M0y9ueJUO2Q8hMDyNFneDCetVAPKD4zkIYPfMxmyyipi0k6B5bYxNQryjQw==
X-Received: by 2002:a17:907:ca0a:b0:bd2:3623:dab4 with SMTP id
 a640c23a62f3a-bd51797a5b0mr842985966b.28.1779225649321; Tue, 19 May 2026
 14:20:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518044047.1002235-1-rosenp@gmail.com> <33318503dca54fd9401ca99213632c59d5deec12.camel@perches.com>
In-Reply-To: <33318503dca54fd9401ca99213632c59d5deec12.camel@perches.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 19 May 2026 14:20:37 -0700
X-Gm-Features: AVHnY4Jhw3hzHBDQWSI6NRaybB17KjHVyCpRtZ6Hrq3IyCLWBNKVeEXyQf0ZLIQ
Message-ID: <CAKxU2N8qqKAHS9rqYR+YDAVmJqxZfqDQ_-Hnt_rbKMLvK1c6eA@mail.gmail.com>
Subject: Re: [PATCH net] net: fec_mpc52xx: Fix resource size format
To: Joe Perches <joe@perches.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289616-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ozlabs.org:email,perches.com:email]
X-Rspamd-Queue-Id: 31929585243
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 10:38=E2=80=AFAM Joe Perches <joe@perches.com> wrot=
e:
>
> On Sun, 2026-05-17 at 21:40 -0700, Rosen Penev wrote:
> > resource_size() is printed after casting to unsigned long, but
> > sizeof() returns size_t.
>
> trivia and I wonder if this code path is even possible
Not sure what you mean. probe has a corresponding of_match_table in
the platform_driver struct.
>
> > diff --git a/drivers/net/ethernet/freescale/fec_mpc52xx.c b/drivers/net=
/ethernet/freescale/fec_mpc52xx.c
> []
> > @@ -834,7 +834,7 @@ static int mpc52xx_fec_probe(struct platform_device=
 *op)
> >               goto err_netdev;
> >       }
> >       if (resource_size(&mem) < sizeof(struct mpc52xx_fec)) {
> > -             pr_err("invalid resource size (%lx < %x), check mpc52xx_d=
evices.c\n",
> > +             pr_err("invalid resource size (%lx < %zx), check mpc52xx_=
devices.c\n",
> >                      (unsigned long)resource_size(&mem),
> >                      sizeof(struct mpc52xx_fec));
>
> mpc52xx_devices.c does not exist.
right. the message is wrong. this is only meant to be a compilation fix.
> It was deleted nearly 20 years ago by:
>
> commit 917f0af9e5a9ceecf9e72537fabb501254ba321d
> Author: Paul Mackerras <paulus@ozlabs.org>
> Date:   Mon Jun 9 14:01:46 2008 +1000
>
> and
>
> It's possible to remove the cast to unsigned long and use %pa
> and %zx could be %#zx to match output prefixes.
Yeah I haven't had luck getting cleanups like this merged. Compilation
fix has a higher chance of getting in.

