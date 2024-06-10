Return-Path: <netdev+bounces-102400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F308902C99
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 01:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0812831C9
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 23:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D008815219B;
	Mon, 10 Jun 2024 23:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OXXTyHqd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04283BB48;
	Mon, 10 Jun 2024 23:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718063412; cv=none; b=ps3e3p2QWJYtFUiuuamAyoxusspS0dpVrrqkJAgysPsbUuSBLnHI0o9UgedNZmdWjJLySY2jUMyWMGqS+E58OemlJL9TxsqrH4eHZZtnJWY8/nxLWECdy//TlkRPYMdPKPVSI0Uf+f0PWCrLIs7pX5KJzhh2XnNMsk3qnhQmeK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718063412; c=relaxed/simple;
	bh=GSZ9ox6lIuV8HBDQteAf50c/wbFbZZ5Ws4kYzDKBr+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9SFXyyfrlzzw4fKLYbm4fQXT9JXHtKvNYcEXZZNoaZ9hOLHc2RIrwB+SkN4PZlmD/2Sh8vx0egvj3xzbVmxK3q+gQbj+BuawSR4SjcrYKr1DVSTylQlgWDQ01Z8t/Rm9bgdnTZHq6h+88PNms7zZi2DReEcLyagpczDvXWvfIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OXXTyHqd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ln+WVy76jUn+P4EBY0LbwmFreIynli6ZJaL1IR10J/w=; b=OXXTyHqdGOo4ngCAwmxJv5Op4M
	v/H3Mg46ok/Mzkj/sH9unq+Hwe5rHCYsbPwwjVQZqb6I4VEwre2KgoMGRkNWzyrDFCyR8r4OhGkmt
	OwRg0VRVLKjZ8VNkSNe4CaJlZyZdJoGgsz4N9wiez7RklQC7nT4Fe1yiN9AqNLEPgoG8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sGolq-00HL2q-Ui; Tue, 11 Jun 2024 01:49:50 +0200
Date: Tue, 11 Jun 2024 01:49:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next 1/3] net: xilinx: axienet: Use NL_SET_ERR_MSG
 instead of netdev_err
Message-ID: <42fff229-ee8c-4738-854b-6093f254408f@lunn.ch>
References: <20240610231022.2460953-1-sean.anderson@linux.dev>
 <20240610231022.2460953-2-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610231022.2460953-2-sean.anderson@linux.dev>

On Mon, Jun 10, 2024 at 07:10:20PM -0400, Sean Anderson wrote:
> This error message can be triggered by userspace. Use NL_SET_ERR_MSG so
> the message is returned to the user and to avoid polluting the kernel
> logs.

This has nothing to do with statistics. So it would be better to post
it as a standalone patch. It is the sort of trivial patch that should
get merged quickly.

I would also comment about the change from EFAULT to EBUSY in the
commit message.

    Andrew

---
pw-bot: cr

