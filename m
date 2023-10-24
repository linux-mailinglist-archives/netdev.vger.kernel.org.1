Return-Path: <netdev+bounces-43931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C847D5765
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 18:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76613B210EE
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42AD39922;
	Tue, 24 Oct 2023 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Clq8PGFq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B55629437
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 16:08:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DF2B0
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 09:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698163692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IjN52sp3DALiOlG73yTeB0LvMITZMvs1P6Xx8F02nk4=;
	b=Clq8PGFq1rcRfXsg+v3v7f/4/vjFudaJ1XlQON64HGgg/u3lrS2yZn6FXhzcB1hAbSpEYC
	Vf0n+ExZboQKrYJ2zfY04cRSGAWBwi40OEHR7EvdIqw7JRqPfIIjfwmoMpbk1dMRllCHx6
	zSJjF2WVPC0lw3S3wdH8VPSepzRQupY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-vyUwOFK5N9SJ22HF9YJSfQ-1; Tue, 24 Oct 2023 12:07:59 -0400
X-MC-Unique: vyUwOFK5N9SJ22HF9YJSfQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9c797b497e8so237440866b.0
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 09:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698163678; x=1698768478;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjN52sp3DALiOlG73yTeB0LvMITZMvs1P6Xx8F02nk4=;
        b=SwoHChtiyU4llux2XWTQCknlJdwFQrbQ6tAVQgODD8lyeuIXGDJK7KTqMX4JPKJ8al
         veLtsC+0JStgv2E9zdbHMBop2APtFahHVO4d8lDehAIPfYtnFxYJKy3etxxZMIs5V1hr
         oivrzk7W6lX6GTsXsE/oUwf1UAm2WaX5iCymok0p04lAbwRsrTWwdzbSPsNrm1CcKKXu
         /eWi3t85iiS+xh5z9AyHUY+h3nce19+QxA1pUcnH3atJesYZhCgUO6zD+Fe2t8hLwcFo
         JMEiXnscpAznQqQPrCpHheePjYwRH+Ec6/6P2BcI7YDL/8+prM21IVyYyn4df8CoHbAP
         ocXQ==
X-Gm-Message-State: AOJu0YzzPKFEBiUc7yQQpTP82ODQarf8BPWwGaGfIBWf+3sCqd6WHdIX
	x0lTpO4x75bpp0hVINTs3QsOPJjgRmybGdCiL8/KkwmqKWwPicbThEqkKNyw3sgB3iFuQEODK/E
	FmiMZ1lEFM+Fd22WW
X-Received: by 2002:a17:907:7f8b:b0:9a1:abae:8d30 with SMTP id qk11-20020a1709077f8b00b009a1abae8d30mr9227365ejc.47.1698163678364;
        Tue, 24 Oct 2023 09:07:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH71UJ0fiJyLaK2kn6BI171cL0QHtUrKb8VK2HsZ7+wdzh+157Ymr6NF1VaGZJu8/ECUuTCdg==
X-Received: by 2002:a17:907:7f8b:b0:9a1:abae:8d30 with SMTP id qk11-20020a1709077f8b00b009a1abae8d30mr9227345ejc.47.1698163677907;
        Tue, 24 Oct 2023 09:07:57 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id gx13-20020a1709068a4d00b009ae6a6451fdsm8442848ejc.35.2023.10.24.09.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 09:07:57 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 00485EE2339; Tue, 24 Oct 2023 18:07:56 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, martin.lau@linux.dev, razor@blackwall.org,
 ast@kernel.org, andrii@kernel.org, john.fastabend@gmail.com,
 sdf@google.com, kuba@kernel.org, andrew@lunn.ch, Daniel Borkmann
 <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v3 1/7] netkit, bpf: Add bpf programmable net
 device
In-Reply-To: <20231023171856.18324-2-daniel@iogearbox.net>
References: <20231023171856.18324-1-daniel@iogearbox.net>
 <20231023171856.18324-2-daniel@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 24 Oct 2023 18:07:56 +0200
Message-ID: <87msw8ovfn.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel Borkmann <daniel@iogearbox.net> writes:

> This work adds a new, minimal BPF-programmable device called "netkit"
> (former PoC code-name "meta") we recently presented at LSF/MM/BPF. The
> core idea is that BPF programs are executed within the drivers xmit routi=
ne
> and therefore e.g. in case of containers/Pods moving BPF processing closer
> to the source.
>
> One of the goals was that in case of Pod egress traffic, this allows to
> move BPF programs from hostns tcx ingress into the device itself, providi=
ng
> earlier drop or forward mechanisms, for example, if the BPF program
> determines that the skb must be sent out of the node, then a redirect to
> the physical device can take place directly without going through per-CPU
> backlog queue. This helps to shift processing for such traffic from softi=
rq
> to process context, leading to better scheduling decisions/performance (s=
ee
> measurements in the slides).
>
> In this initial version, the netkit device ships as a pair, but we plan to
> extend this further so it can also operate in single device mode. The pair
> comes with a primary and a peer device. Only the primary device, typically
> residing in hostns, can manage BPF programs for itself and its peer. The
> peer device is designated for containers/Pods and cannot attach/detach
> BPF programs. Upon the device creation, the user can set the default poli=
cy
> to 'forward' or 'drop' for the case when no BPF program is attached.

Nit: according to the code the policies are 'pass' and 'drop'? :)

> Additionally, the device can be operated in L3 (default) or L2 mode. The
> management of BPF programs is done via bpf_mprog, so that multi-attach is
> supported right from the beginning with similar API and dependency contro=
ls
> as tcx. For details on the latter see commit 053c8e1f235d ("bpf: Add gene=
ric
> attach/detach/query API for multi-progs"). tc BPF compatibility is provid=
ed,
> so that existing programs can be easily migrated.
>
> Going forward, we plan to use netkit devices in Cilium as the main device
> type for connecting Pods. They will be operated in L3 mode in order to
> simplify a Pod's neighbor management and the peer will operate in default
> drop mode, so that no traffic is leaving between the time when a Pod is
> brought up by the CNI plugin and programs attached by the agent.
> Additionally, the programs we attach via tcx on the physical devices are
> using bpf_redirect_peer() for inbound traffic into netkit device, hence t=
he
> latter is also supporting the ndo_get_peer_dev callback. Similarly, we use
> bpf_redirect_neigh() for the way out, pushing from netkit peer to phys de=
vice
> directly. Also, BIG TCP is supported on netkit device. For the follow-up
> work in single device mode, we plan to convert Cilium's cilium_host/_net
> devices into a single one.
>
> An extensive test suite for checking device operations and the BPF program
> and link management API comes as BPF selftests in this series.
>
> Co-developed-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Link: https://github.com/borkmann/iproute2/tree/pr/netkit
> Link:
> http://vger.kernel.org/bpfconf2023_material/tcx_meta_netdev_borkmann.pdf
> (24ff.)

I like the new name - thank you for changing it! :)

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


