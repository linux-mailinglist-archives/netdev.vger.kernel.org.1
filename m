Return-Path: <netdev+bounces-153261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1E19F77A7
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 09:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A3C1894899
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 08:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058582206A8;
	Thu, 19 Dec 2024 08:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="olhwfwvZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571D5217728;
	Thu, 19 Dec 2024 08:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734597780; cv=none; b=JEqViJ3VVKTWzz9m+uHG8ZYX302I7DtPz4Ks4KZUNxZzpF7XlGdyWcStcyUGGrZSZqsDgXEKlQh2PWxZbet/NKJh9tms3KzSeTvdFP4rh3nCyqi9cYlXQJhJLyTeCsd95j1QZ9ifUpFARwtqG+FHju3C/75UovjOF57r5M74XVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734597780; c=relaxed/simple;
	bh=NRq2i384taxxZARdZXdORNH9JNRzC7xXvwMyuH8PwqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpOAEZICEvVgLajmte4olZL8xRsQtc3xaWn8ETP49JHwAzemPpQ6G4BHFszzb13EUWnsIJ/0gM8M5YO8nWikGthPAOut781tfDnSeqc0Myf2d2qUVJSu0I4ily7sU/ACH5rYKB7ODnJcWEhJiBGJ7xNEuHPR2di+N7OLJaH50R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=olhwfwvZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=do53qTy1FJkzBEMjHcZ3Pn3ZOf9hDME5r2pFUppjpa8=; b=olhwfwvZwTZzPhvP6CyFcM2Mro
	F2beK/wVfzIOisB1gS30N49/qjum6oSn5LuD4NWpmR6fY/NcIrkFzE6XXnOgHk0NxV4n1jKIoPIK4
	t4DugUYe2yLYgZ30kJYzOAtT51B+7WK57at8HVlJXpFi4Ru53Lme54rJanA+SC/4Dgl0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tOC7S-001YBp-Mz; Thu, 19 Dec 2024 09:42:54 +0100
Date: Thu, 19 Dec 2024 09:42:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mdio_bus: change the bus name to mdio
Message-ID: <8f69b67f-9b70-4890-86cf-90726612c444@lunn.ch>
References: <20241219065855.1377069-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219065855.1377069-1-yajun.deng@linux.dev>

On Thu, Dec 19, 2024 at 02:58:55PM +0800, Yajun Deng wrote:
> Since all directories under the /sys/bus are bus, we don't need to add a
> bus suffix to mdio.
> 
> Change the bus name to mdio.

Please add an explanation to the commit message of how this is safe in
terms of ABI.

    Andrew

---
pw-bot: cr

