Return-Path: <netdev+bounces-44735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 711A07D97A2
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 14:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4FB282389
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFA51A278;
	Fri, 27 Oct 2023 12:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="co579VLK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBE919BB8
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 12:17:55 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F41E1BB
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 05:17:53 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4083f61312eso15658515e9.3
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 05:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698409071; x=1699013871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HnSSviJMbW73CYFlxlkiiUfIJKhXBNtv3pZYT4H9PPE=;
        b=co579VLKrA/JlhVxKXF5+hGXDgFVBxmXYAzgiJ5jBXxBPKOJtLDSjg8djtCBdxrKUb
         DSFZb+dKSZYCZZnRTqufoVBQa8V+4xZ8kS3BfpKNnpebUKl7p4nV2suCTaLlunvJARDk
         73im62tM3BHSZFIEvadj35PMZYgzNOWOHE8VBH1nFcTXGUQamri65FRMga0wxpkjE1Dv
         9a1COrLCABMLurxhonr/k6OpL6l/vp0QYYAmlyqNu0wOTB/v44tpp6iTVsA94IR0aLPb
         wwpXMB/47RptYSxE5/WgAh/b9x58H+WyXIdgf5RCZrTv30ruPvvt0blydCMAc7rG95WX
         J5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698409071; x=1699013871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnSSviJMbW73CYFlxlkiiUfIJKhXBNtv3pZYT4H9PPE=;
        b=jmhL9vuHy0wix/gumV8IecJgDTVRHO53rdp33u1KZyV1IvCXRAbh8NwTdjSgJGLBF1
         n8+yl69FJW70YQKhusxTFyaLFOevdDyB0Ov/ysxQ+M+T3BLUcRbNAAHMp6VwCJYkid/d
         /actYe3zTlbaJ2wxaTacHb2vhj7p6/ZEkFPig5WhUVQjLl6uHEyKvWYxoXwagsi02Jo6
         PF81aftKKaQA7bIpQ+rwxhdHsluu09/0u8wed6MTfhiD7DcWGjwEOWEyk8zMe6vnfIi1
         rVrRpkSFvl/A27BuJ15yujZssirLPmE1FHClUJzOoPm27TCGL2nJ4rVMGEUIWm2tTHIT
         as5Q==
X-Gm-Message-State: AOJu0YzuL2S6ZVImtEp+/tqYverPseTmZFWwlke74lvGI5lFkYpg4A89
	oOC4TGJ7pWALJnEVOlgPOQoBdz65cRniwvSR+yk=
X-Google-Smtp-Source: AGHT+IHC6uUGgPeWGP9gaB+YAHmpUGN6zGIl085NvPG+QmhGh3Kqwvs35IBgNlyG8cGXTzKE3kaLCg==
X-Received: by 2002:a05:600c:5251:b0:407:8e68:4a5b with SMTP id fc17-20020a05600c525100b004078e684a5bmr2473427wmb.38.1698409071274;
        Fri, 27 Oct 2023 05:17:51 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l41-20020a05600c1d2900b004090ca6d785sm1554896wms.2.2023.10.27.05.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 05:17:51 -0700 (PDT)
Date: Fri, 27 Oct 2023 15:17:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bo Liu <liubo03@inspur.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-XXX] vhost-vdpa: fix use after free in
 vhost_vdpa_probe()
Message-ID: <1eaf041b-6556-40e3-ad80-993754b2bc0f@kadam.mountain>
References: <cf53cb61-0699-4e36-a980-94fd4268ff00@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf53cb61-0699-4e36-a980-94fd4268ff00@moroto.mountain>

Ugh...  Crap.

I modified this patch to apply cleanly on net but I still didn't change
the subject to net.  But now that I'm looking at it actually goes
through one of the virt trees.

It should still apply to whatever virt tree as well.  It's just shifted
70 lines.

regards,
dan carpenter


