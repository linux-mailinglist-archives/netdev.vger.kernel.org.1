Return-Path: <netdev+bounces-154624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E528D9FEE6F
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 10:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4661881BCD
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 09:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA01718E377;
	Tue, 31 Dec 2024 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="CUkRIS7p"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-48.ptr.blmpb.com (va-2-48.ptr.blmpb.com [209.127.231.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F9513B7AE
	for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735638034; cv=none; b=U3+BC9ca80iKtUXYL6Mo/wu9PtQZp2kKeo/mwRKFRUqJJIqgv/eis31kk2S13paxs2jUMUtfVQE969CnU82ki5PplrZrxeDfTeEFYCvgx0qRJWgfTYaRgmBOoc7gB07upOEtpVk4+ZdqvCV1/TYumXPQ5XSih2P/XlxkIwxgD1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735638034; c=relaxed/simple;
	bh=0wEH6SXICD715U8SYWvG178P06CSdymwXFrvLe2pDEU=;
	h=To:Date:References:Content-Type:Message-Id:In-Reply-To:Cc:From:
	 Subject:Mime-Version; b=S4vU3Fi0sQr1zwC6yNJrbB/uQiJfbDwaLCmyIYCt7AlFC6RAVYJCN34dA8W5toObWKPI1cpSCG/haXZa0GN7Bltexzqa7jkrVleR/NBH0xnQ++pB64FGMXCXAvkd9iRO0cBIwkanhidDuDfdD26kMkuUV5sOusDEQRbFeRxTRs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=CUkRIS7p; arc=none smtp.client-ip=209.127.231.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1735638020; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=i1PrNfAXzIi+Ix6R7sdRoU8AIW5pfJXmLKZtZXrdy00=;
 b=CUkRIS7p2BVkkPPf0kGZ7K8leEMhuNKmBArDFeRKzsLxhDxgfsppfN1cxchSa+dt2w5IId
 E0fLqrGnyEV3ER8hvXpyz7/lwvBb0LErqAAVROvpBKT2/f4WgQO5+E7c5b3plRoVGj9LD+
 XPnKbpZMP5+UFhp5SIXqv6paS558F25lPk2zsLb3STO8hWAv1dkZ7H0Hf+X7pVspt0at6a
 tETNCwRMZOaGdQt8zcCTYCL8m9a74Zo4S+IAQ++OpxqphgwNVO3PWJgUgzcUmZF9egXmSg
 n4574dW7So2lh7lhY9E3INBKqZl60M2B5icZXRi4vk2tjk2rcdSDoT7orL07Cg==
X-Original-From: tianx <tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+26773bc02+13e3f3+vger.kernel.org+tianx@yunsilicon.com>
User-Agent: Mozilla Thunderbird
To: "Andrew Lunn" <andrew@lunn.ch>, "weihonggang" <weihg@yunsilicon.com>
Date: Tue, 31 Dec 2024 17:40:15 +0800
References: <20241230101513.3836531-1-tianx@yunsilicon.com> <20241230101528.3836531-9-tianx@yunsilicon.com> <9409fd96-6266-4d8a-b8e9-cc274777cd2c@lunn.ch> <98a2deaf-5403-4f85-a353-00bfe12f5b13@yunsilicon.com> <45dfc294-76d8-4482-b857-4e3093ac829d@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Received: from [127.0.0.1] ([116.231.104.97]) by smtp.feishu.cn with ESMTPS; Tue, 31 Dec 2024 17:40:17 +0800
Message-Id: <a09b9cda-5961-452b-84cb-844262e5b71a@yunsilicon.com>
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <45dfc294-76d8-4482-b857-4e3093ac829d@lunn.ch>
Cc: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<wanry@yunsilicon.com>
From: "tianx" <tianx@yunsilicon.com>
Subject: Re: [PATCH v2 08/14] net-next/yunsilicon: Add ethernet interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

On 2024/12/31 13:12, Andrew Lunn wrote:
> On Tue, Dec 31, 2024 at 12:13:23AM +0800, weihonggang wrote:
>> Andrew, In another module(xsc_pci), we check xdev_netdev is NULL or not
>> to see whether network module(xsc_eth) is loaded. we do not care about
>> the real type,and we do not want to include the related header files in
>> other modules. so we use the void type.
> Please don't top post.
>
> If all you care about is if the module is loaded, turn it into a bool,
> and set it true.
>
> 	Andrew

 =C2=A0Hi, Andrew

Not only the PCI module, but our later RDMA module also needs the netdev=20
structure in xsc_core_device to access network information. To simplify=20
the review, we haven't submitted the RDMA module, but keeping the netdev=20
helps avoid repeated changes when submitting later.

Best regards,

Xin

