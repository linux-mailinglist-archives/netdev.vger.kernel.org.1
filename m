Return-Path: <netdev+bounces-97823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58F68CD600
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 16:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138B61C209F1
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 14:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B4B149E1E;
	Thu, 23 May 2024 14:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QL0ITScb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415E112B16E;
	Thu, 23 May 2024 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716475262; cv=none; b=HATgfDUk9yMVVbUPE/L90FgTj0oHapFzPakhjtKuItwRsITMOXRwTGi4Xa7sBj937Aeb66knz7Rwt+qr2TZKPGJ8oZJha+5d3H6aMUjfBqnw7FWdJoEgg7UHxgWmJXPCJKm6X2TE1Bo5fFfgp+YyQq9GA0XD/hU5Zg5KuR99/Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716475262; c=relaxed/simple;
	bh=J37CGLNwT838ydiPOn9Wa6R1GLXsTn7/JsoUPCz/9dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4D8mRUV1IKJcOC6ewY3iKTdTbeIzj7LSbjK36hznVEzjSFp2nHKuDzzkkok54KzRkj35IYKSzNK66cciP4ygXrjICGV39R55TrNa595sj83vRlzPv7zbMLl88h3Yb1IbtPMQBBzs15YxP25Pr92ZLPqZZOv8hB7csYhOsaMJtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QL0ITScb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691CFC32781;
	Thu, 23 May 2024 14:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716475261;
	bh=J37CGLNwT838ydiPOn9Wa6R1GLXsTn7/JsoUPCz/9dA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QL0ITScbbOElyfsR8elZCh9+T26SCaCcvQY3y5R5ZErz7XlJr8cGb2NGmFhunkSjP
	 cITBqRd84LFpB13U5tk01oDerbVk9RsQ6uki2Mszgi36x6DwPcX47b8iCLGMzU1DIn
	 mriaNCfssuXKrVDwwUMOiH8T7eaVEKkLIUfq+V5z4a8hCAHJPhQU74SJQFbg7N7/sI
	 Bu4kgdEUwC5Q3mP1JAQbwISITePJ6A66gwDfPHABhlw3d7KGoUc1yG4OVdthA4OjFE
	 eSVKtlhbQ4Ew5MkwW+DOQyy4629bKolE5X55VjGbks+vGaII+YCE40XZMY/MtiZTpM
	 vCyUIoS4mPFag==
Date: Thu, 23 May 2024 15:40:56 +0100
From: Simon Horman <horms@kernel.org>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: steve.glendinning@shawell.net, UNGLinuxDriver@microchip.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: smsc95xx: fix changing LED_SEL bit value
 updated from EEPROM
Message-ID: <20240523144056.GO883722@kernel.org>
References: <20240523085314.167650-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523085314.167650-1-Parthiban.Veerasooran@microchip.com>

On Thu, May 23, 2024 at 02:23:14PM +0530, Parthiban Veerasooran wrote:
> LED Select (LED_SEL) bit in the LED General Purpose IO Configuration
> register is used to determine the functionality of external LED pins
> (Speed Indicator, Link and Activity Indicator, Full Duplex Link
> Indicator). The default value for this bit is 0 when no EEPROM is
> present. If a EEPROM is present, the default value is the value of the
> LED Select bit in the Configuration Flags of the EEPROM. A USB Reset or
> Lite Reset (LRST) will cause this bit to be restored to the image value
> last loaded from EEPROM, or to be set to 0 if no EEPROM is present.
> 
> While configuring the dual purpose GPIO/LED pins to LED outputs in the
> LED General Purpose IO Configuration register, the LED_SEL bit is changed
> as 0 and resulting the configured value from the EEPROM is cleared. The
> issue is fixed by using read-modify-write approach.
> 
> Fixes: f293501c61c5 ("smsc95xx: configure LED outputs")
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
> ---
>  drivers/net/usb/smsc95xx.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Simon Horman <horms@kernel.org>


