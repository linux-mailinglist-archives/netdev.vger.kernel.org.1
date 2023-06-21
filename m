Return-Path: <netdev+bounces-12609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE557384F1
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7A91C20EB2
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 13:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4668317730;
	Wed, 21 Jun 2023 13:27:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B70DF4A
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 13:27:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECC01991
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 06:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687354041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ofvqVAkAqqEfRnmBiSCZMDKkhjK3J7MHukSlH9avkrY=;
	b=NSbzSz/mByiAcE9pUFl/6Guv19AF9zcQAstqvVoBu45oYh0kImYNCcYdNl74ZpbrqsTCCP
	QKFkXekKtqV5NIMz0gRNPI4GwlVQfcpo0vMOQdsKZ8BQjMAt2HhpcEwMuCWpf6aS1M6Ixj
	Z29BLOnD7ldSve+xcfnJ2MQvPlRrnEI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-JE9Nu-TtPTS-u3zTxT8AXA-1; Wed, 21 Jun 2023 09:27:19 -0400
X-MC-Unique: JE9Nu-TtPTS-u3zTxT8AXA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-98864f473c7so252623166b.0
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 06:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687354038; x=1689946038;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofvqVAkAqqEfRnmBiSCZMDKkhjK3J7MHukSlH9avkrY=;
        b=UNXOW75FdCvFUpTB9Vh33BbxqA2eUmG/TRThtytpW9vGR4tUSy3MhorZ6VU/Skwgg1
         QzdIiNIP0MzSX8w93luOJwzfI0RU9BA34QOBkHIIYcU/Ak2utGUbg1NYBEJOo6/cCOGb
         n/RqNFVKI6yaky88jtk5DtfI52bBFsIvakIZs8C99hm8F/6okg4D0l3BvuoM10MbyMcW
         xnIGzkLtjtRN0IYYM1Fp/1tms/X3kbx3jah+DRWru1WC2PJzsbXBVDGUL+Wnx1Kxt/ET
         MwVDzAw963s3UstL9oAKWU4yP7g8ZcS2WnIM0qzQDZQVK9Koeb8W/3eXisJj/ilmgb+q
         ZpKg==
X-Gm-Message-State: AC+VfDxPwenILbKhSBptRr9NtYBBsUQqzglkbcqMiocxzLmB9o8SB7oE
	Hve5vdCbf9DB4hLUrlPLtZI2DwJJfpPqmTxifet8YAbjSHhEubUpjpVFhNY4LMYdIJ95ki/vP4g
	E3Stg6qNNbNQvjZhV
X-Received: by 2002:a17:906:6a25:b0:989:40a9:505d with SMTP id qw37-20020a1709066a2500b0098940a9505dmr4476916ejc.0.1687354038334;
        Wed, 21 Jun 2023 06:27:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7qLfjtWgQdqbA+QBFU2pyLhHtF/tS4YwbyBMT3z6QITojXnrcF4+GPy+G2rIzwkKT+S4HJdg==
X-Received: by 2002:a17:906:6a25:b0:989:40a9:505d with SMTP id qw37-20020a1709066a2500b0098940a9505dmr4476899ejc.0.1687354037898;
        Wed, 21 Jun 2023 06:27:17 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id dv5-20020a170906b80500b00988a364023bsm3077010ejb.127.2023.06.21.06.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 06:27:17 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A0D60BBF23B; Wed, 21 Jun 2023 15:27:16 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>, "Fijalkowski, Maciej"
 <maciej.fijalkowski@intel.com>, "bpf@vger.kernel.org"
 <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org"
 <andrii@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Karlsson, Magnus"
 <magnus.karlsson@intel.com>, "bjorn@kernel.org" <bjorn@kernel.org>,
 "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
 "simon.horman@corigine.com" <simon.horman@corigine.com>
Subject: RE: [PATCH v4 bpf-next 06/22] xsk: introduce wrappers and helpers
 for supporting multi-buffer in Tx path
In-Reply-To: <SN7PR11MB665536C0588850F0374EFBA3905DA@SN7PR11MB6655.namprd11.prod.outlook.com>
References: <20230615172606.349557-1-maciej.fijalkowski@intel.com>
 <20230615172606.349557-7-maciej.fijalkowski@intel.com>
 <87352mdp10.fsf@toke.dk>
 <SN7PR11MB665536C0588850F0374EFBA3905DA@SN7PR11MB6655.namprd11.prod.outlook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 21 Jun 2023 15:27:16 +0200
Message-ID: <87r0q5c5e3.fsf@toke.dk>
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
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

"Sarkar, Tirthendu" <tirthendu.sarkar@intel.com> writes:

>> -----Original Message-----
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> Sent: Tuesday, June 20, 2023 10:56 PM
>>>
>> Subject: Re: [PATCH v4 bpf-next 06/22] xsk: introduce wrappers and helpe=
rs
>> for supporting multi-buffer in Tx path
>>=20
>> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
>>=20
>> > From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
>> >
>> > In Tx path, xsk core reserves space for each desc to be transmitted in
>> > the completion queue and it's address contained in it is stored in the
>> > skb destructor arg. After successful transmission the skb destructor
>> > submits the addr marking completion.
>> >
>> > To handle multiple descriptors per packet, now along with reserving
>> > space for each descriptor, the corresponding address is also stored in
>> > completion queue. The number of pending descriptors are stored in skb
>> > destructor arg and is used by the skb destructor to update completions.
>> >
>> > Introduce 'skb' in xdp_sock to store a partially built packet when
>> > __xsk_generic_xmit() must return before it sees the EOP descriptor for
>> > the current packet so that packet building can resume in next call of
>> > __xsk_generic_xmit().
>> >
>> > Helper functions are introduced to set and get the pending descriptors
>> > in the skb destructor arg. Also, wrappers are introduced for storing
>> > descriptor addresses, submitting and cancelling (for unsuccessful
>> > transmissions) the number of completions.
>> >
>> > Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
>> > ---
>> >  include/net/xdp_sock.h |  6 ++++
>> >  net/xdp/xsk.c          | 74 ++++++++++++++++++++++++++++++------------
>> >  net/xdp/xsk_queue.h    | 19 ++++-------
>> >  3 files changed, 67 insertions(+), 32 deletions(-)
>> >
>> > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
>> > index 36b0411a0d1b..1617af380162 100644
>> > --- a/include/net/xdp_sock.h
>> > +++ b/include/net/xdp_sock.h
>> > @@ -68,6 +68,12 @@ struct xdp_sock {
>> >  	u64 rx_dropped;
>> >  	u64 rx_queue_full;
>> >
>> > +	/* When __xsk_generic_xmit() must return before it sees the EOP
>> descriptor for the current
>> > +	 * packet, the partially built skb is saved here so that packet buil=
ding
>> can resume in next
>> > +	 * call of __xsk_generic_xmit().
>> > +	 */
>> > +	struct sk_buff *skb;
>>=20
>> What ensures this doesn't leak? IIUC, when the loop in
>> __xsk_generic_xmit() gets to the end of a batch, userspace will get an
>> EAGAIN error and be expected to retry the call later, right? But if
>> userspace never retries, could the socket be torn down with this pointer
>> still populated? I looked for something that would prevent this in
>> subsequent patches, but couldn't find it; am I missing something?
>>=20
>> -Toke
>>=20
>
> Thanks for catching this. We will add cleanup during socket termination i=
n v5.

Awesome! :)

-Toke


