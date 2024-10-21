Return-Path: <netdev+bounces-137562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68589A6EE9
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 17:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 104091C228E4
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 15:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57F51CBEA3;
	Mon, 21 Oct 2024 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Id5ylvoy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A52126BE1;
	Mon, 21 Oct 2024 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729526373; cv=none; b=N66GIgICxkpg/bdkkMxVWGtiaINZPTXjYFCVpMPmPY1iJ58GbDylc84Gr6pG+cZpBVSIRHrldTZ5W7eUGhN28iwCrHKlD3n22b9PNDGYWgzxs7BKSIZluSBlAP89IrbIkWUI7Xv5PokJm6KL5BlavZm+3i9FNDI/BiNc+4TfICQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729526373; c=relaxed/simple;
	bh=MdoulQAt/gdxvf5kX71Mo8/Y8Uz9Q6BD/3TmzYzDocc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIT1vugzUWOyEPIw5nKouJVjWzJSGRcNdWTp8UqIgg1P5p6jsnFLv5ZyehaQDWsN5lpEUqFW8mOlGtzL4HtekcD22AXhG9sGpMVajpU3EcNpMcKvfd6iKXTavCbTxKsPDYMWII29EZQiREsLGv/6epE9evOM4JFZZO7kpFAsgrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Id5ylvoy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DHtdsSRQ0yhaslAu/9YL0JSM+UTwFlfWIijNxd1yrgU=; b=Id5ylvoyYPEGzo2drfOvb4xL90
	BQyTgW1fUlFnSOGneNQAKqRbw7F7qRB0DOHb+FghWLVk0GQBKX3+L1MSoT1ozFu3K4JEr957nNRLq
	k/XkKD15KMAmdTR7gfDFL8c4JU03LFjExr7KuuHWKDlHiGaBNPP+LEB5005d2WzzMxnY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t2uoX-00AkKD-Bk; Mon, 21 Oct 2024 17:59:25 +0200
Date: Mon, 21 Oct 2024 17:59:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: mv88e6xxx: use ethtool_puts
Message-ID: <8555b167-ed19-4b30-b191-1219fddd51b2@lunn.ch>
References: <20241021010652.4944-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021010652.4944-1-rosenp@gmail.com>

On Sun, Oct 20, 2024 at 06:06:52PM -0700, Rosen Penev wrote:
> Allows simplifying get_strings and avoids manual pointer manipulation.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

