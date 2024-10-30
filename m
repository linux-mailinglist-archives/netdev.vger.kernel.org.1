Return-Path: <netdev+bounces-140371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECCD9B636B
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 13:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6711F21B0E
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 12:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799321E9064;
	Wed, 30 Oct 2024 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qo2TOkH4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0271EABB5
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292846; cv=none; b=aDoneK84CliTCacIwnZgiHOxUThCxafitzFoCr1W5wky2AsXLvPFuEIOcM6NToa4nWNAn5gvp+b/v5TK9vz5IWIJv2LhF2VqHoXBL5YNZ9z2Z6rvU/QH61R562ld0GyWGjQGEHdIjvIqcw7vKdpvgExhITrutRveDk0BteWWcU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292846; c=relaxed/simple;
	bh=gY3utNc+G11mtRzzf218TxZTtTb88RWhXyP6DjfdZ0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxNVoVBOeI/GWx8jsbwQ2Digmnm52/qvvyR3gIPjU+QRXYbRsHvgmIlHHLhI/zD+DKDS+3g8zrLBKEWJcVqEb1yRMUKWt8Xwo23jp2GXz7TvQprfFZWQdgIAraYLNPu3wLsSOeRXQwxC1zuQSBZcR7lv5R1q2LJO2V6O1Es0tzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qo2TOkH4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=dItWcFYknE/+Vk/QyCpbocGx1/1JauNssj+eQSZ2qWk=; b=qo
	2TOkH4b5DyYKDYiwnFdFp7/j8lzq5Vd93zeU7Adlw699VvSOVMEkJ6kGT01m7Z3sDqvuAbmSLEl0c
	y7V6MW8ygTd+JPeIUNEKYthE4Y1G5HFEKk+4zAXY3HJNdiGmUoqD8IUKNdLZY9/CDRjlLPqwvGhf6
	d6ZU798FVA7BvUo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t68D4-00BgiO-0M; Wed, 30 Oct 2024 13:54:02 +0100
Date: Wed, 30 Oct 2024 13:54:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next 04/12] net: homa: create homa_pool.h and
 homa_pool.c
Message-ID: <67c42f72-4448-4fab-aa5d-c26dd47da74f@lunn.ch>
References: <20241028213541.1529-1-ouster@cs.stanford.edu>
 <20241028213541.1529-5-ouster@cs.stanford.edu>
 <dfadfd49-a7ce-4327-94bd-a1a24cbdd5a3@lunn.ch>
 <CAGXJAmycKLobQxYF6Wm9RLgTFCJkhcW1-4Gzwb1Kzh7RDnt6Zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXJAmycKLobQxYF6Wm9RLgTFCJkhcW1-4Gzwb1Kzh7RDnt6Zg@mail.gmail.com>

On Tue, Oct 29, 2024 at 09:15:09PM -0700, John Ousterhout wrote:
> On Tue, Oct 29, 2024 at 5:09 PM Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > > +static inline void set_bpages_needed(struct homa_pool *pool)
> >
> > Generally we say no inline functions in .c files, let the compiler
> > decide. If you have some micro benchmark indicating the compiler is
> > getting it wrong, we will then consider allowing it.
> 
> I didn't realize that the compiler will inline automatically; I will
> remove "inline" from all of the .c files.
> 
> > It would be good if somebody who knows about the page pool took a look
> > at this code. Could the page pool be used as a basis?
> 
> I think this is a different problem from what page pools solve. Rather
> than the application providing a buffer each time it calls recvmsg, it
> provides a large region of memory in its virtual address space in
> advance;

Ah, O.K. Yes, page pool is for kernel memory. However, is the virtual
address space mapped to pages and pinned? Or do you allocate pages
into that VM range as you need them? And then free them once the
application says it has completed? If you are allocating and freeing
pages, the page pool might be useful for these allocations.

Taking a step back here, the kernel already has a number of allocators
and ideally we don't want to add yet another one unless it is really
required. So it would be good to get some reviews from the MM people.

	Andrew

