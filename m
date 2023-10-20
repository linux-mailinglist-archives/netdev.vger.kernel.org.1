Return-Path: <netdev+bounces-42961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A328D7D0CB0
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D61D282454
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 10:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A3D15E97;
	Fri, 20 Oct 2023 10:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/1H7+mx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E15A15E81
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 10:07:16 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5DCD64;
	Fri, 20 Oct 2023 03:07:14 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4083cd3917eso5305535e9.3;
        Fri, 20 Oct 2023 03:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697796433; x=1698401233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eg/csZTe11WF84HY2bC30HCtKA95bWgVvxI9p/8afRY=;
        b=W/1H7+mxcgaW2CIZYzlMcgQmGAkNadgMutA1aQstRAx9seq239n1cCjK/Hb3GePFU7
         oTyN5GT+MGBb7uwWj39MSJTqvbVL+rM+zFhdKRTn4KXT3M4uS39UxDxbuQKTCibZEZ79
         kDVkcFl3q08PLSlfw9O9SV0KVxz83GGdKedAFdvdA0N2gaPbuU0qDCiSUK1IXeRQUBuJ
         yClwWAe5ZQJCuN9DuDm19GaHekHy7k+sriVO270bN6Meo6kSbMTTsUp6BKLEqOJcoZ4o
         rVSQ9BJZ3ZWcbzB6EVwFuAZGQb7sqKloI7CQH9MBWLZtBvY96xKCIOnS1pKVSvdEEUyN
         i+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697796433; x=1698401233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eg/csZTe11WF84HY2bC30HCtKA95bWgVvxI9p/8afRY=;
        b=MedMJRwlHgNMeTbIGyJX7TKd+FKnmNJVzeuNcNncpKGuT1niv7qr2Qv91CT0to9Onc
         1gBe64QnjDfMbKmSqsDeoUL/L9hObYQ62bE1l6uJ5EKXgOKGNqOQpty8tOJbYUgONnp4
         DVqAUNmM45moPum67EL9huBX2t92y38EuQe7R0d/bYQEoKrquRQ+6JwBE9bfLwt6eZmJ
         J2jUL0zHsFVnofyfOFhGFuwzAQKaFydiDKJAZiGvLmS5jKbZjijM5TFnKObetybCGeBY
         ub3KjOkPTYDxxDQJDZCfElFhFUujs2IWbfBPLE88joK/8VbmH46zSnPfsHK2WNlh5lrU
         Wn6g==
X-Gm-Message-State: AOJu0Ywv7/SaSRthovZesJ1yGF8rLM98NW4+/1QyC5FTBRZxYFiPDN76
	o89UVSym26DFQUgeY5dN/jY=
X-Google-Smtp-Source: AGHT+IEqZwxXRL66lw1+cuj95TIKompxhoWp5WEAhk2qvUt3UtBRe+YVmcGEZrYV3uvDzSEbs5b0Rg==
X-Received: by 2002:a05:600c:510d:b0:406:53f1:d629 with SMTP id o13-20020a05600c510d00b0040653f1d629mr1084077wms.5.1697796432432;
        Fri, 20 Oct 2023 03:07:12 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id w15-20020a5d608f000000b0032dbf32bd56sm1343204wrt.37.2023.10.20.03.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:07:12 -0700 (PDT)
Date: Fri, 20 Oct 2023 13:07:09 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Su Hui <suhui@nfschina.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net: dsa: mv88e6xxx: add an error code check in
 mv88e6352_tai_event_work
Message-ID: <20231020100709.yy2ovjm3q2hphek6@skbuf>
References: <20231020090003.200092-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020090003.200092-1-suhui@nfschina.com>

On Fri, Oct 20, 2023 at 05:00:04PM +0800, Su Hui wrote:
> mv88e6xxx_tai_write() can return error code (-EOPNOTSUPP ...) if failed.
> So check the value of 'ret' after calling mv88e6xxx_tai_write().
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---

mv88e6xxx_avb_ops :: tai_read() and tai_write() come in pairs for the
existing implementations. So, a missing tai_write() method also implies
a missing tai_read() and would have been caught by the previous call to
mv88e6xxx_tai_read() in this function.

But, ok.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

This is a patch for net-next, as it doesn't fix any user-visible issue
and is just an improvement. For future changes, please note your
expectation regarding the target tree yourself, by formatting the patch
as "[PATCH net-next]".

