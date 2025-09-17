Return-Path: <netdev+bounces-224112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EECACB80EAF
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 18:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27AAC62716A
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C682FB097;
	Wed, 17 Sep 2025 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4gAVDv3K"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2225D2FB0B7
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758125171; cv=none; b=h/0QvtmuwHRYJeZsypMqx7mTJkITbObuUffXo0Ohn8LbmdAAIbBLCZrkPy7+7M5TGxtlXBrhmFp42C8KjuBFFmIeyeruUlglYu6zAIhv9CEjonQif7FV9LrUC2MS3kohjNUvCAO3yM1at/u1zl7JeRIGAJ0tK6LzFKW+zTjvABM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758125171; c=relaxed/simple;
	bh=fNAjYCt/dU7H8sBgKv5dg+BUdC6OpbrM6DMmuH8vkEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MybbJAfCiZU6PPtQuuay5aRsmBc8cVdM4z673dP7BFz2qvHmd8mUqcZRex3fZRfYiOjOypdDTjQjSFcm+gpsfIno35vppkol1QlksXJTXrGyKsayzUG9NOPS/lygerip/CqnYTnOYId9O1QKs3+FY00SZl9mhWKEu+Dp7J/MWYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4gAVDv3K; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=m/MDqomzgI6pBI6nzwPoyNMxfPqurjDyksayxWbnCpo=; b=4gAVDv3KBeS8AM9m1eLUQ8EEHP
	/eLkmu6ZHO+D7AzvSphkC4ZzhwcSm09xxT67z/X+XjM2VfJu9hixVO9hgeTdoQIc8KvPpYBYNNEoM
	A+qxnNULJiSHyQe9aJm13rQmOEY4P3/N+uiG011m5NBWeh07dLks7u/QsjKuRUJsNeVg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uyufW-008iDl-4Y; Wed, 17 Sep 2025 18:06:06 +0200
Date: Wed, 17 Sep 2025 18:06:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Petr Malat <oss@malat.biz>
Cc: netdev@vger.kernel.org, sgoutham@marvell.com, lcherian@marvell.com,
	gakula@marvell.com, jerinj@marvell.com, sbhatta@marvell.com
Subject: Re: [PATCH] ethernet: rvu-af: Remove slash from the driver name
Message-ID: <a12eb1fb-6110-4266-b60e-2b74c1927418@lunn.ch>
References: <20250917071229.1742013-1-oss@malat.biz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917071229.1742013-1-oss@malat.biz>

On Wed, Sep 17, 2025 at 09:12:30AM +0200, Petr Malat wrote:
> Having a slash in the driver name leads to EIO being returned while
> reading /sys/module/rvu_af/drivers content.
> 
> Remove DRV_STRING as it's not used anywhere.
> 
> Signed-off-by: Petr Malat <oss@malat.biz>

Hi Petr

This probably should be for net, not next-next. Please see:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Please also include a Fixes: tag.


    Andrew

---
pw-bot: cr

