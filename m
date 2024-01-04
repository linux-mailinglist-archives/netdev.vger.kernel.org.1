Return-Path: <netdev+bounces-61569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF238244A9
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A4B1F21879
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED692375F;
	Thu,  4 Jan 2024 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="HFEkFi/u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B215923761
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3367601a301so484667f8f.2
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 07:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704380968; x=1704985768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GQJXUUtLJYo9WVTRclMvA/3dFysmYSDjfTjj1Xlk1VY=;
        b=HFEkFi/uDA2FRcL9XREw7PbSmppWKNfA2zFtwX8sKtgZTekGfEN27fC92trQdQslmF
         TPYevMJKr+pv4FD8T5b1TGxFiP7kC905u78WhWsjgdGcq/7MOHfo9LAAK/BP/vWTRE96
         MLOplRQDo6yiI/C7qJhuQCXnib/kODs3NHB67XZvXmLwocLYjbcs9uUGhNoBigsn2ZxV
         TcgBKqysqXI/H9VOpDH6GTvlgaO0skO33PdywXCp0ieUv2BbOHuj8Qbu5gIRsHBL8L9s
         7Jzv7ws5/B+ZUm7QZYR1VujUPUzmrkopDgb14BHg46zjAWpF8STe20ANqhUGpj+rYtsV
         2hSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704380968; x=1704985768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQJXUUtLJYo9WVTRclMvA/3dFysmYSDjfTjj1Xlk1VY=;
        b=rHnJ1qZWZ5Fm514JtcxqCyb/aPgkQ8QgH2gs08fakVIbK6ESZM7MjqBnUZe+AGTSdv
         OZ67U8PA1B2UxjsGFM9oKhPzHxRsISLOwW4Tsx7wDzy5AYgRjo/VTf7m0I2oM+bklRtN
         gcd4/ZR6KlMMaZZ84VAZwXJBu7Y47knGNCHskTNjJEhmmOG4O9Y/X5PL35MHrZJFAu09
         hJKNRejaBZduCl6fj9Ab5y51nghC6kvrNF8FHBZjpdYS4dZjw/WTXg64xNsKNaTPfXaq
         AtQrCeJa/KwCGVjyHF60VuYZ3vKc48ImSzefka1DLsfBUsiwK0McBU6GRFPsOeCJvDTo
         jP8g==
X-Gm-Message-State: AOJu0YxgwK5L0sSN1BRu89TY/pocypnFgUSkNxyKYavIi/xVJpMiWeGa
	ljNXg2RK8PASeqGgsrkHPF0a9t3AkjSO1A==
X-Google-Smtp-Source: AGHT+IEcpXKmWi+QiXXNIxKtxYy0paO5p6UYvh0bhu7RH+GGqH+aSe1IRgYka02fuHpvaJx4cBY5Lw==
X-Received: by 2002:a5d:420c:0:b0:336:6dcc:88e8 with SMTP id n12-20020a5d420c000000b003366dcc88e8mr341571wrq.138.1704380968021;
        Thu, 04 Jan 2024 07:09:28 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id j18-20020a5d5652000000b00336ca349bdesm23860298wrw.47.2024.01.04.07.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 07:09:27 -0800 (PST)
Date: Thu, 4 Jan 2024 16:09:26 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
	michal.michalik@intel.com, milena.olech@intel.com,
	pabeni@redhat.com, kuba@kernel.org, Jan Glaza <jan.glaza@intel.com>
Subject: Re: [PATCH net v2 4/4] dpll: hide "zombie" pins for userspace
Message-ID: <ZZbKJjoNG7o8opKi@nanopsycho>
References: <20240104111132.42730-1-arkadiusz.kubalewski@intel.com>
 <20240104111132.42730-5-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104111132.42730-5-arkadiusz.kubalewski@intel.com>

Thu, Jan 04, 2024 at 12:11:32PM CET, arkadiusz.kubalewski@intel.com wrote:

[...]

>@@ -1179,6 +1195,10 @@ int dpll_nl_pin_set_doit(struct sk_buff *skb, struct genl_info *info)
> {
> 	struct dpll_pin *pin = info->user_ptr[0];
> 
>+	if (!xa_empty(&pin->parent_refs) &&
>+	    !dpll_pin_parents_registered(pin))
>+		return -ENODEV;
>+

Also make sure to prevent events from being send for this pin.


> 	return dpll_pin_set_from_nlattr(pin, info);
> }
> 
>-- 
>2.38.1
>

