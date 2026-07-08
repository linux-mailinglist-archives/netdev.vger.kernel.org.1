Return-Path: <netdev+bounces-305912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5yFQGE2GTmo/OgIAu9opvQ
	(envelope-from <netdev+bounces-305912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:18:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB3472919B
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:18:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=openvpn.net header.s=google header.b=RvhU6nYc;
	dmarc=pass (policy=quarantine) header.from=openvpn.net;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305912-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305912-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 880203006512
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 17:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8185037269F;
	Wed,  8 Jul 2026 17:11:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B490F24293C
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 17:11:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783530686; cv=none; b=lUdM4f2V3lTt10zI5PZvxYhtLStaQxbrTY9DySfk23ETdMAHYBjKe3+uIDkvoJKIj36D83wejQE9MUCmLaXFnKJBphOhOxx8pSLIQcjaRi21PWgx8bhD5K5gwZfHEm/qcKO43wWHYZouDjLzVvrbFkZqdEzyYMMUepXyhv5iWV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783530686; c=relaxed/simple;
	bh=OnDvYeVZIHsNX3z20WKhruG+ctuNtQpNeAQXWrMSVEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DFTDHvshXHdlaGLAJ1WKeBXAWc3MxET4MtKBBdPK1V9A+UK3zXSe/2fkHmnR5rnfAVUIWDZNQuuNYbGcs9Fg3TzlegNP7ZpLZ3KzYMYPwYi7lJN0YfA/C006CT7Pl/yVp/1ebb5kd0RZbOjXI39oc0/CzmiiVwcA5WHkiNXDy8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=RvhU6nYc; arc=none smtp.client-ip=209.85.221.49
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47df4e62d2bso162244f8f.2
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 10:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1783530683; x=1784135483; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GyzOriDsnFAxPrnUCTnI1a6BXNPSDUrbqthMacprIY8=;
        b=RvhU6nYcL0HpLUF5Qj0aJPXlBCayfYzk6xpU3QYFByOsLaWW+bNOWeYTKV0HccYOWm
         Cm2qZ4+znI4oGVe6b3Vw33d3XClEu7xdey5PonqL/WHQzb/WKEaFXNQ3vxeRh8+Tnu7h
         W+JNZ/KObNJ8lbZ89a3tYAfWaWsoolmZ//AsG8MmUioja7ba4+dfXJGPko/8kWGKUFfp
         nQ6vdFTE7TzLOO0v1h7uqlWI1N4ECZNMXo87fNvU2O1vpBJok6uE/RvUshzlKEzidHUT
         EDQbCeRLyP8dXzF2uyiAnbMvQg9iHMv5KrmTyx0Urmji5pPPVAvu5qBmaObKx0tV2FPe
         0LuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783530683; x=1784135483;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GyzOriDsnFAxPrnUCTnI1a6BXNPSDUrbqthMacprIY8=;
        b=PlCYSMbdymXeq5QYl2Xjs8LjkOmPfb3TQzpkOEmggbUZksAbGlfptqbHB2QB8DSljn
         GwsphshhjAA9hW8rG7DHcfIM26y2ZY7/yBLgpWBgqOq95iv6XQLLARDfAfSMH/WBl+I9
         lGt/8ZFdt+R64ppkznhlQWW3H1WZ4NChRaktsJgKEx+Q5YulkS0fJLQspKT9e4Hhbucg
         ujEm/mBtadIFbspHKDfrfMkgvfCjWUiMjJvEbhQVoXwLWk5lM3c4Ejw/4RdCl4CO1cZQ
         8ymMqbdRIC/ntlSsDJChewADecEiryGfiETvs4Dz5w2ZER+edN+h9JRQWl6UAuNan010
         KmGQ==
X-Forwarded-Encrypted: i=1; AHgh+RonmbdrD8Cpc6vryWdCwjSZxAT+jGdp5RjDfHQYkuze7JktHJlmZ0WooEVo5xgukYvZNVG7QCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUXgOc7305sUqlhu2tcbKaabjcZmh5d3QKaW94chiGnD43zCLw
	eFBZSQywuyFyU4ONYw3IYnrcl7OXcaZ/bFgqt1HgfYmlzmpqzJEi24DbDwb1bg42wfmCSxIfIWY
	hqbY3LynPhF8s4sdAJx73LgFnv4A2iDbf1LWTiE9KeajQJF0dOZ3jwgARztWu6OrS
X-Gm-Gg: AfdE7cm1uwG3M4olJBo8fm+q0zwKJ5EjmB/Ufy3NKEDq840IJVsMU6nJNotoOYc3Zkj
	ErvdPDaoOfR6bbjE/C/ymtVChD+sL8cfmT4/Y1+F5wdCfbs09bHIitd/4WDy1I8JesDbADvZksW
	JAyetqLG6B9+GHUEaSXZsQwauwuB5amDcwBHT47RmTzHHFCSJSbjaJpuCCxevx+FdTuZ5ZNMZI5
	ZD+AZvV7JWBfrvMGqM7iW+k6do/DK7isddNAccUGtjX9CxGokJR0TQEGKngyt/QMZVfczlitbN9
	myjxZebToYVqwn/aDupPbPYJ//WnwU7cVKmW6gKBogisx4juI3pB6mXsskaCMViH0XkhebICUh2
	rhqq9iIwiUGhyJRsOCZyTzO+oRSmfy4+1ZuZqUWhu0yDyWRZjhkeZfrZVaqmV0aoYAqFchX+zcj
	Gpf4Ja8yV/XyjmyfOYnICYiTG0Ko0566DReIeF5bAF86bpKicv
X-Received: by 2002:a5d:6f04:0:b0:46f:558:a43f with SMTP id ffacd0b85a97d-47df071565dmr3521349f8f.4.1783530682867;
        Wed, 08 Jul 2026 10:11:22 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:d5c0:15e:e7ac:47cb? ([2001:67c:2fbc:1:d5c0:15e:e7ac:47cb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039b126sm43990941f8f.24.2026.07.08.10.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 10:11:22 -0700 (PDT)
Message-ID: <39bbffbc-3a33-4458-a0ba-424942ed5e25@openvpn.net>
Date: Wed, 8 Jul 2026 19:11:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] ip: add OVPN device mode support
To: David Ahern <dsahern@kernel.org>, Marco Baffo <marco@mandelbit.com>,
 netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
References: <20260703111419.842059-1-marco@mandelbit.com>
 <95c5e510-34c3-4ba3-9173-3d3954628948@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Organization: OpenVPN Inc.
In-Reply-To: <95c5e510-34c3-4ba3-9173-3d3954628948@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,quarantine];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305912-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:marco@mandelbit.com,m:netdev@vger.kernel.org,m:stephen@networkplumber.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,openvpn.net:from_mime,openvpn.net:dkim,openvpn.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ACB3472919B

On 08/07/2026 17:33, David Ahern wrote:
> On 7/3/26 5:14 AM, Marco Baffo wrote:
>> Allow selecting point-to-point or multi-peer mode when creating an
>> OVPN device.
> 
> iproute2 does not currently support ovpn, so this patch is doing more
> than just selecting a mode. It adds support to create ovpn netdevices
> via iproute2. Enhance the commit message.

Actually that already works out of the box, without teaching iproute2 
about 'ovpn'.

You can go with "ip link add ovpn0 type ovpn" and the interface will 
nicely show up.

However, the ovpn device mode is set to the default value, hence this 
patch enhances that part.

Regards,

> 
>>
>> Signed-off-by: Marco Baffo <marco@mandelbit.com>
>> ---
>>   ip/Makefile           |  2 +-
>>   ip/iplink.c           |  2 +-
>>   ip/iplink_ovpn.c      | 87 +++++++++++++++++++++++++++++++++++++++++++
>>   man/man8/ip-link.8.in | 24 ++++++++++++
>>   4 files changed, 113 insertions(+), 2 deletions(-)
>>   create mode 100644 ip/iplink_ovpn.c
>>
>> diff --git a/ip/Makefile b/ip/Makefile
>> index 3535ba78..978f6841 100644
>> --- a/ip/Makefile
>> +++ b/ip/Makefile
>> @@ -13,7 +13,7 @@ IPOBJ=ip.o ipaddress.o ipaddrlabel.o iproute.o iprule.o ipnetns.o \
>>       ipvrf.o iplink_xstats.o ipseg6.o iplink_netdevsim.o iplink_rmnet.o \
>>       ipnexthop.o ipmptcp.o iplink_bareudp.o iplink_wwan.o ipioam6.o \
>>       iplink_amt.o iplink_batadv.o iplink_gtp.o iplink_virt_wifi.o \
>> -    iplink_netkit.o ipstats.o
>> +    iplink_netkit.o ipstats.o iplink_ovpn.o
>>   
>>   RTMONOBJ=rtmon.o
>>   
>> diff --git a/ip/iplink.c b/ip/iplink.c
>> index 3f0b46c9..c6aee8b6 100644
>> --- a/ip/iplink.c
>> +++ b/ip/iplink.c
>> @@ -42,7 +42,7 @@ void iplink_types_usage(void)
>>   		"          ifb | ip6erspan | ip6gre | ip6gretap | ip6tnl |\n"
>>   		"          ipip | ipoib | ipvlan | ipvtap |\n"
>>   		"          macsec | macvlan | macvtap | netdevsim |\n"
>> -		"          netkit | nlmon | pfcp | rmnet | sit | team | team_slave |\n"
>> +		"          netkit | nlmon | ovpn | pfcp | rmnet | sit | team | team_slave |\n"
>>   		"          vcan | veth | vlan | vrf | vti | vxcan | vxlan | wwan |\n"
>>   		"          xfrm | virt_wifi }\n");
>>   }
>> diff --git a/ip/iplink_ovpn.c b/ip/iplink_ovpn.c
>> new file mode 100644
>> index 00000000..08e59526
>> --- /dev/null
>> +++ b/ip/iplink_ovpn.c
>> @@ -0,0 +1,87 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * iplink_ovpn.c	OpenVPN DCO device support
>> + *
>> + * Author: Marco Baffo <marco@mandelbit.com>
>> + *
>> + */
>> +
>> +#include <stdio.h>
>> +#include <string.h>
>> +#include <linux/if_link.h>
>> +
>> +#include "utils.h"
>> +#include "ip_common.h"
>> +
>> +static void print_explain(FILE *f)
>> +{
>> +	fprintf(f,
>> +		"Usage: ... ovpn [ mode { p2p | mp } ]\n"
>> +		"\n"
>> +		"MODE := p2p | mp\n"
>> +		"(p2p is the default if mode is not specified)\n");
>> +}
>> +
>> +static int ovpn_parse_opt(struct link_util *lu, int argc, char **argv,
>> +			  struct nlmsghdr *n)
>> +{
>> +	while (argc > 0) {
>> +		if (matches(*argv, "mode") == 0) {
>> +			__u8 mode;
>> +
>> +			NEXT_ARG();
>> +			if (strcmp(*argv, "p2p") == 0)
>> +				mode = OVPN_MODE_P2P;
>> +			else if (strcmp(*argv, "mp") == 0)
>> +				mode = OVPN_MODE_MP;
> 
> the options need to be a table used for both setting and displaying value.
> 

-- 
Antonio Quartulli
OpenVPN Inc.


