Return-Path: <netdev+bounces-305368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4YLAIenDTGpzpQEAu9opvQ
	(envelope-from <netdev+bounces-305368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:16:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBBE7199AD
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:16:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=i3qYxE+P;
	dkim=pass header.d=redhat.com header.s=google header.b=POUFeZhU;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305368-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305368-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81D13305CDE1
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 09:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C0D3911B6;
	Tue,  7 Jul 2026 09:11:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDB839099C
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 09:11:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415499; cv=none; b=AHh80+v+VhwCd6LQEzVbSliEdtIko4tkdNBzNZxYZpZCz/ShLHoD7I6+o2W0Du3uz8la3nPOcByQQta6pnVcFAA293ugNirQfQyWCfYoronu3fMKIpJgcygDrZirdsbjRUUjX6MFvPB0R0p/XqXk3J6WrbxlyLZ3ol6D1fqfiRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415499; c=relaxed/simple;
	bh=ZMbwppaEOt+Q4DVo9jrvDNtl/WKltKL0JxXqxucsSjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdIoJWly8ELPQifzkW5+FomySWag7mynSxVTnW7QkItLFj9E8LbXzczR8Q/MSiWKCIRc3HQdRRUcRWIte8TTdK5qZUDeAwFDxHauUlqcHmGAh2Kj9UQiAasxQc6gJgnR096GQNXrwS93ySRtrofVbiKPhjKrg0FyCWb7pZElk/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i3qYxE+P; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=POUFeZhU; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783415496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z5RnetOGjoSbZBofYUofFjQ2y5JiYAZXkRIu1Tnosi0=;
	b=i3qYxE+P8nELwFVpvoGOW9TybHDGJOMTWbmXT5Z7Jh3nFu0XPCRh1g9rtUFjNpD7lBCyuY
	6hqDKT35hlZkzVvhqSRJTSE9r/HlrLGtjo50wgnosC3qe8lJEIUsB9jfDpykNh7FX+S22X
	+Kq92wqjiL2iJlZwBovi/NozHMGFidc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-P2fuAEpUMLq86CFZLOgVEA-1; Tue, 07 Jul 2026 05:11:35 -0400
X-MC-Unique: P2fuAEpUMLq86CFZLOgVEA-1
X-Mimecast-MFC-AGG-ID: P2fuAEpUMLq86CFZLOgVEA_1783415494
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493a7fa8481so3106455e9.1
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 02:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783415494; x=1784020294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z5RnetOGjoSbZBofYUofFjQ2y5JiYAZXkRIu1Tnosi0=;
        b=POUFeZhU4Yt11yUrKTldF3+CRgmKLsHqv1VWSzpi1ISPefpfIyG8O+PnJQn5jSPJcg
         60WgUrWmS7US8J+1niob0Wa3d7s7Z0CuXq0u5vylqg/6m38XZckthU7c8NnJrs6hMeu7
         2SL+FD5ucI/PbBvAjG+LVZDByfK/Gb5aYSfBG+LzNqmDd9vMknN1PNre8/2Id8obyeAg
         hE/lX1UnDB8T6XOYaSwLi2QQ535bVhlw3VFg/kmSNUWuWsVrGqDVV010Mh9e+quT4f6t
         XGNe6bjAL236kGsfgsulsXiPO8UCf3VQHzRzGe0DgwRyoguqIRpaRecRd7Ql//AAQF2P
         tspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783415494; x=1784020294;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z5RnetOGjoSbZBofYUofFjQ2y5JiYAZXkRIu1Tnosi0=;
        b=eFXCphX091aAjJMtuj5fyalGpboFyWHynqm/iczF3v8cqjuSULcenkPCsHIkcdDiKi
         6JnCyy1lJcr14QTCOL8+niV+H5Wd7RhTXS0LzSmmko4/AIxB9JARI9kkuoJYtG0eRHqu
         C9p8rk2C5gZHdCfSwokZXKV5X8jTVHIXmQHivgDAr9jComU1pXqlsJCGF4YtOZGQGhPt
         TKU2CcNEyGcvaZ7wjA4j02B8o40d0kpOh3kTloBxDh84TXpZDHD+J+hRQ1kphwvugDWE
         W6v/r90nFYgJKIIZN08LrOFDBqCAXIPb6sMue/MVqCSxKt0UqVFJlGSVLDh9Ml2wk75a
         DQsg==
X-Forwarded-Encrypted: i=1; AHgh+Rrwo/44YjmxJI7FXLCjtfr7RPAjJx9Y0W27I6V7B+YL1Ydyo049Wj0pSnJpfwRJqrfreHCQx5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJwbQzdEUkjY7lMu4FWqOj+3YhIEZvlmEvXpgotKx9logZ4rus
	aLbl2roewjqwVyZ1CmgQjuiNDwm53xkU73+0++cFQUhw41dgTQWqTWO9cPFCVzFcncSyVwKYtS4
	FVf1ZkbQMmf1EIkPrcedq+HyL4Xq0cpz6Tapr7Wcr1C/s6I7u571TK7DM1g==
X-Gm-Gg: AfdE7cn/rofmex0rD4TGDQTkS0WI9h5u0NBEjEbb9CRAKRoraZ6Y4Qvog/w9+yebLqb
	ZImkcQufakKaL6brCuwJucZz21r9yG3lxHugooiUfi/K0+BmHe/cZrjR4znenuVOlu1hO5slmJb
	9LpiOc1hqRP8j0XZCL1ErDg7eZEiDd7knPzw5J5gBB07JZIyPg3F6o+yvvnULgMfoJ8owJ4Hze/
	aW+ZkRDX6kt+lI2ANqbE0SsClHz+/ELUxTFcUydsX5I2QZCuc+oWiLTJsnai17Q9bR4rzaGHhSk
	H7c4z93y9Wr4s8x6K003RLRc/H6ZlrM+dvf9jyzZnMy45Tq4NyneySnGXvLfxwYEA8q/HIn3pjg
	NRw910+7vmJmbqPlFzomD22b3I0a8lPYhwQjwGdXXX2ltnVICOYUamwsw56pypxlOiwqHN86hTE
	/oAWcWS/EsNPdR
X-Received: by 2002:a05:600c:4853:b0:492:2fc8:21f2 with SMTP id 5b1f17b1804b1-493e1012c27mr11908735e9.8.1783415493863;
        Tue, 07 Jul 2026 02:11:33 -0700 (PDT)
X-Received: by 2002:a05:600c:4853:b0:492:2fc8:21f2 with SMTP id 5b1f17b1804b1-493e1012c27mr11908505e9.8.1783415493425;
        Tue, 07 Jul 2026 02:11:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a558easm32340161f8f.27.2026.07.07.02.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 02:11:32 -0700 (PDT)
Message-ID: <0b75cedb-691f-44ca-891c-d42d5cd24fd2@redhat.com>
Date: Tue, 7 Jul 2026 11:11:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] ax88179_178a: Add HW support for AX179A-based chips
To: Birger Koblitz <mail@birger-koblitz.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
 <20260701-ax88179a-v1-2-13685df67515@birger-koblitz.de>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260701-ax88179a-v1-2-13685df67515@birger-koblitz.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305368-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mail@birger-koblitz.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1FBBE7199AD

On 7/1/26 7:42 AM, Birger Koblitz wrote:
>  static int ax88179_reset(struct usbnet *dev)
>  {
> -	u8 buf[5];
> -	u16 *tmp16;
> -	u8 *tmp;
>  	struct ax88179_data *ax179_data = dev->driver_priv;
>  	struct ethtool_keee eee_data;
> +	u16 *tmp16;
> +	u8 buf[5];
> +	u8 *tmp;
>  
>  	tmp16 = (u16 *)buf;
>  	tmp = (u8 *)buf;
>  
>  	/* Power up ethernet PHY */
> -	*tmp16 = 0;
> -	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL, 2, 2, tmp16);
> +	if (ax179_data->chip_version < AX_VERSION_AX88179A) {
> +		*tmp16 = 0;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL, 2, 2, tmp16);
>  
> -	*tmp16 = AX_PHYPWR_RSTCTL_IPRL;
> -	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL, 2, 2, tmp16);
> -	msleep(500);
> +		*tmp16 = AX_PHYPWR_RSTCTL_IPRL;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL, 2, 2, tmp16);
> +		msleep(500);
>  
> -	*tmp = AX_CLK_SELECT_ACS | AX_CLK_SELECT_BCS;
> -	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_CLK_SELECT, 1, 1, tmp);
> -	msleep(200);
> +		*tmp = AX_CLK_SELECT_ACS | AX_CLK_SELECT_BCS;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_CLK_SELECT, 1, 1, tmp);
> +		msleep(200);
> +	} else {
> +		*tmp = AX_PHY_POWER;
> +		ax88179_write_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, tmp);
> +		msleep(250);
> +	}
> +
> +	if (ax179_data->chip_version == AX_VERSION_AX88279) {
> +		*tmp16 = ax88179_mdio_read(dev->net, dev->mii.phy_id, MII_ADVERTISE);
> +		*tmp16 &= ~(ADVERTISE_10FULL | ADVERTISE_10HALF);
> +		*tmp16 |= ADVERTISE_RESV; /* Advertise 2.5GBit link */
> +		ax88179_mdio_write(dev->net, dev->mii.phy_id, MII_ADVERTISE, *tmp16);
> +	}
>  
>  	/* Ethernet PHY Auto Detach*/
>  	ax88179_auto_detach(dev);
>  
> +	if (ax179_data->chip_version >= AX_VERSION_AX88179A) {
> +		*tmp = AX_MAC_EFF_EN;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_BULK_OUT_CTRL, 1, 1, tmp);
> +
> +		*tmp16 = 0;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, tmp16);
> +
> +		*tmp = 0x04;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_LOW, 1, 1, tmp);
> +		*tmp = 0x10;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_HIGH, 1, 1, tmp);
> +
> +		*tmp = 0;
> +		if (dev->net->features & NETIF_F_HW_VLAN_CTAG_FILTER)
> +			*tmp |= AX_VLAN_CONTROL_VFE;

Does not build successfully:

../drivers/net/usb/ax88179_178a.c: In function ‘ax88179_reset’:
../drivers/net/usb/ax88179_178a.c:2376:33: error: ‘AX_VLAN_CONTROL_VFE’
undeclared (first use in this function)
 2376 |                         *tmp |= AX_VLAN_CONTROL_VFE;

Full log here:

https://netdev-ctrl.bots.linux.dev/logs/build/1119419/14655119/build_32bit/stderr

Side process note: the patch series shoudl include the target tree
('net-next' in this case).

/P


> +		if (dev->net->features & NETIF_F_HW_VLAN_CTAG_RX)
> +			*tmp |= AX_VLAN_CONTROL_VSO;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_VLAN_ID_CONTROL, 1, 1, tmp);
> +
> +		*tmp = 0xff;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_BM_INT_MASK, 1, 1, tmp);
> +
> +		*tmp = 0;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_BM_RX_DMA_CTL, 1, 1, tmp);
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_BM_TX_DMA_CTL, 1, 1, tmp);
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_ARC_CTRL, 1, 1, tmp);
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_SWP_CTRL, 1, 1, tmp);
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_TX_HDR_CKSUM, 1, 1, tmp);
> +	}
> +
>  	/* Read MAC address from DTB or asix chip */
>  	ax88179_get_mac_addr(dev);
>  	memcpy(dev->net->perm_addr, dev->net->dev_addr, ETH_ALEN);
>  
>  	/* RX bulk configuration */
> -	memcpy(tmp, &AX88179_BULKIN_SIZE[0], 5);
> -	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_BULKIN_QCTRL, 5, 5, tmp);
> -
> -	dev->rx_urb_size = 1024 * 20;
> -
> -	*tmp = 0x34;
> -	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_HIGH, 1, 1, tmp);
> -
> -	*tmp = 0x52;
> -	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_LOW, 1, 1, tmp);
> +	if (ax179_data->chip_version < AX_VERSION_AX88179A) {
> +		memcpy(tmp, &AX88179_BULKIN_SIZE[0], 5);
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_BULKIN_QCTRL, 5, 5, tmp);
> +		*tmp = 0x34;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_LOW, 1, 1, tmp);
> +
> +		*tmp = 0x52;
> +		ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_HIGH,
> +				  1, 1, tmp);
> +		dev->rx_urb_size = 1024 * 20;
> +	} else {
> +		/* The Bulk-Register configuration for the AX88179A is done in
> +		 * ax88179a_link_reset(), once the link is up for a given link and USB-speed.
> +		 */
> +		if (ax179_data->is_ax88772d)
> +			dev->rx_urb_size = 1024 * 24;
> +		else
> +			dev->rx_urb_size = 1024 * 48;
> +	}
>  
>  	/* Enable checksum offload */
>  	*tmp = AX_RXCOE_IP | AX_RXCOE_TCP | AX_RXCOE_UDP |
>  	       AX_RXCOE_TCPV6 | AX_RXCOE_UDPV6;
>  	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RXCOE_CTL, 1, 1, tmp);
> +	ax179_data->rx_checksum = 1;
>  
>  	*tmp = AX_TXCOE_IP | AX_TXCOE_TCP | AX_TXCOE_UDP |
>  	       AX_TXCOE_TCPV6 | AX_TXCOE_UDPV6;
>  	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_TXCOE_CTL, 1, 1, tmp);
>  
>  	/* Configure RX control register => start operation */
> -	*tmp16 = AX_RX_CTL_DROPCRCERR | AX_RX_CTL_IPE | AX_RX_CTL_START |
> -		 AX_RX_CTL_AP | AX_RX_CTL_AMALL | AX_RX_CTL_AB;
> -	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, tmp16);
> -
> -	*tmp = AX_MONITOR_MODE_PMETYPE | AX_MONITOR_MODE_PMEPOL |
> -	       AX_MONITOR_MODE_RWMP;
> +	ax179_data->rxctl = AX_RX_CTL_DROPCRCERR | AX_RX_CTL_START |
> +			    AX_RX_CTL_AP | AX_RX_CTL_AMALL | AX_RX_CTL_AB;
> +	if (ax179_data->ip_align)
> +		ax179_data->rxctl |= AX_RX_CTL_IPE;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &ax179_data->rxctl);
> +
> +	if (ax179_data->chip_version < AX_VERSION_AX88179A)
> +		*tmp = AX_MONITOR_MODE_PMETYPE | AX_MONITOR_MODE_PMEPOL | AX_MONITOR_MODE_RWMP;
> +	else
> +		*tmp = AX_MONITOR_MODE_RWMP;
>  	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MONITOR_MOD, 1, 1, tmp);
>  
>  	/* Configure default medium type => giga */
>  	*tmp16 = AX_MEDIUM_RECEIVE_EN | AX_MEDIUM_TXFLOW_CTRLEN |
> -		 AX_MEDIUM_RXFLOW_CTRLEN | AX_MEDIUM_FULL_DUPLEX |
> -		 AX_MEDIUM_GIGAMODE;
> -	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
> -			  2, 2, tmp16);
> +		 AX_MEDIUM_RXFLOW_CTRLEN | AX_MEDIUM_FULL_DUPLEX;
> +	if (!ax179_data->is_ax88772d)
> +		*tmp16 |= AX_MEDIUM_GIGAMODE;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, tmp16);
>  
>  	/* Check if WoL is supported */
>  	ax179_data->wol_supported = 0;
> @@ -1653,7 +2450,11 @@ static int ax88179_reset(struct usbnet *dev)
>  			     1, 1, &tmp) > 0)
>  		ax179_data->wol_supported = WAKE_MAGIC | WAKE_PHY;
>  
> -	ax88179_led_setting(dev);
> +	/* For chips starting with AX88179A, LEDS are configured by the adapter
> +	 * firmware directly from EEPROM/EFUSE values
> +	 */
> +	if (ax179_data->chip_version < AX_VERSION_AX88179A)
> +		ax88179_led_setting(dev);
>  
>  	ax179_data->eee_enabled = 0;
>  	ax179_data->eee_active = 0;
> @@ -1706,6 +2507,24 @@ static int ax88179_stop(struct usbnet *dev)
>  	return 0;
>  }
>  
> +static int ax88179a_stop(struct usbnet *dev)
> +{
> +	u16 reg16;
> +	u8 reg8;
> +
> +	ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &reg16);
> +	reg16 &= ~AX_MEDIUM_RECEIVE_EN;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, &reg16);
> +
> +	reg16 = 0;
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &reg16);
> +
> +	reg8 = 0;
> +	ax88179_read_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, &reg8);
> +
> +	return 0;
> +}
> +
>  static const struct driver_info ax88179_info = {
>  	.description = "ASIX AX88179 USB 3.0 Gigabit Ethernet",
>  	.bind = ax88179_bind,
> @@ -1732,6 +2551,45 @@ static const struct driver_info ax88178a_info = {
>  	.tx_fixup = ax88179_tx_fixup,
>  };
>  
> +static const struct driver_info ax88179a_info = {
> +	.description = "ASIX AX88179A USB 3.2 Gigabit Ethernet",
> +	.bind = ax88179a_bind,
> +	.unbind = ax88179a_unbind,
> +	.status = ax88179_status,
> +	.link_reset = ax88179a_link_reset,
> +	.reset = ax88179_reset,
> +	.stop = ax88179a_stop,
> +	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_MULTI_PACKET | FLAG_AVOID_UNLINK_URBS,
> +	.rx_fixup = ax88179a_rx_fixup,
> +	.tx_fixup = ax88179a_tx_fixup,
> +};
> +
> +static const struct driver_info ax88772d_info = {
> +	.description = "ASIX AX88772D/E USB 2.0 Fast Ethernet",
> +	.bind = ax88179a_bind,
> +	.unbind = ax88179a_unbind,
> +	.status = ax88179_status,
> +	.link_reset = ax88179a_link_reset,
> +	.reset = ax88179_reset,
> +	.stop = ax88179a_stop,
> +	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_MULTI_PACKET | FLAG_AVOID_UNLINK_URBS,
> +	.rx_fixup = ax88179a_rx_fixup,
> +	.tx_fixup = ax88179a_tx_fixup,
> +};
> +
> +static const struct driver_info ax88279_info = {
> +	.description = "ASIX AX88279 USB 3.2 2.5Gigabit Ethernet",
> +	.bind = ax88179a_bind,
> +	.unbind = ax88179a_unbind,
> +	.status = ax88179_status,
> +	.link_reset = ax88179a_link_reset,
> +	.reset = ax88179_reset,
> +	.stop = ax88179a_stop,
> +	.flags = FLAG_ETHER | FLAG_FRAMING_AX | FLAG_MULTI_PACKET | FLAG_AVOID_UNLINK_URBS,
> +	.rx_fixup = ax88179a_rx_fixup,
> +	.tx_fixup = ax88179a_tx_fixup,
> +};
> +
>  static const struct driver_info cypress_GX3_info = {
>  	.description = "Cypress GX3 SuperSpeed to Gigabit Ethernet Controller",
>  	.bind = ax88179_bind,
> @@ -1877,6 +2735,18 @@ static const struct driver_info at_umc2000sp_info = {
>  
>  static const struct usb_device_id products[] = {
>  {
> +	/* ASIX AX88179A/B USB 3.2 Gigabit Ethernet */
> +	USB_DEVICE_VER(0x0b95, 0x1790, 0x0200, 0x0200),
> +	.driver_info = (unsigned long)&ax88179a_info,
> +}, {
> +	/* ASIX AX88772D USB 2.0 100Mbit Ethernet */
> +	USB_DEVICE_VER(0x0b95, 0x1790, 0x0300, 0x0300),
> +	.driver_info = (unsigned long)&ax88772d_info,
> +}, {
> +	/* ASIX AX88279 USB 3.2 2.5GBit Ethernet */
> +	USB_DEVICE_VER(0x0b95, 0x1790, 0x0400, 0x0400),
> +	.driver_info = (unsigned long)&ax88279_info,
> +}, {
>  	/* ASIX AX88179 10/100/1000 */
>  	USB_DEVICE_AND_INTERFACE_INFO(0x0b95, 0x1790, 0xff, 0xff, 0),
>  	.driver_info = (unsigned long)&ax88179_info,
> 


