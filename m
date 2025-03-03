Return-Path: <netdev+bounces-171349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E623FA4C9D4
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 18:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74416189F74D
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F722144DD;
	Mon,  3 Mar 2025 17:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ktRl63M1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBB75CB8;
	Mon,  3 Mar 2025 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022165; cv=none; b=phc4ve6TU3cIKwrGjqIGZJZckcI8126pOwyCJf76uB/v2hiD2b0Lj8aRftzESmuGN/g/ovPcbfCUBERKDqEr+4o58PaMPD/8/17C1znEne6pwieBcL+U7iuI9JLkc7uQiHz1ncJ6A/tfTim4ZYyPJC0bSxCt7do8Pl4tHKXDvzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022165; c=relaxed/simple;
	bh=nPOtAJFZrfuFhT3wqz0eAE0UL4Cyx0k3+kWjJ+HrM6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jow7RsN1y25kpkgz3fFUhTOwUpq74EiU16NF0Jp5DtSoORqDDQoAQh+WkYCEVyTgvOZvgtrg/oAHBDpy2ncTIYmPUIYzSU2ipLtgbMMNHuNovmJvmQjMgK86a0a4P5MU8LtqPnLwuA3+2dx0sfJ+riJF5liMsQAdm+cAAK4QdVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ktRl63M1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=jRct7iFcUQqwebb9XNxidafNiDflHagvQntiKDIJ/ng=; b=kt
	Rl63M1yJAGp0rFF8DRhQDdp92kA7DOZymT1XeIb4s0QztPixcwrkujFMH/qFC29aWWKTpSSscrloM
	7vMBFWYQPYDM8UGUWJZMDMF2lFo/hJt7MN7WbuXllTH/ziS0hpD/5WUd1GHWc4ES7R/iVvf0eNf4d
	DhvTs0vUNNPOO94=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tp9OK-001sFp-Mm; Mon, 03 Mar 2025 18:15:44 +0100
Date: Mon, 3 Mar 2025 18:15:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ziyang Huang <hzyitc@outlook.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, rmk+kernel@armlinux.org.uk,
	javier.carrasco.cruz@gmail.com, john@phrozen.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: net: dsa: qca8k: add
 internal-PHY-to-PHY CPU link example
Message-ID: <55a2e7d3-f201-48d7-be4e-5d1307e52f56@lunn.ch>
References: <TYZPR01MB555632DC209AA69996309B58C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <TYZPR01MB5556D90A3778BDF7AB9A7030C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <ae329902-c940-4fd3-a857-c6689fa35680@lunn.ch>
 <TYZPR01MB5556C13F2BE2042DDE466C95C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYZPR01MB5556C13F2BE2042DDE466C95C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>

On Tue, Mar 04, 2025 at 12:37:36AM +0800, Ziyang Huang wrote:
> 在 2025/3/4 0:15, Andrew Lunn 写道:
> > ...
> > 
> > The previous patch still causes it to look at port 0 and then port 6
> > first. Only if they are not CPU ports will it look at other ports. So
> > this example does not work, port 6 will be the CPU port, even with the
> > properties you added.
> 
> Sorry, I forget that the following patch is still penging:
> https://lore.kernel.org/all/20230620063747.19175-1-ansuelsmth@gmail.com/
> 
> With this path, we can have multi CPU link.

So you should get that merged first. Then this patch.

> > When you fix this, i also think it would be good to extend:
> > 
> > > +                    /* PHY-to-PHY CPU link */
> > 
> > with the work internal.
> > 
> > This also seems an odd architecture to me. If this is SoC internal,
> > why not do a MAC to MAC link? What benefit do you get from having the
> > PHYs?
> 
> This patches are for IPQ50xx platform which has only one a SGMII/SGMII+ link
> and a MDI link.
> 
> It has 2 common designs:
>  1. SGMII+ is used to connect a 2.5G PHY, which make qca8337 only be able to
> be connected through the MDI link.

Please do not call it SGMII+. It is not SGMII if it is running at
2.5G. It is more likely to be broken 2500BaseX, broken in that it does
not implement the inband signalling.

>  2. Both SGMII and MDI links are used to connect the qca8337, so we can get
> 2G link which is beneficial in NAT mode (total 2G bidirectional).

So is this actually internally? Or do you have a IPQ50xx SoC connected
to a qca8337 switch, with copper traces on a PCB? If so, it is not
internal.

	Andrew

