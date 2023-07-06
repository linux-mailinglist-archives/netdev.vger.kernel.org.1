Return-Path: <netdev+bounces-15747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA1B7497D7
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 11:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB111C20C99
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 09:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8571FBA;
	Thu,  6 Jul 2023 09:01:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B301309F
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 09:01:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2933F1BCE
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 02:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688634109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qi7u0r6BcPK/thgcy9NPn79CF3hPv/q0g1w/o2j+xHE=;
	b=iEc4p4Edj6EaaJSBaDglr3FBzHGf9rBR9fSEbBzL8CbZX2Gxqjisdov/8XA4gpCFAhRew2
	vT4qPFYCKU1vBVV2ZdcjYItqVUYmcupkE46BKtsLuuxUYDTQ64YgUqfPo3JD+0vmPRbRO0
	wpqQc2iR9eUgDsUz1/8SJ7dUScsZspw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-FY25iL0hNBi3S-1G-fthSQ-1; Thu, 06 Jul 2023 05:01:48 -0400
X-MC-Unique: FY25iL0hNBi3S-1G-fthSQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-635e2618aaeso1343496d6.0
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 02:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688634107; x=1691226107;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qi7u0r6BcPK/thgcy9NPn79CF3hPv/q0g1w/o2j+xHE=;
        b=GrV4/zh7YBWzl97Z26yOmsymYKdPMtxVyrZX1NRHQNc8SFiGzhpL7qsiJMEZr1t5Q0
         iLB6Yr54ruSmINCC19dk1eYPrOEIGWhpPZwBDPo5DUzmC/pMIlaa2bbAgHY73YIBE/x+
         fx+sbsTQPee7KOyae2SXrOxmfs/KmiW33harLUbTX0xbcxLwAfOYLUKiFhxlXSOkLnyY
         0V1PW9KVLZ2MBdjsfiVnHuA7blnqUhrXjGkRFE3aW+saKDVqGY8zWfembeEDZtj/yH7a
         eTMORbpaIk+CSprgrEbW+GGRG7VL0zGohMyp60GrAn7pfOXJHO+EjC26likPwoDINcPN
         jREA==
X-Gm-Message-State: ABy/qLaAEGZfPQcECZ8pwceU4KR74Vw88CDJCFLBs2PGm2PmNNfp8t/A
	PgtGg5BQXVxJyUr2uMSb+CjWcdY/0nJnWs5+m/HhEGS4vuAVzM7Th547sSiVS+CljB+0lxA7HnL
	Z9zKzLkzPyRBWtDMd
X-Received: by 2002:a05:6214:5298:b0:635:ec47:bfa4 with SMTP id kj24-20020a056214529800b00635ec47bfa4mr1161164qvb.4.1688634107645;
        Thu, 06 Jul 2023 02:01:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGtWnu41mn5Ponn3JjXVBuIzv07N/hyizwAr6C422tUw/GBlo7Epua+9aJP5n1D7Em8tWJ66A==
X-Received: by 2002:a05:6214:5298:b0:635:ec47:bfa4 with SMTP id kj24-20020a056214529800b00635ec47bfa4mr1161142qvb.4.1688634107320;
        Thu, 06 Jul 2023 02:01:47 -0700 (PDT)
Received: from gerbillo.redhat.com (host-95-248-55-118.retail.telecomitalia.it. [95.248.55.118])
        by smtp.gmail.com with ESMTPSA id f1-20020a0ccc81000000b0062ffcda34c6sm618257qvl.137.2023.07.06.02.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 02:01:46 -0700 (PDT)
Message-ID: <8c98394f6d399b4e725521f8d9fe9788f7fe3784.camel@redhat.com>
Subject: Re: [PATCH net 1/6] netfilter: nf_tables: report use refcount
 overflow
From: Paolo Abeni <pabeni@redhat.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org, 
	edumazet@google.com
Date: Thu, 06 Jul 2023 11:01:42 +0200
In-Reply-To: <20230705230406.52201-2-pablo@netfilter.org>
References: <20230705230406.52201-1-pablo@netfilter.org>
	 <20230705230406.52201-2-pablo@netfilter.org>
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

On Thu, 2023-07-06 at 01:04 +0200, Pablo Neira Ayuso wrote:
> Overflow use refcount checks are not complete.
>=20
> Add helper function to deal with object reference counter tracking.
> Report -EMFILE in case UINT_MAX is reached.
>=20
> nft_use_dec() splats in case that reference counter underflows,
> which should not ever happen.

For the records, I also once had the need for an non atomic reference
counters implementing sanity checks on underflows/overflows. I resorted
to use plain refcount_t, since the atomic op overhead was not
noticeable in my use-case.

[not blocking this series, just thinking aloud] I'm wondering if a
generic, non-atomic refcounter infra could be useful?

Cheers,

Paolo


