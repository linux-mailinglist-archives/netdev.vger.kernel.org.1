Return-Path: <netdev+bounces-242698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B07C93CB7
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 11:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C9B24E063A
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 10:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A54309EEE;
	Sat, 29 Nov 2025 10:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9VEpF8z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B286309DCF
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 10:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764413695; cv=none; b=R/EuE0McrocLCKAfz6TnTpqi0z2CU4xmBw6qBIXMit2BTWF8jORad9mS4dIU1u4r5Wr64UJzeM0aq2+8YwfATHaJsi435DZtvOo36cJn+SovSkqWg0GND9YCE7X8nSLoU2HcD/vx0Yf57f0EQUj3eO88/gW5bGD06pRwkaBP0F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764413695; c=relaxed/simple;
	bh=KNVUGzbjxkkJ9TPlKItSaotNjp2ctuWkFyPczALT4jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxmVYNCdwQJjU8t8uQIFk5e1Ka81n5exry0/4kGYPdE60TesmKwEin1pP9uwavUwnLezjmtgyCFJG4UiAMkaOYlzbaGE6Kl2rj+e9CWj0P1MpwSi8z2rtPoVMJ5a387mDPrm3BoQI0myjdehMVht2UvSXN2I2geHzBCX8pgUNpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9VEpF8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A659FC4CEF7;
	Sat, 29 Nov 2025 10:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764413694;
	bh=KNVUGzbjxkkJ9TPlKItSaotNjp2ctuWkFyPczALT4jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E9VEpF8zQDQUtR1tN1CIBLikWMOX3ZqU/3lgyYAmTjddsAQP5nvHPOKiIMLAt/wxX
	 /sm17y5VrmneN9mck7S2dRWegdZqj6vGBkP/3OV/l+QAR6rTm0mgxopDkRx32DR92Q
	 7pLfMS+S0SiOnlMf0Uuk+Jt6BDasAJeMR3z3LykhNgH8vwcYCQGcEwbri+CFCOW94G
	 6sqNUCFwHD8XWnlCJV6oLviVJ4tCZMzTy2j5rChVlwj85ghWbak+33OKLtumIuVHD4
	 2sHI6k+MPiacU06s3icQ1FL36qLBVIr+cAkNTl/7VXBGnk+xO62wkn9ah0p8QoS3wK
	 eRx6L3MswiOGA==
Date: Sat, 29 Nov 2025 10:54:51 +0000
From: Simon Horman <horms@kernel.org>
To: Sreedevi Joshi <sreedevi.joshi@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-next] idpf: update idpf_up_complete() return type to
 void
Message-ID: <aSrQ-2nLnQabIO34@horms.kernel.org>
References: <20251126170216.267289-1-sreedevi.joshi@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126170216.267289-1-sreedevi.joshi@intel.com>

On Wed, Nov 26, 2025 at 11:02:16AM -0600, Sreedevi Joshi wrote:
> idpf_up_complete() function always returns 0 and no callers use this return
> value. Although idpf_vport_open() checks the return value, it only handles
> error cases which never occur. Change the return type to void to simplify
> the code.
> 
> Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


