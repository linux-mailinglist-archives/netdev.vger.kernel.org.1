Return-Path: <netdev+bounces-180974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C797A8352A
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6444D1B63C44
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 00:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616457080D;
	Thu, 10 Apr 2025 00:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="u8vtkYb5"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166F8136E
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 00:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744246390; cv=none; b=KIkMpphKp0i7fdvpfQm7PoAQIh/E33Ii7xCoNB51G/vBdfC8EKk1iYgKRwiObfBPdbMZeruMU8LJRRQ87QP201daaffP2Z1dxfMgh8pJITOzhd1jH2X22N6M3GVklJ3yjdnN1Yo7MDGmbhXiwDuGib4DGfh28pMO54IAfrpX7QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744246390; c=relaxed/simple;
	bh=fsOddfVX7V5KkkPXD1GuJHf9rfIe77uHCseIDcO89+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IgDzO4PdnD3BVozwF0H2NOa5+0V745HssomyXnIC8l/NHWMoO2AM3OlbbQU9TxLoeRiQX/JOxC+PeQ6SgG7ZOUSqRzzAzQh7eo3XRmBntt85jPwgccFN+WKjcTxaUXQfEMgtqeteaMqQcamYxYGiWk0QYAzJDsW0vv91jBPKo4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=u8vtkYb5; arc=none smtp.client-ip=17.58.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=r6XmJIFr7QSOukVIZtVvldsOdQcCgSTp2kqkiVt6ee4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=u8vtkYb5u8qBR3///h27eNvKQsb9Aam/eKWxbOK44QRpjweuiXUdefgMUAFhKNWHJ
	 tLHy88+Qi3vnLJyOShuJJru++4rA9qEXuBUcLqepJ/KAqlLnHeSYwrfysg+fq0e2Cl
	 9ocxBaPXBNcg9HZk6kgGdpGw7vq/JGeQm71W+O9ggqPVpvmvqAg4IU+xih63i6qkZ1
	 uvahcWPqfYpDdxpffUeiRAtfLNcYC44wvu9YPk0AlciXUnLN1TWRdWOkrO62eqd0XC
	 z4GDkSwjads+1bxj7XE0ywwKDuoLNygQmF0qf7VULXzUJAFYiHO1d9570Cq0OJzQLW
	 q4C2eCdTKLtbA==
Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
	by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPS id 3513AA02B0;
	Thu, 10 Apr 2025 00:53:03 +0000 (UTC)
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id F163DA0136;
	Thu, 10 Apr 2025 00:52:32 +0000 (UTC)
Message-ID: <2e4fa39d-3d1d-4336-af99-4ecdf8a9482f@icloud.com>
Date: Thu, 10 Apr 2025 08:52:29 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] sock: Correct error checking condition for
 assign|release_proto_idx()
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Pavel Emelyanov <xemul@openvz.org>,
 Eric Dumazet <dada1@cosmosbay.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20250408-fix_net-v1-1-375271a79c11@quicinc.com>
 <CANn89iKP-5hy-oMuYwEvwFOzzAkfF5=8v7patSE5z7PZQS0V2Q@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <CANn89iKP-5hy-oMuYwEvwFOzzAkfF5=8v7patSE5z7PZQS0V2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: d1vt1E6VHyJKiYHACmo99i3JmO6Mdgm5
X-Proofpoint-GUID: d1vt1E6VHyJKiYHACmo99i3JmO6Mdgm5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_06,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=961 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504100005

On 2025/4/9 03:06, Eric Dumazet wrote:
>>  {
>> -       this_cpu_add(net->core.prot_inuse->val[prot->inuse_idx], val);
>> +       unsigned int idx = prot->inuse_idx;
>> +
>> +       if (likely(idx < PROTO_INUSE_NR))
>> +               this_cpu_add(net->core.prot_inuse->val[idx], val);
>>  }
> I do not think we are going to add such a test in the fast path, for a
> bug that can not happen.
> 

agree.

> Please give us a reproducer ?

will remove that check in v2 provided @prot->inuse_idx will never be
used if @prot fails to be registered.

thank you for code review.

