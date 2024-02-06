Return-Path: <netdev+bounces-69541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA74584B9ED
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 16:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 304BEB254D4
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726BC133400;
	Tue,  6 Feb 2024 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zymIoPHq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A238712E1D8
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233834; cv=none; b=ldgyKdE8nR/dRId9QQsJLIC35E0wknTJ4zKhFvVL7xHma4k16c2Bdbw2rjRtdYXMkLvaAaerL22G3avXL51ve+CJm0B9ekUDjmTUqU9IYD/Em21NqQ62cyBwwZpebrCJEin0mHkcZJ27oCBS7SrPZ2/OfmTciTv9gXmjHleZ/qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233834; c=relaxed/simple;
	bh=MvrRCxXD7YMyPLeSQT/F2iHBwwzFH74F3QUCYJBupRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtWeaIkkOVAmnUgBtpJ0A+QnlJ59kgjPWcQXec2H953JsEl5girlFszNl2cXz6pcI40E0T3LqKHsW6jO3/le06qvVXrrUe/wOXh8313JV+rEG/vIUBQDW3tRN9lbRvvR2MY87wm6rj41hFDKGimqZsliV+0zVXGIwYiYdBXZa54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zymIoPHq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ovye9MxZtduANg+rIAfLLjCojRhTrQnjmluGc/Nv3Bg=; b=zymIoPHq4J4aOkmEb3bGFhDYvC
	G298EEdZfcFnvg25DA8WZAytpIr65OkHMoJ1NyAHwZ9CnCQ9mlwwk9ZIOLfpjV9PyCvVI6x1NQRr7
	6WJJx2n0ZGe0+aizHrvlV/UOEHq3oiaz+tEGnPJOv2y7B2RuNtejGR72eiyCK29LFoiE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rXNVW-0079Oe-SC; Tue, 06 Feb 2024 16:37:10 +0100
Date: Tue, 6 Feb 2024 16:37:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: mahendra <mahendra.sp1812@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [Kernel 5.10.201] USGv6 conformance test issue
Message-ID: <6f3cccef-2397-4cdd-8626-6259ec19c619@lunn.ch>
References: <CAF6A8582QOWc1k7c9sgeX5ebwY79SDAmXzfbBumW6qGoyu6HRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6A8582QOWc1k7c9sgeX5ebwY79SDAmXzfbBumW6qGoyu6HRw@mail.gmail.com>

On Tue, Feb 06, 2024 at 02:50:26PM +0530, mahendra wrote:
> Hi Everyone,
> 
> We are executing IPv6 Ready Core Protocols Test Specification for
> Linux kernel 5.10.201 for USGv6 certification.

Posting three times in quick succession is not going to help you get
an answer.

	Andrew

