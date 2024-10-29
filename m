Return-Path: <netdev+bounces-140147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2859B5609
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B651F23659
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 22:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658012038C1;
	Tue, 29 Oct 2024 22:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUgh9rXI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D65218FDC5;
	Tue, 29 Oct 2024 22:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730242185; cv=none; b=Mm5iWoW/A6dExO3cELAyyZ7DHzIXD+5gB5vzwbuuPBFGGO7AF2Cy5q4Il82ViDRx0i2qO5JFGFz5Lf6yA/6VNVbut1hVL2m2z3ijx6JAyIRkmEuSeewmwXaL1Ci2WOu1Um3DZey8oU+W/hpW1qcpv4QDT1xth2pOyK1Uf2JLVo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730242185; c=relaxed/simple;
	bh=eH3h7yYOUEPtNn00/HkZI+Oxk26Jms4MbXgkp7ud8hg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/0VXmsT0bwPCtmd5NFKtgxhriUatS+DdYoy4FWWrfRn0vg4TagEFRNiLLQjuMTsvKR+xBPKQbQyUveVun9TULdF+aVy9Lt43lNG/dgnPjI+v3mZ+tSdt5Jq9FVn0cCKoa4TugvfUQkpjVN8tJ+ys/lI/4V8MI7Gm0CSxJKHSpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUgh9rXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1DDC4CEE3;
	Tue, 29 Oct 2024 22:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730242184;
	bh=eH3h7yYOUEPtNn00/HkZI+Oxk26Jms4MbXgkp7ud8hg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LUgh9rXI6tkXQY8RxmFUi5Nrzqv4NRvHAzMzh37EASpnU0FheRV5LbxnmQa2W4dro
	 hTjYysymEMZgt1lOolxxXHfkOKlj85lm2lISBkJ8qPOQUXmGwAX3BGrfpnlGgapcbm
	 uqM6tOCs5m1j2rJ7FAGzvR+g1WVpU/MccctH42BFgE/dk+ftC2A801UqprqoSgn6Jr
	 APtDRpcHCbt4wAyK8GsLwJR995xkdBEzO3IMm2pjztwfqu8u08yKzVoC9iiNwsdGuQ
	 AVmuR6Sw6oVGqyDsJx/0wtki/IP3X98+SnRk7KH4hIWylE504Koksi/Hf1yv4/T2my
	 NTQBCYWg2razw==
Date: Tue, 29 Oct 2024 15:49:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCHv2 net-next] net: bnxt: use ethtool string helpers
Message-ID: <20241029154943.381c105d@kernel.org>
In-Reply-To: <20241022193737.123079-1-rosenp@gmail.com>
References: <20241022193737.123079-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Oct 2024 12:37:37 -0700 Rosen Penev wrote:
>  	struct bnxt *bp = netdev_priv(dev);
> -	static const char * const *str;
> +	const char *str;
>  	u32 i, j, num_str;

please respect reverse xmas tree variable declaration ordering
Since the line declaring str is now shortest it should go to the end.
-- 
pw-bot: cr

