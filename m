Return-Path: <netdev+bounces-221921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BF2B525DF
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D502687051
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEB1219A8E;
	Thu, 11 Sep 2025 01:39:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5B41EE02F;
	Thu, 11 Sep 2025 01:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.80.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757554757; cv=none; b=niYfBJA5zSsEJoJ0D8ML2iCXjZD4UhgRnqCS+4AmUc6oOobkeaJ/XRUBKIElapwxcvnZVy+8LX+LgfPhFN87+HgWQVYfWEy9k9Lq6r5dEDjeNKXshdLErtetRZ5OPO0mOaEixqEU/TlhHqvokOxhqXomnubMTnyBBIga1XsvgyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757554757; c=relaxed/simple;
	bh=eI9zEdBAMXiGmXs4FbK4DweOP/eMGnkLbpnjdy2Bx3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+rGBXs+SsKqx7lviJDzeQCCfxZRcGp9RmK4L860MjxoQ+4nO8ACt9T9EvFWRR5TkzqDPN+lgvnMd0ngF/kMrQLhiQzlsGqmXjm3BQGXW+7g3f5xOpLhXOeiLUJGgzQ0ois2obGVTr+cUu9zod2EHkGb2aogujXYDgX6nYoKcOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=43.155.80.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz9t1757554707t8016020f
X-QQ-Originating-IP: cSbRNIsLa5SmLZiDKzkB/vpZ6MnDPzxvOq3darSzK+M=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 11 Sep 2025 09:38:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6096983397407212890
Date: Thu, 11 Sep 2025 09:38:25 +0800
From: Yibo Dong <dong100@mucse.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Anwar, Md Danish" <a0501179@ti.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net, gur.stavi@huawei.com,
	maddy@linux.ibm.com, mpe@ellerman.id.au, danishanwar@ti.com,
	lee@trager.us, gongfan1@huawei.com, lorenzo@kernel.org,
	geert+renesas@glider.be, Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com, alexanderduyck@fb.com,
	richardcochran@gmail.com, kees@kernel.org, gustavoars@kernel.org,
	rdunlap@infradead.org, vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v11 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <DE99249D4B15AB68+20250911013825.GA1855272@nic-Precision-5820-Tower>
References: <20250909120906.1781444-1-dong100@mucse.com>
 <20250909120906.1781444-4-dong100@mucse.com>
 <54602bba-3ec1-4cae-b068-e9c215b43773@ti.com>
 <20250909135554.5013bcb0@kernel.org>
 <36DC826EE102DC1F+20250910055636.GA1832711@nic-Precision-5820-Tower>
 <20250910180207.2dd90708@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910180207.2dd90708@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NyPaQtJYQgeoV1Z1Je0uGcuGrVaPxCqf2JQ+ej0KcSdw5E4vpOx1d6mi
	+zDE4K7P2ai9aQVlSPd2Qh5B5Lj0v34oWnmaRDXIOlSJh8/tWY0nopih8aY2e8JORBMTJ8K
	Hx4x+WhauN4PwtTQKXWbCqc2Iu3rjWTbawCSwDqRi2dLNM/sT57/BLFchcVEGGIAAecSV35
	UPFhkO3wk5436DGicUJCWDCWxD8Wvp8xln8SSUFuWOQOJ2kuvjjnmDZ/1v7Ug3UIkr/GTNJ
	wOvG+afYFQKQmLL+7tj8zlgGw+RSxMJik2JI4kHqQQOBG6D1oxNVxaxhFslw2swpQFGke3H
	ATpJRKsRDzgZ4R4JFvY7QFI+/Rzt268RstX1fo7qdfblxlEzKb63Sewg2oFA2zMNmP961vn
	wQqjVppBHEjvRaoqBHAoOISpHiyhPHR14nlwZurV01RlWMjZhel/x9Hg6gJdGUiJ0eORj6s
	rZEhKbhC7D2CoqhbTWEGaCx80GRgd+wnlRCl4xjp8jgwBl7l7zLUXDc39ySBX8pXHrO78kv
	4DUCcJNZ1eQx3abgGNnmhiNqSPrArj1RAZwB1F9paI5Vh9CD7gc8Jj8qJbeQ3ofJZQFxIHr
	M6S6+D5ray9BjSykcC8YlxK006dSmp67cTSqD8kNwAfOcDq8H8cf1cgiO3CqOO9s5D7whm3
	o8/83cPZs7qUTXONWEZPMYvOIKSA+jF7MG6aIMLP+zbcq3DBtttJKT+TzgogHmJKtFTht2i
	3ARElzoBqonbTk/vU+5CHMwWJDbmyzdYcb18g8j9ytGmq/Lx5B+bixrWMSLVUXS2KnZ0eKx
	i3UicIlNlEzvEy3rPhLipF0ws1HjGWqkP+spknsK+LYgQGpA8hQOm8CDDyJKGI4n8uEScta
	hUHi9FLwL3REgKjYDPnCQ0tzC/GCP87KGCo3EqimWIRdlCzGFMNWq0vvLJI5sZWEI2gWIRv
	+yq7ZY4Q5fuyDKgNZoqkSKnIBECRgjvyjUcHZ0r4D0KUUFHINLgAY7stbOexJy1wjLIQiTU
	X9C6Q7Ag==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Wed, Sep 10, 2025 at 06:02:07PM -0700, Jakub Kicinski wrote:
> On Wed, 10 Sep 2025 13:56:36 +0800 Yibo Dong wrote:
> > > Not sure this is really necessary, I'd expect C programmers to intuit 
> > > that 4 is the number of bytes in u32 here. sizeof(u32) is going to
> > > overflow 80 char line limit and cause more harm than good.
> > >   
> > 
> > I found similar code in other drivers, ixgbe, it like this:
> > 
> > #define IXGBE_READ_REG_ARRAY(a, reg, offset) \
> >                  ixgbe_read_reg((a), (reg) + ((offset) << 2))
> > 
> >          for (i = 0; i < size; i++)
> >                  msg[i] = IXGBE_READ_REG_ARRAY(hw, IXGBE_PFMBMEM(vf_number), i);
> > 
> > Maybe I should follow that style?
> 
> Personal preference at this stage, but I like your code more.
> 

Ok, then I'll keep this code as it is.

Thanks for your feedback.


