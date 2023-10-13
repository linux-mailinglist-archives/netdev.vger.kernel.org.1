Return-Path: <netdev+bounces-40561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94BE7C7AB1
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 02:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5779C282B95
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 00:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F6636A;
	Fri, 13 Oct 2023 00:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iekErt/E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3605363
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 00:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E53C433C7;
	Fri, 13 Oct 2023 00:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697155308;
	bh=Ha5S911H5ryYsiwYz0UJplTypjEmV4oV7kNBO0ZqmXA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iekErt/EtcnZMdtnt6ARmkStMpS+OHACro/dgSHLXxtVq+JUIJUwAgAZ2zxvaO8qa
	 PAIuDp8eSG2pco4dZGwna6XKWb6aSOg0TdEUt6b9C4UcS1LRPuaY7riQxiQO61v6Nw
	 VS41ScmoZNVfcNLlmlUCqthMumlGq4X7akbFujjJ7N3hmTSngD/xWMcM8X8BICJyUo
	 /Ft8/Kmwq8HPPj2aKJdnTvscOSfWT6/Yg2eDTj0B4L5xPk+/PPop+IKh4SctkJHZHZ
	 Ae9UeuSwwQ6Qc3FGPc29VULp1XC0PanRWcaKAuaaoM4KkDgwDgOwdNB4hvaJY1v14R
	 2DqQgCDqCrSZg==
Date: Thu, 12 Oct 2023 17:01:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <edumazet@google.com>, <egallen@redhat.com>,
 <hgani@marvell.com>, <mschmidt@redhat.com>, <netdev@vger.kernel.org>,
 <sedara@marvell.com>, <vburru@marvell.com>, <vimleshk@marvell.com>
Subject: Re: [net PATCH v2] octeon_ep: update BQL sent bytes before ringing
 doorbell
Message-ID: <20231012170147.5c0e8148@kernel.org>
In-Reply-To: <20231012101706.2291551-1-srasheed@marvell.com>
References: <PH0PR18MB47342FEB8D57162EE5765E3CC7D3A@PH0PR18MB4734.namprd18.prod.outlook.com>
	<20231012101706.2291551-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Oct 2023 03:17:06 -0700 Shinas Rasheed wrote:
> Sometimes Tx is completed immediately after doorbell is updated, which
> causes Tx completion routing to update completion bytes before the
> same packet bytes are updated in sent bytes in transmit function, hence
> hitting BUG_ON() in dql_completed(). To avoid this, update BQL
> sent bytes before ringing doorbell.

Please read this:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#resending-after-review

And also when you reply to people please use sane quoting.
This: >>>
is used to indicate three levels of quoting.

