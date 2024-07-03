Return-Path: <netdev+bounces-108984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBAD9266BD
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 19:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EABCCB21D04
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D121836EC;
	Wed,  3 Jul 2024 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRKVn+AK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2E5181BA8;
	Wed,  3 Jul 2024 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026448; cv=none; b=OyuVhq8bmqE0nwMSG0k21GXrFlF/9HJGUnD9XnQYtaMyAMdKiIQY3PVDTNx0j8uBr16XTv1O+/J83BrZt0iPpQFwjJ/W0hklRCyIP6mw0eshS8eSCjkrZ/6za/Pfv6wolUDYxvDmkyKbcpFcll5lP7pvCIa1+p0oBr+yvc+fmrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026448; c=relaxed/simple;
	bh=9eoWwn2g0lrKnFdEAzvoJLuWc280RHi5NqBoOjcHqH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izezhswT+LwyYOEDQ1EkFbhB9bcS69z+jIirwgjoL/vsB2vcZUi/UBuMdPc+dwC5tTLnpkwMyDu9lPCoPTdS68qF+jQ1kXqHE8186pSVH+WPycksNlE6mcorOJ6dKGPt8hYks067sqwWxoDMe3vaNais4SvgGtqzag+/ShII94I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRKVn+AK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8ADCC2BD10;
	Wed,  3 Jul 2024 17:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720026448;
	bh=9eoWwn2g0lrKnFdEAzvoJLuWc280RHi5NqBoOjcHqH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aRKVn+AKXhm5ClANXRiYnvN5FugViwp6L8miNH7L1VXMgJPsqgeAHpWL510eZWm7b
	 vimtGWP30yqNzvgih4qFRANrH+gjPplPOBF9LRcbyM7JhpdNDl5RYc4M6LH35jyc0B
	 pxdn/QlaEls9Fuoalpq9H0XDVTg3440syW7CV+Fi5ZVoXoXPZtYcaF5mgYP6NSj/ZL
	 YfYfSFbNeEoERF/sOfqVngwLFj4Ln0YhiLkhKuDdZ1tRvCHrm8NuUvtebExW2WoWCp
	 4TWtNInc5CGrJb6k/MMRwH9OsmcphaLDENOcOYkKv+pJlPagsZSFO/309WrvfnDE0Z
	 YJuJer5ICHyIw==
Date: Wed, 3 Jul 2024 18:07:23 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
	rkannoth@marvell.com, jdamato@fastly.com, pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net-next v22 01/13] rtase: Add support for a pci table in
 this module
Message-ID: <20240703170723.GH598357@kernel.org>
References: <20240701115403.7087-1-justinlai0215@realtek.com>
 <20240701115403.7087-2-justinlai0215@realtek.com>
 <20240702164829.GL598357@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702164829.GL598357@kernel.org>

On Tue, Jul 02, 2024 at 05:48:29PM +0100, Simon Horman wrote:
> On Mon, Jul 01, 2024 at 07:53:51PM +0800, Justin Lai wrote:
> > Add support for a pci table in this module, and implement pci_driver
> > function to initialize this driver, remove this driver, or shutdown
> > this driver.
> > 
> > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > ---
> >  drivers/net/ethernet/realtek/rtase/rtase.h    | 338 ++++++++++
> >  .../net/ethernet/realtek/rtase/rtase_main.c   | 638 ++++++++++++++++++
> >  2 files changed, 976 insertions(+)
> >  create mode 100755 drivers/net/ethernet/realtek/rtase/rtase.h
> >  create mode 100755 drivers/net/ethernet/realtek/rtase/rtase_main.c
> > 
> > diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
> > new file mode 100755
> 
> nit: Source files should not have the execute bit(s) set.
> 
>      Flagged by Checkpatch.
> 
> Otherwise, this patch looks good to me.

FTR:

Reviewed-by: Simon Horman <horms@kernel.org>



