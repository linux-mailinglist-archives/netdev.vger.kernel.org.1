Return-Path: <netdev+bounces-223329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFE9B58BC4
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 04:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B991BC31BB
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 02:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6C21A0712;
	Tue, 16 Sep 2025 02:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VkJhU7Aa"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8C01367
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 02:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757989017; cv=none; b=CSUXSIaeOumxqUJEpdWWl8dDg5ASulUyiillGzWHgr8LxaL/IgPrxrPSdXQc2ClhC20uRpv0llHqtyaLq3H+tSzgj30HiDd/xUa8tBPIglMp2cLZKYnu2/JixQ7Vix+9KuLF39CEA2dY902HLgZysHaO6/MvNyWl7OlNuYy0k3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757989017; c=relaxed/simple;
	bh=HQuoxTNbIGjELA/n6GJOLKhbzbs44U5TFVQKn+u51F0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UrPxvNLAnjVYgbReEIZXnc3GDCXvQdyRF1S96DzJZ5YN8GbzXCpwW5FClf/D11OOQAeWyF/s6Y00AFLJfcBuFpdIecfxpRJuEx+Pp4X8W1lMQ3YGzAao0oC7xW5fv7qn/ffmP1u0psO4xmIi/tEaMIQWMdiNtNyTL9V3rUiTQkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VkJhU7Aa; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <af23d217-4053-4a42-8f70-4e214f9623bf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757989013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6S3D96E1J/d1P4QcQftTAA0YEbKqtYTWzhCznEjnyl8=;
	b=VkJhU7Aagdff2T4PgYi8VcbNlqtHUPuUGwYJRSJxOj3skBqxrnIIq4axmOwyF56PpRXX88
	/GoyfIhLv+i8p4GVdBcnIEIqNrQndhtSKRKg6FogVy2pLzYy4h0oQdbbY0BBmIKPVlLp6X
	7AbmN7gRieM556o6ZI2S+E8MFIpJ8VI=
Date: Tue, 16 Sep 2025 10:16:42 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/3] bpftool: Add bpf_token show
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Chris Mason <clm@meta.com>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250723144442.1427943-1-chen.dylane@linux.dev>
 <20250913162643.879707-1-clm@meta.com>
 <CAEf4BzYDgkEwVo3T_jW2QtjXxCxYPxPMC-+46C12Us+9F2bOFg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4BzYDgkEwVo3T_jW2QtjXxCxYPxPMC-+46C12Us+9F2bOFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/9/16 00:21, Andrii Nakryiko 写道:

Hi Andrii, Chris,

> On Sat, Sep 13, 2025 at 10:18 AM Chris Mason <clm@meta.com> wrote:
>>
>> On Wed, 23 Jul 2025 22:44:40 +0800 Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> [ ... ]
>>
>>> diff --git a/tools/bpf/bpftool/token.c b/tools/bpf/bpftool/token.c
>>> new file mode 100644
>>> index 00000000000..6312e662a12
>>> --- /dev/null
>>> +++ b/tools/bpf/bpftool/token.c
>>> @@ -0,0 +1,225 @@
>>
>> [ ... ]
>>
>>> +
>>> +static char *get_delegate_value(const char *opts, const char *key)
>>> +{
>>> +     char *token, *rest, *ret = NULL;
>>> +     char *opts_copy = strdup(opts);
>>> +
>>> +     if (!opts_copy)
>>> +             return NULL;
>>> +
>>> +     for (token = strtok_r(opts_copy, ",", &rest); token;
>>> +                     token = strtok_r(NULL, ",", &rest)) {
>>> +             if (strncmp(token, key, strlen(key)) == 0 &&
>>> +                 token[strlen(key)] == '=') {
>>> +                     ret = token + strlen(key) + 1;
>>> +                     break;
>>> +             }
>>> +     }
>>> +     free(opts_copy);
>>> +
>>> +     return ret;
>>
>> The ret pointer is pointing inside opts_copy, but opts_copy gets freed
>> before returning?
> 
> Thanks for the bug report, Chris!
> 
> Tao, the fix probably should be something along the lines of:
> 
> ret = token + strlen(key) + 1 - opts_copy + opts;
> 
> to translate that pointer back into the original string? Can you
> please send a patch?
> 

Of course, i will fix it, thanks for the bug report.

>>
>> -chris
-- 
Best Regards
Tao Chen

