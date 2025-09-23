Return-Path: <netdev+bounces-225723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BD6B97880
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 22:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AEFF162F2A
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 20:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C32330AAD0;
	Tue, 23 Sep 2025 20:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="0FwvzxPh"
X-Original-To: netdev@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175D81BD9D3
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 20:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758660812; cv=none; b=H6d3+4xuR/QFEHcqAVU8MsAfokfTj4sEvpBO9vpjAQYZ9vP6xZAhGpgE/EzbRpS9+toHy23RCbKeztnrIJDumnDwsBlixtcGx2bpozeaqPcbDbVTRqIOcIbJ8fuYDbbpw7F45GCiv4RTZsTcOPznrVAb+ZimYZnicgcA8l9P29c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758660812; c=relaxed/simple;
	bh=A9g20I8lseVKXlAh/tg+QgMk7GC67zftnbhm/6Ovfnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPuYbNnDuStfAwHmJQ8sG+esh4LYzkFbGl3gKPludhIhzpj4OuYAk9l1h0LYp33F2Vy2CnyK23dkp7bXjQ/QfmR50UrnACcIhUiIXnGpdRJna94uMi8bZD1QHdLYfzKKol6Fkq/NBsTHs9kfjLxWAwdeO5+JQU1fyClRFlkU6u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=0FwvzxPh; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5006b.ext.cloudfilter.net ([10.0.29.217])
	by cmsmtp with ESMTPS
	id 16KFv91gnSkcf1A0vvDVHf; Tue, 23 Sep 2025 20:53:29 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 1A0svD4Vj0HUD1A0tvtgoh; Tue, 23 Sep 2025 20:53:27 +0000
X-Authority-Analysis: v=2.4 cv=TIhFS0la c=1 sm=1 tr=0 ts=68d308c7
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=N332or4wHRcdzxpigiEmqg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=gaVSdRgQbUJKjHIfkZ4A:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xR+Ojw/IUQBpUZG1R+fgJRf6pEBM1UY4TV59RRigg/U=; b=0FwvzxPhR3boWRA2R2jjvhqYf6
	Q+1uW31zrwDf2agKemJJdl1COGeQRKC0xFJWGjEkmdijHZDk9uT5cn03tRrO5IQ2SJWPFpmVloKDK
	f0inm9STgU7QCFbrmeVmJrlAO7pp6hBBOWSpt15OZR5oC9gTxBXCzwS8u2FLsTd1aqx9uAr8DAS6F
	rf0NBai9QZIr9gZThB+KniC3pLlxWJlaBaqi01oetGI2Pne+kxKdPZby7kqLUkdsaNVyOOj8v3iGc
	zj6iiuajCRgkiqKxsqxGyKVSxLGqY1E0zE0lwS4qMaguxptZjfx6NRx/KlZwolb4lxqzYF7WdHrs+
	xq2IPNsQ==;
Received: from [83.214.155.155] (port=35596 helo=[192.168.1.104])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1v1A0r-00000003Mp0-2G1U;
	Tue, 23 Sep 2025 15:53:26 -0500
Message-ID: <a4b598a1-3ad6-4e42-9f48-21db966f0a34@embeddedor.com>
Date: Tue, 23 Sep 2025 22:53:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] tls: Avoid -Wflex-array-member-not-at-end warning
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aNFfmBLEoDSBSLJe@kspp> <aNFpZ4zg5WIG6Rl6@krikkit>
 <c9cd2ebb-ecdb-4ba9-8d54-f01e3cd54929@embeddedor.com>
 <aNMCznixxL2veGxK@krikkit>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <aNMCznixxL2veGxK@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 83.214.155.155
X-Source-L: No
X-Exim-ID: 1v1A0r-00000003Mp0-2G1U
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.104]) [83.214.155.155]:35596
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJpdU9mKBGmwum+GefuqxcB/poj5yni8iepy0tpRlW6m3ENb5tW2A/USTWSSWhsEnZlG1ZC6ZweSBvPSINc1JuTelENKUERkimE0oBeFiOAb062dHlhf
 6G1QwCvjmpArlhhGRnS/0HaufmNNjbO9dlOwBerKBTgu5kztwHu8zSsNE9P5dA39pNCgmIS4TZ6M0hwkq7B3Um0vNp61CDJ6aOY=



>>
>> If this (flex array) is not going to be needed in the future, I'm
>> happy to remove it. :)
> 
> I don't see what we'd use it for, aead_request.__ctx contains private
> data from the crypto code (all accesses seem to be through
> aead_request_ctx defined in include/crypto/internal/aead.h, see also
> the kdoc: "Start of private context data").
> And we haven't seen the author of a42055e8d2c3 in a while, so we can't
> ask about the intention behind this field.
> 
> So IMO, tls_rec.aead_req_ctx can simply go away. Would you send the
> patch?
> 

Done: https://lore.kernel.org/linux-hardening/aNMG1lyXw4XEAVaE@kspp/

Thank you for the feedback. :)

-Gustavo

