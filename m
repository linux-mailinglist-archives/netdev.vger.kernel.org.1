Return-Path: <netdev+bounces-261808-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GLaKV9uoWm6swQAu9opvQ
	(envelope-from <netdev+bounces-261808-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 11:13:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1321B5E29
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 11:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38A3F30EE913
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E6C39525E;
	Fri, 27 Feb 2026 10:10:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E29B36EAAD
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772187001; cv=none; b=p/gBbiBS8lzi0JTFJZe2tslK7QF5reFE7HVTjvDN/C8gwa2oWtKwaBwqyMiDstkOXxeL9EbSutH4mTm0+1Ko4BYu5oIPrZz03UIzBhvBP2XR+WhXNdP2pf1eu7ChVqhRNJgGRuWbZyWuuTSCF2fcyEa7GJgkomH6AIeTMmNd18Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772187001; c=relaxed/simple;
	bh=+0vQ/R6tjuFbo9r1LWcPfmUITJV6dv+rcbp1OrFwLE4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nXfyH7QucFxT6BGeSMOS2j25GJ3dm0aBNVn9S9CuezIHypxMOMGYZc6bh/cwFWg2yUNCDp+GniMNYvt2DeCOFsOScbLxIvWrqHO79sHzPr2RRRx7BDS0InqMFm0QaLF+E/h7C4371NvZVitNmifXKVJ2/sEmrfB/xnh985sUC74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4836f363ad2so21433015e9.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 02:10:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772186999; x=1772791799;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6uSVFsNv4qABB19foHAPJFAwem67AH9v1xAhTA86BI=;
        b=SDMTYq0H3pWhlkhDiyonWYtDI3z4MWhOD4K3yWogrTeNsVQwmhSmoL03Mt8tKKbIrl
         8INhDiMqiZom+rw0K9eXEZqv9uaWIcwn5X3dL3j2ZgXgz7ztWwnDkptMQdCrVDMjgfie
         EWgktfUFP+TUZvUAwjUgJPygiuQuSI0LshDkS6xsOLW2/s5KpHUu2t7ePOkuuNXTYc2M
         anxa+rhW5N+wAWoot1SYd4D+hxqnaHW6m3V3Hp+5BoM9m9yeYiqY/KLbYkbOecblYpq3
         9yyBBs5DJtMVHXCU1SNZltY/M2Ti8YSzzITm/YAFhyGCxEc29GikAsG6eVYX7pgOOsjf
         ZAUw==
X-Forwarded-Encrypted: i=1; AJvYcCX/MZTW+PiVFLt439YzPJeaNs9xK6zPhuk/kI1hsGlDdPvmiGRpMLOPF+TlXbNIK8yixBvvfqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtG8YpOuqrw2X/MAeRo/0OntrngoOGo82Tkooz0VRM+U1AnQCd
	3eVgLWkYA+1Z+5rp8KaspeR2YQL3OZM47KznsNMcxFtxnXRm3MJ4kq4ZxyMH2qaKnQU=
X-Gm-Gg: ATEYQzwdvhQnnWlb1kZPuNCV6EZoI9ECSfr+pifG/MkS1aEhTwaS/W6b84FAufXShRY
	laIuz4+J8jc+oZge4eLosDr8wvolRxu5ff537pW45yXrwlGPSlXVR62ZsLiZT3LEiuZP+kIdn+n
	ZlP4LgkkM86gYUuufqWAwXvYTEfFoXTyXwzNd4OTTjOpCIYC1L/BUweznu5e9OX9Zmeu0VBNyBR
	y5fe2itT58kC9JltjbjzYfTb9Oux/fY+lPRh/DOVSF5SIqRRd470Ba3ABbUz5kf3bjCSu8IKeYx
	DdNCMVBHzOe073fb69yGBGGAB87UpmvEv4fd6YWXsHcip0qfVC77g08eGhLvdVkYxPPECk5+H8W
	+VMXn8af8dpBXY+rMPT7u+nqgtwQFNQkHskkfL+BrQpuzAKRKgbMc30/Jbb8Wbk0fF2cf8gwFoB
	A2MumN0b2OmgfnY/Op7BNb8lC8KOQplv3FUBnhgO4Ei3l0jzuOJ4RVVdvXFDkBVU5Ti8u3/w==
X-Received: by 2002:a05:600c:1d12:b0:480:32da:f338 with SMTP id 5b1f17b1804b1-483c9bc0429mr30739775e9.14.1772186998385;
        Fri, 27 Feb 2026 02:09:58 -0800 (PST)
Received: from [192.168.88.241] (89-24-32-126.nat.epc.tmcz.cz. [89.24.32.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcbf789sm56840115e9.17.2026.02.27.02.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 02:09:57 -0800 (PST)
Message-ID: <c304a58d-2f07-4bdf-983f-9d92b13fdcbe@ovn.org>
Date: Fri, 27 Feb 2026 11:09:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, netdev@vger.kernel.org,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 dev@openvswitch.org
Subject: Re: [PATCH -net] net: openvswitch: clean up some kernel-doc warnings
To: Jakub Kicinski <kuba@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
References: <20260226221054.1041044-1-rdunlap@infradead.org>
 <20260226165629.377fd10d@kernel.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260226165629.377fd10d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_FROM(0.00)[bounces-261808-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ovn.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D1321B5E29
X-Rspamd-Action: no action

On 2/27/26 1:56 AM, Jakub Kicinski wrote:
> On Thu, 26 Feb 2026 14:10:54 -0800 Randy Dunlap wrote:
>> +	/* private: */
>>  	OVS_DP_ATTR_UNSPEC,
>> +	/* public: */
> 
> Hm, can't quickly grep the relevant guidance but I always thought that
> the comment is supposed to pretend to be a label. IOW not be indented:
> 
>  enum ovs_datapath_attr {
>  /* private: */
>  	OVS_DP_ATTR_UNSPEC,
>  /* public: */
>  	OVS_DP_ATTR_NAME,		/* name of dp_ifindex netdev */
> 
> I find that easier to read, but no strong preference.

FWIW, it looks like ynl puts the private tag on the same indentation
level as the max enum member, which we can see in the generated headers:
  https://lore.kernel.org/all/20230727163001.3952878-4-sdf@google.com/

But I also do not have a strong opinion on how it should look like.

Best regards, Ilya Maximets.

