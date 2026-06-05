Return-Path: <netdev+bounces-295720-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Zkk1LG2JImpqZwEAu9opvQ
	(envelope-from <netdev+bounces-295720-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 10:31:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C4C64668C
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 10:31:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b=YO8R6dhk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295720-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295720-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E681303C7CE
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 08:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844E83C1F59;
	Fri,  5 Jun 2026 08:20:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FC23C4B9B
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 08:20:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780647612; cv=none; b=Jf5SfJWEbaheCh54xPk9qWj5CL7zeamlAsSaRyHziNNq5sdcY97Ugtl43j3k7U9/gf59bVL30a131YsE/n/uAu5x9lmcZlaCV0dA5YmQQTYscU10Xn/6Hv/SsKeBlBD5flm12ngy98fJNEeozJWO16N1iyW8QS0Conf4BF6Yl2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780647612; c=relaxed/simple;
	bh=Ad1nIwuhBFfO4iShVdGuS+I6zfiRoplsexotURrrbuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDyye53pqfXO4qYicQ1qOcVKi/CAaWzNsIRlaZdzlutaf4A2P+iu/xS/NONjCC0paElHKBY/0gsAfrHdnDKZ4hHbXrngIKiVpQv3JEKfl4A2XtAgnDcdJClUJZKpjVmHuit5sgEhuvT6yNUyKjL3FKIW95Azx3y0DSzsqvyUGl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=YO8R6dhk; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso7688805e9.2
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 01:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1780647609; x=1781252409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HO+c1Ts8db7gdpq3ytaulcv5tyCH+8/4qMx4yWr0gHo=;
        b=YO8R6dhkR1pRkOGx0HM7m8sIvq2aioXqvYhAw8D7an8UBaxqzYTNU/eZf2lI+gtyXk
         0zlGYUi+CQCTuWQHLrx278CaicF90SRdjlbzUcK6vn4I6XHPGKK9mOBF1ehTfzCXSt7j
         Jz0UucQnrm9tGfYAn1ZvUMzygdUWpKPsemxBiUd5hRIjJeahYhav8EFVHNErD4TLXBjX
         lLsnGoQ+eXH3gUsk6zaG1uU3rfj1BUhMfsBh9VA0dMQ3yy9QipNb80Uc24pORJSbXWnJ
         nCWqWiTF5f0sJ6G60YYnGBezAcsHKYP5Dgz49KZIyKw8642xYujTyFqckocWp+dFRO4I
         PKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780647609; x=1781252409;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HO+c1Ts8db7gdpq3ytaulcv5tyCH+8/4qMx4yWr0gHo=;
        b=FXcVYH87SkdEyef08tlu9enQyx/sWWGEUvBQlN249MTgnsjfUT5tLNPzpPXPRFKuRe
         xKiUnblspgLui7HyhZRcr8YblxH6v/BktJt2132DM2bNr2+YgdB9SPYdIkQtHyPx1chE
         rkbcC061l2Rbm/APUSpvcl21SHuTDr//tRFOcZ1xfF10KP4HWq1DZTNug6O1ryYUllHo
         FafcMLhU27xjnqwNrpCHB3gJa+Mj1knyn+LOiqWCy+6JYh7tAICpP/hq0/E3bGyF6q8t
         fFLEeyZO5nHix7NpIoBiBzV4/qUZH4MEHGeA3gIWp1WuQGjwrgqKP75l88HoOxg1+Ejc
         GH2A==
X-Forwarded-Encrypted: i=1; AFNElJ+ax0cq+aQAvt7S5QtO0Pb2+mE9koJzKevmkPaJ5G5Fv5VEs3fvau94GqmbugwlDeayIZsbWhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJno4oQPzbVUu3HB1SsA0eis01spjQ3cbS7WxPu7O5fZHf3xTh
	37bYmBKBhHWrwo5E8FkidyF0QoStjaiSCrSBkylfeYhOp4R7QeWQ/1TfPXITvHSJMzE=
X-Gm-Gg: Acq92OHNKFNWdZ/1/m7GGh02QqK6EOzDx0CfOg35uK9G7O22pGmKYduOa078ODHFrQT
	TL4+u6SAERYhsqi1zyXA1iUySZIVG81Uid23m+Ls86Po8cq22hjkb1JlvlOFaBDGKa1F5MFD2BW
	oBAnskqlA6wGAiOIXkq57/Fl7OnzBJKR8uWVwM9HjwTmNXPBGXz55boHiwkFO+t8q3kzgHyQqMU
	lMBZF02d4zdKrpreiZRMr0lfc+tPhbQZX/YLcrH2BsB3GFjo8WaiACBt1erDxSX6tOuYKUF67Il
	kOfsaKVzd5cu/fFB6oTbEkgvpl0H+IkH7w6ekXn3ifKvHubx/0U7/No/xxN3wM2/cywlxAdQghK
	6uWxNpc0C6Pi+Erl1Tfz9WAuZ4JHj8Qro8Fw6GCUtOmMpSxqxc3ZhaWVUSiKop1+LaZq32CdRZ6
	LOQGvUG5n8UAo/9yBfqyoTUlN1+cZRHXsINEPotKHWnF0eDzTAGljPznt/V6EQLmeyKmwzwhQx7
	Cs=
X-Received: by 2002:a05:600c:6387:b0:490:b26f:a512 with SMTP id 5b1f17b1804b1-490c251d015mr39333285e9.0.1780647609238;
        Fri, 05 Jun 2026 01:20:09 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f345209sm23277449f8f.17.2026.06.05.01.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 01:20:08 -0700 (PDT)
Message-ID: <4d9067d9-2a4a-45e2-aa43-c456648989da@blackwall.org>
Date: Fri, 5 Jun 2026 11:20:07 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] net: bridge: Move long delayed work on
 system_dfl_long_wq
Content-Language: en-US, bg
To: Marco Crivellari <marco.crivellari@suse.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux.dev
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Simon Horman <horms@verge.net.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>
References: <20260507134815.295588-1-marco.crivellari@suse.com>
 <CAAofZF6CcyxoOsYr94KARUFtfi+=H1nF3mBQAtFWxEujdVgXUw@mail.gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <CAAofZF6CcyxoOsYr94KARUFtfi+=H1nF3mBQAtFWxEujdVgXUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295720-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:marco.crivellari@suse.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:bridge@lists.linux.dev,m:tj@kernel.org,m:jiangshanlai@gmail.com,m:frederic@kernel.org,m:bigeasy@linutronix.de,m:mhocko@suse.com,m:horms@verge.net.au,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:idosch@nvidia.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,verge.net.au,davemloft.net,google.com,redhat.com,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[blackwall.org:mid,blackwall.org:dkim,blackwall.org:from_mime,blackwall.org:email,vger.kernel.org:from_smtp,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28C4C64668C

On 05/06/2026 11:16, Marco Crivellari wrote:
> Hi,
> 
> On Thu, May 7, 2026 at 3:48 PM Marco Crivellari
> <marco.crivellari@suse.com> wrote:
>> [...]
>>   net/bridge/br_fdb.c    | 2 +-
>>   net/bridge/br_stp.c    | 2 +-
>>   net/bridge/br_stp_if.c | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> Gentle ping.
> 
> Thanks!
> 

Ping about what? The patch is marked as RFC so it is not
going to be considered. It already got a reviewed-by one
of the maintainers, I'm ok with it too, so when sending it please add:

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

Cheers,
  Nik

