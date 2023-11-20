Return-Path: <netdev+bounces-49318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACAE7F1AB8
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 18:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0041C217E4
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 17:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BD1224E2;
	Mon, 20 Nov 2023 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q14/AOXc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D6822316
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 17:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0556C433C7;
	Mon, 20 Nov 2023 17:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700501908;
	bh=p+qhJD+a7A3Vn/YfBl7sYkUwHQd9/SQ5vepUL1GP/yQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q14/AOXcjMkB61wedVH7lSliHDiWjFiXW/o5mSEYxehrFQ6nOqL09FbATSCnPi/da
	 d3uZ8enBfmTYRYn7f6pL1RRwUdHOgCj3EV81fJZl02jUhgdibA0RmEDSU7hPgrz+kv
	 UR/IFQ0CYls7B7+2N09WL/AW2P5SADPTplCl833sdBlR9Vel/KTbLAtVNmMwAlUWjj
	 dNYHxyPxSjZsSK5AJ4oMdGZr2vADwt+xgRjwsTfhMjesKDwvc1Kcc+7h54l9CPlbcW
	 3SPTPffZoWCabbt+5yHhxXEhzmB9XfRvVzXM8JbkMhSJcj6lQ9vlIkjpQHprWdSkD+
	 M72pj0y61HdLw==
Date: Mon, 20 Nov 2023 17:38:23 +0000
From: Simon Horman <horms@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
	victor@mojatatu.com
Subject: Re: [PATCH net-next 1/6] selftests: tc-testing: cap parallel tdc to
 4 cores
Message-ID: <20231120173823.GF245676@kernel.org>
References: <20231117171208.2066136-1-pctammela@mojatatu.com>
 <20231117171208.2066136-2-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117171208.2066136-2-pctammela@mojatatu.com>

On Fri, Nov 17, 2023 at 02:12:03PM -0300, Pedro Tammela wrote:
> We have observed a lot of lock contention and test instability when running with >8 cores.
> Enough to actually make the tests run slower than with fewer cores.
> 
> Cap the maximum cores of parallel tdc to 4 which showed in testing to
> be a reasonable number for efficiency and stability in different kernel
> config scenarios.
> 
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Hi Pedro,

This limit seems a bit unfortunate, because it seems dependent on
hardware and software details that are subject to change. Meanwhile
this patch will be long since forgotten. But, OTOH, I can't think of
a better idea at this time, so:

Reviewed-by: Simon Horman <horms@kernel.org>

...

