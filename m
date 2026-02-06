Return-Path: <netdev+bounces-257495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKeDKcmyhWmbFQQAu9opvQ
	(envelope-from <netdev+bounces-257495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 10:22:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AF1FBF88
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 10:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 634F230125C3
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 09:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1B735C1AE;
	Fri,  6 Feb 2026 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="tGNdjA6m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44B02E1EE0
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770369578; cv=none; b=D5DFCEnP3cNi4kju/y/IFN1l5pjcDFpHD54KiCFZ0goo/ab/bfD12ubyHlVZdnCkshapPrG/SCHVJ73E2dvnOJpmbWMmkIe4H2TcY7hfrWJukgqbrCpyHyX/e7Who+kxB61p/C4PUU27cx6krdzaTYY/sq+SiV4Rsfwy256Qh2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770369578; c=relaxed/simple;
	bh=NOjMrvXLnxubIJ98sxIqIaFk16kAXp6BZ67WoBvZ684=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwd/234q7wNjzzAa8G2CiMRSFv+dw4plybKxh50xRx6pdDf8pv2WT+YBQjnFosCWocRcXDICD4ySgdrLbRC3RQi5tEgeqqq3NFNRU439AFbqNOIgy2/D+SCe7n28wkJpf+vcsDrQ6cOXLe0ZVuNHvvweC5Bh2GO2o1bC+j35oE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=tGNdjA6m; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-482f454be5bso23616755e9.0
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 01:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770369575; x=1770974375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NOjMrvXLnxubIJ98sxIqIaFk16kAXp6BZ67WoBvZ684=;
        b=tGNdjA6mjSn1RcZh6sOY3d4GJU3BT5sSZ4BcgHgairWhCv0eS3vXcD0Dbehjh78ipl
         618Qfv1FxWjfvqsVZdaSy+/sUzOznx5sLmRNyBVeVHYSxUBgmrMoCsvkeAhqJyfYf9Bg
         ZR7bRpPHQ7jKNsmueVoWYDPb1Aiom9Fw52D3OBLbV01fCoc6ok5WZtJGyMbvf9YcVOVI
         4WJf1GPk9XMeAzFtTXWzph+9XDoGYOtEj1rq6hR3f9fFhcpoKCdKcXJ9/37MWPZY5/+1
         tuLDrmhBR//mGNosouBCLR7dFeEJDwDUxwN4ost0VDE/aFBaiQIxladGo/WiQhgJI2Pu
         uz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770369575; x=1770974375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOjMrvXLnxubIJ98sxIqIaFk16kAXp6BZ67WoBvZ684=;
        b=gSRWqbtTPBZGfLTfgrdfUkPckwVZtXxIW/u01xy/Ftlckbap1UslWb8vQv8ROIfiBS
         QOFcvmrCV0oZOVxYBS8sRCAH9HyhuhgVlXqRffFqXwC4GTNWr5sga/m2HmIPzHREtCrW
         1i0RpO1cNw/vQrtp65LSGs9tvyJRWwM5NULPadnbu8pw0kzCtaMX9eNbw/C21+WAb7Pe
         xVYDt2YcMyRFbOqzsmkK7tYxoKmiaSwg18lXr7dVLkhN+VTAtzN4eCFgDm3m5bzw8meG
         qqGezhs8mpby6sSrd0/AND7dmjbY7NMy2kW4hClx/Ju7iQEJqtsJcfKljqd4ICTj33Mt
         TukQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0fvignVb36b6zzWkeM28mUNe4o8dunuOJi/p726kkkM+nvtb52rygAi+hrg88h75XealU32k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKNsfxC1mcWXXAtJb3pvR6dvjE0cu08GYSkJrJSz5gEASOteax
	iDG6z9sB0u16qZERoMNV43iAmdYi26N/ij6e+uC8G9KG+FLJezWXwUsXfIJTkoCQD5M=
X-Gm-Gg: AZuq6aIaqdV5+ao4iBpo+RVde0lOVeOTQwOkXr3dvHRAS0dIqIUUqbJMCeAY/KMO+dM
	j44N/fASCqT/ms1Vq7DxyyrWBRss+Fp21DTgItSqq2c9ai/XbkN+VeBPRf1oPuATyUWzf68ReQN
	kTpo7SxpoikQcq92mBB90ny/JLCl68/xhKW8rDclaQfeHyoFpIEfwMTl+cwTPEFq3R0AL+rnGCQ
	Cryqd0ZUkxJSRkV7vNZLYkGH/NkRqhMbWUs/hkjuTh2KMeb/ShNAKJdBHHGoghEd7JXu6Xqarrs
	I2Ix7g9RUO32nun5X3CzpIEyRfpNM+NVvPHq2B39XbrVBnoRD9IOt8LrzGNeT63RQyxVj6/N0Yl
	8joZ5ukHLEpbCNfarUs9/JWwMjHsTadVx0IloJSf63iDnDm0MKidnRoX7A1Y7GIQz1eJJZJV7cs
	P4utfx+6+dn3DzwzIEr+M=
X-Received: by 2002:a7b:c3d5:0:b0:47e:e38b:a83 with SMTP id 5b1f17b1804b1-483178ebf8emr52443975e9.7.1770369574701;
        Fri, 06 Feb 2026 01:19:34 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d8e8d4sm112369355e9.15.2026.02.06.01.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 01:19:33 -0800 (PST)
Date: Fri, 6 Feb 2026 10:19:30 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Moshe Shemesh <moshe@nvidia.com>, Shay Drori <shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Or Har-Toov <ohartoov@nvidia.com>
Subject: Re: [PATCH net-next V2 1/7] devlink: Refactor resource functions to
 be generic
Message-ID: <f56e4xngd6byd5gta2hcvfzwwntqbybpbbqv3nw2i7734cc5kx@vwaqvacwxiyp>
References: <20260205142833.1727929-1-tariqt@nvidia.com>
 <20260205142833.1727929-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205142833.1727929-2-tariqt@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257495-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,nvidia.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 08AF1FBF88
X-Rspamd-Action: no action

Thu, Feb 05, 2026 at 03:28:27PM +0100, tariqt@nvidia.com wrote:
>From: Or Har-Toov <ohartoov@nvidia.com>
>
>Currently the resource functions take devlink pointer as parameter
>and take the resource list from there.
>Allows the resource functions to work with other resource lists

s/Allows/Allow/ ?


>that will be added in next patches and not only with the devlink's
>resource list.
>
>Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
>Reviewed-by: Shay Drori <shayd@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Otherwise, the code looks fine to me:

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

