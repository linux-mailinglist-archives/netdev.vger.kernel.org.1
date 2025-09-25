Return-Path: <netdev+bounces-226197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1D8B9DD70
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 09:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3F517ACB55
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 07:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C982E6CB6;
	Thu, 25 Sep 2025 07:20:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4260A157A5A;
	Thu, 25 Sep 2025 07:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758784837; cv=none; b=L8jU20m/Ro3c4PgZq7t/+7X3qbrlP8xn17dCEYzelOMUmsZhsbZaXiPPdh0Igi6xDHMyBwmVL9+pR7FCP2XMCzcRCOI8zgcLAAQSvPwpy+72FZ6yJZOl0BcP3XJWPN1SRy+Nhz4yflfadn0tlWunna0nIjCkQ9Q33fMCSHBv2/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758784837; c=relaxed/simple;
	bh=gjHLPCBlwWxNDU5lSABc9GZLWQJ25pg9E2aj27Xg248=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lVPcacNFwP2cKvlYi7UKkY2ZpGSKuJCvLU5ZMwZHd7aZeY0Z/N7R/3PN9AS+IRzK0jmUGMNqp+uaW6J4EuQcFriFnc/4HdX6zIDgYmaj9q0mpcDYfp4g3BhhexXN6Ru8ud5SAGWnm6rBCMizbJkp5dFodf2WiY+kYMJ262cyPso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cXPrl13JMz9sRr;
	Thu, 25 Sep 2025 09:06:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rgCLZvrocVzQ; Thu, 25 Sep 2025 09:06:15 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cXPrl0LBsz9sRk;
	Thu, 25 Sep 2025 09:06:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id EF9D78B76D;
	Thu, 25 Sep 2025 09:06:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id xlLlTdw8seGO; Thu, 25 Sep 2025 09:06:14 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 270738B76C;
	Thu, 25 Sep 2025 09:06:14 +0200 (CEST)
Message-ID: <f229764d-7dc5-4dfb-84d5-1dacec7edb86@csgroup.eu>
Date: Thu, 25 Sep 2025 09:06:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: wan: framer: Add version sysfs attribute for the
 Lantiq PEF2256 framer
To: Jakub Kicinski <kuba@kernel.org>
Cc: Herve Codina <herve.codina@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <77a27941d6924b1009df0162ed9f0fa07ed6e431.1758726302.git.christophe.leroy@csgroup.eu>
 <20250924164811.3952a2d7@kernel.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250924164811.3952a2d7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 25/09/2025 à 01:48, Jakub Kicinski a écrit :
> On Wed, 24 Sep 2025 17:06:47 +0200 Christophe Leroy wrote:
>> Lantiq PEF2256 framer has some little differences in behaviour
>> depending on its version.
>>
>> Add a sysfs attribute to allow user applications to know the
>> version.
> 
> Outsider question perhaps but what is the version of?
> It sounds like a HW revision but point releases for ASICs are quite
> uncommon. So I suspect it's some SW/FW version?

The datasheet of the component just calls it 'version'.

Among all registers there is a register called 'version status register' 
which contains a single field named 'Version Number of chip'. This field 
is an 8 bits value and the documentation tells that value 0x00 is 
version 1.2, value 0x10 is version 2.1, etc...

> 
> We generally recommend using devlink dev info for reporting all sort
> of versions...

Ok, I'll look at devlink. Based on the above, what type of 
DEVLINK_INFO_VERSION_GENERIC_XXXX would you use here ?

Thanks
Christophe

