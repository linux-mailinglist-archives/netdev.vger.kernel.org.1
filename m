Return-Path: <netdev+bounces-172817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109B8A56361
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 10:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B05217134F
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 09:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0091E1DE5;
	Fri,  7 Mar 2025 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="kNqBrPsa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1981C84B7
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741338994; cv=none; b=Dh/CnGsRd26NSdmyV633qrYTRlXz/2S3AxN8Qz52VgPopX31piO6RdzzOsomOL3DZfq4BFGSUwjAa9YzU+5s4Y25N21xRQL6oc5LL1Q9arUEv77lQrd0zjY2fh2vFKqmjxCyN7XSHqyZFT2ESqL6KEebLXBa+VRfulgQcyqIddg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741338994; c=relaxed/simple;
	bh=9B1x7tm7VGsWqJAdosAMjavJ8BGidB6ECj8LF+UqJ58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qjwebSRUql2r4aDUCAu2CCEIK8wMpcXDmXLwGYG/CY8z0i/BsrQiTWtb2JFovHITbcnJTpVL2AFiQ7T9TT3jLwfAOcSJaDPJR7cSUoSKa0mSgOMxqWeJvKqRnY7Vka64I2DxbcP699g71vT2nBbVrm+DhxVpwU4E+/hrbPywzVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=kNqBrPsa; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1741338991;
 bh=l7Bmpx1B1OFaUSgPQarXLFPl0uH+PohveX2hywvmfnE=;
 b=kNqBrPsaubi+LI2RvY1AUqmwcLqP+yYnb2LdK1egTX0Q2W+v7IYP5A2VWvgiMaHV16jHlZaXo
 /mjrx17COXr/Sh1oZM9tqOmDfcwLQPZ6z64Ai4xpJ9TKTSqW4GYWi3xk3Bmp8OlI58mjQY9Z8x/
 dl0ZHMWFjMm6dvCwB+khLsn3t1yKOYJb3wA6qiX0RBcxDFHOPeC2p4tJMmMXovJkntYtN3VeZw3
 T36rglp2dzGx6XbqbCRBpz/n1eZJLRhcOq94Z0/2bIGCMiVzH8o9n2OZwcR4eARau8h8m1QybcI
 tw9cajLN4IOh5S+SON1bZi0+miq2nQK9fq+KhCud/N9A==
X-Forward-Email-ID: 67cab95fd992817a57e35d57
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <cbd6d3ee-8ad1-443f-9506-e28240ffb09e@kwiboo.se>
Date: Fri, 7 Mar 2025 10:16:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: Enable Ethernet controller on
 Radxa E20C
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
 <20250306221402.1704196-5-jonas@kwiboo.se>
 <e0e8fa5e-07a2-4f4f-80b9-ddb2332c27ea@lunn.ch>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <e0e8fa5e-07a2-4f4f-80b9-ddb2332c27ea@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 2025-03-06 23:49, Andrew Lunn wrote:
>> +&mdio1 {
>> +	rgmii_phy: ethernet-phy@1 {
>> +		compatible = "ethernet-phy-ieee802.3-c22";
> 
> The compatible is not needed. That is the default.

Interesting, however I rather be explicit to not cause any issue for
U-Boot or any other user of the device trees beside Linux kernel.

Regards,
Jonas

> 
> 	Andrew


