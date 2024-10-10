Return-Path: <netdev+bounces-134194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC826998571
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3ECB1C235B2
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 12:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92761BE238;
	Thu, 10 Oct 2024 12:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cXa3yDu8"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FBF1BCA05
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728561636; cv=none; b=WBMIyMl3ibfq2GazvkKH84MdyqxTFMzrX3Vt4Zeme1wto4dtVSDBRcB2ManObf+MBAngZxZwJ2NAxTDTE0k6zLl4s+lBuRdyb6N47UjAt5aN+jyFJs7s7I581DngVhxTl4Mewyl97kNK/xliacnY2sr87etPAx+J0rYOe04gttQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728561636; c=relaxed/simple;
	bh=sT5H35U5jkcZvVt9VWiPCTKiviAXpChbf77PYnahJWU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJfyjyQ6r5UypfoHXu7MzEBXx0BGebM5hwMVA/w+UobWzK80hL4RzIe1CChS3aVeAtgMNq8sJVBzylWnM3fgXtY8TfhqbbrcAzleKumiyI05VA4YhdN4fnPG+sXAejBWj+ZmzJo/mIX+JbdT0zpTdBQO/+tyF3tocr7yIIvuPwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cXa3yDu8; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728561634; x=1760097634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sT5H35U5jkcZvVt9VWiPCTKiviAXpChbf77PYnahJWU=;
  b=cXa3yDu8ymPo9aR/APzJABLd3hK0A1w4FXJ+WH3nCUm0K5Og54oJcg8I
   ZaOzZPlH8qDXMlj38zUMs9dBiRY1+NYOynP28rNuCDrqeKyAlNlikT5xM
   6UD9ZA5kXCc2xPm5AmdrI7zWfotgwim6nmVC0kSywtL3HU7M8cmnf515t
   wUVsdvOKmz1pp0zLSxFw9I/woRSJ7S+blGcXxP6XcJ3gEir6/Ca+fKfLC
   D92+gL798DrS2PAJ63uVpboiuo6jy0LqW6gEIBulePnsno/fe8Gr2uG2d
   KJEfgD2Jm9dhQu7DUmZOlfYQ5TtdbUyQ6OEKD9X0diSx8d0m5wEcNWQRS
   g==;
X-CSE-ConnectionGUID: sX2+qVlOR5m52EoKP+4bOw==
X-CSE-MsgGUID: RTi3gB1uT1O81XVSJ9ybHg==
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="200279101"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2024 05:00:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 10 Oct 2024 05:00:26 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 10 Oct 2024 05:00:24 -0700
Date: Thu, 10 Oct 2024 12:00:24 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Ido Schimmel <idosch@nvidia.com>
CC: <netdev@vger.kernel.org>, <dsahern@gmail.com>,
	<stephen@networkplumber.org>, <gnault@redhat.com>, <petrm@nvidia.com>
Subject: Re: [PATCH iproute2-next 2/2] iprule: Add DSCP support
Message-ID: <20241010120024.tq7headjnkytbt5a@DEN-DL-M70577>
References: <20241009062054.526485-1-idosch@nvidia.com>
 <20241009062054.526485-3-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241009062054.526485-3-idosch@nvidia.com>

> Add support for 'dscp' selector in ip-rule.
> 
> Rules can be added with a numeric DSCP value:
> 
>  # ip rule add dscp 1 table 100
>  # ip rule add dscp 0x02 table 200
> 
> Or using symbolic names from /usr/share/iproute2/rt_dsfield or
> /etc/iproute2/rt_dsfield:
> 
>  # ip rule add dscp AF42 table 300
> 
> Dump output:
> 
>  $ ip rule show
>  0:      from all lookup local
>  32763:  from all lookup 300 dscp AF42
>  32764:  from all lookup 200 dscp 2
>  32765:  from all lookup 100 dscp 1
>  32766:  from all lookup main
>  32767:  from all lookup default
> 
> Dump can be filtered by DSCP value:
> 
>  $ ip rule show dscp 1
>  32765:  from all lookup 100 dscp 1
> 
> Or by a symbolic name:
> 
>  $ ip rule show dscp AF42
>  32763:  from all lookup 300 dscp AF42
> 
> When the numeric option is specified, symbolic names will be translated
> to numeric values:
> 
>  $ ip -N rule show
>  0:      from all lookup 255
>  32763:  from all lookup 300 dscp 36
>  32764:  from all lookup 200 dscp 2
>  32765:  from all lookup 100 dscp 1
>  32766:  from all lookup 254
>  32767:  from all lookup 253
> 
> The same applies to the JSON output in order to be consistent with
> existing fields such as "tos" and "table":
> 
>  $ ip -j -p rule show dscp AF42
>  [ {
>          "priority": 32763,
>          "src": "all",
>          "table": "300",
>          "dscp": "AF42"
>      } ]
> 
>  $ ip -j -p -N rule show dscp AF42
>  [ {
>          "priority": 32763,
>          "src": "all",
>          "table": "300",
>          "dscp": "36"
>      } ]
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

LGTM.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>


