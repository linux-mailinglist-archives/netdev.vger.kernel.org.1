Return-Path: <netdev+bounces-29382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7B5782FA7
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 19:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36A1E280E94
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 17:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1127F8F48;
	Mon, 21 Aug 2023 17:48:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062C88C16
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 17:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB59C433C7;
	Mon, 21 Aug 2023 17:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692640126;
	bh=XZDt43brnFTJkb8ScLQNvWMVfoRbXfvHIPbaNmZldAg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F6yDjvDCIsPvanRvMO9iP5ovPq8w7hv8wc9g7fkg0xbVHYVnJTD+KMBrgLS5lVWTH
	 znqU9oXtTt+NfkBsSq3y+2AVLdXvIXqBp8iUwB8HR7x9mGi1TzhwCmBK3cO4B6HRS7
	 E+T4PJXm1v6bhzzbs2O8uPBHaaYEsESUeE3HavF4sXHAK+uXw2x3xnbETG/N8SvJ6q
	 Q5t5YU8mIqIVHWRS7D/eySV230GwrXA7iSEAJRHtL4Xd47ecpMG1JbybOQOPHIDqJ1
	 bQOyBOmoxbwMBvek8X5nOA2ptpja3emOax+vjUvWswoTL+nsoaIETxXarARXgyEoxJ
	 yVcQH2bSjL8rQ==
Date: Mon, 21 Aug 2023 10:48:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@idosch.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, syzbot+5ba06978f34abb058571@syzkaller.appspotmail.com,
 wg@grandegger.com, mkl@pengutronix.de, idosch@nvidia.com,
 lucien.xin@gmail.com, xemul@parallels.com, socketcan@hartkopp.net,
 linux-can@vger.kernel.org
Subject: Re: [PATCH net] net: validate veth and vxcan peer ifindexes
Message-ID: <20230821104844.19dd4563@kernel.org>
In-Reply-To: <ZOI6bf86B1fVb1sF@shredder>
References: <20230819012602.239550-1-kuba@kernel.org>
	<ZOI6bf86B1fVb1sF@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Aug 2023 19:08:13 +0300 Ido Schimmel wrote:
> There is another report here [1] with a reproducer [2]. Even with this
> patch, the reproducer can still trigger the warning on net-next. Don't
> we also need to reject a negative ifindex in the ancillary header? At
> least with the following diff the warning does not trigger anymore:

Yeah, definitely, please go ahead and submit.

Is "ancillary header" used more commonly as a term? in gnel we usually
call this thing "user header" or "fixed header".

