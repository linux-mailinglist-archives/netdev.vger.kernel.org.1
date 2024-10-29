Return-Path: <netdev+bounces-140072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C879B529B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2815FB218D8
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 19:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74183206979;
	Tue, 29 Oct 2024 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Boadslt5"
X-Original-To: netdev@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425402040BB
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 19:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730229548; cv=none; b=kULM75xXVsWPWh47F6oB1TmXhQZmZzllsB9SeJi84lxmyZGxdZuEjrS2mit8nmR9oU7yVSNbOBTMbAvRQzaxxJLqUJPNl0bLHQEzqK+QavEWr3QeQpyyIC4ZLms0We1xSeJH51ZCxDSW9mjYbr1IMlMns0I5Zg9qvF+L1/V1kt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730229548; c=relaxed/simple;
	bh=JC4hvfnHHC8twg219qs6N3Cxwqnq5m2kLx6kybD60nE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e4nb71+q8jOYu1PS6bHT07+JF5Zcgmy9yY80plSR2l+392xLD/4MBSIn3EHKSIc6DcE2wJJH3flHxY+7kHTFeu4iPPln52YsNU2RwI3vpmUT7mtbLJH5v1p0n3qf8p+bzfSAFVHNMAqmRSyqddjZpOn8In1dpEiYwa0oUzKPnsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=Boadslt5; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id 5lXttzQBtqvuo5rk4tDUmM; Tue, 29 Oct 2024 19:19:00 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 5rk3tZ6FCSAO35rk4tQoHG; Tue, 29 Oct 2024 19:19:00 +0000
X-Authority-Analysis: v=2.4 cv=L7obQfT8 c=1 sm=1 tr=0 ts=67213524
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=OKg9RQrQ6+Y1xAlsUndU0w==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7T7KSl7uo7wA:10
 a=gH3oePmIiMEZKbxs2gsA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PnMHK4mc58FzU4q3ZQlBHloCOzwLLmE7NXP6JKHsCTo=; b=Boadslt5WQN5MxVp8Z5qioAagL
	Eqg/oK73rQ4QDOa6hJ26QYo+/J2Av24bkZqzF0SqfQbQp49ykutjB7/vzZZC7JHI8dkUVQWu0Eseh
	wiwd/yrhskEdU2TPEqgUey9x+xa7tfYrv0x1mSXDRuliafZe66xoUZ2vJjP//Tke57lNKMdI8ksrQ
	Ja7OSBQtjkEyXyJ7gDU4kbn603BdeSwFBVwpkgCXy4w58v9Zs526jTYkFT3O9f1HJeKRbgk1XJPFm
	MDnpr+K9S3aYPjO38zOa8X8XjE17jbRxzPuoNtQur1kgu5Q9AyyH9vzdwh6I3eEuEn2oCzM2AZdQE
	wYSnMYQw==;
Received: from [201.172.173.7] (port=43040 helo=[192.168.15.6])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1t5rk2-001DUt-0i;
	Tue, 29 Oct 2024 14:18:58 -0500
Message-ID: <5aa93a65-e325-4c77-aaa8-5ef04f3b9697@embeddedor.com>
Date: Tue, 29 Oct 2024 13:18:56 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2][next] net: ethtool: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Michael Chan <michael.chan@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>,
 Manish Chopra <manishc@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <cover.1729536776.git.gustavoars@kernel.org>
 <f4f8ca5cd7f039bcab816194342c7b6101e891fe.1729536776.git.gustavoars@kernel.org>
 <20241029065824.670f14fc@kernel.org>
 <f6c90a57-0cd6-4e26-9250-8a63d043e252@embeddedor.com>
 <20241029110845.0f9bb1cc@kernel.org>
 <7d227ced-0202-4f6e-9bc5-c2411d8224be@embeddedor.com>
 <20241029113955.145d2a2f@kernel.org>
 <26d37815-c652-418c-99b0-9d3e6ab78893@embeddedor.com>
 <20241029115426.3b0fcaff@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20241029115426.3b0fcaff@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.7
X-Source-L: No
X-Exim-ID: 1t5rk2-001DUt-0i
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.6]) [201.172.173.7]:43040
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCFFvPp+tw9Mrgto0QPqlupRlU7shQ5n7XNOYDaCiEdp5PO7+3nOVpHHP7dgOxzrmU6LmkK0dg3MvZhOB+bml7qeKChUZb2uR47SXwSPyQMlrWlcBQmr
 bb+5NU/QOq4UF5ewPLXnWDfAjuPu5xKLKDtApoOvfVgW3AgCjC0+gW1iH1SC6TXDmlAEKiCLXBc3sf+iVm97TIS+zAjRirJr9yI=



On 29/10/24 12:54, Jakub Kicinski wrote:
> On Tue, 29 Oct 2024 12:48:32 -0600 Gustavo A. R. Silva wrote:
>>>> Is this going to be a priority for any other netdev patches in the future?
>>>
>>> It's been the preferred formatting for a decade or more.
>>> Which is why the net/ethtool/ code you're touching follows
>>> this convention. We're less strict about driver code.
>>
>> I mean, the thing about moving the initialization out of line to accommodate
>> for the convention.
>>
>> What I'm understanding is that now you're asking me to change the following
>>
>>        const struct linkmodes_reply_data *data = LINKMODES_REPDATA(reply_base);
>>        const struct ethtool_link_ksettings *ksettings = &data->ksettings;
>> -    const struct ethtool_link_settings *lsettings = &ksettings->base;
>> +    const struct ethtool_link_settings_hdr *lsettings = &ksettings->base;
>>
>> to this:
>>
>>        const struct linkmodes_reply_data *data = LINKMODES_REPDATA(reply_base);
>>        const struct ethtool_link_settings_hdr *lsettings;
>>        const struct ethtool_link_ksettings *ksettings;
>>
>>        ksettings = &data->ksettings;
> 
> You don't have to move this one out of line but either way is fine.
> 
>>        lsettings = &ksettings->base;
>>
>> I just want to have clear if this is going to be a priority and in which scenarios
>> should I/others modify the code to accommodate for the convention?
> 
> I don't understand what you mean by priority. If you see code under
> net/ or drivers/net which follows the reverse xmas tree variable
> sorting you should not be breaking this convention. And yes, if
> there are dependencies between variables you should move the init
> out of line.

By priority I mean if preserving the reverse xmas tree is a most
after any changes that mess in some way with it. As in the case below,
where things were already messed up:

+       const struct ethtool_link_settings_hdr *base = &lk_ksettings->base;
         struct bnxt *bp = netdev_priv(dev);
         struct bnxt_link_info *link_info = &bp->link_info;
-       const struct ethtool_link_settings *base = &lk_ksettings->base;
         bool set_pause = false;
         u32 speed, lanes = 0;
         int rc = 0;

Should I leave the rest as-is, or should I now have to rearrange the whole
thing to accommodate for the convention?

How I see this, we can take a couple of directions:

a) when things are already messed up, just implement your changes and leave
the rest as-is.

b) when your changes mess things up, clean it up and accommodate for the
convention.

extra option:

c) this is probably going to be a case by case thing and we may ask you
    to do more changes as we see fit.

To be clear, I have no issue with c) (because it's basically how things
usually work), as long as maintainers don't expect v1 of any patch to
be in pristine form. In any other case, I would really like to be crystal
clear about what's expected and what's not.

Thanks!
--
Gustavo




