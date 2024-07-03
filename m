Return-Path: <netdev+bounces-109010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3739267FD
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 20:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CDE21C23B7D
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5D9185E4D;
	Wed,  3 Jul 2024 18:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7apOXDz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DCB17DA02
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 18:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030851; cv=none; b=f0CVgLJv07bqGJraEs6wviZnjnapYth96NCoGESEyKR51NUHKrVioVoN81QnBxE1oh8sbRpYSo78MTaR5B65ehpgA/MrdkZWjVA6ieZvD7d7Px5pFfk72a27/bW1HL5XF0Fcp8mfKq6jCxZ2UdN4mYaJiO1AGUfNqgiEdU9fcf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030851; c=relaxed/simple;
	bh=T5vz8e4Q6ADnU0SXFbQTuUb29Cjb5UvBS+IcJ8J/jc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIiLBjHsWBJn9uPiMP0YyPtqEqyhQSl1tU+Kz+jdCmH91DMqKo7nmxQmSGyCP+L4Exbqg9Hfjb7vXCAr/ORmiurr3yFe5aayG3OxBBNSS4f2NT55H1z8SUzxkW86l01fYDFdq7FsqF2GUnQwyOwTX3ZW/rAdAnSTTSDeR4FC4/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7apOXDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3CFC2BD10;
	Wed,  3 Jul 2024 18:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720030851;
	bh=T5vz8e4Q6ADnU0SXFbQTuUb29Cjb5UvBS+IcJ8J/jc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k7apOXDzV7yGQoCe/D1Bzq2WORBnRidbM+VwZk82E20msNUk+5h6knOrXunNz4nT0
	 qUlGFSXfQZPFKtiDsUqVU+B+cGBoCChK2Jz46/PpWu9+rmVd+eGDEDg0dFMAiqUbLG
	 z7c3On2wOrw/6SFnbgUA4Gk+MsL1xhgMVzcqY+gr0ZvDSPsswnEJdlKhLJDgCDOwc4
	 KO3eqKwR+TKUb4GCDyFpWrDPBNMT8jFMIfKAYUtyPl12MN/mBfIW2cU30ZD8Df3PKa
	 7o0OqCcw5hrw1SkWExohJ5+cXdqLZKGjxHT4XsDhElXfXj8suKvnWtLInVkkhhqeG9
	 w4v4VI2qLAeoA==
Date: Wed, 3 Jul 2024 19:20:47 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: Re: [PATCH v2 iwl-next 5/7] ice: Disable shared pin on E810 on
 setfunc
Message-ID: <20240703182047.GN598357@kernel.org>
References: <20240702134448.132374-9-karol.kolacinski@intel.com>
 <20240702134448.132374-14-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702134448.132374-14-karol.kolacinski@intel.com>

On Tue, Jul 02, 2024 at 03:41:34PM +0200, Karol Kolacinski wrote:
> When setting a new supported function for a pin on E810, disable other
> enabled pin that shares the same GPIO.
> 
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
> V1 -> V2: Fixed incorrect call to ice_ptp_set_sma_cfg_e810t()

Reviewed-by: Simon Horman <horms@kernel.org>


