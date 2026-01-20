Return-Path: <netdev+bounces-251367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E59D3C13C
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 08:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1744501E4A
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 07:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE557392817;
	Tue, 20 Jan 2026 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="AWSFDfUV"
X-Original-To: netdev@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9321C334C02
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 07:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895547; cv=none; b=rKvX5Kvltm/wfiTgzmLNWW1/VqnTzeICHJgwd7rClssb7SIWuJ5Oo4oPsStkrAZcuYnXc34FrSi3UXzbCa//Q5o3c2QXpPwmxz7qQbSp/VJFcoBkcQd0Te/6W1bRGoUrvpGarSnZU/+w2wXy3TfUw+UFbfxBT6leNJAw2Y23z78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895547; c=relaxed/simple;
	bh=LKDVa1ggavkolWuR21y5AM/nqHwm+X69exVaYuFo2OA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MBJ6oC5+OfCWXSyLQV/KQpFzGOxdhng3zAMoITd9G1+Fp6MmsOTnC/M0MYcF+6fD43cKDqIo0m4WdfGkf+DVjkQadSn06W2lA4Mp4IVnDYwwgRQWtQwm5fk0N3dl9U6M3psqFVbCSB41ovc4AsGCbGH+pQBUO3xHEdYEI4eWWo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=AWSFDfUV; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id hsbjvk3ICCxrGi6XBvOljA; Tue, 20 Jan 2026 07:52:17 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id i6XAvsjqCh8QWi6XBvLdSX; Tue, 20 Jan 2026 07:52:17 +0000
X-Authority-Analysis: v=2.4 cv=Mcdsu4/f c=1 sm=1 tr=0 ts=696f3431
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=aEbNOhhS7pL/zVeD3/sqyA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=7T7KSl7uo7wA:10
 a=pbEPpAIZXhgMZgdEvJEA:9 a=QEXdDO2ut3YA:10 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fMKq1eT9qc6Ac5ztif8rUdeTqxjRs4ACIXVD72/VCkY=; b=AWSFDfUVxmJoGpoBhdun3JPgpr
	WlDi85OotIiENjMCnAV/KdW0Xk8dZ3K20HgeLK4ajj/JT4fohNqlhIVczHcKXbo5Iimj7m4mhOYu6
	Yl+ntSqUiXSPi7773loLRnHvuycTAkl9J0DWmlA2A4aqBlt9cyRDc1GBCL3dLK4NLe7491UOBHN2E
	vrwfv/GtPr1TJM8bJ06urbC/35fk2FPjaslrONK9kI1jxAuTT2zjl2ueJDexFQyBBkoi+6MSzP1/r
	n6fGTIx5/CM1yCDVKGv9WrdD8sWk7t96OBfgdJkIk+rBZH0u84TvYD1kad87f4LasMb7CNNeLSSVc
	nRfGx81A==;
Received: from m014013038128.v4.enabler.ne.jp ([14.13.38.128]:28839 helo=[10.79.109.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vi6X9-00000003JyH-1rYI;
	Tue, 20 Jan 2026 01:52:16 -0600
Message-ID: <1228d107-4a60-4c33-a763-1a199c0b0961@embeddedor.com>
Date: Tue, 20 Jan 2026 16:51:57 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net] Revert "net: wwan: mhi_wwan_mbim: Avoid
 -Wflex-array-member-not-at-end warning"
To: Slark Xiao <slark_xiao@163.com>, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, gustavoars@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260120072018.29375-1-slark_xiao@163.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260120072018.29375-1-slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 14.13.38.128
X-Source-L: No
X-Exim-ID: 1vi6X9-00000003JyH-1rYI
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: m014013038128.v4.enabler.ne.jp ([10.79.109.44]) [14.13.38.128]:28839
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMIWi8A5vPmGTGUwluAFRxUmZ4jhR3qLTPjJC7pz4jjhkYYqSFgxo88aLeVE8zBQOQIRqRlLOY0yr3JgRxpM64z5rGR+Kbx3ct6hMgExno04ugYxGSOK
 L8fAqqZNI6frSw/LoxU9j8fBWWMfPsreLwGerabnoY9jqi8O/Iv0X9nwebvFM6WAvfWfjcUoJFzJRTPsZg3/zz68XYRh9i76oxA=

Hi Slark,

On 1/20/26 16:20, Slark Xiao wrote:
> This reverts commit eeecf5d3a3a484cedfa3f2f87e6d51a7390ed960.
> 
> This change lead to MHI WWAN device can't connect to internet.
> I found a netwrok issue with kernel 6.19-rc4, but network works
> well with kernel 6.18-rc1. After checking, this commit is the
> root cause.

Thanks for the report.

Could you please apply the following patch on top of this revert,
and let us know if the problem still manifests? Thank you!

diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index 1d7e3ad900c1..a271a72fed63 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -78,9 +78,12 @@ struct mhi_mbim_context {

  struct mbim_tx_hdr {
         struct usb_cdc_ncm_nth16 nth16;
-       struct usb_cdc_ncm_ndp16 ndp16;
-       struct usb_cdc_ncm_dpe16 dpe16[2];
+       __TRAILING_OVERLAP(struct usb_cdc_ncm_ndp16, ndp16, dpe16, __packed,
+               struct usb_cdc_ncm_dpe16 dpe16[2];
+       );
  } __packed;
+static_assert(offsetof(struct mbim_tx_hdr, ndp16.dpe16) ==
+             offsetof(struct mbim_tx_hdr, dpe16));

  static struct mhi_mbim_link *mhi_mbim_get_link_rcu(struct mhi_mbim_context *mbim,
                                                    unsigned int session)

