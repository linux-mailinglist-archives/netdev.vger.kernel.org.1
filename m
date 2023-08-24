Return-Path: <netdev+bounces-30452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7327875E1
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 18:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAFF728158A
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 16:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADB412B9C;
	Thu, 24 Aug 2023 16:46:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD60810E6
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 16:46:37 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2891BEF
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 09:46:24 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52a49a42353so131630a12.2
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 09:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692895583; x=1693500383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TYS9DHrs+1jKHxzPrBabk1rf0CL1aLAQaTkspy2i15c=;
        b=f7PlLcP/Mm8OeQKXzbnlJ3D9vrob4zWOyWyc+nn4MsZYcWbM9hLPR/ZEkGYUUP5upw
         LrzkHXgy526IQEU7ZCa6uAmmO8HXQxF3KplYH7cVFU7QKKZKmizqY82O1wwL2SF4kPA1
         2l0ZrvvJI3AfhrP47cljftE2FN2cbATo31NDuc8STE6U/z7A/jfCeAJEe9vzPsLDsPia
         wGSSIwdObnmSZNs3sSLN2R5PlrWSYsTE7P5xmt9wL7uMV4k3TXxUZ2CYqoxU/fiGohz9
         XFr6/HOKXS9CeLviC07drzkgjZn8bTnLGDPh7pDhWSwf9JfCZJSQzsYncBVez6OItBSt
         PVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692895583; x=1693500383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYS9DHrs+1jKHxzPrBabk1rf0CL1aLAQaTkspy2i15c=;
        b=GNEcB5FAqPXF6XNDEd7rhG6ma+SzeDJ3M6MlMX67Cv4nGlojONcQjTioAqeWYNC8/s
         31NfT8gJWH2duWmSbqKt9HCRqmMw89Q01zkMG4L7EDjkDWzGVF+0yez2vJDqdLP+BYqK
         U0JtQ8hRON1LMBj3XYBOI26NPdQ2Pau1qpgPqYxfyQgJYE982Pr4vRctyUtev/O6Tm1Q
         8xADfX2BxEmCwMdefCoDtAeBcU4mGRVofkT/Hb4vhhgwU3ghPXw/m5T7kRSrqAkkKiaI
         jy06ctFoSICUv6OG4yz20K3+bY8YQo8bsYxSeKpcET5JR+Qs5l2pHMGjrZsXfRa/6Uhq
         L9VA==
X-Gm-Message-State: AOJu0YwBDPHScsKZVmA6ElGy345J8xqCGQzYsCUaJTUz1b8IWoewj0x+
	u/Nm7xoEznoHPDpCB/89/gwbFg==
X-Google-Smtp-Source: AGHT+IF/m7RNPBX6onvAwK8petHps/a8h+SMAmgibC9V70N3AnQNIIXaKrsHOuy1PVEqGcxrhEKBXA==
X-Received: by 2002:a05:6402:b04:b0:525:ce69:b52d with SMTP id bm4-20020a0564020b0400b00525ce69b52dmr11926005edb.39.1692895582669;
        Thu, 24 Aug 2023 09:46:22 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id z12-20020aa7cf8c000000b005256d4d58a6sm10714706edx.18.2023.08.24.09.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 09:46:21 -0700 (PDT)
Date: Thu, 24 Aug 2023 18:46:21 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Stanislav Fomichev <sdf@google.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	donald.hunter@redhat.com, Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v5 11/12] doc/netlink: Add spec for rt link
 messages
Message-ID: <ZOeJXfT2lhVAaOAk@nanopsycho>
References: <20230824112003.52939-1-donald.hunter@gmail.com>
 <20230824112003.52939-12-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824112003.52939-12-donald.hunter@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Aug 24, 2023 at 01:20:02PM CEST, donald.hunter@gmail.com wrote:

[...]

>+attribute-sets:
>+  -
>+    name: link-attrs
>+    name-prefix: ifla-
>+    attributes:
>+      -
>+        name: address
>+        type: binary
>+        display-hint: mac
>+        value: 1
>+      -
>+        name: broadcast
>+        type: binary
>+        display-hint: mac
>+        value: 2

Why do you specify value here? In general, it is not needed if it
is the prev+1.


>+      -
>+        name: ifname
>+        type: string
>+        value: 3

[...]

