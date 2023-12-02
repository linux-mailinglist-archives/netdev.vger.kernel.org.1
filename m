Return-Path: <netdev+bounces-53216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F98801A56
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 04:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944761C209D5
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 03:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194F28BF9;
	Sat,  2 Dec 2023 03:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNJVtCel"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCDD6137
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 03:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAA4C433C8;
	Sat,  2 Dec 2023 03:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701489525;
	bh=4Dssh/2XYrY7MFpdTli/FZh9LF92fl3xHUY9aZxS/Pg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UNJVtCelRf/0UiHca/sA+nNHW5KpAxlyJE35EDaH124YQSHW3SHpu9ad6DDFTZza9
	 tY1dMIlGCa1nTsMoXd9PqD8ATfDdK0iX9RtGOnZtqPGzDhNkCwjcJteNSt+3jgSepZ
	 3LsPt1bhjrlSsI+TJGsX4ojwn6qTd5UqWLRsHToQqZKV6ZmkihZIvKtmfdRtwpK55s
	 xdrgiLUTmrw5lMb2zS6c4pfsJJlOkRaXNBp8XX7zIhtz0KbSn2AsLDlcouhp6SB2vj
	 qq6iBx4XseHTqWvzLIDUxePGxThJb7kb3QaZ/6NYnMxR1lMIYa5QncS0Pe+Ogt5Epd
	 xtOWtgPZOBS9w==
Date: Fri, 1 Dec 2023 19:58:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
 <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
 <davem@davemloft.net>, <wizhao@redhat.com>, <konguyen@redhat.com>,
 "Veerasenareddy Burru" <vburru@marvell.com>, Sathesh Edara
 <sedara@marvell.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v1] octeon_ep: control net API framework to
 support offloads
Message-ID: <20231201195843.118fdcfe@kernel.org>
In-Reply-To: <20231201131815.2566189-1-srasheed@marvell.com>
References: <20231201131815.2566189-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Dec 2023 05:18:14 -0800 Shinas Rasheed wrote:
> +static netdev_features_t octep_fix_features(struct net_device *dev,
> +					    netdev_features_t features)
> +{
> +	return (dev->hw_features & features);
> +}

Why is this needed? The core kernel should already make sure
unsupported features aren't requested.

