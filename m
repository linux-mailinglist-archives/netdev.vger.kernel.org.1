Return-Path: <netdev+bounces-25054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30766772CB3
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61EFB1C20C5E
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 17:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E253814AB3;
	Mon,  7 Aug 2023 17:22:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D7614AAB
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 17:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A9BC433C8;
	Mon,  7 Aug 2023 17:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691428937;
	bh=Btos6yEe/pTyrhgNSa9UQH62RHapqhrdMCY/H1ZIIUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nb8VGOo1PMsc4g0x+peqbaUowavB9SZT+KJAn6EZYprxEAVjjjIGOhlCPhxlVGJZD
	 m71ht22A38Zpohb3HnKzamiFKfYd/us+Ra8OHo7pSvj9B7ZpRXTsuwpMYsbEH2jIne
	 jXdFKZwyaMr0QuiP0YfGCY+lRyHVy4VMsrtM1QqLBAMVMqqkFEqiTm52rG54vYdUra
	 D56s0L+xh6cLY48aVEEeehrMWplwQmbq1RQvaLrJm1I+1AK5IZcVIM7w6wBKrND6Am
	 JVPLMdpu1Db7IKiW0HgBu9ehielZxrocv5XBfbYaumlal/sDXWSkGs9933/AHHuElq
	 tb2OBuRmIK1vQ==
Date: Mon, 7 Aug 2023 10:22:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xinyu Liu <LXYbhu@buaa.edu.cn>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 baijiaju1990@gmail.com, sy2239101@buaa.edu.cn,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [BUG]Bluetooth: possible semantic bug when the status field of
 the HCI_Connection_Complete packet set to non-zero
Message-ID: <20230807102215.75d3322d@kernel.org>
In-Reply-To: <ed32aad7-41c0-c84d-c1f3-085a4d43ce09@buaa.edu.cn>
References: <ed32aad7-41c0-c84d-c1f3-085a4d43ce09@buaa.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 5 Aug 2023 12:35:25 +0800 Xinyu Liu wrote:
> Our fuzzing tool finds a possible semantic bug in the Bluetooth system 
> in Linux 6.2

Sorry this is independent from your report.
Why are you fuzzing 6.2? It's end of life. Even 6.3 is at this point.
Please use latest kernels in your testing.

