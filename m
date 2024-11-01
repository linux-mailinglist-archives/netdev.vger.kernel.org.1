Return-Path: <netdev+bounces-141063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA4C9B956F
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 17:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1611C2201F
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 16:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0820D14884F;
	Fri,  1 Nov 2024 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Umzd/1S2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE20137747;
	Fri,  1 Nov 2024 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478695; cv=none; b=S4LWVo12zFbtb2vWg6RfPpYgru4/7UgxUqylWY6A9s4iNbW0ErKPPqYaNNV+Rr9z8EJLmVTbiAc0ERzaVerkPyCLL0spBW8fhHDqItBx88fYttpsmA956E07AvfMOVaKteCr3ndLv0o0AoCV+tXsksIs6pIfM8Gk89cCAu/RP+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478695; c=relaxed/simple;
	bh=elpsGko6Bj1ALymA5v5gavqHeM7GV37sKg52ryw5eLE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ex4vmPvK1DCqB2wMvH8m5haoijcpytUrvH5XUbX5iD2ux3qbzqEBS8iVtlb6w5HFk/ung/pBK49jQcp6tsO/LpGBotKXc7ub9me4Kq2u5hLurRPyOVQsleLTt4Z1clUZo5U3OdQpaX6d+HKDrETk9nsaoT2NjaI7nYFD3WMzwow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Umzd/1S2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA09C4CECD;
	Fri,  1 Nov 2024 16:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730478694;
	bh=elpsGko6Bj1ALymA5v5gavqHeM7GV37sKg52ryw5eLE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Umzd/1S2Jn3fqC0MHd5sLAE0MhNTdUOjAI4Wzcq43nX/t2xer2R145BYAq5sUjbEz
	 7QQP0R8Omv8ecuy9KUNLRN/APAlWIU/QMfTIUF7BWg+8XhI8N6mNigd/qU4lkd6OYD
	 sqN4nqAUaQfowQ50Tf3RsrO6rj1lCsVtt8v2LnC9jVEqXyyQcPIL43HuMhYvgugo3Z
	 f6yuKmU1cd1OK9Apqx9qzKrVZF+XXj+veqKg8Rb6vUughKlJXwb3EtAj6916xOELce
	 IO8KSBU4Rgw4hvJAADZgBFKeoZoXTH5NSx96HAynwLGS4n6Itl4ZYcghKJeBJozVoL
	 It4R+O1HSpCLg==
Date: Fri, 1 Nov 2024 09:31:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lei Wei <quic_leiwei@quicinc.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_kkumarcs@quicinc.com, quic_suruchia@quicinc.com,
 quic_pavir@quicinc.com, quic_linchen@quicinc.com, quic_luoj@quicinc.com,
 srinivas.kandagatla@linaro.org, bartosz.golaszewski@linaro.org,
 vsmuthu@qti.qualcomm.com, john@phrozen.org
Subject: Re: [PATCH net-next 3/5] net: pcs: qcom-ipq: Add PCS create and
 phylink operations for IPQ9574
Message-ID: <20241101093132.7770799c@kernel.org>
In-Reply-To: <d7782a5e-2f67-4f62-a594-0f52144a368f@lunn.ch>
References: <20241101-ipq_pcs_rc1-v1-0-fdef575620cf@quicinc.com>
	<20241101-ipq_pcs_rc1-v1-3-fdef575620cf@quicinc.com>
	<d7782a5e-2f67-4f62-a594-0f52144a368f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Nov 2024 14:21:24 +0100 Andrew Lunn wrote:
> > +	/* Access to PCS registers such as PCS_MODE_CTRL which are
> > +	 * common to all MIIs, is lock protected and configured
> > +	 * only once. This is required only for interface modes
> > +	 * such as QSGMII.
> > +	 */
> > +	if (interface == PHY_INTERFACE_MODE_QSGMII)
> > +		mutex_lock(&qpcs->config_lock);  
> 
> Is there a lot of contention on this lock? Why not take it for every
> interface mode? It would make the code simpler.

+1
-- 
pw-bot: cr

