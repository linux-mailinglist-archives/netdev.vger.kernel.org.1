Return-Path: <netdev+bounces-49316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B11307F1A69
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 18:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF5F281E8F
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 17:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88069210F9;
	Mon, 20 Nov 2023 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hm9zRZLg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6985E22328
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 17:36:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B960CC433C7;
	Mon, 20 Nov 2023 17:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700501760;
	bh=ZQ8jpw1GNEmFueOwbEPGOnNhSPON5CvKL9DkohvqMvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hm9zRZLg/lrFb9Gytr4pkkKm96odIc81fLCgHYQdMP5lO1jauXS187WAyooyUlBwK
	 Ykp4xeFS2DptygzlSXpb0ZrGuf5c0Aey9cS8MDVqptejoI2UxfbbFg5MSm4qHLUq2i
	 PAe3f5uZFKHHEC1Fxg/u/0mNfzN7d/qUS7R9Kdi/AM3Q6y2r0thK/Hu/Ken14QL29A
	 M8YTddr0lC5mpywgQxmIx5xDnTssWW0wG/6gru+oOwu0CFuH7DpqxpHeXwvagid2sO
	 TQnUCi5O8/mjZgOSM1y4cMB6044QommOnUb+78rGbwP1GQmEz4YgzPD7NeyHu329OJ
	 gV6Pk+glIoAXw==
Date: Mon, 20 Nov 2023 17:35:55 +0000
From: Simon Horman <horms@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
	victor@mojatatu.com
Subject: Re: [PATCH net-next 5/6] selftests: tc-testing: timeout on unbounded
 loops
Message-ID: <20231120173555.GE245676@kernel.org>
References: <20231117171208.2066136-1-pctammela@mojatatu.com>
 <20231117171208.2066136-6-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117171208.2066136-6-pctammela@mojatatu.com>

On Fri, Nov 17, 2023 at 02:12:07PM -0300, Pedro Tammela wrote:
> In the spirit of failing early, timeout on unbounded loops that take
> longer than 20 ticks to complete. Such loops are to ensure that objects
> created are already visible so tests can proceed without any issues.
> 
> If a test setup takes more than 20 ticks to see an object, there's
> definetely something wrong.
> 
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Hi Pedro,

no need to respin because of this, but 'definitely' is misspelt above.

Moving on, I am very pleased to see these loops become bounded in time.
So the above nit notwithstanding,

Reviewed-by: Simon Horman <horms@kernel.org>

...

