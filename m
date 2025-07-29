Return-Path: <netdev+bounces-210887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB54B15479
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 22:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DBD57B0E2B
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 20:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62930279910;
	Tue, 29 Jul 2025 20:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="FyXYKkBh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AB2278E63
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 20:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753822587; cv=none; b=pnWG38PDnvLTPd+KgJiGLP5N/3orY4hHrWV7cQ5tOY7HwfXvPqWetzrhIp0sHDrtt5GzfgGW1P9e18P4fjI+nHPv1MuDZTGZCGa94bU92Ygo87w8XRkfarmDGoiqh4GydkeHRHyMmC5/eKCfy7k9s/PRRWR4hyL7abhUiULCSHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753822587; c=relaxed/simple;
	bh=Z1Kr26XwW405L9j7UMRlKke0625JiBNeN1OtSRfhsDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rfMdoHnhXonI+/2sh/mkM9z99m/qfR77uViS7g7kW/wvDPTOWkZZkQcPTxWjABq9yu3QzgPI4+/YkQl0KQq/2LuFzhrQgvsmInlf6JyD8yqMXr9RWjFKLkLAaZJRB5lSCOEiRPZugw5LKqgN49wChsK9gs+1t5XTKwbqDIJw4nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=FyXYKkBh; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1753822584;
 bh=v+EFRhrySWl3zLJ7XlS9rNLMc1j/yRIrm57mAagtY1s=;
 b=FyXYKkBhpQXdl2wC1/tJTM3l4w/IhZXNtC8ftd70Ok2MSMEwPx7MuTiuv1FSqOYRM9vnjjEa1
 UFByQHAwWDm1lGlIUGWRdsbQNuNfamBTwnrLmUU1wq0BKoShL1Dc09FK4rECYS8RMX8PcsNI4b7
 tjMF5lvhFVrwbrwJGbvn74lG1fuFNZGkAPoe8kNrQ+MOxDI630TRxAoBpBQ29CMoiYCgFMIfAY4
 60Lyobc8JZ3p0apA8PmbENRHwcMGsW4dhdarp6/T6pb8iF0c9aEkWGe38qe5lExZ7W7KgMLUiRp
 Zn6gnD9FWXqVQMIAF/nfkNZ+WPEVWy6p03MlAnqoIZDA==
X-Forward-Email-ID: 688935605983c8a2f4b4a751
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <db1f42c3-c8bb-43ef-a605-12bfc8cd0d46@kwiboo.se>
Date: Tue, 29 Jul 2025 22:55:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add RTL8367RB-VB switch to
 Radxa E24C
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: "alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>,
 "andrew@lunn.ch" <andrew@lunn.ch>, "conor+dt@kernel.org"
 <conor+dt@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "heiko@sntech.de" <heiko@sntech.de>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "olteanv@gmail.com" <olteanv@gmail.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
 <robh@kernel.org>, "ziyao@disroot.org" <ziyao@disroot.org>
References: <5bdd0009-589f-49bc-914f-62e5dc4469e9@kwiboo.se>
 <20250729115009.2158019-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250729115009.2158019-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Chukun,

On 7/29/2025 1:50 PM, Chukun Pan wrote:
> Hi,
> 
>> The issue is with TSO and RX checksum offload, with those disabled on
>> the conduit interface (gmac1/eth0) my issues disappeared.
> 
> I did a test today and the same problem occurred when running the new
> kernel on my rk3568 + rtl8367s board. This problem does not exist on
> older kernels (6.1 and 6.6). Not sure where the problem is.

I had only tested on a next-20250722 based kernel and on a vendor 6.1
based kernel. And similar to your findings, on 6.1 based kernel there
was no issue only on the newer kernel.

I will probably drop the use of "/delete-property/ snps,tso" and include
a note in commit message about the TSO and RX checksum issue for v2.

> 
>> With a 'mdio' child node 'make CHECK_DTBS=y' report something like:
>>
>>    rockchip/rk3528-radxa-e24c.dtb: ethernet-switch@1d (realtek,rtl8365mb): mdio: False schema does not allow { [snip] }
>>          from schema $id: http://devicetree.org/schemas/net/dsa/realtek.yaml#
>>
>> With a mdio node the driver is happy and dtschema is sad, and without
>> the mdio node it was the other way around.
> 
> On older kernels (6.1/6.6) only realtek-smi requires mdio child OF node.
> Commit bba140a566ed ("net: dsa: realtek: use the same mii bus driver for both interfaces")
> changed this behavior, both MDIO interface and SMI interface need it
> (rtl83xx_setup_user_mdio), but the dt-bindings has not been updated.
> I think this needs a Fixes tag.

Thanks for finding this, and yes I can see that commit bba140a566ed
changed the behavior of the driver and probably broke out-of-tree users.

My current plan for a v2 is to:
- include a new dt-bindings patch to allow use of a mdio node
- include a mdio node in the switch node
- add a Fixes tag to the driver patch

Then leave up to maintainers to decide if they want to accept this patch
or not.

Regards,
Jonas

> 
> Thanks,
> Chukun
> 
> --
> 2.25.1
> 
> 


