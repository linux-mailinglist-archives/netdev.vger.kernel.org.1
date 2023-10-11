Return-Path: <netdev+bounces-40048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F32C7C58F7
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 18:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF87D282323
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 16:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596E532C86;
	Wed, 11 Oct 2023 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="rRUQiAAG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F1B18B04
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:16:35 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6754AAF
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 09:16:29 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4075c58ac39so318435e9.3
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 09:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697040988; x=1697645788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y43IqVqy0IAZVxNOtDg5x6xHOYHjqP8gs9vZBWd+ZO8=;
        b=rRUQiAAG6S1X1FvEy+Qiby0XLHE6h32O45ntrYRF5JGSnVM4mJIM735ovppgP005om
         x79MvrplQmi147IGN3QxEj190ZT2R58fFzLTFpMwr+yE9eJLt/+sr0lflEFsTNwY9DvC
         ox0DVOmyzoZeYIkLyNA61wVlPVYhWa+4FbaxmbWQIVB/gmebpDmiD9/nG/QJYVOFX9df
         m73wqr9dBg6pPwu1y5HFywq5lqvkYNxTIIzSKkKFqeeBc69aKZNi4vyW75rTEakqNwxi
         cwTvxVIGEcbmYEYRMMek/y+c0We034x5s7m2mN1KO4lG7zvVubJUC8AUtm9+5759vQ1N
         jcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697040988; x=1697645788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y43IqVqy0IAZVxNOtDg5x6xHOYHjqP8gs9vZBWd+ZO8=;
        b=j7WIzk9HXqJEiisQelqm2zCHJV9SjtMRZOgdgMfCrp0+UV27mFFem+Vey5sc/kgq/c
         ctABFJDPdPhFRCE0/5hskJPFKGcxk6XuVof+NeseQKlBb6PaI3LEDIBbKv6IpbnuzD8V
         5i9HyWJaf4DnD/21eMdmBauBgfE6/zkE3gt5jV4wd5IaqjQNITe3JDTh5Ot8/imqqdpD
         et2aI2dk4tN1x9XtbSRwDnPHHAzUsdS1qW2enFPTFDVcLhF5x2zVsryw8ZnjaEhDYFcQ
         5dvvJhrOWYWaQPA1/hxrNWHfkqZmHnmu0+TRpFOcGC/S/pT+li04XBtJZKkPTUI6d3+V
         V7Rg==
X-Gm-Message-State: AOJu0Yyn/ks8OJBkTedF0waUvgx5sk+KPZ6Bhauskn38hlffsE+3x3Z5
	pXXg7BoVtlse7FBfBRH4WP35BQ==
X-Google-Smtp-Source: AGHT+IF6Q1SF84Iv3R4PLR5q19ewR+10xActemOwQv/zYuQwagXNOstF0aILNHsVtS4NP3mqb69b/g==
X-Received: by 2002:a05:600c:2299:b0:3fe:1232:93fa with SMTP id 25-20020a05600c229900b003fe123293famr18559552wmf.22.1697040987837;
        Wed, 11 Oct 2023 09:16:27 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id l10-20020a7bc44a000000b004067e905f44sm17392957wmi.9.2023.10.11.09.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 09:16:27 -0700 (PDT)
Date: Wed, 11 Oct 2023 18:16:26 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jiri Wiesner <jwiesner@suse.de>
Cc: netdev@vger.kernel.org, Moshe Tal <moshet@nvidia.com>,
	Jussi Maki <joamaki@gmail.com>, Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] bonding: Return pointer to data after pull on skb
Message-ID: <ZSbKWoCUbL8HR7Ar@nanopsycho>
References: <20231010163933.GA534@incl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010163933.GA534@incl>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Oct 10, 2023 at 06:39:33PM CEST, jwiesner@suse.de wrote:
>Since 429e3d123d9a ("bonding: Fix extraction of ports from the packet
>headers"), header offsets used to compute a hash in bond_xmit_hash() are
>relative to skb->data and not skb->head. If the tail of the header buffer
>of an skb really needs to be advanced and the operation is successful, the
>pointer to the data must be returned (and not a pointer to the head of the
>buffer).
>
>Fixes: 429e3d123d9a ("bonding: Fix extraction of ports from the packet headers")
>Signed-off-by: Jiri Wiesner <jwiesner@suse.de>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

