Return-Path: <netdev+bounces-42975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9A37D0E1A
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 13:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495541C20E73
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 11:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BEB18635;
	Fri, 20 Oct 2023 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="HBVcSUib"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4DC182CA
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 11:05:54 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90700CA
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 04:05:52 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9becde9ea7bso387561666b.0
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 04:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697799951; x=1698404751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Exo5xiO3KVt/QMxdyTgJ6waq5wAsX1Iu8g5SJ6Dq8K0=;
        b=HBVcSUibaOluEIp4rlE8IlxZwafosvNC0i3bQXFpM9dOjIurprlibKD/TYhx0P0nTx
         smG0lqIdSaYfS+5ap3+7rFyGg25aJK3H7PsNPc9Vxk3QTp0ALzGeoW3ZX6WWeYUnNBIG
         FN7GpVuQn8Wpui4NH2CB+qDQNXSssd706M9Kyh2wKoKsYHqN93ieg0/WRaBvlrkNbU81
         7i5qHoiF2my/LyfglpxkvT8rQGJfnRrAJgIS0E7LrYuwOW6b2ASCGE9Z7+M2bYEnoXWd
         kBXrFWpcFRCB5VmsiCH3ruUvOpyxaOn8tZ/Ysy6WdmmFO91SUqWqvB1Jyxn54MtvhmFR
         svpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697799951; x=1698404751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Exo5xiO3KVt/QMxdyTgJ6waq5wAsX1Iu8g5SJ6Dq8K0=;
        b=dy5/Tcyic/FDAOWCZ870wcR57aVWQUWqhLpScp25lhdRTQyUf2PtejdbbiXPAxYDe9
         7vJPA8x4UyVADR+gm2oy1NySG4Al088yOyLqzBgqG8XQdwJf9ScKmJ9oV84v+02XFY+G
         yT1GAhjWlO6SqaBN+kUR77aXOPZoxtVIoAHVh0X/gxozCzQS21IuTxU2uTwbuK9vtRGz
         wf2y73xn/zd5ftnuZy2i/a5C3b6Y5HSu1wM/H7Iy0FFX2h7a0lvAT7NqBR08UBsqkpES
         PUr5hau/qspr/SZeiOR3k9oisOyHu4txaA5NoCKBRImxAg2akv3i2jZ3sIEH8nroMBQ0
         FA0w==
X-Gm-Message-State: AOJu0Yzh5wWkwIyNq4pel0hwnAikFtcpGQC2kerVjWbLigYU6LYWB3Iw
	7PftXcCcwmfr1HTtliLM9kPNdvc9zP9DoUM45VQ=
X-Google-Smtp-Source: AGHT+IErITdQEZRCuYaOEOnvyF14FElmL3FxvDLn8O8cq8aZOahsrEpuuNODabq5VFcReWZ8gBVJFA==
X-Received: by 2002:a17:906:7308:b0:9a2:295a:9bbc with SMTP id di8-20020a170906730800b009a2295a9bbcmr1126733ejc.37.1697799951070;
        Fri, 20 Oct 2023 04:05:51 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id sd26-20020a170906ce3a00b009a5f1d15644sm1257367ejb.119.2023.10.20.04.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 04:05:50 -0700 (PDT)
Date: Fri, 20 Oct 2023 13:05:49 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: Re: [patch net-next v2 02/10] tools: ynl-gen: introduce support for
 bitfield32 attribute type
Message-ID: <ZTJfDXcVQI00k26i@nanopsycho>
References: <20231020092117.622431-1-jiri@resnulli.us>
 <20231020092117.622431-3-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020092117.622431-3-jiri@resnulli.us>

Fri, Oct 20, 2023 at 11:21:09AM CEST, jiri@resnulli.us wrote:

[..]

>@@ -192,7 +192,7 @@ properties:
>                 type: string
>               type: &attr-type
>                 description: The netlink attribute type
>-                enum: [ unused, pad, flag, binary, u8, u16, u32, u64, s32, s64,
>+                enum: [ unused, pad, flag, binary, bitfield32, u8, u16, u32, u64, s32, s64,
>                         string, nest, array-nest, nest-type-value ]
>               doc:
>                 description: Documentation of the attribute.

Note this hunk no longer applies as the patch adding uint/sint was just
applied. Will fix and send v3 tomorrow.

[..]

