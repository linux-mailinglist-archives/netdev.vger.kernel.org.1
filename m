Return-Path: <netdev+bounces-42966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1517D0D79
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C9FAB20D3D
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 10:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FB712E7C;
	Fri, 20 Oct 2023 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="q7fxKNp/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEC1179A2
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 10:38:36 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDBED53
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 03:38:35 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso875318a12.1
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 03:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697798314; x=1698403114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UChiINUyEpY2Ko4HFfGal2l31hxLZ4K0lUAgDy18hDo=;
        b=q7fxKNp/cCg4JXeH+Trgp26gHUk976q3k/NRxQI9MJm1MDk4WuBT2dEbjpAbAlNI+5
         tnhYWr9tVz3w6h2xquNY1P7vvGgAI53VZWZp0l1W8qoz5h8fsKwhCPQBUjSWYypTJf7X
         GPlaOe05J9uUS3n0O53hzRtdKnrpaUaDg28GX3b0A2YsLB3jK0PskWd/k8WvujjTHqCR
         YwJaIGvA/qhMxxAOKKOK+U5P4CWM346IGEMcTWbFdb+An/OzW5H7aVxTBLNlHAoL8OAM
         4iPB4KPBK8OOo8Q3K7c0EUYwyEx+8yPKkGXSVv19hTQl3OIA4MBOd5HHYQZ10t4i0rKa
         CVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697798314; x=1698403114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UChiINUyEpY2Ko4HFfGal2l31hxLZ4K0lUAgDy18hDo=;
        b=igTKyHbzrK8oUXTYvKjXfxZz96rlnlYwFnhmsNSy3JSlwQUgm3aTkkYKmWtb+pQXEZ
         sr6p8AKVfVisA0Fu5622l+EI31o2wvXYm+pvLBYr46pumsJpjhQdxNSw5QP2uYQyt5f3
         6eF0tW846VTQojmGhihXZLIXz492DjsjnkVjTdWOldkwHLdHteZgNUsakTFygdhriw4L
         HrBKSiQ5NgQOxgD6s9RGq3/DxevyA81G6kcdPXLCk+ZWjU0+PSDtX32cm81qxchACown
         4p5JEhrwXZ9J5mt3i/A+8cEb+v646+Xs7ZVqfJAPSTa1fE1pjA97HhPHVEqz3xP4Z7/o
         uG6w==
X-Gm-Message-State: AOJu0YzpcsM/3LUQ+pVnzJIQXIO9gS38gs841Jennlsp72JXvWyxtWgl
	Zs7EescA6AnJHqaXMk0sOhSGWQ==
X-Google-Smtp-Source: AGHT+IGUbM5agQcEPNzYCqdtaTZPmbOSMp2QosBY/RDVw1m0+FtsJ4PrSTkG/wDX0pqVECheXqhv0g==
X-Received: by 2002:a50:aa9b:0:b0:53e:1f7d:10f2 with SMTP id q27-20020a50aa9b000000b0053e1f7d10f2mr1208943edc.10.1697798313707;
        Fri, 20 Oct 2023 03:38:33 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id dm28-20020a05640222dc00b0053def18ee8bsm1189249edb.20.2023.10.20.03.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:38:33 -0700 (PDT)
Date: Fri, 20 Oct 2023 12:38:31 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, johannes.berg@intel.com, mpe@ellerman.id.au,
	j@w1.fi
Subject: Re: [PATCH net-next 4/6] net: trust the bitmap in __dev_alloc_name()
Message-ID: <ZTJYpx5dn4UPa2/j@nanopsycho>
References: <20231020011856.3244410-1-kuba@kernel.org>
 <20231020011856.3244410-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020011856.3244410-5-kuba@kernel.org>

Fri, Oct 20, 2023 at 03:18:54AM CEST, kuba@kernel.org wrote:
>Prior to restructuring __dev_alloc_name() handled both printf
>and non-printf names. In a clever attempt at code reuse it
>always prints the name into a buffer and checks if it's
>a duplicate.
>
>Trust the bitmap, and return an error if its full.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>---
> net/core/dev.c | 15 ++++-----------
> 1 file changed, 4 insertions(+), 11 deletions(-)
>
>diff --git a/net/core/dev.c b/net/core/dev.c
>index bbfb02b4a228..d2698b4bbad4 100644
>--- a/net/core/dev.c
>+++ b/net/core/dev.c
>@@ -1119,18 +1119,11 @@ static int __dev_alloc_name(struct net *net, const char *name, char *res)
> 
> 	i = find_first_zero_bit(inuse, max_netdevices);
> 	bitmap_free(inuse);
>+	if (i == max_netdevices)
>+		return -ENFILE;

Hmm, aren't you changeing functionality here? I mean, prior to this
patch, the i of value "max_netdevices" was happily used, wan't it?
In theory it may break things allowing n-1 netdevices of a name instead
of n.


> 
>-	snprintf(buf, IFNAMSIZ, name, i);
>-	if (!netdev_name_in_use(net, buf)) {
>-		strscpy(res, buf, IFNAMSIZ);
>-		return i;
>-	}
>-
>-	/* It is possible to run out of possible slots
>-	 * when the name is long and there isn't enough space left
>-	 * for the digits, or if all bits are used.
>-	 */
>-	return -ENFILE;
>+	snprintf(res, IFNAMSIZ, name, i);
>+	return i;
> }
> 
> /* Returns negative errno or allocated unit id (see __dev_alloc_name()) */
>-- 
>2.41.0
>

