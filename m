Return-Path: <netdev+bounces-101883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78344900688
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 16:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6CF1F24044
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 14:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A501990B2;
	Fri,  7 Jun 2024 14:27:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483A8194AD3;
	Fri,  7 Jun 2024 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770431; cv=none; b=pX7rc7ttavXPOZbchLg67X9k8z0DbqiBHFyUfCDyLJFmJOZdV02wUBLeo91A2dDwyyZQc0fKcLAjGdMz2dqBvx8pH2VKNOZesinh9KjyUHdZqy9PZtVdS/aX4TwUpBC+l9kZEH2uOPKW+9JhhfEVKZRnFtiKOr3sTUFLZBHkIIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770431; c=relaxed/simple;
	bh=s/wAF2MKyNyCf80HDbawVNiWCXO6QMjFhK7UDLN3ixk=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=BvU+Hl0gOV6hFB5xKAbjda13Th5UrLY4AyxJ+IgqnZMFUDuUeqOk9yc8W5DLxLYIx3L7tMIA17nojS4NdmCOn2WVSshYicKcDY0KUq2Yr7G0krABl8SmAxQYq0A4XLRLBZ0o+2BMc9IakZCU1l1cgldkdZK8P0oF1c0yQk6p8vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=990276a841=ms@dev.tdt.de>)
	id 1sFaYc-008Qz7-Od; Fri, 07 Jun 2024 16:27:06 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sFaYc-00EhMZ-5Z; Fri, 07 Jun 2024 16:27:06 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id BF4D5240053;
	Fri,  7 Jun 2024 16:27:05 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 4A07B240050;
	Fri,  7 Jun 2024 16:27:05 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id D257E3849A;
	Fri,  7 Jun 2024 16:27:04 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Jun 2024 16:27:04 +0200
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
In-Reply-To: <20240607113652.6ryt5gg72he2madn@skbuf>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-13-ms@dev.tdt.de>
 <20240607113652.6ryt5gg72he2madn@skbuf>
Message-ID: <ae0811c79a126e9f034beccf37e61991@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-ID: 151534::1717770426-CDC4D8CF-65FA3DE4/0/0
X-purgate: clean
X-purgate-type: clean

On 2024-06-07 13:36, Vladimir Oltean wrote:
> On Thu, Jun 06, 2024 at 10:52:33AM +0200, Martin Schiller wrote:
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> 
>> Only bits [5:0] in mac_bridge.key[3] are reserved for the FID. Add a
>> macro so this becomes obvious when reading the driver code.
>> 
>> Signed-off-by: Martin Blumenstingl 
>> <martin.blumenstingl@googlemail.com>
>> ---
>>  drivers/net/dsa/lantiq_gswip.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/net/dsa/lantiq_gswip.c 
>> b/drivers/net/dsa/lantiq_gswip.c
>> index f2faee112e33..4bb894e75b81 100644
>> --- a/drivers/net/dsa/lantiq_gswip.c
>> +++ b/drivers/net/dsa/lantiq_gswip.c
>> @@ -238,6 +238,7 @@
>>  #define GSWIP_TABLE_MAC_BRIDGE		0x0b
>>  #define  GSWIP_TABLE_MAC_BRIDGE_STATIC	BIT(0)		/* Static not, aging 
>> entry */
>>  #define  GSWIP_TABLE_MAC_BRIDGE_PORT	GENMASK(7, 4)	/* Port on learned 
>> entries */
>> +#define  GSWIP_TABLE_MAC_BRIDGE_FID	GENMASK(5, 0)	/* Filtering 
>> identifier */
>> 
>>  #define XRX200_GPHY_FW_ALIGN	(16 * 1024)
>> 
>> @@ -1385,7 +1386,7 @@ static int gswip_port_fdb(struct dsa_switch *ds, 
>> int port,
>>  	mac_bridge.key[0] = addr[5] | (addr[4] << 8);
>>  	mac_bridge.key[1] = addr[3] | (addr[2] << 8);
>>  	mac_bridge.key[2] = addr[1] | (addr[0] << 8);
>> -	mac_bridge.key[3] = fid;
>> +	mac_bridge.key[3] = FIELD_PREP(GSWIP_TABLE_MAC_BRIDGE_FID, fid);
>>  	mac_bridge.val[0] = add ? BIT(port) : 0; /* port map */
>>  	mac_bridge.val[1] = GSWIP_TABLE_MAC_BRIDGE_STATIC;
>>  	mac_bridge.valid = add;
>> --
>> 2.39.2
> 
> On second thought, I disagree with the naming scheme of the
> GSWIP_TABLE_MAC_BRIDGE_* macros. It is completely non obvious that they
> are non-overlapping, because they have the same name prefix, but:
> _STATIC applies to gswip_pce_table_entry :: val[1]
> _PORT applies to gswip_pce_table_entry :: val[0]
> _FID applies to gswip_pce_table_entry :: key[3]
> 
> I think it's all too easy to use the wrong macro on the wrong register 
> field.
> If the macros incorporated names like VAL1, KEY3 etc, it would be much
> more obvious. Could you please do that?

OK, so I'll change the macro names to

GSWIP_TABLE_MAC_BRIDGE_KEY3_FID
GSWIP_TABLE_MAC_BRIDGE_VAL0_PORT
GSWIP_TABLE_MAC_BRIDGE_VAL1_STATIC

Also the comment of GSWIP_TABLE_MAC_BRIDGE_VAL1_STATIC should be changed 
to
/* Static, not aging entry */

While looking again at this diff above, I noticed that val[0] is set
incorrectly. Shouldn't it be either "port << 4" or (after the previous 
patch)
"FIELD_PREP(GSWIP_TABLE_MAC_BRIDGE_PORT, port);" instead of "BIT(port)"?



