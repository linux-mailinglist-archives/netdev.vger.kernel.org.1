Return-Path: <netdev+bounces-107427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39BA91AF2F
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 20:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70005B2096E
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 18:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A5F19AA63;
	Thu, 27 Jun 2024 18:40:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA43F198E66;
	Thu, 27 Jun 2024 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719513630; cv=none; b=uqSNvrAtiPBgL1uY2kmQ1h2h65aVy8wB9c49kNT8gohNfGy0QbkYi/TtFrPfIB8QJv6x0e/K2sH6Zjyw7AGD2doo0gSHzjyMv0a0fiUDGQ4x+Wtwy6cR2Odh0mx7VWDPxuVfbVcf0b+cN3JZ3xcG54FSXj2PBpjXvGa3WrqiVIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719513630; c=relaxed/simple;
	bh=KkLyl1RC/EwhIBQ23wSnNwb/PtCW43HptLeyStQCzBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C37TX/0Z5GOAQKvqqxICo+dEG9VoToRPNN2MEFlnE1dfhbz4ycsYeqH9mhRrxFJ1aohyCDW8OfAIb8wfMZGXNxNVAZB2AyKCloKQvAY2RMxEX8V/fkLEx++JXj6VRpyfTMvRdxWk54rycKPkrgtS14uAInMvUjyFviwp7Wxs/MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-585e6ad9dbcso279189a12.3;
        Thu, 27 Jun 2024 11:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719513627; x=1720118427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRtwt1nHk/eFQfYHJCx8+U3yM4OGoY8sGkg3XpVPOa0=;
        b=kK5VsnLBsraJ5p55FA2kQZttfc3d0H0mnnKYQ7RiLmxY7EZvGeW4uDTmkXDkS0XhsA
         CzNf6aisfSN/8nIA6Mh8M2B+VHsWpb5fxtsfUrudK0vAROvf1DKaPZ/PUTVr7SaTtm5Z
         3y9DRJhyEz55OzTrtYCgLf86H65sf5SeiKhwlnqsNFDltkgr8qWhRsRTnuiSOFtyWAev
         P6rReUH1VabNM2NKapjx2AM3F5zh3oE8i1E/cbmTiFV9IoASRsFKJBIiD5iArEXUver4
         jz6167r1qtydDTOK+Qtjr32BpVGXuJLd0CunbJMG3UYe3FZ0jQ3/Ci9DWOViPGgd2vnN
         7ftw==
X-Forwarded-Encrypted: i=1; AJvYcCUbX9Py+9ZO6IjEalF3dxgo8fe0li25Da2Y4PP2kgreIWsz0XpJhoDUjUs7ZEbOTLn2STFmUMeCepqB3djCJ8XVWLbTi6AHNbve6yKXVmFFAC96HWCTIporsOGoUQHO0cwPusO1
X-Gm-Message-State: AOJu0YxLt/lewwB2icvJEp9XOBK2VXo4cdmFuE4VgdUQezrmV5qdpzKK
	W/hiJsujOyFvGRNQHRJIYnbX6bPEQaQZixjRwW6anTbesZvHdGua
X-Google-Smtp-Source: AGHT+IGyWL39Gdti/FMrbm7JkEdRxyFNJ+JC9do85JtWo4z+QZkEpUt2llHGxHDQC6aOi9kuwYXphQ==
X-Received: by 2002:a50:c34d:0:b0:57c:7151:2669 with SMTP id 4fb4d7f45d1cf-57d4a276171mr11107130a12.7.1719513626964;
        Thu, 27 Jun 2024 11:40:26 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58612c83578sm28651a12.18.2024.06.27.11.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 11:40:26 -0700 (PDT)
Date: Thu, 27 Jun 2024 11:40:24 -0700
From: Breno Leitao <leitao@debian.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: kernel test robot <lkp@intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kuba@kernel.org, horms@kernel.org, Roy.Pledge@nxp.com,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] soc: fsl: qbman: FSL_DPAA depends on COMPILE_TEST
Message-ID: <Zn2yGBuwiW/BYvQ7@gmail.com>
References: <20240624162128.1665620-1-leitao@debian.org>
 <202406261920.l5pzM1rj-lkp@intel.com>
 <20240626140623.7ebsspddqwc24ne4@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626140623.7ebsspddqwc24ne4@skbuf>

Hello Vladimir,

On Wed, Jun 26, 2024 at 05:06:23PM +0300, Vladimir Oltean wrote:
> On Wed, Jun 26, 2024 at 08:09:53PM +0800, kernel test robot wrote:

> > All warnings (new ones prefixed by >>):
> > 
> > >> drivers/net/ethernet/freescale/dpaa/dpaa_eth.c:3280:12: warning: stack frame size (16664) exceeds limit (2048) in 'dpaa_eth_probe' [-Wframe-larger-than]
> >     3280 | static int dpaa_eth_probe(struct platform_device *pdev)
> >          |            ^
> >    1 warning generated.
> > --
> > >> drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c:454:12: warning: stack frame size (8264) exceeds limit (2048) in 'dpaa_set_coalesce' [-Wframe-larger-than]
> >      454 | static int dpaa_set_coalesce(struct net_device *dev,
> >          |            ^
> >    1 warning generated.
> 
> Arrays of NR_CPUS elements are what it probably doesn't like?

Can it use the number of online CPUs instead of NR_CPUS?

Other than that, I would say we can drop this patch in the meantime, so,
we can move with the others, while this one is being addressed.

