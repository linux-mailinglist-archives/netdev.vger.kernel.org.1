Return-Path: <netdev+bounces-246017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B768CDC79B
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 15:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12BC03015A1C
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 14:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EEF3624B2;
	Wed, 24 Dec 2025 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f13ELqDx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F523624A0;
	Wed, 24 Dec 2025 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766584383; cv=none; b=KHd2tqX4y3xUtDbvzY9+DrNWd28UyDYaj5BXubMUNmaCXxPw2sQIfJEhB9d9fifSB0urR7OIOmDS6ky0VPvLbH3yooD//YaklR3oNYiZbkdkL+WPfjGYbiFPrZsu/lmxrAFL8xR4JPDmzvhvxtYkPqUT08ca7qD5nyBN5zWTFcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766584383; c=relaxed/simple;
	bh=9PK51ECBkOhdwQhJqIpfxbtYs8gBQMsdpeDhvx6eIxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A825TgHFVD2cds+tptPvEruia+GcztksS4O4GQqz0K6KU6i13jK6nYOtX2GAoOx6E9WsLZHc1bifwN58F7OHUcsd6qj22DKTqOvk9XZf1fv6RPrexBJioR9YrBG4ouEl11g7DYpnveaI39I+52hDwbNbE/bjg6yrihWLTlVkML8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f13ELqDx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZcUSC+YGvjcYhPt8XzYCqS36AYXBZHGVX6AQ6mImiQc=; b=f13ELqDxa2wtl2GB8W0GjY9s1r
	W5qgp7pAAFITypJK+RNj9dMsUC+iqlKvbIvnznjPzqepk7WM49M8YCPNqE2IID935oB1bX+XBMH0G
	w5kMsfjnYKdhK5g582lbacULNObRSJvKBpJlwShuw6WaF/GuMIvpVWBc/A/YeUECaxYM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vYPII-000QFP-JQ; Wed, 24 Dec 2025 14:52:50 +0100
Date: Wed, 24 Dec 2025 14:52:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Akiyoshi Kurita <weibu@redadmin.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: dsa: marvell,mv88e6xxx: fix typo
Message-ID: <647f64c2-6206-42fb-98b6-19840e4e819c@lunn.ch>
References: <20251224123230.2875178-1-weibu@redadmin.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224123230.2875178-1-weibu@redadmin.org>

On Wed, Dec 24, 2025 at 09:32:30PM +0900, Akiyoshi Kurita wrote:
> Fix a typo in the interrupt-cells description ("alway" -> "always").
> 
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

