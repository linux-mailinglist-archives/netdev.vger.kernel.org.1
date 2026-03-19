Return-Path: <netdev+bounces-269654-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFN1FwJlvGlLyAIAu9opvQ
	(envelope-from <netdev+bounces-269654-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:05:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6175F2D27B8
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C1C06300B52D
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF29E3AD513;
	Thu, 19 Mar 2026 21:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="WOA/IYyj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7AC3A901D
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773954298; cv=none; b=ou1CxKy1cWX3aSFMUQ0Kq4d6kgtt8Hd1D+uNcnoEh+ApowPb8CYI4D4ORdBYIX65WwEuMHML5OrgRkF0rm6l6zUZZ6JRoJ1w86NpmDlO6I+/j2+HZM5Yco7HAxXiY0w2cMPnRXhU0SBgMdE5wktXH7H4wPGIlCEfMk7/VKzfLTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773954298; c=relaxed/simple;
	bh=VXEe2Wt/BPF56RchrCbVXYGHSz5WUuP8r2Urg254hMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PiFFnmbmL2/2h00qBRZ8ua+4msPoVn99DErvV4uRz9+cJbollIANanjgBx1FPpgIwMfdkLjaqNNiPUPZ09ZT1sCr5nCislnvZxVwY1qX6MOgeUP3TnvcxxudqUfBzuMZZpCLwODUNbXNMD3CWei+EGgNM24fI8FYWp3pGIHLl8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=WOA/IYyj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso10337145e9.3
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 14:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1773954294; x=1774559094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MtZVxPVUHMGFu9xactQ6Dfd4M1+RdF64jSWwvCrOk2A=;
        b=WOA/IYyjyr86qlZi+8Vv40vXJrF11gFZT7SUTAZcrIUZ0VFEnMXR4jrgBZjGTGmXOP
         StQuoEpWChRGPsrGILwGH9N0r0Xyr6zBBvoagLdpE7wsbH0CK7XTj6r9CLKanTr+BL13
         uO39vxsd3qVBdhXtmQu4ZHXDhnnVBVy+4ojvIEySyeZi6UxkJlmBXRWCGjQJvQDGxtQa
         sTnlth+Mg2cI0Y1QNrruZr6nNiKoDmUpc7+7GE0jlytnGVzjcwQGORbNRNc9AmEIk+xU
         +koB6Ld1UqpjjYHsU3dbLHckUtDFESJdQM4EMdZuCmEaGhTvvtDKtP/mYTRmAGRtMJfd
         ToTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773954294; x=1774559094;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtZVxPVUHMGFu9xactQ6Dfd4M1+RdF64jSWwvCrOk2A=;
        b=j/4Uex3brFihSNBtGyzlONQrgWwyaUFKXpWZ+ptr/69U9mKHeuPPfCDZuZFEDF2SG9
         qYk1sUevxwziIEgxJ0D1x5EhxtPnL7pmhADMY9k5sRml+s5xgL6uJyarnmt3V1B0TtYd
         kvRmDRppx3/7GT3ppaZQAyTGfH+lKKhr7S6IEm/JXyNO/tJ7Qk6zfYO+z0eJRH9mp4BW
         BJRkW257gsRVI14o+tfwfukYaR26wp794BRnUgmOwBg66gHSlDfaDfAiZasGov9hr1I2
         v3PCDaTevmiIon8jsJpAFKcXbmF0WpKtrVMYZFK4V5LaoREFaf3pPehkc4aezSESk2aA
         HGKQ==
X-Gm-Message-State: AOJu0YxuSTmK2qopGaeqULSH1L2oo36cwAvgzlRaHSt1OvGGIz8AHBlv
	ei3O0DFUpfZX4GWjCBR9fuG9LDKmZG88zlzeHU6AH3tPvwKKsWnSVcOBid4mYG9CXiZlbWM9D/S
	jggW4yZf/VWhtWtahIWlfFqjU20BY1smLlFyCuyL1kQuxDRf7Z/Y=
X-Gm-Gg: ATEYQzxRMEUOJozqwT0HleN5+j+0VhGauUpTWi4TeeruKRu1Ui3yHv8PVIWo9btNkUR
	Xyq/TadyGQz9nN3BbHFC5SQQ1jynn5IKr8EXWS+5MCR7+jeKCnjoL7siFI/JCo4wigBjGFd/CZ/
	6D9uI9F8T46oxPZHVLa/9ED3mBzNd8xJE1qwoAh3kH9JNfcw7cuCHfw3a4OEPaRWEVKDmVr5f+a
	FWNWgAC+eeRV6LsX4QVOaWYzqup5qF9zjS4bcZ5obp/X61at9bPAWJ8cpOCB9jEvzhGo0reywmc
	YTyufbX7EWabGxGsCqYV+aLW62yItkyFoQj/AkO5Q1RcsVnY9NIFQIhMAY0Yz7Fl+DM82THXNUt
	3Rb6ozHVheBsEeETWZqIg5W0l2ni0M83PSaKtbCinh8waKhkB/6GwE3WPOLwZ+YXieMSAsejPRw
	a/KQ+hLfXiatCjt3zPGhOicF2umtIiTGTQrzJ4wce88f6/T+Towr03M8G/hlq3Kg==
X-Received: by 2002:a05:600c:1f86:b0:485:17a7:b9c7 with SMTP id 5b1f17b1804b1-486fedb551dmr8971255e9.10.1773954293892;
        Thu, 19 Mar 2026 14:04:53 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:f893:3da0:4a19:6a42? ([2001:67c:2fbc:1:f893:3da0:4a19:6a42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8b949e1sm155536515e9.9.2026.03.19.14.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 14:04:53 -0700 (PDT)
Message-ID: <3c0acfe0-e5f3-4290-90e1-ebbcc99d8d77@openvpn.net>
Date: Thu, 19 Mar 2026 22:04:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/9] pull request: ovpn 2026-03-17
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, ralf@mandelbit.com,
 Sabrina Dubroca <sd@queasysnail.net>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
References: <20260317104023.192548-1-antonio@openvpn.net>
 <20260319124432.2fda076a@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20260319124432.2fda076a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-269654-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6175F2D27B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 19/03/2026 20:44, Jakub Kicinski wrote:
> On Tue, 17 Mar 2026 11:40:14 +0100 Antonio Quartulli wrote:
>> This is (yet..yet..yet) another resend of the original PR meant for
>> net-next.
>> We have fixed the hitchups in the commit messages, as pointed out by the
>> AI.
>>
>>
>> This batch includes the following changes:
>> * use correct constant when declaring nlattr array in ovpn_nl_key_swap_doit
>> * use bitops.h API when possible
>> * send netlink notification in case of client float event
>> * implement support for asymmetric peer IDs
>> * consolidate memory allocations during crypto operations
>> * add netlink notification check in selftests
>> * add asymmetric peer IDs check in selftest
>> * add FW mark check in selftest
> 
> In addition to the mark test failing always three more tests hang
> around 30% of the time on debug kernels:
> 
> https://netdev.bots.linux.dev/flakes.html?tn-needle=net-ovpn&min-flip=12
> 
> Please follow up with the fixes? More info how our CI builds the
> kernels etc:
> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style

Thanks for pointing this out.
We'll look into the issue and send fixes for the hangs and for the mark 
test.

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


