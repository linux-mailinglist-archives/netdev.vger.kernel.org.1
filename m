Return-Path: <netdev+bounces-145668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 047969D05AA
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 21:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A429B1F21379
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 20:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7531DB940;
	Sun, 17 Nov 2024 20:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VdTfp2hl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C25A3BBEA
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 20:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731874235; cv=none; b=h9ctoL0fvnFPVCdcRHrvr5+YqLy+FLwOeOTWaFiqhAsaIRJCnXevs6FSf7cXqVE1CvyUy4ObGa3bZMYO6Gv+UimhcVWTyxLeb52O8RPCswb/GlFeRUJ9FhTObTe4OxZZhFKG7ADx1QQmhav47T/4nTtKpCgvE5jXR/Ev3RIM9QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731874235; c=relaxed/simple;
	bh=D0t8SACiO14mcO+iLXv448DhsSs4x3QkjZJg1l2z1WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wnl6XY3chtK8hS19Z9aH8jR5/9X85xN2gDp9X3q0UhT3IRNHbI72FyP9vm+bvhiLqbFeavyrQ/itYZMXqe+S2uw7BfqBDI/6hqfrXGMblRnLrVGffbhQojPqWSjSxPQLxCvTL4dWrqZVgQVGr4S6BBL8wV0ZVczqori2RlGuvQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VdTfp2hl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HHxFXlxiMP50Oc3x9Lp0sTwbazYHU3yBWzcSV8JAITI=; b=VdTfp2hl8Ahuls2EVZj5c3OHxX
	zLABzc1/uRuluUuAM5sH8uczPJxjfBJxnOWRQqmDVQXwOuS4mcG0R6ll+6FWZSjXnWoT3gE9kR7yV
	lKhpF2yLyXyaajuK4gGEaFBZlxe81xxcm1J5sJMo5uLBmI3OOOSutwqEfkiSphRwevqo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tClbJ-00DbJU-Dq; Sun, 17 Nov 2024 21:10:29 +0100
Date: Sun, 17 Nov 2024 21:10:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, alexanderduyck@fb.com
Subject: Re: [PATCH net-next 2/5] eth: fbnic: add missing header guards
Message-ID: <ad6e9791-eb97-4079-a3d0-753c9463b210@lunn.ch>
References: <20241115015344.757567-1-kuba@kernel.org>
 <20241115015344.757567-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115015344.757567-3-kuba@kernel.org>

On Thu, Nov 14, 2024 at 05:53:41PM -0800, Jakub Kicinski wrote:
> While adding the SPDX headers I noticed we're also missing
> a header guard.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

