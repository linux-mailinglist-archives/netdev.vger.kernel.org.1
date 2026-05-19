Return-Path: <netdev+bounces-289526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIMzKoWVDGq/jQUAu9opvQ
	(envelope-from <netdev+bounces-289526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:53:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39812582A8F
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB5DD30162A8
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17717367B64;
	Tue, 19 May 2026 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TB74GgNU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A609E367B62
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779209603; cv=pass; b=KNakVpwGdoQM6e9wQTrasL5FD+1X29CM7903ulvJfASnYIeEMW/7ZYWzi9aTNgKkI1yjhxZJ9zUYuCFcvXyGxZxWUnscbrktpJVvRNwZ3+8ipNUAQi6D+tGWXxrqRskbhbhse089EMVv2vQe6IYZjhDnzvKSFb7/9q7WIGrPNUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779209603; c=relaxed/simple;
	bh=cEcBY6cfkZEIsBTrWNenc3tq9Use2OImwgca6uuH33w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YpRsbRK8b1Z29jofH8zyVawEIHf2mhg3x4USyFu5M0IrjX6xMhNHBMexikmJmbGibCRRo8atbY+VCzNcYZSNmE9dRyGo3zTNqVsT/MQTxRs7YhSqs9LGcjKAgj1s+Brc01xQ8x8Wq1h0naTzKunmv1q+fwqtd/T6zmcYF4anJu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TB74GgNU; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50e63771d91so40692311cf.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 09:53:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779209601; cv=none;
        d=google.com; s=arc-20240605;
        b=QfNNRNTp5UYNB7srly8zGzoKe+lCH3GgCUnmwgbcfe5T0Bz3tkasRR+GY9IOZYvgv5
         n7Qca8AXQh1WRAjApLEz2iEJtjKftnIAE03LtvX7JIo7m84BW4L1AHojoPXl0cVqnbyP
         T2ZIlLdolXeGi1hA5fH0mxhoYITwCBrR8eHLiIjwVhVLCL5rP7Gv+1Or27CU002lPVvo
         CY3uJSlhg6p9URh/zz9XlsyfpwxUbAyNSPQ4hvS2YhDo/wv4ieV/UXRrfsdAKeevjCzm
         myAtXi/P0jBMAz2sHWHN4S3v0gKQXUBVsqItrc5jFb7On9gc8PJUEtazocYdsWxGbfhu
         tYyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cEcBY6cfkZEIsBTrWNenc3tq9Use2OImwgca6uuH33w=;
        fh=5KtXpPigM3bLx/FqDA7nkDxvTVKiI1udGKzvw2a/a/0=;
        b=j+F62dW4dffALtZHWXFiTffs813qNTPeM72E4OVWnnD7B8peiclmn06LcSTggvBVpG
         kHYDnN0jFtL0tCVWrYS5RRgjmu0gMlLjWe2FUVRJKvBEmoC3S/RcevB+etD3fM9iOKtq
         /FzL1sU7emKxnnywgFL+yVVITsAtRgTsZmd5Bb4kiWnUb26rYIDSvpEKdcrTVNnJQkFK
         NZfs3wddvz6aofBPRuIPoT9iOYuXl9oPjoWhtWsOxrOIdSDKUSB5DQpiALf5NHH1/aa8
         YZx9ukvihFklVPYCawQG3Wf800gJ84ozMgkBNrvQT/EnKcjZWIcONQfKb6CICc/3yWF4
         XxaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779209601; x=1779814401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEcBY6cfkZEIsBTrWNenc3tq9Use2OImwgca6uuH33w=;
        b=TB74GgNU5VQpJNArEf3tKA0UWMSWKjAoC5Ztl4j6aehoFTXB8YXMRjidwzPSKU86V5
         2R/PVPIEq5f7AS6EV9a9zI+QQqDjEf6RYXoOoOVwOv/D55gOu8hFBjTxWXLAw8i71yjQ
         Ue94GCDWRyamc3Q/4XGQLxtxgh8vcERhlB7noK6xam7igHjE2UftkhbN6i/JEKgJlHzL
         7BOVz3RNKbMWSYf3//RPE9nkeFb6mjc+X+dF1Zb7ODxlcBZht7eFXb+6k4P/DiLPsFMD
         hxpJ1I8vXJtESpPUAOseznbWij4N1TYzIWdxHyE/L88WU/wmuM7DrMt5aSYKwlMeokxp
         Vpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779209601; x=1779814401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cEcBY6cfkZEIsBTrWNenc3tq9Use2OImwgca6uuH33w=;
        b=IgoAhZtMz9myO1DPFJ6T4qb+WrXP2Q3HxZBE3SpypNmBzL9tH7Du/Xf6V8l/cAiXHG
         4wYK+WaDIoY5FQIn1f6cZEwiqPEElWl2gVAdWmZhBfInApko+U0cEld5suACxPzkCjQr
         45ZfVHiIngFoztEDMQqZ4FTXpT6azsBulb91/jDgSmBbnWEfgpxfwQ4QQT7Niu7KuvoN
         HHApJEMMooVWI1/azCBPYHjYGtHtYYA28U21jF+OfJE7vV/gJm7O5aVqkf4iln2FXDeF
         WnayFg9zY4hVIDDQMq9986IuTJynlCvxt3NwZouUmapw+Yd/6zYSEkdwhZl75ib6S9dg
         6mMg==
X-Forwarded-Encrypted: i=1; AFNElJ/62gT14jaz3oF2wcOhQAeOyVeiw93FBPIbW3e8JzVRd3BbjgzyoZZtDp3XR3hC5Yktl1XIwIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFtRyAMjxK1Qu5tVrWCf8HbJeZnmTWv3bxiRVbQpF6x2J2FEDZ
	aqNxJ+HALoK+11MVmXO3CQD8l98G8AGSgb6p5B7oIN6dX3sXut0UZHJgMj9b8VAfpAVNEsHDj91
	2OnIvjh9aXuKNNnlzCHcd3pgw0rNbTxI9zXBuzPnT3urtllOnhRVFAsx9
X-Gm-Gg: Acq92OGaEhp+5Q67tFsAOj1lf8EAErzwuCmpRwOA5x+UqRRI6i4UwbyGL+sqTa3rqeR
	I/m9g5Nb2ZLd0uKWGNqKXYw4JlyV5IwM+5FloRoe9rS7ZjUwQ1ge9VpxqQLwW1BLWzGvJc1utyE
	hFH+S7nT8zhspzNYt369M59oLPMHOBRHwAD8mTeSIfPasJUpCB9R/yJOhcFmE4cm+QJ2zfilcRf
	4xc3atRSP5evZHGvJyXe/ox87b/QdQ0jZVScgzz8x7pnZPCjn17qNLRV/rve93s4Sv5VEB+JRkA
	p9Sl0h408pt6vZb5dNrjAfszeSKdBrNU3J6G3lUuxOZU55jyjQ6IjVxd7GRDiwdHhjz4ElFvoKJ
	1g5o7HVhPRfsyTA4FhqCEWGzJMKCwM6Six2/hj/tz2kvzooIhI1MyKqAoBct+f8I=
X-Received: by 2002:ac8:5a41:0:b0:512:e827:d844 with SMTP id
 d75a77b69052e-5165a27ad60mr285265541cf.58.1779209599873; Tue, 19 May 2026
 09:53:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519114355.2769474-1-edumazet@google.com> <20260519114355.2769474-2-edumazet@google.com>
 <20260519093904.49298543@kernel.org>
In-Reply-To: <20260519093904.49298543@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 19 May 2026 09:53:08 -0700
X-Gm-Features: AVHnY4Ih4payQ64Hwtu75YmHs5w3sFf_v8r5VDJlrGUltpyVEpzEFBiSzix3AEY
Message-ID: <CANn89i+pLyyDedP7YeFLxYrESrhLvFrRoeaVJHrG=aDEnM0csA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/2] rtnetlink: use nla_nest_end_safe() in rtnl_fill_prop_list()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289526-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 39812582A8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 9:39=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 19 May 2026 11:43:54 +0000 Eric Dumazet wrote:
> > Avoid corrupting a netlink message and confuse user space in the
> > unlikely case rtnl_fill_prop_list was able to produce a very big
> > nested element.
>
> Should we not prevent it from happening in the first place?
> IIUC otherwise if user adds a lot of altnames ip link will no longer
> work?

We cannot prevent this unless we add a mutual exclusion.

If a reader iterates an RCU list, other threads can delete items
(before the reader's cursor) and add new ones to the end of the list.

