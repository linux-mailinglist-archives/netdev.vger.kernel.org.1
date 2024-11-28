Return-Path: <netdev+bounces-147774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422059DBB9B
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 17:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC0B6B20E57
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 16:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F9B1C07C5;
	Thu, 28 Nov 2024 16:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AWYdJpE6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B4C1C07C2
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732813095; cv=none; b=RvOcs9jvroQ1guDBg5qxv6vKWd/TGlzhmrk8N0/TrmUjesMbN9NkLba+K9dP52v9on9Rzhd3MrKrjsl9xpEP+cmcm2MF71Oo5PgeyP/zTzsAHO/2KWwXnHphAFbbKtEuy6J4IsD2hhljgYT23u9Z+JOSjEbkNgeWF2bAsJ/pSOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732813095; c=relaxed/simple;
	bh=wA+P+gJfjc5QTwq2D+cqv5kMqc8PZiaZBylhMfnoIoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFMAtkTibMUSWzrlDqrlth9yMwf8K/lP5ZqQid0vZmBEmKj1v/i3oZfhPocqv49gF+nSp3L5IQC9L+OI1n5vK0ta8imNZ4yNw0u8CYQjOsYOMoJRzed50uO9vaPuOvYu17wZhdY3IMSPiJDlsXGAWheY7eX4w3e8d5UM/4znvQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AWYdJpE6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EaNQxNa40FWQXORb+sjzLurTLXPHVQeUGSRzUf27yFY=; b=AWYdJpE65EVpTLXuNycZKKRC3d
	Ybtd/O/WTYgifY5B+ME1MFJL210egMH5U4wtEZP3Qqf7V8PoJPLrPo0Oxz9COhqAqDSZ8wQ6QTfQw
	Sb1i+6c02QEQjUGu3EqJcL7/iV4RbHbQlm6JFyXdh2BkORNQ5l9PSJ513sw39kDRAyHA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tGhqD-00EipN-Ck; Thu, 28 Nov 2024 17:58:09 +0100
Date: Thu, 28 Nov 2024 17:58:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Michal Kubecek <mkubecek@suse.cz>, kernel@pengutronix.de,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] ethtool: add support for
 ETHTOOL_A_CABLE_FAULT_LENGTH_SRC and ETHTOOL_A_CABLE_RESULT_SRC
Message-ID: <919a9842-f719-41ac-96fb-ae24d2f0798f@lunn.ch>
References: <20241128090111.1974482-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128090111.1974482-1-o.rempel@pengutronix.de>

On Thu, Nov 28, 2024 at 10:01:11AM +0100, Oleksij Rempel wrote:
> Extend cable test output to include source information, supporting
> diagnostic technologies like TDR (Time Domain Reflectometry) and ALCD
> (Active Link Cable Diagnostic). The source is displayed optionally at
> the end of each result or fault length line.
> 
> TDR requires interrupting the active link to measure parameters like
> fault location, while ALCD can operate on an active link to provide
> details like cable length without disruption.
> 
> Example output:
> Pair B code Open Circuit, source: TDR
> Pair B, fault length: 8.00m, source: TDR
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> changes v2:
> - s/NLATTR_DESC_U8/NLATTR_DESC_U32
> ---
>  netlink/cable_test.c   | 39 +++++++++++++++++++++++++++++++++------
>  netlink/desc-ethtool.c |  2 ++
>  2 files changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/netlink/cable_test.c b/netlink/cable_test.c
> index ba21c6cd31e4..0a1c42010114 100644
> --- a/netlink/cable_test.c
> +++ b/netlink/cable_test.c
> @@ -18,7 +18,7 @@ struct cable_test_context {
>  };
>  
>  static int nl_get_cable_test_result(const struct nlattr *nest, uint8_t *pair,
> -				    uint16_t *code)
> +				    uint16_t *code, uint32_t *src)
>  {
>  	const struct nlattr *tb[ETHTOOL_A_CABLE_RESULT_MAX+1] = {};
>  	DECLARE_ATTR_TB_INFO(tb);
> @@ -32,12 +32,15 @@ static int nl_get_cable_test_result(const struct nlattr *nest, uint8_t *pair,
>  
>  	*pair = mnl_attr_get_u8(tb[ETHTOOL_A_CABLE_RESULT_PAIR]);
>  	*code = mnl_attr_get_u8(tb[ETHTOOL_A_CABLE_RESULT_CODE]);
> +	if (tb[ETHTOOL_A_CABLE_RESULT_CODE])
> +		*src = mnl_attr_get_u32(tb[ETHTOOL_A_CABLE_RESULT_SRC]);

ETHTOOL_A_CABLE_RESULT_SRC is a new property, so only newer kernels
will report it. I think you need an
if (tb[ETHTOOL_A_CABLE_RESULT_SRC]) here, and anywhere else you look for
this property?

	Andrew

