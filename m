Return-Path: <netdev+bounces-139942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A159B4C1E
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 15:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD934B228B9
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 14:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5AF2071E7;
	Tue, 29 Oct 2024 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkxPuELr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7458D206E9A;
	Tue, 29 Oct 2024 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730212441; cv=none; b=lsydLRnJoLC42hLgcAlH9Xkc9QGDBd0Q1DcRUXuZq8z3UWTHGbLYNO0gRj88rHbwbpMbHyG+xwmSIgwUkCzyoMUpSP5VLN8hMghDAM/kknpibrA8rrx1CUp4+mkS8iywtKeQjuoDFaddvF04YorgJGW8rt5zuAeS2bKTcOzH9Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730212441; c=relaxed/simple;
	bh=ZgRDBxxipce3Y8hxkR7nbzY7ay8WuNC5fEu1E9gRWrs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P1L8ikThnljxKuw99uyTc4RXsyrLRm0xa2f2CXCLWLwe0mr1aN9SxyBmehZx4QLmXTOdGTNE+XUMXS5F+Ga2jDSpv/7ue37FsgLrPk2eJsT1GK5/93CKKUl2KKDNuAwkLLo6+uM9iS/pEUdAXv36RgHRn4s4lOIVO5hPd2aSdX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkxPuELr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC49C4CEE5;
	Tue, 29 Oct 2024 14:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730212441;
	bh=ZgRDBxxipce3Y8hxkR7nbzY7ay8WuNC5fEu1E9gRWrs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JkxPuELr1EWeQShx94jBdw0CeKJInjUHexPO/bBCOpG/27LZgh2OO+9fNeWXrwDIG
	 GAaCLNiyC94thkTM4Eq6Nbbhr2gT5jN46J7xCzFQloN6PLX0w29ZaNLn10f15BkLxt
	 JRfFfWxyjqa9xC/lH0pf3okSLMeQXEHgnLPb9as2vojcbCYybSlSuezSGZ1F9MiZnt
	 Z4oo+GukFt1UW6q3RnTRsXngJi45H4i06ALF9dkvRzAZYPX1uabogE7xEEyt4C+4rU
	 mWre5fIJYL2W68mAjmWkp+kfqn+Xm3bK//Tn9yuBLSimJc+xKXEjBAsll02/9z4dxk
	 TmZvFp6z+MASQ==
Date: Tue, 29 Oct 2024 07:33:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Alexander Duyck
 <alexander.duyck@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH RFC 10/10] mm: page_frag: add an entry in MAINTAINERS
 for page_frag
Message-ID: <20241029073359.758d9b84@kernel.org>
In-Reply-To: <06933039-a330-4ed9-9db1-9c75cd7ae9b7@huawei.com>
References: <20241028115850.3409893-1-linyunsheng@huawei.com>
	<20241028115850.3409893-11-linyunsheng@huawei.com>
	<20241028162743.75bfd8a1@kernel.org>
	<06933039-a330-4ed9-9db1-9c75cd7ae9b7@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Oct 2024 17:40:08 +0800 Yunsheng Lin wrote:
> On 2024/10/29 7:27, Jakub Kicinski wrote:
> > On Mon, 28 Oct 2024 19:58:50 +0800 Yunsheng Lin wrote:  
> >> +M:	Yunsheng Lin <linyunsheng@huawei.com>  
> > 
> > Why is this line still here? You asked for a second opinion
> > and you got one from Paolo.  
> 
> Because of the reason below?
> https://lore.kernel.org/all/159495c8-71be-4a11-8c49-d528e8154841@huawei.com/

What is the reason in that link? You try to argue that the convention
doesn't exist or that your case is different? The maintainer tells you
their opinion in context of the posting.

It seems like you're more motivated by getting into MAINTAINERS than
by the work itself :/

