Return-Path: <netdev+bounces-39105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034D87BE113
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D4E2817DD
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 13:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D201F341A5;
	Mon,  9 Oct 2023 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IO0bwW6S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B199BDF59;
	Mon,  9 Oct 2023 13:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC06C433C7;
	Mon,  9 Oct 2023 13:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696859216;
	bh=Ew1XbL9SrrnXVmkQDxu2ljVL3wze4KKK3L5OJe2bKuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IO0bwW6Ssa2ncFH5bBQSd+iCyZ/G/GDcVGP+xkL34MRALkLpJSNuVqSPIL+lqtDnu
	 uidXjg2zGPP2xs1mcclBdCoRGrL0NkIsDdMXVEUa54XYN+IqzK06W5K6ysoqpnTOpy
	 MEPjr2Y0iciyeDOmvvTvqmEClE0KIfSdtsqomndw=
Date: Mon, 9 Oct 2023 15:06:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	Andrea Righi <andrea.righi@canonical.com>
Subject: Re: [PATCH net-next v3 0/3] Rust abstractions for network PHY drivers
Message-ID: <2023100916-crushing-sprawl-30a4@gregkh>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <5334dc69-1604-4408-9cce-3c89bc5d7688@lunn.ch>
 <CANiq72n6DMeXQrgOzS_+3VdgNYAmpcnneAHJnZERUQhMExg+0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72n6DMeXQrgOzS_+3VdgNYAmpcnneAHJnZERUQhMExg+0A@mail.gmail.com>

On Mon, Oct 09, 2023 at 02:53:00PM +0200, Miguel Ojeda wrote:
> On Mon, Oct 9, 2023 at 2:48 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > Any ideas?
> 
> That is `RETHUNK` and `X86_KERNEL_IBT`.
> 
> Since this will keep confusing people, I will make it a `depends on !`
> as discussed in the past. I hope it is OK for e.g. Andrea.

That's not ok as you want that option enabled on systems that have those
broken processors which need this option for proper security.  You would
be forcing people to disable this to enable Rust support?

confused,

greg k-h

