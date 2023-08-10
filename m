Return-Path: <netdev+bounces-26460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B570777E30
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9D21C2165B
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 16:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2323720F99;
	Thu, 10 Aug 2023 16:26:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151C91E1D2
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 16:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB52C433C7;
	Thu, 10 Aug 2023 16:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691684791;
	bh=PLPnIFk3ITvkeqRC6SfEJPLCPJ/y0ZeEHIWOWpjo5dk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QemTnpP0JmToWpYcZxplHbiGYvfYs4gybItzpa4gzs3eNSO3s2gDEWx+arnKQPgz3
	 QJVZTTXuwONIoRucWygOE9x4wahbOuFqVX0mBjMb6D3rIzKqB6kg+dPL2EZH3PKRSG
	 B+pr00mqquRjUR+sHHlgS6ravXh9nfKr5lM/ZODwCqi8bnVuQCDJNz7wUm/em+DF6b
	 4a2ruuvveKre6aG8bZfAPol/F0LJUHiRDnyg9aaZN//b08Lb/wbp9wkUdx/pqNSqjT
	 Mjj+BsF5xwlS8a/+vwUGNxDweJmVN0F7AOl3lj/Me/qApLvSQSYQARM5iOyY+Gh/LN
	 5W+KwsBCntQCA==
Date: Thu, 10 Aug 2023 09:26:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: <linus.walleij@linaro.org>, <alsi@bang-olufsen.dk>, <andrew@lunn.ch>,
 <f.fainelli@gmail.com>, <olteanv@gmail.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <clement.leger@bootlin.com>,
 <ulli.kroll@googlemail.com>, <kvalo@kernel.org>,
 <bhupesh.sharma@linaro.org>, <robh@kernel.org>, <elder@linaro.org>,
 <wei.fang@nxp.com>, <nicolas.ferre@microchip.com>,
 <simon.horman@corigine.com>, <romieu@fr.zoreil.com>,
 <dmitry.torokhov@gmail.com>, <netdev@vger.kernel.org>,
 <linux-renesas-soc@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH net-next v2 0/5] net: Remove redundant of_match_ptr()
 macro
Message-ID: <20230810092629.47d47537@kernel.org>
In-Reply-To: <20230810081656.2981965-1-ruanjinjie@huawei.com>
References: <20230810081656.2981965-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Aug 2023 16:16:51 +0800 Ruan Jinjie wrote:
> Changes in v2:
> - Correct the subject prefix: patch -> PATCH 

Cool, now Linus replies to v1 with his acks and you've wasted everyone's
time. If only we didn't have rules about reposting.. oh wait:

Quoting documentation:

  Resending after review
  ~~~~~~~~~~~~~~~~~~~~~~
  
  Allow at least 24 hours to pass between postings. This will ensure reviewers
  from all geographical locations have a chance to chime in. Do not wait
  too long (weeks) between postings either as it will make it harder for reviewers
  to recall all the context.
  
  Make sure you address all the feedback in your new posting. Do not post a new
  version of the code if the discussion about the previous version is still
  ongoing, unless directly instructed by a reviewer.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#resending-after-review


I'm throwing your series out.
Resend next week with all the tags included.
-- 
pw-bot: cr

