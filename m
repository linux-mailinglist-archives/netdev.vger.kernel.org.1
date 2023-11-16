Return-Path: <netdev+bounces-48363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 408967EE26A
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 15:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C591F25FA5
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A46315B3;
	Thu, 16 Nov 2023 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7eIWoyz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B396315A4
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 14:12:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E46BC433C8;
	Thu, 16 Nov 2023 14:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700143966;
	bh=zhFegTaYVzoRKRVWkFOF3bH/j/9PLPLwEjA1JlG/VPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L7eIWoyznt44VkvdJN20N8GhsqFHdbYTl9gxDnqboTPXimAfB8HOdUFaiPZXsCbzG
	 WbVDNaZP6ya77VqO2aLk4gVp5XVoU1jq6OCEcK/8NorDAe6mV2DQXsVYl4eomdL5z/
	 ZuYMPa+MFGnsT9vNkpbrjjRfVhdr3PphsJPJREIlVc5/5yJQeQWWIEl5ml3Co1sPDA
	 rCicuyjvqUtoGjUiWInkMUjFy32kfiPinzBI5dzz+rqxsg5DlGU1lFJ32yv+o4sk0e
	 RfDpKMKmicyB5bjxCG4uSxTPTRUYWBD6PrqUV2v3mKHbZqE6Ac4INrQJm117ZWhcvi
	 tiB+vsv3mfSUQ==
Date: Thu, 16 Nov 2023 14:12:41 +0000
From: Simon Horman <horms@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
	victor@mojatatu.com
Subject: Re: [PATCH net-next 4/4] selftests: tc-testing: use parallel tdc in
 kselftests
Message-ID: <20231116141241.GD109951@vergenet.net>
References: <20231114160442.1023815-1-pctammela@mojatatu.com>
 <20231114160442.1023815-5-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114160442.1023815-5-pctammela@mojatatu.com>

On Tue, Nov 14, 2023 at 01:04:42PM -0300, Pedro Tammela wrote:
> Leverage parallel tests in kselftests using all the available cpus.
> We tested this in tuxsuite and locally extensively and it seems it's ready for prime time.
> 
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Reviewed-by: Simon Horman <horms@kernel.org>


