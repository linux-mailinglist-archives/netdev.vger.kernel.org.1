Return-Path: <netdev+bounces-214858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7C0B2B7AD
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 05:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA96E6266F4
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 03:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66892F9C53;
	Tue, 19 Aug 2025 03:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XAv7CCLM"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D42C2EAB6E
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 03:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755574471; cv=none; b=szHUu5Lhd/ug3J64Uy8mJ/hOIdVwjIARdq+5PQdTUaFOFsyvxzwjV/Kd9vi2t8Vo2xXTu/s4yZ6vQPo4MOs9YZGWmsOSX7BBm2sbAAQOg2a8tKLzaaqG7zkKxzTzCMjIeq0DkYTNBHwraR7n9H92FE+AJcDGnFHd7Uepe8rRwow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755574471; c=relaxed/simple;
	bh=JKNZX2bbEIrC8xCWZSb+vHXAfSZLVZNxXfIdG7LwcsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=taUu94qaUAJN2Vs16UG1izn81XJeamap1uEPpTNSAJOKagNWOUCCrkvK+VYFz2zQm5YBZ7aeLfCyzYCfYUN5qfOUtppaD4XDtGUcWBmzS/YjqVEz+RWFC+HqyUudKYzLAatimoKDqPnVnO4gPCDNf2w37yYUx3skISfAzRJk1xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XAv7CCLM; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250819033421epoutp0186d34ddee9031b0ae3c1d3c7335ec3ae~dDavtCL-K0184601846epoutp01h
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 03:34:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250819033421epoutp0186d34ddee9031b0ae3c1d3c7335ec3ae~dDavtCL-K0184601846epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755574461;
	bh=Hsc9puMhPwaXFA5i4kUspsGUpcSO7N7D73eS4uhdn3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XAv7CCLM6SQreTulkQMq4em7c1xdncPU0BbOGn72h1yGzDf2reKDAFT53/LGf7Rvi
	 uVWulezwXSgwqdt4SVA//YSk6KUE7ECtdMi5HiLNq+BDzRDiH64XpAs3u87Pjjnr1x
	 8YzLaIRFMpRw4J1uRoJ1jWfNSPxKvar/br7kHh+Q=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250819033421epcas5p386142418c9dce35e45e0a8ed238f7a60~dDavLPnx-1213112131epcas5p3t;
	Tue, 19 Aug 2025 03:34:21 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.88]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4c5ZvJ1tHGz6B9mD; Tue, 19 Aug
	2025 03:34:20 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250819033318epcas5p3325d9c2481db3e40d776197d13f09d5a~dDZ034sxy1308013080epcas5p3B;
	Tue, 19 Aug 2025 03:33:18 +0000 (GMT)
Received: from asg29.. (unknown [109.105.129.29]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250819033316epsmtip2600ea94da3ad14d0a16bd9af8a307fec~dDZzQbId-1926619266epsmtip2D;
	Tue, 19 Aug 2025 03:33:16 +0000 (GMT)
From: Junnan Wu <junnan01.wu@samsung.com>
To: jasowang@redhat.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	eperezma@redhat.com, junnan01.wu@samsung.com, kuba@kernel.org,
	lei19.wang@samsung.com, linux-kernel@vger.kernel.org, mst@redhat.com,
	netdev@vger.kernel.org, pabeni@redhat.com, q1.huang@samsung.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	ying123.xu@samsung.com
Subject: Re: [PATCH net] virtio_net: adjust the execution order of function
 `virtnet_close` during freeze
Date: Tue, 19 Aug 2025 11:33:26 +0800
Message-Id: <20250819033326.3602994-1-junnan01.wu@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CACGkMEsVJcb2YYvfXYA0soE++cPEmQatkC0tB+shNKB=OTteWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250819033318epcas5p3325d9c2481db3e40d776197d13f09d5a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250819033318epcas5p3325d9c2481db3e40d776197d13f09d5a
References: <CACGkMEsVJcb2YYvfXYA0soE++cPEmQatkC0tB+shNKB=OTteWg@mail.gmail.com>
	<CGME20250819033318epcas5p3325d9c2481db3e40d776197d13f09d5a@epcas5p3.samsung.com>

On Tue, 19 Aug 2025 10:48:37 +0800 Jason Wang wrote:
> On Mon, Aug 18, 2025 at 11:39 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Mon, 18 Aug 2025 09:15:22 +0800 Junnan Wu wrote:
> > > > > Yes, you are right. The commit of this fix tag is the first commit I
> > > > > found which add function `virtnet_poll_cleantx`. Actually, we are not
> > > > > sure whether this issue appears after this commit.
> > > > >
> > > > > In our side, this issue is found by chance in version 5.15.
> > > > >
> > > > > It's hard to find the key commit which cause this issue
> > > > > for reason that the reproduction of this scenario is too complex.
> > > >
> > > > I think the problem needs to be more clearly understood, and then it
> > > > will be easier to find the fixes tag. At the face of it the patch
> > > > makes it look like close() doesn't reliably stop the device, which
> > > > is highly odd.
> > >
> > > Yes, you are right. It is really strange that `close()` acts like
> > > that, because current order has worked for long time. But panic call
> > > stack in our env shows that the function `virtnet_close` and
> > > `netif_device_detach` should have a correct execution order. And it
> > > needs more time to find the fixes tag. I wonder that is it must have
> > > fixes tag to merge?
> > >
> > > By the way, you mentioned that "the problem need to be more clearly
> > > understood", did you mean the descriptions and sequences in commit
> > > message are not easy to understand? Do you have some suggestions
> > > about this?
> >
> > Perhaps Jason gets your explanation and will correct me, but to me it
> > seems like the fix is based on trial and error rather than clear
> > understanding of the problem. If you understood the problem clearly
> > you should be able to find the Fixes tag without a problem..
> >
> 
> +1
> 
> The code looks fine but the fixes tag needs to be correct.
> 
> Thanks

Well, I will do some works to find out the fixes tag.
Once there's progress, I will let you know.

