Return-Path: <netdev+bounces-102157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76184901AD5
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 08:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DCB51C21743
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 06:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F316A10A22;
	Mon, 10 Jun 2024 06:04:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916FADDB8;
	Mon, 10 Jun 2024 06:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717999467; cv=none; b=OwgObNlfycbYt5ns5O5GKkqFb9Us3ZyRf8VFhaqqtVoIPwDKMAr9E+syWD7pppBL6eoVbwpOnjqzGbqD2oHW35kR0+f1XMXJn2w3OEK3eOgSEaXTD2FPfJjzlnGBysqW4RebJIJDVtv9wDeaqW7qO1ViikVEf7CWt3mQiJrCMlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717999467; c=relaxed/simple;
	bh=cSQdX4BBYMrswHnIrE7sy+aIIFqOv+WYoxhqcbK1I0M=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=R/XUwbzSTgaSWh+VY3O0TAa/6MhrMp2hZ2DQBqsV3bzKs/I+sj93G8ikKkWMxYc9wiSEX9XfEuEK42gMC3dTPgikv8pE4Ibza/P4FUFPvii2HVKBllQ8s0nrnd2XdkCoQnDGKH+dyxORGW3h6s4EKpvXCPJ4Loi+fLCiEbR2d0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9905c7c8d6=ms@dev.tdt.de>)
	id 1sGY8d-0081Zp-BT; Mon, 10 Jun 2024 08:04:15 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sGY8c-007Uab-NP; Mon, 10 Jun 2024 08:04:14 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 581C3240053;
	Mon, 10 Jun 2024 08:04:14 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id D9D49240050;
	Mon, 10 Jun 2024 08:04:13 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 595D9201B0;
	Mon, 10 Jun 2024 08:04:13 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 10 Jun 2024 08:04:13 +0200
From: Martin Schiller <ms@dev.tdt.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
 f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 12/13] net: dsa: lantiq_gswip: Add and use a
 GSWIP_TABLE_MAC_BRIDGE_FID macro
Organization: TDT AG
In-Reply-To: <ae0811c79a126e9f034beccf37e61991@dev.tdt.de>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-13-ms@dev.tdt.de>
 <20240607113652.6ryt5gg72he2madn@skbuf>
 <ae0811c79a126e9f034beccf37e61991@dev.tdt.de>
Message-ID: <de33cde759363a3dedb24375c76939fa@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-type: clean
X-purgate-ID: 151534::1717999455-C0C438CF-D4D8639C/0/0
X-purgate: clean

On 2024-06-07 16:27, Martin Schiller wrote:
> While looking again at this diff above, I noticed that val[0] is set
> incorrectly. Shouldn't it be either "port << 4" or (after the previous 
> patch)
> "FIELD_PREP(GSWIP_TABLE_MAC_BRIDGE_PORT, port);" instead of 
> "BIT(port)"?

Please ignore this comment. The format of the port specification differs
for static and dynamic (learned) entries.


