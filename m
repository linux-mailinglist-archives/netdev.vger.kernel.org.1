Return-Path: <netdev+bounces-31817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DC97905C6
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 09:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E87D1C208F8
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 07:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD4723B3;
	Sat,  2 Sep 2023 07:29:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D96323AA
	for <netdev@vger.kernel.org>; Sat,  2 Sep 2023 07:29:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575D3C433C7;
	Sat,  2 Sep 2023 07:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1693639772;
	bh=RTbpFhhBwRB9wpN3hoxEEaPCTMvshHWrqKtoXGVFog0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HOWFwQsSGfjNpM3PP3I1mjINJGeggctbw4PtMzXNQtrvYjNqX45HI0OInvWV73+EB
	 havtkBgORzgDWJrqHU/QywccJIWEEFZGaQfwPh+C90nqnNmETsN7T8LYAtnDjahdZz
	 jLn3bVCHTmA9xYbQ4Wo0W/BOfEm6mdnZ1A+pBFkc=
Date: Sat, 2 Sep 2023 09:29:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jordan Rife <jrife@google.com>, netdev@vger.kernel.org
Subject: Re: Stable Backport: net: Avoid address overwrite in kernel_connect
Message-ID: <2023090243-curse-renovator-c5eb@gregkh>
References: <CADKFtnSPTQGLxfpn38cfwTPk=JY-=Ywne2DFoRkq03m-eKo17Q@mail.gmail.com>
 <7702c74e-482f-cd89-1d12-fb6869bd53f2@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7702c74e-482f-cd89-1d12-fb6869bd53f2@iogearbox.net>

On Thu, Aug 31, 2023 at 09:26:31PM +0200, Daniel Borkmann wrote:
> [ Adding Greg to Cc ]
> 
> On 8/31/23 8:47 PM, Jordan Rife wrote:
> > Upstream Commit ID: 0bdf399342c5acbd817c9098b6c7ed21f1974312
> > Patchwork Link:
> > https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=0bdf399342c5
> > Requested Kernel Versions: 4.19, 5.4, 5.10, 5.15, 6.1, 6.4, 6.5
> > 
> > This patch addresses an incompatibility between eBPF connect4/connect6
> > programs and kernel space clients such as NFS. At present, the issue
> > this patch fixes is a blocker for users that want to combine NFS with
> > Cilium. The fix has been applied upstream but the same bug exists with
> > older kernels.

Also, no one tested this, it doesn't even actually apply to any of those
trees :(

Jordan, please provide working backports after you have tested this, if
you wish to see it applied to any stable trees.

thanks,

greg k-h

