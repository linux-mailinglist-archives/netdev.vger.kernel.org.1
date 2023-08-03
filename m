Return-Path: <netdev+bounces-23949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B900476E44D
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724B828203E
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 09:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C71154A0;
	Thu,  3 Aug 2023 09:26:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985077E
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 09:26:27 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20435E48;
	Thu,  3 Aug 2023 02:26:26 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bb775625e2so5392335ad.1;
        Thu, 03 Aug 2023 02:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691054785; x=1691659585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=reH+wpAbFDO+nwl2PBy4B/7elBuO2sg2phuodffB6Do=;
        b=OLFCyrsO/h7Lx5prlW9D+hYxudwzVNKDhLEvKQ992HTej4NYfPRtHwKsiK7sB2cS3X
         a1pQRkrCowc5Mfw3XBnR7Z3U3Slhli6AeGVyu3oTvcQtC5Ds8CF93o03vkwDioHVS9g7
         pZAD0ebLncdl59gRbXAfZHfALrkcN0Fy/mmplFT3eaTu0J5xMOnnvzr7G8KYe+6R48rY
         Hhsd/ogykPKPNRvpS6oNT8hDFb0P9HuxVBWlpneRb9jrnzJ+hSGwOgZCBAGaTcylj+x+
         /huE91fpS6zU1okkkno3O4Yibrk0Smk6RgM1GBBazZk5vEMuMnjaQDnR0VzRi67b6fIA
         iVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691054785; x=1691659585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reH+wpAbFDO+nwl2PBy4B/7elBuO2sg2phuodffB6Do=;
        b=G175QDjBD85XUBylcva5doTN2qO9HpV0PQwZ712IbmjRHiF8msG0mlnFgozTwz0K7V
         0NCFVzCLcJUGfrV2EYm4BcQISOd1x/yUylKZmzWh69uLGtVKH2ul0R6sAHwevkI9prOS
         1z5E8jWKIASa6Asi4iJTQUiho4zOPkl8aEvs1kdfHJDdHF41ZTnyHt/96ZXTmMo57lxA
         5A1cNLsAuCLcYNyUjRFW1Iod3zPGEQucn9RUgrAhPaf5PJu9quxCsNFEzaFIpTKGUWl+
         f8oM6lHXDHeGhax8Lnw4vgRpyG6gX0GDgFb/+XX78ZhgcOz1Tudqfjn38iChMZgHoyQr
         UwXg==
X-Gm-Message-State: ABy/qLYUlpdF8yn4EO/N+WYvgWWBvWJ5wzq/dCNdJnzql01eohfiFaJ8
	oREdpXhz1QAEmxRqJ1Oo+Xs=
X-Google-Smtp-Source: APBJJlFs6ITXJ3rHkQEAPM41nCDxi1VOLYeqFKo8yf7MjMHUykganaPpVgg86HnvIlSBrH1ty0/+NA==
X-Received: by 2002:a17:902:e5c5:b0:1b2:676d:1143 with SMTP id u5-20020a170902e5c500b001b2676d1143mr25301467plf.15.1691054785518;
        Thu, 03 Aug 2023 02:26:25 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b001b89b1b99fasm13874945plk.243.2023.08.03.02.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 02:26:24 -0700 (PDT)
Date: Thu, 3 Aug 2023 17:26:19 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Stefano Salsano <stefano.salsano@uniroma2.it>,
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
	Ahmed Abdelsalam <ahabdels.dev@gmail.com>
Subject: Re: [net-next 0/2] seg6: add NEXT-C-SID support for SRv6 End.X
 behavior
Message-ID: <ZMtyu/mb7O8fuzAg@Laptop-X1>
References: <20230731175117.17376-1-andrea.mayer@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731175117.17376-1-andrea.mayer@uniroma2.it>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 07:51:15PM +0200, Andrea Mayer wrote:
> The NEXT-C-SID mechanism [3] extends the SRv6 architecture by providing several
> ways to efficiently represent the SID List.
> By leveraging the NEXT-C-SID, is it possible to encode several SRv6 segments
> within a single 128 bit SID address (also referenced as Compressed SID
> Container). In this way, the length of the SID List can be drastically reduced.

nit: it is possible...

