Return-Path: <netdev+bounces-133309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CD1995940
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112A628156B
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 21:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5C817C7BE;
	Tue,  8 Oct 2024 21:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WyMGbg06"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4ED2574B
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 21:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728422607; cv=none; b=UslQ4q8UactQ+MPFDgP2mNZ3GB7ao5pXIEhkAhy6quyorDo4DB6YnE7ohkeqO4EQ8WMiJOWtm6wOWyn6HvhajmhVu6YnqJDRIp6XxjY6ifiWWt7uXs5yeRg0e10F6CTThBVZPW5wupUPjWobbmlqzsJ8upfdUmUtpJru+bbdNdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728422607; c=relaxed/simple;
	bh=hxqBBIDpBxTqwbO9yN1BZsTIOsspHLjoyV+R9g3yJzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKJX5QBPhWtD/q5e7WrZHuVXCO82D0qCHAykqlq5iSlVwiCCypjb2ECdun//ub+oBSfXxTt77kArAwsrusHGJUZzqdqz2GYADMcjXWjlMJsRXNiFXCAaNs7+K5lyCoLuqzIZwMYE7pNKJoiSthRCrCQE6M3v0Gk8yibHgqAGsCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WyMGbg06; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Pxik2gx4EtMTir3lFmAnSz4tQyov8kiQegGBqAAuFEQ=; b=WyMGbg06t62dW7ClIeYRrYJ+sG
	dwnnwTlXMknqh7vpoaQIS+KuixjD/g7VFyRdRluiadbknP18UVr9PLEJGizOLiwbYUN9G91gK/6QS
	ZabIaALQ5JpN5uqtkvd3j8xZ5sIDoUwNqriZz1HOoc+SBKXrO3Xpx9SsV8ljYKaPzUps=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1syHfv-009Poo-Rw; Tue, 08 Oct 2024 23:23:23 +0200
Date: Tue, 8 Oct 2024 23:23:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shenghao Yang <me@shenghaoyang.info>
Cc: netdev@vger.kernel.org, f.fainelli@gmail.com, olteanv@gmail.com,
	pavana.sharma@digi.com, ashkan.boldaji@digi.com, kabel@kernel.org
Subject: Re: [PATCH net v2 3/3] net: dsa: mv88e6xxx: support 4000ps cycle
 counter period
Message-ID: <05fb18ef-1436-4864-a2e6-3cd7bb0123c1@lunn.ch>
References: <20241006145951.719162-1-me@shenghaoyang.info>
 <20241006145951.719162-4-me@shenghaoyang.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006145951.719162-4-me@shenghaoyang.info>

On Sun, Oct 06, 2024 at 10:59:47PM +0800, Shenghao Yang wrote:
> The MV88E6393X family of devices can run its cycle counter off
> an internal 250MHz clock instead of an external 125MHz one.
> 
> Add support for this cycle counter period by adding another set
> of coefficients and lowering the periodic cycle counter read interval
> to compensate for faster overflows at the increased frequency.
> 
> Otherwise, the PHC runs at 2x real time in userspace and cannot be
> synchronized.
> 
> Fixes: de776d0d316f ("net: dsa: mv88e6xxx: add support for mv88e6393x family")
> Signed-off-by: Shenghao Yang <me@shenghaoyang.info>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

