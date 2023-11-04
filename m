Return-Path: <netdev+bounces-46007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CF07E0D34
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 03:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF2B1C21025
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 02:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F13117CE;
	Sat,  4 Nov 2023 02:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tuo33ITN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB4517CB
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 02:08:31 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2394D184;
	Fri,  3 Nov 2023 19:08:31 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6bbfb8f7ac4so843180b3a.0;
        Fri, 03 Nov 2023 19:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699063710; x=1699668510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eas1S/wVYtGHnyaa/c7Jx06vN4wCvc4XZ4Mgg/NHg44=;
        b=Tuo33ITNyv6Bf4x5rEIDR5VczMKlG9xX9rnh9M1ge4nKOSasHUZ/e9zW0nk8rkbRiD
         OmTngYAEJThwCzcgvb6/ctuv8XueKmwBmpz+sL7y0cpJ5EQIuIOorM4l2YPywnzkIWPY
         EbLQ+dDd3H+wQ8r3PioZIbGk6Z+CT0v4VSr6YzGei5DFpUtHY2YcR+CbFrR8Qtuf+X6k
         2wipZBoxWW53+6Ao/8SoqXr6d3DeNhmNi9e8/X5XhxNBDA4aJcoYEvDYbdpv8whHwsl0
         0b8/e7EMLjGNEWoz+oBHohHv2gJ91vq8qNWpxflFUwxJHNz4sCGv7WI3e+gRrcegiUI3
         cUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699063710; x=1699668510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eas1S/wVYtGHnyaa/c7Jx06vN4wCvc4XZ4Mgg/NHg44=;
        b=Fn2v5ihakNInCrdixgkaA5J5zLyJnSbSgaBBPN5BMPcAZFvt60yRM5I/PwR7y7Ebcx
         UIeGd844b3fcyQVKn/tsZcMOV5SRQfGlDJpD4VpXqZMPbqByNOjkMWdXao/HHrRJc/gp
         vlUOkXdgCyI4ivbqvYvjtorXZ9iIl3a2k95l+zRGa9ek7r0CLxgVe3ptDiGY7LKzG7Am
         IiaPUWxsG85S3HZI+A9/msge7JGJmaaQjJ6U6sA9T6IKvDh6qL5/totmUn9ocrmcTMKS
         mR/rBvcYCVMKj5wOHNKRLJJkWPAqtw5fLfIDfQzPElod/XTXRY6Znr1js5p2J67kReC4
         K3/A==
X-Gm-Message-State: AOJu0YyhzkrjkA6i0Ne0sfCTTLr+95sCBgX3ZFjZAThT9VCADCy0e2uK
	RyMcHnp4qBYWweCKKDEXbohthaQIvH0=
X-Google-Smtp-Source: AGHT+IEwWhjgnAfJE7EHlNjQZK1knpIesVPpoivfZGQqzxa7IZwCVGuFNEl96z94lD+XdYwJbQ5tlw==
X-Received: by 2002:a05:6a20:8f11:b0:181:9ff4:bd25 with SMTP id b17-20020a056a208f1100b001819ff4bd25mr7315356pzk.4.1699063710522;
        Fri, 03 Nov 2023 19:08:30 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id e11-20020a056a001a8b00b006c2d5a31ab9sm1987708pfv.81.2023.11.03.19.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 19:08:29 -0700 (PDT)
Date: Fri, 3 Nov 2023 19:08:27 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: jeremy@jcline.org, davem@davemloft.net, habetsm.xilinx@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	reibax@gmail.com,
	syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next V3] ptp: fix corrupted list in ptp_open
Message-ID: <ZUWnmyEWLABNgT0z@hoboy.vegasvil.org>
References: <tencent_97D1BA12BBF933129EC01B1D4BB71BE92508@qq.com>
 <ZUV_1CZRUQTiANTT@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUV_1CZRUQTiANTT@hoboy.vegasvil.org>

On Fri, Nov 03, 2023 at 04:18:44PM -0700, Richard Cochran wrote:
> No need for another mutex.

Actually the mutex is needed.

Thanks,
Richard

