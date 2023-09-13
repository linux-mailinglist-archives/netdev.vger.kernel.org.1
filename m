Return-Path: <netdev+bounces-33477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A9279E14F
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 09:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B5B281F56
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 07:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC811DA3E;
	Wed, 13 Sep 2023 07:58:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DD1154BA
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 07:58:59 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBD81989
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:58:58 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31f71b25a99so6236997f8f.2
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1694591937; x=1695196737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EkdGZYQrwA4ll/7xTuDvjPfd4MTlNtu+sDVCgPZq2hM=;
        b=fDj6Pg+QybGFCjKOebH0swOZ+enPGTuJmqrxMxg9BozYR2t35AEvdUCMHsIqzGNHma
         Kj53e6YM3/CfYAz/G7lLIGUFDWdZ7h5h7vRaUbbu2vxs6CwLV1h2mB8YjPxiCFSJfnRC
         1kuwY1nwWyw7OHUZrYms+gK6x1Oe8GsTsu+lxmWhLTvZvKbQnH/TTqlTIsBGc7VK8WCd
         BYXIKxQ1tBBBF8B9oZGtjcoPMfRzIIS1d/luKYyKQbsjdk8lEpyHY3KNNrGQ8SVHcVqS
         oIG352Hi9ueyP1KkVwm5WLcYxjEQUulQR71iDxHVTSln/ciuqd6B75e0pgDdpMGie4Yj
         5+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694591937; x=1695196737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkdGZYQrwA4ll/7xTuDvjPfd4MTlNtu+sDVCgPZq2hM=;
        b=WfB/M7AMZH4IpCv99lCLVah99YLXC0HX82rcGdSZWJ5V3DciZA7Wjs6bR/OEnA7YPU
         Q1zIQ87Ba4/+h0g1r9fiWtuvpvTPEIfggE1sb0FN9H+hsTmbJs5AcAMWFlYrYbsySzol
         u8pxLtOxcpxdpQ8MaFTCGVfMHf+9TYQEKM7Dp3/sUuFUojfW+XvbG/YQB1w0L1ynkCgX
         vaQ4s+z96SgygJxFQmNXjGCk+ltdHTxjmexXxyWwU2ErbhVesan5WzRCOyckmK1IGxYp
         IFzGXnTeyF6LdlNH6p0hvY0R7Ftz2k7O5aAvWFe7+jaxZ6TiUgEjghMZ4o6szWzeZifj
         cq8Q==
X-Gm-Message-State: AOJu0YwFAGou33h7MA3V1YwdwjL4zayLMmY7TtbGHzeUGB8+DDuAkJA/
	+h1A0Xk3UvHpcOnYQJBsTfCpkg==
X-Google-Smtp-Source: AGHT+IEXU002BF4gZvckDLmB/m507XPZeHi5Or79qEm1/eb14IbkNOzOzkoHnUocfn03vmeh+czvxg==
X-Received: by 2002:adf:f782:0:b0:31a:d551:c2c9 with SMTP id q2-20020adff782000000b0031ad551c2c9mr1382336wrp.6.1694591937140;
        Wed, 13 Sep 2023 00:58:57 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id y18-20020adfd092000000b003179d5aee67sm14854979wrh.94.2023.09.13.00.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 00:58:56 -0700 (PDT)
Date: Wed, 13 Sep 2023 09:58:55 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arnd Bergmann <arnd@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@ti.com>,
	Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ti: icssg-prueth: add PTP dependency
Message-ID: <ZQFrv4W70ijXWTFZ@nanopsycho>
References: <20230912185509.2430563-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912185509.2430563-1-arnd@kernel.org>

Tue, Sep 12, 2023 at 08:54:51PM CEST, arnd@kernel.org wrote:
>From: Arnd Bergmann <arnd@arndb.de>
>
>The driver can now use PTP if enabled but fails to link built-in
>if PTP is a loadable module:
>
>aarch64-linux-ld: drivers/net/ethernet/ti/icssg/icss_iep.o: in function `icss_iep_get_ptp_clock_idx':
>icss_iep.c:(.text+0x200): undefined reference to `ptp_clock_index'
>
>Add the usual dependency to avoid this.
>
>Fixes: 186734c158865 ("net: ti: icssg-prueth: add packet timestamping and ptp support")
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

