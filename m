Return-Path: <netdev+bounces-145601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06D59D0091
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 20:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37043B21D0C
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 19:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1780F191F77;
	Sat, 16 Nov 2024 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jdmIMSJb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97341944F;
	Sat, 16 Nov 2024 19:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731783801; cv=none; b=hQGvffesqCwDA054dGf00uJ2dy9+BjbH9P2bWD3/nklSdOAzwd4z8RS2x6v+5QUGUmnAwo0IkRxNZ7k+K8GSstm0fdfiV/fgy+CXwiva/8mFmaY/aCnRPU6/D7lV3oKGMHZa9sBY/Dil/n64U4MK4ZpocgshR/XOjzw0CadxWwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731783801; c=relaxed/simple;
	bh=tZv5E1A8W1wlQkj3ZuO1THIUSuTiJ46DgCRtNku7HDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bN154hwByPgzj1pnFHD+RLoYU7iC7lmDxF2vXgcRqXhNbBiXg5opBH7uKBB1lE9loYjb2fUVzEPj9DPTmliT1QGc2Y0kLF4idNHJogsHZHTEQuhgQfCGWMAqFrbtp1mjatd1a83qRCyZdhNGv1x7X177eXOWn9zQNfR6TKD6aOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jdmIMSJb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5Dw8FP9OZHOdFbVLJrs4LP7I8GCsdONWPSWzuBFuWYo=; b=jdmIMSJbe8MRduGOj4NHcSP8UC
	hTmiT0eexiwueBObTqdU4HUdQc+IVeiLmrkbOUea34ApOfA+M9JWF9prtWM+khnv5KHSzdEwv22df
	i76e8yw1k75f4tomSl28B2xbqlMROmKaeh/yQUviJAdSZpTMgtGcHIyg5Byfcfg7OI2M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tCO4U-00DXTx-E6; Sat, 16 Nov 2024 20:03:02 +0100
Date: Sat, 16 Nov 2024 20:03:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	horms@kernel.org, pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net v2 5/5] rtase: Add defines for hardware version id
Message-ID: <8eda9366-e11c-4665-bee6-63f0db4d8376@lunn.ch>
References: <20241115095429.399029-1-justinlai0215@realtek.com>
 <20241115095429.399029-6-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115095429.399029-6-justinlai0215@realtek.com>

On Fri, Nov 15, 2024 at 05:54:29PM +0800, Justin Lai wrote:
> Add defines for hardware version id.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

