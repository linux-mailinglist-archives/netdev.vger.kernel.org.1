Return-Path: <netdev+bounces-265666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADQOGGwFr2knLwIAu9opvQ
	(envelope-from <netdev+bounces-265666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:37:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B17D423DB96
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58A27300850D
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 17:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8062C11D5;
	Mon,  9 Mar 2026 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="iWg1g/um"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E5B3C1970
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773077864; cv=none; b=nj8/0lZo0JlRoIQwQl4FUbj1/BeCKfTwoepuwiQpLCp2UzCEBsFOKpHJ/qxAIYo4mEby4t/2HOyDpDukbwltB1BlEPRa5Qc1icMTlJ9WHt8B6cPSmbsRXx62elYbmqR0us3lAChQk3lsHl4GVYqlIaI2e7IXjbiu0NUpm6pmzno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773077864; c=relaxed/simple;
	bh=ysL0+edsEeHwORWLhMDT+N4iqIQ5jciud+DCRLHgnOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WNLmtyz9XgseoFddkRWQyHgJsrlgFIiLVX4tOvk+zSRHFlqNuHfKCC1YfAg4LoLh6x3OdOSJp5v0Cko7oJb6ZdLjiccbE8H+HTypREPOtNAmHWyoDSaqoldKvfof7NSTpARmG2xd56r+93KE1NTXrwvuUUqTFRzsXtzLAMuBnhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=iWg1g/um; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5ffc6a96665so1322161137.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 10:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773077859; x=1773682659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W27N/znVmIDSI8tzJ4IRCYxWcWYYknXf+V7AqJORcfk=;
        b=iWg1g/umiyF2fFuozSpkaW1uV/k9hqmO61A22Pttgp1UD60vbz6oO/WbQpNZyClDdx
         CYRuGxnJerx3YSmof6xL7I3Om51aFUc9b15jlCdeIR/XpJAe6oKo35RFlg01A7Tu30wU
         ZAVRFH0aXZtcVvw4r1lWclseU1S7lSHuqmiMu38wxvvj88CotDTIX0SQ8TYJ6GLd8uGt
         kH5wfZZK6O1SPcN5G9RY9dfz0nCp/GCGm1DFHYVweot+2I/noJYSjutWCIJwQrMyJ3vM
         veYMD7fCfZCD7lDXpib5377WDHDs2olTo0xPpRb7ljQUdvXyxVW/5A5EuXgNFK2yInZ0
         zZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773077859; x=1773682659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W27N/znVmIDSI8tzJ4IRCYxWcWYYknXf+V7AqJORcfk=;
        b=SqQ7StLf3YK9MaFoW5h9oD407BLTeO6mTfARWvFiFH3etqN2t51A6f3TqsJ8Z/0JD7
         lKUuwFxsb6HXRcOUfE2HUkyx5s2TqU9KCysjPeqYIoOqoiwOiD2D5/VEGG8v3YTL0J48
         V5ArstG5plc/Cb9K0c7bwKwRWfAiBzVfqRBuZ36VHt4Jpv0lTjk1syJnoQ1NS4QK5CJO
         oPLtOVlaOE2/t4/ERvJkE1mo9+vrWOFdSFE/O8LOmwDdlqEB+1PF/d65mzJHSBT2pyo8
         J5essTAzfQCFljbVQgB5RWZ7iyhUtVK9VBotinUtlT1aYeSZ2XnmnHQ3eR7+f0dhpJH8
         mUfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTwp17AjZ7Dxj6yPDQ1vUxF9w+sBXDpDc0BZyjRYaiY+T46bVZgyy3OG/l+zyBjAFrnPpPkDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhnDDtrI6i58IZKeDvCLKWwnS1Ek9T8PL3To/Sb0aS+/hJs3xZ
	vdk58HaLAaHY1BtvSeN0zYfVfMtp5ZfNFTYrAl7yRr0gEG/IRsOHPBf39CdyL3IZiQ==
X-Gm-Gg: ATEYQzyFYYDqacgdAyhb5kRzXmzEELf79qlK5yvVeDQLDPPA0JApjX9kuwRHQbv3je/
	NT6m9DRyuL/hgGgMvjDMMTbl6W79x2AuimrLjsfMSWfrd45tNWqXJHV53WuIH9MswKVG7lAQM3X
	/3tqJvqQF6yWXvlFhtRt9cuKm81FRCJWEskWl5uY+nDdgxxwglP9/pQVadQIdxQIlYXyhKIwtL2
	mf1qrnQxqfz2OHZJGvCy7HWQs/zFqCBe33JF5oRX/wK6d2ndou/hFAk/+7KEB12ULe0CqJJrFK1
	uwEaMAN7v3PQC6UyXoLABvMGNghvXJc1PD7VV2kv3ovroQliG/fy987Ww6Cu7vkQPQB0BHhvZ7w
	2PVLlE5aH98qDyaFf2UnKaopt7pKgO2YgQ4KlrI15p1B6/MuxD8pCySRK7zJz6w+lWnG0keQ5Lb
	2tX2K0kT8dVM+O5q0gwEIyXjORVPxXLZM=
X-Received: by 2002:a67:f343:0:b0:5ff:eae7:bd5d with SMTP id ada2fe7eead31-5ffeae7c791mr3068946137.22.1773077859249;
        Mon, 09 Mar 2026 10:37:39 -0700 (PDT)
Received: from [192.168.50.25] ([179.218.14.134])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94e7b12e0a6sm9050337241.0.2026.03.09.10.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 10:37:39 -0700 (PDT)
Message-ID: <e9487cc0-38d2-4080-8633-60b0f2a61ca5@mojatatu.com>
Date: Mon, 9 Mar 2026 14:37:33 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/sched: refine indirect call mitigation in
 tc_wrapper.h
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Victor Noguiera <victor@mojatatu.com>,
 Pedro Tammela <pctammela@mojatatu.ai>
References: <20260307133601.3863071-1-edumazet@google.com>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20260307133601.3863071-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B17D423DB96
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,mojatatu.ai];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265666-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pctammela@mojatatu.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mojatatu.com:mid,mojatatu.com:email,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Action: no action

On 07/03/2026 10:36, Eric Dumazet wrote:
> Some modern cpus disable X86_FEATURE_RETPOLINE feature,
> even if a direct call can still be beneficial.
> 
> Even when IBRS is present, an indirect call is more expensive
> than a direct one:
> 
> Direct Calls:
>    Compilers can perform powerful optimizations like inlining,
>    where the function body is directly inserted at the call site,
>    eliminating call overhead entirely.
> 
> Indirect Calls:
>    Inlining is much harder, if not impossible, because the compiler
>    doesn't know the target function at compile time.
>    Techniques like Indirect Call Promotion can help by using
>    profile-guided optimization to turn frequently taken indirect calls
>    into conditional direct calls, but they still add complexity
>    and potential overhead compared to a truly direct call.
> 
> In this patch, I split tc_skip_wrapper in two different
> static keys, one for tc_act() (tc_skip_wrapper_act)
> and one for tc_classify() (tc_skip_wrapper_cls).
> 
> Then I enable the tc_skip_wrapper_cls only if the count
> of builtin classifiers is above one.
> 
> I enable tc_skip_wrapper_act only it the count of builtin
> actions is above one.
> 
> In our production kernels, we only have CONFIG_NET_CLS_BPF=y
> and CONFIG_NET_ACT_BPF=y. Other are modules or are not compiled.
> 
> Tested on AMD Turin cpus, cls_bpf_classify() cost went
> from 1% down to 0.18 %, and FDO will be able to inline
> it in tcf_classify() for further gains.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>

