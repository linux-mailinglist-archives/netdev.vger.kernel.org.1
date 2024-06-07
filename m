Return-Path: <netdev+bounces-101874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B7E9005A9
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF6D7B26620
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC62194C69;
	Fri,  7 Jun 2024 13:54:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFB919149E;
	Fri,  7 Jun 2024 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768443; cv=none; b=g/8KXIGOf1zD9Vz7P12raeCST7PS9VLJgYlid9bwxOJdpHUyduLgdBbI1SSQ0wgPTIB4cQA0x0eCWqa3Ze02FsI4HzzJu7UKep/HAfvZjrwNgdoZx9v8RNWUfmZJiKkmudg5h3/YNEhFhcvFXTrqPvPUlaBBfHUZIrQTZ34NI7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768443; c=relaxed/simple;
	bh=91otkUgIB0mhSgUT3Jf/hB6FYPgNDeYftqYvwzJmFRc=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=X3EfSKlOWSdPZ7XG85NOMaGgLRcUSGkigfkdbl962OvUvYJdYY6+IYeTT5AO6vCHCa61tAH4qTQ02QMCVx0uwr1FMQi4sR8hQieDhmh+qQHLJrQ1hyRJk9iki1prM6UJ6F0AOumVaNM4K7RFEEfDM07SV0UdoB4JU9wtXj1keA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=990276a841=ms@dev.tdt.de>)
	id 1sFa2Z-0065jU-HH; Fri, 07 Jun 2024 15:53:59 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sFa2Z-008CvR-0N; Fri, 07 Jun 2024 15:53:59 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id B1C8C240053;
	Fri,  7 Jun 2024 15:53:58 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 44326240050;
	Fri,  7 Jun 2024 15:53:58 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 0AA0C2092B;
	Fri,  7 Jun 2024 15:53:58 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Jun 2024 15:53:58 +0200
From: Martin Schiller <ms@dev.tdt.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
 f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 10/13] net: dsa: lantiq_gswip: Fix error message
 in gswip_add_single_port_br()
Organization: TDT AG
In-Reply-To: <20240607135041.4lo36yeybwa2tkue@skbuf>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-11-ms@dev.tdt.de>
 <20240607112710.gbqyhnwisnjfnxrl@skbuf>
 <07b91d4a519c698bb80c0f50a0d00067@dev.tdt.de>
 <20240607135041.4lo36yeybwa2tkue@skbuf>
Message-ID: <cb945e096fe9a5d6c74057b20bb9c1c1@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-ID: 151534::1717768439-1FCDB522-0293E6EC/0/0
X-purgate-type: clean
X-purgate: clean

On 2024-06-07 15:50, Vladimir Oltean wrote:
> On Fri, Jun 07, 2024 at 03:34:13PM +0200, Martin Schiller wrote:
>> On 2024-06-07 13:27, Vladimir Oltean wrote:
>> > Isn't even the original condition (port >= max_ports) dead code? Why not
>> > remove the condition altogether?
>> 
>> I also agree here if we can be sure, that .port_enable, 
>> .port_bridge_join and
>> .port_bridge_leave are only called for "valid" (<= max_ports) ports.
> 
> dsa_switch_parse_ports_of() has:
> 
> 		if (reg >= ds->num_ports) {
> 			dev_err(ds->dev, "port %pOF index %u exceeds num_ports (%u)\n",
> 				port, reg, ds->num_ports);
> 			of_node_put(port);
> 			err = -EINVAL;
> 			goto out_put_node;
> 		}

OK, so I will remove this check altogether.

