Return-Path: <netdev+bounces-181205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF24A84120
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463B7189D0C4
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 10:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4991E21A94F;
	Thu, 10 Apr 2025 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="lOwW5HX7"
X-Original-To: netdev@vger.kernel.org
Received: from mr85p00im-ztdg06011101.me.com (mr85p00im-ztdg06011101.me.com [17.58.23.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95802147ED
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 10:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744282032; cv=none; b=MGykRCDe/B8YoTaqi6bmA7OOvs7Xh4GHDyn2WmdOrU8ZXdBSysnLkbEA/Q4ovxRLLe2KnkAXOBsBAf9mtVKbOAtmA4tBB/bP4T2aJLhzMpM42OdD9fW8758pnEZxoe0+8ed81NBhIHpXfWBr26eVvk3Pd2xGmkubkcnePVcSXs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744282032; c=relaxed/simple;
	bh=/SzIIl8glx834G56UGPfB2A+zMVV/rqrdXWyJUoVB1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TklOt22WVUBneocyPVczDOp1i66BauUNY7m9Th1ZRTVn+sNJucPPiDnNfZFogi7bQFDjm7hzUfiI7SHpxBbWAsDlFyRQGljYsL5+K4eR1Fsp0Zht4z/BqsOvp9DUuJxYg+dnKcZk8vHL+F0/aa7gQ/sQGloVnii99kz1lwnt+2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=lOwW5HX7; arc=none smtp.client-ip=17.58.23.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=AHanVT6iRMOTk04nt7SHSG+50FZYlbxzcEQ6De1ez50=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=lOwW5HX7gR5cXbSvfSM/fqaEC++HlRRJqYOEqLn2mBltNAyY1+xf1agRzTYVrsUZv
	 TGdcgYeSxt/eQnfVz6jpXeBwH95VzJEbdU0sm4N3StKJ9k1sJ+kYnOjFEpM0IqZKnG
	 1ZGZ1ykBPGbB8cQzxtez/YPGcU2JX+WMDC0b9LhK+4W5vkNE/8Q/lainw/kti+ez6l
	 DBrQemUKZTxZMdh9X4S85ghSRS6T2pxZWeP3lGEuTfMDf/djkSJYBwfX2lofsqMPAq
	 5ITYGUEsyMTRVMC+oZvADy9N/RraS8UarBhbYBg/WARyy7Z1MGvgKQYyLL6LDKmXaN
	 y+SgdV0eiyxag==
Received: from mr85p00im-ztdg06011101.me.com (mr85p00im-ztdg06011101.me.com [17.58.23.185])
	by mr85p00im-ztdg06011101.me.com (Postfix) with ESMTPS id CF859DA03C6;
	Thu, 10 Apr 2025 10:47:09 +0000 (UTC)
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011101.me.com (Postfix) with ESMTPSA id 06A88DA033E;
	Thu, 10 Apr 2025 10:47:06 +0000 (UTC)
Message-ID: <ed3ce657-01e1-4d4a-bfbb-062d5ae765f9@icloud.com>
Date: Thu, 10 Apr 2025 18:47:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] sock: Correct error checking condition for
 (assign|release)_proto_idx()
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: dada1@cosmosbay.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, quic_zijuhu@quicinc.com,
 willemb@google.com, xemul@openvz.org
References: <20250410-fix_net-v2-1-d69e7c5739a4@quicinc.com>
 <20250410035328.23034-1-kuniyu@amazon.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20250410035328.23034-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ttBYjDirZWMACttoes--FMHxsX7QbBDU
X-Proofpoint-ORIG-GUID: ttBYjDirZWMACttoes--FMHxsX7QbBDU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 clxscore=1011 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504100081

On 2025/4/10 11:53, Kuniyuki Iwashima wrote:
>> [PATCH net-next v2] sock: Correct error checking condition for (assign|release)_proto_idx()
> Maybe net instead of net-next ?
> 

Either net or net-next is okay.

> 
> From: Zijun Hu <zijun_hu@icloud.com>
> Date: Thu, 10 Apr 2025 09:01:27 +0800
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> (assign|release)_proto_idx() wrongly check find_first_zero_bit() failure
>> by condition '(prot->inuse_idx == PROTO_INUSE_NR - 1)' obviously.
>>
>> Fix by correcting the condition to '(prot->inuse_idx == PROTO_INUSE_NR)'
>>
>> Fixes: 13ff3d6fa4e6 ("[SOCK]: Enumerate struct proto-s to facilitate percpu inuse accounting (v2).")
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


