Return-Path: <netdev+bounces-58170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C196481564B
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 03:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3FA71C23DA3
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 02:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4A515BB;
	Sat, 16 Dec 2023 02:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYtK3mce"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293EB185A;
	Sat, 16 Dec 2023 02:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13295C433C7;
	Sat, 16 Dec 2023 02:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702692644;
	bh=j/voS/7d34MytfDrCELADQRaybMJaIlqQDl1Natue7s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LYtK3mceYHV0FksWDJo92BP8wiZyXjWc3vQ9aChfjsBTEmREMJkIjEKRS83RjFHZv
	 f7hmJ9hhBDx+Y6neOskMWcCkpac95F/kaQMpmLZEGhz4oeigrjYEayPLtNR6StARVs
	 Rd4KMdRbLJZL28Abhbwp7KDyR3DL6wFZm2XvMuWI7R6a72N4J366l3E0nrCFvzZZEj
	 hlJJSAF3vZ8olTZiMWK+/rCnhZA3GfrPC5HD9Yp6mBI/aekTvyoQ1wkeboWbDoWezI
	 9OGr0lSNCGEwVlB+cgljJIiicXX04CurJoPPdQeBjjURpQbmsmfLP/RFsaxq60n3qj
	 UECv1+Apq1XaQ==
Date: Fri, 15 Dec 2023 18:10:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wang Jinchao <wangjinchao@xfusion.com>
Cc: Sunil Goutham <sgoutham@marvell.com>, Linu Cherian
 <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Jerin Jacob
 <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>, Subbaraya Sundeep
 <sbhatta@marvell.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stone.xulei@xfusion.com>
Subject: Re: [PATCH] net: devlink: insert space after include
Message-ID: <20231215181043.4ed733cf@kernel.org>
In-Reply-To: <202312151404+0800-wangjinchao@xfusion.com>
References: <202312151404+0800-wangjinchao@xfusion.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Dec 2023 14:04:52 +0800 Wang Jinchao wrote:
> Subject: [PATCH] net: devlink: insert space after include

Please repost with subject changed to:

[PATCH net-next v2] octeontx2-af: insert space after include

Please keep Subbaraya's review tag.
-- 
pw-bot: cr

