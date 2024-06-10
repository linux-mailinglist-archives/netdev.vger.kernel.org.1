Return-Path: <netdev+bounces-102198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81566901DD4
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 11:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AFAAB265A7
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 09:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EBB71B48;
	Mon, 10 Jun 2024 09:07:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFDE7404B;
	Mon, 10 Jun 2024 09:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718010446; cv=none; b=SZvKVHzDcZsR8+T+G9zRC/Pt90+QMcdC8xlJN5Q5V/oeVr+k516mX/3HC0iIFiSXLiLL9C3Kf8wAl2wuq+HWbBl4+eJvY7hh+cZtCX9HJNQTnSKXbIlcb9Av10/T9P5uIpSBzM+FbCn5vnzcX7cSah1gtUJ0RGw4hRQtpfxNKU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718010446; c=relaxed/simple;
	bh=SzjKD3HfHsc1onvN3RhcIqrm0rpUg3M9t6rNMB763Ik=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=TM5zs9UXCAYA/NEsRrwDDSiCmBlLoRsuv4ecruPn42+d8U1wODW76RsmK4RoJifhlTaMuQ+vU2XkFSg9J87q+2yH4dz1Pz9O2AfbiXT+94xf7nUF5vCS81fR8fqpsEIcSekHnJWqBgoZRFEazBP1oicmpK0sUXGqq6/7I3rYD5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9905c7c8d6=ms@dev.tdt.de>)
	id 1sGazm-004F3I-97; Mon, 10 Jun 2024 11:07:18 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sGazl-00HAGA-JS; Mon, 10 Jun 2024 11:07:17 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 42BCC240053;
	Mon, 10 Jun 2024 11:07:17 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id BA8BB240050;
	Mon, 10 Jun 2024 11:07:16 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id D56F426128;
	Mon, 10 Jun 2024 11:07:15 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 10 Jun 2024 11:07:15 +0200
From: Martin Schiller <ms@dev.tdt.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 01/13] dt-bindings: net: dsa: lantiq_gswip: Add
 missing phy-mode and fixed-link
Organization: TDT AG
In-Reply-To: <ae996754-c7b9-4c46-a3dd-438ab35d6c67@kernel.org>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-2-ms@dev.tdt.de>
 <ae996754-c7b9-4c46-a3dd-438ab35d6c67@kernel.org>
Message-ID: <c410ac7cce5fe6bf522bac6edb18440d@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-ID: 151534::1718010438-2FD8C746-4AF8A988/0/0
X-purgate-type: clean
X-purgate: clean

On 2024-06-10 10:55, Krzysztof Kozlowski wrote:
> On 06/06/2024 10:52, Martin Schiller wrote:
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> 
>> The CPU port has to specify a phy-mode and either a phy or a 
>> fixed-link.
>> Since GSWIP is connected using a SoC internal protocol there's no PHY
>> involved. Add phy-mode = "internal" and a fixed-link to describe the
>> communication between the PMAC (Ethernet controller) and GSWIP switch.
> 
> You did nothing in the binding to describe them. You only extended
> example, which does not really matter if there is DTS with it.
> 
> Best regards,
> Krzysztof

OK, so I'll update subject and commit message to signal that we only
update the example code.

