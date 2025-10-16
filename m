Return-Path: <netdev+bounces-230150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE97BE47AC
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 18:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0106054143E
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 16:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC29B32D0D9;
	Thu, 16 Oct 2025 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3XXkATF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F2432D0D4
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630935; cv=none; b=l6p+5PfnBttgslGzWPM8VK9Y03vFd+/rUzhGPVI7pl/p36QZNRLjhLRtM+4nuB9QpYiCYktjTcN/7aug+wHocLFH2qqjmmP++segmgp7NYr8SImMvYY4KeMMpK0qklx8vsEdf2uqgnTAzswsadlg1OuS4vYrOmE/uHl98gR2CLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630935; c=relaxed/simple;
	bh=rtOobu5Sj6URXeJFQHEPI/LcvnF98Vvo3jMsGLFw7Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXQUgHguD/B87YClrgRwG2kt02/dDUEKwW0ug5WU5D6LkBS2pPKImyRFcbEOSmJaaX2z3+4BJDcppVTi7Y1/ujdCbcTXiJ92p0bwLIgiJllaGi1K9LXwDVUhnJ5R4aNR7ZAzvR/1V16bDUxzl23IvNV6ajPABu4XXMyiHpmaIB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3XXkATF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEFFC4CEF1;
	Thu, 16 Oct 2025 16:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760630935;
	bh=rtOobu5Sj6URXeJFQHEPI/LcvnF98Vvo3jMsGLFw7Ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C3XXkATFhO5SOAHnGnmt8eM6n+IU9UCidNpwdgWJEenZXPHAHIL6/Y9ll9yObg4WD
	 T1pmhh4oq/A4vdiOWjGttIzMf+Rk3xT8i5gmgKBjtIxGkvtUsCwheZ9RZBPXZrh5FW
	 /ppwyyVyKZ4OoM1fG3nYPIukS1MMgGsn6vkIbhhpzWdU2RUktF24e3Guf/LenXF0FC
	 hAej+ZwS5gxV4SD9aX86GrpnYZgQAmleIDL6uaMu4MeTcVGgU2w3FGgD38/qLF71gM
	 ncks9ZZHYPJncjsBhyz2nJOyAbg3qJuh9KFNeUi7TnFaouZO2qWrNwjYKsJpBCiPB1
	 xC0XRDeOM8Hfw==
Date: Thu, 16 Oct 2025 17:08:52 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH iwl-net v2] libie: depend on DEBUG_FS when building
 LIBIE_FWLOG
Message-ID: <aPEYlAph8tID7pdh@horms.kernel.org>
References: <20251016072940.1661485-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016072940.1661485-1-michal.swiatkowski@linux.intel.com>

On Thu, Oct 16, 2025 at 09:29:40AM +0200, Michal Swiatkowski wrote:
> LIBIE_FWLOG is unusable without DEBUG_FS. Mark it in Kconfig.
> 
> Fix build error on ixgbe when DEBUG_FS is not set. To not add another
> layer of #if IS_ENABLED(LIBIE_FWLOG) in ixgbe fwlog code define debugfs
> dentry even when DEBUG_FS isn't enabled. In this case the dummy
> functions of LIBIE_FWLOG will be used, so not initialized dentry isn't a
> problem.
> 
> Fixes: 641585bc978e ("ixgbe: fwlog support for e610")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/lkml/f594c621-f9e1-49f2-af31-23fbcb176058@roeck-us.net/
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
> v1 --> v2 [1]:
>  * add DEBUG_FS dependency in LIBIE_FWLOG
> 
> [1] https://lore.kernel.org/netdev/20251014141110.751104-1-michal.swiatkowski@linux.intel.com/

I lightly compile-tested this and overall it looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


