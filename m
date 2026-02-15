Return-Path: <netdev+bounces-258804-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sN9hO3Y/kml8sQEAu9opvQ
	(envelope-from <netdev+bounces-258804-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 22:49:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCDA13FD1D
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 22:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58B493010B99
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 21:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EAA2FBDFD;
	Sun, 15 Feb 2026 21:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="N0WWeaSR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567DD2580EE
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 21:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771192181; cv=none; b=aER+z+1ds6i8HFDJfJUCCezp8ZmyBUzpBEf9wkl9IWx36o4Sbn4sIJzcykIzWv9+95Ii2BA8GMTSHjPrwGbQZo83brIYSA1UYm23eKWJIoWPm52PLOPxbNk50f8+Tu2L15Cbxw1bl4IiUfYK/5BuzBgxmNIxh32byK+FlmbCJ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771192181; c=relaxed/simple;
	bh=7HVhe/DfYShgIGWXWpxUxGUKYO6YjXLOrca2JZIGxqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZ1txuRZQ+gnKiT/p3Ner6FrEK9ihp1k1Z5/VaFfIbA07eyUckwHh5FfrpSOXhHgrEGdXHG5tCYh1v0Od2LNUbR+PFGDfS7oYwLeivZ+6kKv2Yv9Xr6S46/j/TDQJPTcJ2/Cuf2rtyYLQ7YX9FJDV+PBoQrkumU4Ayw5kFK+glo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=N0WWeaSR; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d4c307db9aso1494217a34.3
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 13:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771192177; x=1771796977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HY4iKSdZnOC2lD9r2U/xlpJrxAQ+ri4/u1JX8B2xnrQ=;
        b=N0WWeaSRia/VO19q112Q3BLQdYXnRswu9GG7YV5wPazRLgtDedQTLhGJk+o3NEMv3r
         Steyaadr6zfVaLu0zad0U2ERQJCZv5DzBDlhrBWiCMJdtemW+gUtvWeVmb+wku9J9q16
         9+At/L4fUvKo0nFbcH28OBOdSnUMrXS+FoXM/Cdo0/PN1AltLWUSVuyUF5Mt8cdhgums
         B8DgBjPLAKzYGPvdBt4tXybxfSItVZ9/v1pVgggIj56YjcIMpDv7oP+Xo6JFWTKJAc6g
         qC6UD0umffssA9y3zn3JrVIAMrWOPAgE6c1O+fp18YtPzVr6b6ujE9+LX7NWrPe9MRU7
         lZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771192177; x=1771796977;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HY4iKSdZnOC2lD9r2U/xlpJrxAQ+ri4/u1JX8B2xnrQ=;
        b=nCPu51tqheAL8PDQaorUM28k3k/RED39YHaGUvtfy8SROuQXQ5lvdZ+jyZgHkW62jY
         6dMXcZ/yeNxEwb5r+vU59t5HBMYy7lZ6Ao7Go+7N+T2fKeufWWqtqq8xWt0eMRp1yXYE
         Nko7RltajeQOv2fkREuEDC8O6f5NZfr7/e6ZuvUK0wKBMNgvq1VbCwImlfsaN5s/siTV
         wJHa+j4WE1JevdXZrOdna/KLIWfm0zeoemFgdeASwNp+N5nAoK0F/tnWLjJDT7SF/jbn
         hWJ7/OeDOp9NSFEH0WQVd4VEMD9XUZwcx/Xb3lD5tNxlzllIUuL6Qg9RDgCqYpTBkoHl
         OECA==
X-Gm-Message-State: AOJu0Yw37V8ieN/SOT3gKV3WVV6UlM9+1Xr9JeMjTBd4UqDXaOPf6+hC
	Kjj72SkJfD4BQa/dthMe5E13mRwWtlMhWzpU//jxxzJ7MgN+w7nKT0s542bRkrP8If4=
X-Gm-Gg: AZuq6aIleEXzdu4RaCNy5WMIXWsiimodWjasNrRNUYpNfl+chiq52UXM9iga7tUoCej
	06Bv6AVI8/tKEg+IgmNfB8tWpdpwcBnYL3/RWIYbAenOEJeO/0xDluTEfCYBvRiw68S2jYF36eQ
	V6/B9KG5jpCjjBw1xTqrMej3X6DJ/TTde20R+67RXkgWzOt+OHsimi8tNoSjJWn/JEHS/ALx6kp
	cwCgGmYNtxqwdgVDE/YlM6o/67sQ3rO3oc1gm+2jjwqT2VvoeYtDfAn8habzuSxjOTrRTu3ctT5
	yJTxdQefmagh67tqywYqM3DT1MX13+OQTZDtNfzGiGG8+tNQdeMQxgnVWzKAOm2m5UhBRe9jto9
	OEVSRxvPTfTNXWYPsphdMcyXpk2UvQDlZRcV6WRdeiXao4OLtJTJqGxpZ1Zpgnrv4k/zP8GEizN
	x9CnZdxg3gzwmWpM1hEVvAtzQIadHw+mmO4fShjWNgIgGaTCg5ELfMMcSjGnZxZ5Fb/qIAMpHXQ
	MAYoTPXYw==
X-Received: by 2002:a05:6830:a90:b0:7cf:d9ba:c9a6 with SMTP id 46e09a7af769-7d4d090525dmr4389599a34.0.1771192177368;
        Sun, 15 Feb 2026 13:49:37 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a75309bcsm11301383a34.1.2026.02.15.13.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Feb 2026 13:49:36 -0800 (PST)
Message-ID: <540635ba-d96b-449c-95f8-bc2a0ad7931d@kernel.dk>
Date: Sun, 15 Feb 2026 14:49:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH io_uring-7.0] io_uring/query: return support for custom rx
 page size
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: netdev@vger.kernel.org
References: <2e8280467c93ead0c61ed3d68c036d6a0474bb78.1771188227.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2e8280467c93ead0c61ed3d68c036d6a0474bb78.1771188227.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258804-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6BCDA13FD1D
X-Rspamd-Action: no action

On 2/15/26 2:34 PM, Pavel Begunkov wrote:
> Add an ability to query if the zcrx rx page size setting is available.
> 
> Note, even when the API is supported by io_uring, the registration can
> still get rejected for various reasons, e.g. when the NIC or the driver
> doesn't support it, when the particular specified size is unsupported,
> when the memory area doesn't satisfy all requirements, etc.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
> 
> It's a simple change, would be great to have in 7.0 so it comes in the
> same release with the feature.

Looks fine, only replying to say that I think all of the ones posted
today should just hit 7.0, no reason to defer any of them.

-- 
Jens Axboe


