Return-Path: <netdev+bounces-172684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C8CA55B05
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0851B3B3D98
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B8827D778;
	Thu,  6 Mar 2025 23:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="um0w4+9b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1456A27811E
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 23:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741304552; cv=none; b=a//blD0ZJVX/TEgA3tkLbizszRgzL9M63AqaqCReBwC835/TDhSREN6Ia1wdsk4F8T15vKCg/p6JOCrib9eWxtPRs/T3B62CH5GOmQ67od3o1f5xslVOY/zcepjd6xJOegUeBciOcDhaBoT6wqLp74GmQANjVLJl4fkY3ihs4ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741304552; c=relaxed/simple;
	bh=tJEJfQjhxKeAqPrvSWuWasiFZZaUalkdDqunLHyvNDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jrRG3gohLM+CLNiPXdS4jrE4hqpDEVBMSqhjD9KLWYF0DNdzJA1kg93mNKVOCZx1S1ZNzqAJ14QDKvSS4jPBpe1/9UhyDF3jPlmLl5RZwydBCfQEfa5/IY131To7N5h9EWWHhxraP8ZtsgA7uEI6n0qY49LNEJwls8ewksq8jZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=um0w4+9b; arc=none smtp.client-ip=121.127.44.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1741304549;
 bh=hK36UdkUAC80MW7rI32wQbKkvzzOhAooKnorAx3Xf5w=;
 b=um0w4+9bcWuLVYp34fDSYDGC+YCVIdz/a7kQ9KekHMe8tnM+tyOKuVvvIdeutJBBhhx2QZjhJ
 xwXi/4Dvp/mkzHzOzWtjWwY/6knSkNe016olj2IQtnnOx7c9l2w/aQjH1/dNRkL9UH9L64IpDI4
 dm5QjQ9hECKlogGEcwERn55Y/9fYZyuPdRbJzrzcsT1F3niWOHAXCv4CWdntNwTpbYKot+LITI8
 Kq0m3jXHp/uswIA0xReoJm7aSMtbBZB3Clc0/FKybsaZ+VqS0FVKVDZu0wD/6Qz/ZM7+tE9M6cH
 cTGm9sinP8ht7c8hLXZDDeF9uTxxOJVA9YmSDWceGuLw==
X-Forward-Email-ID: 67ca32e3c1763851c065d3ce
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <3f341b96-1add-4eeb-b185-b4bfe0bf0250@kwiboo.se>
Date: Fri, 7 Mar 2025 00:42:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: rockchip-dwmac: Require
 rockchip,grf and rockchip,php-grf
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Wu <david.wu@rock-chips.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250306210950.1686713-1-jonas@kwiboo.se>
 <20250306210950.1686713-2-jonas@kwiboo.se>
 <5d69f4a2-511a-4e7e-bafe-5ce6171cb1d5@lunn.ch>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <5d69f4a2-511a-4e7e-bafe-5ce6171cb1d5@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 2025-03-06 23:32, Andrew Lunn wrote:
> On Thu, Mar 06, 2025 at 09:09:45PM +0000, Jonas Karlman wrote:
>> All Rockchip GMAC variants require writing to GRF to configure e.g.
>> interface mode and MAC rx/tx delay.
>>
>> Change binding to require rockchip,grf and rockchip,php-grf to reflect
>> that GRF (and PHP-GRF for RK3576/RK3588) control part of GMAC.
> 
> It is pretty unusual to change the binding such that something
> optional becomes mandatory. I would expect a bit more of a comment
> explaining why this does not cause backwards compatibility
> issues. Have all the .dtsi files always had these properties?

rockchip,grf was listed under required properties prior to the commit
b331b8ef86f0 ("dt-bindings: net: convert rockchip-dwmac to json-schema"),
maybe this was just lost during the conversion to yaml schema.

The DT's I have managed to check all seem to have the rockchip,grf prop
and the old .txt schema listed "phandle to the syscon grf used to
control speed and mode".

Without the rockchip,grf the driver just logged an error and ignored
trying to configure speed or mode.

We could possible leave it as optional, but when it is missing speed and
mode cannot be configured by the driver. Today this just result in an
error message, after this series there will instead be a probe error.

Regards,
Jonas

> 
>     Andrew
> 
> ---
> pw-bot: cr


