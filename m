Return-Path: <netdev+bounces-291706-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPc0O4aoFWqJXAcAu9opvQ
	(envelope-from <netdev+bounces-291706-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:04:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E84D5D706E
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36EE3300D14E
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5EF3F8ED8;
	Tue, 26 May 2026 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="MRZrPPfS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C38323504B
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 13:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803838; cv=pass; b=NBWTWBFlwEVtn8YPTe/5VxxWVHLJWUJPP0+XCQ27p9rDmmDm404Bz+09J4UANSiOkjTic8br+XcyqxR6H2WBLUbqJNKk9W2lwE4PYXju6olwo9cPJ65N3DyvXN7gZGyT8s3RTkvp7RL/q+d6TgCAZDXntGaQ3WDn6I7Dgsw4TSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803838; c=relaxed/simple;
	bh=CX2lnK9RcOWqSjBWasjFyuNxV5UE7eUfgNRJ43lQSt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/fS/G2Rz2fNazjVUkXRS1Ok/DLME3RsiKukYEqcr5DpUfDuDfT/faUVAbeXt9Ks+tgg1vOqpkn9zTEBnOsDJtYswPwViu1dDeNXWQvDiwApesUjCdj4R/VZQyjxLGfy9UYrvWs7nU5aPzCZR+PUADVRS2HaDRX56WkSx4yyloo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=MRZrPPfS; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6763cc8775cso19673822a12.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 06:57:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779803831; cv=none;
        d=google.com; s=arc-20240605;
        b=O8j2DwGgJsXiKs2dQyRoAHtSh7b8HGDfLsMjX6yLdYoD6KMhsaCABJ09byHfSFho0v
         MmNMaJ3ygYTMZqVEFfIwrwU2s/FfiFDkMoFI7Ge1e6+VfjGrw2A1Krg23D6laVYZNuHG
         gFiasesYYTp/BYCwI8iaBFticDY+LzWIM4Oug5u67617s8BgjlCuQ4425NLXwPVikemB
         WeCdaoDOdBO/5LopGI9v+Fkl9hDZ1FWHu4gWzlwk4tn6ZUprKtM/qqF7wQLoOzN4Oxi9
         96fHbsX0VY/doNbE6tpeCB+qiqRgvtcYKzV/t62n7zAbQ8Keql7CNGD6zRcINyVXINXG
         LsMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pmNn1qWk7/TKlmNZNMjGRwnuBcoC2pwzkAf+IEM9Zt4=;
        fh=XiAjeWK89WMtBAevDcgQLg552Dml/FoaS7WJ7sf4NWc=;
        b=bFkPZ8e24fEIPq5cCWGEvBmj7A+dsSCJYStooEvlSw0zcjsF0vYy0GtM6bqE6aCo98
         QQgbX6XLD9SwsCXUPGvnUedE74r3+rsCVZxN4GnONWlPc9qRObngkupRUrnkijykf/1I
         y5iuOUda3DlDNmv3VoTBEI12pR3dZlZbqduouu1IlFvXN8ASOTDQuQv4BoBrOfR60fNW
         WY28SLKavpssVG7czEG7ay0+M6BtX0g18L/t5rKOWi7GYcn64/Ifx/jypeTNIj/BE1Z8
         Jopc6VDLHL/Y7BsG224sIJ6kQnY4l6gqEAWiUxqIGz5xzECIordgbcUd92rO4/0MYBCV
         e3kQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1779803831; x=1780408631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmNn1qWk7/TKlmNZNMjGRwnuBcoC2pwzkAf+IEM9Zt4=;
        b=MRZrPPfS3FTl7o2l5kq/zsBc/jyfZH+3xwWoZx/wyX5Rb6T8lhmbfMJOYlO5aFTKkN
         Bq12dUg4snzLOlZ4JERGN3BFFE2nTcCCiTZ+N9E2rpVzOPYXF5tNjokT/VJEj+x7R76S
         wJ2ZqEpLZ3HM4foeomjlydzgrEjckFwx+vLz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779803831; x=1780408631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pmNn1qWk7/TKlmNZNMjGRwnuBcoC2pwzkAf+IEM9Zt4=;
        b=qLhUzExAVo2Jv4AIzms0ExcTGVtAfZML2vhPIxXyxsTqBZ5r8MTU/sp4EhIpRB2/KC
         FQ+kqCucJC26iuOcc67/Y4hiCLCP4xyLs52dXIecEWY8Lj0O2ahfh7gsKh6Izj59S10d
         XqIr552FN1ldcz/mkT2yNuHc6K07cde90ywsHZtMT8qjl9ghVaeS/dNRIRPaca4uqPIH
         nKJEdFvF98X2yhyabwQZ0OGUkLprnlox1UtuKJpFQnWkk2JRhXglBQ2oZLMgNOs4dWjf
         NF3zPuvKQiHRDL+ORoTg3ow0PLNJAdwgfcXacJLaUe6SepPBGg1Lsf5kw/IYdLe1pdQl
         aVLQ==
X-Forwarded-Encrypted: i=1; AFNElJ/cvULhicqccPYacibidSo4KuFw9LGJ9L2yQrVSXacKBCBfdAP5jd6CL4p2L6YX9gEiaTaYDaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9LJ6SwAAYb2M6SW7sMasThjnPZUJe62ykGpK4sTP8Ji83bgLW
	t1YeqRedEOuFYez/vlWWdaIRBkcHFMefR4tvAHiy3MwSSKAnRiK81BwXZbJUu/uEZI0hJu/S1fX
	K/JLhRuqvOlPVb14NJfidZGnIa6qcTRK5k2jyNeHiVQ==
X-Gm-Gg: Acq92OGA7hi5FKaqsIstarnQN4ZSmUwv1wiPRGU3pjsjXMOQC43ZkCxr53Udaies7jz
	NImO/+TtZ8CzH4sAvRzUaAQ2iZaRwx/ulSu2ya3xSCSr4sZju0D1ZtZze+rovn9luws3qjlzVm4
	q5ygFfX/BQ45sDXZN/TbvvuYC2EER1LhGM/E+MwAkVQrrwZl92wshppK19ZQjg9Bt847kLx07Ij
	uzQQBDkHWmy2IYykDUSSQJB0B2GfaPK0xIVu3zrz4EJo2Gr20grd5DXLNcPeP6TnqxEl3URS2l8
	lXQiaTyLvOEeqgw1BdbaKBYOo7nitrFWSuZMDmnBmgX5b5L2Wuo=
X-Received: by 2002:a05:6402:2152:b0:687:fc0:8298 with SMTP id
 4fb4d7f45d1cf-6882efeddd4mr8033873a12.15.1779803831409; Tue, 26 May 2026
 06:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526064835.2233822-1-swan2718@snu.ac.kr> <14018241.uLZWGnKmhe@ripper>
In-Reply-To: <14018241.uLZWGnKmhe@ripper>
From: =?UTF-8?B?wq3rsJXsiJjsmYQgLyDtlZnsg50gLyDsu7Ttk6jthLDqs7XtlZnrtoA=?= <swan2718@snu.ac.kr>
Date: Tue, 26 May 2026 22:56:58 +0900
X-Gm-Features: AVHnY4LxnVrFzswY8dw_KnSP-5mTDmGd64Ddq1H-UBRZ_OlCA3frAGXWLFTfNlA
Message-ID: <CAL3z5EbfEeMn-2_JrvcXRtuKTtruEf+8MX9tCmn-N9edvvrjwA@mail.gmail.com>
Subject: Re: [PATCH] batman-adv: fix DAT purge use-after-free on teardown
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, 
	marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[snu.ac.kr,none];
	R_DKIM_ALLOW(-0.20)[snu.ac.kr:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291706-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[swan2718@snu.ac.kr,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[snu.ac.kr:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,snu.ac.kr:dkim]
X-Rspamd-Queue-Id: 6E84D5D706E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Sven,

You're right. I re-examined __cancel_work_sync() and confirmed that it
internally disables the work before flushing, so the re-queue race I
described does not exist. I'll withdraw this patch.

Thanks for the review.

Soowan Park

2026=EB=85=84 5=EC=9B=94 26=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 4:30, S=
ven Eckelmann <sven@narfation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tuesday, 26 May 2026 08:48:35 CEST Soowan Park wrote:
> > batadv_dat_purge() is a periodic delayed work that re-queues itself via
> > batadv_dat_start_timer() at the end of each run. When the mesh interfac=
e
> > is torn down, batadv_dat_free() calls cancel_delayed_work_sync() to sto=
p
> > the purge work before freeing the DAT hash table.
> >
> > However, cancel_delayed_work_sync() leaves the work in an enabled state=
.
> > If the purge work is currently executing and re-queues itself before
> > cancel_delayed_work_sync() internally marks it for cancellation, the
> > newly queued work escapes cancellation. This re-queued work then fires
> > after batadv_dat_hash_free() has already freed the hash table but befor=
e
> > the pointer is set to NULL, causing __batadv_dat_purge() to operate on =
a
> > dangling pointer that passes the NULL check, and spin indefinitely on a
> > spinlock in freed memory.
>
>
> You are talking about a re-queue by batadv_dat_start_timer(). This only
> happens when the DAT gets initialized or via the worker (batadv_dat_purge=
)
> itself. How can the worker which is cancelled (with sync) re-queue itself=
?
> Isn't this breaking a guarantee of cancel_delayed_work_sync() or did I
> misunderstand this part of the documentation?
>
>
> "This is cancel_work_sync() for delayed works." [1]
>
> "Cancel work and wait for its execution to finish. This function can be u=
sed
> even if the work re-queues itself or migrates to another workqueue. On re=
turn
> from this function, work is guaranteed to be not pending or executing on =
any
> CPU as long as there aren=E2=80=99t racing enqueues." [2]
>
> (the part "This function can be used even if the work re-queues itself" i=
s
> the important part here).
>
>
> > Replace cancel_delayed_work_sync() with disable_delayed_work_sync(),
> > which additionally disables the work so that any concurrent
> > queue_delayed_work() call from the running batadv_dat_purge() is
> > silently rejected. This guarantees no re-queued work can fire after
> > disable_delayed_work_sync() returns.
>
> I have no problem with using "disabled_*" everywhere (I even have a pendi=
ng
> patchset to use it - just to avoid problems with code changes in the futu=
re).
> But since this is a fix which I don't get in the moment, I would like to
> understand the problem you are describing better before applying it.
>
> Regards,
>         Sven
>
>
> [1] https://www.kernel.org/doc/html/v7.0/core-api/workqueue.html#c.cancel=
_delayed_work_sync
> [2] https://www.kernel.org/doc/html/v7.0/core-api/workqueue.html#c.cancel=
_work_sync

