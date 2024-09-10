Return-Path: <netdev+bounces-126877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00309972C33
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 10:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2BF1F25762
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69952186E2F;
	Tue, 10 Sep 2024 08:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1DqU6it"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C7E186E2C
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 08:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725957240; cv=none; b=OLPgS0EDTQuNjxyKyLaIQM89yHXWdSahfiVn0+uzik6VTxjO2SUFpXemWBtxoHiXz3RLuNV3JqYZRyfzP8BPkgbvw9L8GpXftJjtSCEFowJYYgyJ3h1Dpm7UCSxw6tJNc8/YfD8MET7kiLf/cEx75MxI3ZVzD7aNjD0B6kLrpKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725957240; c=relaxed/simple;
	bh=M1cs7ahuEayn5iKdO253DvbiwCwBYCSXZD1x8X6VH+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTYo+WOxGe382OIsCWd1WL/ud2hrXsQDbmvSUiXSok9Vr5aBf+tu/bFXi3YuZmKfY0zMxrlWHCmkYGl1lsOQLFyLOAk663rF9u6LWtrxFbiQoACr2GdldlV/8DTjvVEHtrC8LKnNh4nRTb2BMzvu4eStokoL8yQPtYhkiKKjw88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1DqU6it; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C99C4CEC3;
	Tue, 10 Sep 2024 08:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725957239;
	bh=M1cs7ahuEayn5iKdO253DvbiwCwBYCSXZD1x8X6VH+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J1DqU6itfQXXCdMtts8B9pru+W0ssB9QXERab2MUcltwyTAj4xPB4n9rGLYqXL8dl
	 Z6ie9b6YWQScWbP0Bxi37Ft+HtHidU7YelrGcFIyXVj5vcMIJ2hT+ZU69szPRgc8Mu
	 zZJhxMz+JIx/5526F+HzBHhfpWERndnNeKWJPyD8kxOuB81pMptb0OJxNioPtr/yH/
	 4l/s7gDmUun5mF1kcw6/1eO/HptQBexVZvEiwA9+PYF9mRe/Tx1/lRvKzCZIOHDKFV
	 E9IPNOv15DSgvekIGK/Aq0sGOtIEXL6B6OdBy1BCeH0B8z7M0qTs+Q5fUT8ulWIwug
	 Vcf0Ds/lKC0ug==
Date: Tue, 10 Sep 2024 09:33:55 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com,
	selvin.xavier@broadcom.com, pavan.chebbi@broadcom.com,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH net-next 1/3] bnxt_en: Increase the number of MSIX
 vectors for RoCE device
Message-ID: <20240910083355.GD525413@kernel.org>
References: <20240909202737.93852-1-michael.chan@broadcom.com>
 <20240909202737.93852-2-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909202737.93852-2-michael.chan@broadcom.com>

On Mon, Sep 09, 2024 at 01:27:35PM -0700, Michael Chan wrote:
> If RocE is supported on the device, set the number of RoCE MSIX vectors
> to the number of online CPUs + 1 and capped at these maximums:
> 
> VF: 2
> NPAR: 5
> PF: 64
> 
> For the PF, the maximum is now increased from the previous value
> of 9 to get better performance for kernel applications.
> 
> Remove the unnecessary check for BNXT_FLAG_ROCE_CAP.
> bnxt_set_dflt_ulp_msix() will only be called if the flag is set.
> 
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>


