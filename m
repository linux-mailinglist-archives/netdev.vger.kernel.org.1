Return-Path: <netdev+bounces-49155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9CB7F0F47
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 10:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13332280B91
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2401173A;
	Mon, 20 Nov 2023 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7/XNI5U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A204411C92
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 09:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98022C433C8;
	Mon, 20 Nov 2023 09:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700473445;
	bh=k8nXSk71g2Musf1CxkyhLYDAmO9Pg1y6jhWggky52n0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k7/XNI5U2+rslhJ0qAbqcTCEs9Db7hAwf0+v7XgWZxPY/Fju7wt4w7C2dfyXNmujb
	 Q1BAJhTteR+jIYEikXfPcCGh1tK6KKhW5740qKxsHgvLMQhsFbXh24uMHU4fkJUg9e
	 d8GqzdZd6zqvVH9PrSt5kFhwQa/cxjLnq4kV0XNOIME2nL/4iSqoMhSqycvnEznNv5
	 I5RB9LhU7bBiAufKx12+bsjzY0KcbX7Yz/gIExf+cwt6HlfGb8xQ6+sDu77QACLcaW
	 qnD6i4kNVR/XNV8/HThnYS2PNyPP51lqy3j0kkwFVohWKJXk1rgSwcOmRwgDxeLhPh
	 1Y4uuIuMXj/XA==
Date: Mon, 20 Nov 2023 09:44:00 +0000
From: Simon Horman <horms@kernel.org>
To: Louis Peens <louis.peens@corigine.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>, netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: Re: [PATCH net-next 2/2] nfp: offload flow steering to the nfp
Message-ID: <20231120094400.GL186930@vergenet.net>
References: <20231117071114.10667-1-louis.peens@corigine.com>
 <20231117071114.10667-3-louis.peens@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117071114.10667-3-louis.peens@corigine.com>

On Fri, Nov 17, 2023 at 09:11:14AM +0200, Louis Peens wrote:
> From: Yinjun Zhang <yinjun.zhang@corigine.com>
> 
> This is the second part to implement flow steering. Mailbox is used
> for the communication between driver and HW.
> 
> Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
> Signed-off-by: Louis Peens <louis.peens@corigine.com>

Thanks Yinjun and Louis,

The minor suggestion provided in my response to patch 1/2 not withstanding
this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

