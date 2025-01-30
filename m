Return-Path: <netdev+bounces-161664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC0BA231DA
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 17:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5768E161C90
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 16:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6C61E9B3F;
	Thu, 30 Jan 2025 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnVKEmy2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D811D1DA5F;
	Thu, 30 Jan 2025 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738254666; cv=none; b=fWqXS9Bwk69BhRXi1q4KBhV5r9cHEzV6iMOWhFO0KVfPofA4DZeFeqThAo1QxS/GIN6K/LsnEsJ8d8cGMRbXKsDGWjWsFACLt/cOCy1ITGYGCLG8QO1zMHOidHjwo2uVHtMELJweSaQ8bIwuzXnxiNPdXikiTZ6aerkM5xbimws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738254666; c=relaxed/simple;
	bh=DNHRIyQQAl0iDXxcXATkuv/Ll8kfRJVZqASir1JJU1k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QSVCQyh7nGqD2DtgkZ/Ug46GpzviA3EAn8oKsNEvTQEIzB85QLr5sCoAHKRVbmLTs/qfgAw0VKBJONB233pyU8k/bH5gCcmAEUgD32cQK5QYEiIdKqT0c7zn4Mrzy50OHLTsvJb6LIfDZacyBUFuHFwQq+/TlzokVVU4MGDa5cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnVKEmy2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F067EC4CED2;
	Thu, 30 Jan 2025 16:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738254666;
	bh=DNHRIyQQAl0iDXxcXATkuv/Ll8kfRJVZqASir1JJU1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CnVKEmy2ceqR0WBb9WvYSzlMKAXSzUkQVASWimzNoHwPU8lKB9BTiFTouPZ9n9ecI
	 EvS1lJGXe/xwCSyt8OLCTHFzOuRFU48elpkWQLCzE6YauXva9JAk4tD5LiWr0xCLVz
	 WGv0+LnnzRtlWJCP3HUOJFISimWsiQbhI9PfsT/M2A7ALKN5VNKz5+W9h3EGHrqhRV
	 ihKn3kTWA5F05oNZ+BYDi3Dl0oOObPiFjVRlXZBGUMUbU8o476IbpyQ6hEsuhnMV6F
	 W9MsOUTYta/vx57YFfQ1br++Ab5EnU4ZLLB/3EVODWOLpGoGAHySb/LPL6PwvWnYjD
	 A5+I2JEV4iJ7g==
Date: Thu, 30 Jan 2025 08:31:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net 1/3] MAINTAINERS: Add myself as maintainer for
 socket timestamping and expand file list
Message-ID: <20250130083104.7f66ff2e@kernel.org>
In-Reply-To: <20250130101811.5459c3f8@kmaincent-XPS-13-7390>
References: <20250128-fix_tsconfig-v1-0-87adcdc4e394@bootlin.com>
	<20250128-fix_tsconfig-v1-1-87adcdc4e394@bootlin.com>
	<20250129163916.46b2ea5c@kernel.org>
	<20250130101811.5459c3f8@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jan 2025 10:18:11 +0100 Kory Maincent wrote:
> > > +F:	net/ethtool/tsconfig.c
> > > +F:	net/ethtool/tsinfo.c    
> > 
> > Does that sound fair?  
> 
> Yes it does. Whether setting me as reviewer for the SOCKET TIMESTAMPING subpart
> or adding me as maintainer of these two files it is ok for me. What do you
> prefer?

The latter, TBH. I'll send the patch. We recommend setting up lore+lei
to subscribe to threads which touch particular files. It's much more
scalable than adding interested folks to MAINTAINERS. Tho, last time
I looked lei didn't support the weird mdir format used by claws :(

