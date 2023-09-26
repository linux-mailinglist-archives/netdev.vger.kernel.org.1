Return-Path: <netdev+bounces-36234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E497AE748
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 10:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 186861F2557F
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 08:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD5311C8B;
	Tue, 26 Sep 2023 08:03:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0954C6E
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 08:03:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76676C9
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 01:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695715394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ELJLtZNf5BHgiOefmxJ85wHiMzo3vyZFSvRuYmBGd3k=;
	b=gD6tzs35c9GgQlCnGIbkvfyNk4r5SUP//bPF2ri/sg4tD8sfoUnBrFPbpyNSJ3OcSY2EIu
	qk3tJwr6m0d7dZcQ6A4f6AXfEUt0bFV3+BVpVH1LkHW++CcP7s854s2RUslyau4e+jM/ku
	K4+whbFtAMNL4MONlCtOoikTyx+ClWA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-MyRLrIp_OHuNuyZBzUHf9g-1; Tue, 26 Sep 2023 04:03:13 -0400
X-MC-Unique: MyRLrIp_OHuNuyZBzUHf9g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fbdf341934so75604685e9.3
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 01:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695715392; x=1696320192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELJLtZNf5BHgiOefmxJ85wHiMzo3vyZFSvRuYmBGd3k=;
        b=K8vqwXTW4LnUrIviMlvYuKatpYhiUwhMLB4/fGTZ0GRmCnMH40X7aK0CxORW8IOmx/
         ppyipl0wsrVlXkKhic8jhrXXkUmWxveIpzzT/GEBOizZ4Rc7oxaL4Vgy16ujuotjTtlc
         qmoFMORqmWaaGbFn2/5PXOTrkKgkfWvsBzeTa3+A3sMklwfh8Tb1pmcZ5DPpp7ihvUXL
         EDgvacC1VU62+d09pNxhIz3k4JWxQqTpjAYEvpo4owAVnaqZWRhENdHPszDCyT4zSYPh
         Cu96/sJstVXmZQgU67HJjhPZjZ0cYAVKNHvOadW0tYQ2W8Md4+AvWJRxKUUlBFeh051C
         tkQw==
X-Gm-Message-State: AOJu0YwkH61d2rTVb+zp1pyg4g0bm3Rw0mPRw6m32BMe++DBE9y4NtiO
	uv/Lhpvjsx1dVSFEcqxucRTrHHS7iN8UIJfM1nzVeLtgE+FkVGUM5jNFaEkuehgojHCk1fdkSDR
	20vcy4w1LbrLXzpOIJpnLSfNg/rekJK9u
X-Received: by 2002:a7b:c8ce:0:b0:3f5:fff8:d4f3 with SMTP id f14-20020a7bc8ce000000b003f5fff8d4f3mr7389497wml.7.1695715392260;
        Tue, 26 Sep 2023 01:03:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE59rpXl/SGxh4tybcaud/lyyascHkYmT5tXB1hN3iXyjhk5Q4F0p49nyFPjgDbiKxOxjQesT70FqFxc2/btoE=
X-Received: by 2002:a7b:c8ce:0:b0:3f5:fff8:d4f3 with SMTP id
 f14-20020a7bc8ce000000b003f5fff8d4f3mr7389478wml.7.1695715391965; Tue, 26 Sep
 2023 01:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230923170540.1447301-1-lulu@redhat.com> <20230923170540.1447301-8-lulu@redhat.com>
 <20230925135047.GE13733@nvidia.com>
In-Reply-To: <20230925135047.GE13733@nvidia.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 26 Sep 2023 16:02:34 +0800
Message-ID: <CACLfguUW+u+ADefgRnpRPU8DNj_EKDsrK0sy_Uj8EGtUN6Yu+g@mail.gmail.com>
Subject: Re: [RFC 7/7] iommufd: Skip the CACHE_COHERENCY and iommu group check
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: jasowang@redhat.com, mst@redhat.com, yi.l.liu@intel.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 25, 2023 at 9:50=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Sun, Sep 24, 2023 at 01:05:40AM +0800, Cindy Lu wrote:
> > This is just the work arround for vdpa, I Will
> > fix these problems in the next version.
> >
> > Skip these 2 checks:
> > 1.IOMMU_CAP_CACHE_COHERENCY check
> > 2.iommu_group_get check
>
> Uuh, something has gone really, really wrong if you need to skip these
> checks in the core iommufd code..
>
there are problems in this code, I will continue working in this.
Thanks
Cindy
> Jason
>


