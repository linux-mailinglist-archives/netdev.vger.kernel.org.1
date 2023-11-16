Return-Path: <netdev+bounces-48360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2AD7EE257
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 15:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8524C1F24716
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C572D79D;
	Thu, 16 Nov 2023 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="soSpI0zR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362FD3158D
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 14:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C6DC433C8;
	Thu, 16 Nov 2023 14:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700143687;
	bh=CRvk+wgbPAQeVQNFiysm59ZlZC1tw+/krexl24iwoIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=soSpI0zR3FnYOumT7CsB1XJ7nihj1ezyMB1+yqrk+whIQ5E4UugxbC/FBTPFsTsRd
	 UvUURXQbtr3Yc0JLb+LCr6uPSychiKISthvb09Jz4du8j48zX6HDVF+N0ZQMUmvPB2
	 8GkIpIS5jqUBKIaOh2jTmtJW1dTKr/vo9X6djfeTOb3LgCPnI67yBN54RSCZ8ZaH7I
	 NLEkoIcFzUdcxm4jMfeCwMnfmCvI522gXdwOihbkYNWX0WQJI0T1lZABYJrgcbfAwP
	 H3dPTJxGHmZvEBbxhINR1UPJBzpzZr/Uj4PgoIIvMubXgrA41ph3rcx0zjIAH3cACT
	 kIg2z9bmh6zyw==
Date: Thu, 16 Nov 2023 14:08:02 +0000
From: Simon Horman <horms@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
	victor@mojatatu.com
Subject: Re: [PATCH net-next 1/4] selftests: tc-testing: drop '-N' argument
 from nsPlugin
Message-ID: <20231116140802.GA109951@vergenet.net>
References: <20231114160442.1023815-1-pctammela@mojatatu.com>
 <20231114160442.1023815-2-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114160442.1023815-2-pctammela@mojatatu.com>

On Tue, Nov 14, 2023 at 01:04:39PM -0300, Pedro Tammela wrote:
> This argument would bypass the net namespace creation and run the test in
> the root namespace, even if nsPlugin was specified.
> Drop it as it's the same as commenting out the nsPlugin from a test and adds
> additional complexity to the plugin code.
> 
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Reviewed-by: Simon Horman <horms@kernel.org>


