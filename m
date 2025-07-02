Return-Path: <netdev+bounces-203095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0547EAF080D
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 03:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A9954A7F06
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 01:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535DC15747D;
	Wed,  2 Jul 2025 01:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJ4E3yBX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E61BBA33
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 01:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751420069; cv=none; b=A8Geydkfw4/TCj93UWErO0W3CHduyO/Rypvg1sRsYqSMOQ3kDyL/TD90e/EFo74lIhBrkOpytv8lzTEpZFLZJl1jVYWu47cI4jdeaXtZ663yuPDlU8ML7OXFEac62zGUEBfG5Wj0HFDv5I7ZfUCRuq0PIS8hTPvbADKgdTD0sas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751420069; c=relaxed/simple;
	bh=4i8udb3+3ZsGRJhISbyWmsQDm9KT0vudMala98VpOvI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hoKYkz24s4TNsXvDa29iYDAaDPS0FHfNFs/hsmRtlNZS7MK0JPfHWs9eH/A2BUzs2dbb4+6VRR81JCjTq2nNwu1DN6vYth48PlOsXCRyn8brCsAg7glBBzItKct1ebvNPolJnzdYnr2BGs+uI2MaJtQRiWCXFMOvnFEWxe250+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJ4E3yBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5397BC4CEEB;
	Wed,  2 Jul 2025 01:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751420068;
	bh=4i8udb3+3ZsGRJhISbyWmsQDm9KT0vudMala98VpOvI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uJ4E3yBXpReSRk+OidDMCbGvLeGkCusp/U/SE03YhmKOYyu9z7hjOup2ryJaYo/qa
	 hrdWdOUeztK8C9kc6a6/15mPNGcIrIzrGWKkRXELkVLXToNukdPVOkJmW8pIyL8QKb
	 lbyUTHM4NkszkKzo0Nmbdj0Y3FJ7txIS0vBPk74VCULd5QGrFCpQ7pSGP5HQHSZOi8
	 b+0JVpTM4vBskDySHT1CMXkU3dFdtrsuFv7sgubjvupHDPXGBlW9lCOYL0sXop2l75
	 qaOsCGUNKfJOs4juvx7nRQqgz5duTzkoNd+A91iCDASK9ObOjQMQxjxo0mf8GHhGGA
	 cDclxCMF7IdCg==
Date: Tue, 1 Jul 2025 18:34:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Simon Horman <horms@kernel.org>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>, kernel test
 robot <lkp@intel.com>
Subject: Re: [PATCH net] bnxt_en: eliminate the compile warning in
 bnxt_request_irq due to CONFIG_RFS_ACCEL
Message-ID: <20250701183427.497e5f24@kernel.org>
In-Reply-To: <CAL+tcoA8+gGaOhAC4p743Ah9fVbmVwk8AT8zHH7SpFr2-pmm=A@mail.gmail.com>
References: <20250629003616.23688-1-kerneljasonxing@gmail.com>
	<20250630110953.GD41770@horms.kernel.org>
	<CAL+tcoDUoPe05ZGhsoZX24MkaRZx=bRws+kY=MuEVQdy=3mM1A@mail.gmail.com>
	<20250701171501.32e77315@kernel.org>
	<CAL+tcoAfV+P3579_uM4mikMkNK4L2dMx0EuXNnTeLwZ3-7Po2Q@mail.gmail.com>
	<20250701175607.35f2a544@kernel.org>
	<CAL+tcoBu_jo5Nhv-4gRomwfOpN+Y_Ny+QJ6p1dk87gQ==YX-Mg@mail.gmail.com>
	<CAL+tcoA8+gGaOhAC4p743Ah9fVbmVwk8AT8zHH7SpFr2-pmm=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Jul 2025 09:11:35 +0800 Jason Xing wrote:
> > >
> > > Like Simon said -- fewer #ifdefs leads to fewer bugs of this nature.  
> >
> > Agree on this point.
> >  
> > > Or do you mean that you don't understand how my fix works?  
> 
> Oh, thanks to the word 'fix' you mentioned. It seems that I'm supposed
> to add Fixes: tag...

Yes, change the commit reference to a full Fixes tag.
Also -- may be worth mentioning that it happens with GCC specifically.
My first try to reproduce was with clang and it seems not to show this 
warning even with W=1

