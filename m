Return-Path: <netdev+bounces-271128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJlKIbatwmkyggQAu9opvQ
	(envelope-from <netdev+bounces-271128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:28:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FF6318056
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C562830010EF
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CA23D5246;
	Tue, 24 Mar 2026 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Y8V6oDM0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8AF3DF004
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774365684; cv=none; b=W+0w2tdj/0zbDRmgDlaXdRmqV7a42v7RTwSJ1zdjFyqcUQG69D5AHuYQYHyR8nMMLcDum65ySj58R2nOR5j78qvFee00rb+MOWRwH+6RtytIeHOh0cttns4Spyo33891NC36oES0sy0FFwyOr5NSTTkETS3gTrymk84JO5eFanA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774365684; c=relaxed/simple;
	bh=EIvl+evZSdI4tBh15Sacy5+Jrtohe9ICNu5LjwM9W2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDP2Ms85LwVJ1guOwY0U3mcFrHCqpTfE8yrOMcC+FOf2pHBVXxC2386DjLXHCQrNpSupG3Ac0XoT6egzqC0asQ8b+1zQMAYkKcBlYcw4zw+SJ/ITt7aHIYx/pf5ZJDCe93pHkzeEkJ/yX14TIw6rJoIusOvOPYriyZ6YNrcnmYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Y8V6oDM0; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486b96760easo12965205e9.2
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 08:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774365679; x=1774970479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzMaHFnlgiUXA/8hXlEnMbh8V7BZ7v7XDlvylu1xk4o=;
        b=Y8V6oDM0cDMM5NAaiMdFbhWT3ud3Z1XNHXmmcZPzxhpWPVrHVLrrOvDSx3G2uXICMd
         KvbHi5TtaaF4kdv3G2Wsa8kMVmlGZ7Fy9ufmve1FsY1IAwiLHkx3pLp2tkLNRrwtlK67
         kbnoAzeqMxnqddChsYa2nVs7rsSimmdITQhq3tuxC40fPngN4ogh2bEt2+Q0EpJa6Exz
         lR+Eu38gT5UWX7YtSKGn27TKE8DuMhqj8um/2Gqw8diNe6vOX4sG2bVOBAq+bzQq9pOy
         BVBNOIFmMy3KMXv+HnN1SIVh7ll1jLkFKfvEb/qGG8MyIMFNdqUgrY1YnVt9nh9W6268
         Jg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774365679; x=1774970479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzMaHFnlgiUXA/8hXlEnMbh8V7BZ7v7XDlvylu1xk4o=;
        b=XzHEbQqAq3ygRXI7h/ZrClhmsbswctZiet04Xdf1pm13DIaL8VcZ8GqcZgt82eu5Mj
         JeRRL0gP3UQMQ8fZNKrIAV9My6x8YX582aVS9JmEpGRw2qE1VdFsHkt8gO7mvTGvbGSg
         k6Zajb972Yr23j60mvuq2wSlVEFwOyJHwkLCmkEe21JKfnffAmjOerlOJ5QvCJF/0Var
         4V+JaGvZcliI9DdeStvMJ2OoGMibpFbDJ3GCI3o28vFzA7fsd+KTbYTWChgjiL5AW+Bt
         Y8NIBgEQtn3p5G+vqSN8Qdu8iYeeLGSlmCxD7Mvc4Ji57zOcU+V1AT0wYyF5devY4dUc
         lxbw==
X-Forwarded-Encrypted: i=1; AJvYcCXe4SRjc8deQrnWK0ZUWUO74u90K6xi52Hj8pFtp2CAG9Oufndt1XJKhQGg1JAkbAHb5x5tMFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykatcmskuj/C3Qse26uKhawHboWWcY8dHnwHb02TlC+dYDhbdt
	1EPm9qbnGesSytQi/vdY4xPxpfCBQAJUcVlQ+qWwMuYZeWNHK7iC+jEdQhgQWL+Cqxk=
X-Gm-Gg: ATEYQzz/kza1qf0bCQfg+J7dSklmLNYazO4JclEZzml3BpXhpF+MUY6WkmiQXhDaYut
	hFQ8koYBpqMKr5wkISRZ65wr7IOBDDi7DKMdK3JhuneKkW0adfpH4FEIgEEdF4sbcSp6fZYjygf
	3442CXaNI0JzlgxMrhPodVHLsI/TOm8SYTJE5N7dsPkXMbYB/8JFPSZef9Y9koPgLMQ5VpYbM8l
	5+32llj/BHg3kMxB8i5dix65FEHasxAx03y7pTO0wT0hLBYO7zv5ANdZQT+mJ/jd1Q/pqWX4J1P
	w1X8vLlA7NyWsxh7fBz1fGxD7xmPicsr5pitHUjT0KmP3zok3vrSiB0U4LEaXAM2cRuoY5hnViC
	zFqeXf78vgc9tqYaf4rANkYEPOEegSSfcfQrht3jPY63sDwdlRnAFd1pvVFeDf6bgxtaSguo+8r
	fneRFB4muB4Pzjmq9QmtR2MOlNA86vJaYzkgM=
X-Received: by 2002:a05:600c:8b62:b0:486:f9a4:d487 with SMTP id 5b1f17b1804b1-48715f025f3mr3399605e9.0.1774365678743;
        Tue, 24 Mar 2026 08:21:18 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6470393fsm39925317f8f.17.2026.03.24.08.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 08:21:18 -0700 (PDT)
Date: Tue, 24 Mar 2026 16:21:15 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Ben Copeland <ben.copeland@linaro.org>
Cc: jiri@nvidia.com, netdev@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH net-next v4 13/15] net/mlx5: Add a shared devlink
 instance for PFs on same chip
Message-ID: <vms2w2ctvoojfqm25hkqapeq7gvn4bsybnrj5rxwsuvfbwutw7@4i5pbtckvlqn>
References: <20260312100407.551173-14-jiri@resnulli.us>
 <20260324151014.860376-1-ben.copeland@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324151014.860376-1-ben.copeland@linaro.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271128-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Queue-Id: 28FF6318056
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tue, Mar 24, 2026 at 04:10:14PM +0100, ben.copeland@linaro.org wrote:
>Hi Jiri,
>
>This breaks probe on AmpereOne systems where VPD has no serial number:
>
>[    0.839394] mlx5_core 0000:01:00.0: probe_one:1952:(pid 10): mlx5_shd_init failed with error code -2
>[    0.846302] mlx5_core 0000:01:00.0: probe with driver mlx5_core failed with error -2
>
>Returning 0 instead of -ENOENT when no SN is found fixes it:
>
>--- a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>@@ -33,7 +33,7 @@ int mlx5_shd_init(struct mlx5_core_dev *dev)
> 		start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
> 						     PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
> 		if (start < 0)
>-			return -ENOENT;
>+			return 0;

Okay. That is probably the best fall-back. Do you want to send the fix,
or should I?


> 	}
>
>Thanks,
>Ben
>

