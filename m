Return-Path: <netdev+bounces-47148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 908977E83E2
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 21:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16021C20B48
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 20:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545D93B2AB;
	Fri, 10 Nov 2023 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4fy5nMj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3992F3B7B4
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 20:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE25C433C9;
	Fri, 10 Nov 2023 20:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699648654;
	bh=Gstp9yb61OjsTuHdpm83SN/hPjjO5FW+SEuM0791eZQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y4fy5nMj8Rzgkjiieh+wEpbAA1v5K1FVdZlRte9lQ1mT4VjhzMMbLlmWYv81gVTGT
	 WW/uGbm+GBjrUquEJlpe7dhFBUbokGw5g8M/yuSmqNFMN9Pk48ebCh6dfOWBTR3bk+
	 cO1Db4pKQd9QbO7Ou0ubLc7NucXVupnKg/0yAvpn1Z3SY+AKOMNoDrJWMNAHDi+/rt
	 faIrmStpuLTXooDGsBL9hDanXwi+QVJlPGn8/decvcwUydszl7QOIZHAg3w7H52pt1
	 6kQpTwc1PNRlRwPGmHH/W9CRc/aAoOV31KiomD3olDvSokRtW5WWcZGByFU2l7r05K
	 vAucJEIphC33g==
Date: Fri, 10 Nov 2023 12:37:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: <alexey.pakhunov@spacex.com>
Cc: <mchan@broadcom.com>, <vincent.wong2@spacex.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <siva.kallam@broadcom.com>, <prashant@broadcom.com>
Subject: Re: [PATCH v2 1/2] tg3: Move the [rt]x_dropped counters to tg3_napi
Message-ID: <20231110123733.42f31ddb@kernel.org>
In-Reply-To: <20231110002340.3612515-1-alexey.pakhunov@spacex.com>
References: <20231110002340.3612515-1-alexey.pakhunov@spacex.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Nov 2023 16:23:39 -0800 alexey.pakhunov@spacex.com wrote:
> +		for (i = 0; i < TG3_IRQ_MAX_VECS; ++i)
> +		{

checkpatch says:

ERROR: that open brace { should be on the previous line 
-- 
pw-bot: cr

