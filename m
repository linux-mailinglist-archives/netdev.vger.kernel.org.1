Return-Path: <netdev+bounces-29733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A3C784877
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 19:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C916C28113B
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A5F2B571;
	Tue, 22 Aug 2023 17:36:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708632B545
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 17:36:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1C7A27E
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 10:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692725761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hz7Z8y2P7m45R2UBTeGN2JuhmC8I5fCqRqJcDftK6rI=;
	b=if+i1A/TGxTtbWGbUv72aEFLdfa39KZbYmdRiesdNL8smUmnD2rNg6tE1aXQxSetTDeoht
	5Y9szg9UQxYiWRshzQd15Vg2VIKl1WCN8GuA5DXkLI+6ALBEsgvIChtKeB5tkXuAPRM83V
	zyqRYFaHRHuLeZ2AiCAd4qqiLTscXzA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-VxzjE60pOqG40tTI-P4eHA-1; Tue, 22 Aug 2023 13:36:00 -0400
X-MC-Unique: VxzjE60pOqG40tTI-P4eHA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b9ce397ef1so47973741fa.1
        for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 10:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692725759; x=1693330559;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hz7Z8y2P7m45R2UBTeGN2JuhmC8I5fCqRqJcDftK6rI=;
        b=RYDyMR1oM5BzHEmhtAlLBF/RquweZGzOvXDcW98fW9Td/XPggbWpcyuGNa9Lgt3c+s
         qRcILheGuozCbLPOnCPm201NoBE6WfsbBr89uwE2dvG1H/JZZ5oDDx0SN0kfnVc4uD0C
         c5rzV1hcmwhz51moAqvRmXxhVpXuhF8gHZ5E4FPYX9wZ6fUxeY3+v1fUfvgjPATC6pju
         F6ybSXEQN824Jsp0hNb9fYX1wRxhwA96T683P/kO3ntP+IP0B0NOP15wB2JdO63Kn2ux
         goUWcuvKz0BBvmInBouc33BxfOPewmqg6HD5zMltwZTtkR6OulifbfP9AqhZ+XmGFoxy
         ic1A==
X-Gm-Message-State: AOJu0Yzt7Mp3ekgxVMG/wkIS99VmclZJFOZZztlc6e3MsBhjJlSFxenl
	bNR5t2XO6xnx3wdO9BXzqrr75iSeVbexXEOYt7mjNM92PIMbiDjpeLvmjc+AxV8PPK3G/9w3SPW
	boYymN/XGEpOtoNLE
X-Received: by 2002:a2e:320c:0:b0:2b9:e93e:65e6 with SMTP id y12-20020a2e320c000000b002b9e93e65e6mr7647443ljy.35.1692725758699;
        Tue, 22 Aug 2023 10:35:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEaliFX53rXvTcqcEnmCJyi1Pl+k86CRgOTzWYinO3AVLwjYDMLIqFkUd69rkXPS8IFj5usA==
X-Received: by 2002:a2e:320c:0:b0:2b9:e93e:65e6 with SMTP id y12-20020a2e320c000000b002b9e93e65e6mr7647408ljy.35.1692725758245;
        Tue, 22 Aug 2023 10:35:58 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id l4-20020a1709062a8400b00997e00e78e6sm8483372eje.112.2023.08.22.10.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 10:35:57 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 88C3FD3CCEB; Tue, 22 Aug 2023 19:35:57 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <jbrouer@redhat.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: brouer@redhat.com, bpf@vger.kernel.org, netdev@vger.kernel.org, Samuel
 Dobron <sdobron@redhat.com>, Ondrej Lichtner <olichtne@redhat.com>, Rick
 Alongi <ralongi@redhat.com>
Subject: Re: [PATCH bpf-next 4/6] samples/bpf: Remove the xdp1 and xdp2
 utilities
In-Reply-To: <b3d2080d-e593-283b-cf97-d39256cfd4e9@redhat.com>
References: <20230822142255.1340991-1-toke@redhat.com>
 <20230822142255.1340991-5-toke@redhat.com>
 <721e5240-ab19-507a-c80e-ce5d133c0a9f@kernel.org> <87cyzf9fsp.fsf@toke.dk>
 <b3d2080d-e593-283b-cf97-d39256cfd4e9@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 22 Aug 2023 19:35:57 +0200
Message-ID: <877cpn9dz6.fsf@toke.dk>
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

Jesper Dangaard Brouer <jbrouer@redhat.com> writes:

> On 22/08/2023 18.56, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Jesper Dangaard Brouer <hawk@kernel.org> writes:
>>=20
>>> On 22/08/2023 16.22, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> The functionality of these utilities have been incorporated into the
>>>> xdp-bench utility in xdp-tools. Remove the unmaintained versions in
>>>> samples.
>>>>
>>>
>>> I think it will be worth our time if we give some examples of how the
>>> removed utility translates to some given xdp-bench commands.  There is
>>> not a 1-1 mapping.
>>>
>>> XDP driver changes need to be verified on physical NIC hardware, so
>>> these utilities are still being run by QA.  I know Red Hat, Intel and
>>> Linaro QA people are using these utilities.  It will save us time if we
>>> can reference a commit message instead of repeatable describing this.
>>> E.g. for Intel is it often contingent workers that adds a tested-by
>>> (that all need to update their knowledge).
>>=20
>> I did think about putting that in the commit message for these, but I
>> figured it was too obscure a place to put it, compared to (for instance)
>> putting it into the xdp-bench man page.
>>=20
>> If you prefer to have it in the commit message as well, I can respin
>> adding it - WDYT?
>>=20
>
> It is super nice that xdp-bench already have a man page, but I was=20
> actually looking at this and it was a bit overwhelming (520 lines)=20
> explaining every possible option.

Haha, I think that's the first time I've had anyone complain that I
write too *much* documentation ;)

> I really think its worth giving examples in the commit, to ease the=20
> transition to this new tool.

OK, I'll respin tomorrow with some examples in the commit messages...

-Toke


