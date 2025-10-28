Return-Path: <netdev+bounces-233442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AB91FC13532
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 08:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3482A4F01D8
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 07:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC221F4E34;
	Tue, 28 Oct 2025 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wUYWTRfQ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58161EE033;
	Tue, 28 Oct 2025 07:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761636941; cv=none; b=irBWCp+fG0Fz1//SVd7W7nDqTzE02qLUdTYcQmjv940vAha4jbsIZY7fyUQLJjFfh3Hhbbsny7TI7iH9kQPh8tuLXqq2Oem4XiHBmfzSAlF6eOUKDO75AAQJ8BW0HODCQOqamDuyD3lfbLPsBvrkJtOJCMqIbmp2fmI29DYis3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761636941; c=relaxed/simple;
	bh=uLdIGu/opKZqTUfCVdvxeIGlRUtIfnhZ9CWDlHJaLCQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRKCUxH/U5EzlGZeJYyqy6QjDVnp4SG/3hoskltCB9jLWjCrKClx5DYEp/YPia7/lhXMeUINmHCoF2UUad8LfcZ9qGY2sCPfRJrc7Zh02uCf0H/jd0C03xz007cpNTdEMfcflXfhXq25nA7VswEvxK8IEjVRS7XZXERGnVExY2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wUYWTRfQ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761636939; x=1793172939;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uLdIGu/opKZqTUfCVdvxeIGlRUtIfnhZ9CWDlHJaLCQ=;
  b=wUYWTRfQzJbQSZ791aC9uzv3mOlwsvV3dKFVdwMAiXo3tM/9JjO9TUvc
   LgpxzIaCoh3vP15drghtZrg+7DIAuTUoJm3arj1Gw3p7XJXLF8AQ17nmQ
   LLR/r0ZYGKBN7JBvpGFtnkz6N+XLYTivSjQOiqXsWIc+5lC46xec3xoi0
   W4p+CwQVcDvERvOI0Kwa1P0uOzFA6jPf1qCEByemF82SRrjqBZe6FG105
   KarO82o9UiWhItfDKUX339tbyJdTBouDQLx6Ad0cuLR6YSzKyhoxks24J
   aAgwyViU0LR1g3NFROY7Li8ebNasse/ASjYAOq4eLVCBfd8iAqCabrvK6
   Q==;
X-CSE-ConnectionGUID: 6tHLyAsXQCmJ696quaN52w==
X-CSE-MsgGUID: wH4d5CSfSbi/v+QioxxwCQ==
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="215693261"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2025 00:35:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 28 Oct 2025 00:35:08 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 28 Oct 2025 00:35:08 -0700
Date: Tue, 28 Oct 2025 08:33:54 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy:  micrel: lan8842 erratas
Message-ID: <20251028073354.7r5pgrbrcqtqxcjt@DEN-DL-M31836.microchip.com>
References: <20251027124026.64232-1-horatiu.vultur@microchip.com>
 <4eefecbe-fa8f-41de-aeae-4d261cce5c1f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <4eefecbe-fa8f-41de-aeae-4d261cce5c1f@lunn.ch>

The 10/27/2025 14:05, Andrew Lunn wrote:
> 
> On Mon, Oct 27, 2025 at 01:40:26PM +0100, Horatiu Vultur wrote:
> > Add two erratas for lan8842. The errata document can be found here [1].
> > This is fixing the module 2 ("Analog front-end not optimized for
> > PHY-side shorted center taps") and module 7 ("1000BASE-T PMA EEE TX wake
> > timer is non-compliant")
> 
> Hi Horatiu

Hi Andrew,

> 
> Could this be split into two patches, since there are two erratas?

Yes, I will split them in the next version

> 
> I notice there is no Fixes: tag. So you don't think these are worth
> back porting?

Definetly I would like to be ported but the issue was there from
beginning when the lan8842 was added, so I was not sure if it is OK to
send it to net.

> 
>         Andrew

-- 
/Horatiu

