Return-Path: <netdev+bounces-50598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A82A7F6454
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 17:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D9A281A7D
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 16:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F66321AD;
	Thu, 23 Nov 2023 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F61b8LN1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CCD91
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 08:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700757944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lBjBl6RiMXteiisXslLo0Yh7FdmVurXCHqt4qx72G+0=;
	b=F61b8LN1fw9RSOHOBPofBEDLo3TNlgHHb1FVnQXubc3nv4k/CWKVHb3PqTiYQ6BiyYp40o
	hyCau9FYPSa9M9k1mgLSBuylBH41Fdpe0ORueDmg/q7oxdGqlN3HBtfd/sXhHQz12llMrK
	ylKlqT0rlxOAqRKNMJZBeI5vlw/gHFg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-02myRbwcO2WxpT7AcgGnsg-1; Thu, 23 Nov 2023 11:45:42 -0500
X-MC-Unique: 02myRbwcO2WxpT7AcgGnsg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a0009a87651so67136366b.1
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 08:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700757941; x=1701362741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBjBl6RiMXteiisXslLo0Yh7FdmVurXCHqt4qx72G+0=;
        b=l9NbkWVAkmNCKzFQH5qSlSTCptsBaO2IW8pN2OIrfsBaEck+4S7J+EJS1Mn/UOzMBo
         hUCgYkxtwTCGTAbw7Zvjfl6CLGxrXu4/7K1GyMbbZQRW7YFB8T4K768hNcJZy5FMjjI/
         RDMRYTBIUMjtiHvjo2tkQJtdcuWwB/8Pl8ccI7wRxdxDJPkiCREeyi4jdpSFG8N80UID
         ZPi5+FyliTunrlGfcjE6oGOVrwYjOocrdMY3DshNktlmGEdMaqs+vcb+VNMQ3GqQ/apQ
         vIBNdSUBdmJ0tjv5hDu2cW7wlTGIK/jT00nwAJ4gdMPDBk+ewrFroSWaciKUpMqsJCad
         L8CA==
X-Gm-Message-State: AOJu0YyiV1pRsQNf+ob/ZBNWSTENN4ySAYndUc7X+q9Za+bSHcIHx7b/
	s9hwuw6nJAizEkGh58Po7MiEuXTk5pyB635RsZojfDiy+9YZysFtGr735aUoCtAkl6Btf4g8kKk
	aVvdO2DmZDVr58FrA4L328ErCj7RTeZNy
X-Received: by 2002:a17:906:14d:b0:9e0:5d5c:aa6d with SMTP id 13-20020a170906014d00b009e05d5caa6dmr4276183ejh.20.1700757941730;
        Thu, 23 Nov 2023 08:45:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfaOoZK8ZVUHRmRcmkEFqZf7x8Mab1KDGr4SWVV+OmpRRd1SIVYmQoomns8qprSr9GXpfGYdGZr2ToP/DcJ7w=
X-Received: by 2002:a17:906:14d:b0:9e0:5d5c:aa6d with SMTP id
 13-20020a170906014d00b009e05d5caa6dmr4276162ejh.20.1700757941494; Thu, 23 Nov
 2023 08:45:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115210509.481514-1-vschneid@redhat.com> <20231115210509.481514-2-vschneid@redhat.com>
 <CANn89iJPxrXi35=_OJqLsJjeNU9b8EFb_rk+EEMVCMiAOd2=5A@mail.gmail.com>
 <CAD235PRWd+zF1xpuXWabdgMU01XNpvtvGorBJbLn9ny2G_TSuw@mail.gmail.com> <CANn89iKRSKz0e8v+Z-UsKGs4fQWDt6eTAw71VENbSmfkEicTPA@mail.gmail.com>
In-Reply-To: <CANn89iKRSKz0e8v+Z-UsKGs4fQWDt6eTAw71VENbSmfkEicTPA@mail.gmail.com>
From: Valentin Schneider <vschneid@redhat.com>
Date: Thu, 23 Nov 2023 17:45:29 +0100
Message-ID: <CAD235PTyEce0S-22vg=opQdq0MUwEovdx5henU=9Mwh3Rf8QrA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tcp/dcpp: Un-pin tw_timer
To: Eric Dumazet <edumazet@google.com>
Cc: dccp@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-users@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Tomas Glozar <tglozar@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Nov 2023 at 17:32, Eric Dumazet <edumazet@google.com> wrote:
>
> On Thu, Nov 23, 2023 at 3:34=E2=80=AFPM Valentin Schneider <vschneid@redh=
at.com> wrote:
> > I thought that was already the case, per inet_twsk_hashdance():
> >
> > /* tw_refcnt is set to 3 because we have :
> >  * - one reference for bhash chain.
> >  * - one reference for ehash chain.
> >  * - one reference for timer.
> >
> > and
> >
> > tw_timer_handler()
> > `\
> >   inet_twsk_kill()
> >   `\
> >     inet_twsk_put()
> >
> > So AFAICT, after we go through the hashdance, there's a reference on
> > tw_refcnt held by the tw_timer.
> > inet_twsk_deschedule_put() can race with arming the timer, but it only
> > calls inet_twsk_kill() if the timer
> > was already armed & has been deleted, so there's no risk of calling it
> > twice... If I got it right :-)
> >
>
> Again, I think you missed some details.
>
> I am OOO for a few days, I do not have time to elaborate.
>
> You will need to properly track active timer by elevating
> tw->tw_refcnt, or I guarantee something wrong will happen.
>

Gotcha, let me dig into this then!


