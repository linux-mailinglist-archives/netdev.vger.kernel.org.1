Return-Path: <netdev+bounces-108081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A27391DD05
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 12:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F1F1F211B5
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 10:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1402D85628;
	Mon,  1 Jul 2024 10:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzEJwEAb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9E084D13;
	Mon,  1 Jul 2024 10:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719830954; cv=none; b=SCDH5+cdOwUIAD6F6+Q60GX7aavE6/tCu02A6l/CXslqkQnGbSnsS0lbpfqY6DREFa7tetomLD+0TU3XmwKoDgIGZJTyjNmq0VD14G7GwciI6VcPrCz1AKQ6I6u9kn1ZXULMVG675e1aP6OhCeId0XFoVAPi+ngFVoRbTAIkVT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719830954; c=relaxed/simple;
	bh=3e24QcLTp8FeaqS0YgW7i3cZBp54an0X/zu22pQoWHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pY/dkInjebT3s6nNDn89eVwjSFJq6TmpfNfhSwxGdDBKMv5wv3PxSGt5xU3ZcrZ/ST9893rhRGMqyc0ok2Iajz0tbRxsszoGo4dDaP7KzX3bdcdQp63OHragOPeojf2EJQdGBDbYR9ZnXLaMfw6iEEcAaSyJ7t3mehsgG0RhKTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzEJwEAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629D2C116B1;
	Mon,  1 Jul 2024 10:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719830953;
	bh=3e24QcLTp8FeaqS0YgW7i3cZBp54an0X/zu22pQoWHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kzEJwEAbKwsNDW2Jd6fh0ayOwWt3XsUDoUR5rKEf0+qOIjrGb3oA0ICD+7BBuFog9
	 jyCuBhpZ7eN4RIYRIwXPH+Jjl9p312FK8Og3cTkess60LtWLrbo5XrlK/lMOPkUCzV
	 AjEF/rfakcv8E95wIahZmyyVb28EtOukDoLTomh9VRB8hDBbmeYUhM+kpHgDL2y+NE
	 UzLMxa5KCm3A3uAaoxuad5o1GziGYRt9eya49kJ/96hab1AtsaT3kOfTqvivMKDaj/
	 nd8gEYVRdoaQWogvmAANqLZfMPpw24cJ5TY+Hfn37BvPFqOaxZ1sxx3vmeW9hZIx9L
	 mAETI5dU/XpMg==
Date: Mon, 1 Jul 2024 11:49:09 +0100
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v7 01/10] octeontx2-pf: Refactoring RVU driver
Message-ID: <20240701104909.GP17134@kernel.org>
References: <20240628133517.8591-1-gakula@marvell.com>
 <20240628133517.8591-2-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628133517.8591-2-gakula@marvell.com>

On Fri, Jun 28, 2024 at 07:05:08PM +0530, Geetha sowjanya wrote:
> Refactoring and export list of shared functions such that
> they can be used by both RVU NIC and representor driver.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


