Return-Path: <netdev+bounces-106236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772859156D6
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 20:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE622B2411A
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 18:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8962319EED7;
	Mon, 24 Jun 2024 18:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GR1Zx25p"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A692E400;
	Mon, 24 Jun 2024 18:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255541; cv=none; b=fvJIvSp7BC4DsSlo+84UA2JZpke7/fLy0YsSEKacWHCdlvHdCjwQMDaxRqFkEiIAuxeCa8W3/CBq5I9hyY0uNG0GhvrREUBhEu28YgJk59ULQiSNwrSvsH9F/zj94bgFP+8JFBMo5Wl0Bkbpf1iTVqNtLfI3rHKRjtJXWjXccB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255541; c=relaxed/simple;
	bh=vjAK4BHFcZgLQEnSbH4lyl2FcXXdbm52EvC+Zt7q808=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTEcaXLG1+GTkA97Bfw/1fUt7T/IjqMQP5p14K91Cs7RuRPxTQIogm3SYf3xRRN3WURICjjth0qGOfprsnZKUMMaTtRVEwUf1GPvXFfu+rHF6N2Z+VSSfoi7owlq0kp79ItlfbVeCRGQG10owqc3C0aW52sMu8xq78pXUJKNcgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GR1Zx25p; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=K0lyMj3UXzLsvO1X8aghEUe7sBxLcfkkq8Bk5NmS9R0=; b=GR1Zx25pDUYo+GXpfSmZwsELQt
	AAa5cyhowk4dKjxhY8eSrpEBGFha3acBmMNL7oaLMCytLbSsEdAvJQqdZ3a/GS0FAQmt5SRl+lfyQ
	FxUHxVoTRnAVk5UIbTS8pD/nISsPXT3JoYQVBOV2TZcKBXepFcsLFK5fzuzmIqLTbmS4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sLott-000sSc-Nk; Mon, 24 Jun 2024 20:58:49 +0200
Date: Mon, 24 Jun 2024 20:58:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Li <Frank.Li@nxp.com>
Cc: netdev@vger.kernel.org, conor+dt@kernel.org, davem@davemloft.net,
	devicetree@vger.kernel.org, edumazet@google.com,
	imx@lists.linux.dev, krzk+dt@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, madalin.bucur@nxp.com,
	pabeni@redhat.com, richardcochran@gmail.com, robh@kernel.org,
	sean.anderson@seco.com, yangbo.lu@nxp.com
Subject: Re: [PATCH 1/1] MAINTAINERS: Change fsl-fman.yaml to fsl,fman.yaml
Message-ID: <af3c9b4b-e315-4f8b-b76f-f68911645227@lunn.ch>
References: <20240624144655.801607-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624144655.801607-1-Frank.Li@nxp.com>

On Mon, Jun 24, 2024 at 10:46:55AM -0400, Frank Li wrote:
> fsl-fman.yaml is typo. "-" should be ",". Fix below warning.
> 
> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/net/fsl-fman.yaml
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406211320.diuZ3XYk-lkp@intel.com/
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

