Return-Path: <netdev+bounces-119030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 904BF953E4E
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 02:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4A71F246E5
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 00:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B984320E3;
	Fri, 16 Aug 2024 00:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FaXvtjlq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CF91FA5;
	Fri, 16 Aug 2024 00:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723768629; cv=none; b=rWZNH5btEQ5mK5tFWuyTYRnnVI3Q6uLDCODBdgNbbrEO8G6mtaCb11U/kSRXhITUnFw5+ZBWTTN99w+76N7vf6394BoeHhyYCpnH6hZpuW9TAgSDVW0JEjUQ3M6wjMe9WILt8IKzFeCTr72fUuk+APeTtIeDMA8aNslx9SU/13c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723768629; c=relaxed/simple;
	bh=ULzfBCGg6wuKC5BIwcGAFmP3GK+4G7WdylWO7cT6tTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/0++3YaDLFDsbn9gcY8BVlpCzEVOO0LU944ZbDfxGXTgPDUAzFVhNmwCNK/GfgznjPuEVKQ8U7qC+3fbkJ12+SN9QLwpffcnCAWrfgd7bPcPrxGleSlpHrYb3hIGDGIf1GPZk4RXsMkBHOf1KfH3mJYD4xNcquoqScrqS+XoTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FaXvtjlq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MFAHxuwL7ZbIHZ/noLpTELlYwVWnBfa1zy/ROrn1hhI=; b=FaXvtjlqz9b+nmX3t/L5zzEpiA
	IghYNbZY57uAjR8MuUjfi/Aa6oqxdym5gFbLSy6SC81KtlZ7XY0tFpiBeUHW6P7oIQQ6/qiz7CrVY
	9OgJzwm3n8vwPOqp6W1mZv3YURfhep4iQ2wOo+NgxZyCOy05UWnf/Lz0R2x05/j7jBAA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sekxi-004snJ-Ez; Fri, 16 Aug 2024 02:37:02 +0200
Date: Fri, 16 Aug 2024 02:37:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, aliceryhl@google.com
Subject: Re: [PATCH net-next v3 1/6] rust: sizes: add commonly used constants
Message-ID: <6b12ed3a-d846-41ff-9821-a3946bb88378@lunn.ch>
References: <20240804233835.223460-1-fujita.tomonori@gmail.com>
 <20240804233835.223460-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804233835.223460-2-fujita.tomonori@gmail.com>

On Mon, Aug 05, 2024 at 08:38:30AM +0900, FUJITA Tomonori wrote:
> Add rust equivalent to include/linux/sizes.h, makes code more
> readable.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Your Signed-off-by: should come last. That keeps it together with the
others added by Maintainers as they handle the patch on its way to
mainline.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

