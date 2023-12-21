Return-Path: <netdev+bounces-59705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3DC81BD71
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 18:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392732817B3
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 17:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0B66280F;
	Thu, 21 Dec 2023 17:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmhgXh/E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAD7627F4;
	Thu, 21 Dec 2023 17:40:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F97C433C8;
	Thu, 21 Dec 2023 17:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703180440;
	bh=cJRJia0H10o+aBvcQG5xPpIzftIQUfu6g1hofp+Ojh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jmhgXh/ET/xqCYBUAAkEMvlIxdVb9zkNdwolhxjml0dhYpXMavG6pVF7wgnPG6MhK
	 5VpRdXBU9avsQbJRB2ukqGk1Tt0oyXZ39F+DaL2bK1auPmWTMXjxAqWVga6vZHG7uR
	 tM0g8q5+PCQWk0qKBmvNG2zF5M7hFFEyvyS2bgF00mPVynLXC2IkMu8sy8Kq8lfXEN
	 66DaEQIY7i4j2e/OqzZ420MRr/pEwitxM/J3fQHFgEGq1xacep6vK6h0hW0M4I6WdF
	 H+54jLR6ejVkbOS1Z3+3F8ZxiaWRELG9JwtfmEfHbhCiYJnthKOIco+7NYCoLVQUAf
	 XRn2EhTLoRm5w==
Date: Thu, 21 Dec 2023 18:40:34 +0100
From: Simon Horman <horms@kernel.org>
To: YouHong Li <liyouhong@kylinos.cn>
Cc: isdn@linux-pingi.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] drivers/isdn/hardware/mISDN/w6692.c: Fix spelling typo
 in comment
Message-ID: <20231221174034.GC1202958@kernel.org>
References: <20231221024758.1317603-1-liyouhong@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221024758.1317603-1-liyouhong@kylinos.cn>

On Thu, Dec 21, 2023 at 10:47:58AM +0800, YouHong Li wrote:
> From: liyouhong <liyouhong@kylinos.cn>
> 
> Fix spelling typo in comment.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: liyouhong <liyouhong@kylinos.cn>

Thanks,

while we are updating this file could we also fix the following
which is flagged by codespell: oscilator ==> oscillator

With that update feel free to add:

Reviewed-by: Simon Horman <horms@kernel.org>

