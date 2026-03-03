Return-Path: <netdev+bounces-262982-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIR6FvI8pmmpMwAAu9opvQ
	(envelope-from <netdev+bounces-262982-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 02:44:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D051E7C72
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 02:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8511C3031ACA
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 01:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AEE373C1B;
	Tue,  3 Mar 2026 01:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="E0FCl9Cw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A77F34888F
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 01:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772502255; cv=none; b=d6VAmwao4YGTZs7Rm/TliMHr6/fygIkvT8PL1TKSYrtUHS5xbJJKOneRnaLqomHWVWwitiHzI61909Wte5KjqPv4sUjNVw91Pehp8e+W7hikxdzB6w47cCZj36aIEjDhCUDXQetYXgrTXJS4m2lQXYndi0JCXzKl+P8Mx+AwOuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772502255; c=relaxed/simple;
	bh=h46P7kVUyNdq5URjNM7EixZSnrIt8YE4XHi7HyMCXnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=saW/5v9C6ZitGK3YMIeMTZNsRpKO9YpOV7whAcPsOc3GqQ//u2YuROEROIjLFAF0KeOvhERMSBD0j3Qq2hlFQxm/LhFWsDdp5m7031nInEg7Uu3ba5ovquOGHorpM6rutqVp8mTZkZovG4nxyUkOdNJpQjjxaz9sjKeQeFyYj+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=E0FCl9Cw; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cb513e860cso535056785a.2
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 17:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1772502253; x=1773107053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d/ou1XtFi0XNZ0AZfXj8pwsiuakW+AHiGBQcTnvVDfo=;
        b=E0FCl9CwILuog3RkjUFNZm+jufvwAiXS46HmRHwT3bteM0zc7JtykMuswjf36aRYSM
         D4mzTpfbeOGr8WTtlKShpE6nvhVqnolymZwpkqUrTD2Yor8R4Po4MuhvMH+qYQvZNmET
         wlOTw/o1J1bh5wE6qh9wP6Lb56M4I1ATDsIhji462hXtAW42H0Dmbh5CQp6IthAT3KS2
         FMLchPAg8/yyIPcdkitTM4AhH9rYZ7dB2Xvo3hNtgSpFpkbcIQWF4eKHfSSyP8lzBUUO
         ux2nmRRrSQ0v9MvuTUjPn6FASsPsnFsoJhW18mGyLI3azHOvZQGrzJGaMrH5q/ZBw0ed
         atjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772502253; x=1773107053;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/ou1XtFi0XNZ0AZfXj8pwsiuakW+AHiGBQcTnvVDfo=;
        b=pRDeMsM9uUQAp/L+Lbc4/PJifX8/9CEnr6v7Q1L3Ie1zcScWmQTfJqgyDtngz0zkgQ
         zkvrBpFpke83ci3Ks36dA3AY21WvEKCHKmsIZ7dGg1ixZEeJmoL9ruQwyxAxBJ3xOblA
         zw59nKlBi8s/2xMIhfq/1RcY6dk9awKBlX4DKOKKctANQm5Zbdrrx975p69PDAd0VTZq
         g35JSBKt540RiI09DH+WpokhhqR9IJTcp4tPJ6jNvwO9N2t4brbMdWsS1PhBZwAdFQL0
         jk5aIoaqOjSuacmwBNo+eXGPEOIcfPW9Z8LGdVNoJ5pdkQNDOPILMf8885U7eKkIb/kS
         b+nA==
X-Forwarded-Encrypted: i=1; AJvYcCWaDHqXcqVin5uy5FouvvaYK/l/D8lJ6W2++gEOgR4xnNC3utP61zrzGO/lfHR6i8l1qoDshvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuMrpUDNHq3Su3sHK4cYNMwdXfB0liK9jK7hzr3u5686r/Jbke
	gR+Mw9uTLLeZY5+5spBcaXZmFDNZ2Bhtn/aGfcy/RxvnsqCBLUZZNkrK5Ywk9eaywEw=
X-Gm-Gg: ATEYQzzf1z2wusXHQIuroy2TdUbWWanuYR4Gi6KuYonDHDwJQEcluKSPCC+h1tLbUuU
	D88e7pFSFkG98JJealOsquVNMDRa1wBrEBH/A6xxeTWaCyLNsADnp9bhpFXhvC5lEOtrLa+3yHg
	etbW7OtHRtORiX7IZUg1+VoVFViUrlrvqlCT8LGhsegouxQTMKSkzTijagA+yTBy8SMMQDKarZP
	4dPhyXciVnTtKNQIAHfzKXVmw/wAsgfyFf0R+lr0Ik10tT5jjK9qPdEkZPVUpUX7AfhSrhXKF18
	v9ZNUJoaeWrrUSQbmEc8GCUUfFcfi2M/c7K5b9QkgQzTD2c7Z4EUUn2+fAiF6FsrvvHtRxtN4wW
	QS3c4ODjSMFmkTmZHPghqNhpN+1Akjc8JLv0POIyR21W1IjQykmt7e76OgADwUsetsKjy1DOXRJ
	AUOXS3OMxx0UCh7Fr/wP83f58nK7Jm/5oCUyEnkOIeQ+W+MJWtMGSa+cx08HYNF634+Q==
X-Received: by 2002:a05:620a:1905:b0:8b2:f191:2b3a with SMTP id af79cd13be357-8cbc8e03cf8mr1850497285a.53.1772502253009;
        Mon, 02 Mar 2026 17:44:13 -0800 (PST)
Received: from [192.168.86.87] ([136.27.45.11])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6541f1sm1260110085a.3.2026.03.02.17.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 17:44:12 -0800 (PST)
Message-ID: <0bc2e2a0-b11c-487c-b663-ea62535e3f78@davidwei.uk>
Date: Mon, 2 Mar 2026 17:44:11 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] selftests: drv-net: iou-zcrx: rework large
 chunks test to use common setup
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 asml.silence@gmail.com, io-uring@vger.kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260227171305.2848240-1-kuba@kernel.org>
 <20260227171305.2848240-3-kuba@kernel.org>
 <90cfcf06-e987-4817-acba-2037a436a744@davidwei.uk>
 <20260302164816.1df2e32c@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260302164816.1df2e32c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C0D051E7C72
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262982-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[davidwei.uk];
	DKIM_TRACE(0.00)[davidwei-uk.20230601.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,davidwei-uk.20230601.gappssmtp.com:dkim]
X-Rspamd-Action: no action

On 2026-03-02 16:48, Jakub Kicinski wrote:
> On Mon, 2 Mar 2026 07:54:28 -0800 David Wei wrote:
>> Let's use ksft_variants() with both single() and rss()?
> 
> Woohai? I intentionally chose to only test one, buffer configuration
> and flow steering are quite orthogonal. What extra coverage do you have
> in mind by asking for both?

Mostly paranoia, in case there are any unexpected differences with RSS
vs single queue. Someone wrote the lovely ksft_variants code, why not
use it? :P

I should send the patch that actually adds pthreads to the iou-zcrx.c
test binary...

(I don't feel strongly either way. Whatever you prefer.)

