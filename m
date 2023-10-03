Return-Path: <netdev+bounces-37636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A787B6693
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 12:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 1CC31281630
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 10:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DAEDDDD;
	Tue,  3 Oct 2023 10:41:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC623DDAC
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 10:41:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E6FB7
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 03:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696329690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEM5s9LjMr/YRPee+FNwgiSqc+ylSynZdt7LNsU3DA8=;
	b=DSLIzrKjcWZypmbh1z5xtD0OfVGSU0vrcSXfbrfUQ94MJnRfDv3lkeDdAgfFAbP7/ZN049
	2PQ4uEyQnJJwK8JvkW7HZui81i+ZlSGuGs/pxSkMsNwCvf6zsuuneXmC6WNtS21gDHDpb2
	lhoV/P2CoXwD5t/aXijmM2LBIJrpevA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-3rvotzW1MZitUZdGxEG9ZQ-1; Tue, 03 Oct 2023 06:41:29 -0400
X-MC-Unique: 3rvotzW1MZitUZdGxEG9ZQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9ae6afce33fso17928566b.0
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 03:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696329688; x=1696934488;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xEM5s9LjMr/YRPee+FNwgiSqc+ylSynZdt7LNsU3DA8=;
        b=TERvpID2kVIiawYCFgAv3xI06Hcsf1/SZkhXChmXurFkjAsJwbUiVk6wjZp4P2v8sR
         0RtySOCpVKSwrRoi3+RlW8G8kzfo0uBwyXgx+HcJ3lj07P/JaghQOvzciRfLgjfp8wEt
         8wedf4gyhQJMyStHl6DHsW7O8FyJHLmrR4KLMAU3qqQJBqxZPpn8VMHB4VXJMAnFsbyp
         33wc2ytQaSR835lfmPZ6MpB3qMeypIX35b1v7hNnX4in7k+L4sq7J4Or32aOdX8VFQur
         lTsFbnfG7rzrcCezRSo9e7jUjdMksf0wAvqDah4ZHZuUbPmh91XzVvxxdyBMe6OVN42f
         d5tQ==
X-Gm-Message-State: AOJu0YyDRX28LZPQTX029CoEBMseGckYdAnTbUvX/qxFBSfFT7v8URF2
	HWnHCC9fYPeeb9fNIGv9bXUjkIhZ24mrSs87Dc4nC5VhMAVRvIkJaYzOzmY2RQf2FIMfo3Zpeyq
	ri9vOvN2/aP0revZX
X-Received: by 2002:a17:906:25d:b0:9b2:bf2d:6b65 with SMTP id 29-20020a170906025d00b009b2bf2d6b65mr13123552ejl.4.1696329688212;
        Tue, 03 Oct 2023 03:41:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTp4Yzu/cOAedVnFfUtha2zEKWPPeZzfa3qsmsNMKsBJ+r6YYEbp9xiJ3pmDMPdNIMRLIP9g==
X-Received: by 2002:a17:906:25d:b0:9b2:bf2d:6b65 with SMTP id 29-20020a170906025d00b009b2bf2d6b65mr13123529ejl.4.1696329687871;
        Tue, 03 Oct 2023 03:41:27 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-193.dyn.eolo.it. [146.241.232.193])
        by smtp.gmail.com with ESMTPSA id n10-20020a170906118a00b009a19701e7b5sm832863eja.96.2023.10.03.03.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 03:41:27 -0700 (PDT)
Message-ID: <6e5fb3e148ae1fb4a29561fe9d04235d8be6ab1f.camel@redhat.com>
Subject: Re: [PATCH net-next] net/smc: add support for netdevice in
 containers.
From: Paolo Abeni <pabeni@redhat.com>
To: dust.li@linux.alibaba.com, Albert Huang <huangjie.albert@bytedance.com>,
  Karsten Graul <kgraul@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
 Jan Karcher <jaka@linux.ibm.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu
 <tonylu@linux.alibaba.com>,  Wen Gu <guwen@linux.alibaba.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 03 Oct 2023 12:41:25 +0200
In-Reply-To: <20230927034209.GE92403@linux.alibaba.com>
References: <20230925023546.9964-1-huangjie.albert@bytedance.com>
	 <20230927034209.GE92403@linux.alibaba.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-09-27 at 11:42 +0800, Dust Li wrote:
> On Mon, Sep 25, 2023 at 10:35:45AM +0800, Albert Huang wrote:
> > If the netdevice is within a container and communicates externally
> > through network technologies like VXLAN, we won't be able to find
> > routing information in the init_net namespace. To address this issue,
>=20
> Thanks for your founding !
>=20
> I think this is a more generic problem, but not just related to VXLAN ?
> If we use SMC-R v2 and the netdevice is in a net namespace which is not
> init_net, we should always fail, right ? If so, I'd prefer this to be a b=
ugfix.

Re-stating the above to be on the same page: the patch should be re-
posted targeting the net tree, and including a suitable fixes tag.

@Dust Li: please correct me if I misread you.

Thanks,

Paolo


