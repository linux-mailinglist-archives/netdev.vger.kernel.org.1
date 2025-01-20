Return-Path: <netdev+bounces-159673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AAEA16590
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 04:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8091887DD1
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 03:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3677A3EA71;
	Mon, 20 Jan 2025 03:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FY4rf/ga"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B625182BC;
	Mon, 20 Jan 2025 03:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737342759; cv=none; b=tUMHn13A8lmXzAF0M/xqho9yCJjkXCwWs4x7nuRG1Isyb9hg4emaxGVsYsXRCsjlhwRASmH1NG741fLU34yDd2omla0Q9aGWJWKXLeUE8siGXWybPxdizBpdEfjDZk58CyiL+YLcaHiBovXPT9H9OP+deAiuTD1UeWUW1nIoZ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737342759; c=relaxed/simple;
	bh=bmvPYWO8EuBlTLLWuZK+2Mr8k174IXbOrjkmSH4v0T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEmEmhZeh48pd8o9AVEeFyISrJa33o5FQebjlBmlZOi6cJpdY5f4qyjD0KOlDuCkZ1DLPkZ4Mj94fodj26FlOCfWRHLq55bSQIyJjeNGKbvIOspT3s3H6Di3N8Hq4liW5dTSuaSpM/WOLZiTTwriD/lDci9douSPLhVfR21/HWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FY4rf/ga; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=827wYT8UbXt3wFmxqd95EaciVY8VTpN/2mOlgsUWNGA=; b=FY4rf/gaqOXvqbw9/4Y/BjSETz
	OxQYtemTIsI/Z7fIK0xdKxRHTt5uIxEq0USRUTnjcm/XAKzRaal9d0L4v8nTNNQa7MQvQPjimWi3I
	eB1Qly4Sq/Lm6XfrKQdt+x5IJXkQndgvuPXsr8pIXvzSlq48+3rV8Nf3xGAr12AX0MKY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tZiD8-006Df3-R3; Mon, 20 Jan 2025 04:12:22 +0100
Date: Mon, 20 Jan 2025 04:12:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Aryan Srivastava <Aryan.Srivastava@alliedtelesis.co.nz>
Cc: "olteanv@gmail.com" <olteanv@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC net-next v1 2/2] net: dsa: add option for bridge port HW
 offload
Message-ID: <17952bc5-31eb-452c-8fec-957260e9afd1@lunn.ch>
References: <20250120004913.2154398-1-aryan.srivastava@alliedtelesis.co.nz>
 <20250120004913.2154398-3-aryan.srivastava@alliedtelesis.co.nz>
 <bb9cf9af-2f17-4af6-9d1c-3981cc8468c0@lunn.ch>
 <5d5cc80b20e878d01c3d7d739f0fc7e429a840ed.camel@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d5cc80b20e878d01c3d7d739f0fc7e429a840ed.camel@alliedtelesis.co.nz>

> > This is not a very convincing description. What is your real use case
> > for not offloading?
> > 
> The real use case for us is packet inspection. Due to the bridge ports
> being offloaded in hardware, we can no longer inspect the traffic on
> them, as the packets never hit the CPU.

So are you using libpcap to bring them into user space? Or are you
using eBPF?

What i'm thinking about is, should this actually be a devlink option,
or should it happen on its own because you have attached something
which cannot be offloaded to the hardware, so hardware offload should
be disabled by the kernel?

> > net-next is closed for the merge window.

> I was unsure about uploading this right now (as you said net-next is
> closed), but the netdev docs page states that RFC patches are welcome
> anytime, please let me know if this is not case, and if so I apologize
> for my erroneous submission.

It would be good to say what you are requesting comments about.

   Andrew

