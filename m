Return-Path: <netdev+bounces-211274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F60B1772D
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 22:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469781C240C1
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 20:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9056F2550CF;
	Thu, 31 Jul 2025 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kokyeCcp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F4B23C4E6;
	Thu, 31 Jul 2025 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753993892; cv=none; b=IrawvuOWqscC7l8Y7UJ6nN3EOywP+oEAU4ooURd1JWj/Bt+kS/Fd+mpur3J3YcJlzMzBF08TSBc1RAYA/uzuTTtQt7smSVUkhh7AWnHDJHmdNXMz229lC2myLqUp/ES6EITk5qpQw2CzNAUjiIvlBm9KpLKF/3uN1k72d/RmxLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753993892; c=relaxed/simple;
	bh=Lf39aKIK+Wi8Gtf922wlnQNbCXTgqYiV4+0YQZJFf3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apbWYK/z1uLm2JP+NhVRZQv3cbJKXdusM+hUybYKvCwLi7G+BbvUr9uUb9Ai/NG+3FpavH3Eq+PDSjUoMRHf58JzA5gTeSRVA8ZWSYXiMqycICx/LslUocrKc4d+7q6HpvXPc+Uj4FflnjOg9O2BhCtFBIpXqW+PtxxD1+YyLsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kokyeCcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11137C4CEEF;
	Thu, 31 Jul 2025 20:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753993891;
	bh=Lf39aKIK+Wi8Gtf922wlnQNbCXTgqYiV4+0YQZJFf3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kokyeCcpna9aZUCilkj4+R2eDTrhga0wIlwIcLnsZeITMhyJUj/7uTWNmFUTFHMvt
	 vDpiXZSwUk1voxowgvC8U99LMZhDIWLb9rCZ0gPBvSaSTlC9/PiF1ZkvfBUWRTXoV4
	 geGjVfX0r0Mn1a/kBPCUN2PppB/o/Inx7MR+nc2IF9zk4Uz4N24Hggha7iqk1csUpd
	 6Ef6tss7kWpSzSOZQH3wQU6TdUTlWragCOmCnqL1IDMXdPNxH9wUoI8tgXMtFHH+2y
	 +ZReiMKR5PteVyTJwEwl4z2jPWje9d/K6wdslpCydHIxGZ3tQ7TZj60qHsrUqNB+/X
	 YUNtf5hZWJlYw==
Date: Thu, 31 Jul 2025 21:31:24 +0100
From: Simon Horman <horms@kernel.org>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: andrew+netdev@lunn.ch, christophe.jaillet@wanadoo.fr, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, fuguiming@h-partners.com,
	gongfan1@huawei.com, guoxin09@huawei.com, helgaas@kernel.org,
	jdamato@fastly.com, kuba@kernel.org, lee@trager.us,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	luosifu@huawei.com, meny.yossefi@huawei.com, mpe@ellerman.id.au,
	netdev@vger.kernel.org, pabeni@redhat.com,
	przemyslaw.kitszel@intel.com, shenchenyang1@hisilicon.com,
	shijing34@huawei.com, sumang@marvell.com, vadim.fedorenko@linux.dev,
	wulike1@huawei.com, zhoushuai28@huawei.com,
	zhuyikai1@h-partners.com
Subject: Re: [PATCH net-next v10 1/8] hinic3: Async Event Queue interfaces
Message-ID: <20250731203124.GI8494@horms.kernel.org>
References: <20250731140404.GD8494@horms.kernel.org>
 <20250731183420.1138336-1-gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731183420.1138336-1-gur.stavi@huawei.com>

On Thu, Jul 31, 2025 at 09:34:20PM +0300, Gur Stavi wrote:
> > On Thu, Jul 31, 2025 at 03:58:39PM +0300, Gur Stavi wrote:

...

> > Thanks, I think I am closer to understanding things now.
> >
> > Let me try and express things in my own words:
> >
> > 1. On the hardware side, things are stored in a way that may be represented
> >    as structures with little-endian values. The members of the structures may
> >    have different sizes: 8-bit, 16-bit, 32-bit, ...
> >
> > 2. The hardware runs the equivalent of swab32_array() over this data
> >    when writing it to (or reading it from) the host. So we get a
> >    "byte jumble".
> >
> > 3. In this patch, the hinic3_cmdq_buf_swab32 reverses this jumbling
> >    by running he equivalent of swab32_array() over this data again.
> >
> >    As 3 exactly reverses 2, what is left are structures exactly as in 1.
> >
> 
> Yes. Your understanding matches mine.

Great. Sorry for taking a while to get there.

> > If so, I agree this makes sense and I am sorry for missing this before.
> >
> > And if so, is the intention for the cmdq "coherent structs" in the driver
> > to look something like this.
> >
> >    struct {
> > 	u8 a;
> > 	u8 b;
> > 	__le16 c;
> > 	__le32 d;
> >    };
> >
> > If so, this seems sensible to me.
> >
> > But I think it would be best so include some code in this patchset
> > that makes use of such structures - sorry if it is there, I couldn't find
> > it just now.
> >
> > And, although there is no intention for the driver to run on big endian
> > systems, the __le* fields should be accessed using cpu_to_le*/le*_to_cpu
> > helpers.
> 
> There was a long and somewhat heated debate about this issue.
> https://lore.kernel.org/netdev/20241230192326.384fd21d@kernel.org/
> I agree that having __le in the code is better coding practice.
> But flooding the code with cpu_to_le and le_to_cpu does hurt readability.
> And there are precedences of drivers that avoid it.
> 
> However, our dev team (I am mostly an advisor) decided to give it a try anyway.
> I hope they manage to survive it.

Thanks, I appreciate it.
I look forward to reviewing what they come up with.

