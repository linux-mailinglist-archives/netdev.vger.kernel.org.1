Return-Path: <netdev+bounces-33573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD35379EA1E
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 15:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776A8281DF7
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 13:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019831E523;
	Wed, 13 Sep 2023 13:53:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA14D1A71E
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 13:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4ABC433C7;
	Wed, 13 Sep 2023 13:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694613233;
	bh=iUcwDVbOPzjvN7qtqNWiJalrX8S8KbMei03FWhdP1hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PIrg3bKMG4dvgc5PcANUTo1iC93RcCjkCM+EJx13Zt2gFuX0Bh6TgsfI6qMzeF7TO
	 7NI2SRlZ2Q0d8VVN1vG7UPR+V3e7IIDFnl+rWPU3X+qZ9fQNB002grP2wUEOcYn5OI
	 mnzuevHWHjU2uqyPVbmW7Pzrllwjbr45srEqOBs/sCly63ul878oToa+CXX1ex+9aF
	 j7ve1xttl+pqcDeToyf1PsURxpSysQ3D/2Mi/rKeVLO3cteNZsXnyvwzXZkogPylb2
	 /mU23CJ+VAM7NQ6/LD94kLTRg8VSQTxxhBk7J91Rv1i+8qPyZO7DB3i9OOowPRoTmN
	 n9QuR5dLOzjvQ==
Date: Wed, 13 Sep 2023 15:53:48 +0200
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, nbd@nbd.name,
	john@phrozen.org, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] net: ethernet: mtk_wed: check
 update_wo_rx_stats in mtk_wed_update_rx_stats()
Message-ID: <20230913135348.GT401982@kernel.org>
References: <b0d233386e059bccb59f18f69afb79a7806e5ded.1694507226.git.lorenzo@kernel.org>
 <20230913112929.GS401982@kernel.org>
 <ZQGhZcA1e7CjnL+P@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQGhZcA1e7CjnL+P@lore-desk>

On Wed, Sep 13, 2023 at 01:47:49PM +0200, Lorenzo Bianconi wrote:
> > On Tue, Sep 12, 2023 at 10:28:00AM +0200, Lorenzo Bianconi wrote:
> > > Check if update_wo_rx_stats function pointer is properly set in
> > > mtk_wed_update_rx_stats routine before accessing it.
> > > 
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > 
> > Hi Lorenzo,
> 
> Hi Simon,
> 
> > 
> > I'm a little curious about this.
> > 
> > Is there a condition where it is not set but accessed,
> > which would presumably be a bug that warrants a fixes tag and
> > targeting at 'net'?
> > 
> > Or can it not occur, in which case this check is perhaps not needed?
> 
> nope, so far Wireless Ethernet Dispatches (WED) is supported just by mt7915
> that sets update_wo_rx_stats callback. Howerver, I am currently working on WED
> support for mt7996 where we do not have this callback available at the moment.

Thanks Lorenzo,

Understood. In that case the patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

