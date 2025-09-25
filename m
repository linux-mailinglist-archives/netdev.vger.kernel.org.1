Return-Path: <netdev+bounces-226372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A18B9FA6D
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 15:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 130644C1A9A
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 13:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FB4271469;
	Thu, 25 Sep 2025 13:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="vw0i9OJl"
X-Original-To: netdev@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBA818BC3D
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808026; cv=none; b=ueRu8tFn+9nqMVjva4qeai4SVO/Dhujd0lJzucdhLqEYKbUV45a1xoVtbKAE/gtGoe8kG12nA/xTVlhW0kYolBwUX7m2ZlowA29ioGwroGCbYcgzw1iWqjO2evtZ9fRvFn8omhIrWoNJBKl/4AEjwwDcDL/X9Zx6leVr6o3/Liw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808026; c=relaxed/simple;
	bh=QaeuqU5IKDB5njifOO3nkb72eo9WDM+qBuUVP7jeOes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GHtEp/ofAWClbqtdDM7BCwxuzK0GoHWKyrru1n3da1D5wFHLgvIjvR54cMfowrlzQilwHizCE1N67TqzkOyofFV+jw08aAmlKauTndPy/PS14zRWFeXeW0HTiwkCjwYHLXKiX1S5N5z027mO1ioiIeXvsgmLqNdgrl7cTsmXs1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=vw0i9OJl; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id 1hb8v6z2lZx2i1mJGvsDfq; Thu, 25 Sep 2025 13:46:58 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 1mJFvPXVa25G71mJGv9wa4; Thu, 25 Sep 2025 13:46:58 +0000
X-Authority-Analysis: v=2.4 cv=LuqSymdc c=1 sm=1 tr=0 ts=68d547d2
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=TDP2S4RWD7HzL5QBIXWMeQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=Ab0Lm24STF9_9LFwZLUA:9 a=QEXdDO2ut3YA:10 a=DY-CUodvXd4A:10
 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wQH2YqZrAjDbl97Li4x21PKe2sTxB46h35TNYvK8pds=; b=vw0i9OJl5mtBvBE4C/EzxX87dD
	ydfS5gFzKTek3rt2L9X1MMsJD9dFR3TQ7OYTLyCzTKNQ9cUtChg6y9eUxCWnzcDrqnXmiETB9mg7g
	FzwGLriMpthnaMHSy/cz9jq3hS0q8C0yG/lzn8emnqnJYeXQNyyEZNUvSUKImI+QLCRAp7rVL21Fq
	yL/ew+OGyWyW5LH940mUk4XMAiFwFlteMUTg+TrgvLUOBxrpUkT4kNidd13BLnEOlAMdChT2U0uBa
	VNKuL4M/VPhh7kQTewN423cfHG31gBHWPk9F8DNLISY1Fi+wVfX1/ljxfQ8Cl5Ii1kt6XSyO1K0Zx
	CSgSt/qw==;
Received: from [83.214.222.209] (port=33238 helo=[192.168.1.104])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1v1mJC-00000004B6y-2Lzb;
	Thu, 25 Sep 2025 08:46:55 -0500
Message-ID: <92c454f7-9138-4de5-8857-92970a9cfcf0@embeddedor.com>
Date: Thu, 25 Sep 2025 15:46:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] Bluetooth: Avoid a couple dozen
 -Wflex-array-member-not-at-end warnings
To: luiz.dentz@gmail.com, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aMAZ7wIeT1sDZ4_V@kspp>
 <175880760625.2984149.17268227498282852314.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <175880760625.2984149.17268227498282852314.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 83.214.222.209
X-Source-L: No
X-Exim-ID: 1v1mJC-00000004B6y-2Lzb
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.104]) [83.214.222.209]:33238
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 19
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfH70+1mwziCBcCKrL5cUoHWaTd3iESdIiJE31Vu8FYUpyaM8WwTdFuIUqMAWCBymGrzkPLel1BxGTVlDlfnfYVGJZapy5uJJlltojS4U+/7egzb4Lf7j
 714MC3eIiVJeJobIbjLFBjVWbJ54w2ohdNAnVJ8ObTQbPi7hS7hxb1OPXo5R12IvUyFASUDZ137kNezVr4LOx2LiQsYIVer4++E=



On 9/25/25 15:40, patchwork-bot+bluetooth@kernel.org wrote:
> Hello:
> 
> This patch was applied to bluetooth/bluetooth-next.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

Thank you, Luiz!

-Gustavo

