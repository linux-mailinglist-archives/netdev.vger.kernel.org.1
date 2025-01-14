Return-Path: <netdev+bounces-158222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAC4A111D1
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 21:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458F3188A646
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 20:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1361FBCA6;
	Tue, 14 Jan 2025 20:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="DrnANGe3"
X-Original-To: netdev@vger.kernel.org
Received: from mx17lb.world4you.com (mx17lb.world4you.com [81.19.149.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868BD146590
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 20:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736886085; cv=none; b=d2WTggB0eES+WzIY0gcR6bN0xf3hMCfL/DSYoCSk6b1On1eilCL4XZrPxhhWUzedy5l5NILjBBNn9iu7rpb++AQ73fJQNJN5boVqbmMmmZDb55P691ABpRaV6lQVJ/INhQ1WiffEv8k1qJkB0n0A4QC4lniriCz1cInDbdQVm3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736886085; c=relaxed/simple;
	bh=tHYiFtQEohLaf17HBGBPnlPSezYpiPQmuEm/QLe8pr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHvXO0NC+B24Yl/NNsDZtBbslgjE/hzy4sEmamOgL7HQtdpOEIhqMIWXTG31w70z0VJ3gj4Q2U92VZh8jqb28QDQz0ucBtJn9l/P2vDhRQN1mzHToxr8QVs/u72790YLaiC6p7w+Ki6LnuPDDgWMh3cj44h92JDFTRYFAI6afa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=DrnANGe3; arc=none smtp.client-ip=81.19.149.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/DGuVO0MX9Wsbg5xHq+7kJ0JxzPt+pN3CwOG/bq0W+0=; b=DrnANGe3OfOrv1hRdh54WWouUE
	FDOOxggAkIyHDE7MkR35mzR4brcC063jl1k062GDEiQsqBqevMBTxaOL/Zs6h2pTFQuYiFnv569tR
	e/lSbJnSL1/KlFTy1Z8zcZf3VAfIMk3rsR+eRJu/hY1YkAwc0M89cb51rz/wUgaU07PQ=;
Received: from [88.117.60.28] (helo=[10.0.0.160])
	by mx17lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tXnPb-000000003OW-3qW9;
	Tue, 14 Jan 2025 21:21:20 +0100
Message-ID: <4c35670a-e4db-4dd3-bf2c-73eb33ca2c1a@engleder-embedded.com>
Date: Tue, 14 Jan 2025 21:21:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/5] tsnep: Add PHY loopback selftests
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20250110144828.4943-1-gerhard@engleder-embedded.com>
 <20250110144828.4943-6-gerhard@engleder-embedded.com>
 <543fd272-4727-4f13-bec5-9a61bc460066@lunn.ch>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <543fd272-4727-4f13-bec5-9a61bc460066@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes



On 13.01.25 23:06, Andrew Lunn wrote:
>> +static bool set_speed(struct tsnep_adapter *adapter, int speed)
>> +{
>> +	struct ethtool_link_ksettings cmd;
>> +	int retval;
>> +
>> +	retval = tsnep_ethtool_ops.get_link_ksettings(adapter->netdev, &cmd);
>> +	if (retval)
>> +		return false;
> 
> Why go via tsnep_ethtool_ops. Since this is all internal to the
> driver, you know how this callback is implemented.

Yes, I know how this callback is implemented, but this way I don't
double this knowledge. With this implementation get_link_ksettings()
can be changed locally within tsnep_ethtool.c without potentially
forgetting to sync the selftests.

Gerhard

