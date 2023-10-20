Return-Path: <netdev+bounces-42963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904E97D0D0B
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5416928243C
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 10:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0F015EBC;
	Fri, 20 Oct 2023 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Dna3EpiK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE576171A0
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 10:25:01 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B763B8
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 03:25:00 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9c2a0725825so98507566b.2
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 03:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697797498; x=1698402298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rVCmt1E316ybUmoR7RJdWhx7Z+HSeu5fEPJ5WMmz1T0=;
        b=Dna3EpiKOJFOPnRf81goRPWIE0MFuEpzPHBTAljRN97nMzWuj+6PoXcaB1MZzkuT2l
         hhvry4YJe1oaPFZaauwja4wGWBojmILhZ8HMyWJXLtdIjksEqYkW17UInMZOHSzdBdnL
         JoRl6Vv/bXUx/hoeKSMESZin3ytHbzo5meV+WlrxyDJL68exNcJzs4JfIKZ/Uf3KC1ly
         msHyeirHawu9g6PDcS7BDJr7Z8Hal2M9icB8Mtk0cF3KyM7Npx0JMTJlODnnhmCzCH1N
         ckQ/spF3v/9J3Z0NV4ZfneigaJD7RRYRBpO6Z7MfOtDT1xEkgo+oFAlysBoWSFcd+tEV
         m/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697797498; x=1698402298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVCmt1E316ybUmoR7RJdWhx7Z+HSeu5fEPJ5WMmz1T0=;
        b=flZT4U7Xy0E4g/volGTJ5heBh6XF3l8zQwYHCGddKgE825lNEu737uBv34Y2yFEJ6M
         aw0YDCum797pYh/slC5vui/4jb+KsLfssX8Z0sbHm62nbl/Y7QdY1zt7KN6Rpq4EIeNo
         3+0xzXZYC6IIfNhCvVFxLtB92KW9m9e8ZXRfjbquCloJVgkGPp/PxAN9IGzLSIYbDITJ
         JrxDv+76zIvFaCJM/6tO9jOrOrmlDDtEOxzcD01pfgEUtn0PcnOQ/MqoC+SdK8RzSRRD
         kmKba0n6RhchdiIZgaaK3/oJhBH/qkhpIEtHEd8zl68BUr8dkKJEb8+XskBtjJncFLT6
         5VIQ==
X-Gm-Message-State: AOJu0YwI9qk2AP1yo+pIRwbzp0TUDka0Q1Y7l6WaYMAgNBsZCLXetK+l
	M1oESYW/j8luGsyag5aRO0H1Vg==
X-Google-Smtp-Source: AGHT+IEjR1I9Vxi30ojEghOJ4CmEm/ly8dzKqBz4+Uw+OYXXaqU4K3i9kSrDgIshJECzXl/YH1zpyw==
X-Received: by 2002:a17:907:6e91:b0:9a1:f81f:d0d5 with SMTP id sh17-20020a1709076e9100b009a1f81fd0d5mr1209257ejc.54.1697797498505;
        Fri, 20 Oct 2023 03:24:58 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id og43-20020a1709071deb00b0098951bb4dc3sm1198637ejc.184.2023.10.20.03.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:24:58 -0700 (PDT)
Date: Fri, 20 Oct 2023 12:24:57 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, johannes.berg@intel.com, mpe@ellerman.id.au,
	j@w1.fi
Subject: Re: [PATCH net-next 2/6] net: make dev_alloc_name() call
 dev_prep_valid_name()
Message-ID: <ZTJVeUJy9WhOgiAU@nanopsycho>
References: <20231020011856.3244410-1-kuba@kernel.org>
 <20231020011856.3244410-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020011856.3244410-3-kuba@kernel.org>

Fri, Oct 20, 2023 at 03:18:52AM CEST, kuba@kernel.org wrote:
>__dev_alloc_name() handles both the sprintf and non-sprintf
>target names. This complicates the code.
>
>dev_prep_valid_name() already handles the non-sprintf case,
>before calling __dev_alloc_name(), make the only other caller
>also go thru dev_prep_valid_name(). This way we can drop
>the non-sprintf handling in __dev_alloc_name() in one of
>the next changes.
>
>commit 55a5ec9b7710 ("Revert "net: core: dev_get_valid_name is now the same as dev_alloc_name_ns"") and
>commit 029b6d140550 ("Revert "net: core: maybe return -EEXIST in __dev_alloc_name"")
>tell us that we can't start returning -EEXIST from dev_alloc_name()
>on name duplicates. Bite the bullet and pass the expected errno to
>dev_prep_valid_name().
>
>dev_prep_valid_name() must now propagate out the allocated id
>for printf names.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>---
> net/core/dev.c | 20 +++++++++++---------
> 1 file changed, 11 insertions(+), 9 deletions(-)
>
>diff --git a/net/core/dev.c b/net/core/dev.c
>index 874c7daa81f5..004e9f26b160 100644
>--- a/net/core/dev.c
>+++ b/net/core/dev.c
>@@ -1137,19 +1137,18 @@ static int __dev_alloc_name(struct net *net, const char *name, char *res)
> 	return -ENFILE;
> }
> 
>+/* Returns negative errno or allocated unit id (see __dev_alloc_name()) */
> static int dev_prep_valid_name(struct net *net, struct net_device *dev,
>-			       const char *want_name, char *out_name)
>+			       const char *want_name, char *out_name,
>+			       int dup_errno)
> {
>-	int ret;
>-
> 	if (!dev_valid_name(want_name))
> 		return -EINVAL;
> 
> 	if (strchr(want_name, '%')) {
>-		ret = __dev_alloc_name(net, want_name, out_name);
>-		return ret < 0 ? ret : 0;
>+		return __dev_alloc_name(net, want_name, out_name);
> 	} else if (netdev_name_in_use(net, want_name)) {
>-		return -EEXIST;
>+		return -dup_errno;
> 	} else if (out_name != want_name) {
> 		strscpy(out_name, want_name, IFNAMSIZ);
> 	}
>@@ -1173,14 +1172,17 @@ static int dev_prep_valid_name(struct net *net, struct net_device *dev,
> 
> int dev_alloc_name(struct net_device *dev, const char *name)
> {
>-	return __dev_alloc_name(dev_net(dev), name, dev->name);
>+	return dev_prep_valid_name(dev_net(dev), dev, name, dev->name, ENFILE);
> }
> EXPORT_SYMBOL(dev_alloc_name);
> 
> static int dev_get_valid_name(struct net *net, struct net_device *dev,
> 			      const char *name)
> {
>-	return dev_prep_valid_name(net, dev, name, dev->name);
>+	int ret;
>+
>+	ret = dev_prep_valid_name(net, dev, name, dev->name, EEXIST);
>+	return ret < 0 ? ret : 0;

Why can't you just return dev_prep_valid_name() ?

No caller seems to care about ret > 0


> }
> 
> /**
>@@ -11118,7 +11120,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
> 		/* We get here if we can't use the current device name */
> 		if (!pat)
> 			goto out;
>-		err = dev_prep_valid_name(net, dev, pat, new_name);
>+		err = dev_prep_valid_name(net, dev, pat, new_name, EEXIST);
> 		if (err < 0)
> 			goto out;
> 	}
>-- 
>2.41.0
>

