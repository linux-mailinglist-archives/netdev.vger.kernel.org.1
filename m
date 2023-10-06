Return-Path: <netdev+bounces-38474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DB07BB1A2
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 08:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47991C208FA
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 06:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5D8523D;
	Fri,  6 Oct 2023 06:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W3776beY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C667646B3
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 06:42:48 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78ED6E9
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 23:42:46 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5041d6d8b10so2323973e87.2
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 23:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696574565; x=1697179365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W48qcl+qVVYwRgZC9dzFeOYmfNEtgKzD22rI+wL+TnY=;
        b=W3776beY1WhbnwkPTXU43k1YN3bvA4HlOBqBgtXAJzQprzX/UGxajTumHDGQWNKiKm
         /1t0l/pO3krDhIBHQ3XxXDVbArB99i2ZUh3oZY4SPbIb8YXPAszCWNYcHvHou3oE3HSB
         QSohK1xz+5hgMrNeV9sWOQy4R2JEhL6cXNk/MDq3ta2/xSwcLVQLdSCgt5Lwonn/VKv+
         TqccQKyo2IfiWDGqqjrC6vfv1TR9o27kSf/Tr+j/wOI8z1YC5f4AV07jnTEN14AZBlDV
         V/t1IVApB6pmJRcgwoWp7Erq46w0NLVOKO/gHgc7qkcazCMOqgMtIfwAQmTxjEmFuuWs
         c/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696574565; x=1697179365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W48qcl+qVVYwRgZC9dzFeOYmfNEtgKzD22rI+wL+TnY=;
        b=H/wUYAXydGHKfH1Zg/3ziczAPF7oA7i4N+OzPq8i/LW8ANIIn9f5qW0D2ZPbjvXq2c
         ncgvP77C2Q1z0Y71CxtmXEq73WtXz8NUUrPHv+J0q+5rlVZFMhOglw9kTEsDXVv28DGG
         s0PVVkbySiOmnPwp0X4lZVgXO1BSRbh9d0BCclzNVFrPyvDCwf4Pp5/wD9qlKRFLYjUI
         BP5iV3vslE2eIWKrxBFnIZ1ic6I/Tqe5UXtm/Y4s2C/uUoXRwTkwBG5S8inzAi2IHyU+
         GE9w4rxCk8jSQJxRwYSndXriJGc5Tgh8cVsAvveZeF0RM0LLPLjWXXzAVi6trnfegRkH
         A8tg==
X-Gm-Message-State: AOJu0YzEOSBgh67rtVIEMB0WEjKYg5lSTgwZRznniPlh6dwbTt8joKet
	1HgfRhRd9Q72Du7Ka4XmrQo6dQ==
X-Google-Smtp-Source: AGHT+IFIWdwm8yYcilcNJBfYGLjSxm5s+ZR2i1auLhHaCiDm+4VaFO3iNGZddB32L6PiCOJ5HAbcYw==
X-Received: by 2002:ac2:5f5b:0:b0:4fd:cae7:2393 with SMTP id 27-20020ac25f5b000000b004fdcae72393mr5162245lfz.2.1696574564680;
        Thu, 05 Oct 2023 23:42:44 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f17-20020a1c6a11000000b004063ea92492sm3019275wmc.22.2023.10.05.23.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 23:42:44 -0700 (PDT)
Date: Fri, 6 Oct 2023 09:42:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ricardo Lopes <ricardoapl.dev@gmail.com>
Cc: manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com, coiby.xu@gmail.com,
	gregkh@linuxfoundation.org, netdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: qlge: Replace strncpy with strscpy
Message-ID: <0b78b29f-2a84-487c-a43b-f8d3fa20d935@kadam.mountain>
References: <20231005191459.10698-1-ricardoapl.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005191459.10698-1-ricardoapl.dev@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 05, 2023 at 08:14:55PM +0100, Ricardo Lopes wrote:
> Avoid read overflows and other misbehavior due to missing termination.
> 

There aren't any read overflows in the current code.

> Reported by checkpatch:
> 
> WARNING: Prefer strscpy, strscpy_pad, or __nonstring over strncpy

But making checkpatch happy is good and the patch is fine.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


