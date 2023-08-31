Return-Path: <netdev+bounces-31647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F17A978F3E9
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 22:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D401C20B1F
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 20:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A0F19BD0;
	Thu, 31 Aug 2023 20:26:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C91018C26
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 20:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39477C433C7;
	Thu, 31 Aug 2023 20:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1693513567;
	bh=NNAeoqLpCZgpHOi/0zl8S9CWF7TvuYfjEBTVaJJVnnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K5PsRxAGOZQA0kflTYSdafWsrNSih0hyFr8o6j1WN+7hPpQWOehea22aMNHu9bqW6
	 tBWafpqejmso08kd0bt3ugM087/dX8czMd8lyPevFtH5arLgVzduZhw34EW8B8AZ3l
	 32GazId82GcrECG9gPF0X645giSQT/MtlUpazKg8=
Date: Thu, 31 Aug 2023 22:26:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jordan Rife <jrife@google.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Subject: Re: Stable Backport: net: Avoid address overwrite in kernel_connect
Message-ID: <2023083113-unwed-chalice-c8d6@gregkh>
References: <CADKFtnSPTQGLxfpn38cfwTPk=JY-=Ywne2DFoRkq03m-eKo17Q@mail.gmail.com>
 <7702c74e-482f-cd89-1d12-fb6869bd53f2@iogearbox.net>
 <2023083123-musky-exterior-5fa5@gregkh>
 <CADKFtnRw=9F7Epa2T1N_2Zeu4sj+YySuvVb-PTOdfiAF9g4cPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADKFtnRw=9F7Epa2T1N_2Zeu4sj+YySuvVb-PTOdfiAF9g4cPA@mail.gmail.com>

On Thu, Aug 31, 2023 at 01:09:04PM -0700, Jordan Rife wrote:
> Greg,
> 
> Sorry if I've misunderstood. The netdev FAQ
> (https://www.kernel.org/doc/html/v5.7/networking/netdev-FAQ.html#q-i-see-a-network-patch-and-i-think-it-should-be-backported-to-stable)
> seemed to indicate that I should send network backport requests to
> netdev.

5.7 is a very old kernel version, please use the documentation from the
latest kernel version.

You can use "latest" instead of "v5.7" there.

> I saw "option 2" in
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> which reads
> 
> > send an email to stable@vger.kernel.org containing the subject of the patch, the commit ID, why you think it should be applied, and what kernel version you wish it to be applied to.
> 
> Would "option 3" listed there be preferred?

What's wrong with option 2?

thanks,

greg k-h

