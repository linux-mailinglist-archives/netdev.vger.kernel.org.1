Return-Path: <netdev+bounces-161489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70470A21D5C
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 13:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B443A64C5
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 12:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BEFDDA9;
	Wed, 29 Jan 2025 12:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CUztH85z"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0405C19BA6;
	Wed, 29 Jan 2025 12:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738155580; cv=none; b=sRHP8rsX/2scZvSPJYoUJ3OculVN/eECOloSr2F/krcCbYroT0GueSv+NND1U8o1BTbRqC7hyoRBLLJy2bCjYeYqdbJVCy6c+jwbw46peubGK4LRCcqBk4TBNceEcwp64l3z8RlR8SoBvNuBlXmZAQ2Af7mwO1wtRxKTtgk5yjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738155580; c=relaxed/simple;
	bh=sQX6x1MxCe6dGTJg14sb7IOEKntmBZSGagRFz3P5fYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZU2xHDlCcMmASxkHzHn00KWDeXpdiKk98HIhkSJkGxuND8Jp0go6PZZwSXyd4saMmsbEeBAmZfiigwHfg8KhH6raoPrF3fAQb/AUYori053Wo+oqO+MgmIJ6UvTQMarV+vnasc8XK2ODEZ+feTs6sua0jhMn2TKfsj8hPl9lnb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CUztH85z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iGCt+0XxcYcy2o+9UQUPdgFocwfvqqMxMPoHohs8Lr0=; b=CUztH85zaoBHrhNGD7AArJxIxQ
	bTqqhXxkfIpyFsSfW9KkbD+h9KZwEnsQ0rJilPxFAnBn8ImYlu4Kgwjp3FyNz4ZS+JCmDXRR3pldW
	CCSdXbtfElUK5J8Ei+K7RPaxW+t+4GDnM4PRoYwIYetZmMYLfW5LAK13RhKAh/XTSn0c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1td7f5-00984N-HY; Wed, 29 Jan 2025 13:59:19 +0100
Date: Wed, 29 Jan 2025 13:59:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Swathi K S <swathi.ks@samsung.com>
Cc: 'Rob Herring' <robh@kernel.org>, krzk@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	conor+dt@kernel.org, richardcochran@gmail.com,
	mcoquelin.stm32@gmail.com, alim.akhtar@samsung.com,
	linux-fsd@tesla.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, alexandre.torgue@foss.st.com,
	peppe.cavallaro@st.com, joabreu@synopsys.com, rcsekar@samsung.com,
	ssiddha@tesla.com, jayati.sahu@samsung.com,
	pankaj.dubey@samsung.com, ravi.patel@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v5 1/4] dt-bindings: net: Add FSD EQoS device tree
 bindings
Message-ID: <b4df65c8-e6e5-437f-826a-eb011aac83df@lunn.ch>
References: <20250128102558.22459-1-swathi.ks@samsung.com>
 <CGME20250128102725epcas5p44b02ac2980a3aeb0016ce9fdef011ecf@epcas5p4.samsung.com>
 <20250128102558.22459-2-swathi.ks@samsung.com>
 <20250128154538.GA3539469-robh@kernel.org>
 <003001db722f$1d7e56d0$587b0470$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003001db722f$1d7e56d0$587b0470$@samsung.com>

> > > +properties:
> > > +  compatible:
> > > +    const: tesla,fsd-ethqos.yaml
> > 
> > Humm...
> 
> Hi Rob, 
> Could you help me understand if there is anything wrong here?

Is your compatible really "tesla,fsd-ethqos.yaml"? If so, i think this
file needs to be called tesla,fsd-ethqos.yaml.yaml.

	Andrew

