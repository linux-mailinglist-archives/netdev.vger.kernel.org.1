Return-Path: <netdev+bounces-141330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFC89BA7B3
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 20:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EDD91F21477
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 19:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283851865E7;
	Sun,  3 Nov 2024 19:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="E9nA7Su0"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7278B140E5F
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 19:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730663013; cv=none; b=jf9VV528yuTpMPqhNqnI3zOPX761sKXKykslUnLaDwnuHYg1gTtAD689N+riocYmcz1XWEvmKy07AgaUccCy37gTAgoV1cKB6AoQH7/ZetvwlfZIO6QmWR1BYoS47zyzwm0L/+ydzGOufAHtbqj6jE1Iy5Khho+l7e4wM5JBIgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730663013; c=relaxed/simple;
	bh=0UksLun9eQJMhq+Y5/PHbI+lUWIE0RJS2aFHsBjlZMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nE0Ed3attDbd1CubTRdfJdiCrlhYLBadAeuieSNodwTX7FyqHc100w/Xl7KXOw+qv6glbOfHjhF/lWyuU0+cinkR/Mv1GUQzB6R2/6gl4SAauQK7RYlTekc8TW+Nk6XVdtJZSCa5QUvtWgbKoeNRK7XUFLE4gnm4zHQR2azXE1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=E9nA7Su0; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=dJB6w20QABS+Tyo4ES8z7MGs1dJjCRqRWyJwHQD0U+I=; b=E9nA7Su0YTtB2HI8
	DR7ouRzElFAMGicLH4G0a0JD7JUbs92gP5B2hhHnx15kRbUgGOSdBD3L8Y6DN0HHHRma9FRzeCQ2U
	LIUEHtEjeYjEN3/N1BoYYgRKXVU12qF6OKV5tYHF5WTkz287kM691mIpIDIhUaKLUtKCczDQQ6r23
	Sfh10rO7PTnbi96VZefiVR+0UtcOwWNO1NhDObXdMMFs4EkDutySOvf8QtXyC6GNx+3Uq/EmQA/ER
	6s1qNaOIxgpzlXBOp5oM+h69Ncc7EJKFleT+ZTF9tjN9Yroe04EHh61hnvjM6GhSHckqD2mRXWnHl
	2gQ8UnuQfbCWkcSsAQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1t7gVV-00FCDy-1e;
	Sun, 03 Nov 2024 19:43:29 +0000
Date: Sun, 3 Nov 2024 19:43:29 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: "Arinzon, David" <darinzon@amazon.com>
Cc: "Agroskin, Shay" <shayagr@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bshara, Saeed" <saeedb@amazon.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: Of ena auto_polling
Message-ID: <ZyfSYWEwI4yxZI6l@gallifrey>
References: <ZyZ3AWoocmXY6esd@gallifrey>
 <b3df5db4bea6401095b908b3632bb09e@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <b3df5db4bea6401095b908b3632bb09e@amazon.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 19:42:11 up 179 days,  6:56,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Arinzon, David (darinzon@amazon.com) wrote:
> > Hi,
> >   I noticed that commit:
> > commit a4e262cde3cda4491ce666e7c5270954c4d926b9
> > Author: Sameeh Jubran <sameehj@amazon.com>
> > Date:   Mon Jun 3 17:43:25 2019 +0300
> > 
> >     net: ena: allow automatic fallback to polling mode
> > 
> > added a 'ena_com_set_admin_auto_polling_mode()' that's unused.
> > Is that the intention?
> > Because that then makes me wonder how
> > admin_queue->auto_polling
> > gets set, and then if the whole chunk is unused?
> > 
> > Thanks,
> > 
> > Dave
> > --
> >  -----Open up your eyes, open up your mind, open up your code -------
> > / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> > \        dave @ treblig.org |                               | In Hex /
> >  \ _________________________|_____ http://www.treblig.org
> > |_______/
> 
> Hi Dave,
> The auto polling mode was written as a fallback in case there are issues with interrupts,
> it is currently not used by the ENA Linux driver, from Linux's perspective, it can be removed.

Thanks for the reply,
I've just posted what I think is a suitable revert of it then,
see message 20241103194149.293456-1-linux@treblig.org.
I've build tested it only, so please give it a good check and shake out!

Thanks again for the reply, and the ack on the other patch.

Dave
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

