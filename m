Return-Path: <netdev+bounces-233444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF85C13577
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 08:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463921883F73
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 07:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D18222D795;
	Tue, 28 Oct 2025 07:42:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from chinatelecom.cn (smtpnm6-08.21cn.com [182.42.159.130])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D153E23EAB8
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.159.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761637327; cv=none; b=ocesoH4rOld4FjO6iheKuEH/D0C9i5Q14ojoTB1pEl5P8w9hHhhEtvlPlVub6QGSrHgKNwsJjVkJmfedQGNSqKUlaOgm1w8o3oqSOyjy5UIlGIzTkTh0y/OIukgCA2U1l0jSktrv9L+laPEhMi6pf3mVpSZv14N+fSFLV1l71ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761637327; c=relaxed/simple;
	bh=606YGgEfIlHDfi6pSUV3ijYpXH8pd+wQknKkEyhPtXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lp2JX6Q2eG0WjsmRMHijYQ/xvN7EwWkyBhT/wIIm+edSErvEG01sLZM4aL5yVNpClm2GOHp8mUlQi9hSI9ZjIJrJt4tka+BX+EOxO3VbGVOVhHZYMCF5L17djZx/mWBLT/thaoa4LwDPfyt06kuLDEHWK4f0OLsHp5jEkajt2so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.159.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.137.232:0.230931900
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-27.148.194.68 (unknown [192.168.137.232])
	by chinatelecom.cn (HERMES) with SMTP id B3B2D904FDDA;
	Tue, 28 Oct 2025 15:34:51 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([27.148.194.68])
	by gateway-ssl-dep-79cdd9d55b-2nzwx with ESMTP id 3256557da404483dac94efec0516385a for kuba@kernel.org;
	Tue, 28 Oct 2025 15:34:53 CST
X-Transaction-ID: 3256557da404483dac94efec0516385a
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 27.148.194.68
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Message-ID: <44342ead-92c9-4467-b5e6-86076684e2ee@chinatelecom.cn>
Date: Tue, 28 Oct 2025 15:34:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] net: ip: add drop reasons when handling ip
 fragments
To: kuba@kernel.org
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org
References: <1761532365-10202-1-git-send-email-liyonglong@chinatelecom.cn>
 <1761532365-10202-2-git-send-email-liyonglong@chinatelecom.cn>
Content-Language: en-US
From: YonglongLi <liyonglong@chinatelecom.cn>
In-Reply-To: <1761532365-10202-2-git-send-email-liyonglong@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jakub,

Thank you for your response. I'm sorry for the late reply.
‌My email system seems to have some issues, and I loss  your reply msg.
I get your response information from web page: https://lore.kernel.org/netdev.


> Personally IDK if this is sufficiently semantically significant
> to warrant merging. FRAG_FAILED means "unidentified error during
> fragmentation"? ip_frag_next() only returns -ENOMEM and
> SKB_DROP_REASON_NOMEM already exists, so just use that.

Yes, I agree. use NOMEM instead of FRAG_FAILED.


> FRAG_OUTPUT_FAILED means something failed in output so it'd be more
> meaningful to figure out what failed there, instead of adding
> a bunch of ${CALLER}_OUTPUT_FAILED

The skb send failed in output() is frag skb, The skb droped outside of output() is the
origin skb. I think if we want to get detail drop reason we can use kfree_skb_reason
in output() (maybe anther patch set in future).
In my opinion, drop reason of the origin skb outside of output() can be not so meaningfull.


-- 
Li YongLong


