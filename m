Return-Path: <netdev+bounces-229233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C85BD99A4
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C48B8353A0A
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23DF3148BA;
	Tue, 14 Oct 2025 13:08:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F503148B7;
	Tue, 14 Oct 2025 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760447317; cv=none; b=T6BeIYNrKwoIQIaXAZdUAle3WtkdWaTWC6nqfdTcu+/NcdfA3x/jTiDfEWZl4GU/C47WRAtUh8ecjURl+/dFFXEeBHP5IDe7z7/eklKyuXuvWQWlfyxM3R/CS93coz9TCZbFjUCzCyoE5CDaKjm7LOMZv+8FIqs5Q17QZchau0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760447317; c=relaxed/simple;
	bh=gkZ/CfHBXUas6V1hYRlzV1KXrk4I2oeBY3bP9B1I1/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YXpVo0QMe0ZjLDSJx6JbtaLpbCbLPQGL9GPtJOMLEQQC3c+PHEf01tLKaJief8yC63wxbXtJYxEM0YSeuIqzGKqgIOopRcgL+/qqGXrfrV1yV49LdTBCadHVyHSO5S51V6pzeSAhhiN9YHrIYdp+MKCZ5dQ4Ti0+KQFTxRD2pVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id AA7B96028F36C;
	Tue, 14 Oct 2025 15:07:53 +0200 (CEST)
Message-ID: <77cfe8ef-57d4-4dee-b89d-3f5504653413@molgen.mpg.de>
Date: Tue, 14 Oct 2025 15:07:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v2] ixgbe: Add 10G-BX support
To: Andrew Lunn <andrew@lunn.ch>, Birger Koblitz <mail@birger-koblitz.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251014-10gbx-v2-1-980c524111e7@birger-koblitz.de>
 <0c753725-fd6f-4f85-9371-f7342f86acff@lunn.ch>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <0c753725-fd6f-4f85-9371-f7342f86acff@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Birger, dear Andrew,


Am 14.10.25 um 14:27 schrieb Andrew Lunn:
> On Tue, Oct 14, 2025 at 06:18:27AM +0200, Birger Koblitz wrote:
> 61;8003;1c> Adds support for 10G-BX modules, i.e. 10GBit Ethernet over a single strand
>> Single-Mode fiber
>> The initialization of a 10G-BX SFP+ is the same as for a 10G SX/LX module,
>> and is identified according to SFF-8472 table 5-3, footnote 3 by the
>> 10G Ethernet Compliance Codes field being empty, the Nominal Bit
>> Rate being compatible with 12.5GBit, and the module being a fiber module
>> with a Single Mode fiber link length.
>>
>> This was tested using a Lightron WSPXG-HS3LC-IEA 1270/1330nm 10km
>> transceiver:
>> $ sudo ethtool -m enp1s0f1
>>     Identifier                          : 0x03 (SFP)
>>     Extended identifier                 : 0x04 (GBIC/SFP defined by 2-wire interface ID)
>>     Connector                           : 0x07 (LC)
>>     Transceiver codes                   : 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>>     Encoding                            : 0x01 (8B/10B)
>>     BR Nominal                          : 10300MBd
>>     Rate identifier                     : 0x00 (unspecified)
>>     Length (SMF)                        : 10km
>>     Length (OM2)                        : 0m
>>     Length (OM1)                        : 0m
>>     Length (Copper or Active cable)     : 0m
>>     Length (OM3)                        : 0m
>>     Laser wavelength                    : 1330nm
>>     Vendor name                         : Lightron Inc.
>>     Vendor OUI                          : 00:13:c5
>>     Vendor PN                           : WSPXG-HS3LC-IEA
>>     Vendor rev                          : 0000
>>     Option values                       : 0x00 0x1a
>>     Option                              : TX_DISABLE implemented
>>     BR margin max                       : 0%
>>     BR margin min                       : 0%
>>     Vendor SN                           : S142228617
>>     Date code                           : 140611
>>     Optical diagnostics support         : Yes
>>
>> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Unfortunately I do not see the original patch on the mailing list 
*intel-wired-lan*, and lore.kernel.org also does not have it [1].


Kind regards,

Paul


[1]: 
https://lore.kernel.org/intel-wired-lan/0c753725-fd6f-4f85-9371-f7342f86acff@lunn.ch/T/#u

