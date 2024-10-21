Return-Path: <netdev+bounces-137561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96C09A6EDF
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 17:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ABDE1C22B12
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 15:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A481CBE99;
	Mon, 21 Oct 2024 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZHJMJlbz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15D5176ADE;
	Mon, 21 Oct 2024 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729526189; cv=none; b=YoFvWrMbpUyMxaKbZ5rE9E4iug0RGfxjO6C4gPqKW7a6TFVYT4UipOknpDy8inTjaJlzTsUvOQIWQOeSmvPDHU8Lte7h8OHUv5g3zDKBt8cXdx1UjLP4sqJCVdWrqrayUJU7Qy/X/AjY6m+MMWSh7/ACcb12WjpygrieTl1Fm1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729526189; c=relaxed/simple;
	bh=4LJ6ltHOMbD8l5HB9Na3hpBNuvyDBnC2dorgWJ2pYTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8xc0E3Uk0FnP9X3Jv4Em/Nmfnusp5+8uA8z6stxZjqpLdrDN8ECNIPuMDnuQ1lbMI4zI1eHx+TvZEmB/GFS8To7F0QqeDd2/5mepjXWGYRN3I8ffU0F6kFD+Pk1MCGon/k1HosX9Q0YyxD5TRgGCgiGBkb7qf/a5ekGzky39Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZHJMJlbz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=klBZtZzs9/z097DD2p+GRfLh//efNgEyHmVmSF1vI/4=; b=ZHJMJlbzT5ifog/fmgruA9ol9Q
	/Fq5Ae1SImJaKM1YWTKd1pCPUgOdFlW2ZxxkmrzIAOY9L+yc9fxGWQ9xQvNuNiPrV2BE5F913JHA6
	YRxT2Iqd6VxDvfSOmf7LnwJqmL+ScgBc0THOTAIJo/PNF8FQp4P9kNFk06RdNTqOmkcg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t2ulQ-00AkIg-I1; Mon, 21 Oct 2024 17:56:12 +0200
Date: Mon, 21 Oct 2024 17:56:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: mv643xx: use ethtool_puts
Message-ID: <0f5ce9ec-14ea-43aa-bbb5-6fcbec032124@lunn.ch>
References: <20241018200522.12506-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018200522.12506-1-rosenp@gmail.com>

On Fri, Oct 18, 2024 at 01:05:22PM -0700, Rosen Penev wrote:
> Allows simplifying get_strings and avoids manual pointer manipulation.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

