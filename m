Return-Path: <netdev+bounces-172688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A49A55B69
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27971899C5E
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A947A17F7;
	Fri,  7 Mar 2025 00:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="ViDQJMYY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A7423AD
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 00:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741305947; cv=none; b=P3o/xg762a8oyDQPE+05jDqxFUoGCdpOSKMuaBTfrqRDZ7xLZxCEkNtmFN9VJxZAIWS/YnEP/TLkGLgYA4FkacFmNThhPt45YfcOwx6mNNN+i/gj87AXG5BHsQZal8WF5irKtsx5TW8lL2PxHsW76FgGrPfta4HN7eRq5mzTGB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741305947; c=relaxed/simple;
	bh=3xzndWS90lxvRgrGpXolhhCHNJh+cKO5OpPa3qNLBvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sbxWOjYrf3u6TXG01GligNNjNs4lIK4eWaxlEonmhfLC6PxJxEtJWxGSPe8/F8E6bkWrilXu/JLvqObVLhJwKtSBOo2IHOzYsCwJKDxkRorzULO5d5q0mjNo3jKDKt099Gr1dt9bdBLoxXWlFgftLmxXRd91YmISxsB7iXr2iqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=ViDQJMYY; arc=none smtp.client-ip=121.127.44.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1741305945;
 bh=q8v6FqGBLcIgD0IKorolr/eW5VRYMlf3vVnAR1Zl+FQ=;
 b=ViDQJMYYdD+Pq6EMZf3OAvr3RCwVvT223n+2a9nOCtD/fjtAW63b1b0ibzAXEdD01Tzu8q5X8
 XMkiU5JGZ8uW8Yo8bXSeJxmKh5x1gJKmBfFGcEP2kCfcZt2/tn8mPBrl3vCTq0GRsZ0MI7hHLy5
 Z9/FU586O36+yLvB3l2hak0OBrueIZ08p79NdcjsKl/2HZXfdctTh+QaIb/ZxbLapQ7wNcjdtGn
 pGLL8sTSwRPGAW93avhaJvK3USxXdRU9YQo/sLHrxGK7G19uVbkapN2LJ7MVpxrKcF9bEq+uYvO
 ivE68qeJ4gVemgltd4Odg+x87P9IGcSlOAvAMEXnnh0w==
X-Forward-Email-ID: 67ca3854d01a7bf632cb828f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <003d3726-680a-4e91-89cd-d127bc3b5609@kwiboo.se>
Date: Fri, 7 Mar 2025 01:05:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add GMAC nodes for RK3528
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Yao Zi <ziyao@disroot.org>,
 linux-rockchip@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250306221402.1704196-1-jonas@kwiboo.se>
 <20250306221402.1704196-4-jonas@kwiboo.se>
 <a827e7e9-882a-40c6-9f2c-03d8181dff88@lunn.ch>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <a827e7e9-882a-40c6-9f2c-03d8181dff88@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 2025-03-06 23:46, Andrew Lunn wrote:
> On Thu, Mar 06, 2025 at 10:13:56PM +0000, Jonas Karlman wrote:
>> Rockchip RK3528 has two Ethernet controllers based on Synopsys DWC
>> Ethernet QoS IP.
>>
>> Add device tree nodes for the two Ethernet controllers in RK3528.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> gmac0 is missing the integrated-phy and has not been tested bacause I do
>> not have any board that use this Ethernet controller.
> 
> What do you know about the integrated PHY? Does it use one of the
> standard phy-modes? RMII? Does the datasheet indicate what address it
> uses on the MDIO bus? If you know these two bits of information, you
> can probably add it.

The SoC datasheet lists following:

  MAC 10/100/1000 Ethernet Controller (gmac1)
  - Support 10/100/1000 Mbps data transfer rates with the RGMII interfaces
  - Support 10/100 Mbps data transfer rates with the RMII interfaces
  - Support both full-duplex and half-duplex operation
  - Supports IEEE 802.1Q VLAN tag detection for reception frames
  - Support detection of LAN wake-up frames and AMD Magic Packet frames
  - Support checking IPv4 header checksum and TCP, UDP, or ICMP checksum
    encapsulated in IPv4 or IPv6 datagram
  - Support for TCP Segmentation Offload (TSO) and UDP Fragmentation
    Offload (UFO)

  MAC 10/100M Ethernet controller and MAC PHY (gmac0)
  - Support one Ethernet controllers
  - Support 10/100-Mbps data transfer rates with the RMII interfaces
  - Support both full-duplex and half-duplex operation

and vendor kernel use following DT node:

	phy-mode = "rmii";
	clock_in_out = "input";
	phy-handle = <&rmii0_phy>;

	mdio0: mdio {
		compatible = "snps,dwmac-mdio";
		#address-cells = <0x1>;
		#size-cells = <0x0>;

		rmii0_phy: ethernet-phy@2 {
			compatible = "ethernet-phy-id0044.1400", "ethernet-phy-ieee802.3-c22";
			reg = <2>;
			clocks = <&cru CLK_MACPHY>;
			resets = <&cru SRST_MACPHY>;
			phy-is-integrated;
			pinctrl-names = "default";
			pinctrl-0 = <&fephym0_led_link &fephym0_led_spd>;
		};
	};

I could possible add something like that to the device tree, or I could
drop the entire gmac0 node and instead have it added in a future series.

Regards,
Jonas

> 
>     Andrew


