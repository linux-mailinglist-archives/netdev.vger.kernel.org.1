Return-Path: <netdev+bounces-41719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 322437CBC1A
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD79CB20F77
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 07:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AB8182A1;
	Tue, 17 Oct 2023 07:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="SH30fCrX"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABB85380
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 07:15:20 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442688E
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 00:15:18 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-405497850dbso52227365e9.0
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 00:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697526917; x=1698131717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TBg7prLFZr/Yps2tY0mMbH8x1I8Xl++I91r2qbgj3M0=;
        b=SH30fCrXjEGnBc/zVraV1s+wm14fJuIKl0pny6NIVHryIBq0A8Cr1lX+nLU2c9gXhb
         2MeadbJOlhEMx1SdAgyx7sBGfl1cKW6Zr/lJ3WgirqQBvG++V/+DkrmAeuMcyQxTZwj+
         RyTmV8h0KtqPEPCj7Genk4Sgv6KUhVXsp7AmzagkMnvFav1iYN3rNfXDe7sDNT/zcpFW
         o3F/cEybcmaxAtKBki3K4Rz4kJriGPNHSrtweagCbqOeoXT1MxRglE5K0Mbt1+xlfyyt
         dng2vMKWpVZhrHLkUXFB/+AM0Me/tkhf/kTFbIMfZu+m4vgXNThZkChqGuHWaUlr++v8
         OAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697526917; x=1698131717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBg7prLFZr/Yps2tY0mMbH8x1I8Xl++I91r2qbgj3M0=;
        b=O0egDk0754GoWUx/fM3+Eah7I3jSwOMVzmi/DguaYL5qR8RDdwkSbB0OsMnoIySnFf
         59nMGSEut/THiHht9mtaIzkreZT6AR3IZgDeLszlJ7rgX/TTrr5NWHliNwJKtQXI9UtW
         +Pnc5LFDMUqAL91L4GWJe6g/igRQzxAwEklrY/Y9xZYnSiuvJWL+ZePJja6d+7UcZgFZ
         qaJv5r0XvvC4CMTjafZrMUBr8A3zEo+s+KEP1rY0og68HCbSAF1lpLcZcbaEDgsZ6AI9
         n9hsyq4S5KYFwlWxPeE+ErqsUuQvhGI0PXNWOTTbGbMvMuiG/Gbzu+j7jQXx+gMvo7dR
         oSpg==
X-Gm-Message-State: AOJu0YxF6a/Js0w7ADsKGmt7yWm8Xiu0Q2vx9TifrB6T1YRWJUUy9XC3
	Az4VkrSwS3aHQiZEfhsw6O+0BUwfh9tEtll/u6ld0A==
X-Google-Smtp-Source: AGHT+IGek1tsGnLMo0i5lU6aur2cJuD+x/zcVB/Y2xPAkCNnm3bGlYW3wxvZjxJBkcr7V6kszenWSw==
X-Received: by 2002:a05:600c:1f89:b0:403:cc64:2dbf with SMTP id je9-20020a05600c1f8900b00403cc642dbfmr1038606wmb.27.1697526916538;
        Tue, 17 Oct 2023 00:15:16 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id p17-20020a05600c469100b00401e32b25adsm1073370wmo.4.2023.10.17.00.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 00:15:15 -0700 (PDT)
Date: Tue, 17 Oct 2023 09:15:14 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com
Subject: Re: [patch net] netlink: specs: devlink: fix reply command values
Message-ID: <ZS40gkrsa6fIBbor@nanopsycho>
References: <20231012115811.298129-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012115811.298129-1-jiri@resnulli.us>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Guys, when do you plan to merge net into net-next?

Thanks!

