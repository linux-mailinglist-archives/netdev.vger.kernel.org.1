Return-Path: <netdev+bounces-42567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4427CF56F
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 12:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC0F282126
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 10:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA26168BE;
	Thu, 19 Oct 2023 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lgXCyMoJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41161945E
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:34:56 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FD4124
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 03:34:54 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32da4ffd7e5so369145f8f.0
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 03:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697711693; x=1698316493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gHZ0E2oURQ40dzVmSqirtuqVQjv7KJZAugs/PKtmYUc=;
        b=lgXCyMoJ4ePOJCrJQlFBVWwImk9CquZTm2u+4IE5bTLtPVWBbowhiIBfGgaGuAWrir
         DMxI0HL07KlU1xMB4vomLRQKtQMZLphduJzxLtj2ykGYudNotYgAQqSoAnDKKRUT/gNI
         SgcdgfC3VbnIluEfSaA7d/2WV73XdsUSrMjHLFjNMAYh3QJzTsG1AT6xJbt8D20l7NEg
         7O4YkfxJpbWGEE08hp+aAS6en1I9e6rsXaJTKTeKxVBWPWTorAwlBUeRSrJWXpo4LLsx
         HsrmepXs085cNJX7L5ZVKAFsHgngCK3ga37IxqX4hyu9uwhOPvk86n+uWaDncEpLjTZd
         usQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697711693; x=1698316493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHZ0E2oURQ40dzVmSqirtuqVQjv7KJZAugs/PKtmYUc=;
        b=QCc65OfaxAc/VaenAt7tAdcq7gFGtiFRwtuqJvxwlw7myn4Rh+O+2H5yr4MR4QJ+gi
         cMc9xIRK9qg/iDzM/qET50GfjkBINGp1hnib4YUFk+AlXQlsN45cL5kBbZQzajyco8Ax
         X+Xx94gAjqKFuQyApWS3YUBsUDYl1K8miQIl34QtQ6plGMW1tI+k21MaBwg9sCF3oQ1A
         6Asr+GcqB1lNZe/c6NoYabeCDimYw6KEqEJ7iNbJXaDxaFEeCZ6i5gRDdPy1N+QuTdTn
         Fb6XxjaEARrDDp49NmoBYl/l6lE9iWWgGcYE87HgtRboLpGAJkYjgswSRBdDAuywn49S
         l0+g==
X-Gm-Message-State: AOJu0YzwmnAmNFNgHPvfBmhcp6EugtXGQRvKxeZGSvptHe/cIyByoxQJ
	hv4tzE1q+TjZpmm9P+eO+8/7VA==
X-Google-Smtp-Source: AGHT+IFdar0VVDaMOSgRpl4MSClkYLbAVPKlMoGU4cE/swmAe891KuxkdeV5d/6VMA1irMhQ27GKxQ==
X-Received: by 2002:adf:eb87:0:b0:32d:dd68:e83 with SMTP id t7-20020adfeb87000000b0032ddd680e83mr1075240wrn.21.1697711693227;
        Thu, 19 Oct 2023 03:34:53 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q9-20020a05600000c900b0032d8eecf901sm4175868wrx.3.2023.10.19.03.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 03:34:52 -0700 (PDT)
Date: Thu, 19 Oct 2023 13:34:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, nathan@kernel.org, ndesaulniers@google.com,
	trix@redhat.com, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net: lan78xx: add an error code check in
 lan78xx_write_raw_eeprom
Message-ID: <aa78dff4-d572-4abc-9f86-3c01f887faf1@kadam.mountain>
References: <20231019084022.1528885-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019084022.1528885-1-suhui@nfschina.com>

On Thu, Oct 19, 2023 at 04:40:23PM +0800, Su Hui wrote:
> check the value of 'ret' after call 'lan78xx_read_reg'.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
> 
> Clang complains that value stored to 'ret' is never read.
> Maybe this place miss an error code check, I'm not sure 
> about this.

There are a bunch more "ret = " assignments which aren't used in this
function.

regards,
dan carpenter


