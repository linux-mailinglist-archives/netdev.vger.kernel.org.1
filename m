Return-Path: <netdev+bounces-38090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D792C7B8EBF
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 23:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id E4F641C20897
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 21:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24422376A;
	Wed,  4 Oct 2023 21:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="L6dRom3B"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85015219EB
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 21:28:09 +0000 (UTC)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65473BF
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 14:28:08 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2791d5f1a09so51058a91.1
        for <netdev@vger.kernel.org>; Wed, 04 Oct 2023 14:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1696454887; x=1697059687; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XxnJOCGcqOSmtyd5hsiwf2XPRUSx2Nzu1+pWFla2Kvk=;
        b=L6dRom3BIc6yU2k+E7Rh093E1aWSI/38FZ0D4zPf+bppSVqPrsD1894fDE/KW1Frip
         b3Iu3d3RJy6VrosLed1MvS3aUgeybMrOim8JzGU0AouZ9LD/OVhuUCd8H/fKZ51pVCHd
         jIPfIz5duLB9ihxwbQYxBVB/fKtnUvoaZgk7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696454887; x=1697059687;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XxnJOCGcqOSmtyd5hsiwf2XPRUSx2Nzu1+pWFla2Kvk=;
        b=sh11MFW9Sx6FDa0W4elHFhSjd3BpabHZ6Zfauww08NNDarc6NJBxTifKqd/LlmUVFQ
         QLlp5FalaupNUKN6cw4nIyb0V5cGMZw13i8HbeuaxpYwcGeond67yA6FkD21mRMQsxE1
         i4BVi/nl7nb+N1ovClTDjVlELj1XrLks4EF2QGJxD/KC7nzzeagPyxSI2pq6ieorBVP3
         WbgKXsLu4AaXLrEs575qLpUNFUXDkmQkNZQys3zPSs3gcOogHW8R1ESN3MbbMHgkTXor
         yxM82jbGDEf1ZyReImRaE+aJIRNPAHKm6VDWZCRvWB1aktUU3T6z8Jbgukjq5eLeZxxn
         IU/w==
X-Gm-Message-State: AOJu0Yy7MXPZcXMl4XhnzmnvY1lXDLIQ8laUi1WJ11jR27o8S7Z/QbmX
	QLJvG/zpXj5ZrQzoLQSYfRrd9icMZrbllPRGhHQErD87zIqS07Uk4aA8Rg==
X-Google-Smtp-Source: AGHT+IFVcqJ2B+DYgsCxUor3skNelEiGwr2nh6MgkW+hD987M7veCh3QOi97TSwLLIeKroMpvQAL9UoIs+VX6tO8RrU=
X-Received: by 2002:a17:90a:1fcc:b0:26d:414d:a98a with SMTP id
 z12-20020a17090a1fcc00b0026d414da98amr3135567pjz.1.1696454887471; Wed, 04 Oct
 2023 14:28:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Markus Mayer <mmayer@broadcom.com>
Date: Wed, 4 Oct 2023 14:27:56 -0700
Message-ID: <CAGt4E5uB_zX-3OtUcTRPjYiiJ1FYbYAdr6uWSgy1qJip5p7wnQ@mail.gmail.com>
Subject: Bug in 6.5 tar-ball
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

It would seem I discovered an issue with the ethtool-6.5 tar-balls on
cdn.kernel.org. They are missing the const.h header file. Maybe other
files too.

Please verify as follows:

$ curl -s -o - https://cdn.kernel.org/pub/software/network/ethtool/ethtool-6.5.tar.xz
| \
    tar tJf - | grep const
[no output]

$ curl -s -o - https://cdn.kernel.org/pub/software/network/ethtool/ethtool-6.5.tar.gz
| \
    tar tzf - | grep const
[no output]

Meanwhile, this tar-ball seems correct:

$ curl -s -o - https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/snapshot/ethtool-6.5.tar.gz
| \
    tar tzf - | grep const
ethtool-6.5/uapi/linux/const.h

So, the tar-ball directly taken from git.kernel.org does have const.h,
but the two from cdn.kernel.org do not.

This is currently leading to build problems for me.

/storage/buildroot/output/arm64/host/bin/aarch64-linux-gcc
-DHAVE_CONFIG_H -I.  -I./uapi  -D_LARGEFILE_SOURCE
-D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -Wall -Wextra
-D_POSIX_C_SOURCE=200809L -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
-D_FILE_OFFSET_BITS=64  -Os -g0 -D_FORTIFY_SOURCE=2 -std=gnu11 -c -o
netlink/rings.o netlink/rings.c
In file included from internal.h:45,
                 from common.c:7:
./uapi/linux/ethtool.h:1507:19: warning: implicit declaration of
function '__KERNEL_DIV_ROUND_UP' [-Wimplicit-function-declaration]
  __u32 queue_mask[__KERNEL_DIV_ROUND_UP(MAX_NUM_QUEUE, 32)];
                   ^~~~~~~~~~~~~~~~~~~~~
./uapi/linux/ethtool.h:1507:8: error: variably modified 'queue_mask'
at file scope
  __u32 queue_mask[__KERNEL_DIV_ROUND_UP(MAX_NUM_QUEUE, 32)];
        ^~~~~~~~~~
make[3]: *** [Makefile:1410: common.o] Error 1
make[3]: *** Waiting for unfinished jobs....

There are, of course, ways to work around it, but the tar-balls should
be fixed, since I won't be the only one hitting this problem.

Regards,
-Markus

