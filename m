Return-Path: <netdev+bounces-25921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1107762BA
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 16:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59CE5280DD8
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 14:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B7418B11;
	Wed,  9 Aug 2023 14:41:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216E02CA4
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 14:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD924C433C8;
	Wed,  9 Aug 2023 14:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691592077;
	bh=hZL+A1+2SfhEiKPYNkvrBc6Rb3xDWwaGw9S1aooJWn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JeIDLqFLNixApyRoxJcuE/+sfQ3I4orpK4C7d+SWhlVECuNwy4wZDcsB0njtuSLrE
	 9QVwxt0MRW0CqurVKUYK3AqWXJ/cBgNXd1pSdXujKIswOoZrfEqAzu25ZRw9hztNyQ
	 xK8HmGDfQvkcXSRjfdd8E52JZtNYG5nnbUL8g+Up+rM3LDXTz23qZY1BLXNWPkUaOw
	 I5uqMe2SbvAGGiFCTtscLwLabcliY0o3iUSPISQBM5JkAS7nGka8q5vBQCnZYc69E4
	 K4US/y51RHcwC/+26+INfVSHxr4lifGVo3QVYGOtALmO7VH+x5vrt3YLhecvkKJ/pH
	 OzhL/kGrEwuCQ==
Date: Wed, 9 Aug 2023 16:41:13 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	petrm@nvidia.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: switchdev: Remove unused declaration
 switchdev_port_fwd_mark_set()
Message-ID: <ZNOliQ0VXjSoV++7@vergenet.net>
References: <20230808145955.2176-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808145955.2176-1-yuehaibing@huawei.com>

On Tue, Aug 08, 2023 at 10:59:55PM +0800, Yue Haibing wrote:
> Commit 6bc506b4fb06 ("bridge: switchdev: Add forward mark support for stacked devices")
> removed the implementation but leave declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


