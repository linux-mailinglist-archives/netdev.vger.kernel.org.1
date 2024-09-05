Return-Path: <netdev+bounces-125358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A4296CE34
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 06:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867701C224C7
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 04:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35C714EC77;
	Thu,  5 Sep 2024 04:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="JEVN6/T9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2951FA4
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 04:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725511648; cv=none; b=ec+efNdr4Z6aynMDtUJ/DBw5Tvb6jSviqyI3lJT4Ccx/XjMHpA/HQfCrUn9ljQWOHpziURO3mNdZ0npMz5CFMn0ewfV1snrf2eho5/4YlkEseJ4qMLNtr1eff28kt/dHNf5mqLpEH9/kVOZ6cfttWXC7YefhbmcxPdTImQI/FFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725511648; c=relaxed/simple;
	bh=Q52FaWQ+Fly3WnSXMurIAeuTWm7jDEjfj3AB0gnFzaY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=szIBKQdSb9NV+i/+OenMjduNNKEN5k2tWlkGN2EKey2vtNnYMyfiYdcsQrP9xnca8qxxirkqTvCNRBmWbpbgcbP1XtT06zmYCTTaVO2U8l4AZxCYRr7DSAP3ffSy1sSswO0nglpveMJ0DN8Axjw8c/afWjbTi3oU9gy7/gtFZdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=JEVN6/T9; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 4854l5ml011086
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 5 Sep 2024 06:47:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1725511629; bh=cDaO5+LW1VQt2+xVRJqXcHOJRwxNUlpFupMOx8Rbces=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=JEVN6/T9EdLsiYGsNjyjqh0L6fk/k1PWhTEYS+8t7upCIFxGRze4alo1YRZiO03F/
	 DW/Zcduo07yk8vSBaTwJ+KP9tchVylesqJaMdYjwOvhKGydU5JQqbL0zHk/JVzvGE/
	 KeSyRGz+ltKHBWNH2yR50InaYrp4nYRnIJAiEkfc=
Message-ID: <7ba77c1e-9146-4a58-8f21-5ff5e1445a87@ans.pl>
Date: Wed, 4 Sep 2024 21:47:04 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [mlx4] Mellanox ConnectX2 (MHQH29C aka 26428) and module
 diagnostic support (ethtool -m) issues
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
To: Ido Schimmel <idosch@nvidia.com>, gal@nvidia.com
Cc: Tariq Toukan <tariqt@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
        Michal Kubecek <mkubecek@suse.cz>, Jakub Kicinski <kuba@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
References: <a7904c43-01c7-4f9c-a1f9-e0a7ce2db532@ans.pl>
 <ZthZ-GJkLVQZNdA3@shredder.mtl.com>
 <b0ec22eb-2ae8-409d-9ed3-e96b1b041069@ans.pl>
Content-Language: en-US
In-Reply-To: <b0ec22eb-2ae8-409d-9ed3-e96b1b041069@ans.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04.09.2024 at 21:08, Krzysztof Olędzki wrote:
> On 04.09.2024 at 06:00, Ido Schimmel wrote:
>> I see Tariq is OOO so I'm adding Gal who might be able to help with
>> CX2/mlx4 issues.
>>
>> On Sat, Aug 31, 2024 at 11:28:03PM -0700, Krzysztof Olędzki wrote:
>>> Hi,
>>>
>>> I noticed that module diagnostic on Mellanox ConnectX2 NIC (MHQH29C aka 26428 aka 15b3:673c, FW version 2.10.0720) behaves in somehow strange ways.
>>>
>>> 1. For SFP modules the driver is able to read the first page but not the 2nd one:
>>>
>>> [  318.082923] mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module info attr(ff60) port(1) i2c_addr(51) offset(0) size(48): Response Mad Status(71c) - invalid I2C slave address
>>> [  318.082936] mlx4_en: eth1: mlx4_get_module_info i(0) offset(256) bytes_to_read(128) - FAILED (0xfffff8e4)
>> I assume you are using a relatively recent ethtool with netlink support.
> Yes, sorry for not stating this explicitly:
> 
> # ethtool  --version
> ethtool version 6.10
> 
>> It should only try to read from I2C address 0x51 if the module indicated
>> support for diagnostics via bit 6 in byte 92.
>>
>> A few things worth checking:
>>
>> 1. mlx4 does not implement the modern get_module_eeprom_by_page() ethtool
>> operation so what it gets invoked is the fallback path in
>> eeprom_fallback(). Can you try to rule out problems in this path by
>> compiling ethtool without netlink support (i.e., ./configure
>> --disable-netlink) and retesting? I don't think it will make a
>> difference, but worth trying.
> Right... I should have thought about this.
> 
> Interestingly, this makes things even worse:
> 
> # ethtool  -m eth2
> Cannot get Module EEPROM data: Unknown error 1564
> 
> mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module info attr(ff60) port(2) i2c_addr(50) offset(240) size(16): Response Mad Status(61c) - invalid device_address or size (that is, size equals 0 or address+size is greater than 256)
> mlx4_en: eth2: mlx4_get_module_info i(240) offset(240) bytes_to_read(272) - FAILED (0xfffff9e4)
> 
> 1564 is mlx4_get_module_info() incorrectly returning -0x61c coming from "Response Mad Status(61c)"...

This BTW looks like another problem:

# ethtool -m eth1 hex on offset 254 length 1
Offset          Values
------          ------
0x00fe:         00

# ethtool -m eth1 hex on offset 255 length 1
Cannot get Module EEPROM data: Unknown error 1564

mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module info attr(ff60) port(1) i2c_addr(50) offset(255) size(1): Response Mad Status(61c) - invalid device_address or size (that is, size equals 0 or address+size is greater than 256)
mlx4_en: eth1: mlx4_get_module_info i(0) offset(255) bytes_to_read(1) - FAILED (0xfffff9e4)

With the netlink interface, ethtool seems to be only asking for for the first 128 bytes, which works:

sending genetlink packet (76 bytes):
    msg length 76 ethool ETHTOOL_MSG_MODULE_EEPROM_GET
    ETHTOOL_MSG_MODULE_EEPROM_GET
        ETHTOOL_A_MODULE_EEPROM_HEADER
            ETHTOOL_A_HEADER_DEV_NAME = "eth1"
        ETHTOOL_A_MODULE_EEPROM_LENGTH = 128
        ETHTOOL_A_MODULE_EEPROM_OFFSET = 0
        ETHTOOL_A_MODULE_EEPROM_PAGE = 0
        ETHTOOL_A_MODULE_EEPROM_BANK = 0
        ETHTOOL_A_MODULE_EEPROM_I2C_ADDRESS = 81

For the ioctl one, it looks like we want all 512 bytes but reading fails when trying to read 
16 bytes @240 because of the 255 octet issue. As the driver only masks the "invalid I2C slave address"
error (CABLE_INF_I2C_ADDR) but not "invalid device_address or size" (CABLE_INF_INV_ADDR) it is
able to successfully read 255 octets from A0h, and also to fake 256 from A2h:

# ethtool -m eth1 hex on offset 256
Offset          Values
------          ------
0x0100:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0110:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0120:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0130:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0140:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0150:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0160:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0170:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0180:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0190:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x01a0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x01b0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x01c0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x01d0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x01e0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x01f0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

(again with "i2c_addr(51) offset(0) size(48): Response Mad Status(71c) - invalid I2C slave address")

To compare, this is what we get from CX3 pro:

Offset          Values
------          ------
0x0100:         55 00 fb 00 50 00 00 00 8c a0 75 30 87 28 7a 44
0x0110:         14 82 04 e2 14 82 04 e2 4e 20 04 ec 1e dc 0c 62
0x0120:         4e 20 01 3b 1e dc 01 3b 00 00 00 00 00 00 00 00
0x0130:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0140:         00 00 00 00 3f 80 00 00 00 00 00 00 01 00 00 00
0x0150:         01 00 00 00 01 00 00 00 01 00 00 00 00 00 00 3f
0x0160:         24 4e 7f 55 0e f6 16 c1 00 01 00 00 00 00 32 00
0x0170:         00 40 00 00 00 40 00 00 00 00 1c 00 00 00 00 00
0x0180:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0190:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x01a0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x01b0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x01c0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x01d0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x01e0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x01f0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Also no issue here:
0x00f0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 
> Also.. I think this is 3rd time I'm recompiling ethtool without netlink support.
> Would it make sense to add add --disable-netlink?
> 
> RFC quality patch:
> 
> Subject: [PATCH ethtool] Add runtime support for disabling netlink
> 
> Provide --disable-netlink option for disabling netlink during runtime,
> without the need to recompile the binary.
> 
> Signed-off-by: Krzysztof Piotr Oledzki <ole@ans.pl>
> ---
>  ethtool.8.in      | 6 ++++++
>  ethtool.c         | 6 ++++++
>  internal.h        | 1 +
>  netlink/netlink.c | 5 +++++
>  4 files changed, 18 insertions(+)
> 
> diff --git a/ethtool.8.in b/ethtool.8.in
> index 11bb0f9..0b54983 100644
> --- a/ethtool.8.in
> +++ b/ethtool.8.in
> @@ -137,6 +137,9 @@ ethtool \- query or control network driver and hardware settings
>  .BN --debug
>  .I args
>  .HP
> +.B ethtool [--disable-netlink]
> +.I args
> +.HP
>  .B ethtool [--json]
>  .I args
>  .HP
> @@ -579,6 +582,9 @@ lB	l.
>  0x10  Structure of netlink messages
>  .TE
>  .TP
> +.BI \-\-disable-netlink
> +Do not use netlink and fall back to the ioctl interface if possible.
> +.TP
>  .BI \-\-json
>  Output results in JavaScript Object Notation (JSON). Only a subset of
>  options support this. Those which do not will continue to output
> diff --git a/ethtool.c b/ethtool.c
> index 7f47407..dc28069 100644
> --- a/ethtool.c
> +++ b/ethtool.c
> @@ -6537,6 +6537,12 @@ int main(int argc, char **argp)
>  			argc -= 2;
>  			continue;
>  		}
> +		if (*argp && !strcmp(*argp, "--disable-netlink")) {
> +			ctx.nl_disable = true;
> +			argp += 1;
> +			argc -= 1;
> +			continue;
> +		}
>  		if (*argp && !strcmp(*argp, "--json")) {
>  			ctx.json = true;
>  			argp += 1;
> diff --git a/internal.h b/internal.h
> index 4b994f5..84c64be 100644
> --- a/internal.h
> +++ b/internal.h
> @@ -221,6 +221,7 @@ struct cmd_context {
>  	char **argp;		/* arguments to the sub-command */
>  	unsigned long debug;	/* debugging mask */
>  	bool json;		/* Output JSON, if supported */
> +	bool nl_disable;	/* Disable netlink even if available */
>  	bool show_stats;	/* include command-specific stats */
>  #ifdef ETHTOOL_ENABLE_NETLINK
>  	struct nl_context *nlctx;	/* netlink context (opaque) */
> diff --git a/netlink/netlink.c b/netlink/netlink.c
> index ef0d825..3cf1710 100644
> --- a/netlink/netlink.c
> +++ b/netlink/netlink.c
> @@ -470,6 +470,11 @@ void netlink_run_handler(struct cmd_context *ctx, nl_chk_t nlchk,
>  	const char *reason;
>  	int ret;
>  
> +	if (ctx->nl_disable) {
> +		reason = "netlink disabled";
> +		goto no_support;
> +	}
> +
>  	if (nlchk && !nlchk(ctx)) {
>  		reason = "ioctl-only request";
>  		goto no_support;

>> 2. Can you test this transceiver with a different NIC?
> Ah, yes. Sorry once again - I had done that already, and of course it works,
> which is why I came here and explicitly blamed CX2.
> 
> Here is the output from a CX3 Pro NIC:
> 
> # ethtool -m eth2
>         Identifier                                : 0x03 (SFP)
> (...)
>         Optical diagnostics support               : Yes
>         Laser bias current                        : 7.574 mA
>         Laser output power                        : 0.5815 mW / -2.35 dBm
>         Receiver signal average optical power     : 0.0001 mW / -40.00 dBm
>         Module temperature                        : 32.13 degrees C / 89.83 degrees F
>         Module voltage                            : 3.2714 V
>         Alarm/warning flags implemented           : Yes
>         Laser bias current high alarm             : Off
>         Laser bias current low alarm              : Off
>         Laser bias current high warning           : Off
>         Laser bias current low warning            : Off
>         Laser output power high alarm             : Off
>         Laser output power low alarm              : Off
>         Laser output power high warning           : Off
>         Laser output power low warning            : Off
>         Module temperature high alarm             : Off
>         Module temperature low alarm              : Off
>         Module temperature high warning           : Off
>         Module temperature low warning            : Off
>         Module voltage high alarm                 : Off
>         Module voltage low alarm                  : Off
>         Module voltage high warning               : Off
>         Module voltage low warning                : Off
>         Laser rx power high alarm                 : Off
>         Laser rx power low alarm                  : On
>         Laser rx power high warning               : Off
>         Laser rx power low warning                : On
>         Laser bias current high alarm threshold   : 10.500 mA
>         Laser bias current low alarm threshold    : 2.500 mA
>         Laser bias current high warning threshold : 10.500 mA
>         Laser bias current low warning threshold  : 2.500 mA
>         Laser output power high alarm threshold   : 2.0000 mW / 3.01 dBm
>         Laser output power low alarm threshold    : 0.1260 mW / -9.00 dBm
>         Laser output power high warning threshold : 0.7900 mW / -1.02 dBm
>         Laser output power low warning threshold  : 0.3170 mW / -4.99 dBm
>         Module temperature high alarm threshold   : 85.00 degrees C / 185.00 degrees F
>         Module temperature low alarm threshold    : -5.00 degrees C / 23.00 degrees F
>         Module temperature high warning threshold : 80.00 degrees C / 176.00 degrees F
>         Module temperature low warning threshold  : 0.00 degrees C / 32.00 degrees F
>         Module voltage high alarm threshold       : 3.6000 V
>         Module voltage low alarm threshold        : 3.0000 V
>         Module voltage high warning threshold     : 3.4600 V
>         Module voltage low warning threshold      : 3.1300 V
>         Laser rx power high alarm threshold       : 2.0000 mW / 3.01 dBm
>         Laser rx power low alarm threshold        : 0.0315 mW / -15.02 dBm
>         Laser rx power high warning threshold     : 0.7900 mW / -1.02 dBm
>         Laser rx power low warning threshold      : 0.0315 mW / -15.02 dBm
> 
> 
>> 3. I'm wondering if this transceiver requires an "address change
>> sequence" before accessing I2C address 0x51 (see SFF-8472 Section 8.9
>> Addressing Modes). The generic SFP driver doesn't support it (see
>> sfp_module_parse_sff8472()) and other drivers probably don't support it
>> as well. Can you look at an hexdump of page 0 and see if this bit is
>> set? If so, maybe the correct thing to do would be to teach the SFF-8472
>> parser to look at both bit 2 and bit 6 before trying to access this I2C
>> address.
> That would be byte 92, correct?
> 
> # ethtool -m eth2 raw on offset 92 length 1|hexdump -C
> 00000000  68                                                |h|
> 00000001
> 
> 0x68 = 01101000b:
> 
> - 6 Digital diagnostic monitoring implemented (described in this document).
> - 5 Internally calibrated
> - 3 Received power measurement type: 0 = OMA, 1 = average power
> 
>>> However, as the driver intentionally tries mask the problem [1], ethtool reports "Optical diagnostics support" being available and shows completely wrong information [2].
>>>
>>> Removing the workaround allows ethtool to recognize the problem and handle everything correctly [3]:
>>> ---- cut here ----
>>> --- a/drivers/net/ethernet/mellanox/mlx4/port.c	2024-07-27 02:34:11.000000000 -0700
>>> +++ b/drivers/net/ethernet/mellanox/mlx4/port.c	2024-08-31 21:57:11.211612505 -0700
>>> @@ -2197,14 +2197,7 @@
>>>  			  0xFF60, port, i2c_addr, offset, size,
>>>  			  ret, cable_info_mad_err_str(ret));
>>>  
>>> -		if (i2c_addr == I2C_ADDR_HIGH &&
>>> -		    MAD_STATUS_2_CABLE_ERR(ret) == CABLE_INF_I2C_ADDR)
>>> -			/* Some SFP cables do not support i2c slave
>>> -			 * address 0x51 (high page), abort silently.
>>> -			 */
>>> -			ret = 0;
>>> -		else
>>> -			ret = -ret;
>>> +		ret = -ret;
>>>  		goto out;
>>>  	}
>>>  	cable_info = (struct mlx4_cable_info *)outm
>>> ---- cut here ----
>>>
>>> However, we end up with a strange "netlink error: Unknown error 1820" error because mlx4_get_module_info returns -0x71c (0x71c is 1820 in decimal).
>>>
>>> This can be fixed with returning -EIO instead of ret, either in mlx4_get_module_info() or perhaps better mlx4_en_get_module_eeprom() from en_ethtool.c:
>>> ---- cut here ----
>>> --- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c	2024-07-27 02:34:11.000000000 -0700
>>> +++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c	2024-08-31 21:52:50.370553218 -0700
>>> @@ -2110,7 +2110,7 @@
>>>  			en_err(priv,
>>>  			       "mlx4_get_module_info i(%d) offset(%d) bytes_to_read(%d) - FAILED (0x%x)\n",
>>>  			       i, offset, ee->len - i, ret);
>>> -			return ret;
>>> +			return -EIO;
>>>  		}
>>>  
>>>  		i += ret;
>>> ---- cut here ----
>>>
>>> BTW: it is also possible to augment the error reporting in ethtool/sfpid.c:
>>> ---- cut here ----
>>> -       if (ret)
>>> +       if (ret) {
>>> +               fprintf(stderr, "Failed to read Page A2h.\n");
>>>                 goto out;
>>> +       }
>>> ---- cut here ----
>>> With all the above changes, we now get:
>>>
>>> ---- cut here ----
>>>         Identifier                                : 0x03 (SFP)
>>>         Extended identifier                       : 0x04 (GBIC/SFP defined by 2-wire interface ID)
>>> (...)
>>>         Date code                                 : <REDACTED>
>>> netlink error: Input/output error
>>> Failed to read Page A2h.
>>> ---- cut here ----
>>>
>>> So, the first question is if above set of fixes makes sense, give that ethtool handles this correctly? If so, I'm happy to send the fixes.
>> I believe it makes sense for the driver to return an error rather than
>> mask the problem and return the wrong information (zeroes).
> Alright, will work on the patches. Thank you BTW for your very patient and
> encouraging review and support the last time. Greatly appreciated.
> 
>>> The second question is if not being able to read Page A2h and "invalid I2C slave address" is a due to a bug in the driver or a HW (firmware?) limitation and if something can be done to address this?
>> Let's see if it's related to the "address change sequence" I mentioned
>> above. Maybe that's why the error masking was put in mlx4 in the first
>> place.
> So it seems it is not, but please double check after me.
> 
>>> 2. For a QSFP module (which works in CX3/CX3Pro), handling "ethtool -m" seems to be completely broken.
>> Given it works with CX3, then the problem is most likely with CX2 HW/FW.
>> Gal, can you or someone from the team look into it?
> On 04.09.2024 at 08:09, Gal Pressman wrote:
>>> ConnectX-2 is End-of-Life since 2015 and End-of-Service since 2017..
>>>
> Yes, I am very familiar with these terms and aware of the EoL / EoS situation. 
> 
> However, the HW still works (and actually works very well), it is still
> supported even by the most recent Linux kernels, and for a non-prod use
> cases like mine (retro workstation) it may be hard to make an argument that
> it should not be used. Especially that it supports everything I need,
> including PXE booting with iPXE, and BTW - the fact that Mellanox even
> provided sources allowing to build / tweak the mrom is truly unique and
> amazing.
> 
> That said, I totally get that *if* this is a FW issues, getting a new
> version is rather unlikely, even it used to be a "best-in-class"
> premium NIC... 15 years ago? 😉 
> 
>>> With QSFP module in port #2 (eth2), for the first attempt (ethtool -m eth2):
>>> mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module info attr(ff60) port(2) i2c_addr(50) offset(0) size(48): Response Mad Status(41c) - the connected cable has no EPROM (passive copper cable)
>>> mlx4_en: eth2: mlx4_get_module_info i(0) offset(0) bytes_to_read(128) - FAILED (0xfffffbe4)
>>>
>>> However, if I first try run "ethtool -m eth1" with a SFP module installed in port #1, and then immediately "ethtool -m eth2", I end up getting the information for the SFP module:
>>> # ethtool -m eth2
>>>         Identifier                                : 0x03 (SFP)
>>>         Extended identifier                       : 0x04 (GBIC/SFP defined by 2-wire interface ID)
>>> (...)
>>>
>>> I this case, I even get the same "invalid I2C slave address" error:
>>> mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module info attr(ff60) port(2) i2c_addr(51) offset(0) size(48): Response Mad Status(71c) - invalid I2C slave address
>>>
>>> If I immediately run "ethtool -m eth1" I get:
>>> mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module info attr(ff60) port(1) i2c_addr(50) offset(224) size(32): Response Mad Status(61c) - invalid device_address or size (that is, size equals 0 or address+size is greater than 256)
>>> mlx4_en: eth1: mlx4_get_module_info i(96) offset(224) bytes_to_read(32) - FAILED (0xfffff9e4)
>>>
>>> Alternatively, if I remove SFP module from port #1 and run "ethtool -m eth2", I get:
>>> [ 1071.945737] mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module ID attr(ff60) port(2) i2c_addr(50) offset(0) size(1): Response Mad Status(31c) - cable is not connected
>>>
>>> At this point, running "ethtool -m eth1" produces one of:
>>>
>>> *)
>>>  mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module ID attr(ff60) port(2) i2c_addr(50) offset(0) size(1): Response Mad Status(41c) - the connected cable has no EPROM (passive copper cable)
>>>
>>> *)
>>>  mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module info attr(ff60) port(2) i2c_addr(50) offset(128) size(48): Response Mad Status(41c) - the connected cable has no EPROM (passive copper cable)
>>>  mlx4_en: eth2: mlx4_get_module_info i(0) offset(128) bytes_to_read(128) - FAILED (0xfffffbe4)
>>>
>>> *)
>>>  mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module ID attr(ff60) port(2) i2c_addr(50) offset(0) size(1): Response Mad Status(41c) - the connected cable has no EPROM (passive copper cable)
>>>
>>> *)
>>>  mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module info attr(ff60) port(2) i2c_addr(50) offset(0) size(48): Response Mad Status(41c) - the connected cable has no EPROM (passive copper cable)
>>>  mlx4_en: eth2: mlx4_get_module_info i(0) offset(0) bytes_to_read(128) - FAILED (0xfffffbe4)
>>>
>>> *)
>>>  mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module ID attr(ff60) port(2) i2c_addr(50) offset(0) size(1): Response Mad Status(41c) - the connected cable has no EPROM (passive copper cable)
>>>
>>> I wonder if in this situation we are communicating with a wrong device or returning some stale data from kernel memory or the firmware?
>>>
>>> Thanks,
>>>  Krzysztof
>>>
>>> [1]
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mellanox/mlx4/port.c#n2200
>>>
>>>
>>> [2]
>>>         Identifier                                : 0x03 (SFP)
>>>         Extended identifier                       : 0x04 (GBIC/SFP defined by 2-wire interface ID)
>>> (...) 
>>>         Optical diagnostics support               : Yes
>>>         Laser bias current                        : 0.000 mA
>>>         Laser output power                        : 0.0000 mW / -inf dBm
>>>         Receiver signal average optical power     : 0.0000 mW / -inf dBm
>>>         Module temperature                        : 0.00 degrees C / 32.00 degrees F
>>>         Module voltage                            : 0.0000 V
>>>         Alarm/warning flags implemented           : Yes
>>>         Laser bias current high alarm             : Off
>>>         Laser bias current low alarm              : Off
>>>         Laser bias current high warning           : Off
>>>         Laser bias current low warning            : Off
>>>         Laser output power high alarm             : Off
>>>         Laser output power low alarm              : Off
>>>         Laser output power high warning           : Off
>>>         Laser output power low warning            : Off
>>>         Module temperature high alarm             : Off
>>>         Module temperature low alarm              : Off
>>>         Module temperature high warning           : Off
>>>         Module temperature low warning            : Off
>>>         Module voltage high alarm                 : Off
>>>         Module voltage low alarm                  : Off
>>>         Module voltage high warning               : Off
>>>         Module voltage low warning                : Off
>>>         Laser rx power high alarm                 : Off
>>>         Laser rx power low alarm                  : Off
>>>         Laser rx power high warning               : Off
>>>         Laser rx power low warning                : Off
>>>         Laser bias current high alarm threshold   : 0.000 mA
>>>         Laser bias current low alarm threshold    : 0.000 mA
>>>         Laser bias current high warning threshold : 0.000 mA
>>>         Laser bias current low warning threshold  : 0.000 mA
>>>         Laser output power high alarm threshold   : 0.0000 mW / -inf dBm
>>>         Laser output power low alarm threshold    : 0.0000 mW / -inf dBm
>>>         Laser output power high warning threshold : 0.0000 mW / -inf dBm
>>>         Laser output power low warning threshold  : 0.0000 mW / -inf dBm
>>>         Module temperature high alarm threshold   : 0.00 degrees C / 32.00 degrees F
>>>         Module temperature low alarm threshold    : 0.00 degrees C / 32.00 degrees F
>>>         Module temperature high warning threshold : 0.00 degrees C / 32.00 degrees F
>>>         Module temperature low warning threshold  : 0.00 degrees C / 32.00 degrees F
>>>         Module voltage high alarm threshold       : 0.0000 V
>>>         Module voltage low alarm threshold        : 0.0000 V
>>>         Module voltage high warning threshold     : 0.0000 V
>>>         Module voltage low warning threshold      : 0.0000 V
>>>         Laser rx power high alarm threshold       : 0.0000 mW / -inf dBm
>>>         Laser rx power low alarm threshold        : 0.0000 mW / -inf dBm
>>>         Laser rx power high warning threshold     : 0.0000 mW / -inf dBm
>>>         Laser rx power low warning threshold      : 0.0000 mW / -inf dBm
>>>
>>> [3]
>>> # ethtool -m eth1
>>>         Identifier                                : 0x03 (SFP)
>>>         Extended identifier                       : 0x04 (GBIC/SFP defined by 2-wire interface ID)
>>>         Connector                                 : 0x07 (LC)
>>>         Transceiver codes                         : 0x10 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>>>         Transceiver type                          : 10G Ethernet: 10G Base-SR
>>>         Encoding                                  : 0x06 (64B/66B)
>>>         BR, Nominal                               : 10300MBd
>>>         Rate identifier                           : 0x00 (unspecified)
>>>         Length (SMF,km)                           : 0km
>>>         Length (SMF)                              : 0m
>>>         Length (50um)                             : 80m
>>>         Length (62.5um)                           : 30m
>>>         Length (Copper)                           : 0m
>>>         Length (OM3)                              : 300m
>>>         Laser wavelength                          : 850nm
>>>         Vendor name                               : IBM-Avago
>>>         Vendor OUI                                : <REDACTED>
>>>         Vendor PN                                 : <REDACTED>
>>>         Vendor rev                                : G2.3
>>>         Option values                             : 0x00 0x1a
>>>         Option                                    : RX_LOS implemented
>>>         Option                                    : TX_FAULT implemented
>>>         Option                                    : TX_DISABLE implemented
>>>         BR margin, max                            : 0%
>>>         BR margin, min                            : 0%
>>>         Vendor SN                                 : <REDACTED>
>>>         Date code                                 : <REDACTED>
>>> netlink error: Unknown error 1820
> 
> Thanks,
>  Krzysztof
> 


