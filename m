Return-Path: <netdev+bounces-191902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AD7ABDD56
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21A507A40D3
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 14:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1148324887C;
	Tue, 20 May 2025 14:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udlmY6Mu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDB918DB2A;
	Tue, 20 May 2025 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747751862; cv=none; b=pvKeJ/YrhY6mySJkbVrlHBPRCcIpuAG2mSm7xbuiLwcIM/l6Q0NsUY/0N3Pmk3J4NS9gnbi+j+7X1ceu4tZ/N1kyifm0eI3WIaIKLvB22Fb/PjFKpXDSpwnVdf6gXWnlE4u7OO75VqT+phDEhz82xa7NU4MkIPfGFDKS5gBmDdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747751862; c=relaxed/simple;
	bh=nqNVYdFdo5whHwkiTLh4RqdZVNnbZMJgGY6L8YHUnyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3VDdcLV9IFdDLaxUnnFiAN4wk6xQfjzN+xvyFBNQ00yntQjwCBOCTL9zTbPZzVqwd3hbY01v1YU3R+T+Qx6PPbdlFUmjFzxwJipi3c72yMHGGxEdv9gnbCr87JtM4OCWC+eA99buo6xhrMqeyCyITxf0BiIWTb+piGO43wf8ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udlmY6Mu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF207C4CEE9;
	Tue, 20 May 2025 14:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747751861;
	bh=nqNVYdFdo5whHwkiTLh4RqdZVNnbZMJgGY6L8YHUnyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=udlmY6MufKZCvYJsTznavkNAvcdCkBNHlzTw/1qRo4SJXkXGLrJzaReYwiu+DlDoi
	 G8tUgImajEoOIEOh1J1ZQc2fSW9eA8Tvdrl9uEcqCVkozWSzsdpxJQJipEno5q59Ha
	 TPhfiX0KqXa5wLamEEEBA7bqEpv9mLkL4B98YlJOlyvk9FvjZ2RGgiruYghuOxnJoU
	 HlC8lYIEonnaKz/NzpdPDvxGNP56xiMASNNr0i3cmQvCKgfVUO6qzTYJ6NvizLVykX
	 SVkeipHH4/7V//AheRcWyF6zmCkcBGxqk8FetzBH2SPdKFvzTNLU/pjWvWnKc5r0zK
	 enm3kIXJwXQ2w==
Date: Tue, 20 May 2025 15:37:36 +0100
From: Simon Horman <horms@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Jijie Shao <shaojijie@huawei.com>,
	"salil.mehta@huawei.com" <salil.mehta@huawei.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	" lanhao@huawei.com" <lanhao@huawei.com>,
	" wangpeiyang1@huawei.com" <wangpeiyang1@huawei.com>,
	" rosenp@gmail.com" <rosenp@gmail.com>,
	" liuyonglong@huawei.com" <liuyonglong@huawei.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: hns3: Add error handling for VLAN filter
 hardwareconfiguration
Message-ID: <20250520143736.GT365796@horms.kernel.org>
References: <20250517141514.800-1-vulab@iscas.ac.cn>
 <3f03a8d0-c056-4c46-8f98-a5b5f48c6159@huawei.com>
 <682BD774.007007.29338@cstnet.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <682BD774.007007.29338@cstnet.cn>

On Tue, May 20, 2025 at 09:14:28AM +0800, Wentao Liang wrote:
> > Are there any real functional problems?
> > Would you please tell me your test cases? I'm going to try to reproduce the problem.
> 
> Hi,
> 
> I found this problem by static analysis and manual auditing. I believe there should be add a check just like the other call of hclge_set_vlan_filter_hw(). If the check is useless, could you please tell me the detailed reason.

Thanks,

I think it would be useful for the patch description to state
that the problem was found using static analysis.

But let's wait for more feedback from Jijie on if this
check is, at least theoretically, required.

