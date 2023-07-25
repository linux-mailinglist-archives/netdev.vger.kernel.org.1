Return-Path: <netdev+bounces-21018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 871B37622BA
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 21:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87741C20F92
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 19:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896F826B14;
	Tue, 25 Jul 2023 19:56:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA362516D
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 19:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFB4C433C7;
	Tue, 25 Jul 2023 19:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690314963;
	bh=GiXQu/nD8DNTAps01d2gInzs5Y3/qwmhEDn60fHTXNc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V2y6Y1HJ2urzh7TOYLE5dX/DhXm07qPkuUdUmM9FSyxBGbCikHDt7bKkVl1f4ictT
	 jsfMI1oiafgXo3vqvhAmrWGzOpShV20VY8ImYhGtW2Mrzx/eHpj0Bx15JIPvzsH6Hr
	 AyJXL9YDzBa1haqs/6/IVjlYz1XAvBRMh/dbje22tBMFnWPZkxF29wSnamY4p3eHQy
	 qkqyclynQ8VFIbFZ/7n5lTOtHHMbHTR1jIevefLhtKdsgQ8FDf9RCcxeCvTUkd/rjU
	 jsLw39GdxVXXh6Dm8ZxoagaoxwOgM0QkbTbdHJ70qhnl0V9YunOICB46M9DcBQiOb9
	 otVlAUiij8ckg==
Date: Tue, 25 Jul 2023 12:56:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Lin Ma <linma@zju.edu.cn>, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net/sched: mqprio: Add length check for
 TCA_MQPRIO_{MAX/MIN}_RATE64
Message-ID: <20230725125601.7ec04aa5@kernel.org>
In-Reply-To: <4ce3c7a980be3ce9012ba02a5d9d4285cdf4fd07.camel@perches.com>
References: <20230724014625.4087030-1-linma@zju.edu.cn>
	<20230724160214.424573ac@kernel.org>
	<63d69a72.e2656.1898a66ca22.Coremail.linma@zju.edu.cn>
	<20230724175612.0649ef67@kernel.org>
	<d02a90c5ca1475c27e06d3d592bac89ab17b37ea.camel@perches.com>
	<20230725123842.546045f1@kernel.org>
	<4ce3c7a980be3ce9012ba02a5d9d4285cdf4fd07.camel@perches.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jul 2023 12:50:00 -0700 Joe Perches wrote:
> > > What do you think the "case" is here?
> > > 
> > > Do you think John Fastabend, who hasn't touched the file in 7+ years
> > > should be cc'd?  Why?  
> > 
> > Nope. The author of the patch under Fixes.  
> 
> It adds that already since 2019.

Which is awesome! But for that to work you have to run get_maintainer
on the patchfile not the file paths. Lin Ma used:

  # ./scripts/get_maintainer.pl net/sched/sch_mqprio.c

That's what I keep complaining about. People run get_maintainer on
paths and miss out on all the get_maintainer features which need 
to see the commit message.

