Return-Path: <netdev+bounces-21744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8177648C4
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 09:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182D8281FE5
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 07:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3523C2F1;
	Thu, 27 Jul 2023 07:35:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8429BE72
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 07:35:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2192359DE
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 00:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690443289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l/d1hElCRlKYILqamKbhScYXhcTsJFSt0ooe3i9EVAI=;
	b=e5knfw9uMq50UQ0QMsKT2BfVQQt3PAYNR/PpIhjXV9yA/h8IjNz1DIA+fcEuGsFgmsa8Iq
	GpvmFS0fcCbU43HZ40nc0E1yLgpNeJe1rrlYhsczC2tNRVaZtLvvjd+Te+w/u8V8bbJJYq
	BZo7NeU6f2qqDsS0jMeifapYG1xCXXA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-TiroYOxNPmqcT2btfXsXJg-1; Thu, 27 Jul 2023 03:34:46 -0400
X-MC-Unique: TiroYOxNPmqcT2btfXsXJg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-63d2b88325bso1911706d6.1
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 00:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690443286; x=1691048086;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l/d1hElCRlKYILqamKbhScYXhcTsJFSt0ooe3i9EVAI=;
        b=VRfPq8hhD1XG2AJK15QoxNGz+7xrtTM0zcH5XvZet5dcO2ZRhIMhzfzZ/xLQ6PA//S
         e4+tVtKjXL7Z0agAXelbollHlvP+SdStpsod62qV9V5mZAeJgb8zWlDqOdP+nbEJpVJi
         qty8wXJtMHb3xFiEthhwHfXdnAUCj3m9KvAPqBtb2kVu8awNBn+/+d46OSl8KGSh7QbF
         CavT314f62NcnNOEwSWUL4mZbPF4oyMW4ByuQS11LN7Q5D1kIZWaUyXNEM73EPYDMzk/
         jRdTdbK3PV/gvYZuHkv7V+FZ5uhZxdgruByNbVm/JtGcSglwN1Hz0f1WstXbsFbXRk4H
         OC9w==
X-Gm-Message-State: ABy/qLYn5RWV3hVDvBIqyAqB4FhmvIBihmNbgvJNR1NY9dsznj6SE9/f
	of6LuIvhLc8VcXC5M7jLTSPTrPZRRClONPFiVMCcf5dau/Hyxz3X6W1P/WAWdeuDHa8azgaX3TK
	ptrJuYBsx1NJjX0WG
X-Received: by 2002:a05:6214:19e9:b0:63c:7427:e7e9 with SMTP id q9-20020a05621419e900b0063c7427e7e9mr4493711qvc.6.1690443285860;
        Thu, 27 Jul 2023 00:34:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGTrykDjpbg/R1Mtb6qfJcIecQ9pyF15SQ90DIo/BDc2dp4I1nqmkSehaimfPaY6ZdARx0Vcw==
X-Received: by 2002:a05:6214:19e9:b0:63c:7427:e7e9 with SMTP id q9-20020a05621419e900b0063c7427e7e9mr4493694qvc.6.1690443285622;
        Thu, 27 Jul 2023 00:34:45 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-238-55.dyn.eolo.it. [146.241.238.55])
        by smtp.gmail.com with ESMTPSA id e16-20020a0caa50000000b0063d3dbf77f8sm106914qvb.51.2023.07.27.00.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 00:34:45 -0700 (PDT)
Message-ID: <c4ca108f891718188ea2a9560324d23de2740565.camel@redhat.com>
Subject: Re: [PATCH v2] bpf: Add length check for
 SK_DIAG_BPF_STORAGE_REQ_MAP_FD parsing
From: Paolo Abeni <pabeni@redhat.com>
To: Lin Ma <linma@zju.edu.cn>, davem@davemloft.net, edumazet@google.com, 
 kuba@kernel.org, ast@kernel.org, martin.lau@kernel.org, yhs@fb.com, 
 void@manifault.com, andrii@kernel.org, houtao1@huawei.com,
 inwardvessel@gmail.com,  kuniyu@amazon.com, songliubraving@fb.com,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Thu, 27 Jul 2023 09:34:41 +0200
In-Reply-To: <20230725023330.422856-1-linma@zju.edu.cn>
References: <20230725023330.422856-1-linma@zju.edu.cn>
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
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-07-25 at 10:33 +0800, Lin Ma wrote:
> The nla_for_each_nested parsing in function bpf_sk_storage_diag_alloc
> does not check the length of the nested attribute. This can lead to an
> out-of-attribute read and allow a malformed nlattr (e.g., length 0) to
> be viewed as a 4 byte integer.
>=20
> This patch adds an additional check when the nlattr is getting counted.
> This makes sure the latter nla_get_u32 can access the attributes with
> the correct length.
>=20
> Fixes: 1ed4d92458a9 ("bpf: INET_DIAG support in bpf_sk_storage")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

I guess this should go via the ebpf tree, right? Setting the delegate
accordingly.=20

Please correct me if I'm wrong.

Thanks!

/P


