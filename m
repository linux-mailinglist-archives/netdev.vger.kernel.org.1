Return-Path: <netdev+bounces-35472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3D97A99F2
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 20:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383131F21311
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 18:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4927814001;
	Thu, 21 Sep 2023 17:31:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4E413FFE
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:31:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7DC515BC
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695317259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i4TZou60+SKYzdbWYogj65SYgMTBZDPG5rM/GAK2kd4=;
	b=c1uAqGKubkQ1xpP52rihHSlKOWXKIb21jTNfFXBLDHIOLngI5W7pqyu7ZZGwgyFJFOFM8u
	AXBFuAsrIz8mNSM36xIBGooC1PY4N8p630Va3seUFaBH1HrpLEMKZTWkzO9LSL1jhsS5r8
	1IgFXW2mmkj7u0S8L1+WhFbs+14fMdQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-c1m-d_yHMYqinpqsuF_t6A-1; Thu, 21 Sep 2023 04:59:36 -0400
X-MC-Unique: c1m-d_yHMYqinpqsuF_t6A-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a9cd336c9cso17685966b.1
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 01:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695286775; x=1695891575;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i4TZou60+SKYzdbWYogj65SYgMTBZDPG5rM/GAK2kd4=;
        b=Lfm34ElqGI8ilTGuXjL9aAm//CO9xKIHotZDp/ZB4GT1+CPFBAnFQreIX0uxWjnM6Y
         JMz5mcPWIPHpuXxJprad17H9/BKYIjEPhxAlcbem58Ijiz0UhQDUHon4Wd1FSDHIPeOh
         BQ899VobV20a8uc76muCfImpmRgzx5csM/jv1wnGms/DccFtlOtojN5czVpvAtJ+TV8A
         FP0GCtRRfl6J7P2YxEhMKZ06Xfs3G83UW0vhfz0wOP4KagEwx0Sf1/HvGXgMwQYPJwzJ
         PW8IBHYoxjI8BwK3OtYR86uLQP6brCWMLW51XsalK7d+EVLWg9RFntqPSJbX792XkRJc
         gx5Q==
X-Gm-Message-State: AOJu0Yxg2/vbODcsdUhzjbJYeRUO1Ihkqdq6qyfShAoy5Jf1mTPTc0Eh
	3swkDCp/8uGabIlq4nAd2SiQhBP5LdyGi5TXuMEQHj25aIZTbOJBAo1p1IPZa/7mQOd1Y1G1FT5
	+43Aqimk13Mjz2n3QKEOAu/iF
X-Received: by 2002:a17:907:9512:b0:9ae:4492:df34 with SMTP id ew18-20020a170907951200b009ae4492df34mr3040554ejc.6.1695286775006;
        Thu, 21 Sep 2023 01:59:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGlmeJnWZ+sn8kzSxDMyc1NVykwD3pK7V0gjvb5RmYbzE0KhGvzw5vrHFI35DI5C5iXlWVlg==
X-Received: by 2002:a17:907:9512:b0:9ae:4492:df34 with SMTP id ew18-20020a170907951200b009ae4492df34mr3040545ejc.6.1695286774642;
        Thu, 21 Sep 2023 01:59:34 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-251-4.dyn.eolo.it. [146.241.251.4])
        by smtp.gmail.com with ESMTPSA id lw13-20020a170906bccd00b0098884f86e41sm707189ejb.123.2023.09.21.01.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 01:59:34 -0700 (PDT)
Message-ID: <b5db3535a15b7e1bf89724d934fb880d292913cd.camel@redhat.com>
Subject: Re: [PATCH v1 0/2] Fix implicit sign conversions in handshake upcall
From: Paolo Abeni <pabeni@redhat.com>
To: Chuck Lever <cel@kernel.org>, netdev@vger.kernel.org, 
	kernel-tls-handshake@lists.linux.dev
Cc: Chuck Lever <chuck.lever@oracle.com>
Date: Thu, 21 Sep 2023 10:59:33 +0200
In-Reply-To: <169515283988.5349.4586265020008671093.stgit@oracle-102.nfsv4bat.org>
References: 
	<169515283988.5349.4586265020008671093.stgit@oracle-102.nfsv4bat.org>
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
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Tue, 2023-09-19 at 15:49 -0400, Chuck Lever wrote:
> An internal static analysis tool noticed some implicit sign
> conversions for some of the arguments in the handshake upcall
> protocol.

This does not apply cleanly to -net nor to -net-next, and the lack of
the target inside the subj is confusing. I guess this is for your devel
tree???

Cheers,

Paolo


