Return-Path: <netdev+bounces-17761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21793752FF4
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 05:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF4328201C
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 03:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435F11C08;
	Fri, 14 Jul 2023 03:28:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ABF187A
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 03:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECDFC433C7;
	Fri, 14 Jul 2023 03:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689305308;
	bh=2xj8F0S6TzwUbEUnsVNE1YC34zaDXKl959eBBMlj52s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J9M4mF9jlTs29Tku+qyUmRi0yvEnNSyQttTlGjlCjm3nIvIM6qvY1GekaAEVY+M54
	 Ek8S1m+5OJoc7ZHsJ/sSOiuSDZLDz6KBNDGIw6VV06aR18RAPYnzAqK1pFaFspPLi5
	 zLRQdLy8GmCSDN41biWTzUBF6HfAjYaMgrw/6l2VCRQmq109qAUXVPCudZ18Mhs3oG
	 DSd8ul0FpLW4wqJgcVKKMDg9pQCEmjVTz2oaOPnkaWT0jHU9gnH0nekSlTxQMJ8eEo
	 HwritwpbLXtxHm5wbqDbyKLnyryihOd50frFNT8/nOXeyG3APooRSLQNlgw12jPtOp
	 PJUKnH3Sb4akg==
Date: Thu, 13 Jul 2023 20:28:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <willemdebruijn.kernel@gmail.com>, <andrew@lunn.ch>,
 <sgoutham@marvell.com>, <lcherian@marvell.com>, <gakula@marvell.com>,
 <jerinj@marvell.com>, <sbhatta@marvell.com>, <naveenm@marvell.com>,
 <edumazet@google.com>, <pabeni@redhat.com>, <jhs@mojatatu.com>,
 <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>, <maxtram95@gmail.com>,
 <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: Re: [net-next Patchv2 0/3] support Round Robin scheduling
Message-ID: <20230713202826.52cb8389@kernel.org>
In-Reply-To: <20230713060111.14169-1-hkelam@marvell.com>
References: <20230713060111.14169-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jul 2023 11:31:08 +0530 Hariprasad Kelam wrote:
> octeontx2 and CN10K silicons support Round Robin scheduling. When multiple
> traffic flows reach transmit level with the same priority, with Round Robin
> scheduling traffic flow with the highest quantum value is picked. With this
> support, the user can add multiple classes with the same priority and
> different quantum in htb offload.

Please extend the driver documentation appropriately, there's 
a "Setup HTB offload" section which only shows strict prio now.
-- 
pw-bot: cr

