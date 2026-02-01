Return-Path: <netdev+bounces-255683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAigHHHTf2mjyAIAu9opvQ
	(envelope-from <netdev+bounces-255683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 23:28:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D6124C762F
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 23:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F7C130048D3
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 22:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EE12EC541;
	Sun,  1 Feb 2026 22:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="HoawHfqy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18055242D72
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 22:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769984876; cv=none; b=omFhC+ZGTGiiEkq0PkEebpx25IA7kMsRlsv+qk+czs5gCYEI4J21doEljg3qffAeFqh3YzV+DBaGfwQmkNNhuG5hxJ/QOP1+wQ5RWkIfoIglAk/1VCeGb81FJOT9uAqWzJgfbGSOW7gfJI7hJbuWM36BBN2fn8qaTLDJUEdtq4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769984876; c=relaxed/simple;
	bh=uJhyolSrtatUAw+mRvmMrPYyuUryi2DApKK8xUiXypo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+LN/+3GuN8rEyRTkCYy3ukhVY3jFL50qwxPjpdgZNLQGUbNW6I1fYy8GB8BfNig902xY3HOvHOf1G3hDmxodvPb+R3BgoWp/wTh2JsFPDnHphvSR3u2W+PF583BgWdYK+slDD6SQ2XUJEtFq/qwrL7pg0Sn6Y4TUSdolh6k9k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=HoawHfqy; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-81ecbdfdcebso1991450b3a.1
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 14:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1769984874; x=1770589674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GhOlhcxP38dJ2XGmh4H+Vv+ro6H1PQ0GligsQ8SN3e8=;
        b=HoawHfqym+XoPz4KshhIXbvSkyyze2SYPzUYtb9t4QYDS0N5gjgyS7+mv3VmP6XfUp
         5XsRt5y6U6hIsd+PD0EAGo0XnvvKbK9pmx9p8pG7UOkcl0QRb/2O+BgQPGBkoCySRNlu
         XTYHelGjULmFSYc88Sfm7u+kOLl1FGpjtClT2uUHoPYavX22YAUdtEnOxpUtjvpfhMnV
         lknugjm/B+dW5I1R5tFBJJ+/2E+fPm3LpUbXsbodFpAX3GXiCFHb6+tWLX1Db/e9OAlQ
         WabCOR0NvbzBxpskDC0idOXTHFYCZC4vJzWHMCj7/wulPsbmmnFbvY9qvHekqbaFCzz0
         M1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769984874; x=1770589674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GhOlhcxP38dJ2XGmh4H+Vv+ro6H1PQ0GligsQ8SN3e8=;
        b=WEEyBKHhS83afhB/26vrjRopQQF4ru1wsn8zETgtYDI2ZJzf5UXNtx9egglLOC4GAh
         J6/pBVKTDhtXiuJZYr+FZ2GMUgsys6le8wIwYXbUPKee0wPAWj7bGsjRHljKnwzyScOy
         OHIIRYT5b7VxLRfhmuyIm3bvdnWrBAQ3084+Nhp5u3UqLjCUndrxoBn5RKExN5m91w1j
         1kzRf/9SAZZmTQjKu4ONSLqYoMd84BuTYrhD4gFgPCZMpS8PmxlooDVJKcFtVq3ZTbYx
         nq5ZrFTwQbFkur1YBuw8QD4E4jgA2NQ8opKUcLaKX2H/miNRjGrVvPCqwUf/9xIecLQa
         V1XA==
X-Gm-Message-State: AOJu0Yx57wag1SvhZC5quT/V4mwQYsLZUcg498eDH4tvWrsE/N370QzL
	61hv+QWICtVWfEQEyH6t8qFhzKGCEzEdEqOfEgwGELdCZ30t5sgYAYxVJHzrkHNqaC0=
X-Gm-Gg: AZuq6aIM09NcYyl3pNILqhbS4u9ySdziy0uREcITVzxjSlC/MFmyHhGxMVaidKLFBsB
	4dn3c4jLBzL4tkjb8VZktWWUeKO29suJ8k/nf8Ww8MJJHhRgS9ohzqBYtkgkSxz7esSvv4ioLdQ
	1la1KmYC+PNnftxF8xsHg7TpTucLdnFU+Vr6OJOTQNOpkLG3vy84QESZUfR6HuIphhCt9lu1/+E
	5jgoB+E+f5Z6uWyujtyxxZ+muMf3U24jBSPtDN9RV91x4+DuV2hf6Ps5i4gQi07CAYA0EXCei4t
	BPn2uGohQsG7QKkMZgjWA/zgdqxzhgTF4Z7EYMz3CIDoe2fynu+ZXVvg7nh6yAvYJcOfiLV4SdW
	1ZeIV+ZgJ/50UB8/vzK700sjV5Q9aFVuea9+JghXRvvbJmXCzeLuLDdZX2IWCiurB6jZ2UEdbm/
	d0wdXFK7k7ajk0X0gPtQGMGps3nqIasnwnH3AIPqHyUnvsWXyOMRcLGpn2BuTd4o+r5TOiEzQJD
	9dMKAlZa5Qqp2J6Qw==
X-Received: by 2002:a05:6a00:438b:b0:823:1580:790e with SMTP id d2e1a72fcca58-823ab86cff2mr8898074b3a.56.1769984874525;
        Sun, 01 Feb 2026 14:27:54 -0800 (PST)
Received: from [192.168.100.174] (p94025-ipoefx.ipoe.ocn.ne.jp. [153.246.129.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b1bc68sm13786528b3a.2.2026.02.01.14.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 14:27:53 -0800 (PST)
Message-ID: <7ef5474a-f5d6-4afd-995d-16ecbfe00fa3@davidwei.uk>
Date: Mon, 2 Feb 2026 07:27:48 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 11/16] netkit: Implement rtnl_link_ops->alloc
 and ndo_queue_create
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260129222830.439687-1-daniel@iogearbox.net>
 <20260129222830.439687-12-daniel@iogearbox.net>
 <20260131161903.064b5cb2@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260131161903.064b5cb2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-255683-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[davidwei.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,kernel.org,jrife.io,intel.com,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[davidwei-uk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davidwei.uk:mid,davidwei-uk.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D6124C762F
X-Rspamd-Action: no action

On 2026-02-01 09:19, Jakub Kicinski wrote:
> On Thu, 29 Jan 2026 23:28:25 +0100 Daniel Borkmann wrote:
>> +	if (netif_running(dev))
>> +		netif_carrier_off(dev);
>> +	err = netif_set_real_num_rx_queues(dev, rxq_count_new);
>> +	if (netif_running(dev))
>> +		netif_carrier_on(dev);
> 
> Why do we need to flap the carrier?
> (If there's a reason perhaps add a comment?)

I saw veth doing this in veth_set_channels(): off, set num rx queues,
then on. But it doesn't sound like there's actually a need? I'll test
without this and remove it if everything works.

