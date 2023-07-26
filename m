Return-Path: <netdev+bounces-21167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972647629EE
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 06:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6CE1C210A8
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 04:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE44523F;
	Wed, 26 Jul 2023 04:07:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4565E1846
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 04:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA9CC433C8;
	Wed, 26 Jul 2023 04:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1690344442;
	bh=YtkdbvEmfXjVWfbcHacCSzhuU9NxeZ59S9sLsqcWlXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I9CmT2wVBSQl4217ZEImjonHfi4iX569+4jDl/5whE+vVTQF6xiSRTGfLFRb5ZoA9
	 O1AVy8D6aNOlvmWTepIFmIqIypUBJEFFqI/dQJ782jdu6KjNCcK4vgmfvhKOLNCD6V
	 djsNvK+t9TAlvwi6+b+M5K9RwfeUX8rMfdnmPXKQ=
Date: Wed, 26 Jul 2023 06:07:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: valis <sec@valis.email>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	pctammela@mojatatu.com, victor@mojatatu.com, ramdhan@starlabs.sg,
	billy@starlabs.sg
Subject: Re: [PATCH net 0/3] net/sched Bind logic fixes for cls_fw, cls_u32
 and cls_route
Message-ID: <2023072653-petty-magician-211c@gregkh>
References: <20230721174856.3045-1-sec@valis.email>
 <8a707435884e18ccb92e1e91e474f7662d4f9365.camel@redhat.com>
 <CAEBa_SB6KCa787D3y4ozBczbHfZrsscBMmD9PS1RjcC=375jog@mail.gmail.com>
 <20230725130917.36658b63@kernel.org>
 <CAEBa_SASfBCb8TCS=qzNw90ZNE+wzADmY1_VtJiBnmixXgt6NQ@mail.gmail.com>
 <20230725150314.342181ee@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230725150314.342181ee@kernel.org>

On Tue, Jul 25, 2023 at 03:03:14PM -0700, Jakub Kicinski wrote:
> On Tue, 25 Jul 2023 23:36:14 +0200 valis wrote:
> > On Tue, Jul 25, 2023 at 10:09 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > > We don't know who you are. To my understanding the adjustment means
> > > that you are not obligated to use the name on your birth certificate
> > > but we need to know who you are.  
> > 
> > I could start a discussion about what makes a name valid, but I'm
> > pretty sure netdev is not the right place for it.
> 
> Agreed, I CCed Greg KH to keep me honest, in case I'm outright
> incorrect. If it's a gray zone kinda answer I'm guessing that
> nobody here really wants to spend time discussing it.

You are not incorrect.

Sorry "valis", we need more information to be able to take patches from
you as an author for obvious reasons.

thanks,

greg k-h

