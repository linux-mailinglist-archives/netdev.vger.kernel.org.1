Return-Path: <netdev+bounces-30425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC4978742F
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 17:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717B2281550
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4928C134B8;
	Thu, 24 Aug 2023 15:29:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013BA12B66
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 15:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451C2C433C8;
	Thu, 24 Aug 2023 15:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692890971;
	bh=STEAVOyaPX97JlKs+Za+J/vi/QFn2uiTUKxsbqO34YE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IoJz4u5LD5wUUDu9C622wK0k9tQb2JG+WUKJQUcgTufNAezSP6MMTGcz9MttCeTqx
	 +XTdPlbLJblH8bplC3LVQrANqDkGaznVu7XEg5mszsFIRpbW63RzqvY7xynf84Qp3+
	 C4yYuZgWm7FLhNXdhtqZaR2WFpGaTiltKgCFxH45R3J50OvRPpGg7QAA7x3OU/XFQP
	 oOnVSfgfmD+6Vik8rycov6x7vQgUnLl1SkuZgd9zw8oSVoqriGefdaq5ZrO0zBOc6T
	 7XnJ4S/9R/7t9VMJVii03QLpURBxOE9CQtQlwEizvt8JcWI6eWHAisx2HvtkL1rfkD
	 UrmgFUdcLkwyg==
Date: Thu, 24 Aug 2023 08:29:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Martin Habets <habetsm.xilinx@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next] docs: netdev: recommend against --in-reply-to
Message-ID: <20230824082930.3f42cf8b@kernel.org>
In-Reply-To: <20230824090854.GA464302@gmail.com>
References: <20230823154922.1162644-1-kuba@kernel.org>
	<20230824090854.GA464302@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Aug 2023 10:08:54 +0100 Martin Habets wrote:
> On Wed, Aug 23, 2023 at 08:49:22AM -0700, Jakub Kicinski wrote:
> > It's somewhat unfortunate but with (my?) the current tooling
> > if people post new versions of a set in reply to an old version
> > managing the review queue gets difficult. So recommend against it.  
> 
> Is this something NIPA could catch?

I think so, but the whole thing makes me feel bad. I mean, if I was 
to sit down to write some code I should probably try to hack up 
my email client to allow force-breaking threads?

