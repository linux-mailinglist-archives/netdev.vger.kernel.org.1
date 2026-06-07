Return-Path: <netdev+bounces-296183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7X7yL2YGJWqACwIAu9opvQ
	(envelope-from <netdev+bounces-296183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 07:49:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C46CE64EE5E
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 07:49:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=dnvXLX7w;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296183-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296183-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 28B6E3007AD5
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 05:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A412DB7A3;
	Sun,  7 Jun 2026 05:49:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A412853E9;
	Sun,  7 Jun 2026 05:49:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780811360; cv=none; b=OAJq9YH7aZ5NKdDZlrm1mjHDYrv8e7ol8XMkKxBwtbt2NA2seYc42RsNcN4N6TbGCAf6OcyacPBWZHKIRbciPeMiEU5aNSiVvWIMqu/f7TV6j4Xpro/cXXWQ74jqWKUuMVx86yKyAIU1U58W6oXlugeOQtlf2vsUfjmxH8DcAds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780811360; c=relaxed/simple;
	bh=uIzjOavKfaKb8A+vzifaV9lqqFBik5P++T7ZWM6BAyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cd57uTjavDDuCHSKErGsr6Ax5vd7lTNgYAFKYnztVtf0uyDZGjzqE3LihmTicJhuSK5r/vAHjlLwmEJsQ0T8tWGJN2h0lt8JT0pPQNShstwxsS4jVS2vK3XOTBQl1eiXYcqHdaoYARpZLstNv0dtSX348BCnb5QO5bgzO1nas2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dnvXLX7w; arc=none smtp.client-ip=198.137.202.133
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=7gO0UdD5vwxsvPbPXQOY8CU6VnCOXDgqC4KB2RZA/yc=; b=dnvXLX7w9zqkZtiR4Pl+7mJpyw
	vveBWG1NGSgCCVySw/omqLo3XsZ12cEcpGLao58K88QzIPLIV2Pj+JRD47zSGY8XB5Lfdzzv2GUhO
	d4uaD8HRZY/c0OIDRkIwHh7B9PHVU4367hivDfE9COUwtD4q1mnNoasGop1kF0cyWOinn3KNDAgkS
	/LfL+svckxrbZzGb28wR3XdTQ1g+IHJjDEedxi2/1latWxI0F65+i4TVQXEfzVnMZkhh92GF13MXA
	Rcct45/Z+tYWII8ZQCOebYJdKbwqIOYRJWlBBpUrI9CoDqRZHGDIViGMZO4e5BTA5UGT94sX09s/Z
	tSj387gw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wW6Ng-000000022zW-3Z1Q;
	Sun, 07 Jun 2026 05:49:08 +0000
Message-ID: <cf3d6937-1ffa-4d81-8e19-b3f607a7e1d1@infradead.org>
Date: Sat, 6 Jun 2026 22:49:06 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 16/16] Documentation: networking: Add
 timestamp related APIs to OA TC6 framework
To: Selvamani.Rajagopal@onsemi.com, Andrew Lunn <andrew@lunn.ch>,
 Piergiorgio Beruto <pier.beruto@onsemi.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 Jerry Ray <jerry.ray@microchip.com>
References: <20260605-s2500-mac-phy-support-v4-0-de0fbc13c6d8@onsemi.com>
 <20260605-s2500-mac-phy-support-v4-16-de0fbc13c6d8@onsemi.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260605-s2500-mac-phy-support-v4-16-de0fbc13c6d8@onsemi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296183-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[onsemi.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org];
	FORGED_SENDER(0.00)[rdunlap@infradead.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:andrew@lunn.ch,m:pier.beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:richardcochran@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,infradead.org:mid,infradead.org:from_mime,infradead.org:dkim,onsemi.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C46CE64EE5E

Hi,
These needs a few additional blank lines to avoid docs build warnings:

Documentation/networking/oa-tc6-framework.rst:554: WARNING: Explicit markup ends without a blank line; unexpected unindent. [docutils]
Documentation/networking/oa-tc6-framework.rst:561: WARNING: Explicit markup ends without a blank line; unexpected unindent. [docutils]
Documentation/networking/oa-tc6-framework.rst:566: WARNING: Explicit markup ends without a blank line; unexpected unindent. [docutils]
Documentation/networking/oa-tc6-framework.rst:573: WARNING: Explicit markup ends without a blank line; unexpected unindent. [docutils]

See below.


On 6/5/26 10:42 PM, Selvamani Rajagopal via B4 Relay wrote:
> From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> 
> Added new APIs to support hardware timestamp feature as defined in
> OPEN Alliance 10BASE-T1x MAC-PHY serial interface specification.
> 
> Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> ---
>  Documentation/networking/oa-tc6-framework.rst | 76 +++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/Documentation/networking/oa-tc6-framework.rst b/Documentation/networking/oa-tc6-framework.rst
> index fe2aabde923a..694d9485b1c5 100644
> --- a/Documentation/networking/oa-tc6-framework.rst
> +++ b/Documentation/networking/oa-tc6-framework.rst
> @@ -153,6 +153,10 @@ OPEN Alliance TC6 Framework
>  - Forwards the received Ethernet frame from 10Base-T1x MAC-PHY to n/w
>    subsystem.
>  
> +- If supported by the hardware and enabled, updates hardware timestamp
> +  in skb, when indicated by one of the three timestamp capture registers
> +  through TSC fields of the header.
> +
>  Data Transaction
>  ~~~~~~~~~~~~~~~~
>  
> @@ -495,3 +499,75 @@ the MAC-PHY.
>  Zero align receive frame feature can be enabled to align all receive ethernet
>  frames data to start at the beginning of any receive data chunk payload with a
>  start word offset (SWO) of zero.
> +
> +.. c:function:: int oa_tc6_ptp_register(struct oa_tc6 *tc6, \
> +                                        struct ptp_clock_info *info);
> +
> +Registers the PTP hardware clock related functions with the kernel.
> +This API simply registers. Initialization of the fields in the
> +ptp_clock_info structure are left to the vendor as programming hardware
> +timer is expected to be vendor dependent. The fields max_adj, owner,
> +and all the functions for the clock operations, like adjfine, gettimex64,
> +settime64, adjtime are expected to be initialized in the structure before
> +calling the registering the hardware clock.
> +
> +.. c:function:: void oa_tc6_ptp_unregister(struct oa_tc6 *tc6);
> +
> +Unregisters the PTP hardware clock related callbacks.
> +
> +.. c:function:: int oa_tc6_ioctl(struct oa_tc6 *tc6, struct ifreq *rq, \
> +                                 int cmd);
> +
> +ioctl interface to handle hardware timestamp and PHY related commands.
> +
> +.. c:function:: int oa_tc6_get_ts_info(struct oa_tc6 *tc6, \
> +                                       struct kernel_ethtool_ts_info *info);
> +
> +Provides timestamp related settings that are supported to ethtool.
> +
> +.. c:function:: void oa_tc6_hwtstamp_get(struct oa_tc6 *tc6, \
> +                                         struct kernel_hwtstamp_config *cfg);
> +
> +Returns hardware timestamp configuration. Part of net_device_ops callbacks.
> +
> +.. c:function:: void oa_tc6_get_ts_stats(struct oa_tc6 *tc6, \
> +                                         struct ethtool_ts_stats *ts_stats);
> +
> +Provides hardware timestamp related traffic statistics for ethtool.
> +
> +.. c:function:: int oa_tc6_hwtstamp_set(struct oa_tc6 *tc6, \
> +                                         struct kernel_hwtstamp_config *cfg);
> +
> +Helper to set hardware timestamp configuration. Part of net_device_ops
> +callbacks.
> +
> +.. c:function:: void oa_tc6_set_vend1_mms(struct oa_tc6 *tc6, int mms);
> +
> +Helper to map MDIO_MMD_VEND1 command to vendor specific Memory Map Select
> +(MMS) value. This function offers flexibility for vendors that may have
> +used any MMS value between 10 and 15 as allowed by the specification.
> +MDIO_MMD_VEND2 is already mapped to MMS4 in the OA TC6 frame work code.
> +
> +.. c:function:: int oa_tc6_write_registers_mms(struct oa_tc6 *tc6, \
> +                                               u16 address, u16 mms, \
> +                                               u32 value[], u8 length);

Insert blank line here.

> +Writing multiple consecutive registers starting from @address for the
> +given @mms memory map selector in the MAC-PHY. Maximum of 128 consecutive
> +registers can be written starting at @address.
> +
> +.. c:function:: int oa_tc6_write_register_mms(struct oa_tc6 *tc6, \
> +                                              u16 address, u16 mms, \
> +                                              u32 value);

and here.

> +Write a single register addressed by @address and @mms in the MAC-PHY.
> +
> +.. c:function:: int oa_tc6_read_registers_mms(struct oa_tc6 *tc6, \
> +                                              u16 address, u16 mms, \
> +                                              u32 value[], u8 length);
and here.

> +Reading multiple consecutive registers starting from @address for the
> +given @mms memory map selector value, in the MAC-PHY. Maximum of 128
> +consecutive registers can be read starting at @address.
> +
> +.. c:function:: int oa_tc6_read_register_mms(struct oa_tc6 *tc6, \
> +                                             u16 address, u16 mms, \
> +                                             u32 *value);

and here.

> +Read a single register addressed by @address and @mms in the MAC-PHY.
> 

-- 
~Randy


