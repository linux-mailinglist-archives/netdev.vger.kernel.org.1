Return-Path: <netdev+bounces-259593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJnIHkmAl2kOzQIAu9opvQ
	(envelope-from <netdev+bounces-259593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 22:27:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C587B162CB3
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 22:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA5C6301327F
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 21:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D7732938A;
	Thu, 19 Feb 2026 21:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GgpKtR6a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EE3329363
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771536450; cv=none; b=UuVhdb+/UB5Wmd1y4huvBZhWYLlkb95bmfHXrVnHRODEDkAQXuJLcIzNIcOqMZjPlUHbM3VBYgK6N022TcC5qqfMbQzva3mUjJSgun2P4u2jFXr5aW3tuaVRp+j9huy2fcSbd9MVGyiJ8H58w/CYT4B7bp/dyH/E1bdrNY6P/ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771536450; c=relaxed/simple;
	bh=uAGBrIf0G4PtksC5eMQdKnqhc6vXfYYkalF3B3xNnBA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nP4cjYKDBEiJkHpbp87o8EXPamaJdboLnWRxVNNnqchBWH/nZW339l8CYXEqH+kqgNEG/WPJjbjDNUN36xFseby/FaygaML7DhAQVvxovDsW0z2CMS9bFenHUXcqeimQxY7cvRwJ5U5RxCcm2kkJ7cR+eUWqmsXLNEiyZexWWDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GgpKtR6a; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-40ee196dd78so933438fac.1
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 13:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771536446; x=1772141246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UA1VERvz5151jt2KdPat2DgK+V02UUk6l4sZ04x/A1s=;
        b=GgpKtR6aGP7idiUYNt2cYM6FhXS49LEVdgkg+d5gPQOk6ooxYU+JrN9UMretVowqUR
         Jj+AVBu3zTavQ4UQKfWJCDTfwP3ECznoPWhty2152bdA2EgJ8PBJgRV9eiB8t+ue/lW3
         myYZrV+MGB62O5uJEK/QLBYE/9WthXH/YePRs6hQd2/52x71u70l5bOu7TXwwjGRb97o
         4Bv7xAR/DH9WPmVh4GJxmtBSi0x/6YCwdmszVL/bsQUPVUjM9hWkQ5ddxDR8wy6/nCv+
         XHUm17PE9aQekZgTDdoh1Tvb6Lr60oKO3eWHoP3426toYsYSuO0DtD5xvIaSb8kfCFYt
         /Zog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771536446; x=1772141246;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UA1VERvz5151jt2KdPat2DgK+V02UUk6l4sZ04x/A1s=;
        b=n9mTNtkOF9pq95EkrYVvI7VkGZ4M73DXDitNGhCr5Z1LwdvMw2oyg9RuiCxYk0TDCK
         kx0UmUfti2CRS+cKcFu6NBn7gfZfGZAGs1vR3Pv4FsUtEYi1Yt6TR0ChcDIptLGpkdj9
         QkF5XMGzQZ+vmVBTTAVNNJlGRJVxAcAzQHLMG0yBxwAm3jJIZRn/49+tOM7kSrHiNZY5
         DjTROHDXHLRtqDxCuMUG7I+9wGuClJb4GPMVQERNi4qFGmV1IVAmj6zasm94K3JQsIV/
         eOneabRbFIrKWGogNCPWtYnzW46eRKmjcu+lvTIzCAKTAqmv6mxOe27eBXGdvbu8MN+A
         orXA==
X-Forwarded-Encrypted: i=1; AJvYcCXj4m8K8lB6JUqGsQ2h7SrsV7w71kKyt+MQKdPU3feMI2hwPj4Az5elabfzoKuoNaoaPg/ZRHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRHhn4402gReggfgIhS893frZKOEZzkkK9sLs6ViohkLPEcNMb
	k/wzFdvZ/SeKOIAm17Bw2u/a6t8+3rLdSSp652pwPzZuSasz3JUooAriWuAnUzn134g=
X-Gm-Gg: AZuq6aKFKnjVo0ChWoX7PYVcuK6HVmOqC4jhCzILJyhO7l7ol8NAltnvxr39+6EQhUc
	DP8eRs7mGn81K+d2SIS/aUEMg9FJjM7aHCNlwDW9yhTJ1VUWhz71SyW1WR+y0D+jmvjGEYdzQKE
	swTO9veO0YzEYujqyW0V1mCTVKp1CUJ5quDQ2B5wKI6z3Gi9O7ihU504MBIydko6xpdH/Q5WTiq
	3UuSrXMVf8WGhDjHzAT4FGwTHDv/sjYs+vfs9h6XfgsfFeKB+Gh/juZ1Hl1VyMtj7V7Uzlpf27M
	HjD2ZxjFKjHzG0sdytrflBXCLzwk+1DMQSjBQ4OmD9a95j74ihWLRvIeO5VakYUUzfaIwLrTdEa
	2DvJbzFuuIUCrol2DVxqLMPwkQ/HZ2uTsPraZREOGIkBSDzgTwEn/DXO0Ho4as2JrTXiJ0KXFAa
	Gc/IalF4V7azsq3OO4kPx237wHWr9URTTf2pia02lfd4/FDhtHLCH8qAH/TQnUiJ1jhNwGRQ==
X-Received: by 2002:a05:6870:326e:b0:404:1ec2:562c with SMTP id 586e51a60fabf-4154539ed1emr1793941fac.6.1771536446376;
        Thu, 19 Feb 2026 13:27:26 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:d4c1:bce:26a1:c903? ([2600:8803:e7e4:500:d4c1:bce:26a1:c903])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40f062ee328sm18930333fac.4.2026.02.19.13.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 13:27:25 -0800 (PST)
Message-ID: <5e6fbdcc-6a19-4d99-af5f-50ba8fa529bb@baylibre.com>
Date: Thu, 19 Feb 2026 15:27:24 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/18] clk: mediatek: Add MT8189 vlpckgen clock support
From: David Lechner <dlechner@baylibre.com>
To: "irving.ch.lin" <irving-ch.lin@mediatek.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Bartosz Golaszewski <brgl@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>,
 Miles Chen <miles.chen@mediatek.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 Qiqi Wang <qiqi.wang@mediatek.com>, sirius.wang@mediatek.com,
 vince-wl.liu@mediatek.com, jh.hsu@mediatek.com
References: <20260202062840.342707-1-irving-ch.lin@mediatek.com>
 <20260202062840.342707-6-irving-ch.lin@mediatek.com>
 <b7fd3dfe-c141-4164-80c2-ddc1f79374f8@lechnology.com>
Content-Language: en-US
In-Reply-To: <b7fd3dfe-c141-4164-80c2-ddc1f79374f8@lechnology.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259593-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[mediatek.com,baylibre.com,kernel.org,gmail.com,collabora.com,chromium.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:mid,baylibre-com.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C587B162CB3
X-Rspamd-Action: no action

On 2/19/26 2:44 PM, David Lechner wrote:
> On 2/2/26 12:28 AM, irving.ch.lin wrote:
>> From: Irving-CH Lin <irving-ch.lin@mediatek.com>
>>
>> Add support for the MT8189 vlpckgen clock controller, which provides
>> muxes and dividers for clock selection in vlp domain for other IP blocks.
>>
>> Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
>> ---
> 
> 
>> +static const char * const vlp_aud_adc_parents[] = {
>> +	"clk26m",
>> +	"vowpll",
>> +	"aud_adc_ext",
> 
> I could not find a matching clock name for "aud_adc_ext" in any
> of the other clock drivers. Which clock is this (i.e. what is the
> macro name in mediatek,mt8189-clk.h)?

I was able to solve this one. It is a fixed clock. It seems to be
missing from the devicetree, so I will comment there instead.

> 
>> +	"osc_d10"
>> +};
>> +


