Return-Path: <netdev+bounces-281084-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDCcHEIL7GnbTwAAu9opvQ
	(envelope-from <netdev+bounces-281084-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 02:30:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EB646440E
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 02:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59DEB3006B53
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 00:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520FB7080D;
	Sat, 25 Apr 2026 00:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uStJdsnl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0345614A62B
	for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 00:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777077056; cv=pass; b=E0UdzU8lmJP9PrsghnJeZmqph7YHLLaB9bpEuUBz5v2DDJMGAOikQQYgu5nG2iZRzBRl1479vrWOE8+WoKScqIVRc1iwzIJewO98B/wqh4XZA/jcL8yMrd3/YEQXIycx7xs2eSpYwlAXCVOToP6cR2/uEb+fbTcKcl4+SSw4adY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777077056; c=relaxed/simple;
	bh=Pe0pQ/xYfUpOrylttDTvtib6XmVWAY+7XhmnK47zGPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8ri4GjyIs53u7GPcX+jAZLF4zRLlPo0ml9ukWfSupnUk2x1riyru58uc3Ohs8TPUUy77Qr3sgXzl7lNOnWY70Ihf7B9qm0Vv6aQjycME30Ecz5XU/cCBtGQSjuHdmB5Anrp+lCK0xAgmMy0sHZhJTCl52p+wFwy8YwhhMz9ik0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uStJdsnl; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c1a170a50so10801972c88.0
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 17:30:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777077054; cv=none;
        d=google.com; s=arc-20240605;
        b=KinpkBgj1WCgA1Y56N4Qy/obT8vIUACCt81zhiDjuHmxcK8G/FJC2JZu19P1ouG92L
         Teva2i6wgx8tki8CD08AsWrcar+5U/rsy3oZ3WDhFSv78LKk78eytvmVNENHIBYGat5m
         ErlHD68rq+qYvrRoAzYZuogmD3eNrkxrT41d/RH2LKuxlbrCgAtnsr9B9Ct39a6aCspW
         SjMm3Z34uOiBDUFT+qQv5JtJts3CfisFMQzst0sP5U7v14P2HtVqjf0zjXfqnkkBSN1u
         UJfuWrBKHu+ure5rfoURhVDhpIaca/cRPGELGBJ/GAFuQC8XROm8/e1DrB4KEQR1xXPC
         m6Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=scAIt6H3Lr9726e8Rx2uESa4VModnRMiTXIlRkglNao=;
        fh=Aw6eX/WX80l3t7ZeNrYhi/b7lroZTuNMDwGGM8BQMK0=;
        b=g4230ZY3ZH75t2lv+qnVBAsjfO+I3qp2fLirK6xq5TiR7TfBUBHebUvAMIcMsoqPk0
         8QNPbNUL45xddWD78HG00juiy6rrNyA/EFVxnIVCaKRLMsp/7qqY8OJVNwk7lRO2a2Pb
         J3H/gwMxX/QG+M1GNxGGa6EBdJvGMyeagbOeE7C8YLhNa/afMWfnjcx3cBaDnwMby/Oa
         0JP3/vI2UJXgovRI6T8lMA18K1SrLRbVXgFU/PKpFa+htni265tHnR45FDGcj/Yz+CdG
         +XzT3UcnKSoaZXlz2KlnQcECat68rO310Gin+qe6wqxB09Fi5SIszqvRm4SDrxls6ejD
         Tyxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777077054; x=1777681854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scAIt6H3Lr9726e8Rx2uESa4VModnRMiTXIlRkglNao=;
        b=uStJdsnlKwoQP6HBSUvsa6RHbnTaAuFc28D0lec7G9QUv19Si2RXBuabruYeTUx2zJ
         rvYuElo2ZUH6Fk2CBUGUki1s9tNbrHC/2JaDC84TI/2mQMZYdlwoDJaX/ChDtmAQTYHQ
         NXmgOm9a0zX3+YkeqZaSx9L8bzExo/McUPAlS90TxiswIE+YPhuzXfvQwnyzr4J2EPYM
         2PthUQ674rt9b2ex8Sae9O0SOHa+/nEj1TsFAHfyVhxf4ffIxPFAn9yJzo7wHAKeqt9k
         LGSOHoziURaecjmYOO4k7c380t0Bw1JGkg2yZdvJpI2WELpzFZxphsXKKITZ55FhDvjQ
         0EMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777077054; x=1777681854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=scAIt6H3Lr9726e8Rx2uESa4VModnRMiTXIlRkglNao=;
        b=f3JYxERRIKfJoWjyrYAjSRXwSb7UsjUeZL7af6YpCQGxLiW9rZf1mmIDiQOUkfEiYC
         4EV/T1vamsN++eXe74MTq9OdXUxwH2Gm7hzTHSPqQxAS9v2oZ3uqOUmv4hHh2qhQXByW
         JCG/cCxzRz27MSj11/rIB0Tl5no5RA6IB9HIsUMwvRb5HrA32KpT0xFF3fwC6XT/Yx8Y
         cm0d5SkDN64QDagoi4c/4VckBKbo20L3Pa0rcX1V5iH0lD++X7cpHDr2RVMxBixLXiab
         n1iakuloolxNRTVRXhgF/mHw7qscLttiUTKJqnXTqZCcCn13ssBcJ3JPS8bCORF+hUP+
         erUQ==
X-Forwarded-Encrypted: i=1; AFNElJ9354E3QslNH8t59P+cqPeTza0vG56zSvCo79YfuJSELR3aoKKmUgnZEkEVahj/xIo1EhyD1D8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCeLuK8ss4sGoqQ4BmlsP+O4yKN01lNIvjVqy3yZHf+7ExkN7z
	PqCelWDFa1l2klW2rqSGsorixUnH6EiIDGKjx/Xn2aX7osy95I3iOD/rrZbETV7NR9iaGU4klJx
	Ui2zja0P+i5vxvCPtnunJU0CtvrgK4vh5dT0ZS1fHhNmozLeYYbtJ2scI
X-Gm-Gg: AeBDiesCqkzH77tr7c6LgPzkL3VclaN2krkR4Qqc/s8vPmse7KBmdHoDXj0hyLOFjW6
	6ecp+4332A2VwU+5yLQn2RjCwGNJCLL6dG4zrdi3s3pTqFJcRC2+OllMceyptcoET2C/k8blxqp
	DAJ/AmL/edAC0uA1yprGbzUzMqNCwhU6tjp+hR2N2ohAGwZTiSO1whIbnY2P+wRHgssVvU3YrPI
	qb/vqE1aywD9/6InYpVzkep6wty10Ze+I3g4MW9LCwNeiQYOZ/Cf942rq5/JhsiZL5XlwIiWfXt
	trc3EqNkVweYukRtc0E1gvHIxiMzzjLfhrhWCf3Xr3PgVl0HoQmkOLpHIf0cb8hcxbXc1zEpz9Q
	3XcoihVjhU97i8ty26L5n73/W4r2kH0a9TMmGcnOYxb+k/EW0R0l3Pc/FTA0vxvrPrG+ULg2X7Q
	==
X-Received: by 2002:a05:7022:3d87:b0:12a:85ef:1e50 with SMTP id
 a92af1059eb24-12c73f6c614mr19080813c88.12.1777077053440; Fri, 24 Apr 2026
 17:30:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424235247.1990272-1-kuniyu@google.com> <407178e7c68a87a2a660badc2e4e8e8feae7b1767998649cb278ce4bde14371d@mail.kernel.org>
In-Reply-To: <407178e7c68a87a2a660badc2e4e8e8feae7b1767998649cb278ce4bde14371d@mail.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 24 Apr 2026 17:30:42 -0700
X-Gm-Features: AQROBzAqrIhJ7JX_MyPdPgfTGaxFKP0KnybLYb1g2b0avxkPVh-L-EmOG11z32E
Message-ID: <CAAVpQUB47UfzsKJUr9M-K_KU0Sz2r4XZv0Y1-SAt8dW--y3=tg@mail.gmail.com>
Subject: Re: [PATCH v1 bpf] bpf: Free reuseport cBPF prog after RCU grace period.
To: bot+bpf-ci@kernel.org
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, kuni1840@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, eulgyukim@snu.ac.kr, 
	martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 50EB646440E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281084-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,iogearbox.net,gmail.com,vger.kernel.org,snu.ac.kr,meta.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]

On Fri, Apr 24, 2026 at 5:26=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index bc96c18df4e0..dba4c9340bb7 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -1654,15 +1654,24 @@ int sk_reuseport_attach_bpf(u32 ufd, struct soc=
k *sk)
> >       return err;
> >  }
> >
> > -void sk_reuseport_prog_free(struct bpf_prog *prog)
> > +static void sk_reuseport_prog_free_rcu(struct rcu_head *rcu)
> > +{
> > +     struct bpf_prog_aux *aux =3D container_of(rcu, struct bpf_prog_au=
x, rcu);
> > +     struct bpf_prog *prog =3D aux->prog;
> > +
> > +     bpf_release_orig_filter(prog);
> > +     bpf_prog_free(prog);
> > +}
> > +
> > +void sk_reuseport_prog_free(struct bpf_prog *prog, bool wait_rcu)
> >  {
>
> The function signature was changed to add a 'bool wait_rcu' parameter, bu=
t

Oops, sorry I forgot to commit the staged change..

pw-bot: cr

