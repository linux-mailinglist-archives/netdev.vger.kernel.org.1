Return-Path: <netdev+bounces-181376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5183A84B26
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 19:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25BE13B77E1
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 17:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5AB28F924;
	Thu, 10 Apr 2025 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dpWrYRR9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC2728EA50;
	Thu, 10 Apr 2025 17:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306612; cv=none; b=A90J4muWuOW9Lk+k2Yl2RQ85Uc2sX+qMjzs7CLpAFsuS2nNuBrzNnWlblVeQbjKSUBB3O6C9vxTVDjwnrsV/yB1xXItbO+q2L8IWFOQpUoqcf5WzWWCKy63Q62I3t/SI6bAa3u4/X5kxIeqGncMUdnvka2503u6NSsHo6W+QmVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306612; c=relaxed/simple;
	bh=t7HKnATgmCsf3hGTnDANUpJF1Vs2UUV5sxwrpaZGqZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvNNRAUtA5tMr+N43TgYGT0249pc7UihMss5kY+4LYw+51DHvlFmWJHA49RM4E+7TCIWaP0I39CYJi1Bptr8cDDOLCZp2r1WVjINavMurN8btdL1t9+WNUwqMqgaKxvLqk8qaxBZobCVsNJN+m9zFxH9LohRFx2DNy6vOdNjRfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dpWrYRR9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bekYy2UKLDPJOi383/IFEmXjLc1ik86Fy2UFdlonMbA=; b=dpWrYRR9yUA+NgE9r8G+CzYkAe
	KUpxJql71SsF2pILHM75BFUdI8lmtedbJ8coxAsPPs53US+gBqjKxm7/NjSMDIfYOoL0tgGF5qSXG
	ndzU0R6jfAXplP6wL4vZP/XY33f5rlGMdBCr067cGmjrKC1cIHafG8BmPfnamuCrnrqk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u2vpO-008iGA-I5; Thu, 10 Apr 2025 19:36:38 +0200
Date: Thu, 10 Apr 2025 19:36:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Prathosh.Satish@microchip.com
Cc: ivecera@redhat.com, conor@kernel.org, krzk@kernel.org,
	netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com, jiri@resnulli.us, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, lee@kernel.org,
	kees@kernel.org, andy@kernel.org, akpm@linux-foundation.org,
	mschmidt@redhat.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 02/14] dt-bindings: dpll: Add support for Microchip
 Azurite chip family
Message-ID: <bd7d005b-c715-4fd9-9b0d-52956d28d272@lunn.ch>
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250409144250.206590-3-ivecera@redhat.com>
 <20250410-skylark-of-silent-symmetry-afdec9@shite>
 <1a78fc71-fcf6-446e-9ada-c14420f9c5fe@redhat.com>
 <20250410-puritan-flatbed-00bf339297c0@spud>
 <6dc1fdac-81cc-4f2c-8d07-8f39b9605e04@redhat.com>
 <CY5PR11MB6462412A953AF5D93D97DCE5ECB72@CY5PR11MB6462.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR11MB6462412A953AF5D93D97DCE5ECB72@CY5PR11MB6462.namprd11.prod.outlook.com>

> Prathosh, could you please bring more light on this?
> 
> > Just to clarify, the original driver was written specifically with 2-channel 
> > chips in mind (ZL30732) with 10 input and 20 outputs, which led to some confusion of using zl3073x as compatible.
> > However, the final version of the driver will support the entire ZL3073x family 
> > ZL30731 to ZL30735 and some subset of ZL30732 like ZL80732 etc 
> > ensuring compatibility across all variants.

Hi Prathosh

Your email quoting is very odd, i nearly missed this reply.

Does the device itself have an ID register? If you know you have
something in the range ZL30731 to ZL30735, you can ask the hardware
what it is, and the driver then does not need any additional
information from DT, it can hard code it all based on the ID in the
register?

	Andrew

