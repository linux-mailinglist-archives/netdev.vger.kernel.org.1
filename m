Return-Path: <netdev+bounces-26212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E987772CA
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723931C214CA
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 08:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5041ADFF;
	Thu, 10 Aug 2023 08:22:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F24F1DDC1
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:22:09 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E5EAC
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:22:07 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe501e0b4cso5551365e9.1
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691655726; x=1692260526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J5c5vaQhSbOgKQaiWjVUmNMr3M2usQ6p0jf2jPVMX64=;
        b=Pcoqu6htEoYqVerSLQZMU0ZELWpw2kE+StryikCBw3+cJtsc2J+y6mjqK7mfjBQuNA
         xLxtyWrpPXV/3pXkBe0M62dm30MB/265D00M1Pgr5vxwTF+7SKMRXuRukfCnlpJ2df+n
         8bLv49ncLHiql5xQn1oK2wvQEYQd5rLl/B5HZ9MPsbuMQJ7eC3b6ahKNVNoMC/I7XsnF
         UY1DBN3kMDiou7hqZ9bd0MwZyzZznzPJDoYQr+/OQnwf0va8+vRe7f1k1RRVX3w9Fh4t
         2T2eUxb41ENU/k6g3tIGqFnTkCWmLL0wno9y+xrfcYWCjgFcmRFprXRYTPFMyiETJazf
         G0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691655726; x=1692260526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5c5vaQhSbOgKQaiWjVUmNMr3M2usQ6p0jf2jPVMX64=;
        b=lHI8RbX/6H7shEVjpZ558pgov3FdULL3Ol3Ci68tTy2XbO8hN+Nv4ZXZutwPHcEDQa
         GTsW8tydq80bdq28mZVOIQIwQzZCF59wshayfuB4Rvt2vJ9PDQ+kdCqmwYk7hleAGbdU
         GMmXEBd+h+xim0XmT/1leoD4vAfMGsG311vxgvFzz8t154ubpgeTgScLwjqUpNXgygDC
         Q3MV3iWr/lSWJfXRRsEunVnwV0Zf4mFsxQZVAnBXG+OiXh7PYTOX2rr9GfE9Bmbafffr
         PT62dcwCBWIcqjGkaVwWWZ5qkQNkd26CQuXpjOSMXcW4y9qPoeufUMpcIFCBxP0z9cvN
         4DLw==
X-Gm-Message-State: AOJu0Yz8hTaxsT5XHhChJ3nBO80+Lu6aiAReQGC0dqc1l6og6h/EmORg
	ExafVzGCWvex/XjlHWzlaRSBAQ==
X-Google-Smtp-Source: AGHT+IGPSHfCPVmnHcWiKDciRP5TgVN5NE5caRWnr1RdqihiKyt9nm7m20hGY5Nn+VfmlfytOE0gcA==
X-Received: by 2002:a05:600c:210:b0:3fb:dd5d:76b with SMTP id 16-20020a05600c021000b003fbdd5d076bmr1383005wmi.7.1691655725921;
        Thu, 10 Aug 2023 01:22:05 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id q5-20020a7bce85000000b003fe17e04269sm1333289wmj.40.2023.08.10.01.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:22:05 -0700 (PDT)
Date: Thu, 10 Aug 2023 10:22:03 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: g@nanopsycho.smtp.subspace.kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, johannes@sipsolutions.net, sam@mendozajonas.com
Subject: Re: [PATCH net-next 02/10] genetlink: make genl_info->nlhdr const
Message-ID: <ZNSeK04gee4AbM0Q@nanopsycho>
References: <20230809182648.1816537-1-kuba@kernel.org>
 <20230809182648.1816537-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809182648.1816537-3-kuba@kernel.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,TO_MALFORMED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Aug 09, 2023 at 08:26:40PM CEST, kuba@kernel.org wrote:
>struct netlink_callback has a const nlh pointer, make info
>pointer const as well, to make setting genl_info->nlh in
>dumps easier.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

