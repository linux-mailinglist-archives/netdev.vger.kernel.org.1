Return-Path: <netdev+bounces-20267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D8875ED38
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 10:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D7761C20974
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 08:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B158C1C32;
	Mon, 24 Jul 2023 08:18:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49471868
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 08:18:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112A998
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 01:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690186691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KLJqCHhuF3YZkm7/7nGx6cKYPK/GzIPNXdUgGeLCeTw=;
	b=GjC9qP3IUsyXPS5eoNAo4Ch8pYTvSJ1UbbrrnBtbEhW8cB6LKPZzDpcNt9AeDBOnB/8cmS
	HumUsnkk7hD+komirG7DN9E0+s+43niHibTrPLt3mZP9G0j8jopGOBLQfm9imDWXry94vF
	ZYqwboSMHBeNCvV0e5kTYBzb/gR/KHw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-y-3_gYBrPT2KvKSG1g_3TQ-1; Mon, 24 Jul 2023 04:18:08 -0400
X-MC-Unique: y-3_gYBrPT2KvKSG1g_3TQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-403fcf7a9d0so11617001cf.1
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 01:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690186688; x=1690791488;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KLJqCHhuF3YZkm7/7nGx6cKYPK/GzIPNXdUgGeLCeTw=;
        b=MXnhNlTQrd1lTzU/z7ML/nNRPE25sVIMMrTnaxKSgUoG1uHezIscGb2zUnc/fKs/o/
         YvpDHJLWy3wlT3O/r1LCFMqJmrl+XwroQcgYHQex5hN2yhTUaIy9MCPX09ZcjafM5f8l
         3khHSWF0SF/kqpxCXtPbTxcw21smiiORhqXtfnQwtt8riqx1xzbFo8Hxgs0UiYA5PBMi
         5AWbPyxwILFidHZ20Vef77E1Hdm2J9xLVi6QxZbIuqOB+wfvQNbtwbV6qKPcDNQCGvzp
         d8ehq7nJ0IMj9E6ZPy3Tek/1a08VyRq7XntWDQo9BLOIDo6Y/pA57BWO1iOYKevkvF2Z
         nFhg==
X-Gm-Message-State: ABy/qLY+p7oQPGpQbUHb242owINu9thkrKVKN5gzyIG7rueBINPdbScV
	z5idQlzAy0hdIQu9nANr5qoHhqncQ/EyjlLDsX+HJrOIdLEONh7IH7WgY9Zt0Xvq4muMb9AFZYe
	qRLyz2zImwgATen3fAx997uNr
X-Received: by 2002:a05:622a:16:b0:403:b395:b38e with SMTP id x22-20020a05622a001600b00403b395b38emr11976607qtw.2.1690186688073;
        Mon, 24 Jul 2023 01:18:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGye5w74z77kHCd8NpJ7xCGPEJcK3fYLKg9Vid/fOx7HYWiRnX/aMKXTiVgMauGmSfhwle1UQ==
X-Received: by 2002:a05:622a:16:b0:403:b395:b38e with SMTP id x22-20020a05622a001600b00403b395b38emr11976597qtw.2.1690186687728;
        Mon, 24 Jul 2023 01:18:07 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id y19-20020ac85253000000b00403cc36f318sm3173724qtn.6.2023.07.24.01.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 01:18:07 -0700 (PDT)
Message-ID: <20788d4df9bbcdce9453be3fd047fdf8e0465714.camel@redhat.com>
Subject: Re: [PATCH net-next 1/2] net: store netdevs in an xarray
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, mkubecek@suse.cz, 
	lorenzo@kernel.org
Date: Mon, 24 Jul 2023 10:18:04 +0200
In-Reply-To: <20230722014237.4078962-2-kuba@kernel.org>
References: <20230722014237.4078962-1-kuba@kernel.org>
	 <20230722014237.4078962-2-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-07-21 at 18:42 -0700, Jakub Kicinski wrote:
> Iterating over the netdev hash table for netlink dumps is hard.
> Dumps are done in "chunks" so we need to save the position
> after each chunk, so we know where to restart from. Because
> netdevs are stored in a hash table we remember which bucket
> we were in and how many devices we dumped.
>=20
> Since we don't hold any locks across the "chunks" - devices may
> come and go while we're dumping. If that happens we may miss
> a device (if device is deleted from the bucket we were in).
> We indicate to user space that this may have happened by setting
> NLM_F_DUMP_INTR. User space is supposed to dump again (I think)
> if it sees that. Somehow I doubt most user space gets this right..
>=20
> To illustrate let's look at an example:
>=20
>                System state:
>   start:       # [A, B, C]
>   del:  B      # [A, C]
>=20
> with the hash table we may dump [A, B], missing C completely even
> tho it existed both before and after the "del B".
>=20
> Add an xarray and use it to allocate ifindexes. This way we
> can iterate ifindexes in order, without the worry that we'll
> skip one. We may still generate a dump of a state which "never
> existed", for example for a set of values and sequence of ops:
>=20
>                System state:
>   start:       # [A, B]
>   add:  C      # [A, C, B]
>   del:  B      # [A, C]
>=20
> we may generate a dump of [A], if C got an index between A and B.
> System has never been in such state. But I'm 90% sure that's perfectly
> fine, important part is that we can't _miss_ devices which exist before
> and after. User space which wants to mirror kernel's state subscribes
> to notifications and does periodic dumps so it will know that C exists
> from the notification about its creation or from the next dump
> (next dump is _guaranteed_ to include C, if it doesn't get removed).
>=20
> To avoid any perf regressions keep the hash table for now. Most
> net namespaces have very few devices and microbenchmarking 1M lookups
> on Skylake I get the following results (not counting loopback
> to number of devs):

A possibly dumb question: why using an xarray over a plain list? It
looks like the idea is to additionally use xarray for device lookup
beyond for dumping?

WRT the above, have you considered instead replacing dev_name_head with
an rhashtable? (and add the mentioned list)

Cheers,

Paolo


