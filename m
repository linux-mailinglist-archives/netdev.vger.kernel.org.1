Return-Path: <netdev+bounces-156854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C5BA0805F
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 20:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88DA188993F
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 19:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51B71A9B38;
	Thu,  9 Jan 2025 19:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OBmZLgdZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60A21ACEBE;
	Thu,  9 Jan 2025 19:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736449258; cv=none; b=YU6EzN3v2I5a8n9WdxDpqcSzaF0dG8m1fXYqPaOvFaCDaAZtI+CtFxern7VcPNn7d4u3qJ8UdNY35Wlp8HgIYB4r4KbE/qj3UvyI+kgEbaXU94Z73S1arO4rq0pe94g/B5yMXlMN/xAHPcQc/MrXnTWDVwz2xaSUlStRMYmLy38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736449258; c=relaxed/simple;
	bh=0lmhxLKtEk9VkTgGPhb0RQ6KjQxWTeXdFCDl11tdZR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ms1WWFPFNKdO9JYHCg1O0DAxkJAPTSoJvt02xXOJGe4FUUyb+J+TgHcgsWxabVqL97oI8WEnwQllT+FvCcMiQ7rscYn48Gi65fOn7bCUkvyLuFPV//ndhmBJHOSx9g+vs0x5ajBuee5VLjjpxiVq8vi/MCwCV0ZEUhMWsiQn4ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OBmZLgdZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jfngTErN0l6iXS1zI8owzIov4Rxwj9txPJ14y7STSzQ=; b=OBmZLgdZ+ZmrtRlmwK3RZGdHUv
	tuTsDimCHGtf94u7cWcAEZPUPKdRp7z+db11VgDyZsk0MveXG0xmNezIb4RL47j8s2QKQcgu/7T1g
	YGuibtXan/fXW1QfZfUtZuqAhDWS0q4BspwWymvfW2I0JZElG7JHvVkM7jDGI7btkKCs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tVxlw-002zLk-5E; Thu, 09 Jan 2025 20:00:48 +0100
Date: Thu, 9 Jan 2025 20:00:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: dsa: qca8k: Use of_property_present() for
 non-boolean properties
Message-ID: <1cb9d60b-1acd-4480-b7a2-7e8eebca75a2@lunn.ch>
References: <20250109182117.3971075-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109182117.3971075-2-robh@kernel.org>

On Thu, Jan 09, 2025 at 12:21:17PM -0600, Rob Herring (Arm) wrote:
> The use of of_property_read_bool() for non-boolean properties is
> deprecated in favor of of_property_present() when testing for property
> presence.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

