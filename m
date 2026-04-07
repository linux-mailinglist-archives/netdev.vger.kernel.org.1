Return-Path: <netdev+bounces-275901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ob2M6bB1GmWwwcAu9opvQ
	(envelope-from <netdev+bounces-275901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 10:34:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B643AB679
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 10:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56F6830058C5
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 08:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047FC39A81A;
	Tue,  7 Apr 2026 08:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xkGzOt2f"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820D739A81B
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 08:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775550880; cv=none; b=DUNGJECI9RDKHvetRJViTPMOd0aWlUt8EpxHrS685G6wA17LN5uZN7zc9NEwIw47KRjFE5AqWtQTnoOZMhrOv7ZstaaKKBDecahVPHXD69V7tfORTBVelsArG9AegPVKr2/xiPcH9GGzle/zGO4B4l/uTh1b3R114L1LOZlV4Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775550880; c=relaxed/simple;
	bh=ll5Xf8OgLSwzLu5gj1f8oU0LLlZwJOhEZFC7iIA9WeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JsZ3m+srExtm/TIl/K+OKaBqRvFBLeLRH7bo2arqgVp7jb9ur3WK19Q5TkmCkbd418RU+FoR3o+p2/NhXB3iwyTYYELgTQ/2LFyEblLZpdKv2yambigbrNIhIoEw26OJ8OsmywLDG8LeD8UU4tQPOPt0EsFsxp8vGWvoYuAKnsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xkGzOt2f; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DB4C21A31AC;
	Tue,  7 Apr 2026 08:34:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AA828603C7;
	Tue,  7 Apr 2026 08:34:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 901F310450169;
	Tue,  7 Apr 2026 10:34:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775550865; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=MeVAzDBoyGqpo2KSnPfszamlpaudEQsSPJY6g/H6Ddc=;
	b=xkGzOt2fHZy8K/uSb8zZSe7krpsMuTwa9sV0dleOZNXCZ0Rcr1V7kjqWPldKOwQVt8psTM
	2hwNspJcP04jPOiA9hsbPXa19xKzO9a1DIRyJhEX6oNnIwPiYbDNv66rWw1CXzVi4aSsv7
	RZJurmrlgJNgpZPP7uggfsMrRrrvjUoo2EK2LNoCcC7LoiVn8cVo/GTbjuDj7dgGJk9/C/
	rJtt6dqYnnlxuANE4gZbL6y3vbWEwGICizQSymY3chIhzLn0DuMYt89JYpjNcS6Z6fTXNo
	pT+lmzsH2H86Ege+Vey2IbLFm+6y9o4jUJSycrPmaiOdEn5M2wFBOqDV6GEeCQ==
Message-ID: <c2026868-35ff-4b5e-a0e2-bf6b3f6b75ce@bootlin.com>
Date: Tue, 7 Apr 2026 10:34:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: Add schema for LAN75XX compatible
 USB Ethernet controllers
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org
References: <20260403-b4-var-som-om44-lan7500-v1-0-0dadde850143@bootlin.com>
 <20260403-b4-var-som-om44-lan7500-v1-1-0dadde850143@bootlin.com>
 <20260405-smoky-spectacular-koel-dbfcda@quoll>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20260405-smoky-spectacular-koel-dbfcda@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275901-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.richard@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 29B643AB679
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Krzysztof,

On 4/5/26 10:06 AM, Krzysztof Kozlowski wrote:
> On Fri, Apr 03, 2026 at 09:02:23PM +0200, Thomas Richard wrote:
>> Create schema for LAN75XX compatible USB Ethernet controllers. The smsc75xx
>> driver only supports LAN7500 and LAN7505 devices.
>>
>> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>> ---
>>  .../devicetree/bindings/net/microchip,lan75xx.yaml | 52 ++++++++++++++++++++++
>>  1 file changed, 52 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/microchip,lan75xx.yaml b/Documentation/devicetree/bindings/net/microchip,lan75xx.yaml
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..b84022976044ffec2024cff9fc0aa5016723abed
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/microchip,lan75xx.yaml
> 
> Rather microchip,lan7500.yaml. Wildcards don't really scale when you
> have 75yy coming which does not fit into this binding.
> 
> 
>> @@ -0,0 +1,52 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/microchip,lan75xx.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Microchip LAN7500/LAN7505 USB Ethernet Controllers
>> +
>> +maintainers:
>> +  - Thomas Richard <thomas.richard@bootlin.com>
>> +
>> +description:
>> +  Device tree properties for LAN75XX compatible USB Ethernet controller.
>> +
>> +allOf:
>> +  - $ref: ethernet-controller.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    items:
> 
> Drop items, that's enum directly.
> 
>> +      - enum:
>> +          - usb424,7500
>> +          - usb424,7505
> 
> But you should notice that this is exactly the same as 95xx, so why it
> cannot go there? Because of the wildcard 95xx naming? That's not a
> reason.

Yes I noticed. I did not put them in 95xx because it is not the same
driver. Isn't that a valid reason?

Best Regards,
Thomas


