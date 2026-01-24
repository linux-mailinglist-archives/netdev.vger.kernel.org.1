Return-Path: <netdev+bounces-253084-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yALXHC3mdGkC+wAAu9opvQ
	(envelope-from <netdev+bounces-253084-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 16:33:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFDA7E09D
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 16:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9236B3007CA5
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 15:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7212222B6;
	Sat, 24 Jan 2026 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Y18mOoqT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEA72192E4
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769268773; cv=none; b=XHJThEOFydYpispmG/dvK/DfGUgHfMBpqRB6txhm0h5mpC88rQT821vgI7PeCw+L03GpU5Q/KuK+bGBTy0TqmdzKW9C+9e/0bJc2Y3Aze0V4qMT46K0OVF9O6eMx3u2Jo3l+WClSPVPiwyqzZqg926shllmiQcOkfyHlrY8PUik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769268773; c=relaxed/simple;
	bh=5J1z+h9gTyVZWXiuUb5p4sSnczES1pjp5WeZ5xR9ogM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sas6GrF2Uo++co6O36cqG8pbt339YQQhBnpZ3lJzwprdXnMLaaWJaKo6irxqEzQd/OOrKmCoEXpk2rtODTQLA+bmW2JKox9KSAGvvXqb/UwOhWYbQay1nhay+DrsxHfJdJEtUrwZL2WnmjRWocugxnSPtKJmbK2Mj7HBKlwUSRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Y18mOoqT; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4042f55de3aso2219561fac.1
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 07:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769268770; x=1769873570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pwfHaIHwhHynrDmxhg0SBWiGRF5dyUumJzQ8SDpYlu4=;
        b=Y18mOoqTVU85CATzrHV9YDuvVyjKDzi7IVId3A+YjhgXo2Pmw8+Z+mvHr/CQ4YXJP4
         2Id6ZxRuaQM9fe11oc1HL3nkyFgQt1p/jjBJpnvlVWqEZp/Vd0ZVSgEX2Hm5W4R+4GJD
         1Hj5Ih21/JwYEYZ7oYq477CE413mg8+TodlV9EyGaK0q6Rn0nhl0+wPEqI8Xh3dVW+wE
         BH4ZzhvrmHpFufMhP944chHsjXChWYbp+YI2dc+VmH8hQ86B9KXQM5uxIoTJQy8yGE4r
         7Fx/6wQa8jbuOKKNJWAo90KsUOMhwtMOK6IvJ6sN5hakqWU4CAzhRagPM9NEg3/4Ga7L
         bLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769268770; x=1769873570;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pwfHaIHwhHynrDmxhg0SBWiGRF5dyUumJzQ8SDpYlu4=;
        b=ivU0b7maZOvXE4gPxUPRvuKyhoJqcxOjTfa9gzwlIi+78bgdGIUczZB1qQR0g2wkUF
         9qoQTAEukACXhaNNwDki8bWSAJ3MB15T43J0Fojqtz5UCxqcp9YoxghJsnRYS4hpLoLG
         +2WvuCj94lkmiB0XnLbDeX5LjhcfRpGnaFCW6GxHOtZqU0JhCf6Va1vJLSph6zRSeF2E
         BMKliGjieH6WB2sp8FvzxxdfRu2iotUJiFDLSDE9Uk4rQm/xz5K3AUspYU1oGakopAsc
         5wne4B+QQn4oUoyYCVXdSje0K7AW8Wo413wfU2lgI06va/IgJ91ZhWDruVh8MsPhktT9
         8dOw==
X-Gm-Message-State: AOJu0YxBels5k7tdGSRogGvGJegXpw3lZhJ9HFKVAhREvs87cJ0bOEpy
	rsF4ShAv6s/6mCdQS24c52ommimnrkpiEbXFatHZoGrN0APb4y52a25PufQ1FZTR4SbTPwfE0Kg
	lp5MAmsY=
X-Gm-Gg: AZuq6aIjZnvT6JDyb4Gm0nXnZlukJBVEhI3fjBL9rp37wq8/3WTE2Bj37y3b4Yg7WU+
	uHNGpw4aFk+qZVL7z5PwWTvbkHeFhs76fqnuO/wS4wQKchLAHIHhhepokkOvnDHp8XGU2pKP2VX
	x68yPoFGk6gwOm3PgUGR55ufdQTfczv2K8NwzYqOtJK9Jh8OqCeTvYlCuWQyFX9MMcD5JAC4Qzk
	MU609pTevCWzdSUBWbflqbWZte+fHS8VzrVMWV1gHyXdQEHtE0K17HegyQ62G7CTAuM2gI0bSPL
	w3NMba5HXMk+QxiQt4vnmvVmGnYTDhv2oz49rAB9zHb/Po1ELTFvL4VD38iheXFXDCBRtfe3FOm
	B0ym6Tajn+rSyAt++H9OBhS8obalhA+ND8zFOdz+iDzuezhjCTq3iKa+NmAj51/LgRYw23DteKh
	hknD5v2g20t8EsI6OtLg7GJroxUwnk3Nc7y+eA9deSKo4hTbHsZcvElxhkXM2o3Q8dx4XrAkU7Z
	IM7yPlw
X-Received: by 2002:a05:6870:b48c:b0:3f5:3d0c:79ba with SMTP id 586e51a60fabf-408ac5dfed5mr3182584fac.28.1769268768955;
        Sat, 24 Jan 2026 07:32:48 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-408af7ff54dsm3587565fac.1.2026.01.24.07.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jan 2026 07:32:48 -0800 (PST)
Message-ID: <8ce09f91-0706-4883-9b7e-1855c8dd5c2a@kernel.dk>
Date: Sat, 24 Jan 2026 08:32:47 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] io_uring/zcrx: implement large rx buffer support
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: netdev@vger.kernel.org
References: <cover.1769249792.git.asml.silence@gmail.com>
 <a840a38936ddcaa4c03b81e66e571a38ca68694f.1769249792.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <a840a38936ddcaa4c03b81e66e571a38ca68694f.1769249792.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253084-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20230601.gappssmtp.com:dkim,kernel.dk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CBFDA7E09D
X-Rspamd-Action: no action

On 1/24/26 3:36 AM, Pavel Begunkov wrote:
> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
> index b99cf2c6670a..b5166c9118e5 100644
> --- a/io_uring/zcrx.c
> +++ b/io_uring/zcrx.c
> @@ -15,6 +15,7 @@
>  #include <net/netlink.h>
>  #include <net/netdev_queues.h>
>  #include <net/netdev_rx_queue.h>
> +#include <net/netdev_queues.h>
>  #include <net/tcp.h>
>  #include <net/rps.h>

Duplicate header? Rest of the patch looks fine to me, I'll just kill it
while applying.

-- 
Jens Axboe

