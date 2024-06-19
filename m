Return-Path: <netdev+bounces-104972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AACF490F550
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 19:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637C21F214B4
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 17:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F6A156967;
	Wed, 19 Jun 2024 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEBMMooN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC1A15689A
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 17:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718818855; cv=none; b=gFt5PWdVCKNUK4Oowfo8CPZKq36msZ6sJoxkWF3bELoHMJjz0pv95XGEuCdTa8hfIRtUKCA94ullVz3JzDLTyHenwybYSLB3mfQYuRU09hrFc1eSb78YBRr8FRxbfz8wJ/6xXI2iPbc56DbsgXSH6T+dZaXfpZgoiU4Xe0xQAHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718818855; c=relaxed/simple;
	bh=F8LH4KtNW9DVlCnD3+/RpnZqvugOqzRc5vMD1irCEbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWoSCXvb/WSbeb8u0l6jXRI8tFiihjY7nE9aVwOvqOxWrttoXxhPAJoJkFACp9bW9Y0YBsKDr1zaJRUHOxMo7JIiQ5lk1/xQbzXQbc4Xq1UZHewSsWzvxhc86kjjgVBIjuFbMW9ASlXsThGZkuz/Ddt5Fm0b0+8XUgY0q60zP4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEBMMooN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDD0C2BBFC;
	Wed, 19 Jun 2024 17:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718818854;
	bh=F8LH4KtNW9DVlCnD3+/RpnZqvugOqzRc5vMD1irCEbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BEBMMooNs87lvwB5jGDvQTJqhDOlCgyaNGSyNYGYqg2bDzTqaib6IRs3Rh8OkkyaJ
	 mRD9LmDQlHzLNLWy8Bmpc8PiFmqu6um+x3fc3NuzPKOxDpqzd0O2oRdH9+IKKJPcUk
	 x2glQ6RfQhe9WvsfsXbOAPdjpr3hjB924UNsvYnYsKFO21FWPXAEqmdL2DkL7WyNVW
	 fBXk/PWZqoHL3DkTjW0YoiYnTn/wTYd9bm2FozbM0XCejnSdlvg6ku/y8bnC98vE1v
	 rl8AVeu0ufsE2uuo33Chjp6oaioTyr4I4+bsKT3yD/P8voKkasUlidItEedjyK4Nj3
	 JGaWeRpyWL4+w==
Date: Wed, 19 Jun 2024 18:40:50 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, dumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew@lunn.ch, rmk+kernel@armlinux.org.uk,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v3 2/3] net: txgbe: support Flow Director
 perfect filters
Message-ID: <20240619174050.GO690967@kernel.org>
References: <20240618101609.3580-1-jiawenwu@trustnetic.com>
 <20240618101609.3580-3-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618101609.3580-3-jiawenwu@trustnetic.com>

On Tue, Jun 18, 2024 at 06:16:08PM +0800, Jiawen Wu wrote:
> Support the addition and deletion of Flow Director filters.
> 
> Supported fields: src-ip, dst-ip, src-port, dst-port
> Supported flow-types: tcp4, udp4, sctp4, ipv4
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Simon Horman <horms@kernel.org>


