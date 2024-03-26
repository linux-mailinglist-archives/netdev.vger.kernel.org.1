Return-Path: <netdev+bounces-82030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F52F88C200
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 13:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4229B1F633F3
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 12:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD6E768E9;
	Tue, 26 Mar 2024 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Q2ez/U7v"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D8D745E1
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455717; cv=none; b=gD2mkTYnGhVoz0oFaOD42Iw9ERrqfA4DTL8aNO5PRxNwKaNdMs7bUudR2Uo/TU1rsLUuBUXgLpr06q5JtEuRcCrqkVeHi27dh+M88Flbxlc4YcpZYwYjP6eu098sOXlV0JeAnQ3gHiY3tZ1A15OeVVwBdxPPumTj0n6d6AiD4IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455717; c=relaxed/simple;
	bh=1+iRHvZ1GPFm4djfqC62M3Jpz2AhjNEFrELgihuTnLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1sB2MlU9ugswiXsoK3ccQgaG5113Qxj5TXoDUJbigVNaBNeAJHDPsJ+rJkAbhYxgZxly0lH88LH/yOCSEtm6UVQjBUzMQMdPtDSPiSzFpJcByKjjaOJGY3JZUMD/YrNKqtTfBKMgWJvM+hFMsrz/aXlWBiswysm9pUxe2wEhB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Q2ez/U7v; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=91D/jxmel/zt0PCAWhRCk6wdRhnvl/MSuj7Chx5MnwE=; b=Q2
	ez/U7vrW6baMTTNIbhlPDb5yDCJ1yc315Tgs7C42ovhORKZc7sJHLgoNZFmsXxkDifLvokZk5Ydq9
	vydWcU5HJBI+Bl3dmFkYn6aScBS4daa0kloV+j+KDQ3eS4zCsqvWzvYm7XgutA7f191T5gML0Xlvb
	VwR6N4PHF69fbgA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rp5oF-00BGyN-7R; Tue, 26 Mar 2024 13:21:43 +0100
Date: Tue, 26 Mar 2024 13:21:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: Serge Semin <fancer.lancer@gmail.com>, hkallweit1@gmail.com,
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn, linux@armlinux.org.uk,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 08/11] net: stmmac: dwmac-loongson: Fix MAC
 speed for GNET
Message-ID: <593adab6-7ecf-4d8f-aefb-3f5eea24f3fc@lunn.ch>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <e3c83d1e62cd67d5f3b50b30f46c232a307504ab.1706601050.git.siyanteng@loongson.cn>
 <fg46ykzlyhw7vszgfaxkfkqe5la77clj2vcyrxo6f2irjod3gq@xdrlg4h7hzbu>
 <4873ea5a-1b23-4512-b039-0a9198b53adf@loongson.cn>
 <2b6459cf-7be3-4e69-aff0-8fc463eace64@loongson.cn>
 <odsfccr7b3pphxha5vuyfauhslnr3hm5oy34pdowh24fi35mhc@4mcfbvtnfzdh>
 <a9e27007-c754-4baf-84ed-0deed9f29da4@loongson.cn>
 <3c551143-2e49-47c6-93bf-b43d6c62012b@lunn.ch>
 <5aad4eea-e509-4a29-be0a-0ae1beb58a86@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5aad4eea-e509-4a29-be0a-0ae1beb58a86@loongson.cn>

On Tue, Mar 26, 2024 at 08:02:55PM +0800, Yanteng Si wrote:
> 
> 在 2024/3/21 23:02, Andrew Lunn 写道:
> > > When switching speeds (from 100M to 1000M), the phy cannot output clocks,
> > > 
> > > resulting in the unavailability of the network card.  At this time, a reset
> > > of the
> > > 
> > > phy is required.
> > reset, or restart of autoneg?
> 
> reset.

If you need a reset, why are you asking it to restart auto-neg?

	Andrew

