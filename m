Return-Path: <netdev+bounces-42690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE097CFD61
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 16:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C50282007
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 14:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BE527440;
	Thu, 19 Oct 2023 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="AwOuEvXT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20FE4419
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 14:54:36 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBBEC2
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 07:54:34 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b89ab5ddb7so5548391b3a.0
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 07:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1697727274; x=1698332074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHVYAT+T8iYPFQ6LlvamaTchg1wOx+0Qgw4gHjbn1rY=;
        b=AwOuEvXTy4hUZNDPq/BhBrWqUOGM7zP9bjkHL3wVyK6pvAG/Wcjhfhvg5KCO6zkQH+
         7UVEUJaMB+iONrPEYuloMQuISMpAhurygA2u/Q6CRLQto4joThnJfn1w9EESstZhTfcP
         SIwu40aPdliKVTgR6hVCh1WELe/gJAxKAKJxvUByWgQHP30svGf8nXcJM2wQMgE3jVEU
         pvBpLlXUtZ27FjUR8TMHLh/E6aExnGnnt5hqrYhXHDhsBNuAedo9ShCpg+B5n8lvhpTg
         ZCR0inV/oYoY3CAnTQL+pguL5v8aW4+z39R+HO6sXC3oq4RhzMOHgLaSwrw6kxYGEIyl
         ouHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697727274; x=1698332074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IHVYAT+T8iYPFQ6LlvamaTchg1wOx+0Qgw4gHjbn1rY=;
        b=ReH0slbZndJdbAs+Dh5Fm2ReYStiewsfJhsewbpIgBDzAPdYDxke2blbx6rRoa7JGt
         60PXFFB08mmMuyzXvbgfXp15obs8Sw9kUYhV1ZXcOElaFah1DnoddDya/pQ5NZ6Dyv/E
         KRrNnC6aOyawWIDfEJM41VeGnojJJ724W4yspuPap9AccfqgZQGbthyHdV43/rSTOfMo
         Q5JI2ZP3GIJ46KF3TWXawErQVXfy8XCS/t344dZUJyX/aTxP6U9JwYNOlcuAWGfHaDWK
         vHjVAS/MVRGFvbyjrDt3o3ie3Xnlfow+/gvnuFMjfKshJ0NVgsr5aEfmrx/N+pqz2Ohw
         EPPg==
X-Gm-Message-State: AOJu0Yw5nRymeAg2MiCcNDEZkDFBBtj/Wkb8Zd7/0I5d3F/6i5a9bjo9
	vIaRTDIb0uUXrG6d9R3f2iJy1A==
X-Google-Smtp-Source: AGHT+IF1nGiRzdrh+s+kANfQtW8VZE3bU6eEaqui1yg5UFad5Bl6uKLCTtylkGCjbD1J/+07InKDuA==
X-Received: by 2002:a05:6a00:b8c:b0:6b8:f7ed:4deb with SMTP id g12-20020a056a000b8c00b006b8f7ed4debmr2176499pfj.13.1697727274321;
        Thu, 19 Oct 2023 07:54:34 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id g9-20020aa796a9000000b006be5af77f06sm5212753pfk.2.2023.10.19.07.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 07:54:34 -0700 (PDT)
Date: Thu, 19 Oct 2023 07:54:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, gregkh@linuxfoundation.org,
 mhocko@suse.com
Subject: Re: [RFC PATCH net-next 0/4] net-sysfs: remove
 rtnl_trylock/restart_syscall use
Message-ID: <20231019075432.4d975762@hermes.local>
In-Reply-To: <169770164786.433869.13558540630519879540@kwain>
References: <20231018154804.420823-1-atenart@kernel.org>
	<20231018111547.0be5532d@hermes.local>
	<169770164786.433869.13558540630519879540@kwain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Oct 2023 09:47:27 +0200
Antoine Tenart <atenart@kernel.org> wrote:

> > That doesn't mean the locking should not be fixed, just that better
> > to avoid the situation if possible.  
> 
> 100% agree on this one. I believe using netlink is the right way.
> 
> Having said that, sysfs is still there and (quite some time ago) while
> having discussions with different projects, some were keen to switch to
> netlink, but some weren't and pushed back because "sysfs is a stable
> API" and "if there is a kernel issue it should be fixed in the kernel".
> Not blaming anyone really, they'd have to support the two interfaces for
> compatibility. My point is, yes, I would encourage everyone to use
> netlink too, but we don't control every user and it's not like sysfs
> will disappear anytime soon.

I have seen code doing discovery of new devices via netlink then poking
around in sysfs. But that usage is inherently racy from the application
point of view. By the time device is discovered, it might be removed or
worse renamed before the sysfs operations.

