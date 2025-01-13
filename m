Return-Path: <netdev+bounces-157907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E338DA0C466
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 23:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD6F63A510C
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 22:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA4C1E491B;
	Mon, 13 Jan 2025 22:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QPkGC43P"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5957C18FDAB
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 22:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736806126; cv=none; b=RXEGzlcRuojal0VTrxzQl6TMgBRnmLefLmuyToWz8I5l6jdsqk2/hM75yuPnZPCgbsXt7c+q4ovnsAzD3OfyQlU5V2+qPuoZSU1ZqB9ZIPcvYJ/h1QzSP3nn7sdPxjU9ek9ZprJ/3s4gJ8ck95OR0cBWMepQ0MCmJnOMkYCoBo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736806126; c=relaxed/simple;
	bh=oSN4Dq180GuGSWzjfconuOddkZy7J2QWnB+lz169nM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNxCmNbuR3PHV/zymiCM0XRgutq6PMPonU6QLG51ffN62Ch+kH8KO4uL+G9QQ6Txt6GKuLpSJyv+CSNk9EqbishwNYyG4tOLOJP6e2xvjsLMsq+fAtAEEP3aG9GC8wT017oDAgvbFEk6S2UySvqHtJFnlVHuzP05Yx7HaGs1CYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QPkGC43P; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=97HIKhsunGbwAeAiyvAYMhLUrSE/kjVen7uT2KQvSEo=; b=QPkGC43PmCy8mgT3EfpeWO+dIk
	KIBa/hRlOATwWz313aiG2ujPh+hTsBXK9MTtjW6EEwzdiwuNr6Fzsdq8fU1O6YBsrsqPHaHwf6Hhs
	t6MCnsHBrcr7eXwSZRsQFD2Lm0IS2tzF8LVjIzvulw1fTcKYXbbabS3dBlD5xPZrcCjE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tXSbv-004Ek0-0h; Mon, 13 Jan 2025 23:08:39 +0100
Date: Mon, 13 Jan 2025 23:08:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/5] tsnep: Add PHY loopback selftests
Message-ID: <b9ba6dd0-a978-421f-8d63-3366ea5e3991@lunn.ch>
References: <20250110144828.4943-1-gerhard@engleder-embedded.com>
 <20250110144828.4943-6-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110144828.4943-6-gerhard@engleder-embedded.com>

On Fri, Jan 10, 2025 at 03:48:28PM +0100, Gerhard Engleder wrote:
> Add loopback selftests on PHY level. This enables quick testing of
> loopback functionality to ensure working loopback for testing.

You don't appear to be sending any packets. So how do you know
loopback is actually working? I'm not sure this is a useful test.

	 Andrew

