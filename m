Return-Path: <netdev+bounces-42345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F11267CE613
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 20:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C23C1C20A16
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 18:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCAB3FE5F;
	Wed, 18 Oct 2023 18:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="PRCgCZAg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AE43FE4F
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 18:15:51 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DD010F
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 11:15:49 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1e58a522e41so4240827fac.2
        for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 11:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1697652949; x=1698257749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHDMTJ75fZCfTpN8+7Wzv/C0Qp0Hti+PJchhIzB0VSI=;
        b=PRCgCZAgwZBKq6hWaPi6SYFgnnAz0RkSkEkQNFzNWqCY6OLyYj1hAQ0VfEFlx6XD4v
         Wv6VEtbEIuLBWgh1ls08Hj8u8aTeyhV/neb0VQ4oPc3DL5yI4PaJFMUBWVyKW/urjGg9
         sDiDx4c1+gu/UT0NzxC81UkC8cos1rXDNcp3lRNH5BhN7DrQupp5tPx4CsM/vFqTVxY8
         whKcOEIpjpN7s2oCjkHdGIxNakd+shY5lXKFxTinq5zc2d71FWIXRJ7y56x+U+D96bSJ
         +zfgMnpY/oxUwpNIdIAsdPgRG8g2IGf5F+ogAe+MeV9r8UE+YRHgW4j4bA2ihVEjOG8q
         7IHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697652949; x=1698257749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHDMTJ75fZCfTpN8+7Wzv/C0Qp0Hti+PJchhIzB0VSI=;
        b=oJTLH2F3T6SSCOsG8jupyRLy6Kw0MS9Ym7hbECASmfATp9GjOKVE7u08NfynB42UWC
         OAGvi8pDr40Yc8ffYytO/oMt2IeCpfKIOySd+Hp5oxx3inrI25wG6f/uWrBgTLvS+/U/
         ByO47GbQVctDZNDQ94Q+28BiFtDst4P0Yw/eP2GUUwji9g+7LU0TChfEVGhTp2Pwn0Lo
         RpG+DEREgFcPOsb8G2kFiNa7BOv1C+7CSqzHRFg1XVT8C5vW080KA1zDUBZi2SxrXyex
         n4mafiyefThGceXMnOGj6lAxJrkf0pemEQePxF9eB/sEqnpsvK7BHgkAkY8AW/9LFmuP
         Grrg==
X-Gm-Message-State: AOJu0Yx1cbV0C1JFaWvKohvHp3s4pF7r8IsnOJ0r4tbAQXYPn2piT4ml
	llcM2yiC+X1A5AlEb98X9SL1OA==
X-Google-Smtp-Source: AGHT+IE9yEGbPPLvbu0nYjIvtJiQg+kK9n+EVKvBP4oolbWxGHamDzjzMWY55qud/YP5r6iYGhvLpw==
X-Received: by 2002:a05:6870:458d:b0:1e9:bbfe:6457 with SMTP id y13-20020a056870458d00b001e9bbfe6457mr192950oao.6.1697652949184;
        Wed, 18 Oct 2023 11:15:49 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id i11-20020aa796eb000000b006934e7ceb79sm3633066pfq.32.2023.10.18.11.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 11:15:48 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:15:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, gregkh@linuxfoundation.org,
 mhocko@suse.com
Subject: Re: [RFC PATCH net-next 0/4] net-sysfs: remove
 rtnl_trylock/restart_syscall use
Message-ID: <20231018111547.0be5532d@hermes.local>
In-Reply-To: <20231018154804.420823-1-atenart@kernel.org>
References: <20231018154804.420823-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 18 Oct 2023 17:47:42 +0200
Antoine Tenart <atenart@kernel.org> wrote:

> Some time ago we tried to improve the rtnl_trylock/restart_syscall
> situation[1]. What happens is when there is rtnl contention, userspace
> accessing net sysfs attributes will spin and experience delays. This can
> happen in different situations, when sysfs attributes are accessed
> (networking daemon, configuration, monitoring) while operations under
> rtnl are performed (veth creation, driver configuration, etc). A few
> improvements can be done in userspace to ease things, like using the
> netlink interface instead, or polling less (or more selectively) the
> attributes; but in the end the root cause is always there and this keeps
> happening from time to time.

What attribute is not exposed by netlink, and only by sysfs?
There will always be more overhead using sysfs.
That doesn't mean the locking should not be fixed, just that better
to avoid the situation if possible.

