Return-Path: <netdev+bounces-296570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3+q6EoTHJmrXkQIAu9opvQ
	(envelope-from <netdev+bounces-296570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:45:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC839656C50
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:45:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b="QJSKt/qj";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296570-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296570-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BEFE3034303
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 13:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58F3380FF1;
	Mon,  8 Jun 2026 13:43:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E9C37F8B3
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 13:43:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926210; cv=none; b=DfECQrD6Yf+oxtr48cA+KItfCO1ORoJC/TsqfUB9jcFEneoiXADerx84eUbAxnIKCUjnZ+4SyO7LB0Bh5A+i8ygpgN5yPwIBGqmEBkIdqi05u/gvpOi6tRSJWX0KX+4uQLoSqEL7755Qvk3SX4EEV1KbJy/+9k9TZg+INWkjw80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926210; c=relaxed/simple;
	bh=HvfB4a1bANoomgCG3Co340Yehe0HpVOi2A12pQ+0F4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FX5osUthWe5XHqZ9ciQTpYthb3HU4LJBvMmSx/380UG3N6kE8S4YNE1jKd0MtEI7Hrq2h+rrh2N+ExomuFV0ggKGxrjDK+4G3MTIwEl/Rn/JXapYoZQB4WtrjJFjZ5O6HLiZYXoebB3/s29phLpuiMVioZH6UWxy3TxbfnOPLjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=QJSKt/qj; arc=none smtp.client-ip=209.85.221.54
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45ef372c58aso2340799f8f.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 06:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1780926207; x=1781531007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hj9Olmd2YvWjy4tXTWbhm/VfxWob1wRJq0JicC4EEZw=;
        b=QJSKt/qjhBekBnb/s10mTfeoNOV5yXF9Z1D6nI1Y9lgMiOqWRhnnpSpa6nbmF96Jew
         ReWH6phArcsxECBG2nMg1Xu2rmW1X2D9Jk2FDk4UOm7kYs4DQZyyyWExIscj7IcRTIQv
         j/ZL0viPNHqkAAwWjNc2MCxYw5AsVX4JKp753+XFIZIIL3mLRFWg2WvT1rz0IQC0ABYa
         meFceYPSCtBEDhbSTNQ+zfEJezI8FCB++rfeHQVD8AwJHokv+LJA7xjMXUhwAQvoIujq
         dK1QX/PxiJblyFqu/9QFepMYt0JsQf//78jNbQLxJiIrkVbqeh68LokJJTX5kaz3ATVE
         KpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780926208; x=1781531008;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hj9Olmd2YvWjy4tXTWbhm/VfxWob1wRJq0JicC4EEZw=;
        b=rDJxcgOlt9UbYnJY2cmWtxnBWNoRmGsNxMszadGzNSmePWLhyNEzX/FO6aA6ouoiJ1
         BYpNvQnZxh11hBrh2N/ryrX6I6r13xQsgYAOQ6u2a5tmzsvpO9y1rz+PTmRedU2bGKuy
         /2DmbuhNuNHHbe2dGjBq9x/zYaSdwOGWNQaaMi4TXHaEdNJU+xeRDesFbyhMYoCe4uf4
         J/twKfVQ01KLtuZeDbPuA8F+FV+r/5CHSfBSnJOw5OZWAc58BPfv7Zz0hhQkoBpm1iRG
         RZb8kJ8GpRsXUdm8FqGUFvefXeCT9g/j3U3j7kAl0AQ0tRIsUpB2haUMA5zk60KNjC7N
         Wlog==
X-Gm-Message-State: AOJu0YxYMI8BlKsYoJarDVFodOzn0ypX5Ir4F4Vn9DbEZ2loV7b9r4Io
	DWoqG/8Hdq6zbK33zRqfDx72hoal7loOwTjzC2+hhVVtWjL8r6po2WNvrbSpYjUCEUs=
X-Gm-Gg: Acq92OEgSHmuX/UL3GapmLHkomU7ipcop9qqasXxcVq/PPfyNj8QMzOumiQ6Trqeu+l
	b+UAx584+xcRUoy/au1wqn3woSSfpu04B5oYBB8DJjWzzyXmvCFkmV1K9azskohX2P+sWYudxWO
	kzLFePIf+McDYOkGmwsv1InHRj1yxE094FBPGhZYvDsKbdy32SKpWYUKwodDfuQ/LW5zsCNIqiP
	rlbKtaaVo3JL54LGU0NoTV89DxP/Aae6jlovG2Kp4MV35MNxoTeYDoFfy/Ip8Mz6HmUkJGz4OeZ
	Sfc3z5WwgjoTiXXgsEBtnY6kb05VzO4gXaW41ynk09DfKIIIB9FArYjdrVzDMhx/z3eLhzruQeN
	6KDOx5piopS5lSgKtqVYK8lY2kBA4w85XkzvAeCb28nJOpEIEZvUCFfbQht95dsFtGALKumY3Yf
	P5302pHI1aT9p5oorSv/OeCiBbNmAnrvj9NqyAZ2ranymGyVkrDBN2Xr/WDG8uZwsn
X-Received: by 2002:a05:600c:4e4b:b0:490:bfda:7d7e with SMTP id 5b1f17b1804b1-490c258999amr271254875e9.3.1780926207095;
        Mon, 08 Jun 2026 06:43:27 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3e59f5sm423730785e9.14.2026.06.08.06.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 06:43:26 -0700 (PDT)
Message-ID: <2626cb5b-d221-439f-9ef9-ddee80491fdf@blackwall.org>
Date: Mon, 8 Jun 2026 16:43:25 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netdev: fix double-free in netdev_nl_bind_rx_doit()
Content-Language: en-US, bg
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, Sashiko <sashiko-bot@kernel.org>,
 bobbyeshleman@gmail.com, dw@davidwei.uk, daniel@iogearbox.net,
 sdf@fomichev.me, willemb@google.com, kaiyuanz@google.com
References: <20260606012124.4060950-1-kuba@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260606012124.4060950-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296570-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:sashiko-bot@kernel.org,m:bobbyeshleman@gmail.com,m:dw@davidwei.uk,m:daniel@iogearbox.net,m:sdf@fomichev.me,m:willemb@google.com,m:kaiyuanz@google.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	DMARC_NA(0.00)[blackwall.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,davidwei.uk,iogearbox.net,fomichev.me];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,iogearbox.net:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,fomichev.me:email,davidwei.uk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC839656C50

On 06/06/2026 04:21, Jakub Kicinski wrote:
> Sashiko flags that genlmsg_reply() always consumes the skb.
> The error path calls nlmsg_free(rsp) so we can't jump directly
> to it. Let's not unbind, just propagate the error to the user.
> This is the typical way of handling genlmsg_reply() failures.
> They shouldn't happen unless user does something silly like
> calling the kernel with an already-full rcvbuf.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: 170aafe35cb9 ("netdev: support binding dma-buf to netdevice")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: bobbyeshleman@gmail.com
> CC: dw@davidwei.uk
> CC: daniel@iogearbox.net
> CC: razor@blackwall.org
> CC: sdf@fomichev.me
> CC: willemb@google.com
> CC: kaiyuanz@google.com
> ---
>   net/core/netdev-genl.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index b4d48f3672a5..11b0b91683d7 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -1095,8 +1095,6 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
>   	genlmsg_end(rsp, hdr);
>   
>   	err = genlmsg_reply(rsp, info);
> -	if (err)
> -		goto err_unbind;
>   
>   	bitmap_free(rxq_bitmap);
>   
> @@ -1104,7 +1102,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
>   
>   	mutex_unlock(&priv->lock);
>   
> -	return 0;
> +	return err < 0 ? err : 0;
>   
>   err_unbind:
>   	net_devmem_unbind_dmabuf(binding);

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


