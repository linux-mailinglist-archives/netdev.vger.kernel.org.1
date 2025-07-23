Return-Path: <netdev+bounces-209322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C2FB0F074
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 12:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1BEA566A5D
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F021729B8DB;
	Wed, 23 Jul 2025 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S4Ucak01"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EC4285C89
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268150; cv=none; b=Tt1tknSBx7MNT8SCwm1h3f83qiFzf2XQXKjS6oDnObcRcNaIUozTboUGwKzv31M/9B0Odch1b2/S15GXgd/otuw33jOmnoOWQyRioTpMxXoN1ZcsUru9nEddoVEFGyN2vcPvXSy2oYUhIoYbIUk6rF1nc3/QpmERQj0QwbgzOn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268150; c=relaxed/simple;
	bh=m43EYY6q+XvOfeXV3GPp4XFcqABOWCC0aWg0XAAXamM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pupzaOLAmcsazW7oGoNSb9V84F+f3/ZqH2KO+vKwlJ3RSYo1mwzQ2gFpO3cVACKMKgQVf/nU5LTL0yOecNyMwAr4okTwybqdsb2mffnxANdZOUXEdJ97D0MKtW6QfgydUi5/3cTmtsg+2naJ7sZKSywT9GUOJpcFz3+r0/9IGM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S4Ucak01; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <393b7e0e-2240-49c5-9ff7-8efa07a11d3b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753268136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CYI4IOaiJ64Vf6dp+PDO/cqw+3AhfpJbd/gGnQR4Krs=;
	b=S4Ucak01dKys0gBZgwAJY0O/HeDXEdpglcJx9M10oPvLNUmZwQxFY9YeCJ21xWHJ9esC7k
	ZgWO0NhpOTWh7nOCsapziZDvN1pYsjnKm6a/2MHCihuxR07Y9uiMAjgSejnLMbu+fnCiP2
	WBQjgB5I5O1icPeJG4STrEioJ44ax3c=
Date: Wed, 23 Jul 2025 18:55:07 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/3] bpftool: Add bpf_token show
To: Quentin Monnet <qmo@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250723033107.1411154-1-chen.dylane@linux.dev>
 <1dd1a433-ecdf-437d-bc71-6d1b65b74cc8@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <1dd1a433-ecdf-437d-bc71-6d1b65b74cc8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/7/23 18:40, Quentin Monnet 写道:
> 2025-07-23 11:31 UTC+0800 ~ Tao Chen <chen.dylane@linux.dev>
>> Add `bpftool token show` command to get token info
>> from bpffs in /proc/mounts.
>>
>> Example plain output for `token show`:
>> token_info  /sys/fs/bpf/token
>> 	allowed_cmds:
>> 	  map_create          prog_load
>> 	allowed_maps:
>> 	allowed_progs:
>> 	  kprobe
>> 	allowed_attachs:
>> 	  xdp
>> token_info  /sys/fs/bpf/token2
>> 	allowed_cmds:
>> 	  map_create          prog_load
>> 	allowed_maps:
>> 	allowed_progs:
>> 	  kprobe
>> 	allowed_attachs:
>> 	  xdp
>>
>> Example json output for `token show`:
>> [{
>> 	"token_info": "/sys/fs/bpf/token",
>> 	"allowed_cmds": ["map_create", "prog_load"],
>> 	"allowed_maps": [],
>> 	"allowed_progs": ["kprobe"],
>> 	"allowed_attachs": ["xdp"]
>> }, {
>> 	"token_info": "/sys/fs/bpf/token2",
>> 	"allowed_cmds": ["map_create", "prog_load"],
>> 	"allowed_maps": [],
>> 	"allowed_progs": ["kprobe"],
>> 	"allowed_attachs": ["xdp"]
>> }]
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
> 
> [...]
> 
>> diff --git a/tools/bpf/bpftool/token.c b/tools/bpf/bpftool/token.c
>> new file mode 100644
>> index 00000000000..06b56ea40b8
>> --- /dev/null
>> +++ b/tools/bpf/bpftool/token.c
> 
> [...]
> 
>> +static int do_help(int argc, char **argv)
>> +{
>> +	if (json_output) {
>> +		jsonw_null(json_wtr);
>> +		return 0;
>> +	}
>> +
>> +	fprintf(stderr,
>> +		"Usage: %1$s %2$s { show | list }\n"
>> +		"	%1$s %2$s help\n"
> 
> 
> One more nit: applying and testing the help message locally, I noticed
> that the alignement is not correct:
> 
>      $ ./bpftool token help
>      Usage: bpftool token { show | list }
>              bpftool token help
> 
> The two "bpftool" should be aligned. This is because you use a tab for
> indent on the "help" line. Can you please replace it with spaces to fix
> indentation, and remain consistent with what other files do?
> 

Thanks for your testing, i will fix it, thanks again.

> After that change, you can add:
> 
>      Reviewed-by: Quentin Monnet <qmo@kernel.org>


-- 
Best Regards
Tao Chen

