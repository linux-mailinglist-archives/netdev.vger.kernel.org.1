Return-Path: <netdev+bounces-42023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 751B57CCBA1
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 21:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B356AB2111C
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 19:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3A62DF78;
	Tue, 17 Oct 2023 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWvynCc+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B77E2DF61
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 19:04:05 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA12E8;
	Tue, 17 Oct 2023 12:04:04 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b201a93c9cso3752230b3a.0;
        Tue, 17 Oct 2023 12:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697569443; x=1698174243; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fUHrf1UL//1JW1GXjaKvUOuCKudYsT4wljTi8OSOB7M=;
        b=JWvynCc+73J5Y1RgPgtThIsdQgNI090FIndY5oCAmQ7u67PDksDiCyJ18Oyui+ii7D
         M/9ntPZXBoJ+4RRDmNJJaAh2AnlUyIyjLdVmElXJxmTo/B8DYGjc19e8aHr3XfpjqdlT
         BznAKri/wng1CzBpZElxWutjdL3yMR8J64Hlbq2llIDsIaO245luwIBl43lKQyiEBc4R
         OgRk8WVUKqf4Ik/ycoT3/cVcTSSJ1wWHomclow/wjHOH4cXFaQJPjoMRvSLxMIBQWDE8
         5vWGSnJQYBx19ilf3cK4fY3DdlUtJCgCvMSo4Tt7RXuC0+fxDldermdF4q6Ga41nGIhs
         W9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697569443; x=1698174243;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fUHrf1UL//1JW1GXjaKvUOuCKudYsT4wljTi8OSOB7M=;
        b=XjbLhSbxupujS0jnJeT/P+Kk/yfzH1BxAyO1HSsesG3jFKvQ6JHzLHul/ZYwhsyudO
         ECavGDPPVQFwWoOHY6ZScQjXfdIRCLQ9RE7QglvDSf/xV3ASsmKGCgmMBLUSVhd3eSsn
         hffp8byDVOi4/IspL38qISoP004Z7lknECgd8XrRmjl5A8c8J22YFtpLG4JChoXpRhAy
         x3lcCSmiWHeQpIDwBb8FpXM9lHJSJTZPZ7sklovhIsU07XLzgyVfTN4RJxCq85hv+mSP
         jHHk6zBhfmrbYSeR8fTrTATFd7qY2SfIALMD8b1CUWLkoYTw+WZyk2n8duDfgJDMQMlP
         ZC9Q==
X-Gm-Message-State: AOJu0Yzurd0rLZ9OHmX8dsp79/aD8JZiYugtK7jy4aK4qHGo4G4IGqaF
	gRmMIsxq/4eYc6uKP9vVLfo=
X-Google-Smtp-Source: AGHT+IHJj9uxiwitttFWiLEz7SKPRHB71eQQs74hj0fuSmPuyu87R//exZODV5l3/2nH1nDNQB9ZRA==
X-Received: by 2002:a05:6a00:15d6:b0:6bb:def8:b09c with SMTP id o22-20020a056a0015d600b006bbdef8b09cmr2932955pfu.1.1697569443433;
        Tue, 17 Oct 2023 12:04:03 -0700 (PDT)
Received: from ubuntu ([223.226.54.200])
        by smtp.gmail.com with ESMTPSA id f28-20020aa7969c000000b00692cac7a065sm1809279pfk.151.2023.10.17.12.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 12:04:02 -0700 (PDT)
Date: Tue, 17 Oct 2023 12:03:57 -0700
From: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To: Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	Coiby Xu <coiby.xu@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: kumaran.4353@gmail.com
Subject: [PATCH 0/2] staging: qlge: Replace the occurrences of (1<<x) by
 BIT(x)
Message-ID: <cover.1697568757.git.nandhakumar.singaram@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patchset performs code cleanup in qlge driver as per
linux coding style and may be applied in any sequence.

Nandha Kumar Singaram (2):
  staging: qlge: Replace the occurrences of (1<<x) by BIT(x)
  staging: qlge: Replace the occurrences of (1<<x) by BIT(x)

 drivers/staging/qlge/qlge.h      | 388 +++++++++++++++----------------
 drivers/staging/qlge/qlge_main.c |   8 +-
 drivers/staging/qlge/qlge_mpi.c  |   2 +-
 3 files changed, 199 insertions(+), 199 deletions(-)

-- 
2.25.1


