Return-Path: <netdev+bounces-49320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B28227F1AE0
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 18:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65F4E1F25639
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 17:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AB22231E;
	Mon, 20 Nov 2023 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDxO3kei"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1704A22316
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 17:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D79C433C8;
	Mon, 20 Nov 2023 17:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700501973;
	bh=hOHAi2znOTrvRtUzor9s91shnsXdvaww9tbNcsN3d8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WDxO3keiWlpJQ3b1rgX/h41LfS/LCiIF7coW50vqMMd1lIxMQXvpcWm7B6SvHPyyl
	 cT++3r/vBLU38JXrYlHBFtkJVGdwtS3ktxmsp3HDtiOjV2s9p+nAA0h5Oi66HJb8r0
	 V+2PMx9eIdA2zyn/UtyNMBXPIgMeJ26y44NPewMmG3JaHgXoXANKHmBP7D5D/orami
	 Q7Qwhs0W/sCklTmqn33PqP6TBO0V/y9zLI/mm4DYkPwXImpQYyFEHA9kKjmvQusowP
	 D3JCOzRsxSjJvtG7krAMCi9CulUPACLve5Y+QkEHA5ra3NHe9SwAW/WpcWp7rNNK7S
	 g3ljY9YcHjtlg==
Date: Mon, 20 Nov 2023 17:39:27 +0000
From: Simon Horman <horms@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
	victor@mojatatu.com
Subject: Re: [PATCH net-next 4/6] selftests: tc-testing: leverage -all in
 suite ns teardown
Message-ID: <20231120173927.GH245676@kernel.org>
References: <20231117171208.2066136-1-pctammela@mojatatu.com>
 <20231117171208.2066136-5-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117171208.2066136-5-pctammela@mojatatu.com>

On Fri, Nov 17, 2023 at 02:12:06PM -0300, Pedro Tammela wrote:
> Instead of listing lingering ns pinned files and delete them one by one, leverage '-all'
> from iproute2 to do it in a single process fork.
> 
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Reviewed-by: Simon Horman <horms@kernel.org>

