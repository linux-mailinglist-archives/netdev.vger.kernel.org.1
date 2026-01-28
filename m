Return-Path: <netdev+bounces-254424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eH2WHvxcemm35QEAu9opvQ
	(envelope-from <netdev+bounces-254424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 20:01:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFB5A8041
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 20:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D83C13004F2D
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 19:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511A82D0615;
	Wed, 28 Jan 2026 19:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="f/wzfIrw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A508372B58
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769626871; cv=pass; b=PMuw/Ks55+XokRzkc+F+U3RxfUd2zU6vsW3GUmmfpph3HjGzsYCWF4pyOlq46OTH5ODuxPxB2RENpcWRfscrd6RUAWmAoeoKsU3EHlVrWFLJDvuJHrdq6AVBVcybsiXWSWZcAwgKHiQBmk+X3Gfrd7uOJyDLxveJPDeXlhXjMUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769626871; c=relaxed/simple;
	bh=JbNk9rvhtMXbYjyC4GYa/lP1CpJ21aszdocrxrXH/T4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GYw19DIcyfKqbDPjECOvzYr6lee/vQK23yW2C57SJe+XJDUmoIeIDLCL7+KxlUqKPRh0hdQXqgC7A8H9To2grHHU5bUZTaFyjIFyoxQu5olNuqJAupSumwdN8f7TGLCSd0gCAdcF8spk8ZKZymVd5yH/RBGwkc48eGlOnR4uiu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=f/wzfIrw; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-352dda4a34eso45804a91.1
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 11:01:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769626865; cv=none;
        d=google.com; s=arc-20240605;
        b=SzFRbt++G1fPE9UnMVEfoWNBh8YcNsWjUyKc/tn3w7nDVybZbK1Ih3AWPQP5YdBp9J
         iB2P0vv0xTB5VWNHlMiV8AL+aySaLucA86p3wkufGcp85FfYdIfxaqc0fmS/5kpT39zM
         b1+WCjL0N2hTgj6udk939Wull11v1nT1+NeirTLe5Pgsjn70DAQbRFdf2dYOlHHzCgPz
         qoliGD/KRILooHvgp4WPLXOcxeSzvoEv2jwof70a/2D1bDiQ2IrLmoaB3nZ8tlqfqosc
         MeaZSb9H+M52fi14QTaeK0n9IQuQuTa8Yc5JeLRh1PMMyN65A4rLGsbPKlay6yTEpYsD
         nNhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P3otY1GBQ3Ugyd/1LL3BCuL+2MDM2kK0rFaojsWQOo0=;
        fh=48ZQuVh95OamZ1gW8tgwITx8ywjwZsWVDmWAS5eTGCk=;
        b=N1mgbTeodEGTV4t8gsKopWJ4mo3xAEIsZEr97NerSJ4oR0ar2e3R07Y4Besl5CwxDR
         sDz5ASDx7A//1wo9JfFRXvOurRumewaPenmQGEQUeVyNc8/fmqirA/+n3b7CU1UaGBvx
         rRTa7GOonbu52Z2KTZbd1OTz7t5K7iL4FPy6Naz/seSqTwOdec3Pzd3/4Neft22VbIHJ
         fPvenygAmsp5X3DWKOwmXyjKoJ7N/be+o9j9ENtUYhq8w7ocBeMLGrG1cGLUmJFeTjBn
         QksJV5nw0MldAEs+oXPOonrB1MCeS2fSgDAHJCmHuCfR173npHnBYCYfCqgiSewXQLMB
         4Jeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1769626865; x=1770231665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3otY1GBQ3Ugyd/1LL3BCuL+2MDM2kK0rFaojsWQOo0=;
        b=f/wzfIrw/iGFhgCbZ6NU1fvJ+MXB/uw5QL/Rtz+Q7TA0Pf01o0XE7r6htgpilVaWiv
         RXUoofcwi17oUat3Kmh051JMezL2lSKGjJBbyWvV2JZc5dbVYRakBWvwG0N3j4ex0noY
         E2mFcM0ISvP/XKpiN9iWcwOWRnwR9b4uzaVBCRRmdORgzLCGT6H5QzdcNMRB3ds0R9zB
         uedpICMT+efmkEgnz/PRx9nFqhMb9FXiuLZuTOxbNRe94QBtPWcW4ePKcuRlxMhMKXhR
         XNfah7AfLZjfTmGKkcOiz0tnbQAktY7s+j13VIaQnIrdtLYGO5dQb7H8JjyoCHyxoGoM
         lkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769626865; x=1770231665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P3otY1GBQ3Ugyd/1LL3BCuL+2MDM2kK0rFaojsWQOo0=;
        b=QoeT+usO+j9S5D1vqA//4D0gpj8LjE7R/PzNlmwggL8hRBLeuzPJ64xjxWOlQzANkL
         Z5Iz92sydrDUB1xMwdQ0mDV9MTPNSOh2IHByOw7lnNI/tDkI4O9iP+QYho9Pw1fOcI6X
         evbzdgcvkBMzi/rqmpHckRWWeuoCgLnVBLQgUIqpO6Tl9MeFHWJRtuMS+bMEX16e4XhC
         pkBdKfDDDgsKCgMSvhQqqCH7y0FJR2HS3r96o5Ab5znlX/JKvQsJ0oKaB0TZjyHTz2G4
         z/MT2DwJYUl7WmVqAVVvT2p9An+fHk0wqOds+rkNo7nnSOyxb8QdqEwe/hpSfUWT8vsr
         VC7g==
X-Forwarded-Encrypted: i=1; AJvYcCUVhBAVVkVbT35krh1EZsAiykfnaUBfkpdQ1BBHcXWZtWrliRrZ0hfR1pAy5lfL7uedHHivAok=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzg60SAIupcIi3c3JgHbpoRHi8LBfqZpm6hdSeBgQB8Xv1W3p/
	lU3ZrFRcmgwnnVKtWJ+S+J90kwLM50TSMxD57yAhJtdOQ/zXVsqoSgkYw1V/G1ScIcaBY4YRASN
	Hf8+PSKLeIMQK5tckwkFTQRnxpFXqZJsvnvZb7nPFcA==
X-Gm-Gg: AZuq6aKFp1uU73ONU/X8El6Js92D9SzlLLrVBEG39UcHa62l1SzfaYntnCbEzfQxgvO
	plZerD4UvWNZ0E89yLNa1ywz8EeIKWr7TnWtpiBTamsPj1EWGJ/c1R6y1zeDqutiYgE8mGAm6CS
	O7XBwmuXCZVPo5iUBvt9iQzg7KWTfBKFmGrCXPKyHnacpUyfJsz+6ZK1U5Gqiqf1zgiFAjXy1K/
	ne0ZSy3JN51junD69G0tpHRTr6c40Dz29aKMkSmrtyReHMv243yYOt3JQ/UDr99wu4Jlg==
X-Received: by 2002:a17:90b:5784:b0:340:4abf:391d with SMTP id
 98e67ed59e1d1-353fecf6b60mr5694721a91.16.1769626864913; Wed, 28 Jan 2026
 11:01:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127071927.1520272-1-zeri@umich.edu> <aXpJWC8daHd329w9@horms.kernel.org>
In-Reply-To: <aXpJWC8daHd329w9@horms.kernel.org>
From: Henry Zhang <zeri@umich.edu>
Date: Wed, 28 Jan 2026 14:00:54 -0500
X-Gm-Features: AZwV_QieRcAuIa-KkZqAz2wvqoGSbgzOrJAA3OBAFu_jjPwzTNOlBxasEmGRRx0
Message-ID: <CACkPEmnTuQ-FpVtydxuXEeocV2QMxZyjJPE1TDck-nte462ZuA@mail.gmail.com>
Subject: Re: [PATCH net] mISDN: Fix data race in timer handling
To: Simon Horman <horms@kernel.org>
Cc: Henry Zhang <henryzhangjcle@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org, 
	syzbot+c6e7bcea7ffb7ff46acb@syzkaller.appspotmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[umich.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[umich.edu:s=google-2016-06-03];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,linutronix.de,kernel.org,syzkaller.appspotmail.com,google.com];
	TAGGED_FROM(0.00)[bounces-254424-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zeri@umich.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[umich.edu:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,c6e7bcea7ffb7ff46acb];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,appspotmail.com:email]
X-Rspamd-Queue-Id: 7AFB5A8041
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 12:37=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
>
> + Eric
>
> On Tue, Jan 27, 2026 at 02:19:27AM -0500, Henry Zhang wrote:
> > KCSAN reported a data race where misdn_add_timer() writes dev->work
> > while mISDN_read() reads it without holding the spinlock:
> >
> > write to 0xffff88812d848280 of 4 bytes by task 10864 on cpu 1:
> >  misdn_add_timer drivers/isdn/mISDN/timerdev.c:175 [inline]
> > ...
> >
> > read to 0xffff88812d848280 of 4 bytes by task 10857 on cpu 0:
> >  mISDN_read+0x1f2/0x470 drivers/isdn/mISDN/timerdev.c:112
> > ...
> >
> > dev->work is read locklessly in wait_event_interruptible() and
> > mISDN_poll(). In mISDN_read(), the result is rechecked under dev->lock.
> > In mISDN_poll(), a stale value may cause a spurious EPOLLIN or a missed
> > wake, but wake_up_interruptible() will correct this. In both cases, the
> > race is benign, so we can annotate these with READ_ONCE/WRITE_ONCE.
> >
> > Reported-by: syzbot+c6e7bcea7ffb7ff46acb@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dc6e7bcea7ffb7ff46acb
> >
> > Signed-off-by: Henry Zhang <zeri@umich.edu>
>
> Hi Henry,
>
> This appears to already be addressed by
> commit 8175dbf174d4 ("mISDN: annotate data-race around dev->work")
>
> --
> pw-bot: cr
Hi Simon,

Thanks for pointing this out. Dropping this patch.

Henry

