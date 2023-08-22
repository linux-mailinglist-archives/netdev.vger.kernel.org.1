Return-Path: <netdev+bounces-29729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A59784812
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 18:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B8F281135
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 16:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2112B55F;
	Tue, 22 Aug 2023 16:56:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8D62B548
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 16:56:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCEB1B0
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 09:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692723402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/dsLYMjhPm8+xZic1Jxn+IF68s5luQhDEnqKJ43WGh8=;
	b=MO+w77M9lgX1VfNqGbRcvEK9/yvVkXetsmx6d707rf3r6o4QgKRxIuAiy6NrxDonhaII0v
	kQCy65S+y5ZruKdgM5mVTzDl2i9uxu/GR4rID7Gq6ek25GgXEAk4jUWeEcbGy7s9y0HgZn
	zTIsBsKYsGtjWu1papFcIP+pABe6wzs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-tNWbwX9vPeqcftJzecxMog-1; Tue, 22 Aug 2023 12:56:40 -0400
X-MC-Unique: tNWbwX9vPeqcftJzecxMog-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a355cf318so353780966b.2
        for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 09:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692723399; x=1693328199;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dsLYMjhPm8+xZic1Jxn+IF68s5luQhDEnqKJ43WGh8=;
        b=P2BegxZfK9KelzVOworZL76YlHOTaLZXNFDrbuXiQUuhvxDysWaI/x9kByguvfq0n8
         96cBIm6gotufmMGm7G3BFCtIJ15+1WsBzHstpTkraajmVogZIueDwFOFfsT9BDK82ccA
         FmyWMDOGOaUs72XuzfFYNIi4Qf83TkG/f927jsVOyW+cUXWUWUkjRBbvhzoMVSWcPSHa
         k79tPa8CB9lA1Q40xDy7sflf1jxY91XNm+U/w6mqtHLnzfoYHKm2UUJVVYYngaCSScTP
         s7Obji+YAN4Bt0lNTkYrPppK3+HbrjHhP878GDwoncEibCTO/kljpi3shqrZReNAFOnU
         Xkxw==
X-Gm-Message-State: AOJu0YzWpL4Eo0wiGKF/EGLS7dpJDYzU25lCKs0zJrcOuj9jWt9XMRTn
	NMPdMLURIhLUDLui3dqq3BgPr0eUAPH1Q7iLMrlPPeKqO0IrtcaFOwFB+U9Y7bcbnYLPdgh0L7r
	151nyeb8ypm+/o9Yo
X-Received: by 2002:a17:907:75f6:b0:9a1:bf00:ae52 with SMTP id jz22-20020a17090775f600b009a1bf00ae52mr1428890ejc.62.1692723399452;
        Tue, 22 Aug 2023 09:56:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg14w9BT3MuJ1e9lbFLJgBlZGSF1Xm7Xgr4TXJ0Ig7uBEo3N3xyUKcYGmmWs/APvIsBT6zeg==
X-Received: by 2002:a17:907:75f6:b0:9a1:bf00:ae52 with SMTP id jz22-20020a17090775f600b009a1bf00ae52mr1428863ejc.62.1692723399142;
        Tue, 22 Aug 2023 09:56:39 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id lo8-20020a170906fa0800b009929ab17bdfsm8377605ejb.168.2023.08.22.09.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 09:56:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 5CCA3D3CCDA; Tue, 22 Aug 2023 18:56:38 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, Samuel Dobron
 <sdobron@redhat.com>, Ondrej Lichtner <olichtne@redhat.com>, Rick Alongi
 <ralongi@redhat.com>
Subject: Re: [PATCH bpf-next 4/6] samples/bpf: Remove the xdp1 and xdp2
 utilities
In-Reply-To: <721e5240-ab19-507a-c80e-ce5d133c0a9f@kernel.org>
References: <20230822142255.1340991-1-toke@redhat.com>
 <20230822142255.1340991-5-toke@redhat.com>
 <721e5240-ab19-507a-c80e-ce5d133c0a9f@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 22 Aug 2023 18:56:38 +0200
Message-ID: <87cyzf9fsp.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> On 22/08/2023 16.22, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> The functionality of these utilities have been incorporated into the
>> xdp-bench utility in xdp-tools. Remove the unmaintained versions in
>> samples.
>>=20
>
> I think it will be worth our time if we give some examples of how the
> removed utility translates to some given xdp-bench commands.  There is
> not a 1-1 mapping.
>
> XDP driver changes need to be verified on physical NIC hardware, so
> these utilities are still being run by QA.  I know Red Hat, Intel and
> Linaro QA people are using these utilities.  It will save us time if we
> can reference a commit message instead of repeatable describing this.
> E.g. for Intel is it often contingent workers that adds a tested-by
> (that all need to update their knowledge).

I did think about putting that in the commit message for these, but I
figured it was too obscure a place to put it, compared to (for instance)
putting it into the xdp-bench man page.

If you prefer to have it in the commit message as well, I can respin
adding it - WDYT?

-Toke


