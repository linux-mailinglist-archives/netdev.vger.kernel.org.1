Return-Path: <netdev+bounces-134412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0061D99940C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 22:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C97A1F243FF
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 20:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D441E2029;
	Thu, 10 Oct 2024 20:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eqwgyg8g"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6AE1CEABC;
	Thu, 10 Oct 2024 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728593970; cv=none; b=r+iMOFY1oJcKgxpMIYAdUpq4BHLUzM1jT2rIKCnlG/7/tQDS7d+doVI6abYXao3JvmumN5BTiRMFoDUWXfG2ljqtIOpa58WMhLwd9kpy6r52hjau8GkfIzAwWNU/jNxyziPnY0/u+XMka5TaCdtMeIkOQkVXVGpqkPJoegT7qQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728593970; c=relaxed/simple;
	bh=9n2VAGdYcReqs35yJzOUGVVKVW0egsjavx4oUUSPykM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImMz2zX6rvmlUiwAAb4AJYmeFD0+2npRGLTtTpfaOScGAENG+v/T1fphVN+KMyOlXPLlbX6pryLC0/a+WycEcz7vBCSbT5GYHmYwm5ZotioeFxOnwbOpq1Zpt2EF0SdM2A117uvCBHUy7l0kRd8+VIjLqAxBU/eMie4KuXise7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eqwgyg8g; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wvCWjvIp3pbwUedSVWqjjlF5QussOrPiSS8prGjuafc=; b=eqwgyg8gYQM54RGoCQ/HpOQ43o
	IWd8or6heyYw8QrBWfZVKd6Xm2x4Ra2uESrfV3hLpx5465fQJrhV0WfMB93IPd7TRGimaG/3gjNCT
	SvQ5wSYUhTBrjxBwmMVUoHCvLJWxkVtvmZEyevK1vk8piqm28+5/q6b6RrkaGuV/ilGI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sz0Ff-009ebS-LB; Thu, 10 Oct 2024 22:59:15 +0200
Date: Thu, 10 Oct 2024 22:59:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Iulian Gilca <igilca1980@gmail.com>
Cc: igilca@outlook.com, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] User random address if dt sets so
Message-ID: <3287d9dd-94c2-45a8-b1e7-e4f895b75754@lunn.ch>
References: <b4d4090a-2197-40ce-9bb5-1d651496d414@lunn.ch>
 <20241010202949.226488-1-igilca1980@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010202949.226488-1-igilca1980@gmail.com>

On Thu, Oct 10, 2024 at 04:29:37PM -0400, Iulian Gilca wrote:

The commit message cannot be empty like this.

Please explain in detail your use case. We need to understand the
'Why?' to decide if this is the correct solution to the problem.  To
me, it seems like you have a broken MAC driver, and fixing that MAC
driver is the correct fix.

    Andrew

---
pw-bot: cr
       

