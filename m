Return-Path: <netdev+bounces-255685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2M2SHLTZf2mJygIAu9opvQ
	(envelope-from <netdev+bounces-255685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 23:54:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5720C7750
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 23:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79B1530053CA
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 22:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35DC2ECE97;
	Sun,  1 Feb 2026 22:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="br7q7Dsc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9B22580D1
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 22:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769986479; cv=none; b=SxN7UWxvjri4U56nrTgYKi+Vm6DubPndUXb1Z8xaRAi4pJBpTnhkL6YY1c0z08igLtm4yqVg9EoPKAnfbHBoD3p9IA3wPmZRXxkAY9GjH9IhlCBjC08Zfg1WM9m0UtrwtH+2phpdhXw0WbdjHGOhc4tDI4Gbt48vmEcoXsJyyNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769986479; c=relaxed/simple;
	bh=h+GpOYR5Bgm8Qm5oFwKf8BpUMmb8W/5/khQY5yPladE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cc/41mvFfXnkCia+58ryrYdi2udShOzDT8PMEJVs2kRH6tbK0EFO97lqVx48phdpubRPIvUIHWdozjICeTKXFy5RV1MOSBfOB2pf//znAu54Bm0aCDFZZvTu3YI77YlYsywDyiwvhFitosGqMLw/88O2zW7PiucK+BVutVBJpDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=br7q7Dsc; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-823210d1d8eso1891046b3a.1
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 14:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1769986478; x=1770591278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/8Sqabui1WaQIPpj7PzlekdVT08tCINJf1sIn5iJIEE=;
        b=br7q7Dsca6DYtCi6ypvs9XuuhoR9T8uQqTEtOR6A7QIjLNBBW8i+7hZi0nubM6Oj3F
         A4vtxo/eKVTbJjU0r9XSSc/oRRViP+d49ZPx3vI6w7KCiUMHeQOQG/tw7UwJHmPaJxNV
         Hs5Ort0aYSgT44Yr7nD5xtZ2HulCynqyHfFktGiPIH5aIZ46AUDPxyYyJuyvDjT84Edh
         ASBAytVE+amWYXrnHgebv4vq63M+Pn4XHiA1IgoKFcKLOpU0k22OiX8xFZQBbQsudgWN
         Xu9xM3Hbcc7xrp9jFN6sxWRNTFZELSA3aIib6XpQfUhPNAvaYXcjaTzDGr/dmLgyvNgD
         T6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769986478; x=1770591278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8Sqabui1WaQIPpj7PzlekdVT08tCINJf1sIn5iJIEE=;
        b=p5LnwFfCxdGNZ+JlHDitApBmXp9QNRAUkk0GSPZTxacW9S/7r5ZeHFf/KGhLFd+t8G
         knQULeHhyOLdS04F6ubtYkPpu2fjmpE3ZCJACYLnnFcQv1VWGuOTvurIpojIf56I30b6
         8VYAw8p5vISPPWBEdpGdnd9c4eT2SKIPoLjUfEhQiD30TBgplL052r+yo+g2IPk6Yu9f
         uEMZUtRc3x7V6hUA/DHCxkh/IkX/rCKCCYCU72yKvUPSx/+Iu0KcKtw8qP8TM8UI5DcD
         c9Bq+MJ9yHE9m8ZCJ6rgKpk7nILAL/KpnhPST5v+6ehRyFLP/3aGbvawMPoVcgtuEHLx
         C8fw==
X-Gm-Message-State: AOJu0Yx+LVZQYSEbw+OhDJNTDukAUKQMkQ/6iyZgg8c3I+uENCgp+EEm
	G/xSixO3H175vH5d6l2B2UtQbHBBnnnvGsui6NBlR4aerYyM4fRCbDUzjQS7UXgtkt8=
X-Gm-Gg: AZuq6aLbELDRdwA3EckrVO33JeHwtj0qZr2HBxaN/8/cwjkhRGfD+oHxVaKc5oirlbC
	YU+qW5zWdh8rF7d0H2U/qTFj5GMBtCdghEMIX9wCnViwNHJQIdxJY2Q/Z/SCgkr6+p6BRJ7YPO3
	RILDYMvBPGALkQ6SN86AoIQFpbcHa5R6ALUXp4lFo0u7SAlgA/EjBEd6moKDZbpyQ2nRSAVrVzk
	tSxgHnpNyPUituhSCbWppgGqA3EIAprBPh8EdA5wcWOA1iYDtEVueljiMpQ4sbS9+dj4OIhe0bW
	7vRg1Pk2XOc8mCXum2Ot68e1h023/Jz0ETcwtKnDxByLuLbZJEQuhoiTWeUNg1gntBa9jRSNN8Y
	zxad1RcnmN5FAGnLI3MVA+gsMubqX/6wa3lQZ0LIVffcY8Tdje13pH8YKxuhX5VSrKGCM0JTxOF
	34UYUdAM3yyRObi6Mf7JwdtCjAgqQNYKdGurWISHrIlCMRJAyxA+kn6LEu+SkTxV9BV4Rc21N2m
	RC7UeYbek492YUOwg==
X-Received: by 2002:a05:6a00:bd03:b0:81f:be3c:8a24 with SMTP id d2e1a72fcca58-823aa6ec4e2mr8638004b3a.36.1769986477775;
        Sun, 01 Feb 2026 14:54:37 -0800 (PST)
Received: from [192.168.100.174] (p94025-ipoefx.ipoe.ocn.ne.jp. [153.246.129.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfd729sm13164495b3a.44.2026.02.01.14.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 14:54:37 -0800 (PST)
Message-ID: <d7490f71-72ac-4c50-b848-c3d366e67a80@davidwei.uk>
Date: Mon, 2 Feb 2026 07:54:34 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 16/16] selftests/net: Add netkit container
 tests
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260129222830.439687-1-daniel@iogearbox.net>
 <20260129222830.439687-17-daniel@iogearbox.net>
 <20260131162427.741b8085@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260131162427.741b8085@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-255685-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[davidwei.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,kernel.org,jrife.io,intel.com,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[davidwei-uk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davidwei-uk.20230601.gappssmtp.com:dkim,davidwei.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C5720C7750
X-Rspamd-Action: no action

On 2026-02-01 09:24, Jakub Kicinski wrote:
> On Thu, 29 Jan 2026 23:28:30 +0100 Daniel Borkmann wrote:
>> Add two tests using NetDrvContEnv. One basic test that sets up a netkit
>> pair, with one end in a netns. Use LOCAL_PREFIX_V6 and nk_forward BPF
>> program to ping from a remote host to the netkit in netns.
>>
>> Second is a selftest for netkit queue leasing, using io_uring zero copy
>> test binary inside of a netns with netkit. This checks that memory
>> providers can be bound against virtual queues in a netkit within a
>> netns that are leasing from a physical netdev in the default netns.
> 
> We should cover the uAPI and the tricky part of the handling please.
> 
> So off the top of my head main bits:
>   - the expected attributes on lessor and lessee via Netlink
>   - destroying the netkit with MP attached
>     - checking the state via YNL,
>     - attaching MP from the main dev to make sure we didn't leave
>       anything behind
>   - destroying phys dev while netkit exists (prolly netdevsim :S)
>   - making sure XDP can't be attached on phys dev when MP is installed
>     via netkit
> 
> ... whatever else you found to be tricky in the implementation.

Sounds good. I'll add these test cases and more.

