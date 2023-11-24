Return-Path: <netdev+bounces-50893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E70697F77CE
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 16:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77085B211E0
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 15:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8692EAED;
	Fri, 24 Nov 2023 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="DEI9u1RI"
X-Original-To: netdev@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEE01727
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 07:29:04 -0800 (PST)
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
	by cmsmtp with ESMTPS
	id 6Jc8riILUjtZ36Y7Br6Xht; Fri, 24 Nov 2023 15:29:09 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 6Y74rMPx1BOcc6Y74rIx4C; Fri, 24 Nov 2023 15:29:02 +0000
X-Authority-Analysis: v=2.4 cv=J+25USrS c=1 sm=1 tr=0 ts=6560c13e
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=yGeM7+xMb5a5VK1DGQx1ew==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10
 a=YArfMqtJ7KKBon4Yl2AA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TaoInkAh2k51qqNVjJ8mEGKxHgoSLe6W4K886QPYJ9c=; b=DEI9u1RIERU3SpLf+ZKYclwtwE
	a1B0c2iDk+Z/PnhZd6ICkvDKvjlyXeDArogw/v50ewvDHwZ4me8RpTaA8r6irG3QTExxr5W3hpgeN
	jyDQy3iUpa7LhDf88HzzWQPn0joJpMcn38HgkplPElVqQTmDEJ7y+p94hYYMY+jlx4u2Cm5wuKtB5
	pttWre2tXuCjGKR9yWFYq1XLpSy8xu3Ke/Yvc6l9sMqeYe+qtz1Sr76EWBTeMG2Atj8BRXrSMs898
	M4by6TxN4WIjHd2cweARSaMPrc4Cku7ZG8018Tfv4Mf1uQlw8iGfwIK+A5ZSrzoiqnXmVdm8NuGMP
	g3bNJkcQ==;
Received: from 187.184.157.122.cable.dyn.cableonline.com.mx ([187.184.157.122]:29540 helo=[192.168.0.25])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1r6Y73-000sai-2D;
	Fri, 24 Nov 2023 09:29:01 -0600
Message-ID: <7086f60f-9f74-4118-a10c-d98b9c6cc8eb@embeddedor.com>
Date: Fri, 24 Nov 2023 09:28:48 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Boot crash on v6.7-rc2
To: Joey Gouly <joey.gouly@arm.com>, linux-hardening@vger.kernel.org,
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20231124102458.GB1503258@e124191.cambridge.arm.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231124102458.GB1503258@e124191.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.157.122
X-Source-L: No
X-Exim-ID: 1r6Y73-000sai-2D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.122.cable.dyn.cableonline.com.mx ([192.168.0.25]) [187.184.157.122]:29540
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfC9e6YpICZMBS7tmDkNXq/MQpr0NP/OoV13+HkOQtoAkLnU8RFWe15VShe2IjO1/CvQcjl7KQeVGv6PpPWRQzsUXvmFNHwFAXiiPqKP/fr+ecfnF4p+b
 Sb1h2hFBBQAW/5awpVg18FE4SpCUUQdcz14pckfeyTpGw5gxBueF2GLkIsSkguFemlNxvD3azqkIPJl6qerzYuMeCzhNFq3GiTY=
X-Spam-Level: *



On 11/24/23 04:24, Joey Gouly wrote:
> Hi all,
> 
> I just hit a boot crash on v6.7-rc2 (arm64, FVP model):

[..]

> Checking `struct neighbour`:
> 
> 	struct neighbour {
> 		struct neighbour __rcu	*next;
> 		struct neigh_table	*tbl;
> 	.. fields ..
> 		u8			primary_key[0];
> 	} __randomize_layout;
> 
> Due to the `__randomize_layout`, `primary_key` field is being placed before `tbl` (actually it's the same address since it's a 0 length array). That means the memcpy() corrupts the tbl pointer.
> 
> I think I just got unlucky with my CONFIG_RANDSTRUCT seed (I can provide it if needed), it doesn't look as if it's a new issue.

It seems the issue is caused by this change that was recently added to -rc2:

commit 1ee60356c2dc ("gcc-plugins: randstruct: Only warn about true flexible arrays")

Previously, one-element and zero-length arrays were treated as true flexible arrays
(however, they are "fake" flex arrays), and __randomize_layout would leave them
untouched at the end of the struct; the same for proper C99 flex-array members. But
after the commit above, that's no longer the case: Only C99 flex-array members will
behave correctly (remaining untouched at end of the struct), and the other two types
of arrays will be randomized.

> 
> I couldn't reproduce directly on v6.6 (the offsets for `tbl` and `primary_key` didn't overlap).
> However I tried changing the zero-length-array to a flexible one:
> 
> 	+	DECLARE_FLEX_ARRAY(u8, primary_key);
> 	+	u8		primary_key[0];
> 
> Then the field offsets ended up overlapping, and I also got the same crash on v6.6.

The right approach is to transform the zero-length array into a C99 flex-array member,
like this:

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 07022bb0d44d..0d28172193fa 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -162,7 +162,7 @@ struct neighbour {
         struct rcu_head         rcu;
         struct net_device       *dev;
         netdevice_tracker       dev_tracker;
-       u8                      primary_key[0];
+       u8                      primary_key[];
  } __randomize_layout;

  struct neigh_ops {

--
Gustavo

