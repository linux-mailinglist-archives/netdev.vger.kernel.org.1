Return-Path: <netdev+bounces-162743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81608A27CC3
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 21:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1EB18867FD
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 20:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF3321A435;
	Tue,  4 Feb 2025 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="qXxX0OHR"
X-Original-To: netdev@vger.kernel.org
Received: from mx05lb.world4you.com (mx05lb.world4you.com [81.19.149.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E715F21A425
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738700823; cv=none; b=K6iT4hcPzaoLdyB9+2CDCO0ohBjdpE7H71IkWVAbkxZdPzqhQfjmrnINu5hbzhj5mgmtZ8gfbwevoDg8P+UqQFlv8c5OG7RXQOlVLw0dSQP2MzMovY6/BWjoUCkpvlg2mbNcSfpnj077X6V1wvewVcEsHQ0/0bJabEbXd0XlQY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738700823; c=relaxed/simple;
	bh=7D/n3uwNh6NdbLVsMaz5GQ+eqY0CGENTcBm9zoOj7TI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bXyEyIQ0kH7UEJuSTrdsmjqUph+Q5IUB6NE6VjLPSmEHwh08yZlvtL07MW9Nxesrt1ialSZBnuwIyokx1/sL1xpTdOjSdkZswreGuXwiPKh9WkRBq/APb6XCh/NoAUf/dS4ROcNs7dUOj/GTY7Atlr1jLPZxbegGyQZZuXeu5pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=qXxX0OHR; arc=none smtp.client-ip=81.19.149.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wfcO5ER+r2plevl8a9nLgRnJivX33DVlif9Ls4pxgSM=; b=qXxX0OHR4MU0roZ/1TmFXcR7x5
	V6Z92fYEsJYkD63ih6nL4JWU4ny/uEOsLss7NQyG7D9E4kIy59g6K7+cyFRHCuaNHkCul/4Ab3THj
	y46gd+naGyiSww1ih2TSfIWYts7oeXLtvjHkUKTPiOZU7EmAfhD6gJkd/0JyDre4PK0k=;
Received: from [88.117.60.28] (helo=[10.0.0.160])
	by mx05lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tfPVZ-000000007UF-3At9;
	Tue, 04 Feb 2025 21:26:57 +0100
Message-ID: <282f56e2-8acd-4298-bd48-bf036f74362f@engleder-embedded.com>
Date: Tue, 4 Feb 2025 21:26:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/7] net: phy: micrel: Add loopback support
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20250203191057.46351-1-gerhard@engleder-embedded.com>
 <20250203191057.46351-4-gerhard@engleder-embedded.com>
 <Z6Ee6RDkaAeKw749@shell.armlinux.org.uk>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <Z6Ee6RDkaAeKw749@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 03.02.25 20:54, Russell King (Oracle) wrote:
> On Mon, Feb 03, 2025 at 08:10:53PM +0100, Gerhard Engleder wrote:
>> +static int ksz9031_set_loopback(struct phy_device *phydev, bool enable,
>> +				int speed)
>> +{
>> +	u16 ctl = BMCR_LOOPBACK;
>> +	int ret, val;
>> +
>> +	if (!enable)
>> +		return genphy_loopback(phydev, enable, 0);
>> +
>> +	if (speed == SPEED_10 || speed == SPEED_100 || speed == SPEED_1000)
>> +		phydev->speed = speed;
>> +	else if (speed)
>> +		return -EINVAL;
>> +	phydev->duplex = DUPLEX_FULL;
>> +
>> +	ctl |= mii_bmcr_encode_fixed(phydev->speed, phydev->duplex);
>> +
>> +	phy_modify(phydev, MII_BMCR, ~0, ctl);
> 
> Why do you use phy_modify() here rather than phy_write() which is
> effectively what this is.

I copied that from genphy_loopback(). You are right, phy_modify() makes
no sense with mask 0xffff. I will change it.

Thanks!

Gerhard

