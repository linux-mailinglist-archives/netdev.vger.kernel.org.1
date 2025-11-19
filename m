Return-Path: <netdev+bounces-240157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81968C70E12
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BFD09347806
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D46936C0B1;
	Wed, 19 Nov 2025 19:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JUx+vO6M"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19182D9487;
	Wed, 19 Nov 2025 19:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763581497; cv=none; b=aBSu9pdZQr+WfuzqhDlQE9Evcc6P+l9xPAVAEOePeOdodTtyp8vFN/qJGZTNuRMzVbMnhurRgu8lpsvm4db467LxbOCIR5LssV1NhmGdwieGv2+1cx1Wj98p7nC7OttMw0nxFJmRN6Ghy6wz8o7341SSOHCxM04S/FY8NDPM2dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763581497; c=relaxed/simple;
	bh=Lvzw5kWPZOa+UVHkjliY8GRM2NlfagfPs9hfidPFsfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jD7aZDaKg0GZVI9JO7hpvXoxh6pTa6FD74TMw8fV1BczalWV/rpfNehNyla/jeK570XLNKAhyF1FtOCg/NmzjuC9SQId+2tqllMsf6kBYOTJ/ZHFutlKIdHCgZfCRkucYsxJmB6jKUukywkSsxP9I0hep8ZzQb5hwDnn+QDTrJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JUx+vO6M; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3+MzljTu9sSQD9At6Ks7daYDnEuV5FX1vj590BIioUI=; b=JUx+vO6MqJ7R+n5Se9X4Jzl5wO
	cDKHBdrTjmoMKLb3G+atFqUElMjKybaSqOPfUpTYi9oNS7u4AZjEv/8I72LEIH/J1qzu596xXp2Uc
	9uSzS+D3c07AHZTdWDAxqUxb4IJYvSGNpIeOBBGCW8g4ugydEo0Xj9L4hb1otC+7ezI0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vLo6g-00EXkE-0M; Wed, 19 Nov 2025 20:44:46 +0100
Date: Wed, 19 Nov 2025 20:44:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: Re: [v2, net-next 09/12] bng_en: Add ethtool link settings and
 capabilities support
Message-ID: <b45636cd-48be-4db7-bf2d-a9eb611c14c6@lunn.ch>
References: <20251114195312.22863-1-bhargava.marreddy@broadcom.com>
 <20251114195312.22863-10-bhargava.marreddy@broadcom.com>
 <49930724-74b8-41fe-8f5c-482afc976b82@lunn.ch>
 <CANXQDtb5XuLKOOorCMYDUpVz6aFuQgvmQZ4pS6RJGkAgeM8n1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANXQDtb5XuLKOOorCMYDUpVz6aFuQgvmQZ4pS6RJGkAgeM8n1A@mail.gmail.com>

> > > +     if (link_info->support_auto_speeds || link_info->support_auto_speeds2 ||
> > > +         link_info->support_pam4_auto_speeds)
> > > +             linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
> > > +                              lk_ksettings->link_modes.supported);
> >
> > autoneg is more than speed. In fact, 1000BaseX only works are 1G, no
> > link speed negotiation, but you can negotiate pause. Do any of the
> > link modes you support work like this?
> 
> All the speeds we support can be auto-negotiated.

If all the speeds you support can do autoneg, why do you need the if ()

	Andrew

