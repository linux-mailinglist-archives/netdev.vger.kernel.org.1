Return-Path: <netdev+bounces-51528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106257FB02A
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 03:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418A91C20A05
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 02:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5CB1C3F;
	Tue, 28 Nov 2023 02:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCFameLS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048DBA40
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 02:38:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23C1C433C7;
	Tue, 28 Nov 2023 02:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701139130;
	bh=+OSbBnS4vP20UuX2XQA37QRXeVEXzq+hur1Q3s0Vb80=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mCFameLSmm/b3mYOMTuAw9k9WZdn3d/OHcLU5VjWb+U8ys0lnwGO5MVtrUTBXrPzB
	 YswropNRxsv6OXrtVHUBOcG7RHeipO0J6vEd0hWtD9czfcTA73BNqQa+nbohZcZG9r
	 HK4t4L6MzQLTFHfwNlG6lJTmLX8cfKdVwFEORQz1dRbqucnzFS9Mn5WXNY1p8/OGEt
	 srum54ahvKy33nvQgjI6rEcnxpxmkSuWdrKRVC5ZkVvaoDoKTW/D8cSradUxWdbLHM
	 M8wPzTqmclFkbZ6NIBfLXxqdnaEGQeFsbAVuES5/n4ZYPoupGwWT58grkDe8KlM9wI
	 XHJr2pSd/pYSg==
Date: Mon, 27 Nov 2023 18:38:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
 <hkelam@marvell.com>, <lcherian@marvell.com>, <jerinj@marvell.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <horms@kernel.org>, <naveenm@marvell.com>
Subject: Re: [net PATCH v2] octeontx2-pf: Fix updation of adaptive interrupt
 coalescing
Message-ID: <20231127183849.140e8809@kernel.org>
In-Reply-To: <20231127060538.3780111-1-sumang@marvell.com>
References: <20231127060538.3780111-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Nov 2023 11:35:38 +0530 Suman Ghosh wrote:
> The current adaptive interrupt coalescing code updates only rx
> packet stats for dim algorithm. This patch fixes that and also
> updates tx packet stats which will be useful when there is
> only tx traffic. Also moved configuring hardware adaptive
> interrupt setting to driver dim callback.
> 
> Fixes: 6e144b47f560 ("octeontx2-pf: Add support for adaptive interrupt coalescing")
> Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
> ---
> v2 changes:
> - Missed adding the fixes tag in v1. Added the same in v2.

Please read:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
-- 
pw-bot: cr
pv-bot: 24h

