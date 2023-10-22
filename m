Return-Path: <netdev+bounces-43275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D53A07D2265
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 11:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E81628157D
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 09:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309471C3A;
	Sun, 22 Oct 2023 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xb+z1ERq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A5C1875
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 09:46:14 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0EBDC
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 02:46:12 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507bd644a96so3337426e87.3
        for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 02:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697967970; x=1698572770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OT8NQtExuF3HMHiil8WHD2dltgv1lNqqQ5cT4R0t6aQ=;
        b=xb+z1ERqqsCYv0lyKqsgE1Pkk19BboZ4bCXt+43ZwDhNrA1TPFs2NMQhasoYBLedvS
         KycnJMOGS89bzW44N0d5bW0Mqhfi58m0xDsfwq+rkB4hQsYMpV8fVWC1BrQDtnoAEBVI
         gJtZ6SZHq7eB94U7aYGhDa3Jpdhq9cZZvqrS3jnDmt//t4+gi0micCz1gcfj2XNt1uxC
         v8PAVMZkLUK7EcBPMRF9aOVhsJkApdvXGgmNbCVFXEMeQoxwM8JOlFGEVuP9cL82gW2l
         dSZr/PmKIm7WRCIUeuKNx5VgGl9WzoqgT+nATCZlcGaJPjaeOSSeeXKasTuj0+zpDzXi
         kCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697967970; x=1698572770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OT8NQtExuF3HMHiil8WHD2dltgv1lNqqQ5cT4R0t6aQ=;
        b=Zi/DqP0ZU7aDFG8a0GrpkDQilx7qOsTI1rCboBhn1oZxGbadsZ+g0IGufj6Qfwwez8
         fNO26Kp6KJR8zCMY5Q+/NFUgE70t318+/T1Dgq8dxLBYRmPLCmio6KRtsbZ/Exl2cGVU
         n6VwAXc1wnN0Msi2GUlCZePzpI+Xhsy7dRYjFZ6owBuoXgMJgaLhUPjKpaHZLhwnMe5D
         gXqPbsZYjm4IYIRyVZc3leQ4k/7nJd1Y2yAGRX2Mx0WW+erEjNS8iePHzQgGbv9lPJUP
         s/b7ZcczB49sd5JP5xkKk/fAn6CdOR0lQ8Fuh/DXGZRYs14GGPKEWQGNm40TFVd13ndX
         p0Iw==
X-Gm-Message-State: AOJu0YwpkU9Xye1LuKhNPMMHrNbSrXgC0eM+Bt6ERQReOb8xT8HLeTtY
	bdruIai7Ie7aafK+L0BcTvfO4wV/YB0dkS8VDP0=
X-Google-Smtp-Source: AGHT+IExI6Vc2RBTVW0umlxDiyhbyW8Ff/B7MNW/fotNxuFKW1BwheppsFU8K0zjidaZbU/v5A7csg==
X-Received: by 2002:ac2:5398:0:b0:506:926c:9b0d with SMTP id g24-20020ac25398000000b00506926c9b0dmr4301164lfh.20.1697967970374;
        Sun, 22 Oct 2023 02:46:10 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id u13-20020a05600c19cd00b004068e09a70bsm6601663wmq.31.2023.10.22.02.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 02:46:09 -0700 (PDT)
Date: Sun, 22 Oct 2023 11:46:08 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: kernel test robot <lkp@intel.com>
Cc: netdev@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [patch net-next v3 08/10] netlink: specs: devlink: add the
 remaining command to generate complete split_ops
Message-ID: <ZTTvYIGmJPrZKtX5@nanopsycho>
References: <20231021112711.660606-9-jiri@resnulli.us>
 <202310212326.u0Z0O9Hx-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310212326.u0Z0O9Hx-lkp@intel.com>

Sat, Oct 21, 2023 at 06:04:36PM CEST, lkp@intel.com wrote:
>Hi Jiri,
>
>kernel test robot noticed the following build warnings:
>
>[auto build test WARNING on net-next/main]
>
>url:    https://github.com/intel-lab-lkp/linux/commits/Jiri-Pirko/genetlink-don-t-merge-dumpit-split-op-for-different-cmds-into-single-iter/20231021-192916
>base:   net-next/main
>patch link:    https://lore.kernel.org/r/20231021112711.660606-9-jiri%40resnulli.us
>patch subject: [patch net-next v3 08/10] netlink: specs: devlink: add the remaining command to generate complete split_ops
>reproduce: (https://download.01.org/0day-ci/archive/20231021/202310212326.u0Z0O9Hx-lkp@intel.com/reproduce)
>
>If you fix the issue in a separate patch/commit (i.e. not just a new version of
>the same patch/commit), kindly add following tags
>| Reported-by: kernel test robot <lkp@intel.com>
>| Closes: https://lore.kernel.org/oe-kbuild-all/202310212326.u0Z0O9Hx-lkp@intel.com/
>
># many are suggestions rather than must-fix

All in generated code.

