Return-Path: <netdev+bounces-140368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9CC9B6339
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 13:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116B628112A
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 12:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A5A1E7C36;
	Wed, 30 Oct 2024 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HFe2TD8q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A5222315
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 12:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292113; cv=none; b=ly2a346Y/TWefYePUHYmf8jPtAGOxbz+Y3xcw7culDHOQofSZvsCPgcjkWn0k2t+dWCOBV1bC9LkiCxh2P/mSfMkIapL4QTwreu3rC3BNcg/+Bv8+RAvqZnAXU5ww3PdKcJCzgXMZeZvbwK+CxJsEQZc9pzxPDbXnpHaGQTwlj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292113; c=relaxed/simple;
	bh=LEsQou2xBryY4xbec+J9PhkHkr9O5+Qo/c3YYNNnoQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2XB45tKNEofU1Wxz4LPf9jfqPZImhK77JUyiSzcLB64u/L+ZKIFSic1+Z9fysNNrycM03Q16Wrqex03idWklw9eR1PwXE86CqC7lY1T576NAJ1n8Hj9EIKkNJXnL5UyiipdpRU86ivUreuHk/fe0x8eWGVoZBPHVgjAn2I6jso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HFe2TD8q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ucM7DN+XgpYo7hPKfiuK2TxrSUPJVRtpjAMS9YODAAA=; b=HFe2TD8qfdjLO+A73vnR/a8fVl
	dJ1WbjcMsA59xhOJwUlEeDbQVc5zDcV2cTVsUbn0ULXORxBYRHI7HbfniS/NQnVMt1B6oLuK7Bzu7
	gqeEzi9xTNaMwd+neG4Fdd+AQjmutS7gknsL00sOXiuxAbiWymSRmKTfbaQq2RRkyynk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t681F-00Bgfq-DC; Wed, 30 Oct 2024 13:41:49 +0100
Date: Wed, 30 Oct 2024 13:41:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next 01/12] net: homa: define user-visible API for
 Homa
Message-ID: <ce06867d-2311-466e-924f-ffa6fa6d49c9@lunn.ch>
References: <20241028213541.1529-1-ouster@cs.stanford.edu>
 <20241028213541.1529-2-ouster@cs.stanford.edu>
 <6a2ef1b2-b4d4-41c5-9a70-42f9b0e4e29a@lunn.ch>
 <CAGXJAmwSCeuwy6HXpzZgp8m+5v=NPCOTgKc-8LBjUuY079+h0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXJAmwSCeuwy6HXpzZgp8m+5v=NPCOTgKc-8LBjUuY079+h0w@mail.gmail.com>

> > Did you build for 32 bit systems?
> 
> Sadly no: my development system doesn't currently have any
> cross-compiling versions of gcc :-(

I'm not sure in this case it is actually a cross compile. Your default
amd64 tool chain should also be able to compile for i386.

export ARCH=i386
unset CROSS_COMPILE
make defconfig
make

	Andrew

