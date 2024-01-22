Return-Path: <netdev+bounces-64835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3018283732E
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 20:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46A21F288F3
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 19:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF60E3FB1E;
	Mon, 22 Jan 2024 19:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idnEZOBx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB11B3F8F9
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 19:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952983; cv=none; b=cTV2HdHfmpU5Cwp9CprdhHuMzVsHjeVu3l8eCVpqIM27sh9YzJ1y2OgaGb4it6JXRQROS7n4+qZAqlG0wtmxQoE87inugK2hcbXP5ri1WzmZbT774mS0v+8HUq6LC2CbUH2JzjRtp0Sw9p1J2zQ1wlc132xVhgRTDFKrrXSsIno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952983; c=relaxed/simple;
	bh=2IkqI+qIw7Xioto49PpXfJh+R7tB24j7dBnJsIV2VL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzNzCgZaeegp0qxtN8LsJgQI0z0L7iBloEPKHLc+hpdGtd5l/xI8yd1awT6FUdpMbpneGWO6LeUSZOAQCkmyUbQtwIqOoXV8basNLL4iqAuSiMPGuqcUrOzPrJLHqLNPsysErCTmQ2g0k2L+pRymk7isUimqBss851m/o/M51Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idnEZOBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628F2C433F1;
	Mon, 22 Jan 2024 19:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705952983;
	bh=2IkqI+qIw7Xioto49PpXfJh+R7tB24j7dBnJsIV2VL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=idnEZOBxQtDSHAjD236ZrDTDJyLSWkc93Y17ovXoheMH+rMVnstSv4whN0YrRHFPc
	 It2jIDwvGZ+SrLsLzbdyhp7ewFdeqDAlgmOoCjBxG2Jypr9ESmUoCWjXa7fmYeuVEi
	 A6BFx247OzhBxm3++1WY7aP0AOrDKPDnisEgJ5yB6ytKPSMDawSELsKkczlO4CmEVR
	 iq+njFeMKjI/rxskIa7lyOl5aPpo+ks4JCxHrJ2xf4w0rcXzcFTQB3j/cFiZI8RrOx
	 YKrtrLsvb2c6DLNR4r7YyhoY4GY5D5eqAABvo5Jhj+k/JaXSuFhyqrFqQlguAJdbVI
	 gxlxZYlfSbp0Q==
Date: Mon, 22 Jan 2024 19:49:39 +0000
From: Simon Horman <horms@kernel.org>
To: Dave Ertman <david.m.ertman@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net] ice: Add check for lport extraction to LAG init
Message-ID: <20240122194939.GE126470@kernel.org>
References: <20240119211517.127142-1-david.m.ertman@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119211517.127142-1-david.m.ertman@intel.com>

On Fri, Jan 19, 2024 at 01:15:17PM -0800, Dave Ertman wrote:
> To fully support initializing the LAG support code, a DDP package that
> extracts the logical port from the metadata is required.  If such a
> package is not present, there could be difficulties in supporting some
> bond types.
> 
> Add a check into the initialization flow that will bypass the new paths
> if any of the support pieces are missing.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Fixes: df006dd4b1dc ("ice: Add initial support framework for LAG")
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


