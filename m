Return-Path: <netdev+bounces-267749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDHXBUt+tWl71AAAu9opvQ
	(envelope-from <netdev+bounces-267749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:27:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECE928DAC1
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6ED13032065
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 15:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0CD26ED3E;
	Sat, 14 Mar 2026 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="2uLV/PTn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E7721773D
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773502024; cv=none; b=KBrLbtNbV3PhIG1sQuwEaEbjx4t+NU1CBfoIOcmmvgWyF1ctFOoqVv9MTdyJjJy083yyQ0wYlNefZPvI6zJF2unzbTVMHM1wXo5xfYkI0casdChiJOjeuwARTljG46ocivrxtn1kJJZhZmc3r2bEz6HUdTtFpxobT7MZ1w8fneI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773502024; c=relaxed/simple;
	bh=nTeCqfVXtKsetEpfgCXAgcZIWz2foL8cxth7ZjbYTcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hf/ERT4GzzL1SrO2n7TWlrYxXupnC28RSpaV6EykjwdHAw2dvvjm7ZzeF1gibQBDnrnzGIB7aizPmCz4nmLrr7htb4z1WVr9v0CypawCgHRAnqjJ+Q+L/FOF41zSPAyZ6gG8wfUK3R7lRK1DNO9P0s/YgklVk1joBiYCANXt8T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=2uLV/PTn; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1271195d2a7so3084014c88.0
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773502022; x=1774106822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vn4gaOGV4l5ZARKWlKB4HTFPQWW07CLAFTjb+NqUxAY=;
        b=2uLV/PTnBfoGdQA4ayW/RYDgeiWYpB3CaBxaN+18mxAYqkDMaV3BZvUSxH9foEnTvM
         +82ZUuAigcdwc8hAPdDMTl4aWP8/D4qC9zhaZdZVGA1nrFB/y+GQIS2JLnHAJ8G+iwhw
         jg5h7jTDYUOUMegNj7Nv07Uc3eRKU/3PNOZ6iEhxr41kaaow1HhzcTr9ZLfGRzemjirL
         Oecvm3+MQl9i8a16a/KtQiF0ekhDrcYWZuwlOsvs4qmKLJ78DU0K5wJmV8QnirXk6o2O
         glY0qwD8KBuFLDk7LTvQ+bGd+1HSSKZRCBuHJYCHaTsNNsRzw2HFh1qFI0LY2EL/wkUh
         uiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773502022; x=1774106822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vn4gaOGV4l5ZARKWlKB4HTFPQWW07CLAFTjb+NqUxAY=;
        b=OmDB1dj1k2aHvBEyF+p3ATlM014pPgqAn02xgHMfslBgPjDaE/RjirKYzMhabu+nrt
         46zmoA7zky9KJm+ETEsVg2pEcrzr6FVDG6AY2NgpAdRUipFSawMjw8Q10hdHAqebf6JO
         6xqIIz+jMAe3z/IdBl9n5q/rNlKpH+6bk/lsAjhCZ6+qPBlLrl7An4DRscpz6OHC8w45
         DQke5c+/E5xQOKqKAYaqdM5gDx2KJl9KQoMYjtK6a+C+7M+p2WXcjVYjH3x4b0rUv5OA
         wqYpyBWpP374R+2excGvgJfRiBOxwh5TIB9rQuYRUJJUC63FSqQekxLufyguchB8jovx
         ccog==
X-Gm-Message-State: AOJu0YzuIb8uxu03VCGG3zRizxAkHw4TbjYIEACXSI2jZlenL/d6U9I7
	XBnAVo67DhXqWlr6VBrhEJ1mYc253WYIIB+ws8iyen1PI32vC+1WJjAFap312c9u2w==
X-Gm-Gg: ATEYQzwOxMdB1cuKezumFnLVrGDIQZz+jGZ4LCTfCnq10l4lyno/w9/O+8z4gi+yLfD
	reprJyFU08b9cKncpS7wTu5yBraYs+vXM0tXIiVMxd0tcrE/H+W6GPx7jgvC6a02Xx/Q0rErDsx
	DPgPsJ3tQR0d9+2KVRneUJQqULZZZNVQKdUJRMGnjDOyPQEQZX0axOZwmXixSbFvrrTNWMTtb72
	WoAN62C7Kep5CApu7fTSQmFFmS5kW/hXXKx5Yji3S5UGOjsrrWTSfNM6xjbQOIH7XSuUCi3KVTp
	JcLHFSdUmn04hMd6ZsY9TNUjuLpy/hb+S0/9FcUzoS6srfA1NoGIUDKSMjPsFeWhcohWX9GB3gj
	lXxhBDHICfZd5Vb08u3VlzAXADeGA4LiNB43lJfYwMA+qsFTSTMu0J8RlszglOLH0NFZwOgD0MU
	w5XFzvMzvYapEhnl9XDsiINEP88dQhkGPgjg==
X-Received: by 2002:a05:7022:2218:b0:11b:bf3f:5251 with SMTP id a92af1059eb24-128f3d6191emr3834467c88.16.1773502021715;
        Sat, 14 Mar 2026 08:27:01 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c54:4d67::2000? ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f63e0d1fsm5827535c88.16.2026.03.14.08.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2026 08:27:01 -0700 (PDT)
Message-ID: <ae437441-f616-40df-bcd2-68534fe83fbb@mojatatu.com>
Date: Sat, 14 Mar 2026 12:26:56 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] tc-testing: add a test case for ETS
 offload
To: Davide Caratti <dcaratti@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
References: <cover.1773411667.git.dcaratti@redhat.com>
 <9d118a29d13cf093687e3bc814578cb922f234b4.1773411667.git.dcaratti@redhat.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <9d118a29d13cf093687e3bc814578cb922f234b4.1773411667.git.dcaratti@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-267749-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,mojatatu.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 6ECE928DAC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 13/03/2026 14:23, Davide Caratti wrote:
> While reviewing the fix for unintentional u32 overflows in ets offload
> code, Jamal said:
> 
>   [...]
> 
>   > otherwise a tdc test should cover it fine (when you get to the
>   > netdevsim change perhaps)
> 
> Add a test case to reproduce the division by zero fixed in [1].
> 
> [1] https://lore.kernel.org/all/CAM0EoMm17wsYZmdFLshH3_-GrZtzd=i0xnoO2yiVB=-N4761mw@mail.gmail.com/
> 
> Suggested-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>

Reviewed-by: Victor Nogueira <victor@mojatatu.com>

