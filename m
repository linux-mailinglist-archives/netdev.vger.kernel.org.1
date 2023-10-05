Return-Path: <netdev+bounces-38216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D2C7B9C98
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 12:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 166E11C2093D
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 10:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368C2125D2;
	Thu,  5 Oct 2023 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KX1m+wJo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86241C3D
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 10:48:51 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AE622CA7
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 03:48:49 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-405361bba99so7049305e9.2
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 03:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696502928; x=1697107728; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v7cACkrX+vqQTrjRrnKRIXYMlLqZ2hjohH6wUGEg+z0=;
        b=KX1m+wJo5dtZXF/BKWfe54iJj1gGXO1xUAjB9fSdjDCAU1IAiKabFk0UTN83WVp5XW
         E7esAWuLur7FILaARrY+NWHLNgcXx0SnzRcub032SRiBHM6R7sgiSYQez1pnVL5oCElc
         Se8JBNEkaZ31KJlU6K2DEiW/yg5TENUk67Fkr76NgFqhAfCzyfkboefPHsmX6M1kGFyt
         5dTV1e15dx7H9UYJGX3CmZVC8Wp9ufEEpT8vuK6HIqPBBDRPnktnTwogV3rg32WcJo5B
         v0UKepsusq4k7lKM6sXaSncDl3tAUL6/0dL6ooiOmX+24hrePujecd7DT73E+vGDsBvk
         3Lqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696502928; x=1697107728;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v7cACkrX+vqQTrjRrnKRIXYMlLqZ2hjohH6wUGEg+z0=;
        b=tLdcVZCzok7Q5ObxYdnEJIOw86Wp4vfe6R7YJATxgX67BR/+whhesnq6Z8znHsCVtJ
         z/7ct3ZUp+BGwjoBA+kKawcGJgt9uxNSQLC4lXYi2LMy5co2vWsyzZBTFW9RVQ3KmcfG
         ZnydQFHDyBsbs8RCUSHHEbnY6S5WtmIcXIlH8tRE7QGx/isFBWPdEvSlpyPXVhoBwikQ
         4z9Hy4/3oj9EW+InqPd4jwQ4Vc50KH/jScjyd26ef65LPdRbyE+fk51l6yDcFKJ1EWNm
         TrtkbN8T2FvLRKNz+DV9ImEMk4U2dJPqOZFgF1l1MY5b9oqX3AN6MM0BzNQ514+PEwRb
         4j/w==
X-Gm-Message-State: AOJu0Yx65+LvLsj8zUqUNiTr2uagcCIkPuNazpMPbbYpPVGBX2lM1PDB
	IfSeAXsLYjeHK5aw1yNJuc/9f9nBO9k=
X-Google-Smtp-Source: AGHT+IFz7nokK3wsOK0cAYjCaaDqaXc6dxlp8/nrM+VGenVLWRKO7echt69DFqVQGcufIYrhM7/zXA==
X-Received: by 2002:a7b:cd0a:0:b0:405:3ae6:2400 with SMTP id f10-20020a7bcd0a000000b004053ae62400mr4765219wmj.23.1696502927964;
        Thu, 05 Oct 2023 03:48:47 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id x2-20020a1c7c02000000b003fe23b10fdfsm3455271wmc.36.2023.10.05.03.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 03:48:47 -0700 (PDT)
Message-ID: <651e948f.1c0a0220.e602c.04aa@mx.google.com>
X-Google-Original-Message-ID: <ZR6UjSZF3bG6y4ZG@Ansuel-xps.>
Date: Thu, 5 Oct 2023 12:48:45 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: dsa: qca8k: fix regmap bulk read/write
 methods on big endian systems
References: <20231004091904.16586-1-kabel@kernel.org>
 <20231004091904.16586-2-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231004091904.16586-2-kabel@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 04, 2023 at 11:19:03AM +0200, Marek Behún wrote:
> Commit c766e077d927 ("net: dsa: qca8k: convert to regmap read/write
> API") introduced bulk read/write methods to qca8k's regmap.
> 
> The regmap bulk read/write methods get the register address in a buffer
> passed as a void pointer parameter (the same buffer contains also the
> read/written values). The register address occupies only as many bytes
> as it requires at the beginning of this buffer. For example if the
> .reg_bits member in regmap_config is 16 (as is the case for this
> driver), the register address occupies only the first 2 bytes in this
> buffer, so it can be cast to u16.
> 
> But the original commit implementing these bulk read/write methods cast
> the buffer to u32:
>   u32 reg = *(u32 *)reg_buf & U16_MAX;
> taking the first 4 bytes. This works on little endian systems where the
> first 2 bytes of the buffer correspond to the low 16-bits, but it
> obviously cannot work on big endian systems.
> 
> Fix this by casting the beginning of the buffer to u16 as
>    u32 reg = *(u16 *)reg_buf;
> 
> Fixes: c766e077d927 ("net: dsa: qca8k: convert to regmap read/write API")
> Signed-off-by: Marek Behún <kabel@kernel.org>

Just find time to test this on a friend's big-endian device and can confirm
this fix the problem. Thanks!

Tested-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Christian Marangi <ansuelsmth@gmail.com>

-- 
	Ansuel

