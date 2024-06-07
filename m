Return-Path: <netdev+bounces-101820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB04900314
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 14:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF7BE284742
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 12:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382501922EA;
	Fri,  7 Jun 2024 12:12:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CED413C67B;
	Fri,  7 Jun 2024 12:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717762350; cv=none; b=DFsCCMxmkoIYRddY7pt/72VKZHsnZaGiUK5A/3G+SFlGOrtalgwC+deAcnuQemJzzlq5+JTJkzu2vcvoS8bUdUMnzSvFQTYuwdFzcYJ/x2/wYDPcURXdFDEtaUQSZpFHnn0haZe7seAOo4N7nrovbaz0dDbB4Lc4Qnohs+szZDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717762350; c=relaxed/simple;
	bh=EHxOxCSAM3lCsXcc/Z3JLZF5VT0uknERV+f3sR2kLK8=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=Ql8T31B5cS3CpENiuJpr64ngoXxEU3R3oFTONWL/H5sBfJ+wpu47pGxMi8n4ytQA/2+W5+heYRCiXNcfYnCh+IG6zHwY063J3cPc91O+Lwdj1Mg4GL5hO8BawG/LqkOv4lTfamSNWcWxRcPqwcOqN5jjlv6uugqY3xYDpeLYqLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=990276a841=ms@dev.tdt.de>)
	id 1sFYSI-005Pn8-BI; Fri, 07 Jun 2024 14:12:26 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sFYSH-007ZNj-PA; Fri, 07 Jun 2024 14:12:25 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 6FD0D240053;
	Fri,  7 Jun 2024 14:12:25 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 001BC240050;
	Fri,  7 Jun 2024 14:12:24 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id B19EA3829D;
	Fri,  7 Jun 2024 14:12:24 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Jun 2024 14:12:24 +0200
From: Martin Schiller <ms@dev.tdt.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
 f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 04/13] net: dsa: lantiq_gswip: Don't manually
 call gswip_port_enable()
Organization: TDT AG
In-Reply-To: <20240607111112.tuilkvwektzohvrq@skbuf>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-5-ms@dev.tdt.de>
 <20240607111112.tuilkvwektzohvrq@skbuf>
Message-ID: <7a05e5c0432f2822b4ef2756b23d3f76@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-type: clean
X-purgate-ID: 151534::1717762346-34DF7522-BF04625D/0/0
X-purgate: clean

On 2024-06-07 13:11, Vladimir Oltean wrote:
> On Thu, Jun 06, 2024 at 10:52:25AM +0200, Martin Schiller wrote:
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> 
>> We don't need to manually call gswip_port_enable() from within
>> gswip_setup() for the CPU port. DSA does this automatically for us.
>> 
>> Signed-off-by: Martin Blumenstingl 
>> <martin.blumenstingl@googlemail.com>
>> ---
> 
> Not to mention the first thing in gswip_port_enable(), which is:
> 
> 	if (!dsa_is_user_port(ds, port))
> 		return 0;
> 
> So the call is dead code anyway.

As you will have noticed, this code will be brought back to life in the 
next
patch.

