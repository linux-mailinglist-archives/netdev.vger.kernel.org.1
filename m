Return-Path: <netdev+bounces-127335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B48197511A
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6F7CB2266B
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6277118784E;
	Wed, 11 Sep 2024 11:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="0Mc6moVN"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-ztbu10021601.me.com (pv50p00im-ztbu10021601.me.com [17.58.6.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0E31537C9
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 11:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726055563; cv=none; b=VPAGfSNlfzPwimmEGF5qsAsWXzR9B0lKFmZC3murBVHTshnUiXUUS8PTJvgkmPD+OW7YNLggRJdTrmR6KAkngqhh7XatzJ01G7/eG6B5Yw5cCVQ9xqYu0nsmhKGaJO5WA/Omum52puHCZAIqymocpERnqNrOsGvLP0IDpHnND5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726055563; c=relaxed/simple;
	bh=1nKrHB2l1LWv7Ehl9rYYKmu0QV/L+jpnIJlN7OKLazs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B7vFanPG+B8Gd0y54x4e5fk4CypL/W1/jqRj6Ga3O+tp/MlzSVUZjjzY2gg+o0TsiTPd3Vo0lppQdLhOdhzavV2Kxx/InB8bmeV8+CAYVy+qluW/vN2CfvLUHf6onLnoklikwk+dOHfH6jRv7q+xCippamMc8WgaS/QZe+DxECo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=0Mc6moVN; arc=none smtp.client-ip=17.58.6.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1726055561;
	bh=8BXVMDejX71W48TZhhQpKYFMwY2Brelh8RqgI9K0HVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=0Mc6moVN8OwjfGM2mUkEjVeRY0IKGQcc+uDIp40Wi3OctttT0bDSb15R+jDmFWmSs
	 /EDW9O0NVtMt7fFgydptg7EvkRf81Gw+XzzC75CfFi1HIzIKtwFt5lUFJSgqvnI4A7
	 TxnHK8nIu52tlNmfM72U0fkGyJp5oTMaDuKTTDhrMg3dO5UFnGIaITYMlmsfLVeOTu
	 +L9S1+W8NHWOX8RejzrWN0tl8n1Y9oRdwWWygoDEV5mpN/cLDUj93x1EGEGd+P9ljx
	 3qDKInI8tpBb/Jq7zbZIPoCJPooak5GJ9BRgjixNiip1FGBwhod74wNz/Vq9r78s3K
	 9Riyb2LlJPACQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztbu10021601.me.com (Postfix) with ESMTPSA id 4D3EB80322;
	Wed, 11 Sep 2024 11:52:31 +0000 (UTC)
Message-ID: <1b1cf618-b62f-43ab-b2dd-29398e33a43d@icloud.com>
Date: Wed, 11 Sep 2024 19:52:09 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] cxl/region: Find free cxl decoder by
 device_for_each_child()
To: Dan Williams <dan.j.williams@intel.com>,
 quic_zijuhu <quic_zijuhu@quicinc.com>, Ira Weiny <ira.weiny@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Timur Tabi <timur@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240905-const_dfc_prepare-v4-0-4180e1d5a244@quicinc.com>
 <20240905-const_dfc_prepare-v4-1-4180e1d5a244@quicinc.com>
 <2024090531-mustang-scheming-3066@gregkh>
 <66df52d15129a_2cba232943d@iweiny-mobl.notmuch>
 <66df9692e324d_ae21294ad@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <a6dae308-ff34-4479-a638-8c12ff2e8d32@quicinc.com>
 <66dfc7d4f11a3_32646294f7@dwillia2-xfh.jf.intel.com.notmuch>
 <e7e6ea66-bcfe-4af4-9f82-ae39fef1a976@icloud.com>
 <66e06d66ca21b_3264629448@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <66e06d66ca21b_3264629448@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: XGgXzuS8JxHYSjgIR97mjtZ1k14OF2Zz
X-Proofpoint-ORIG-GUID: XGgXzuS8JxHYSjgIR97mjtZ1k14OF2Zz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=820 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2409110089

On 2024/9/11 00:01, Dan Williams wrote:
> Zijun Hu wrote:
> [..]
>>
>> do not known how you achieve it, perhaps, it is not simpler than
>> my below solution:
>>
>> finding a free switch cxl decoder with minimal ID
>> https://lore.kernel.org/all/20240905-fix_cxld-v2-1-51a520a709e4@quicinc.com/
>>
>> which has simple logic and also does not have any limitation related
>> to add/allocate/de-allocate a decoder.
>>
>> i am curious why not to consider this solution ?
> 
> Because it leaves region shutdown ordering bug in place.
> 
>>> 2/ search for decoders in their added order: done, device_find_child()
>>> guarantees this, although it is not obvious without reading the internals
>>> of device_add().
>>>
>>> 3/ regions are de-allocated from decoders in reverse decoder id order.
>>> This is not enforced, in fact it is impossible to enforce. Consider that
>>> any memory device can be removed at any time and may not be removed in
>>> the order in which the device allocated switch decoders in the topology.
>>>
>>
>> sorry, don't understand, could you take a example ?
>>
>> IMO, the simple change in question will always get a free decoder with
>> the minimal ID once 1/ is ensured regardless of de-allocation approach.
> 
> No, you are missing the fact that CXL hardware requires that decoders
> cannot be sparsely allocated. They must be allocated consecutively and
> in increasing address order.
> 
> Imagine a scenario with a switch port with three decoders,
> decoder{A,B,C} allocated to 3 respective regions region{A,B,C}.
> 
> If regionB is destroyed due to device removal that does not make
> decoderB free to be reallocated in hardware. The destruction of regionB
> requires regionC to be torn down first. As it stands the driver does not
> force regionC to shutdown and it falsely clears @decoderB->region making
> it appear free prematurely.
> 
> So, while regionB would be the next decoder to allocate after regionC is
> torn down, it is not a free decoder while decoderC and regionC have not been
> reclaimed.

understood it due to your detailed explanation. thank you Dan.


