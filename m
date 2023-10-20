Return-Path: <netdev+bounces-42965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBBB7D0D0F
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB949B215EB
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 10:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431EF16433;
	Fri, 20 Oct 2023 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="wZfArvZ6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF0E17744
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 10:26:33 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975B1D52
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 03:26:31 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507a98517f3so835551e87.0
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 03:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697797590; x=1698402390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FpUv3lYsvCWnwDR/g06Egfp3kFhU4jUb0bzrOwuya/Q=;
        b=wZfArvZ6iByfsgEMWXFipVST/DE4x9aW5Tz0xr3WCV/SG6HAeN5DLin7xBRSZuOwPv
         Sd+m+ZWgXyINHbCQistdFklbSLi9lOkTPHW16t0kCNrNk5+VAZGQ6CZIAq81fxTlTmcC
         6MaOTC3ye2Vukk3YdMw/nbT8/H/e82lfbY5KYMOSk0eM4/72EGMGV1NVkM+blFoXrhaM
         Demcuhh0Uf9remWGrNUmk/atIF0LJPoALb7mBXJiL0p6DxLmtkHeEtacEugmP8vIdBcg
         7QE90fOmPl4c4A3hsmurWQIOldh9oBPNCsKpRmMjp3stlAcbZc1gJj2RGy3d2tuWya+z
         acLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697797590; x=1698402390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpUv3lYsvCWnwDR/g06Egfp3kFhU4jUb0bzrOwuya/Q=;
        b=F4y1sjH97pdA08uys3nYFRWk9qemnhlhIHSASWDo49fm6aTTpr+xBrSHn3OEeN49XM
         DGKLVMdQk4CnLs/U1goc5X1hr1ArBLxvNpiDRjgcBRjSKXHu3ShGVYFaGbLH/aag5roO
         bKNPLHOTuVAHVZ169T/5vK4U6pP71Y+FepZyzOHdvwTQeHCkHzsUp8mBZgkvR6k/sHjn
         k4Lq4SUPi3gLf/Tz50VdKM/EFUFO4cPCl22IDM5ZO1tn1D3pWctp65KbzXPbdDXuozXZ
         13uYAFoxsCLB2NqeYa1qWCoeYKrb2DeOVgw5M0lxYlMg5jGyqWQSstIyvlBGA7qs3uEK
         4ADA==
X-Gm-Message-State: AOJu0Yyyynk50nM3/yimIhc3oIxns4uMzKF5rZld4WruggTwClNSZeoD
	uNP4X/u/YLcNbxUpwKSLuYpm3Q==
X-Google-Smtp-Source: AGHT+IFfbY2lxYPjc9TEMdYAcsK2WwHjA5HaM22K0vA0GSapL5rxGSmu5Fxsposuk3KDUd72mVgdbg==
X-Received: by 2002:ac2:5311:0:b0:507:a1e0:22f4 with SMTP id c17-20020ac25311000000b00507a1e022f4mr896238lfh.29.1697797589649;
        Fri, 20 Oct 2023 03:26:29 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id u25-20020a05600c00d900b004068495910csm6552099wmm.23.2023.10.20.03.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:26:29 -0700 (PDT)
Date: Fri, 20 Oct 2023 12:26:28 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, johannes.berg@intel.com, mpe@ellerman.id.au,
	j@w1.fi
Subject: Re: [PATCH net-next 3/6] net: reduce indentation of
 __dev_alloc_name()
Message-ID: <ZTJV1KpirMjxBUBE@nanopsycho>
References: <20231020011856.3244410-1-kuba@kernel.org>
 <20231020011856.3244410-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020011856.3244410-4-kuba@kernel.org>

Fri, Oct 20, 2023 at 03:18:53AM CEST, kuba@kernel.org wrote:
>All callers of __dev_valid_name() go thru dev_prep_valid_name()
>which handles the non-printf case. Focus __dev_alloc_name() on
>the sprintf case, remove the indentation level.
>
>Minor functional change of returning -EINVAL if % is not found,
>which should now never happen.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

