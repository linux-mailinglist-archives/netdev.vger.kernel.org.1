Return-Path: <netdev+bounces-109613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7F492922F
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 11:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2031C20EE4
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 09:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EC5487A7;
	Sat,  6 Jul 2024 09:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wr7Pzo5N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DAB28F0;
	Sat,  6 Jul 2024 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720257468; cv=none; b=u8MmxRIPUy6j4yuK84MSlrv4pKDceLsJaAg1Hnl/GXo7/BxDyCiSbpxWXUNeG31rgG9K5yTPFO0YztM/HLMulK2GJomDKApZJ+8uV5FIUu3AYLZhQ6N3kePLivTMdfuI3riFF0DIQL8sFAezZNZoAL3/rGm3BWri7E7ocSdieeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720257468; c=relaxed/simple;
	bh=kc7u5x31aESNAaiQLBMprZ+ADbybp+PTLUnyHy0QeZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyo9Qg+MvYHpJHM8glVi0jx01ffUNglV9HqucQgFld5RA/BqIf74bD5FKgUB2VR0mv6KuWIel74wEi9ZF4Z7RpH0gEzO1em1KX7wFQJsny66E5mCZ1n4s14lpkpuTy3odMXd2Iift7mm+CDnnZNxunOF7gW1igTJFFWgMO7bwok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wr7Pzo5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D25C2BD10;
	Sat,  6 Jul 2024 09:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720257467;
	bh=kc7u5x31aESNAaiQLBMprZ+ADbybp+PTLUnyHy0QeZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wr7Pzo5NjnW3CPuFy4tIf6i1wiLLRDI+ZfJ/mLvaMal0tzkAGrKt5Ev5ND3EWvtnT
	 UWW7OFEly2EVhRCNRofKZQm6f990R0Y95VN7vS3GTCP33xOYUS90pCLfi7jiNvCaeQ
	 ZMz2NIuxuTUBKAHkn11nSV4sNLq4x0PGVjKPPYPo=
Date: Sat, 6 Jul 2024 11:17:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: mhi@lists.linux.dev, netdev@vger.kernel.org, slark_xiao@163.com
Subject: Re: [GIT PULL] MHI changes for v6.11
Message-ID: <2024070626-retinal-arise-add5@gregkh>
References: <20240706085117.GA3954@thinkpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706085117.GA3954@thinkpad>

On Sat, Jul 06, 2024 at 02:21:17PM +0530, Manivannan Sadhasivam wrote:
> The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:
> 
>   Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git tags/mhi-for-v6.11

pulled and pushed out, thanks.

greg k-h

