Return-Path: <netdev+bounces-165696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B627CA331A0
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 22:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4416718858E0
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 21:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAC9202F71;
	Wed, 12 Feb 2025 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="UrZ1lKkE"
X-Original-To: netdev@vger.kernel.org
Received: from mx18lb.world4you.com (mx18lb.world4you.com [81.19.149.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1370A202C5B
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 21:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739396169; cv=none; b=fiLJQMhHQQcBgLI+9+kbNHUTkSYU8Zn9xT/CdfxNRPxm8bh2mAfdFGHgHOakN/XBpBYeaHwfRZ38XowKw+xqZwiEUShnOmI+YGdizwVrXKb2eaRkU0Tzk38mX36dud01fB2EPNtQuJUMyklOzQiKDiB9fmaBKdS4RGiXmtEgllU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739396169; c=relaxed/simple;
	bh=SS+RELLWKUyyLYBqlk4Yo6zcv+ecvcrZ33kbeX+WjBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PdNZspN7FgJMTAEJ1GckM3V4d3f0u25GdllNNxCQ6at00pCDJDkgJAJF46e+H9TmT2HpJVat5+CQ6f4Bwao83h43LMAu4RCx5mgLFOsZaFtjtwF1Y2VixNs1N1rJKZ38QGwHxMXmiJcUkuCeNKFWBoPbRYlz+c5pqXDz1LQlmFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=UrZ1lKkE; arc=none smtp.client-ip=81.19.149.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ohGuQAji6FkcHTDoDCDWHnR4UV/FVjMLRPPJcX3KM9Y=; b=UrZ1lKkE9r04N6Eh+X/fR3pzJj
	sfNdDB7n6aZCKAL3KB6eWsqZiWlg68YlhkZ3k9WlmSxz1qga8j9HyPt1FQDQSU0clKqaOgQkBQ4TR
	N7ifeHwBgY5Pt38IYqmznAPhAbTWROChIarS2eNA+/P2acWF/fgIpxi5A2i2QCXiO2+Q=;
Received: from [88.117.55.1] (helo=[10.0.0.160])
	by mx18lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tiKOo-000000001IK-03QT;
	Wed, 12 Feb 2025 22:36:02 +0100
Message-ID: <09a4cd33-3170-4f87-a84b-5e1734d97206@engleder-embedded.com>
Date: Wed, 12 Feb 2025 22:36:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 6/7] net: selftests: Export
 net_test_phy_loopback_*
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>
References: <20250209190827.29128-1-gerhard@engleder-embedded.com>
 <20250209190827.29128-7-gerhard@engleder-embedded.com>
 <d6cb7957-1a54-4386-8e10-17cea49851df@lunn.ch>
 <b18971f2-0edf-4fa7-be1b-eec8392665f0@engleder-embedded.com>
 <c1229fd9-2f65-40dd-bbb5-9f0f3e3b2c2c@lunn.ch>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <c1229fd9-2f65-40dd-bbb5-9f0f3e3b2c2c@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 12.02.25 21:46, Andrew Lunn wrote:
>> Reusing the complete test set as extension is not feasible as the first
>> test requires an existing link and for loopback test no link is
>> necessary. But yes, I can do better and rework it to reusable tests.
>> I'm not sure if I will use ethtool_test_flags as IMO ideally all tests
>> run always to ensure easy use.
> 
> We try to ensure backwards/forwards compatibly between ethtool and the
> kernel.
> 
> The point about ethtool_test_flags is that for older versions of
> ethtool, you have no idea what the reserved field contains. Has it
> always been set to zero? If there is a flag indicating reserved
> contains a value, you then know it is safe to use it.

I'm not sure if I understand the last sentence. Do you mean it is safe
to use a flag that was previously marked as reserved if the clients did
set it to zero, but for ethtool_test_flags this is not the case?

> At some point, the API needs moving to netlink sockets. It then
> becomes a lot easier to add extra parameters, as attributes.
> 
> There is also an interesting overlap here and:
> 
> https://netdevconf.info/0x19/sessions/talk/open-source-tooling-for-phy-management-and-testing.html
> 
> What you are doing is not too dissimilar, although the PRBS is an
> 802.3 standard concept and typically part of the PCS. There needs to
> be some sort of API for configuring the PRBS, maybe as part of ethtool
> self tests? If so, the API is going to need extensions.

Sounds also similar to bit error testing of transceivers. I want to
stress a data link with all supported modes and this is similar.
For me it is sufficient if the driver tests all supported modes, without
any configuration from user space. But extending the API
to enable advanced testing during development and production is
reasonable.

Gerhard


