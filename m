Return-Path: <netdev+bounces-40490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A907C787E
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 23:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02555282BB8
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80623E476;
	Thu, 12 Oct 2023 21:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nN0TJoSC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA4B3E46D
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 21:19:17 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011C2A9
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 14:19:15 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c735473d1aso11566415ad.1
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 14:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697145555; x=1697750355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WV1rWLSM7c49IBFcfuqXHQ0XbP6e2rrZoMUIcLvjd4A=;
        b=nN0TJoSC4A0oGJtC+2ie+rPcv8L4wUsEemoRiePJk/iu8Uhv4MrLKEmEGSAZZ+iE3l
         m6asIgeUsPP4bEj2Ameu5aGs/AUzFsJjwRYrI+QdQOb/CRyT4UqyiChvzST7c1Nw5/HP
         i0TvZb05ObWgmMy4PGoyiahPg4CkNXiDoCy44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697145555; x=1697750355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WV1rWLSM7c49IBFcfuqXHQ0XbP6e2rrZoMUIcLvjd4A=;
        b=rnEm7n7WPEzeGsAOwFNt4YpECYPd0esjohUoOl//YXCUhoBaryx23x4f4QWVTgXiNb
         Orgx54K33WO1zqHP6h888toX1g7pEiSYRwXaguy2S9Ji4ABQHJgGF9NiEp8BqmuUzwy8
         c+Gom4Muvjs5DfqLpr6jGq4OF2po/wOlhb6TcnedxqLbiyU0YnEEAiben8Uuadt35jIA
         CeJ5xBgQkMzzXTSssUihfRbFtOr5L/8vaAVSlhc1Gzik6bKi7NbCSazEryjt32iQUQua
         BJXzMVx+5uA2jPZnEUssQ5g/2KhMeXPrBoo5TzH6qo35534qcV28TnevRHuoViPaCTtJ
         +84A==
X-Gm-Message-State: AOJu0YwBeKUyab9KQS2BjvDBM73gKCrasXgqZBIWrjXc+KXu2ZqQ4Niw
	WP6RJBFKAjoQyI69Bm3URa8YDw==
X-Google-Smtp-Source: AGHT+IF/hXlwpKtWrDQ5SRLUQ/pVbfU+Uaom8WuJEFjDIKbXUNGpndpxYsJlrcNvUqHz/V6eFNrQJA==
X-Received: by 2002:a17:902:ca14:b0:1c9:ca02:645c with SMTP id w20-20020a170902ca1400b001c9ca02645cmr4491963pld.36.1697145555476;
        Thu, 12 Oct 2023 14:19:15 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902d4cc00b001c61073b076sm2429102plg.144.2023.10.12.14.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 14:19:14 -0700 (PDT)
Date: Thu, 12 Oct 2023 14:19:13 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Edward Cree <ecree.xilinx@gmail.com>,
	Martin Habets <habetsm.xilinx@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sfc: replace deprecated strncpy with strscpy
Message-ID: <202310121402.7A27AB9@keescook>
References: <20231012-strncpy-drivers-net-ethernet-sfc-mcdi-c-v1-1-478c8de1039d@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012-strncpy-drivers-net-ethernet-sfc-mcdi-c-v1-1-478c8de1039d@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 08:38:19PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> `desc` is expected to be NUL-terminated as evident by the manual
> NUL-byte assignment. Moreover, NUL-padding does not seem to be
> necessary.
> 
> The only caller of efx_mcdi_nvram_metadata() is
> efx_devlink_info_nvram_partition() which provides a NULL for `desc`:
> |       rc = efx_mcdi_nvram_metadata(efx, partition_type, NULL, version, NULL, 0);
> 
> Due to this, I am not sure this code is even reached but we should still
> favor something other than strncpy.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks correct to me!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

