Return-Path: <netdev+bounces-222666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E40F8B554E1
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 18:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A503FAC294B
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 16:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E0131CA51;
	Fri, 12 Sep 2025 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZNkjFMp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7424430ACF9;
	Fri, 12 Sep 2025 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757695494; cv=none; b=qk9ybcT+GUaGC4CCSH7Oxg82TzcgH6wBDAv923EuRH+rr+LC2bmspY3FM2CSoGJACtnYohhJHMrkIGGFirk7ccgLwLm1u5l7sGQzfPC/DIGw8LT6VwbC/xLggufOEwmW8FZ2m1wmCjFfJ4SljqOeBJh39wBKTKOViWUPYP5Uew8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757695494; c=relaxed/simple;
	bh=T3k8yXx71WmXCOcPeK8TWijLJrnwnPMe6SmbiBr3OtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbwxKghsr/bwZMmisJKohZkLCTnQIRdA5RFMp9VtuiHphF5A0Dyrr8hG5HkN1LJqI9vfJF7YI/2n5eqXt5N7NKIObMaYwaR0HoQFIJmfsGN5bwvooupNLDsCQ9pCZKQFU0LbDyLwv5B7tbOD4a/kNeNGEEzXePbGt/DiYoOdGJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZNkjFMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095D9C4CEF1;
	Fri, 12 Sep 2025 16:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757695494;
	bh=T3k8yXx71WmXCOcPeK8TWijLJrnwnPMe6SmbiBr3OtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TZNkjFMplEJXcSxt1g922eJbDuHFdtPelJyYXhh+Yt2AuKAX/lTgEtSRnHeht4LnN
	 PtnVtsYwUw5mzq+D8HreufB1OXMoZT/EQXqJiqcM/uIaPpuVz5DMddIzuz00+2scAd
	 dmdH0c45mBkpsPeM604mXr9h7GkFVDQP0J2uV27FZzCtjQVf+VD5Zy7F2YypKxsICm
	 0pvDfnDEW1QtS/WGeL8CW8CbyOWbNEEwTHNPN1A88a11RLp7xVe6EvUBQb14RasyPn
	 VnznBWomfmKptx6SqPqhaukbxkAwTBGs8LqyIhOJiceINXjw0dsPcWzcXrMq48Q57i
	 IujrPXbnn4+1Q==
Date: Fri, 12 Sep 2025 17:44:46 +0100
From: Simon Horman <horms@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: andrew+netdev@lunn.ch, christophe.jaillet@wanadoo.fr, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, guoxin09@huawei.com,
	gur.stavi@huawei.com, helgaas@kernel.org, jdamato@fastly.com,
	kuba@kernel.org, lee@trager.us, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, luosifu@huawei.com,
	luoyang82@h-partners.com, meny.yossefi@huawei.com,
	mpe@ellerman.id.au, netdev@vger.kernel.org, pabeni@redhat.com,
	przemyslaw.kitszel@intel.com, shenchenyang1@hisilicon.com,
	shijing34@huawei.com, sumang@marvell.com, vadim.fedorenko@linux.dev,
	wulike1@huawei.com, zhoushuai28@huawei.com,
	zhuyikai1@h-partners.com
Subject: Re: [PATCH net-next v05 12/14] hinic3: Add port management
Message-ID: <20250912164446.GA224143@horms.kernel.org>
References: <20250911123324.GJ30363@horms.kernel.org>
 <20250911142504.2518-1-gongfan1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911142504.2518-1-gongfan1@huawei.com>

On Thu, Sep 11, 2025 at 10:25:04PM +0800, Fan Gong wrote:
> On 9/11/2025 8:33 PM, Simon Horman wrote:
> 
> > > +	err = hinic3_get_link_status(nic_dev->hwdev, &link_status_up);
> > > +	if (!err && link_status_up)
> > > +		netif_carrier_on(netdev);
> > > +
> > > +	return 0;
> > > +
> > > +err_flush_qps_res:
> > > +	hinic3_flush_qps_res(nic_dev->hwdev);
> > > +	/* wait to guarantee that no packets will be sent to host */
> > > +	msleep(100);
> > 
> > I realise that Jakub's feedback on msleep() in his review of v3 was
> > in a different code path. But I do wonder if there is a better way.
> 
> ...
> 
> > > +	hinic3_flush_txqs(netdev);
> > > +	/* wait to guarantee that no packets will be sent to host */
> > > +	msleep(100);
> > 
> > Likewise, here.
> 
> Thanks for your review, Simon.
> 
> Firstly, The main issue on the code of Jakub's feedback on msleep() is
> duplicate code function. The msleep() in hinic3_vport_down and
> hinic3_free_hwdev is repetitive because of our oversight. So we removed
> msleep() in hinic3_free_hwdev in v04 patch.
> 
> Secondly, there is no better way indeed. As our HW bad decision, HW 
> didn't have an accurate way of checking if rq has been flushed. The
> only way is to close the func & port . Then we wait for HW to process
> the pkts and upload them to driver. 
> The sleep time is determined through our testing. The two calls of
> msleep() are the same issue.

Thanks for the clarification, much appreciated.

> Finally, we have received your reviews on other patches and we will
> fix them soon in the next version.
> 

