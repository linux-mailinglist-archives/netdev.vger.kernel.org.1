Return-Path: <netdev+bounces-264969-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ckrzAWVqq2nZcwEAu9opvQ
	(envelope-from <netdev+bounces-264969-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 00:59:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50619228DF0
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 00:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3F36303428C
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 23:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F101B3B530F;
	Fri,  6 Mar 2026 23:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IcF6/Uwh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C922248A3
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 23:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772841569; cv=none; b=pxDBkw00T91AU0FEwS+/A8INM5OhSuM5/BMHgmgWSLKsSc0r8FkNuQ+AKJuGTPVpZx2V+x+pqHXMauB9XByv9BT/po+DBRhMjxDtcvsSlVIBnOMG52QVfBC41fsHf2pEA6xC7DkYj4EZPaIiwRixOIai7mtf2hCrXM6bXI2pL6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772841569; c=relaxed/simple;
	bh=ZW1+oq/Da8XcxgWmfUmEhP57abAz7F5o70Tjo9q6nsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JUEN49fY8RDLyUbcE0UCaHSdEUZUN7V6Rydks4Cq4apKN0OHj/FUprq4A54O7K9pz4vl1ouxZjTo9DSW2Uk+jGL+ocdyKzLOH4FhDWdMPHjUDsqNj0ObrpPHoV5Vgcu8hygYV/l0S2P26uJI/Tuv7Qb9f9dIPdcmOyIPo3izB+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IcF6/Uwh; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-798527f822cso99066507b3.3
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 15:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772841567; x=1773446367;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XK1UJnsw5VgbgGd7ojvWupmQD7kBWTfLPbL/nlR+tX0=;
        b=hLD9162axJh5icagN5/VYt9nav3gf3TB+w/hLdyoyt2qz3mD5UKj2qzRy7IoOQ58nd
         gHAcL29gfeZa91+ZiTmlxYbOWRY4Ebu23OBt2hcDxtBTrrZAiLw7ZnVDhmMR1XOQmAYv
         3mLFfHD+5Ky4CABo7lghuZiwapl57Z+Zc1NnTM8ruJNBAs3IumW1p3DzwAc99GEtuEwg
         09S8TkcTa380djl7UjSEHDEIeO6Ew4xy1ajPwXW2kUAyuyNtahv3FahKO2v33GJLl5kY
         7kT9MCnxeVswzz/4RcVS1YbF++iOrCmEtbzLDqb5emogT8xdQyXVvRpF5oZSezyhV2Xi
         e78g==
X-Forwarded-Encrypted: i=1; AJvYcCVejnly4jLhqOg++dSlkybuvRoP9cC6pE1CXm5Ze+qors4bkGVo8QB3ubU8yE8A4G05naY/GCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuHgC0gNikkR2Dk4tf45jVVy3vL10G8MRU0hJJSXCUA20HTL1P
	Sil7tmx2/sJjfYx0dsdfOpnGsN41ER3FxfjYgZVYx6GpTro9+LIhyJ4vW2rGXwuuCH+5/6p+IcM
	fw4JEfFHbSW8SQep8V4SU2/HwdtnY3TQtjmDsWpy98IwxEi6GomP1wgxHP8DErSR9mBVEFC0mxL
	J14vkaOZ713GHXYZ6Wz0SlUyxtvwXMtpAXOW4FhBu3Dosh/X0l0Pj8sfuIrmrk1pjuobaOXhn+T
	CI2D2HJyTa6cJlX
X-Gm-Gg: ATEYQzzuqUM/1uv5moE4FPDOKpvJAJX9rRTUlSkqXeasbKlLg8ehCokNq8kiwv0WX3h
	xULJDTlzDxxsdzTUTAlEfQzSlOr9nDkKWbHaBpR/gNJpozm19GGzYMkfXJQZXFka7M6VpGpfEHy
	hzium6J11YLheTHQUgke5Z1lDUpf3GQTjiPFvu1iMt/j8t5nZvQkz/v4gOCbySvDda1e/xHY0mP
	QvsTRBznPJdiq2qlFaD/ya9rmq6Nvo8o/xnfrCl+dauVw0dUwGhjgwZgbYPO/tOI8iKz6O5jp4w
	2Zj/JUav7xSMoSHtzaKKqt6bFmLaY4ZDbIG7z0U3QTvLugDVI896BMGFm4b0sm+dNxTg6Mu0XFT
	Ht/FCzn0e2IT4jDxLT0sRSJ0xFu5YmBUgQhHI/9hRmn1ffuhvs0wx8Eq2NVmsZcI9/bR6GbFO8e
	F03ifwN7oAEfw8E6F9xhA5JbVPI1vs0Rllk0KG8NY5XMdsyyyKmbmsFkdxboUDt96K
X-Received: by 2002:a05:690c:660a:b0:797:d5f2:c64 with SMTP id 00721157ae682-798dd6445a7mr37283247b3.10.1772841567426;
        Fri, 06 Mar 2026 15:59:27 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-798dedb8a95sm2515067b3.30.2026.03.06.15.59.27
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2026 15:59:27 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2bdff07d8f4so9717376eec.1
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 15:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772841566; x=1773446366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XK1UJnsw5VgbgGd7ojvWupmQD7kBWTfLPbL/nlR+tX0=;
        b=IcF6/UwhLbumtZzUEz81q/cbtHRVhP8KQHHifZzJ6phInpegN3lwuJdTDESfAJMku1
         RlWqeok+y5nqjaHEh2HNP2ouzYqu9Zu0F9MmqTibjnGrLG1ag6o/LutaGPi33qUWRfau
         NiFyu/DodyR5H1WuE8SEk/HyLzbRHYQ/+IoUw=
X-Forwarded-Encrypted: i=1; AJvYcCUwoqQPXabIeMK6/ZVg/XP5kpvNCmJMfWQU/4ghhsC43WiF+x4e8R28lu+REGKSTJGsjVrWcaI=@vger.kernel.org
X-Received: by 2002:a05:693c:3001:b0:2b7:1d38:3596 with SMTP id 5a478bee46e88-2be4dfd0933mr1710132eec.4.1772841566209;
        Fri, 06 Mar 2026 15:59:26 -0800 (PST)
X-Received: by 2002:a05:693c:3001:b0:2b7:1d38:3596 with SMTP id 5a478bee46e88-2be4dfd0933mr1710122eec.4.1772841565549;
        Fri, 06 Mar 2026 15:59:25 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f984cf5sm2478214eec.33.2026.03.06.15.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 15:59:24 -0800 (PST)
Message-ID: <f604ba58-f8ea-43d6-a49e-400e781c23ae@broadcom.com>
Date: Fri, 6 Mar 2026 15:59:23 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bcmgenet: fix broken EEE by converting to
 phylib-managed state
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: opendmb@gmail.com, bcm-kernel-feedback-list@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, o.rempel@pengutronix.de,
 rmk+kernel@armlinux.org.uk, Andrew Lunn <andrew@lunn.ch>
References: <20260306083120.1076104-1-nb@tipi-net.de>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20260306083120.1076104-1-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 50619228DF0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,pengutronix.de,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-264969-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/6/26 00:31, Nicolai Buchwitz wrote:
> The bcmgenet EEE implementation is broken in several ways.
> phy_support_eee() is never called, so the PHY never advertises EEE
> and phylib never sets phydev->enable_tx_lpi.  bcmgenet_mac_config()
> checks priv->eee.eee_enabled to decide whether to enable the MAC
> LPI logic, but that field is never initialised to true, so the MAC
> never enters Low Power Idle even when EEE is negotiated - wasting
> the power savings EEE is designed to provide.  The only way to get
> EEE working at all is a manual 'ethtool --set-eee eth0 eee on' after
> every link-up, and even then bcmgenet_get_eee() immediately clobbers
> the reported state because phy_ethtool_get_eee() overwrites
> eee_enabled and tx_lpi_enabled with the uninitialised PHY eee_cfg
> values.  Finally, bcmgenet_mac_config() is only called on link-up,
> so EEE is never disabled in hardware on link-down.
> 
> Fix all of this by removing the MAC-side EEE state tracking
> (priv->eee) and aligning with the pattern used by other non-phylink
> MAC drivers such as FEC.
> 
> Call phy_support_eee() in bcmgenet_mii_probe() so the PHY advertises
> EEE link modes and phylib tracks negotiation state.  Move the EEE
> hardware control to bcmgenet_mii_setup(), which is called on every
> link event, and drive it directly from phydev->enable_tx_lpi - the
> flag phylib sets when EEE is negotiated and the user has not disabled
> it.  This enables EEE automatically once the link partner agrees and
> disables it cleanly on link-down.
> 
> Make bcmgenet_get_eee() and bcmgenet_set_eee() pure passthroughs to
> phy_ethtool_get_eee() and phy_ethtool_set_eee(), with the MAC
> hardware register read/written for tx_lpi_timer.  Drop struct
> ethtool_keee eee from struct bcmgenet_priv.
> 
> Fixes: fe0d4fd9285e ("net: phy: Keep track of EEE configuration")
> Link: https://lore.kernel.org/netdev/d352039f-4cbb-41e6-9aeb-0b4f3941b54c@lunn.ch/
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

