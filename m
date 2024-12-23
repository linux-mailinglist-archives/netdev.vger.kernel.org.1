Return-Path: <netdev+bounces-154067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8399FB0D0
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 16:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A85D47A1922
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 15:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC50116F27E;
	Mon, 23 Dec 2024 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyHU54zq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81524182BC;
	Mon, 23 Dec 2024 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734968397; cv=none; b=ub9sqvt7ARrHNpS/WNIn1uuVkQgdL2EtgP3nqDPSBwF0EGAbQizIGL+cUIP56+O40kWQsnEIzvfBGkESuNfpRXKYYYUMzJvTUUFwMMv8sB0vkHK+0o+CiFmzyTpHY7Yl+aIiwDUEwvzGEfyOxeD5+JoIktYdTYO+8FHNtD6CTEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734968397; c=relaxed/simple;
	bh=/1Sxk9XIGSS8M7LWWtrUyTRyk9Rn/I2N2tHQep52EXo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJu0TZ5TdNoR5fKQbYm7nq4xtRzk9PdB6zWXmBQ99FK+Pdj5F7I10I5nlzp9WkZpI9H77zFzO0/uuyNFIpOpXNEel87d9GU4QKgK5+Q7frqTSsZ2A6CuhwGdydQSFFHeVXHfEgszxCndfLZ2uUSB9xF6yu6xGqQqEVt2dOnhZV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyHU54zq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A74C4CED3;
	Mon, 23 Dec 2024 15:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734968397;
	bh=/1Sxk9XIGSS8M7LWWtrUyTRyk9Rn/I2N2tHQep52EXo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KyHU54zqQRMvMlpXJSEjIKxRBEmGwoMpB7thcLTaBrirc3OPfCnXXpf3lZvkU4y+9
	 o6o1fPdhe7/FMwUBgq5MI+jve+Puz9m/ImjXV9o4Qc1teRucHOXknWGWPyKz6a/OZ1
	 UMhuUSYESIxTIy46ypNVBrNYl7eYqfrHYcnfhyJsrVK5mrkU9xYCbXQNEr7bpeKgSs
	 yJQGd3t6jj0L5JTxNVAGgmR1FE0QZIVxv9geGJxODzihm6OgQmBOQCpjm+qsRyINAG
	 M8l4II26Z+9fvxVIoaK5enJhbKRUo6qUqoeouUTXFTM999AWygCEBhUgSg4EFLxLBF
	 zXskI6TfUW7Ig==
Date: Mon, 23 Dec 2024 07:39:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: <andrew+netdev@lunn.ch>, <cai.huoqing@linux.dev>, <corbet@lwn.net>,
 <davem@davemloft.net>, <edumazet@google.com>, <gongfan1@huawei.com>,
 <guoxin09@huawei.com>, <helgaas@kernel.org>, <horms@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <meny.yossefi@huawei.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
 <shenchenyang1@hisilicon.com>, <shijing34@huawei.com>,
 <wulike1@huawei.com>, <zhoushuai28@huawei.com>
Subject: Re: [PATCH net-next v01 1/1] hinic3: module initialization and
 tx/rx logic
Message-ID: <20241223073955.52da7539@kernel.org>
In-Reply-To: <20241222081225.2543508-1-gur.stavi@huawei.com>
References: <20241220132413.0962ad79@kernel.org>
	<20241222081225.2543508-1-gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Dec 2024 10:12:25 +0200 Gur Stavi wrote:
> > On Thu, 19 Dec 2024 11:21:55 +0200 Gur Stavi wrote:  
> > > +config HINIC3
> > > +	tristate "Huawei Intelligent Network Interface Card 3rd"
> > > +	# Fields of HW and management structures are little endian and will not
> > > +	# be explicitly converted  
> >
> > This is a PCIe device, users may plug it into any platform.
> > Please annotate the endian of the data structures and use appropriate
> > conversion helpers.
> 
> This is basically saying that all drivers MUST support all architectures
> which is not a currently documented requirement.
> As I said before, both Amazon and Microsoft have this dependency.
> They currently do not sell their HW so users cannot choose where to plug
> it, but they could start selling it whenever they want and the driver will
> remain the same.
> The primary goal of this driver is for VMs in Huawei cloud, just like
> Amazon and Microsoft. Whether users can actually buy it in the future is
> unknown.
> 
> for the record, we did start at some point to change all integer members
> in management structures to __leXX and use cpu_to_le and le_to_cpu.
> There are hundreds of these and it made the code completely unreadable.
> 
> And since we do not plan to test the driver on POWER or ARM big endian I
> really don't see the point.

I understand. But I'm concerned about the self-assured tone of the 
"it's not supported" message, that's very corporate verbiage. Annotating
endian is standard practice of writing upstream drivers. It makes me
doubt if you have any developers with upstream experience on your team
if you don't know that. That and the fact that Huawei usually tops 
the list of net-negative review contributors in netdev.

