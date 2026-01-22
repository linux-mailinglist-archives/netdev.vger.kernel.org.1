Return-Path: <netdev+bounces-252260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ee5JwP3cWmvZwAAu9opvQ
	(envelope-from <netdev+bounces-252260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:08:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E528A65018
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 026D650A1A7
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 09:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB8936AB4E;
	Thu, 22 Jan 2026 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hhKldijI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qGdbKpY8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B24342532
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769075931; cv=none; b=R/b6TRo1PKL7Wzcz1c/UGilo4+Da18DKhtaj0j8qcjXBr64CqmnsRXEmbmMveUHLedWyTv3vFYG8uxxcutMqSbsNrceJ5xp0qd44Z7Al5FBaRmG2ZO3QXmwrE7jINgANycATUYto9oEAyr+YeMDq6zPjTy2CprZLTO4ctzJ5Z9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769075931; c=relaxed/simple;
	bh=TGZ0rNzf2/Bkr4tJ2ZKGZj3qqNf4EwfsNP+W4wHnDZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aAUTQQmZovEOhY4NiO2FK30VGcH1FIRTZvq9+ShcfMrqmp+WC/9Xbd2Oyud04md2HmtNdDxs8MVPcZ9T5sKLpWntgwqEiEQshR+WOyiczo4DdPRIMJiQ+IJoX6sFkizp8G1mXJZODB/oD3EeazLt03IKG1buPhruwpq+OuBTDXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hhKldijI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qGdbKpY8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769075928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8bga0PmTXpqJChMQAWzNuOW8OkwpWAb0ZdUEZncBTc8=;
	b=hhKldijIQin703iUhO/q5HrslQSO+yiOqlAp00co3nf90qV2SwoRpJKzXEqeJ3LAI1h8v+
	TDr999cmMGRse6HI7QVJm4y5bJ+oaaXfqkdYQ29d6HimHGSdFPxIdIk9IY4GD/EvS/CPC5
	5Phjy25jrL7afTvFlM2ZKM6J/xqusQw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-q-iC-ekqMWOPxlF72igR4Q-1; Thu, 22 Jan 2026 04:58:47 -0500
X-MC-Unique: q-iC-ekqMWOPxlF72igR4Q-1
X-Mimecast-MFC-AGG-ID: q-iC-ekqMWOPxlF72igR4Q_1769075926
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4804157a3c9so6777885e9.1
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 01:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769075926; x=1769680726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8bga0PmTXpqJChMQAWzNuOW8OkwpWAb0ZdUEZncBTc8=;
        b=qGdbKpY86MKLwsmG/6a26h80cYtgnZRjohUtNG49xKvnqDOCbugI1N4sXJ8ahH+NZU
         pYO0g/r5sftG4565WtJxzsg971M6dYd6YQ04u57ymnBmndxUhDKTtJxoaJprP4hH1VN7
         lXdlLtENFA/eRCqf7tEWZqUAtAWxoqYirY2cwh5kMNrueIN+NeeI6SzwO+VlDIlneZXF
         FI6fOO1rIlrOl0HjSf9AStK22T9GD9kzKCyzHWzUDADufxB6mmELH1KkhGJNtWcbQ7oc
         rgk1vuvVgwtTU4TSctsbNgmh2gRnCGLBr/VsUo+2YVvsMIe86FGwsrfaPjB2lrr/q3fG
         bHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769075926; x=1769680726;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8bga0PmTXpqJChMQAWzNuOW8OkwpWAb0ZdUEZncBTc8=;
        b=o23Ka5pCCfA2HwAUMEwqd9xebn34xQ6y5GXDFkhe4bMQuIUYPwjwvNQ05rt1rCC5uL
         75kmSR7EwxiNzE6w9056MUI9Wt+w1SXQTJFmIHqVYzK/67auyS4Qn+zwU1ZrOVHIglTM
         RWHc/RphpRm0hHuLuwYZWFqRTwZN2H+3JrGi2jxNioxejwthXU9dMApfFtPVTMGZ7XHs
         kvBQknHfTkKe+Ip1FnvnN2m9vn5DQcipXyQrZMMZO8ZR4ISJJw80y+IHV2BQaEV+xn1n
         4fQse8ofDLDs79KVvITkTI9BpL53fMVBqFl1ehjqPMC0BcKmyMRsvahX4xodaRpHdTGM
         eAXg==
X-Gm-Message-State: AOJu0YwLnTn4e+4Ah+taP2JP4BdsO0GFH4b4k+1bjilLACGl2e/Yzebw
	y9mYWfuM0k5Ro5I1C2NrsSmFEE//HV2nStttvwBkEAevPQqrQhyOXeIc2cU7j3Su7ClRyaJe3LM
	MFKlZsH98bSi2MsoIK1sWNSEtOI45V0lo72pSjARN6Py7XhBEFx8YT0vHmw==
X-Gm-Gg: AZuq6aJFEIXbjwjV0LPRzIMEIKCcBrCKhhR9F4noO7y89LgeUTeyAmdRzWNf4DRJhSn
	JBoY87uOeB9zDHdpQASrM/nDmd7THjUoqiG5tTQcjdhZbOD6HBBQn4FRWPF71zmSjKQAtNE7iyx
	ns4FNJVoQokFeq8vLdzcN6oWrxWhkfnjWqpR4Tn5W8Gtbej7FXZoVvnt5Lm9cG7uJQpmbjvKX4Q
	xj10k2e0Qaz5GUxT5zITeOI69j2RzCfBKU8IcCOkxbCewcSjcuuDYOGF7ouhqHQ6vxJzkdzBQn9
	ihWZr+zaaZWLLnWvtFkxtTTsIH9btZrHf29XUOceKK/pmkzLifKXr5NZK1XmFf86gHijiFAGz5S
	P8OLuMoORA3AN
X-Received: by 2002:a05:600c:3ba8:b0:47e:e48b:506d with SMTP id 5b1f17b1804b1-4801eac88fcmr326422965e9.16.1769075926027;
        Thu, 22 Jan 2026 01:58:46 -0800 (PST)
X-Received: by 2002:a05:600c:3ba8:b0:47e:e48b:506d with SMTP id 5b1f17b1804b1-4801eac88fcmr326422735e9.16.1769075925628;
        Thu, 22 Jan 2026 01:58:45 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.175])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480470474cbsm54975415e9.8.2026.01.22.01.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 01:58:45 -0800 (PST)
Message-ID: <8285c951-7e24-404f-8c58-ad7766dc3620@redhat.com>
Date: Thu, 22 Jan 2026 10:58:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/3] net: dsa: yt921x: Return early for failed
 MIB read
To: Yangfl <mmyangfl@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
References: <20260118013019.1078847-1-mmyangfl@gmail.com>
 <20260118013019.1078847-3-mmyangfl@gmail.com>
 <5afaff9c-7be2-4464-b675-4bf70aaa17af@lunn.ch>
 <CAAXyoMPFDRyKqZiFsH7cCQzBg6z5KO5mUpLf8jjpCcQhD09-zw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAAXyoMPFDRyKqZiFsH7cCQzBg6z5KO5mUpLf8jjpCcQhD09-zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	TAGGED_FROM(0.00)[bounces-252260-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: E528A65018
X-Rspamd-Action: no action

 1/18/26 8:24 PM, Yangfl wrote:
> On Mon, Jan 19, 2026 at 12:06 AM Andrew Lunn <andrew@lunn.ch> wrote:
>>
>> On Sun, Jan 18, 2026 at 09:30:15AM +0800, David Yang wrote:
>>> This patch does not change anything effectively, but serves as a
>>> prerequisite for another patch.
>>>
>>> Signed-off-by: David Yang <mmyangfl@gmail.com>
>>> ---
>>>  drivers/net/dsa/yt921x.c | 11 +++++++----
>>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
>>> index 5e4e8093ba16..fe08385445d2 100644
>>> --- a/drivers/net/dsa/yt921x.c
>>> +++ b/drivers/net/dsa/yt921x.c
>>> @@ -707,6 +707,12 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
>>>               WRITE_ONCE(*valp, val);
>>>       }
>>>
>>> +     if (res) {
>>> +             dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
>>> +                     port, res);
>>> +             return res;
>>> +     }
>>
>> I know you are just moving code around, so i can understand a straight
>> cut/paste.
>>
>> However, when i look at the code, what is the point of %s and the
>> constant "read stats for"?
>>
>>         Andrew
> 
> The error format is used many times across the file, so using the same
> string helps reduce the data size a bit.

I think you could/should clean the implementation encapsulating the
dev_err in an helper tacking the variable string as an argument.

Since you have to repost, you could introduce a pre-req patch doing that.

Thanks,

Paolo


