Return-Path: <netdev+bounces-165686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C88A3308D
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 21:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EF523A2AC9
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 20:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8147B201017;
	Wed, 12 Feb 2025 20:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="Zx93pNZQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx07lb.world4you.com (mx07lb.world4you.com [81.19.149.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD21201015
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 20:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391237; cv=none; b=oczjpHo7YcWeLzQlduHmHrn0xSL0b8V+1lPXsXJD6OX0hns/d4Yu/+KuK5d8RgjR3hDAXcygaktEJk5WeXlOF4c28ochMMIRy4HTFSt4l2eoXAnjgGV7NWWGtbjjpLehfy81hsNILgi5wFLlRxbo0lYAc/pggmVO4H7s+eAUMmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391237; c=relaxed/simple;
	bh=p0dyme5MgxjPo1iE+IDplCUV0X5hCrjKGXqqGyMmRmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WR7lNFO/62sU7PfsI51ttsp5GhZdE7js0nMeWZ0+/WZY5gibmw9y9cbsCiKkStn3HOwu6LcdsjX2jBVj6XpEVAHhgB47H+0qB5enh+zh9eAD77QkwOdn5idjxR5B/99Xq4sZHIvhvTLd38wCjCoySYrAj0hZopE5o1Hv3h7MVGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=Zx93pNZQ; arc=none smtp.client-ip=81.19.149.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pS9rYmfqnfEJ1IEQstJJhJId9THBjfKcj+wW1KHg92g=; b=Zx93pNZQRc5LOglQ9X08pvsFin
	OIhbsU41ISkzC5guiVl9UE8n80NPAZU9cmuHItV3JnGnyNs8LWNkuNt9bRXtiJGcXyOj1W++waCbO
	1Oi2eQfdxzxb6XN5tCkl7j4Iq+F9kjp4NyQGaPyyh8sEVQVsBQ4KXk7sPclpgue3DK1M=;
Received: from [88.117.55.1] (helo=[10.0.0.160])
	by mx07lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tiJ7H-000000004IK-2XtB;
	Wed, 12 Feb 2025 21:13:52 +0100
Message-ID: <b18971f2-0edf-4fa7-be1b-eec8392665f0@engleder-embedded.com>
Date: Wed, 12 Feb 2025 21:13:50 +0100
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
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <d6cb7957-1a54-4386-8e10-17cea49851df@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 12.02.25 03:23, Andrew Lunn wrote:
> On Sun, Feb 09, 2025 at 08:08:26PM +0100, Gerhard Engleder wrote:
>> net_selftests() provides a generic set of selftests for netdevs with
>> PHY. Those selftests rely on an existing link to inherit the speed for
>> the loopback mode.
>>
>> net_selftests() is not designed to extend existing selftests of drivers,
>> but with net_test_phy_loopback_* it contains useful test infrastructure.
> 
> It might not of originally been designed for that, but i think it can
> be used as an extension. I've done the same for statistics, which uses
> the same API.
> 
> For get_sset_count() you call net_selftest_get_count() and then add on
> the number of driver specific tests. For ethtool_get_strings() first
> call net_selftest_get_strings() and then append the driver tests
> afterwards. For self_test, first call net_selftest() and then do the
> driver specific tests.
> 
> I also think you can extend these tests to cover different speeds.
> There are plenty of ethtool_test_flags bit free, so you can use one of
> them to indicate the reserved value in ethtool_test contains a speed.
> Everybody then gains from your work.

Reusing the complete test set as extension is not feasible as the first
test requires an existing link and for loopback test no link is
necessary. But yes, I can do better and rework it to reusable tests.
I'm not sure if I will use ethtool_test_flags as IMO ideally all tests
run always to ensure easy use.

Thank you for the review!

Gerhard

