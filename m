Return-Path: <netdev+bounces-146424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FAB9D3569
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 09:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CE7528249C
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 08:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C657360DCF;
	Wed, 20 Nov 2024 08:29:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0BA16F271
	for <netdev@vger.kernel.org>; Wed, 20 Nov 2024 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732091379; cv=none; b=eOFOB2nbvB94SZapIteu+BU8N6b/Kwrsbb4jlzbKk6hAn2t828n22Im+a4w1Ru83i4YWb0oqqX/bmiiBzj4IfOeSO+RO2UUNHsf7UP2bE6ZGBFm5PtzGjMVv+wt/Iqhy4f4M7oDEe3Bpm8io5sEARYf73aLRDwbygBufNBeDREo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732091379; c=relaxed/simple;
	bh=7Ifr4kwlqQu0C1yFJZS3ajkFCOJ0TzLt5KNV+Hb4vwg=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=tQ3TXNKGB/YXnsfsWUIttNzbnBJowtIpIVp1y233oXPgGh80nEvH+gifkFoanS0d+0tdlTW2QSimMzCeh891c00xbrGdwE0HzgXohWYeCpVIW63nL98rx/B7RT3Lv1KWrJ5qVD0IvfPxEKwdH3f0MTT67dM9ENMHbOaJHbq7Mf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas2t1732091313t745t33693
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.206.160.172])
X-QQ-SSF:0001000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 12491251422650144601
To: "'Paolo Abeni'" <pabeni@redhat.com>,
	"'Russell King'" <linux@armlinux.org.uk>
Cc: <netdev@vger.kernel.org>
References: <f769256c-d51c-4983-b7a5-015add42ca35@redhat.com>
In-Reply-To: <f769256c-d51c-4983-b7a5-015add42ca35@redhat.com>
Subject: RE: net vs net-next conflicts while cross merging
Date: Wed, 20 Nov 2024 16:28:32 +0800
Message-ID: <013a01db3b26$2f719310$8e54b930$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQK2AfNkyr04IUYYpGaScxifmQHGp7EKRjtg
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MZQHZNohqAr1MDRdV/Q2PNLXc496CNtcwJTrNf0EyyGBkijD7BAekmos
	YDJ3xLewarIgtVwyShmbniDoHRJCl0wR/YivMLMQd0qdhm5xTZNsdcPoxFQEHEchdtv5oMu
	lASQUPm1T+2JQauianxJLbTTEaFoNtIL/h5xi4BeoWn+y0dofzjaHCCY8+6YhPvmEEtR/fV
	EXyqoOOQbVkToRQeONIbONoiEmjnvZ/R+Dg5QHHFSYe/TnaSbhWjH8jm7+3KLYvUH1lpzoR
	EYiiYTcp3a6jzBnG2PVRjPbE/CxWKz0fhZqfFGFE5AuPSc2AycIJT6ro42JVeeIV0ezhRki
	G3XElk1tRGCpDcHcumVOJPSr0oY6ZVtxcsCBtGAzTu3salmqpvIvEwgQyub7EErfZYMh4RC
	8b+X05n2j9vGFC4jVl2jAU9d9V4Lu41X3G5f17Z8U6uBldrwukpbnlZp82JPrzbWk1UcE5G
	5KYlhLGVG5DwgZuEDg5jBy6z0a01SYxrUYvG2ZDJX0FJVdKH671+etK63z7EHhToKOv3Aah
	GFabIF40LRbYx4LcqB53vBIDind1pbUGyqJaqtKCHcHtnCI56uQoy7xNJWsx5I/CBnUV5yU
	h5SJf9Z9jq2Vj6LO0bHdR96z1aD1qFUTCMXULMOj+tpUk/FTw5XS8YAjV/WWJ+1NSOLoe4K
	Is2jrCQytyFmgnHgVHopiVUgK3aUgWxCvBVK4W4np0sTSfCuv66mArZh9wtayfuMjqfWcBq
	se6ePOY9Cr19R7z1jSyjT7lEYcj0zzFWDeNwynUaEHHSdRtHK9ivWfGzvc9Y6D59mhOlKU9
	/T2fv3VTraLHmVi7LxGWaG67qk3ao13pZ/3pzXx6S9yDxZKJ2Jmaf0kRGsJRUztOnlTN/CI
	GPMuPoANcj99wFRpAG00a0TB21WbMeyTvJxP22EGu2hfbvCuuHCxWMuLGTtWklx7J1nQT7P
	gZWZI7rU7l2Nohn/p4PHel1Rgl4uv721COeGBpBLO2Ul14VZZH6IH42GVeR3DXBHCVImMkp
	u04D/ic/DdcRWyTHr3/FElacoendE=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Tue, No 19, 2024 9:15 PM, Paolo Abeni wrote:
> Hi,
> 
> I just cross-merged net into net-next for the 6.13 PR. There was 2
> conflicts:
> 
> include/linux/phy.h
> 41ffcd95015f net: phy: fix phylib's dual eee_enabled
> 21aa69e708b net: phy: convert eee_broken_modes to a linkmode bitmap
> 
> drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> 2160428bcb20 net: txgbe: fix null pointer to pcs
> 2160428bcb20 net: txgbe: remove GPIO interrupt controller

Hi,

I don't find what's the conflict here. Do you mean these two:

2160428bcb20 ("net: txgbe: fix null pointer to pcs")
155c499ffd1d ("net: wangxun: txgbe: use phylink_pcs internally")

If this is the case, it should be resolved as follow:

static struct phylink_pcs *txgbe_phylink_mac_select(struct phylink_config *config,
						    phy_interface_t interface)
{
	struct wx *wx = phylink_to_wx(config);
	struct txgbe *txgbe = wx->priv;

	if (wx->media_type != sp_media_copper)
		return txgbe->pcs;

	return NULL;
}

Thanks!
 


