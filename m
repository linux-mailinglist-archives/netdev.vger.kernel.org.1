Return-Path: <netdev+bounces-47939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51BF7EC055
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 11:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8111C203B9
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 10:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE3BC2FD;
	Wed, 15 Nov 2023 10:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="u9Og2uP3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B0BC8EE
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 10:14:47 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F919C
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 02:14:45 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so10221453a12.2
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 02:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700043283; x=1700648083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NUrvNnPjdmhN7swaMdYslu65aOtTlRA+U1vSW8EoaqY=;
        b=u9Og2uP3wIarceH4HtckW8iejQtrJdHJOxvZ9DLVC25mZhFzcnGVCiwQigP+209wkw
         y3d9/yPNSwbvXzQPlQqQuyA1EIkD5D+TnFhgtxnC4MFHLhL6t2ULWQ1GxS2L91TytVID
         0IrvyiCYlWlx4nBLWw8RmKX5y6gcQKXsVpvN5/xZwm8txyJBACFEwLVkYTnrzO4Gglf8
         vfDbyb4rk1A3ch7uW9zkJPt26UAsZyKeb5v+9sRAz/wQ2m8XyA2P2V0iKzXJ+VUho6dB
         u0kZinbSVkKmGli3nM6v+dQLxlHJZHMIiSFa7+11zzhc2zx+deUzxCH82hNIq+P2lgrK
         dabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700043283; x=1700648083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUrvNnPjdmhN7swaMdYslu65aOtTlRA+U1vSW8EoaqY=;
        b=gxgl4qdQ9+WmQxxLBy3vlRRK9tryzyoRJMCK6H7yiGQnNqHbGNUqHpJ4kzxGp093to
         Nhd6HGb+y22ph+JHnQTIprNHY3o9gzZ5ZBxjMva2qTcFBpfmOJxcSEYK/m35PV0NTQu5
         nx1J/dBfiW65VtQF0opmJEas9U4M+Gu0NnKDrqjQhq2Azj2bvaZcjs2kexIZHREQyrF3
         sGhPhXjQwyXkSsLnzYOF/Dj4i5x1Lsf4fhBsb9KDqET0jGwQr4Ce2W+icm5JLt+ehUDS
         JBKfE52GhPTorieGbO4L5uRnleK9mxU9IA8rZwTRQTsZD1d1rLswKKkVRHx0GVzGqhxm
         8JbQ==
X-Gm-Message-State: AOJu0YygRPlU9u/b2+VBFoqBI6vk+/reBhH4b0GREEOcyxx9Y0fVvRnd
	Aln7ol9zLFqBbr9DCvT/r2/ERg==
X-Google-Smtp-Source: AGHT+IFpFi1fqB5PmI7Ayyou3rQK1sZt3rFJX8kzjZoMvwHdWTBN6GL4WvelgABRuPaJUcfwlXWOoQ==
X-Received: by 2002:a17:906:bc99:b0:9d7:1388:e554 with SMTP id lv25-20020a170906bc9900b009d71388e554mr8727360ejb.17.1700043283423;
        Wed, 15 Nov 2023 02:14:43 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id dt10-20020a170906b78a00b009a5f1d15644sm6753687ejb.119.2023.11.15.02.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 02:14:42 -0800 (PST)
Date: Wed, 15 Nov 2023 11:14:41 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Vlad Buslov <vladbu@nvidia.com>
Subject: Re: [PATCH net v2] net: Fix undefined behavior in netdev name
 allocation
Message-ID: <ZVSaEaNaeRzAm/Jv@nanopsycho>
References: <20231114075618.1698547-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114075618.1698547-1-gal@nvidia.com>

Tue, Nov 14, 2023 at 08:56:18AM CET, gal@nvidia.com wrote:
>Cited commit removed the strscpy() call and kept the snprintf() only.
>
>It is common to use 'dev->name' as the format string before a netdev is
>registered, this results in 'res' and 'name' pointers being equal.
>According to POSIX, if copying takes place between objects that overlap
>as a result of a call to sprintf() or snprintf(), the results are
>undefined.
>
>Add back the strscpy() and use 'buf' as an intermediate buffer.
>
>Fixes: 7ad17b04dc7b ("net: trust the bitmap in __dev_alloc_name()")
>Cc: Jakub Kicinski <kuba@kernel.org>
>Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
>Signed-off-by: Gal Pressman <gal@nvidia.com>
>Reviewed-by: Jakub Kicinski <kuba@kernel.org>


Reviewed-by: Jiri Pirko <jiri@nvidia.com>

