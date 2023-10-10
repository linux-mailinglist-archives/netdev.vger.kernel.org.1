Return-Path: <netdev+bounces-39636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 078B57C0365
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 20:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADFFB281B7D
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 18:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E5C225CC;
	Tue, 10 Oct 2023 18:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8OGieC9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD640225C3;
	Tue, 10 Oct 2023 18:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD92CC433C8;
	Tue, 10 Oct 2023 18:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696962408;
	bh=waPUWbJO/Xc9axF8eteOesPuRUq2mKO6nYwd8+mSl7o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O8OGieC9iXJ/DbcIGSQBJU99kCIt8X7lAt2kGPnXYquud7uIc+imEF23bTwKr17wd
	 FjX5ceLbQc/CSEaNpU0uCVhdPzfsQcVVqapazg3mrL9UrrHUARJ2Bja/PMRQ7NkAqe
	 ozeuOSFmo8TBfB2My9xSzLgGp2jGv7kuXderYCbd0pc+ulR1O+zLDg5vmpBtfqLBEP
	 cmQnlT+0Z12rm+0/xkI8bz/w79q2QDxuJUNGoi/ZR48kWJIbwjuwrHSE66JE4UMCTs
	 Lp0LTv71EPv+A6oE4mM/wIWLKc4H4nVTxReeAc/0iSUJEQ6MaaYmEcoRKCmh+eCDRo
	 VwNRrguM5H3Yg==
Date: Tue, 10 Oct 2023 11:26:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Pedro Tammela <pctammela@mojatatu.com>, markovicbudimir@gmail.com,
 Christian Theune <ct@flyingcircus.io>, stable@vger.kernel.org,
 netdev@vger.kernel.org, Linux regressions mailing list
 <regressions@lists.linux.dev>, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [REGRESSION] Userland interface breaks due to hard HFSC_FSC
 requirement
Message-ID: <20231010112647.2cd6590c@kernel.org>
In-Reply-To: <CAM0EoM=mnOdEgHPzbPxCAotoy4C54XyGiisrjwnO_raqVWPryw@mail.gmail.com>
References: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
	<065a0dac-499f-7375-ddb4-1800e8ef61d1@mojatatu.com>
	<0BC2C22C-F9AA-4B13-905D-FE32F41BDA8A@flyingcircus.io>
	<20231009080646.60ce9920@kernel.org>
	<da08ba06-e24c-d2c3-b9a0-8415a83ae791@mojatatu.com>
	<20231009172849.00f4a6c5@kernel.org>
	<CAM0EoM=mnOdEgHPzbPxCAotoy4C54XyGiisrjwnO_raqVWPryw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Oct 2023 11:02:25 -0400 Jamal Hadi Salim wrote:
> > > We had a UAF with a very straight forward way to trigger it.  
> >
> > Any details?  
> 
> As in you want the sequence of commands that caused the fault posted?
> Budimir, lets wait for Jakub's response before you do that. I have
> those details as well of course.

More - the sequence of events which leads to the UAF, and on what
object it occurs. If there's an embargo or some such we can wait 
a little longer before discussing?

I haven't looked at the code for more than a minute. If this is super
trivial to spot let me know, I'll stare harder. Didn't seem like the
qdisc as a whole is all that trivial.

