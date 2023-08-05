Return-Path: <netdev+bounces-24667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA654770F80
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 13:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF1A61C20AD4
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 11:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83632BA33;
	Sat,  5 Aug 2023 11:52:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DF5AD2E
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 11:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4024C433C7;
	Sat,  5 Aug 2023 11:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691236352;
	bh=qkRJcII+i/MOcmUTOd8zTsfN35mVnLkGtBTM24Hcgcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e6AH/Ua5Kr/zsxIb1fwmsnzHqqoTxEC0qsXThyDdq/0Pyyu/Jzyzy0NK3ccdBChHL
	 BEhA0dRWIeAr9vz2oQGc5a0zXixHcwBLXuA5f8OJqPL0coZ982swT//y6QcaXtXz3G
	 eRe6LiZHo4OccdyvZA6qRzh4rqugjOXPdXdy5jVyXbmaPerM0Ri69A+fHezBQwIejs
	 O5hPsNjizOqnVMm+4a4iclG2G3GYioaE779WOGyIqgBZ9bFJowyYrXI0WuNfDab/Hm
	 1pqhNewbYf7KNaoqDD8yuEpltm/RVbHGt+pcqEq0MKz7DvrO/4854MbZ5oFZkQgIGi
	 nNbs/SQNMWARA==
Date: Sat, 5 Aug 2023 13:52:28 +0200
From: Simon Horman <horms@kernel.org>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
	weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next] team: add __exit modifier to team_nl_fini()
Message-ID: <ZM43/CZjbB0GddEZ@vergenet.net>
References: <20230804113557.1699005-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804113557.1699005-1-shaozhengchao@huawei.com>

On Fri, Aug 04, 2023 at 07:35:57PM +0800, Zhengchao Shao wrote:
> team_nl_fini is only called when the module exits, so add the __exit
> modifier to it.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

