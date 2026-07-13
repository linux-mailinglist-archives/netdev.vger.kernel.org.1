Return-Path: <netdev+bounces-307058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bNokHr6cVGoBoQMAu9opvQ
	(envelope-from <netdev+bounces-307058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:07:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7248748802
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:07:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rMYTKyWU;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307058-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307058-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99AF2302D529
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C273A2559;
	Mon, 13 Jul 2026 08:04:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ABC3955EF
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 08:04:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783929895; cv=none; b=tPrO+xPnPTOrn/LDLpRcxd5G6jXtWGGHXHyPrEufbQtZzEuDRqpEhticzvAs+Nk0uzw90Dj2ajEc1RP0eb++Nhi3HFy7rPWRH8IezNU+9UETE7ckB0Ql74iV7qxHJcT8AZl9tTXnyRy+aZyajyIk15DnDofWKkKVCXjvcONJaNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783929895; c=relaxed/simple;
	bh=DtmdeSEEkMd6hSliNTMBtdGoqWUa3F++SLfQRU48okI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCX7JfDw/9cUHCT+WoX9kgTOTG7Y/hewdaiy/iYWGE83auAO3jgQ0QHA8ph/74uttpZSH41pUxbbPSuk2wIwXojePrXD12hdtwlCqJvT1hF2cGGcY74WBfN0KBBb6aYNY13uW2NEUU8c2pnhNHhSD6me+LE8dJtTXAZSXf7uCWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rMYTKyWU; arc=none smtp.client-ip=209.85.210.44
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e9f829d75aso2183411a34.0
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 01:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783929893; x=1784534693; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CApcsfFtc+hrLmr0JOKsk6dM8KUEWmCDq5Qyf4FUjUA=;
        b=rMYTKyWUSLs/oUugE/Dpodlq1QenIFz5RyE5NObychObG/BfxL3G4LUm3wLSz+YjNg
         V9C+EBwF/3CTTJQUrGMouX2AwoUxY2h+hVfadPkpT8MjCVfP/Kz1kUoVCGutXPe5+dtA
         rnBWH7l41cD7ISEjFJKSWzQKiV67wdVeR+ncPoC6CAHJoxl8715mkM/LTUNYC4Hey4x/
         sum5zB8n5GMPQ6xhdD8v6pd334+bO7+aS8dfXg1hv67m2Cw2jxoGdPrHIPjWiDB9+uIO
         0KOwWITFz5hAXJvFFshxWANNJ93+bWhXPpmbF0mmCSqSd81KWMKjFfOaVOVFfrWwPcKM
         oJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783929893; x=1784534693;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CApcsfFtc+hrLmr0JOKsk6dM8KUEWmCDq5Qyf4FUjUA=;
        b=qYsmVnZkE0yv8aRrfH9QjDgdLhgl1DLZ2LutmBGKE/xH//dl/IxY8aoa+3tFh07tft
         FCgWULeonpbNqvjgpaILgqdsWEpSCYjx3i5IoBicu7MiC7SVWDd0kYSId8xoTd5GbeK1
         SajiDRYiBjzQSLSraTXmUlaTB7nGvVIt8DpMMLBVIATSwbEFhWPkmCgFSmq+kfbEog1F
         BlnT+5DWiACtjB7HV19P9mb4bPluMm8BV5iW2CfE8genrSp15UqV9pl8ivQiE60JhuJy
         aYnfuUlVRMtUdnH6v4jHKkKHh/tgR2M8eYV3Go9rQnCPPr+nLccqcaRJcl0hK0YcCkSn
         CpLw==
X-Gm-Message-State: AOJu0YxD1mhwTZER1xYzLr4FbAi4YC+N9sWaMO+1y/Ez6qHqW8HlOgYk
	+V2zyZ4sxiVej1AuWTRJIrkrM+yShSwfvptFgY7XsR0b5b70vJQLohxa
X-Gm-Gg: AfdE7cn9PAQJFtt2ZvntTcnkumM9xgkrEeeppC4QqDvlKa16lZUwjBkwqiW12PJcyNQ
	3yUX3gnoSBWaBba0SDifq26e/GENTft6asPjg7Y7LAOGsEDOYgREAFMl3d33IPtS4blGBgPH4Ya
	Awd8jXomdCueOhZvMfYOrHb9wu0FoZZxk5e7As9TqCv5J/ZZieAmcop2rbQMc8v1yAgjIGM1Iih
	KKbG2zEzFTN2T2g0iwOnek2l3TEtEmwRpe+RgWLdwFRjxxqahG7Hmu2fkvZ6fLEX6Lt6PNqFZ1T
	nJU1y4oDRSd748bK+0P4f6ftfpsD4HgmmcPZdViX8WdYio2Ga7i2I2Rws7IQec4VeLi6zZGJqmZ
	gH1XdYLt6QDEqVKh6WETtYPFGzBvyeZDcjR++2JVchxW5RlZnAPmNbh5Z05mYrMbqoUcMk2OXyc
	viI2iI
X-Received: by 2002:a05:6830:6688:b0:7e6:de36:3f35 with SMTP id 46e09a7af769-7ec0966e43amr5571430a34.10.1783929892978;
        Mon, 13 Jul 2026 01:04:52 -0700 (PDT)
Received: from localhost ([74.80.182.78])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb2631dfsm12412729a34.13.2026.07.13.01.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 01:04:51 -0700 (PDT)
Date: Mon, 13 Jul 2026 11:04:46 +0300
From: Dan Carpenter <error27@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>,
	Michael Grzeschik <mgr@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Yibo Dong <dong100@mucse.com>, LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] net: rnpgbe: Pass an expression directly in
 rnpgbe_rm_adapter()
Message-ID: <alScHkiC3EmGzOlI@stanley.mountain>
References: <7958e26e-a4f9-48ee-8d79-3797016944c5@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7958e26e-a4f9-48ee-8d79-3797016944c5@web.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307058-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Markus.Elfring@web.de,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:danishanwar@ti.com,m:mgr@kernel.org,m:pabeni@redhat.com,m:u.kleine-koenig@baylibre.com,m:vadim.fedorenko@linux.dev,m:dong100@mucse.com,m:linux-kernel@vger.kernel.org,m:kernel-janitors@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[error27@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[web.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,stanley.mountain:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C7248748802

On Sun, Jul 12, 2026 at 08:35:21PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 12 Jul 2026 20:25:10 +0200
> 
> The address of a data structure member was determined before
> a corresponding null pointer check in the implementation of
> the function “rnpgbe_rm_adapter”.
> 
> Thus avoid the risk for undefined behaviour by omitting the variable “hw”.
> Pass the required address directly to a function call.
> 
> This issue was detected by using the Coccinelle software.
> 
> Fixes: 2ee95ec17e97c58b65e978a08b75fa8cb6424e4e ("net: rnpgbe: Add register_netdev")

There is no NULL dereference here.  It's just pointer math.
No need for a Fixes tag.

regards,
dan carpenter


