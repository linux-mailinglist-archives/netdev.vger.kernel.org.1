Return-Path: <netdev+bounces-168669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96157A40201
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 22:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7862B19C7BF9
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 21:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08398253F19;
	Fri, 21 Feb 2025 21:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="bIXj/gp0"
X-Original-To: netdev@vger.kernel.org
Received: from mx12lb.world4you.com (mx12lb.world4you.com [81.19.149.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6BE253F0E
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 21:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740173079; cv=none; b=FwzYIf3vHjB6d5fzPPSV1pMUYRiWmlXDnJj7Ifys8GE0R0+hkWTl3lEE2TTejDGecP+ja4h9u2NzppYItueq4aJtuBKMKOUgbbIWcrdMfTQo2sjhAoSl3mJN/ltYS/fM/BIWyMV47p4dZJz3iZCMeztzR7zO3V/oKr9MJH0sRIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740173079; c=relaxed/simple;
	bh=NqsMXbYlaesKRuzTxDpMQUhbx1hL2nMbYU36SZARM64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHyZ3encyWNwbjYFWgA6xiMBuvqVUtn5eMc2ctkPAgjpUYQgOdFBPnqseK5+zToc+SrCHTDl0hF+b4+fR6ZU96QWgOVn8UtgtkDZIpCvLDIx0egXePmlGp57e9DglMxISSKO927aQdhrlxxOFrSkVbR8FDLR/7nXFDscoI/Oz28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=bIXj/gp0; arc=none smtp.client-ip=81.19.149.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YK0Emar82nUxaVPtA2wf05uRvf2pJ1iTf4fDEh4cn/8=; b=bIXj/gp0TcHVVd+n7Y/tqYlOYD
	bSDfKiKwL4xOggnSeAPDzeTaI0QH8OEfhpBlYusc1spk1VWjGJUMobrPspCYMQJTY3+SSrtZWeL3M
	pQncHAEMBtFkZig1EtsSq8wSxcLnmvYTyE8rsSjLHMd5bsMJIur/aL0i2caxGfKjlPJ0=;
Received: from [88.117.55.1] (helo=[10.0.0.160])
	by mx12lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tlZtZ-000000001MY-1cTG;
	Fri, 21 Feb 2025 21:45:13 +0100
Message-ID: <ed721a10-d804-4c9b-86b1-a1fb77b77c4f@engleder-embedded.com>
Date: Fri, 21 Feb 2025 21:45:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 6/8] net: selftests: Support selftest sets
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>
References: <20250219194213.10448-1-gerhard@engleder-embedded.com>
 <20250219194213.10448-7-gerhard@engleder-embedded.com>
 <20250220181042.0abe4ea0@kernel.org>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20250220181042.0abe4ea0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes



On 21.02.25 03:10, Jakub Kicinski wrote:
> On Wed, 19 Feb 2025 20:42:11 +0100 Gerhard Engleder wrote:
>> + * @NET_SELFTEST_CARRIER: Loopback tests based on carrier speed
>> + */
>> +enum net_selftest_set {
>> +	NET_TEST_LOOPBACK_CARRIER = 0,
> 
> names doesn't match

I will align the naming.

Gerhard

