Return-Path: <netdev+bounces-37775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F44F7B71BB
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 21:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5059F2812C9
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 19:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70AA3CD00;
	Tue,  3 Oct 2023 19:28:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47943CCF9
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 19:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C0FC433C8;
	Tue,  3 Oct 2023 19:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696361323;
	bh=F1gwlPMep2jVFplQsk4/rGDk2KWelsDBRqVu/4PVoV4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hw3nKo7mnYqc28JgqukwZBUTFavxVpHQ67YOOJlkQ6FdQy2aFb1GFt8/Z5IorU9gY
	 CQY48gksmUqO6gSBgXlFmFI+2EDwRhT5wU4uEh7toMHwHqzCGXqaSqAxSW3Vu0DcqG
	 0mnyMQ+IUftnn/mI1la59KBvxFnVIcBHs6hsJDIOMf90MQfZRFioW4rjm7bETmAIO6
	 NvI4XrGoGLxBKSzfs6TSyoB8yNeI5TxWFGhmF25ZohlFDA0Wu3CO9XcJvVbeewHpW3
	 +qFFKKl43vcIYXnM+A0VEqFT42czqLC5YJhYRZhaK//DzT0R8rkvRyGBSYa1NQxW53
	 T4/R118rD9sbg==
Date: Tue, 3 Oct 2023 12:28:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "shenjian (K)" <shenjian15@huawei.com>, <davem@davemloft.net>,
 <ecree.xilinx@gmail.com>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
 <saeed@kernel.org>, <leon@kernel.org>, <netdev@vger.kernel.org>,
 <linuxarm@huawei.com>, "Sabrina Dubroca" <sd@queasysnail.net>
Subject: Re: [RFCv8 PATCH net-next 00/55] net: extend the type of
 netdev_features_t to bitmap
Message-ID: <20231003122841.28e0c647@kernel.org>
In-Reply-To: <79b08cc9-fac0-ca87-2ea5-a86d9b28aa12@intel.com>
References: <20220918094336.28958-1-shenjian15@huawei.com>
	<20221125154421.82829-1-alexandr.lobakin@intel.com>
	<724a884e-d5ca-8192-b3be-bf68711be515@huawei.com>
	<20221128155127.2101925-1-alexandr.lobakin@intel.com>
	<d250f3b2-a63e-f0c5-fb48-52210922a846@intel.com>
	<0352cd0e-9721-514d-0683-0eed91f711d7@huawei.com>
	<79b08cc9-fac0-ca87-2ea5-a86d9b28aa12@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Sep 2023 16:25:14 +0200 Alexander Lobakin wrote:
> > Would you like to continue the work ? I thought I could finish this work
> > as soon as possible, but in fact, there is a serious time conflict.  
> 
> Oh well, I'm kinda overloaded as well (as always) and at the same time
> won't work with the code during the next month due to conferences and
> a vacation :z :D
> Would I take this project over, I'd start working on it no sooner than
> January 2024, so I don't think that would be a good idea.
> 
> Anyone else? +Cc Sabrina, there's "netdev_features_t extension"
> mentioned next to her name in one interesting spreadsheet :D

FTR Olek brought this topic up at netconf and the conclusion/Eric's
guidance was to deprioritize this work. Instead focus on cleaning up
things which are currently in features but do no need to be accessed 
in generic fast paths.

