Return-Path: <netdev+bounces-217602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBABB39317
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 07:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53631BA7FD0
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 05:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598B6259CB2;
	Thu, 28 Aug 2025 05:37:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FDD7260F;
	Thu, 28 Aug 2025 05:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756359449; cv=none; b=NZ6cQkWHIkdsAYnZTYy6ybQscFmAReJk4dx+Ks9Ubga15uF/9Y3aCJIGF7x6OSt+Vbkx1BHVaPU2qUQI/Qqy3LoSP67A5yXMFgho83iCWci9yHtg71x06zjTjgltfWuWvb4F0pFYGgZNsXIMyyIKJjRAGIjM4Jyu4wgh62F47P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756359449; c=relaxed/simple;
	bh=A9k39wJ79ZzruOuRsKpqxLH+essj4F8/VAkiCQn2eDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dudj8tjKoM5DPUqSbk4QjrIunwLysb/RBdQobOuITrMY5yAVN+/UyqrAwQjasz7VU3KG22MTZlLwzE9LcgmR2MhEqSwHN33PzjdSO/eLwPNS+NL8IhV7fv02M6vNV1HDfnoG8gmRm5ahetSDecycxVs7Z0t+qnSw7i/0aw61dAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz7t1756359421t5d734300
X-QQ-Originating-IP: 1glQHWNwwtKYbWDowIYKqbq6D37frNQQc9nHT0Y4Z20=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 28 Aug 2025 13:36:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2014165224566698848
Date: Thu, 28 Aug 2025 13:36:59 +0800
From: Yibo Dong <dong100@mucse.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, rdunlap@infradead.org,
	vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v9 0/5] Add driver for 1Gbe network chips from
 MUCSE
Message-ID: <BC262E8E0C675110+20250828053659.GA645649@nic-Precision-5820-Tower>
References: <20250828025547.568563-1-dong100@mucse.com>
 <0651d5a9-dd02-4936-94b8-834bd777003c@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0651d5a9-dd02-4936-94b8-834bd777003c@ti.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OaNPNQWBi+in/szjHMwc2bYrOkb7eshd7T2iZ7IYJ/N7AbX5P1UKCAn7
	m+O31pED8uDefR03mJuPZxGD/3BIsDv+YXySf2ZVByADPg2uWub17bOZaiaABpx/c2Aeifn
	B+Pxak6KEhVupBurSykd5cboW9VsSTvZzhX9iwmL4L9tDgm7FRF7COHGJCBqnwnIMBm7pDa
	sFyo0vI8Ooqsv3F4IBrNzoH5rKTME6vqwT1POP+rT1olWyPLzWu0yeRqqVcmhPd9Sl1r71i
	tFslRRswhKrTBgfsxspu9YQ8FmVuWTBD6pA9LYrTRilvDE8wapU13WvqKto4eth4ihLGmEw
	ttMbVKvOgooyggsC66JY1B3lkST5jDy9f4UwzRfu/NNmwHWFPfRScWPsbYSAEF3FeLo+AdR
	JHapamIKyXH4vvkzVVp1sFsJ8N74zgm7yp4KKBrCB/IywdxelKEc7CjCmG8jRMHHzOFP2XR
	3dNxl3HghfN6rfl8WP8yRxh5YLApcKOFxiErpEgRkMNyVfR9ig2+Z1dmeTSGKGX4qy3svzI
	Vj5TDY1jbTmTxRBv1f8ihu/oQAQvUwqNUHkMWd5acPMZsARy+9o0rJjoBju8zf+B62Ld0YL
	hBF23sYzx0iWa0xNFNMMH/8+4z5Pc+1Bwxbzbgcuvx2HfEKdLVQ/LZGYJZHGKqHpKEFcGhk
	Kh3V8zNcE0w6qHflG2glI5LpZkRQCt73BKDfHmp7cuGJCFgnaT8Kael5ucHjanGQxTLi5a0
	3hYhSxjhHLtlKiGrClNZL2MX+8HVnAfwbj55hxkC9MSge+6jMx4hmpncro+8bSOci/WFDJ1
	E7sM/6HBPuA7hf8N//hXBFvIZwDzrKvh4I2K0zPXr667mVkaj3rkc413Cm9RZgSxU7krNU7
	TiKFA6npW48ulSxKjxk//3DUIcjuY4pDQ1aDoA7OSFEBN7+3oTZXvLj2+/MqhcD7U1uEPkx
	SG+a0n/AcswZ4cSN4zyd+FkYhMai4qBTT4ytXA61qlxAk4cMLRpnuJaapKFyclE+C7ABmIy
	OGp4phNqZnAwgXyJmGBzUimSi33xJXsv/X90Sg80UJY/P0nD9uD3nB1qESWusVy/I+mzpfM
	w==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Thu, Aug 28, 2025 at 10:52:21AM +0530, MD Danish Anwar wrote:
> Hi Dong Yibo,
> 
> On 28/08/25 8:25 am, Dong Yibo wrote:
> > Hi maintainers,
> > 
> > This patch series is v9 to introduce support for MUCSE N500/N210 1Gbps
> > Ethernet controllers. I divide codes into multiple series, this is the
> > first one which only register netdev without true tx/rx functions.
> > 
> > Changelog:
> > v8 -> v9:
> > 1. update function description format '@return' to 'Return' 
> > 2. update 'negative on failure' to 'negative errno on failure'
> > 
> > links:
> > v8: https://lore.kernel.org/netdev/20250827034509.501980-1-dong100@mucse.com/
> > v7: https://lore.kernel.org/netdev/20250822023453.1910972-1-dong100@mucse.com
> > v6: https://lore.kernel.org/netdev/20250820092154.1643120-1-dong100@mucse.com/
> > v5: https://lore.kernel.org/netdev/20250818112856.1446278-1-dong100@mucse.com/
> > v4: https://lore.kernel.org/netdev/20250814073855.1060601-1-dong100@mucse.com/
> > v3: https://lore.kernel.org/netdev/20250812093937.882045-1-dong100@mucse.com/
> > v2: https://lore.kernel.org/netdev/20250721113238.18615-1-dong100@mucse.com/
> > v1: https://lore.kernel.org/netdev/20250703014859.210110-1-dong100@mucse.com/
> 
> Please wait for at least 24 hours before posting a new version. You
> posted v8 yesterday and most folks won't have noticed v8 by now or they
> maybe looking to give comments on v8. But before they could do that you
> posted v9.
> 
> Keep good amount of gaps between the series so that more folks can look
> at it. 24 hours is the minimum.
> 
> -- 
> Thanks and Regards,
> Danish
> 
> 

Got it, I found the v8 pathes state in websit:
https://patchwork.kernel.org/project/netdevbpf/list/
It is 'Changes Requested'. 
I mistakenly thought that a new version needed to be sent. I will wait
more time in the next time.

Thanks for you feedback.

