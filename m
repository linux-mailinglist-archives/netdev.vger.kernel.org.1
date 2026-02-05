Return-Path: <netdev+bounces-257022-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGKtM3NLhGm82QMAu9opvQ
	(envelope-from <netdev+bounces-257022-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:49:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35990EF958
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B809B3017249
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 07:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B9A35EDD3;
	Thu,  5 Feb 2026 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="ubv950V5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7ED35D617
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 07:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770277651; cv=none; b=CR6th2+RHMUP+Va9rQbHyBAspojlAqlQ6HbgfC3IF1S/4Wuj84Zwzd25qIoZHxW70vQKVZ2vvn2oSJAECaQkVeCPNTJqMzsGRq9EU+AZoDTTffotfefiwFaz1Dp3AMWUU2wwsEX1F+UwKOTi6SmzKAaJ06OBvmjKmL/duKl0J1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770277651; c=relaxed/simple;
	bh=lpLJPqAArX7Iuvct1n5ysPyMdIPUlZ3UA9Csaqg0/gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4vJQrSI61FGoe+Osq6ZQ1Bh6b+Opu5tZToz/k4E23d4FV2iZ04WGuL5UV9ltu3TurhAD1bwDXwhgvp1vsGg1Art2eTgoM4XkTw8nvoC1C1y5Vk5IJI34OiUGKoT6x33FGxWTc/Zm/ahefpM5YVEJalv7xN2wEFMlA0ZThLvpJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=ubv950V5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48069a48629so5355205e9.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 23:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1770277649; x=1770882449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gS8eTVscdu7wmx3oE8qRW7nf+y0FrAEFYszd1RiMygE=;
        b=ubv950V5xj7Yf3VwyCfUkLn468St+ca17NfDIVJ8r9yBFiEeYpxHXex0N9fcn14YAr
         HRp7Ykiza3Bp81qZVTDPTSoynEDXa78tqZsNATJQ5lBxu8hnpe2TXU85ToCPT2LzO7zD
         6sXYd9bfrL/nPZ78OtFbYAVDJSbqAWLpRntl+EsCf6walZn1VGjTCMscJCLFJFwh//7I
         QlHXQmOEMzSTNmyGHaXaUEMLgvkYJYniYtUfWtEzwNdMsgJnV4rGkc28MWGB3Mn8UspD
         CBqCmlDFH+wd67QtQJCYY2b2gNDA2WSy2wI+FfU2lGLsTYpkLhn7PNjz39SXsYMoxvQT
         TLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770277649; x=1770882449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gS8eTVscdu7wmx3oE8qRW7nf+y0FrAEFYszd1RiMygE=;
        b=wboim+JTvlXgOkXQCXVruI6Rz374Z9rDvAeiW/tzlKqHFta2cGSGtHbNITtN6pK2ck
         KLaLkrpnh1+LY1PYChxwqQ/cRsRUssZOUc4hXkLgXOhZWYzjmvgDVNCJCznJFW46HHL1
         i4ImubD/bWhSS+w7Zkn80rFjWCIgeI84lrycHE95fN3hSQQV1PMjFTSagO3QiJYFlIlJ
         0grwwFixJJjqaztmLNu+RRXurnEsTF4YZLAZavEkHB0kAPZGInv0KvSJrHoCJfhMbYYL
         w4Yn4HD3pOwMv2miYgOjzXvwtHpHSQ3cGxWxntHaMHqSk5fwpTfABOaPNOxVbKVxd2J6
         Gtog==
X-Gm-Message-State: AOJu0YxGMvuwVm/fjMJxYGtGCqhJsfU3KB69vgv9Ce7nVg9ZirsM0bPv
	F9vPho6d6SkNfofmgd+w0Gv4LywOGCctdVEoRtv6b8UAzRkwnFbF0tmbEl8jgBIVtow=
X-Gm-Gg: AZuq6aI/5iZJ/QwZwG3Q5aLHnVSPUjElLop3TwHhJGvFa2/xIaDSw+m0NYk9YXKWUCe
	1hC4gq+w89mrhGNdYDcaAizm+gsfortUNcKej0A8aPecZDMeu3Jz1I4jDsg5Wh3PAdGZiyVqewm
	O1ZUlhR3tU2TYj777SUV2fpZkI20GAEO5cf8OLjqsTWW70Ti2x1NqK/puXkd0khLWR40UKa/Gvj
	lU3Tsm7ab07CLMbG2q9W1BEtp5vn8Dbvxzog1JHFNfVUsQ6lcIeXC+JJK7O74E+d5AGrvQWxHbY
	0NuWZOqZLftGGiOoDqlnvqPCA8k0gEWE8MroavHRVP+bGWEa/65LhOlvwSvALnYTUA29JmnaKdr
	ppF2fQPOn/vQX30/H6Y6dFDvXh7ADJf7N8CUKWacmq5S5GjLrAxlJTZeWSAFqaRKlAUoOKbTCb0
	i7EBodCCW3ru/Bibe1QdE43D0+CmILZad3lHQT
X-Received: by 2002:a05:600c:4e05:b0:477:c71:1fc1 with SMTP id 5b1f17b1804b1-4830e979260mr81218345e9.19.1770277649149;
        Wed, 04 Feb 2026 23:47:29 -0800 (PST)
Received: from ?IPV6:2a02:810a:b98:a000::b3d5? ([2a02:810a:b98:a000::b3d5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830fe62fe7sm57328395e9.4.2026.02.04.23.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 23:47:28 -0800 (PST)
Message-ID: <3b1405cd-6c7f-4883-95fb-151cab223a68@cogentembedded.com>
Date: Thu, 5 Feb 2026 08:47:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: renesas: rswitch: fix forwarding offload
 statemachine
To: Michael Dege <michael.dege@renesas.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260205-fix-offloading-statemachine-v1-1-640224a531d0@renesas.com>
Content-Language: en-US, ru-RU
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <20260205-fix-offloading-statemachine-v1-1-640224a531d0@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[cogentembedded-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[cogentembedded-com.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-257022-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[cogentembedded.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikita.yoush@cogentembedded.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cogentembedded-com.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cogentembedded.com:mid]
X-Rspamd-Queue-Id: 35990EF958
X-Rspamd-Action: no action

Hello Michael

> -		} else if (rdev->forwarding_offloaded) {
> +		} else if (rdev->forwarding_offloaded &&
> +			   !rdev->forwarding_requested) {
>   			rswitch_change_l2_hw_offloading(rdev, false, false);
>   		}

Although indeed the condition in the current code is not correct, I'm not sure comfortable with this fix.

Full condition for a port to be a valid candidate for hardware forwarding is

   rdev_for_l2_offload() && rdev->forwarding_requested

It is not obvious if at this point rdev_for_l2_offload() could get changed from the last call to 
rswitch_change_l2_hw_offloading(), so using only the partial condition at this point does not look good 
for me.

I'd suggest to either change to something like

if (rdev_for_l2_offload() && rdev->forwarding_requested && !rdev->forwarding_offloaded)
	rswitch_change_l2_hw_offloading(rdev, true, false);
if (!(rdev_for_l2_offload() && rdev->forwarding_requested) && rdev->forwarding_offloaded)
	rswitch_change_l2_hw_offloading(rdev, false, false);

Or maybe just

if (rdev_for_l2_offload() && rdev->forwarding_requested)
	rswitch_change_l2_hw_offloading(rdev, true, false);
else
	rswitch_change_l2_hw_offloading(rdev, false, false);

since rswitch_change_l2_hw_offloading() has internal check for the current state and returns early if 
the requested change is already applied.

Nikita

