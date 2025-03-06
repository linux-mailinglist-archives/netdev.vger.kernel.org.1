Return-Path: <netdev+bounces-172416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2303DA54855
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5A3173313
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C701A23A2;
	Thu,  6 Mar 2025 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDdkeUzg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335E653BE
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 10:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258041; cv=none; b=hG3pJpDXI0/Gm2gJVlDiwwfvWlHBtkgIHpfg5T+YuwmL/uP044VwzEUe3Eui6/cy/7bV6Jo6jmymwSa8+C/BE8WEEvRUbAH+6uoePHmbHlXbjWCTuD7WPL3sh6sNFWvrkoK5Ecm9ZE/9Gx4Y/acEJJhfseyGg4cKsJFdx9nfJQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258041; c=relaxed/simple;
	bh=vfPUGZ+wcf507fVjMEVdY9Yqjq9p457hfR6jlUljHYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAIsStp63jTpNBz4WISFGT0jf2zbkk//LdWQTmtIviK5S/lwBIolN5/fT0tsY3vcekXAskIK97qlZrV/k9sgmRuJCVSh7QIGWNLAXh5W0NN0cxsAQ04aSAGpZF53/dyQunJARclvjtyp17+u7mvAmThJeynosMxc8PxL1xoVgDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDdkeUzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D68C4CEE0;
	Thu,  6 Mar 2025 10:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741258039;
	bh=vfPUGZ+wcf507fVjMEVdY9Yqjq9p457hfR6jlUljHYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XDdkeUzgp//Fr8elIJQx32Q602LmSdlCH6F4jQHFcB8szryBztQ5nkWsF1mJ4Qrax
	 UD7GoyQPnbFu4nfX2xsrFUobtoAaSA6AYd9pMrE08QoOi8BXGGHGebbg8ft+fs+zC0
	 HjtPcHk3wgiGWNrY/kxCNJXIh9JozDSWhYguUqqyaqe2akzFiJYzoGJjm6MKv3N4Hu
	 DsESPhRDP/HQ2oxHU973RSarH+9GVbDM78qsYeV5HmFJzEIve0oCD4WeuWtjoGohdf
	 P4JVjTSaN0X6Fjndgrn/WGYRzM++yBF+k2TyukNyuaIQCBLvCbFp1MylijkT1c1+VC
	 Ho2VQ5/WVt/Zw==
Date: Thu, 6 Mar 2025 10:47:15 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: airoha: Enable Rx Scatter-Gather
Message-ID: <20250306104715.GT3666230@kernel.org>
References: <20250304-airoha-eth-rx-sg-v1-0-283ebc61120e@kernel.org>
 <20250304-airoha-eth-rx-sg-v1-2-283ebc61120e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304-airoha-eth-rx-sg-v1-2-283ebc61120e@kernel.org>

On Tue, Mar 04, 2025 at 03:21:09PM +0100, Lorenzo Bianconi wrote:
> EN7581 SoC can receive 9k frames. Enable the reception of Scatter-Gather
> (SG) frames.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


