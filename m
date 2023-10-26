Return-Path: <netdev+bounces-44396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D53E7D7CD9
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 08:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DBF51C20DC4
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 06:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CC711739;
	Thu, 26 Oct 2023 06:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="yoA8iTEC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF9229A1
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 06:25:18 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410ED187
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 23:25:16 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40836ea8cbaso3969315e9.0
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 23:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698301515; x=1698906315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kFfx8EZ0W5MFy5sXiXvXhrEOAyG+HCLb8UVZqrwuco8=;
        b=yoA8iTECXvCk9PS2+is2QNeghwGV0ypQmJv4IPg/r/8L8XQ7OCeaYUjx6S+1c1HMGK
         jrscv03r4V6AnT7rOD0U5yysKu4JhyZ2TX6Vww8ZOzNdJH0L7oADKWNqZMsxsNstdOvk
         qH9bgdIAELqvC6GsMuynSs3n3DXnHIQx5jeJ7g6y7c+tSnKQLj15yQM6D4o5gS0eDW54
         0d62E+h6X1RxFYLca9pjnGBakoFAi3f+PZEZ44yJ9p9xfEXkOExFBM513ezPYoD+ocZT
         ZJBcTpNrLiqYE9utdNGy+861HL4t/pSU2AAuzYKHC83scjF7VZUnj6Vl0EVGOgfKN7zw
         oTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698301515; x=1698906315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFfx8EZ0W5MFy5sXiXvXhrEOAyG+HCLb8UVZqrwuco8=;
        b=IFzSrD76xOdCu2y40usTi18vV4x6k/ZBIxipjmcOclbHsPue7LpXnwRTkBj7d7m4ah
         CKBR1fe6Y30m2ptWvOX/JcQuBokvlfCTKKwVPCb+uZVzagiLKJWMUvmDlVkHlW/Ng/XE
         ymAmTiAcNtwHemailnCQqm3LLufkWO25afjxqIdk7Htx11+iDL5Xy/8RUOvk5+IsnOfk
         tjJgfXj45DoCvyD6HVmlIapeCzsXB78THGTogbTu4qKNqvrN/QvktWwz/QP+dyqI5jBm
         8oBqHWfybm9pBrAiutwdWPuktbolFzEKGbS38nQ+BOfbabCSOWakG4XnOsQ8lnPPOLj+
         cWkg==
X-Gm-Message-State: AOJu0Ywlh4ZynOFcltveprTxjpwu9iIJV9wmthaLhPBKWuRAdy/HNXsQ
	PhLZBTW1qOFV/y2RgvUZU1P9fA==
X-Google-Smtp-Source: AGHT+IFM92HJlM1njRwgSqcEEOQXP5U/hFAr93h6SiDwq6BQQ12uH0IY2MjEVgjbHFO6ibSbZKLi1A==
X-Received: by 2002:a05:600c:3583:b0:401:eb0:a974 with SMTP id p3-20020a05600c358300b004010eb0a974mr13495367wmq.3.1698301514730;
        Wed, 25 Oct 2023 23:25:14 -0700 (PDT)
Received: from localhost ([80.95.114.184])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c458a00b004053a6b8c41sm1610434wmo.12.2023.10.25.23.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 23:25:14 -0700 (PDT)
Date: Thu, 26 Oct 2023 08:25:02 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, martineau@kernel.org,
	Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH net-next] tools: ynl-gen: respect attr-cnt-name at the
 attr set level
Message-ID: <ZToGCBTMNkOTqw3h@nanopsycho>
References: <20231025182739.184706-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025182739.184706-1-kuba@kernel.org>

Wed, Oct 25, 2023 at 08:27:39PM CEST, kuba@kernel.org wrote:
>Davide reports that we look for the attr-cnt-name in the wrong
>object. We try to read it from the family, but the schema only
>allows for it to exist at attr-set level.
>
>Reported-by: Davide Caratti <dcaratti@redhat.com>
>Link: https://lore.kernel.org/all/CAKa-r6vCj+gPEUKpv7AsXqM77N6pB0evuh7myHq=585RA3oD5g@mail.gmail.com/
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

