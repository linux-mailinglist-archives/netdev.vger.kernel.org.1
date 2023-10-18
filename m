Return-Path: <netdev+bounces-42378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0F07CE803
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 21:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A128FB20F1E
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 19:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB3747360;
	Wed, 18 Oct 2023 19:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lcst5eYY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DB647356
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 19:45:08 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D038F95;
	Wed, 18 Oct 2023 12:45:07 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ca3a54d2c4so37721605ad.3;
        Wed, 18 Oct 2023 12:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697658307; x=1698263107; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mJVlIUOl8W19bUYlGTLgzwgWuuHldRueu5Ig9o95wVc=;
        b=Lcst5eYYgfbeXCZtjKJDL0x3phjyHhYq5funnepadWEsshbkMBXKF5KNgApUewrFlm
         p4248iWRfZRcoRgNRow/WjQ2o1wfnKwX/upVcmMOzY9/eG6ABZtQkFQ0GUuQ2vPQcb9B
         qSr94jJz556dFCRbv9gLdh2IqjTymOyPyEnOnJqoGW3t1EYfQjYtfPqhUQlDblEgcWwl
         6jO5tleLDg1S8MYjgxa+3axD7klbU17qfZG8JxhtiHLx0PqKGssNGKv4dWYVNdC+qf/j
         C1Bk7dS0VZ+/XSmRXxmBadjzndRmS9mYn61SoXM7HcWBqNXEGQH6+Ueb+Xa6ssYS36c5
         SvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697658307; x=1698263107;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJVlIUOl8W19bUYlGTLgzwgWuuHldRueu5Ig9o95wVc=;
        b=m4EuAzARaR2GnAWU7FTxx+zBmvKg1g2Ze9NWupENFXHSvzei2OmDIrtWaOhKZDHjx2
         7NTYECu8PCug9RKnG4CpKRy+0wB/RbC0nfDdwDM0QgOHdXzXebRwVwJie31S5W9lRSn8
         MXlfbXXU2VFSqDNo1zUAqK6z+D6RjL7zOkXKrl/rtfhqGMmXLGtkjUjt7Cllw5h0ddSq
         OVib2Jf4fYtn2g2GSomxfJwUZO+kus4Mpzyo++VhhQk44aLLsfB5bTAefr5DWnCBj0Im
         zQMyCh3o8D8NdonpwvDdq6BR+pSIrfUPiS52tf7nUOSdFKJl5l16eKCzd3ahpIQ0t4OA
         IsYw==
X-Gm-Message-State: AOJu0YwyRSCUZxo0hSoSbSdcZpwClDMecQ51/MLRMLJv1U6qVkQFatMN
	3g96TU1eQIMWxq3/bugmx5k=
X-Google-Smtp-Source: AGHT+IEnw2GODP2TQr19/yPsWRkrHfroOFGXjYru419Vfac6A+miAjMgQVaT1L7BpSorND7kMv9b5w==
X-Received: by 2002:a17:902:7590:b0:1bf:4a1f:2b57 with SMTP id j16-20020a170902759000b001bf4a1f2b57mr366891pll.13.1697658307146;
        Wed, 18 Oct 2023 12:45:07 -0700 (PDT)
Received: from ubuntu ([223.226.54.200])
        by smtp.gmail.com with ESMTPSA id f18-20020a170902ce9200b001bc18e579aesm305786plg.101.2023.10.18.12.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 12:45:06 -0700 (PDT)
Date: Wed, 18 Oct 2023 12:45:01 -0700
From: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To: Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	Coiby Xu <coiby.xu@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: kumaran.4353@gmail.com
Subject: [PATCH v2 0/2] staging: qlge: Replace the occurrences of (1<<x) by
 BIT(x)
Message-ID: <cover.1697657604.git.nandhakumar.singaram@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patchset performs code cleanup in qlge driver as per
linux coding style and may be applied in any sequence.

v2: Ammended wording in subject line for all the patches
    Suggested by Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Nandha Kumar Singaram (2):
  staging: qlge: Fix coding style in qlge.h
  staging: qlge: Prefer using the BIT macro

 drivers/staging/qlge/qlge.h      | 388 +++++++++++++++----------------
 drivers/staging/qlge/qlge_main.c |   8 +-
 drivers/staging/qlge/qlge_mpi.c  |   2 +-
 3 files changed, 199 insertions(+), 199 deletions(-)

-- 
2.25.1


