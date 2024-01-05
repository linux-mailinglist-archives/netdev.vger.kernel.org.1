Return-Path: <netdev+bounces-61854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEC5825130
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 10:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29DBD284AF8
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 09:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79252421D;
	Fri,  5 Jan 2024 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ZpN2ayZl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11958249F3
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d41555f9dso13354875e9.2
        for <netdev@vger.kernel.org>; Fri, 05 Jan 2024 01:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704448227; x=1705053027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p/GBsthAoUq8i1Y3HRRU92fYw/cIt+pJASf0ZZAyuuY=;
        b=ZpN2ayZlF7S1JfC7x3PiFh8WxWWv+DLQgdpCsMB7HFiGYwD0njsVE6BBt47vs/RakT
         hy02epmd9dM4FlLhOTBX9FnUzyui9N8bBH/69VLriI9f21rzpB4KkRRp+/z5hOfh+CHM
         Al5hlkEDC4/uVfhbqt6qWthmceR98qflxFvHLL7O7KGArNx4ApAmpXrMaErK/hR+0i/K
         E1B9pNz0KIGi1Uw7RbmsxLhvEKpd0z447FMdfg23qeuldzNJAUsGBTjzbUQtaJzi+P5F
         COSxOKRJFg0eBL59Ub1MzodR7jBVKNfMWmVUKU/tS19B4Xp4chiA/W0qCII4Dz+NkWgf
         3NJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704448227; x=1705053027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/GBsthAoUq8i1Y3HRRU92fYw/cIt+pJASf0ZZAyuuY=;
        b=BLhCNiVoxDAiWtY8z4exRBAlgzcCgFPqyqwALo2vkKaOJCsP6W6ZQItjGOiHmhDRm1
         jp87P1Q8T3qrUarjBfuFO+ojign8Hgj6y8onieOMG9FtGrB3CWki2a/ga7SSbay7kmmw
         Ajv7ft7SvOAESil2WVakjy747am/M32Y8VuMl6NCNhcchU8S0EJ466CdqVFF3SFTto0+
         Mm2mE8EcjxCW8Qd7J4t6KJkgrpfgqcMVckzBCHzx/9ofDkzY8qUO8NVheNNEaVcB5FdA
         POwr64fjCpiP3gW/YWYebc7n6toBUke+wYf5xLWndTqvNUuo6tX9IvePzSVZQPMCRavX
         F5ag==
X-Gm-Message-State: AOJu0YzU4zcimGqelDtQq33OowjMWVr7DA87vtSuLxBLTVNQq75dRsFq
	nwCC8Vx2uDXuPZuFsPnzLuurGXAGff6qLw==
X-Google-Smtp-Source: AGHT+IFR5XVx9IfVQlQgO4/UKbDLbi7Ifr7kL41tRUojLGAq+la9MJ/EP3VZQ4EhP6rQ3spD7tjPXg==
X-Received: by 2002:a05:600c:4e88:b0:40d:2f89:2e02 with SMTP id f8-20020a05600c4e8800b0040d2f892e02mr929537wmq.58.1704448227257;
        Fri, 05 Jan 2024 01:50:27 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id t11-20020a05600c450b00b0040d724896cbsm1032020wmo.18.2024.01.05.01.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 01:50:26 -0800 (PST)
Date: Fri, 5 Jan 2024 10:50:25 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, lanhao@huawei.com, wangpeiyang1@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 net-next 0/4] There are some features for the HNS3
 ethernet driver
Message-ID: <ZZfQ4XRlqde31qgN@nanopsycho>
References: <20240105010119.2619873-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105010119.2619873-1-shaojijie@huawei.com>

Fri, Jan 05, 2024 at 02:01:15AM CET, shaojijie@huawei.com wrote:
>There are some features for the HNS3 ethernet driver

This is quite odd patchset cover letter subject and description. You
should try to be more specific in the subject and more descriptive
here in the description.


>
>---
>changeLog:
>v3 -> v4:
>  - Adjuste the patches sequence in this patch set, suggested by Simon Horman
>  v3: https://lore.kernel.org/all/20231216070018.222798-1-shaojijie@huawei.com/
>v2 -> v3:
>  - Fix the incorrect use of byte order in patch
>    "net: hns3: add command queue trace for hns3" suggested by Simon Horman
>  - Add a new patch to move constants from hclge_debugfs.h
>    to hclge_debugfs.c suggested by Simon Horman
>  v2: https://lore.kernel.org/all/20231214141135.613485-1-shaojijie@huawei.com/
>v1 -> v2:
>  - Delete a patch for ethtool -S to dump page pool statistics, suggested by Jakub Kicinski
>  - Delete two patches about CMIS transceiver modules because
>    ethtool get_module_eeprom_by_page op is not implemented, suggested by Jakub Kicinski
>  v1: https://lore.kernel.org/all/20231211020816.69434-1-shaojijie@huawei.com/
>---
>
>Hao Lan (1):
>  net: hns3: add command queue trace for hns3
>
>Jijie Shao (2):
>  net: hns3: move constants from hclge_debugfs.h to hclge_debugfs.c
>  net: hns3: support dump pfc frame statistics in tx timeout log
>
>Peiyang Wang (1):
>  net: hns3: dump more reg info based on ras mod
>
> drivers/net/ethernet/hisilicon/hns3/hnae3.h   |   6 +
> .../hns3/hns3_common/hclge_comm_cmd.c         |  19 +
> .../hns3/hns3_common/hclge_comm_cmd.h         |  16 +-
> .../net/ethernet/hisilicon/hns3/hns3_enet.c   |   6 +-
> .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 646 +++++++++++++++++-
> .../hisilicon/hns3/hns3pf/hclge_debugfs.h     | 643 +----------------
> .../hisilicon/hns3/hns3pf/hclge_err.c         | 434 +++++++++++-
> .../hisilicon/hns3/hns3pf/hclge_err.h         |  36 +
> .../hisilicon/hns3/hns3pf/hclge_main.c        |  47 ++
> .../hisilicon/hns3/hns3pf/hclge_trace.h       |  94 +++
> .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  40 ++
> .../hisilicon/hns3/hns3vf/hclgevf_trace.h     |  50 ++
> 12 files changed, 1386 insertions(+), 651 deletions(-)
>
>-- 
>2.30.0
>
>

