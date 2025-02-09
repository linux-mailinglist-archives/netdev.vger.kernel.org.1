Return-Path: <netdev+bounces-164490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5212CA2DFE5
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 19:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36391644A6
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 18:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290261DED69;
	Sun,  9 Feb 2025 18:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="Hpzolrq1"
X-Original-To: netdev@vger.kernel.org
Received: from mx10lb.world4you.com (mx10lb.world4you.com [81.19.149.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB9F1D79B6
	for <netdev@vger.kernel.org>; Sun,  9 Feb 2025 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739125758; cv=none; b=PSJSmNPRgZuQ7xq0WGpSBVGQPopkgoe+oIuUXPhWUWxYcuHlxvhBBsJlBSX7GQWLprb4o4VBRzSpsXSbezfBBZ3beD/eOX5OMjHnIthTgTLJ3/7YnX7SDLHveUI7WRJ1a7hgfkBV2VJhMwmHIhvTWUu5f0V3mkgMHFWhG/4wopg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739125758; c=relaxed/simple;
	bh=IgxfTyllKD8RWy2SPdd4177WnHgh4gGbOAuXY5RoD2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H04XJqmzwAZnuxvhYCndFYeJyruQewAeAbQGX+skl1ezBNVU57CjO3jKPWF/atZekLRnodpuAfILkHjjEnNj4MFszj78yaiRdZTTSfFC0DSab2aWRLmMdam+mn680SVwsZQsl8VxuRwhDno/urvz8dEUd23wJt7+2GR8Ktx58nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=Hpzolrq1; arc=none smtp.client-ip=81.19.149.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nVyXrIs0qK8tQ1dCH3gTOVJV5UXnjzjoei8eEm3ouEg=; b=Hpzolrq1tmLMHh1AUhhOJzex/R
	MwhrfthWg5fxttHoETzt6Ta7JlU20zwm7K5QCoMfWlvBAG0Vw2gDsVum4jF5QvdY3GXLQ6kMqSW0u
	zn11DMS5lZje+QVXGaeJ0UiazSwRL7HITOSLJrAhEQRMpsD08qIHOGlsrRQnxKJBoAf8=;
Received: from [88.117.60.28] (helo=[10.0.0.160])
	by mx10lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1thC3L-000000006qH-1Rd9;
	Sun, 09 Feb 2025 19:29:11 +0100
Message-ID: <188c0ca8-dec9-4648-bd6c-87b7dd6f5bf8@engleder-embedded.com>
Date: Sun, 9 Feb 2025 19:29:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: remove unused PHY_INIT_TIMEOUT and
 PHY_FORCE_TIMEOUT
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
References: <f8e7b8ed-a665-41ad-b0ce-cbfdb65262ef@gmail.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <f8e7b8ed-a665-41ad-b0ce-cbfdb65262ef@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 09.02.25 13:12, Heiner Kallweit wrote:
> Both definitions are unused. Last users have been removed with:
> 
> f3ba9d490d6e ("net: s6gmac: remove driver")
> 2bd229df5e2e ("net: phy: remove state PHY_FORCING")
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>   include/linux/phy.h | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 19f076a71..e1237bc51 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -303,9 +303,6 @@ static inline long rgmii_clock(int speed)
>   	}
>   }
>   
> -#define PHY_INIT_TIMEOUT	100000
> -#define PHY_FORCE_TIMEOUT	10
> -
>   #define PHY_MAX_ADDR	32
>   
>   /* Used when trying to connect to a specific phy (mii bus id:phy device id) */

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>

