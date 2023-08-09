Return-Path: <netdev+bounces-26099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B437776C8F
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 01:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0223D280EF6
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 23:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB631DDF4;
	Wed,  9 Aug 2023 23:05:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6391D2F0
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 23:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99407C433C7;
	Wed,  9 Aug 2023 23:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691622319;
	bh=XFaiJ6avOsTBWBsdzJRuTwDyB4qodJIkgKELloezsqQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O7JVYN4pARn+CN2OFra3AoP3IPt0GV3V2QhCHq2wT07/MP4izAJcB4Zn/JqXq1C/N
	 0d9ZmI3hXKl6Z3Bw8/1mdC2l9PWUQD1R4EmzmINjnsprtjNissqnscb+TFn4fXzRyf
	 XPsXWfGqK9ZH5ko1DCASVOGpoYXU6j8p2rqkMjx+YxvcGO4pMTSSAtqguLUe7YBJYg
	 vcHrCbPtfBfFMzOYqMa/ISXCH2pebWKCC+NltgTbPznHVl+TScVV9yjsXYwFxk5HdU
	 sru3NUNFMIa8ZvJ5qLbDDApF12tJsQb+oaVexJJjBfzY45bI47dowoG0+SLMenGXCY
	 uPuqax3Z3evqg==
Date: Wed, 9 Aug 2023 16:05:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
 <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
 <jerinj@marvell.com>
Subject: Re: [net PATCH V2 1/4] octeontx2-pf: Update PFC configuration
Message-ID: <20230809160517.7ff84c3b@kernel.org>
In-Reply-To: <20230809070532.3252464-2-sumang@marvell.com>
References: <20230809070532.3252464-1-sumang@marvell.com>
	<20230809070532.3252464-2-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Aug 2023 12:35:29 +0530 Suman Ghosh wrote:
> +		otx2_stop(dev);
> +		otx2_open(dev);

If there is any error in open() this will silently take the interface
down. Can't you force a NAPI poll or some such, if the concern is a
missed IRQ?
-- 
pw-bot: cr

