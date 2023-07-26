Return-Path: <netdev+bounces-21477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD15763AF2
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 17:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0F61C212DE
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D073253A8;
	Wed, 26 Jul 2023 15:25:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BB7CA63
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85600C433C8;
	Wed, 26 Jul 2023 15:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690385115;
	bh=DyY8BnynseIb1Y67rUsl4rIxCT0kbeSaml0xf51TrXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AYijz9pcrmWmDrTQYRYb+8yQeok9U344Yi+CY46NaPNtfpOTASv3Q2kXwgyYl9Kl6
	 TWzI5oJ6v3xQ1V82qDyLHpYxGZ1H1nQLYjPKrUKy+ZpuUZHy5xRtRdVUC8+sN9CjHR
	 FAjxQdV1MvWZqFJmtSEPch91Fu+fwTZ5XsMdvTF6ZdslyKBkIFmHdNWIw010IUVXD+
	 bkCKylDLlLJmQxejWyHBxRSpQR5x8DRzbCZyU3pufwsq8/Fb7xkVr/SuQP/cUk2c4z
	 qndm9Ec4dFD2+vViOaCZqbLRoSQZcIg7ahsHvoGkASnvmt5VBgn448lpFjracGAei0
	 2elrGicnWzmZw==
Date: Wed, 26 Jul 2023 08:25:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: valis <sec@valis.email>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, pctammela@mojatatu.com,
 victor@mojatatu.com, ramdhan@starlabs.sg, billy@starlabs.sg, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net 0/3] net/sched Bind logic fixes for cls_fw, cls_u32
 and cls_route
Message-ID: <20230726082514.63ba446d@kernel.org>
In-Reply-To: <CAM0EoM=LiL-exVpP-sTT8rh=odFhu_eYY=ob6yMxQP5MGTU00w@mail.gmail.com>
References: <20230721174856.3045-1-sec@valis.email>
	<8a707435884e18ccb92e1e91e474f7662d4f9365.camel@redhat.com>
	<CAEBa_SB6KCa787D3y4ozBczbHfZrsscBMmD9PS1RjcC=375jog@mail.gmail.com>
	<20230725130917.36658b63@kernel.org>
	<CAEBa_SASfBCb8TCS=qzNw90ZNE+wzADmY1_VtJiBnmixXgt6NQ@mail.gmail.com>
	<20230725150314.342181ee@kernel.org>
	<CAM0EoM=LiL-exVpP-sTT8rh=odFhu_eYY=ob6yMxQP5MGTU00w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jul 2023 09:59:02 -0400 Jamal Hadi Salim wrote:
> > If Jamal or anyone else feels like they can vouch for the provenance
> > of the code, I think that may be the best compromise.  
> 
> I am more than happy to add my SoB - these are real issues being fixed
> and this is not the first time that Valis identified and helped
> resolve legit issues in tc.

Great! Please repost with your signoffs.

