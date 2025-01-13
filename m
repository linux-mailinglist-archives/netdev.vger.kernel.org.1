Return-Path: <netdev+bounces-157826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768B4A0BEB1
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 18:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A2F67A4F46
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 17:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BFD20AF87;
	Mon, 13 Jan 2025 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MlADg6PT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8F820F073
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736788454; cv=none; b=tQhKfqasNv8LqaXWDJTOQDK7O33H+mU3wI3HcZPPBK4ZdGS+0Xtog1Bjwxl/JKfWqRiOmI6vjE1PQdjkUHvVKMnGUQjwnrzIMVw2rTRpyOJGih4A6GoXdGfab+I6qiT5CL4yScLJH35TNbWaiWBVNOrqo3n3ZBcqV1L6QeoxLpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736788454; c=relaxed/simple;
	bh=pENBE+w1pxY7Ro/wgvay5mklu5xPzWPVrWp6wjtNsCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bn4TbpaI713Y1nerEZRAa25H6PCh0tXzl6XD7yzkVoryPoMESU8g/spk4kxOk7fQMEAQZ3l31EnM8wbJMXo1/7zWPyw+miaovPohJYyP+D5kYZbJoh6sNQCTM1w1lz8LnQ/IaMHd482UC3PmcjhLd7Ijh2xndV2FZePTyBcnsws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MlADg6PT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UpTwvvQ5nkUY/i397ertR/RrwQvDk1GpXecd7gD+9RQ=; b=MlADg6PTS4gUNKCxJQHOcV6dvP
	zmZmDjSHkGEign0/sTYJ4cq7VdmpiXAJub6FQ4azKob4U/xXnUYHBuuumPQnQUe6AEj1W3wskLSY2
	y9cx6A0r/cAlymM+Tj9bhU1Zr/bgO5rzzLHF1xfXJTeOCBAl8NPZeYHk7MUCzpkDEstY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tXO0c-004AAv-VK; Mon, 13 Jan 2025 18:13:50 +0100
Date: Mon, 13 Jan 2025 18:13:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>, mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: txgbe: Add basic support for new
 AML devices
Message-ID: <30f42cba-3fff-4137-9aa8-b210ee205423@lunn.ch>
References: <20250113103102.2185782-1-jiawenwu@trustnetic.com>
 <0be63e70-74bb-465a-a933-0258a45033a8@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0be63e70-74bb-465a-a933-0258a45033a8@intel.com>

> > +	u32 dword_len;
> > +	u16 buf_len;
> > +	u8 send_cmd;
> > +	u32 i, bi;
> > +
> > +	/* wait max to 50ms to get lock */
> > +	WARN_ON(in_interrupt());
> 
> the comment does not belong here (@timeout is a param, not a const=50ms)
> the warning would be better left to be triggered by lockdep
> (sleeping in atomic context is reported then)

I actually think it is DEBUG_ATOMIC_SLEEP, which is not part of
lockdep.

Also, i've seen recommendations of not using in_interrupt() because
that is not sufficient. There are cases this is false, and you still
cannot sleep.

might_sleep() is the correct thing to put here.

> 
> > +	while (test_and_set_bit(WX_STATE_SWFW_BUSY, wx->state)) {
> > +		timeout--;
> > +		if (!timeout)
> > +			return -ETIMEDOUT;
> 
> it is rather
> ETIME 62 Timer expired
> not
> ETIMEDOUT 110 Connection timed out

ETIMEDOUT is the preferred error. See for example
include/linux/iopoll.h

Ideally, this code should be implemented using one of the macros in
that file.

> > +		wr32a(wx, WX_SW2FW_MBOX, i, (__force u32)cpu_to_le32(buffer[i]));
> > +		/* write flush */
> > +		rd32a(wx, WX_SW2FW_MBOX, i);

> > +	/* polling reply from FW */
> > +	timeout = 50;
> > +	do {
> > +		timeout--;
> > +		usleep_range(1000, 2000);
> > +
> > +		/* read hdr */
> > +		for (bi = 0; bi < dword_len; bi++)
> > +			buffer[bi] = rd32a(wx, WX_FW2SW_MBOX, bi);
> 
> no need for le32_to_cpu()?
> (if so, reexamine whole patch)

When i see (__force u32) i start to wounder if the design is correct
as well.

> > + *  wx_host_interface_command - Issue command to manageability block
> > + *  @wx: pointer to the HW structure
> > + *  @buffer: contains the command to write and where the return status will
> > + *   be placed
> > + *  @length: length of buffer, must be multiple of 4 bytes
> > + *  @timeout: time in ms to wait for command completion
> > + *  @return_data: read and return data from the buffer (true) or not (false)
> > + *   Needed because FW structures are big endian and decoding of
> 
> In other places you were using cpu_to_le32(), this comment seems to
> contradict that

It would be good the use the __be32 and __le32 annotation. sparse will
then help spot such errors.

	Andrew

