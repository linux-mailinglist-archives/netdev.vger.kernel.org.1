Return-Path: <netdev+bounces-75425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AE7869E46
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 18:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ECD41F25084
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 17:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A975A4EB23;
	Tue, 27 Feb 2024 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grjtQ3+E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844C74E1DD
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056180; cv=none; b=BpKkP33IRLcRgpcZyyPGEKtSkvQWr69a11BMuvwozE+o+pBr4bHmBeJ/r7xaM8+I2MZglS2LKl1WCWAhnE4qzSxgIko0O6e2FMXfI7WhD37WBLiIyAoM732ar1yfxyX6wt49FmBjPp9hfigsGKjvbf+ZwM8Zn/+ZpDOGrH3rq1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056180; c=relaxed/simple;
	bh=jYbfm+IX+aarBg4vFWUarkVK6qLS4Zldu3dxA5u9Hkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZF65vP5FgouF7EIFj9r+3CmU7GpjpBUIpeflKSTOPqgaaCRBFmN+szBeSBhTTQeW1WGAWvIwS+x2iv0FsRgdeJ8OGOrKR76y+WgQ+aT0RbJv4d33mkBolvgdz/VDDgslkdUtGdN+2ohkEakQkONs3mdcKNkPddgDA2fx3eTtSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grjtQ3+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDBFC433C7;
	Tue, 27 Feb 2024 17:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709056180;
	bh=jYbfm+IX+aarBg4vFWUarkVK6qLS4Zldu3dxA5u9Hkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=grjtQ3+EeVm78mBdi5WCRuZJ/cZ/F4jYQizmeT0r2MH/+dBJIgIlPnj4RalYE/Ee5
	 uXjDdpjWF0/3BLj1bgZglM4ycMPwRhvV2MhtNKMzVmExB6T/q4Oc4YiSDdwmWqx0c2
	 ysBUGfesbMXj8fOJXmuebiiHYAjS0ox/jTZNljvzmznEIEU5T1Xyd0iqk7A7qIKhfQ
	 /KyMrwRtVfuTIVfeyNvWrtCiNO7UdJzxZ3wWJg6zBe7NwtAidXd9ITLsYxOrddrJ1A
	 tRofPH0I7oqNlfj68ze4NcRXsVLpMNADqSYRQrEnuikYlGr3jDuiEhsQZtN//i7RFS
	 bOPq/caX8/0ig==
Date: Tue, 27 Feb 2024 17:49:35 +0000
From: Simon Horman <horms@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] net: hsr: Use correct offset for HSR TLV values in
 supervisory HSR frames
Message-ID: <20240227174935.GJ277116@kernel.org>
References: <20240226152447.3439219-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226152447.3439219-1-lukma@denx.de>

On Mon, Feb 26, 2024 at 04:24:47PM +0100, Lukasz Majewski wrote:
> Current HSR implementation uses following supervisory frame (even for
> HSRv1 the HSR tag is not is not present):
> 
> 00000000: 01 15 4e 00 01 2d XX YY ZZ 94 77 10 88 fb 00 01
> 00000010: 7e 1c 17 06 XX YY ZZ 94 77 10 1e 06 XX YY ZZ 94
> 00000020: 77 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00000030: 00 00 00 00 00 00 00 00 00 00 00 00
> 
> The current code adds extra two bytes (i.e. sizeof(struct hsr_sup_tlv))
> when offset for skb_pull() is calculated.
> This is wrong, as both 'struct hsrv1_ethhdr_sp' and 'hsrv0_ethhdr_sp'
> already have 'struct hsr_sup_tag' defined in them, so there is no need
> for adding extra two bytes.
> 
> This code was working correctly as with no RedBox support, the check for
> HSR_TLV_EOT (0x00) was off by two bytes, which were corresponding to
> zeroed padded bytes for minimal packet size.
> 
> Fixes: f43200a2c98b ("net: hsr: Provide RedBox support")

Hi Lukasz,

The commit cited above does seem to be present in net or net-next.
Perhaps the tag should be:

   Fixes: eafaa88b3eb7 ("net: hsr: Add support for redbox supervision frames")

> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

...

