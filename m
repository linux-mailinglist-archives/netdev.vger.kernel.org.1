Return-Path: <netdev+bounces-44422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AB27D7ED9
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 10:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B70A281F02
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 08:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2221CF92;
	Thu, 26 Oct 2023 08:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFpJbtMh"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4E017D5
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 08:49:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D553128
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 01:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698310174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2H+EMeMg/1Fs19heJFc8GaaunsyixJ8rWAna5sIJER0=;
	b=WFpJbtMhNXeJ8MBTMQgqbCgmfuNGU6IzZqL07mfzgIsw1tYujlpaN+4vSrcg8OfYe6CYID
	fKv1nWjxXog9EOo6vWfswgwTIs6HDQyChgW3TOhBG7z6psDjWp1vgnHpt1sxgEfPKJjAqY
	+HelRKfnUZSJ9qbezI4E8yNghmYCWds=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-J1XP6w90OVCe47FLqgt1IQ-1; Thu, 26 Oct 2023 04:49:22 -0400
X-MC-Unique: J1XP6w90OVCe47FLqgt1IQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9c167384046so3098666b.0
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 01:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698310161; x=1698914961;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2H+EMeMg/1Fs19heJFc8GaaunsyixJ8rWAna5sIJER0=;
        b=WjP4/pLWAptzVozQ6YLi60N1OFQJflFzmZpfqMobpYz5jI+Q9jTVG6g5eqLz7FhNav
         S/d3zwuIOxO8yEfJIKsqhZjHIUtpwRFygGL7djyNIRDx1iOG9vYrYnittXnzUh42bZ4J
         t1SeSic2NS6P+d5ANPTVDOmVJ71vimP4M1ys9sypAqsmJuH+of7jNf4Y0w0pOxV/uTl7
         zAlMQtOXMfFyjUS1+bzTyD/n43F8J6LLypRgva3BflEgMRdj7BIXm1do8+uimzMRtqDk
         q7/4UZYbbDSmnCh+oLyYSa6Vr/6qzUIdlSn8mSFpkJ7p421zyd52ig5so60bkg2JL/Wx
         obww==
X-Gm-Message-State: AOJu0YzHfcW+K5TX6iYHevUEmQom61RDaUM7D05IKFa/zJ1Sfn74JvLH
	crC5chF1uVna/lly24sCdq9ToEhWY+72faXZH89PjoF4ff5/9LZWK1C/3SWrGV7WP1zBw0Pfo5/
	rgH/yzZw0Ttw+Thw7
X-Received: by 2002:a17:906:59a5:b0:9cb:798f:91e8 with SMTP id m37-20020a17090659a500b009cb798f91e8mr6042907ejs.6.1698310161025;
        Thu, 26 Oct 2023 01:49:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZsbE+cQ3LMb4ECdoxZfpuUbiYD6x9nJTxK6ZQbe8zyNDpdTDVELuBDambmmxEsjCFgbEOag==
X-Received: by 2002:a17:906:59a5:b0:9cb:798f:91e8 with SMTP id m37-20020a17090659a500b009cb798f91e8mr6042893ejs.6.1698310160621;
        Thu, 26 Oct 2023 01:49:20 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-245-52.dyn.eolo.it. [146.241.245.52])
        by smtp.gmail.com with ESMTPSA id h13-20020a1709062dcd00b009ae54585aebsm11319511eji.89.2023.10.26.01.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 01:49:20 -0700 (PDT)
Message-ID: <8404022493c5ceda74807a3407e5a087425678e2.camel@redhat.com>
Subject: Re: [PATCH] net: Do not break out of sk_stream_wait_memory() with
 TIF_NOTIFY_SIGNAL
From: Paolo Abeni <pabeni@redhat.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David S . Miller"
	 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jens Axboe
	 <axboe@kernel.dk>, kernel@pengutronix.de
Date: Thu, 26 Oct 2023 10:49:18 +0200
In-Reply-To: <20231026070310.GY3359458@pengutronix.de>
References: <20231023121346.4098160-1-s.hauer@pengutronix.de>
	 <addf492843338e853f7fda683ce35050f26c9da0.camel@redhat.com>
	 <20231026070310.GY3359458@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-10-26 at 09:03 +0200, Sascha Hauer wrote:
> On Tue, Oct 24, 2023 at 03:56:17PM +0200, Paolo Abeni wrote:
> > On Mon, 2023-10-23 at 14:13 +0200, Sascha Hauer wrote:
> > > It can happen that a socket sends the remaining data at close() time.
> > > With io_uring and KTLS it can happen that sk_stream_wait_memory() bai=
ls
> > > out with -512 (-ERESTARTSYS) because TIF_NOTIFY_SIGNAL is set for the
> > > current task. This flag has been set in io_req_normal_work_add() by
> > > calling task_work_add().
> > >=20
> > > It seems signal_pending() is too broad, so this patch replaces it wit=
h
> > > task_sigpending(), thus ignoring the TIF_NOTIFY_SIGNAL flag.
> >=20
> > This looks dangerous, at best. Other possible legit users setting
> > TIF_NOTIFY_SIGNAL will be broken.
> >=20
> > Can't you instead clear TIF_NOTIFY_SIGNAL in io_run_task_work() ?
>=20
> I don't have an idea how io_run_task_work() comes into play here, but it
> seems it already clears TIF_NOTIFY_SIGNAL:
>=20
> static inline int io_run_task_work(void)
> {
>         /*
>          * Always check-and-clear the task_work notification signal. With=
 how
>          * signaling works for task_work, we can find it set with nothing=
 to
>          * run. We need to clear it for that case, like get_signal() does=
.
>          */
>         if (test_thread_flag(TIF_NOTIFY_SIGNAL))
>                 clear_notify_signal();
> 	...
> }

I see, io_run_task_work() is too late, sk_stream_wait_memory() is
already woken up.

I still think this patch is unsafe. What about explicitly handling the
restart in tls_sw_release_resources_tx() ? The main point is that such
function is called by inet_release() and the latter can't be re-
started.

Cheers,

Paolo


