Return-Path: <netdev+bounces-56506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E7A80F267
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 17:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83AA71C20A0B
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 16:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D669B77F25;
	Tue, 12 Dec 2023 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fg/+edAC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3507765B
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 16:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09358C433C8;
	Tue, 12 Dec 2023 16:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702398351;
	bh=NOX09/14OJ0ZefdYzqvqVjJ/qqQBXuOz9+e0JR84QzY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fg/+edAC5Z9+TcxEAvjAWyWtnq5/aY4UtvczdsBSyp5lTAA8IJeAO6EGXgfRGUD92
	 WC/iT75x4pX21s86TSFTHGSYPlELH/cZNSg3HzgXXUNswNcFIX1qlxtRZWtDn8rj+c
	 oMjVE/M8AlQQSgIfYy63d9p/3AtLUGuQmx8fw2qKFSTtNVVSZIU68mk8cILQzWN8+V
	 9RAvMsDeuN/bB//+/uWMfcbvSbD0biAw49AXPoECmHedgvD3+sUiwxzTVa2MUy6nzK
	 t1X87sjhsdmBSJ4cYCDRuD8G3TY8lmhyogse5Ljw5fIQwvcRIrKaRYqr9441lqRT2x
	 +MNFTwbKZ1Mvg==
Date: Tue, 12 Dec 2023 08:25:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH 8/8] dpaa2-switch: cleanup the egress flood of an unused
 FDB
Message-ID: <20231212082550.17962ffc@kernel.org>
In-Reply-To: <6ipoutbyuvlgj33k3ytmrrrtlikabpu7mc3ysv5wemfjgv6o27@wjrdfhg3vwvg>
References: <20231204163528.1797565-1-ioana.ciornei@nxp.com>
	<20231204163528.1797565-9-ioana.ciornei@nxp.com>
	<20231205200455.2292acf6@kernel.org>
	<6ipoutbyuvlgj33k3ytmrrrtlikabpu7mc3ysv5wemfjgv6o27@wjrdfhg3vwvg>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 14:09:43 +0200 Ioana Ciornei wrote:
> > Is this not a fix? FWIW the commit message is a bit hard to parse,
> > rephrasing would help..  
> 
> This is not actually fixing up an issue which can be seen but maybe it's
> better to just have it through the net tree. I will split the patch set
> and send some of them through net.
> 
> I'll rephrase the commit message and add a bit more information.

Same goes for all the other changes. You don't have to send the patches
to net if there's not user visible impact, just please add the
explanations to the commit messages.

