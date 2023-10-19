Return-Path: <netdev+bounces-42706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 754387CFEC5
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 17:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15E74B20BF7
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 15:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF87031A68;
	Thu, 19 Oct 2023 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRxuOZvp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42B230FB0;
	Thu, 19 Oct 2023 15:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A34C433C7;
	Thu, 19 Oct 2023 15:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697730961;
	bh=haRCOkN73wLvU3HdzEVJZt/eh6HF70wED8hxlg8ZNA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DRxuOZvpSnyUST7JnSiju4ZRgp2YLiIAJvpQcdHFTbsAWctHD74BQGZWiRC0qY+a5
	 K7IgBpxU7IzMogz5eGkTTeu/EXsf3TIANvg0r65NaS3/HjvbBIfDX7EZsb/UIOF6n2
	 C1i5inQu59XewjcLdeZfT5oex/n2t4ajVdiIA1jKrTOZLffJHg56BK/dOieR39b8KI
	 T+0eMAvopRzVzGvCTYaTpFMqDPGBJdcvR+uoZy/wvIGLk/q4ifpAFY7AlJOX2EjeCD
	 UeZ5M3jT7/6w9Pv3vMPVze9jvuZ+y8y64yv/eY/lspRxiZriuNn9TLvTbh3CkiP1rN
	 3Yx8OeCdE9TSA==
Date: Thu, 19 Oct 2023 17:55:56 +0200
From: Simon Horman <horms@kernel.org>
To: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
Cc: Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	Coiby Xu <coiby.xu@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, kumaran.4353@gmail.com
Subject: Re: [PATCH v2 1/2] staging: qlge: Fix coding style in qlge.h
Message-ID: <20231019155556.GJ2100445@kernel.org>
References: <cover.1697657604.git.nandhakumar.singaram@gmail.com>
 <cec5ab120f3c110a4699757c8b364f4be1575ad7.1697657604.git.nandhakumar.singaram@gmail.com>
 <20231019122740.GG2100445@kernel.org>
 <20231019134755.GB3373@ubuntu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019134755.GB3373@ubuntu>

On Thu, Oct 19, 2023 at 06:47:55AM -0700, Nandha Kumar Singaram wrote:
> On Thu, Oct 19, 2023 at 02:27:40PM +0200, Simon Horman wrote:
> > On Wed, Oct 18, 2023 at 12:46:00PM -0700, Nandha Kumar Singaram wrote:
> > > Replace all occurrnces of (1<<x) by BIT(x) to get rid of checkpatch.pl
> > > "CHECK" output "Prefer using the BIT macro"
> > > 
> > > Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
> > 
> > Thanks Nandha,
> > 
> > these changes look good to me.
> > But I would like to ask if not updating
> > Q_LEN_V and LEN_V is intentional.
> 
> Thanks for the review Simon.
> 
> I have already sent a patch for Q_LEN_V and LEN_V and it is accepted
> by greg k-h, so didn't updated here.

Understood, in that case this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


