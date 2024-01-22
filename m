Return-Path: <netdev+bounces-64519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAD58358FF
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 01:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52A65B20D75
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 00:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80979364;
	Mon, 22 Jan 2024 00:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="DKWKO+Lz"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4C7362
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 00:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705883397; cv=none; b=ERo2Sa2SBbPwIZOirOYI9jjM/MEVuF3aPr65XKdaRh2nBzvE8ZiGMfWfYJ2kjCIBbvPFEjrO3GmRy8aDu+7d5KYRUOkpQrJWt2zBz1oc8jfRu02c38s1i9YxlOpVDNqnO6Siqela2Y6tLwyby3oeknP0ZGSSS4sqXOq3fmC8t9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705883397; c=relaxed/simple;
	bh=kegakfHIP/hV1Dm4kfvD7rJ1SJDKTSXmskj+HuzN5rY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Qmvqh1mS6pYIBHzBdfcwSVM/aXLjVR/lyk4dXYz8jvrEqRAUVByZIEFdm9mQmHV/VUjZnq7IC+ZvjzYLfrPr4n2oxq/R8Mh45spO8zhOe//LJToGKtUg+aCxZmW2we9fQhBYx910nJsXk8auqA/DeukT1cMpDD8rCVc4um9ehHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=DKWKO+Lz; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id BC68D80075;
	Mon, 22 Jan 2024 00:29:52 +0000 (UTC)
Received: from [192.168.22.29] (unknown [50.225.254.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 2F14C13C2B0;
	Sun, 21 Jan 2024 16:29:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2F14C13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1705883391;
	bh=kegakfHIP/hV1Dm4kfvD7rJ1SJDKTSXmskj+HuzN5rY=;
	h=Date:To:Cc:From:Subject:From;
	b=DKWKO+LzuCxOdMUd6k3CnRw6M3M9SBRgSpNYQwGIFFN5W1pFU8nB8OdEI/euU4AhT
	 RGQZQr/23OCHMQNi0Dbk6xI5y7ou5A1rPHojcd6eWx4bSm0SNQZwdcfgQMqfFghAz6
	 XOvlZ8j2aT7KM9u3z/hBkBQ+5XdZvvGCvvaTqicw=
Message-ID: <6f0c873e-8062-4148-74c2-50f47c75565f@candelatech.com>
Date: Sun, 21 Jan 2024 16:29:50 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-MW
To: netdev <netdev@vger.kernel.org>
Cc: David Ahern <dsahern@gmail.com>
From: Ben Greear <greearb@candelatech.com>
Subject: Having trouble with VRF and ping link local ipv6 address.
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1705883393-yEz6clWvFNKq
X-MDID-O:
 us5;at1;1705883393;yEz6clWvFNKq;<greearb@candelatech.com>;b41e75bb221a79e1e0de4c629809c98a

Hello,

I am trying to test pinging link-local IPv6 addresses across a VETH pair, with each VETH
in a VRF, but having no good luck.

Anyone see what I might be doing wrong?


[root@ ]# ip -6 addr show dev rddVR5
161: rddVR5@rddVR4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master _vrf15 state UP group default qlen 1000
     inet6 fe80::8088:c8ff:fe31:16ea/64 scope link
        valid_lft forever preferred_lft forever

[root@ ]# ip -6 addr show dev rddVR4
160: rddVR4@rddVR5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master _vrf14 state UP group default qlen 1000
     inet6 fe80::d064:9eff:fead:2156/64 scope link
        valid_lft forever preferred_lft forever

[root@ ]# ip -6 route show table 15
anycast fe80:: dev rddVR5 proto kernel metric 1024 pref medium
local fe80::8088:c8ff:fe31:16ea dev rddVR5 proto kernel metric 0 pref medium
fe80::/64 dev rddVR5 proto kernel metric 256 pref medium
fe80::/64 dev rddVR5 metric 1024 pref medium
ff00::/8 dev rddVR5 metric 256 pref medium

[root@ ]# ip -6 route show table 14
local fe80::d064:9eff:fead:2156 dev rddVR4 proto kernel metric 0 pref medium
fe80::/64 dev rddVR4 proto kernel metric 256 pref medium
multicast ff00::/8 dev rddVR4 proto kernel metric 256 pref medium

[root@ ]# ip vrf exec _vrf15 ping -6 fe80::d064:9eff:fead:2156
PING fe80::d064:9eff:fead:2156(fe80::d064:9eff:fead:2156) 56 data bytes
ping: sendmsg: Network is unreachable
ping: sendmsg: Network is unreachable
^C


Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

