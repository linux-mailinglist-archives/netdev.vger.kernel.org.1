Return-Path: <netdev+bounces-116639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6539994B45D
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 03:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929471C21605
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 01:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F9D1854;
	Thu,  8 Aug 2024 01:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D8820ED;
	Thu,  8 Aug 2024 01:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723078824; cv=none; b=rBN67YAfrLhpm5H/VfQhfTiM9CKOX+/v6OldBLrTZake+63YrGt9C5+aHGeRWmVzVdiLhNTGgBbPnUMpun64pa0dZbNOOvq9wpdeNWwB5m6iMCvYdovzIzzjBUER7lUEtokr3Vd3jft9Jpv7Zx0RIIfOMtHyOPpOSyv6ZEZCSQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723078824; c=relaxed/simple;
	bh=bF4iE2NrtOb1BFE9Ocbi6spQhdhuNgVlEMMUuM2ML54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G0ObLN2OtajyNSQgVOAUuK1Zwkl75LctN9Yq2iLVYHDk+wSQSXo7Ha9gA0LiCP41oDekXNvPaT0W1dXYHj3O48ESIHCjpAVQRDKEoeuTh2E7IOnr6TT9aYJoOaTs9oaRCDxzlj1WfNFn3cSNIcTJLAkYqGiCImasGFisai/+wSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 90023d82552111efa216b1d71e6e1362-20240808
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, CIE_UNKNOWN
	GTI_FG_BS, GTI_C_CI, GTI_FG_IT, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_HH, AMN_C_TI, AMN_C_BU
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:5488b766-34bc-473e-bb7b-dea250863492,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:15
X-CID-INFO: VERSION:1.1.38,REQID:5488b766-34bc-473e-bb7b-dea250863492,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:15
X-CID-META: VersionHash:82c5f88,CLOUDID:7f94e2ef7ffbb62d0b01094f1af5da4d,BulkI
	D:240808084355KNDNP6G5,BulkQuantity:3,Recheck:0,SF:64|66|23|17|19|43|74|10
	2,TC:nil,Content:0,EDM:-3,IP:-2,URL:1,File:nil,RT:nil,Bulk:40,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 90023d82552111efa216b1d71e6e1362-20240808
X-User: zhanghao1@kylinos.cn
Received: from pve.sebastian [(118.250.2.77)] by mailgw.kylinos.cn
	(envelope-from <zhanghao1@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 545650491; Thu, 08 Aug 2024 09:00:11 +0800
From: zhanghao <zhanghao1@kylinos.cn>
To: horms@kernel.org
Cc: bongsu.jeon@samsung.com,
	krzk@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzbot+3da70a0abd7f5765b6ea@syzkaller.appspotmail.com,
	zhanghao1@kylinos.cn
Subject: Re: Re: [PATCH] nfc: nci: Fix uninit-value in nci_rx_work()
Date: Thu,  8 Aug 2024 08:59:17 +0800
Message-Id: <20240808005917.15118-1-zhanghao1@kylinos.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240804105716.GA2581863@kernel.org>
References: <20240804105716.GA2581863@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 04/08/2024 12:57, Simon Horman wrote:
> > On Sat, Aug 03, 2024 at 08:18:17PM +0800, zhanghao wrote:
> >> Commit e624e6c3e777 ("nfc: Add a virtual nci device driver")
> >> calls alloc_skb() with GFP_KERNEL as the argument flags.The
> >> allocated heap memory was not initialized.This causes KMSAN
> >> to detect an uninitialized value.
> >>
> >> Reported-by: syzbot+3da70a0abd7f5765b6ea@syzkaller.appspotmail.com
> >> Closes: https://syzkaller.appspot.com/bug?extid=3da70a0abd7f5765b6ea
> > 
> > Hi,
> > 
> > I wonder if the problem reported above is caused by accessing packet
> > data which is past the end of what is copied in virtual_ncidev_write().
> > I.e. count is unusually short and this is not being detected.
> > 
Yes, you're right.I debug the kernel and find that skb->data is " ".The 
length is less than 2.Using nci_plen to access skb->data in nci_rx_work()
triggers kmsan to detect access to uninitialized memory.
 
I wonder if I can use skb->len to determine length in the
nci_rx_work().I tested it and there was no problem.
 
> >> Fixes: e624e6c3e777 ("nfc: Add a virtual nci device driver")
> >> Link: https://lore.kernel.org/all/000000000000747dd6061a974686@google.com/T/
> >> Signed-off-by: zhanghao <zhanghao1@kylinos.cn>
> >> ---
> >>  drivers/nfc/virtual_ncidev.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/nfc/virtual_ncidev.c b/drivers/nfc/virtual_ncidev.c
> >> index 6b89d596ba9a..ae1592db131e 100644
> >> --- a/drivers/nfc/virtual_ncidev.c
> >> +++ b/drivers/nfc/virtual_ncidev.c
> >> @@ -117,7 +117,7 @@ static ssize_t virtual_ncidev_write(struct file *file,
> >>  	struct virtual_nci_dev *vdev = file->private_data;
> >>  	struct sk_buff *skb;
> >>  
> >> -	skb = alloc_skb(count, GFP_KERNEL);
> >> +	skb = alloc_skb(count, GFP_KERNEL|__GFP_ZERO);
> >>  	if (!skb)
> >>  		return -ENOMEM;
> > 
> > I'm not sure this helps wrt initialising the memory as immediately below there
> > is;
> > 
> > 	if (copy_from_user(skb_put(skb, count), buf, count)) {
> > 		...
> > 
> > Which I assume will initialise count bytes of skb data.
> 
> Yeah, this looks like hiding the real issue.
> 
> Best regards,
> Krzysztof

