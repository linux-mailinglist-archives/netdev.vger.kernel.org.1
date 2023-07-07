Return-Path: <netdev+bounces-16013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E597674AF0C
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 12:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1161C20F7B
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 10:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51EABE77;
	Fri,  7 Jul 2023 10:51:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405FBBA47
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 10:51:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABADC433C8;
	Fri,  7 Jul 2023 10:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1688727090;
	bh=dMjQvPWxzVC76cHGIJsn2XnTQOoQzkZMZV+Gp6SjNoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DzXWq+TsLd9+UoSFGQPsmq3hgM4LcY9udSFATS9UWuXZiFNJWyB3yGhLH7RM4CS3l
	 9KnIQzdut1CSiROHnyHybMwykGtwNtpvZxhABiQgFqpj9OjaVHaGo2rnD77OuC49hV
	 1TRpdcEC8jDYEl6uSbrXQ3usPjzg2JnOKsHPoT34=
Date: Fri, 7 Jul 2023 11:16:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
	sharmaajay@microsoft.com, leon@kernel.org, cai.huoqing@linux.dev,
	ssengar@linux.microsoft.com, vkuznets@redhat.com,
	tglx@linutronix.de, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, stable@vger.kernel.org,
	schakrabarti@microsoft.com
Subject: Re: [PATCH V2 net] net: mana: Configure hwc timeout from hardware
Message-ID: <2023070734-skimming-snack-838c@gregkh>
References: <1688723128-14878-1-git-send-email-schakrabarti@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688723128-14878-1-git-send-email-schakrabarti@linux.microsoft.com>

On Fri, Jul 07, 2023 at 02:45:28AM -0700, Souradeep Chakrabarti wrote:
> At present hwc timeout value is a fixed value.
> This patch sets the hwc timeout from the hardware.

This really does not describe what is happening here.  Please read the
documentation for how to write a good changelog text.

> 
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> ---
> V1 -> V2:
> * Added return check for mana_gd_query_hwc_timeout
> * Removed dev_err from mana_gd_query_hwc_timeout

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

