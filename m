Return-Path: <netdev+bounces-176626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E80F7A6B1FC
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 01:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2791319C3532
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 00:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E40B84A3E;
	Fri, 21 Mar 2025 00:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jo/gzIlR"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16E5757EA
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 00:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742515863; cv=none; b=Ww+r1JZ/1svrKz3esXOcJG9Pc4Gz+OVacooNlHqUpYEBMGQb0jyOSQj6KoDQM58YTUZaigcgzT8I38E1yF5oQwoSLUuqbesHL51vbjQptXEf9dk7EghvskHrGrZ/Mr0w4Mt5UkGRBLMPCRwchD1tc1as3McMn5ItSobumhc+qF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742515863; c=relaxed/simple;
	bh=vOaC/VeeCvo+vykGa1NWcE6zqeTdhHIJyDqLjfcpBlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J42B8kDTeiwGQkpobff4tMvI1oVH8J0DSAiRl0OKdpo8jFSE+VMmi9hD4QlswNqmMRRTIaj9F9BRTnWHI/mBJ6h7JBrY+0pJllW81397PVmPLUbLSm+uA87Q37BXfrjqvae8zsA1MOqsNsJjNj+NEEHGOti8N4x6LE67y9Lk1pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jo/gzIlR; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6d9c84a4-8603-4746-953c-838c674b94b3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742515858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WrvAznNdhcW3AAlhE/8kd+8BrxIbqCILhCTnt/Jwlis=;
	b=Jo/gzIlRX3+056pdhMVRNfPvQl1IBEOByzrKvyINWotNML30C79yxUr6x//yVb4e3qYOFA
	rvATwvvqy1ngNQRt9blcXOtKfVtaBBubAb/mhIS+plhwVFoMTpR2Eib5jqj2/OO47ZczHF
	LA/57SMY/F1nX58qpjZoGVsUtGMNXBA=
Date: Thu, 20 Mar 2025 17:10:51 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 01/11] bpf: Add struct_ops context information
 to struct bpf_prog_aux
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org,
 kuba@kernel.org, edumazet@google.com, xiyou.wangcong@gmail.com,
 jhs@mojatatu.com, sinquersw@gmail.com, toke@redhat.com,
 juntong.deng@outlook.com, jiri@resnulli.us, stfomichev@gmail.com,
 ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn,
 yepeilin.cs@gmail.com, kernel-team@meta.com
References: <20250319215358.2287371-1-ameryhung@gmail.com>
 <20250319215358.2287371-2-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250319215358.2287371-2-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/19/25 2:53 PM, Amery Hung wrote:
> From: Juntong Deng <juntong.deng@outlook.com>
> 
> This patch adds struct_ops context information to struct bpf_prog_aux.
> 
> This context information will be used in the kfunc filter.
> 
> Currently the added context information includes struct_ops member
> offset and a pointer to struct bpf_struct_ops.
> 
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> Acked-by: Alexei Starovoitov <ast@kernel.org>

Applied patch 1 since it is useful for other struct_ops. sched_ext is waiting 
for it.

Most of the bpf specific parts have already been landed. The discussion on other 
patches can continue in this thread for now.


