Return-Path: <netdev+bounces-296158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qOhDARyIJGo08QEAu9opvQ
	(envelope-from <netdev+bounces-296158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 22:50:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 921BC64E56A
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 22:50:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YYQfggFB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296158-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296158-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63AFC3018AF3
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 20:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D803164B7;
	Sat,  6 Jun 2026 20:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79E024E4C6
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 20:50:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780779024; cv=none; b=RG85INFwK0ChZoWipGHM4ecrnvB0onIOeX2NGUQ8LbU7IpQG3pOcGu5a4PF244Nrtc1aqR7fK9Xg87JezbLwAo0djcdNz6W43M2TtGZRwwK2m0OYx9C+6INt7/jtl6uyg+ycD9S9kiuvR2bojOrQX7gDpKbLk3myKGC/3E5bldY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780779024; c=relaxed/simple;
	bh=ab89G/27l/5o7tuJPd46KvxXOp2HCBuR6xIqDz8zGn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=scZzTdNxT0H7yo4Ds0OlELvxIJLTivLgG9jNDgvpP/mmC6lBpHXNycRJXeZlLPannekam73+9UBTJFyYE3Z/DVT+ntr4iPbg5CeY3sRF7aSe3dnArbnkIdW/JivyXp+zlvDLBpsvyVH/JtaJ7A1c/lR6i6KvbAPAVdodnZ/NjVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYQfggFB; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b4e1ade7so32971295e9.0
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 13:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780779021; x=1781383821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KICvSmr67GVRpflb7Bqnkr43eQwEX55VG2vB71Ne/XY=;
        b=YYQfggFBRnj/hmo8ymAFncLuqRxLm7FzmFwU9UlzoeBHbCom//18HGAKELMuX1q6Jq
         IqyYqtgw+OodhpoLbgR8O/1Kz8UaxrLqaYcSMmadETNDPHAbV5JM0dshIhyRYdkRrWBo
         uh47ss83wnGfjDAipzg3p1bEDoEhDO5mZMG2afSr17/P1VGQywP6t2DWzKMZpSD+vR9q
         W3qIIuP2TO6jznJPkzXII0DJKvvDrOkhrY+brN9SZ+fC5/Z8ssRwtAtVY0azhJ8f0+TW
         6qbY8dkA5aA5Eawtq7SOzQjXVoPMl3LvcRMn2ejOmA9cXd/bsveFfnOgaw5VrWm5Ipv/
         CMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780779021; x=1781383821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KICvSmr67GVRpflb7Bqnkr43eQwEX55VG2vB71Ne/XY=;
        b=HAfh3W9tTo5phWN8QHyJ2HMGdgjuVQtntPu+ABPYy5Xq4U0vmSkKFfF7ta7bbxhj+K
         pcwx1Ubg0BWMnKVrgJM0zMNqvX9mXUsyy0oeVYcJGL+Xp2xcwJpiJlSt+dbmRra0l3+6
         PlNAzHxR1W943QHlKriuOAoUlnmvA4rtsA0XaJkkanQJpUDzZROryx1K+Kgn8VRagXcf
         A6k+1xab+7xMH8SFIZVMNjZ3fg69HwlFrxJF/fvEzh7q9UvIdYdRgT6zl3fE6vynbv0W
         fSKZ4YiYX7bDHcjIgANOTBWgk7F1Ps5ob7Vyb1AC8cS3HsmkemvJXW6QzskJg4QE63N2
         an1g==
X-Forwarded-Encrypted: i=1; AFNElJ8tr+l0W/UOr2ey/xvVL1Uoqiu4kFqbDqLSRkwF9EDoOdbz/irNtnHcr77Qfj3joZM269rZUU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrJCGwNYH4OOxtM2CbQW2y7BCFYZE5aUQtY8dmkIsdrypsh4Zh
	vkx3zr8oniMs3erAe+kFfP0zZSGxc6aF8TSg9hcsbAURInHW0/K+fb2D
X-Gm-Gg: Acq92OHPFOoc0IagMnB1p1gtKChFhF5LaxkyznL1x8gtEAtukSFgNSY5nGhmiGBEFr1
	qpJNgrZvH1KrPX1fBKpGkI6a+DmQPnhkNMk1pRbxV0zoNYgpAeS2N1qUWfeuSA9ppa8GXbG5JNl
	SOw9THVGQvM8UqUJmQHH2y6gnQFGu9qYS/JKZsmuIywbR9/Hgye4zkTtmDwaXmYM6ZOVFwheObM
	f5eyraOLwcQk53y1kgqI4e4CgbEUd95gICmNKranDNcvPJTkClElg3Bhm01NMEM9BYD3qhmHylG
	ZmEEpG1ZlyMs9L+VIfRCBYWox5ZgKchSu2IMjFaLs0ubFbxI/tDifF3E9uq9dqBRN3BmKBruRDQ
	XAmZMEJenmiE/qvLC52AwCNUHL2mQB9eurm38i7GzyyuAaaIg0wP/h1teyJv2y/nFPO8XAcerW3
	L49nSkNeJWjlRF0wsaSe4IkDF3vxMAt2Lrmd+d6S8vDBprif8RJ2LtN2fYRG1JO5IjD3+Q3o5ey
	taOL0qg24u3lZrs4F0Qwc1DO91dPiGUbmv7AOhx9i5sravzXPvNBGk4buFYgzoRfIp3PNk=
X-Received: by 2002:a05:600c:4708:b0:48a:6fd4:d3d3 with SMTP id 5b1f17b1804b1-490c2604735mr151296265e9.20.1780779020992;
        Sat, 06 Jun 2026 13:50:20 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f4a:1a00:ac2e:7640:d3:7bd5? (p200300ea8f4a1a00ac2e764000d37bd5.dip0.t-ipconnect.de. [2003:ea:8f4a:1a00:ac2e:7640:d3:7bd5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cbfe4sm259925885e9.7.2026.06.06.13.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2026 13:50:20 -0700 (PDT)
Message-ID: <667f64e0-2b3e-41bf-9c97-3562696d3af7@gmail.com>
Date: Sat, 6 Jun 2026 22:50:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: net: add Realtek r8169 family PCIe
 Ethernet
To: Ricardo Pardini <ricardo@pardini.net>, nic_swsd@realtek.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20260605-rk3588-dts-rtl-eth-describe-dt-alias-v3-0-8a8857b39daf@pardini.net>
 <20260605-rk3588-dts-rtl-eth-describe-dt-alias-v3-1-8a8857b39daf@pardini.net>
 <b7cc8eba-ff6e-417d-8e74-b3bb24e08a26@gmail.com>
 <26da1dfa-3408-4654-9046-36ed6d57059c@pardini.net>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <26da1dfa-3408-4654-9046-36ed6d57059c@pardini.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-296158-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ricardo@pardini.net,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:sebastian.reichel@collabora.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 921BC64E56A

On 06.06.2026 07:03, Ricardo Pardini wrote:
> On 05/06/2026 17:48, Heiner Kallweit wrote:
>> On 05.06.2026 13:49, Ricardo Pardini via B4 Relay wrote:
>>> From: Ricardo Pardini <ricardo@pardini.net>
>>>
>>> Add a binding for fixed/soldered Realtek PCIe Ethernet controllers
>>> driven by the r8169 driver (RTL8125/8126/8127/8168 and variants).
>>>
>>> The "pciVVVV,DDDD" compatibles are the Open Firmware PCI Bus Binding
>>> spelling, auto-derived from PCI-SIG vendor/device IDs, but they still
>>> need a binding when used in a board DT - analogous to "usbVVVV,PPPP"
>>> compatibles documented in their own bindings (e.g. microchip,lan95xx)
>>> so board DTs attaching properties (fixed MAC, nvmem cell, ...) to
>>> these PCI function nodes can be validated.
>>>
>>
>> The of node seems to be created by of_pci_make_dev_node(). But this
>> function is called for bridges only in pci_bus_add_device().
>> So where is the node created in your case? Did you test node creation?
>>
> 
> Hi Heiner,
> 
> Seems to me of_pci_make_dev_node() is not at play here - that's the DT-synthesis path. For nodes already present in DT, the of_node is bound earlier, during pci_setup_device() -> pci_set_of_node() -> of_pci_find_child_device() via the 5-cell reg.
> 
I see, thanks. If the matching is done based on the reg property, then I just wonder
if and where the compatible string is used. Or would the logic also work with a
random compatible string?

> Ref testing: yes; with this series on a NanoPC-T6 I get, for example:
> /sys/bus/pci/devices/0004:41:00.0/of_node -> /sys/firmware/devicetree/base/pcie@fe190000/pcie@0,0/ethernet@0,0 and u-boot correctly adds local-mac-address property there which is correctly picked up kernel-side:
> 
> => setenv eth1addr 8e:b4:90:66:66:66
> => boot
> 
> ...
> 
> # readlink -f /sys/bus/pci/devices/0004:41:00.0/of_node
> /sys/firmware/devicetree/base/pcie@fe190000/pcie@0,0/ethernet@0,0
> 
> # xxd /sys/bus/pci/devices/0004:41:00.0/of_node/local-mac-address
> 00000000: 8eb4 9066 6666                           ...fff
> 
> # ip link show dev end1 | grep ether
>     link/ether 8e:b4:90:66:66:66 brd ff:ff:ff:ff:ff:ff
> 
> 
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - pci10ec,8125  # RTL8125 2.5GbE
>>> +      - pci10ec,8126  # RTL8126 5GbE
>>> +      - pci10ec,8127  # RTL8127
>>> +      - pci10ec,8161  # RTL8168 variant
>>> +      - pci10ec,8162  # RTL8168 variant
>>> +      - pci10ec,8168  # RTL8168/8111 GbE
>>
>> This list reflects just some of the PCI id's handled by r8169.
>> Any specific reason for this exact selection?
> I went for "chips likely to be soldered down on an SBC", but that was indeed speculative.
> 
> I guess I should trim to pci10ec,8125, which is all this series describes? (further IDs can be added by the patches that introduce boards using them)
> 
Yes, I'd prefer this approach. Considering that RTL8168 has been supported for
about 20yrs now, your use case seems to be exotic. Otherwise I would have
such a patch much earlier.

> -- 
> Regards,
> Ricardo
> 


