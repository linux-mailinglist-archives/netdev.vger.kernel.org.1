Return-Path: <netdev+bounces-49321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 194BD7F1AFC
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 18:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ADE21C2149F
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 17:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F5922329;
	Mon, 20 Nov 2023 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qb7ZWhl+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37F722325
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 17:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4C7C433C7;
	Mon, 20 Nov 2023 17:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700502018;
	bh=j24izcB0BEX6PCBIB8xdvgISGX/tySrmyIDfdou4erY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qb7ZWhl+1q5EmmZABTc4P+TidRdBOzUlGA1SYG+XD2idq7KGAffmK1Pf3WcGO5mSm
	 a9YlYm+ZtlfzFXyqCRioiHnzsCZyF/gFED2YmaeEGrBDRXiNZtioQXE7mmIUsMwHCe
	 5bF9dfDO3W/gZYWzpL3yy91UnYfQzq6JMnTnTp5iaCrtUV0BX2Ls6XiDF5NWwmOAh7
	 6SStHgALpjOE0SyMVrmbIOwFzkrrWkbe48QHfcISFOyxaHP5c8BI0WqLDfNyJB6fds
	 3tvTkrBzllKaH+12unFBgeDo5F2MfVFwnR7896oJjQtKGaZpXJCa62eAcoptDpo2/n
	 d8aMCXcWAnNDw==
Date: Mon, 20 Nov 2023 17:40:13 +0000
From: Simon Horman <horms@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
	victor@mojatatu.com
Subject: Re: [PATCH net-next 6/6] selftests: tc-testing: report number of
 workers in use
Message-ID: <20231120174013.GI245676@kernel.org>
References: <20231117171208.2066136-1-pctammela@mojatatu.com>
 <20231117171208.2066136-7-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117171208.2066136-7-pctammela@mojatatu.com>

On Fri, Nov 17, 2023 at 02:12:08PM -0300, Pedro Tammela wrote:
> Report the number of workers in use to process the test batches.
> Since the number is now subject to a limit, avoid users getting
> confused.
> 
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Reviewed-by: Simon Horman <horms@kernel.org>


