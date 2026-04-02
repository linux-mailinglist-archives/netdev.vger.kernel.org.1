Return-Path: <netdev+bounces-274465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL4sKM9GzmlQmQYAu9opvQ
	(envelope-from <netdev+bounces-274465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 12:37:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 143A8387C9F
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 12:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDE56301A2A9
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 10:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193B737C107;
	Thu,  2 Apr 2026 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="fjsF6BEa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C525E382390
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 10:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775126221; cv=none; b=LU5OEmXFINggdWERCFMPByqF18lq27vXDLXuHvSfg7IWbmxQxuQ9W9kMPd6JXYoYx1r5vIfA00794zSKNRqEa7MAPwVk5HCWDaYirQc5lonHvEMHvWOXaH0vGirHcn5NGpJ00MgBG3G4tJwxpfNc9qY4MNNYtQl17ZN/a3B+hGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775126221; c=relaxed/simple;
	bh=GVH5hpvDdjmO5Lc5AiyyjjOYtsIiVa1Nk56TslnBoDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X5bVzlYlBjE3xNzANJ3r609ZoN1q9AwnsYjorjBRgogV0ws64Sxuo+nX9pmcW/kv65CIa4mlI2BwY0HCHsvbwyRhjUAeDrhKXbsh6HeyF190lPzTLCESiweiOMvvB3bUSppu/4g3SQK4XWXG7xhM+WS7H2NHf1oOtUY5t2mzZq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=fjsF6BEa; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56b7fce3ae6so521692e0c.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 03:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1775126219; x=1775731019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ngG7IsBP6BSWiB93KdlKwrqJFZCjcCiJ7Bk1cF+SjGQ=;
        b=fjsF6BEaGHdt57OFGlbCSE8r37QWGTw8Gn0n+RebNChsy7BoaMR6CkizuvNcCjfVvC
         LoJwstiTPE8dI2silH+cyhJenUBlW4VH6e7Z1I8kn0EuKW4VpWE8fybyO2C1+JvgGljp
         WSWPPLoROWeHb+69obKse7nMgo629pbAcPC26HJ0VtQyFAeSMfJAbjRCAUVeCgveTzt1
         Ab3l7Y80aTsnuJmBf9AvKlLCn3c9XnSuoyfAdnIT5MiGoBFLVfgwx07VSujJt4IniC3s
         Y2c+Yihh8qhexqTr6j046bhrldLq4rYVOAgFkePrxa5xGKHcy0M3JoNCQRhKU850SzEC
         kUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775126219; x=1775731019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ngG7IsBP6BSWiB93KdlKwrqJFZCjcCiJ7Bk1cF+SjGQ=;
        b=qPr7SiHmhkF6UaQcwIa0UqcMlc5UarJqUWd03YMJlgxKasaiCNnVh6KOCyiudsPwIS
         BbEs0UJS+zAaJieag8nDNn1MNF2R9GR7+G10dMjWelV4F1YQJ9lyugiqDNnAnJzkjmiY
         r3pQBpG9ZZeFkKxKpPIaunJPdqmBV6DVJLUVnk4yvxKdZWOLx7nWheTaUN6DziSqUS76
         i29Yeqc1w2zLyY74l11zqpf3Yyt/vkANxNq7e44i3IH6cyVcOKXuOddN5/XW2EV3j6n1
         ZPxEeMlBvHQ87SOeb1Yy020yYCCgeqZDgX+dxsMM19ZIoXlf2H3wNSb44A1fE/OHL418
         /15w==
X-Forwarded-Encrypted: i=1; AJvYcCXuf8Dhp5oIxwSn6l62mGwJYjOq+1S9+bhZF/UIQb64IOt63HXiAex7+xKLdC6cQWdin+nweRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMBW5mBadtw2SniOEZIPy1cvPqvxsm5IDEZEo/w+btxJ/Rt8r6
	9LLXJKMuprgOICN6KqiifvzBE53El32Cz0osnq/ik3YO9gVO9116J8fthIFAAs8C6Op0HquOLCE
	QgZeyIw==
X-Gm-Gg: ATEYQzyNhhjmy5OCVmu8/2rxuQ2TBRn+OpGtMG8+geGipccpwp8S9mb1hvRZC/rIHwH
	BDng7h1yTLpQVksI68JHwapQwVPkqR9+KhdI6diO8I+De0q1vIk8EMkN0My9oNDvqUlXeIYr5yh
	OM0ndu5UVO/3BNlcbc2MnY/ubjx7zfH9RlnMBBUd+pnSlZqwAq1rsEdMuzJpTlkcKDQufFGvmiu
	EDAY1nXEuE3nrbs3Ln3xBXt1Q/sYa/KljIT5+l5tRqKatLMGtAvhuHJsRKtI/xIcyg1F7dyUMkk
	FbpX8YYpoanx7asDDVzhqLEmRco47BS4z4A9iHSsHyIYmte1r/POzVM2zRodgAo6BLClEyYqRIV
	YG24KrvAOc1SU0EM21dHUpHI+nzTpL8yMEYgLioFSMKlJ6mKochCxRqnDHjt9rJVVRxww28I3Lt
	zjDaeMdWhzZ8rYB67n3OVPqfDa94Dz++vYVzLHNYisZOI/
X-Received: by 2002:a05:6122:1792:b0:56a:8d44:97e3 with SMTP id 71dfb90a1353d-56d9f11ff08mr488007e0c.5.1775126218450;
        Thu, 02 Apr 2026 03:36:58 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c54:4d67::2000? ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9baff553sm2747091e0c.8.2026.04.02.03.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 03:36:57 -0700 (PDT)
Message-ID: <9569bbe0-24bf-494d-bed9-9e1a85ca3e63@mojatatu.com>
Date: Thu, 2 Apr 2026 07:36:53 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/3] selftests/tc-testing: add tests for cls_fw and
 cls_flow on shared blocks
To: Xiang Mei <xmei5@asu.edu>, netdev@vger.kernel.org
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, shuah@kernel.org,
 bestswngs@gmail.com
References: <20260331050217.504278-1-xmei5@asu.edu>
 <20260331050217.504278-3-xmei5@asu.edu>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20260331050217.504278-3-xmei5@asu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	FREEMAIL_CC(0.00)[mojatatu.com,resnulli.us,davemloft.net,google.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-274465-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,mojatatu.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 143A8387C9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 31/03/2026 02:02, Xiang Mei wrote:
> Regression tests for the shared-block NULL derefs fixed in the previous
> two patches:
> 
>    - fw: attempt to attach an empty fw filter to a shared block and
>      verify the configuration is rejected with EINVAL.
>    - flow: create a flow filter on a shared block without a baseclass
>      and verify the configuration is rejected with EINVAL.
> 
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Reviewed-by: Victor Nogueira <victor@mojatatu.com>

