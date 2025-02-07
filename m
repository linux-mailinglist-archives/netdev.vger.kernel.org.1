Return-Path: <netdev+bounces-163904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA183A2BFD8
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACF5B7A0596
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 09:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991D7199385;
	Fri,  7 Feb 2025 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUC9sIaF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F8532C8B
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921669; cv=none; b=QMvyh/0lvsolQIJTJWJZwF+gU+FlTW7BXyEpwjtW9Ev0gko76sj7qW8hdz8S1EKh/qom2Ub6yspyvAxYOWcr+d/o1neHaK12Sxuoc981l3aT56umHdSsn5XKNGekzCvMvhCtimLJzRXLb8yUhm1dMySN4NHnNXOZJ6IfeI2kwNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921669; c=relaxed/simple;
	bh=RcW4E/v0rpgYTtD8alc/ailJq95Omc66AphSKG4z9gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=he1a84wE1IFDLYPERuIXGiZ0TxFvQbN+h4U7QSXFw+SlnNJQOQuugiIM0CRKK+3uPlP3UTqkn7bXr4Oar2JgALJBXL44t52lZOeMybIvecP6FZn71ij62wEu/zIpWz1iWfNAl1/ciyXR0JQ/7xWmnANHnF3ZRWsgbQM4NMvpGpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUC9sIaF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB978C4CED1;
	Fri,  7 Feb 2025 09:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738921668;
	bh=RcW4E/v0rpgYTtD8alc/ailJq95Omc66AphSKG4z9gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sUC9sIaFbC6zXJHjTKbsuUuxE7P5TE+yX/YXp5c0PvQSFilSy4YBUUMYYhajtnY/5
	 XP0NKq0YFoeK5UE2WSkyNrLQ5WtrDPogqaHZZYj8kjsa2/uLfVb04ULCW3JRZQHPcX
	 j5foQEgfU7sy2KXm+WKZBS83YyEmzIeGWmptWHq3rTHHPOLk9EosFv82iqW2o8z07O
	 TEv9rFjsXjrWtORbtoWhhXcvL4tyHAbOiAdN+xie+YKoZ/P8WFos8deOFiix00Q/Th
	 cRZGr9gtCiqVSZovgmEup2T6l+3L5LOjyfTs/sJLUK0EfcEPT8W5ieqhM6UK2ATSOw
	 4glYCuMZi7mFA==
Date: Fri, 7 Feb 2025 09:47:44 +0000
From: Simon Horman <horms@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH net-next v2 3/7] net: dsa: sja1105: Use
 of_get_available_child_by_name()
Message-ID: <20250207094744.GE554665@kernel.org>
References: <20250205124235.53285-1-biju.das.jz@bp.renesas.com>
 <20250205124235.53285-4-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205124235.53285-4-biju.das.jz@bp.renesas.com>

On Wed, Feb 05, 2025 at 12:42:23PM +0000, Biju Das wrote:
> Use the helper of_get_available_child_by_name() to simplify
> sja1105_mdiobus_register().
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Dropped using _free().

Reviewed-by: Simon Horman <horms@kernel.org>


