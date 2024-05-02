Return-Path: <netdev+bounces-92989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9C58B987C
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 12:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BFED283B6F
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 10:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A54356B76;
	Thu,  2 May 2024 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swsVCt/b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360B24DA1B
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714644479; cv=none; b=HU8MyAlBr3u4OxMT9fY36m1NHAXD9vdmp5ddiseGgID6EUpbBrUxg0SDgc3n6t+2rufuuM25OaR9fCRrWN9nmm6rOpPqCV/nO3bzxevwhP4kAfUX2thyiip+8AyJu2BVcLX19WkoRUhaKieX1sUgU/S5os/vogN+pCr+Q0SnaZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714644479; c=relaxed/simple;
	bh=DbIDTlfALD5Ib8Gf7sf8OqFvtuNq2jCMQ5CPjSBWDTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlFCh+OEKAg8vQgB9V4FqCsiQStrQ6KmPP0o/HOmfZOKl8tFrNaxWk4/BI2gs2quI59TOeX3YqmFgBgIAPRU5X/BoT8czREuLRJlefcCDYUvzedOck6QWXpib8zXYcSy1cvGOZRvdKfkSI5Wcsjj/dOYafw57mdubPAwij6YkHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swsVCt/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410B2C113CC;
	Thu,  2 May 2024 10:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714644478;
	bh=DbIDTlfALD5Ib8Gf7sf8OqFvtuNq2jCMQ5CPjSBWDTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=swsVCt/b1KzrT9qkfmvZeF6luSdx964I9ZYBh3TV4s4JpgKG+l80+9GSPqTKxvOka
	 9/8rPlz31xY1HX3zoQhplxZKEU/4CVQZGQuLHHytQDL0AvoJCbo8K/KL4ZjUpQiGZ6
	 bJHFg1mulzHURoWgrrwQ4wPt7zWRCWl7E1wc3XpkRGby6OdE9gcTy/Jqo+lLhYo2vX
	 J4v/yMs4oEDQ4+3dLCTU7pxRxaU5ZNosQ5wfLK8D0WjZ0Uavk5kE5nl1zGkmGESD1V
	 lX4hrzM+IEtbqxsWiCYQtc0lmSdVQKS6uPEGOhJxrlaEofTWxRx57CHgyDgbb7ZxIE
	 iyoq/ff211PEg==
Date: Thu, 2 May 2024 11:07:53 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew.gospodarek@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	Selvin Thyparampil Xavier <selvin.xavier@broadcom.com>
Subject: Re: [PATCH net-next v2 6/6] bnxt_en: Add VF PCI ID for 5760X (P7)
 chips
Message-ID: <20240502100753.GJ2821784@kernel.org>
References: <20240501003056.100607-1-michael.chan@broadcom.com>
 <20240501003056.100607-7-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501003056.100607-7-michael.chan@broadcom.com>

On Tue, Apr 30, 2024 at 05:30:56PM -0700, Michael Chan wrote:
> From: Ajit Khaparde <ajit.khaparde@broadcom.com>
> 
> No driver logic changes are required to support the VFs, so just add
> the VF PCI ID.
> 
> Reviewed-by: Selvin Thyparampil Xavier <selvin.xavier@broadcom.com>
> Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>



