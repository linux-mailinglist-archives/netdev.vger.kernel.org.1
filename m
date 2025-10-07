Return-Path: <netdev+bounces-228095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47823BC1588
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 14:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF6A1889751
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 12:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE672DCC17;
	Tue,  7 Oct 2025 12:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Y2/8exEl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27732DC330;
	Tue,  7 Oct 2025 12:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839541; cv=none; b=rclS6iE3eI8wd7LyXq8CYW1mfxbcMoEYaO1QAq1hmeJrFKBmQj8XGgHaf0vxCzWXK3zb8bp9L+M0H9SUrOLrEhaan7Pe/zt5+/96Gfvqbm5VYIisEAN4othhp1SdAMQK3b0P6xn/wdU5tdtthI/WVxm50UeIoYqbL5guB5cX480=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839541; c=relaxed/simple;
	bh=bZHluZBNV11Zf3vbOrys+ScLVNV5qSrBfiC1kacumGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKR20da6Qjw13uxmsiJLn6nPVl+hoLF5oKHg7AEXngtlOeaXhrOUo8CwKUZ2Nj0S30Fbq/uUcj23DYmQtUkrWoVRBaz9SwG8HR98eQfK8z1hqH6patU3JOS+xpS1AuckBePqo+B0YHRGvHE5wDV+71ctdt5uUdaMb52E6ajQ1xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Y2/8exEl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AhQrHnwyOhDOXQIAuypnMzei7NY5hbIJrqPdUv7/8jM=; b=Y2/8exEllfLEHpA5WTArpPHWTZ
	sMw+ILUuC+Bqlfe5jyqeB6ja2vulvhvPkSPZw9hp1VAQkBFpviEoTF4govHa1mrvYL3lPoyEKVoeU
	BmHurfwh47cFYRr/C1Jh/npibUcHe/wgh9RG7E1evbCOlo9pz76UfmAG17cpYSf+mcq0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v66eZ-00AMew-KR; Tue, 07 Oct 2025 14:18:51 +0200
Date: Tue, 7 Oct 2025 14:18:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
	andrew+netdev@lunn.ch, conor+dt@kernel.org, kernel@collabora.com,
	krzk+dt@kernel.org, angelogioacchino.delregno@collabora.com,
	kuba@kernel.org, devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, davem@davemloft.net,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH v3] dt-bindings: net: Convert Marvell 8897/8997 bindings
 to DT schema
Message-ID: <89bb83ec-200c-4ed6-bfd8-ac55375e4ee1@lunn.ch>
References: <20251001183320.83221-1-ariel.dalessandro@collabora.com>
 <175943240204.235529.17735630695826458855.robh@kernel.org>
 <CABBYNZKSFCes1ag0oiEptKpifb=gqLt1LQ+mdvF8tYRj8uDDuQ@mail.gmail.com>
 <CAL_Jsq+Y6uuyiRo+UV-nz+TyjQzxx4H12auHHy6RdsLtThefhA@mail.gmail.com>
 <CABBYNZKxGNXS2m7_VAf1d_Ci3uW4xG2NamXZ0UVaHvKvHi07Jg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABBYNZKxGNXS2m7_VAf1d_Ci3uW4xG2NamXZ0UVaHvKvHi07Jg@mail.gmail.com>

> > > > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > > >
> > > > You'll probably have to resend this after rc1.
> > >
> > > In that case I'd like to have a Fixes tag so I can remember to send it
> > > as rc1 is tagged.
> >
> > A Fixes tag is not appropriate for a conversion to DT schema.
> 
> Ok, but then how do you justify merging it for an RC? Or I'm
> misunderstanding and that should just be merged to bluetooth-next and
> wait for the next merge window? In that case I can just merge it right
> away.

Most subsystems don't accept new patches during the merge window
because they will need to do a rebase when -rc1 is pushed. And
rebasing of patches is frowned upon.

By requesting the developers to repost after -rc1 is out, and the
subsystem tree has been updated to -rc1, the Maintainers avoids the
rebase, and pushes the work to the developer to rebase and retest,
leaving the Maintainers to do more useful work.

	Andrew

