Return-Path: <netdev+bounces-42969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201017D0DE0
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E3D91C20E74
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 10:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5EF17999;
	Fri, 20 Oct 2023 10:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="CYO6Ycb7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9211798E
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 10:48:00 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5BF359D
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 03:45:40 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso103088566b.0
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 03:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697798729; x=1698403529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YLTwjqBUL0RgAJQkQyf9RguQc9HPKS5rfOllltIvA9s=;
        b=CYO6Ycb70URrm5diDcoWZV5WQvVIkHXJ1oKA0gmsH5sEtsXgIqBGiQzLbpBv5gM1Dq
         5BqKZ9s8S/6LZn1kxCkpuuJaj6hZFGiWc2lujf4cnTDS5xY78HquVpfZXcbH8WI3Ga95
         OoK+MzXD1JOlTHeQFOPcGnBUjrF2fhU2t1/QC6lGIK1IX8TrJ2aSwEGbTOq9ymu9pRqr
         f9jw/nU5mf6Q8x9L5DNvqtxFrs5pjl2M+nkH7hC6XnpGVUebX05IdiUefpje6vtaboEu
         ylo1qzW9NuibB5u+U9zmvUWnKXoyNqzMk3oB+4MeTaRA+A2A9J2gO3JQygRRG89mhYR+
         6dFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697798729; x=1698403529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLTwjqBUL0RgAJQkQyf9RguQc9HPKS5rfOllltIvA9s=;
        b=IolgIuiyF2XL+LMxGjx1SPKgzg11dcu3VnkMyChZt1ciOv/2PnIMYflliWCa8IQ6cR
         HhhcKwjAtjfb/a/bZDAxCyxQEoLTDYZw4bQoZdK/niZt3PbI9mI49lVWQi0PysrJMNiz
         f33yL7x/G9hsq5h9Zywrnfgf81aNLX0EmbXQ/NPOgZgeJLrIm2pRb5VW5hlM5ZdrJUA0
         rogdWxAsoqRNLmYUEIdg/79acL/ewNPTdfb2SIxZ23CdI1UeKYI2qhKdLGfA/4QGFrfP
         QaZpYfi+h7/6gxiewF9PiHCZnvCYYHop2COFrN+Tx/avmk2La334bZeT12df2icdTSB/
         j3NA==
X-Gm-Message-State: AOJu0Yytag/jGbVCA4OPeXFY4p3GDdqdFk8XBE+R8ALS0nh9Oxr9uSwT
	pWvRlygBVDPKBXmumLee6rLv8g==
X-Google-Smtp-Source: AGHT+IEj/5M5tASA0oG+661TuW7bhYCPRAUYtRl5Ioq46zU4d585haYHmOwphsacZZgnQ0PvO13s1g==
X-Received: by 2002:a17:907:31c5:b0:9c7:59d1:b2cd with SMTP id xf5-20020a17090731c500b009c759d1b2cdmr1004133ejb.38.1697798729285;
        Fri, 20 Oct 2023 03:45:29 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id g19-20020a17090669d300b009944e955e19sm1244897ejs.30.2023.10.20.03.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:45:28 -0700 (PDT)
Date: Fri, 20 Oct 2023 12:45:27 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, johannes.berg@intel.com, mpe@ellerman.id.au,
	j@w1.fi
Subject: Re: [PATCH net-next 6/6] net: remove else after return in
 dev_prep_valid_name()
Message-ID: <ZTJaRz6rRATAvPeg@nanopsycho>
References: <20231020011856.3244410-1-kuba@kernel.org>
 <20231020011856.3244410-7-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020011856.3244410-7-kuba@kernel.org>

Fri, Oct 20, 2023 at 03:18:56AM CEST, kuba@kernel.org wrote:
>Remove unnecessary else clauses after return.
>I copied this if / else construct from somewhere,
>it makes the code harder to read.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

