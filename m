Return-Path: <netdev+bounces-150387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEA39EA133
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 22:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FFA4280E52
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 21:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD3F199FC1;
	Mon,  9 Dec 2024 21:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwwH5ik8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E6849652;
	Mon,  9 Dec 2024 21:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733779529; cv=none; b=Goy+orqbE9ysGqmcGSKugQsmeLPaPMLt2t+y1tObUzyGTtbHW36hhgpKhjMH6jDDlHS8siLvq69Xu3+lNhNH4FFFReQi2aN/FjPNkXIGlP5w397rTnEisyi3Ecr/9LviOCn/M6ajQk8EY+Ci9RmzuVdpzdWikvC+ZUjEC7+aeUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733779529; c=relaxed/simple;
	bh=C7WtiZhDagbqLAikB4SlgKXKSmwaezICgrYfjD+2TuM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qcC42v89sqapBOcbd65rd2WCjKvjmNjV2N1df0BUQ1kHeoJgfcXjIpPJHze/n9loRA9rLBeWxtcU6IwYYnpiqG9gfW+If2W5R2PZvn/tNeOx8MxP5r7DSok/CXvfwKRX3umUVOy4PYxXipyWk9B1ti5kBQQYgyV4TNfma5Herj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwwH5ik8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE55C4CED1;
	Mon,  9 Dec 2024 21:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733779527;
	bh=C7WtiZhDagbqLAikB4SlgKXKSmwaezICgrYfjD+2TuM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mwwH5ik8xQ32ugB+svIyLvYxLrTz89o+AAGOQyApfnMTrXp9ffZEWgKYRX7T4x5i4
	 Z08XLU7cVbphKGoeTnedwu6yLQHORE76BL/5tYKlaIdiO3Td8HLnNmXgOzoB60/poq
	 NKfGBMXrVHqXLSo5QM2WmVYu6lhZ/mGWfR59IoapGe/zZYfijCz4GkPCnsqz/b7BAI
	 ON0Po1jHD42xC8LqGhZ2FcQoFnDt0ppNKgscrzWYGk3SR5Rv+eZmqy9rrx8oeiNCqB
	 M/8/1/Z/TgEAao9X6NzHSUbblSg7GAAZobhMGl4n5AUPSZ/JdLtPUZb148l5UVtVcU
	 68ouWDGbTVOCw==
Date: Mon, 9 Dec 2024 13:25:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
Cc: Sai Krishna Gajula <saikrishnag@marvell.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Sunil Kovvuri Goutham
 <sgoutham@marvell.com>, Geethasowjanya Akula <gakula@marvell.com>, Linu
 Cherian <lcherian@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 Hariprasad Kelam <hkelam@marvell.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "kalesh-anakkur.purayil@broadcom.com"
 <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [EXTERNAL] Re: [net-next PATCH v5 1/6] octeontx2: Set
 appropriate PF, VF masks and shifts based on silicon
Message-ID: <20241209132525.600ba231@kernel.org>
In-Reply-To: <CO1PR18MB4666941A2B96DF6FC59E7119A13C2@CO1PR18MB4666.namprd18.prod.outlook.com>
References: <20241204140821.1858263-1-saikrishnag@marvell.com>
	<20241204140821.1858263-2-saikrishnag@marvell.com>
	<20241207183824.4a306105@kernel.org>
	<CO1PR18MB466694B5C67641606838782BA13C2@CO1PR18MB4666.namprd18.prod.outlook.com>
	<CO1PR18MB4666941A2B96DF6FC59E7119A13C2@CO1PR18MB4666.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Dec 2024 09:09:35 +0000 Subbaraya Sundeep Bhatta wrote:
> >On Wed, 4 Dec 2024 19:38:16 +0530 Sai Krishna wrote:  
> >> -#define RVU_PFVF_PF_SHIFT	10
> >> -#define RVU_PFVF_PF_MASK	0x3F
> >> -#define RVU_PFVF_FUNC_SHIFT	0
> >> -#define RVU_PFVF_FUNC_MASK	0x3FF
> >> +#define RVU_PFVF_PF_SHIFT	rvu_pcifunc_pf_shift
> >> +#define RVU_PFVF_PF_MASK	rvu_pcifunc_pf_mask
> >> +#define RVU_PFVF_FUNC_SHIFT	rvu_pcifunc_func_shift
> >> +#define RVU_PFVF_FUNC_MASK	rvu_pcifunc_func_mask  
> >
> >Why do you maintain these defines? Looks like an unnecessary
> >indirection.
> >
> >Given these are simple mask and shift values they probably have trivial
> >users. Start by adding helpers which perform the conversions using
> >those, then you can more easily update constants.
> 
> There are too many places these masks are used hence added this
> indirection.
> # grep RVU_PFVF_ drivers/* -inr | wc -l
> 135

Yes, I have checked before making the suggestion.
Add a helper first, you can use cocci to do the conversions.

