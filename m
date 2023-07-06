Return-Path: <netdev+bounces-15693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83291749426
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 05:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B48BB1C20CA6
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 03:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03274A5F;
	Thu,  6 Jul 2023 03:26:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1063A5A
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 03:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B526C433C8;
	Thu,  6 Jul 2023 03:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688613970;
	bh=nT7dfDs59tYnaOhZgCidDKZjiC4W1l5cBPARCUtqvdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gRX4YHWSwr4XhkZ0XLW65lzyTIQcDE+gU/msRcEb/Wp7KJcCVgPvh68ggmgPxp1XL
	 30NBzjzx/0wmaF2GTOUCIDY8c5TNlxwSrxRER7bTJo3JpoS2vjyBw98vd4eBpNE+OD
	 4Yf6WPXHB1JM+ey23N/U8NhKCG9pF6UBBA5Fg3ytfEd0UbFswhJOm3EeLQoPqmr77v
	 JutAMUoU8bq5dVRqMEZfGULMhlB6TeYNhCsA30Frzj/4fhyr4m9wWEQS/RQbaeAqx+
	 5dGOGCk1vpBtoNDqgE9Xkz84Fx2oMcAV+ECzIIBViTWLQGeRpu3kPt9X71VdbANmlG
	 NADkr/f3G5EEQ==
Date: Wed, 5 Jul 2023 20:26:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: Michal Kubiak <michal.kubiak@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Sunil Kovvuri Goutham
 <sgoutham@marvell.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
 Geethasowjanya Akula <gakula@marvell.com>, Srujana Challa
 <schalla@marvell.com>, Hariprasad Kelam <hkelam@marvell.com>
Subject: Re:  Re: [PATCH net] octeontx2-af: Promisc enable/disable through
 mbox
Message-ID: <20230705202608.709c0654@kernel.org>
In-Reply-To: <MWHPR1801MB19180605C58796644F1501E4D32CA@MWHPR1801MB1918.namprd18.prod.outlook.com>
References: <20230705033813.2744357-1-rkannoth@marvell.com>
	<ZKVxQ2HtG+GtumCj@localhost.localdomain>
	<MWHPR1801MB19180605C58796644F1501E4D32CA@MWHPR1801MB1918.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Jul 2023 03:18:55 +0000 Ratheesh Kannoth wrote:
> Is it mandatory to fix these  ? ASFAIK, 80 lines restriction is old
> one when screen size were small. 

More of an old rule from when people cared if the code was readable.
We use checkpatch with --max-line-length=80 in networking.

