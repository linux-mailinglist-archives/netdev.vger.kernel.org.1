Return-Path: <netdev+bounces-271845-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKwrFtnDxGmu3QQAu9opvQ
	(envelope-from <netdev+bounces-271845-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:27:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CB732F619
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 764E1303DF69
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 05:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E5A374735;
	Thu, 26 Mar 2026 05:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Egt3Imo5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DC41F099C
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 05:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774502869; cv=none; b=KkoO4ANGwAILZ6Ab9rVaxO+4QpPbjH+GTuCwTFqvmdvDTRTh7ngdbDMazz04BMgiNTanas7Q4KAQPqgh5ylk3M8hzJ1ed7U52ehFpvCzjhQxIV5jERx+6Q/ROWyC19so6W/lbW+3WzgMTnCq+hwsA25kx9OVFRAovE72wG+JzzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774502869; c=relaxed/simple;
	bh=4XYrGFNpPeO8IPVQDMkwn3E8QxIrjN/c4P7ZfXQr+zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QeYAbyEy6K2YaOHTtGKVKzdGhLIBqCl7Dvor0c+v3C0lf33iuTN+9dI9UmwgLhiL8/0Zx4idZ7oP5dua0fLc85k4RUwz9FhTG9rFeOdfE6XAaErBGt13hmI1m5exHfSaXy8YBP5SmefbLtvEimdcpPazoi2PE6kHit6gcwA773g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Egt3Imo5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48541edecf9so6417205e9.1
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 22:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774502865; x=1775107665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1rx491JK9llATf+M6fz3SboKhV4th22ZRjEhbysEvmY=;
        b=Egt3Imo5hr1TbUPeSDHF3SIJqz1vOdub03YnyWh7oAPEXZvIkU2izRle4yQKIWLmGT
         hLLtod/I47dvamOl/m0KKhsiVAdmqfQjhm0I8FiVZ6rDhGqKOY+a25Id1JrL5fqfRVow
         JnRAcHNOl6sho4K/gQiev8sx0cmDwTul7G7AFzxgFVv1FVu150tcqT/CbnHsJrPkbpBS
         Mgg0zBIApDT677qb0/X+fI2tmWJVus+clNZzcMEVXJBIKozmh+RFo5YsIGJIYhLFBp5h
         91/bwJhVwtfk1XTXrRqSLxqkwlo+y8iIgEIy4SRZjfWI4ysL5dPw3diqH4HeRYmqU8AX
         uSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774502865; x=1775107665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1rx491JK9llATf+M6fz3SboKhV4th22ZRjEhbysEvmY=;
        b=qRbC2cGU8lLxLWTUtw9N89cVtTs2KC+zOXVFv/uQoJgwGSq7CjWwUhSNnkRQ6wHz9k
         cTo2RjUnS8KRtyog6ZorLqrkrLXSc635yrzA2TLqU4AQ60xlNw0jwVLmynIUxpX3+0PW
         EJYihEkvyQe/5ZMgtYkQq5/AQNkY4Rnb2u27L5phLHcDEd1wgnAtugjFvryJcCfld+0t
         CrTKeF84hIHnHOLiElhY9r7KvRhM6AhwBKdfwDn2heu3wn9XFkh/gCOH+vyhosDH/DOc
         uDRtD5normtCsvt/hirB/cvDgJfQYMs6b2Xgde9ptZNFr7key3qnKVr2JiPdMxkWfv11
         FFCw==
X-Forwarded-Encrypted: i=1; AJvYcCXdZ2mLX7YqWLWNo8fjxrmlPm9Jr+f30I8ifSVQdT1d/56+hegNPXHHCk3mGmgHrQgl/r8+hLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrA3L9GwGwTs+3gL0/Byeuxx3DrSVuxe4ol1XQh2pIiZ25303M
	G8jbA1iwJU9q9zqvfmPmQjO7P0jBOlv9P+PFKczXWPuFvl8QF6RacQzZSj3aQabDMfn7Wp6nbF+
	k81Qz1HP7dQ==
X-Gm-Gg: ATEYQzyka5Ky/QSEWtQLADXH/6yyxZS9KLkPJAfgvLPy9bstw6Bu6p7Vv3zM4XsLbQs
	pvA1oBjv2XtV0nA8MeS7Q+aYLWcR/c7GjAD0jcTebgV27YNrDBQbF3BtBzp0xH3PZ0kuxrCdNhI
	eP+dTO11yjosHUEuYdRIP7f49MzrDk2HyjGHm0GaYiaGgsgDJAOU5NDXJrCGFpstouhHDJDVKdA
	7PiSxu1q/FMLXxwJqBYHph7nxxOo62QK9RASWzbfrEXLdIQQ3tn/6ztupxThyvqpF2Os0qYFxyf
	lrSy2YtTT3cvUhqxed1DPnSN4o+5uP5oG8N0x+bHqGRTSkBUdj48DhuP9YGFj8tZ3g+wo4wirNg
	jcQi2sOin/PYpbaMqVlss6XNHZzaVhtkORFNc8YtOwrgtD5K8d2L0XGFBom+8wt0jufTu4u2cMV
	l04jbH/II3UxWTCicpw52fLowl0cNMxHCiN70=
X-Received: by 2002:a05:600c:3592:b0:485:3bb5:92cf with SMTP id 5b1f17b1804b1-48715fea715mr97245155e9.12.1774502865063;
        Wed, 25 Mar 2026 22:27:45 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722fa8dc6sm6927555e9.1.2026.03.25.22.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 22:27:44 -0700 (PDT)
Date: Thu, 26 Mar 2026 06:27:42 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Adam Young <admiyo@os.amperecomputing.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next v1.5] mlx5_core: fall back to dev->board_id for shd id
Message-ID: <pzmrqxtzpvmkxibv7uufya5wd2pw63idbj7upst6tieq4vxa3m@xfy2qfgitnsu>
References: <20260325221131.1001431-1-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325221131.1001431-1-admiyo@os.amperecomputing.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271845-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amperecomputing.com:email]
X-Rspamd-Queue-Id: C5CB732F619
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Wed, Mar 25, 2026 at 11:11:31PM +0100, admiyo@os.amperecomputing.com wrote:
>Making the devlink device shared requires an identifier
>to uniquely related the netlink device and the physical
>board.  The original code used the serial number, requested
>from the boards attributes.   However, not all members of
>the family of cards expose that attribute.  The module init
>will fail on these devices.  As a fall back, the driver can
>use the board_id, which is guaranteed to be present, and
>which is unique for every board in a deployment.
>
>Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
>---
> drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>index bc33f95302df..6fa691aca81f 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>@@ -32,12 +32,14 @@ int mlx5_shd_init(struct mlx5_core_dev *dev)
> 		/* Fall-back to SN for older devices. */
> 		start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
> 						     PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
>-		if (start < 0)
>-			return -ENOENT;
> 	}
>-	sn = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
>+	if (start < 0)
>+		sn = kstrndup(dev->board_id, MLX5_BOARD_ID_LEN, GFP_KERNEL);

Board id is PSID. That is not a serial, but rather type. That would
result in 2 nics of the same type to share 1 devlink instance, which is
wrong. Better to just don't create shared instance in case we can get
any identification in form of serial.


>+	else
>+		sn = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
> 	if (!sn)
> 		return -ENOMEM;
>+
> 	/* Firmware may return spaces at the end of the string, strip it. */
> 	end = strchrnul(sn, ' ');
> 	*end = '\0';
>-- 
>2.43.0
>
>

