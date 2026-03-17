Return-Path: <netdev+bounces-268604-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yK+sDZZWuWnYAgIAu9opvQ
	(envelope-from <netdev+bounces-268604-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 14:26:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A52E12AAD69
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 14:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0A3E30B0208
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F1B3CBE87;
	Tue, 17 Mar 2026 13:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="doUzSZJH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5A73CB2C3
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773753762; cv=none; b=qgJQEkuApA465DGpU8tSUR7oHYm3qeD/SWmZKpnBD16tx60dKEiqebXOhb1AzBS/BB+jYfehTS3duDDfHMKm0sh5oCuKtUAb4xL0giBtx1vq+gx3l/dbMz0vIql2ljZ51NfOBnFkfhnxx75GD8obIF3YB8Ha7O1Qd/3LZwpQRI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773753762; c=relaxed/simple;
	bh=MAPRBQrsmlR+ctLXsk0UD+nGbNi7DGZvwoI5nYD81WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAz5se4apFvWQ/Rgd8cD0A/3tFO+5zRKMWCoWncVyDvaJUAm76jmGNn84t5ZkxBzqi6blT/SIF2HIU6zHImBwURMH4wcy0QBALru5Ahy171zfYuh+GtwdqM/hy4OMV0ZX7CuOurYAt25yP77joZgMUOpYots1CRD6UEbaV/CYuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=doUzSZJH; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43b41b545d9so2949463f8f.2
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 06:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773753757; x=1774358557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SjtHn1mz2ERVQdx3tsJyIVFy5VgkRZINLg+TTVUhtdE=;
        b=doUzSZJHWYFheR6Ton0zwohLWxTO02JjcvPQjQGtpXjdwsi4AICVhhGS5S0LXAUSmc
         II4So7/aHF8qhwYyrGIT8HvaYHV1UGq8Uen/faKn/ZcZsWCkR2oxX1e5omi2BrhcU6vX
         5pc50kKs3AMpLCsNZ1xrv+gS9O9oxnBdlruA07UK+f75gFl9KYVsjm0GHZCSWkNr5AY9
         vI/Whn9lQE7326T6O7i3w/Z2zKWRwBg/86arTJwoiWABDplaz4KdFxP4EMJSCUV3Rs/o
         s6YUh81x1WALkIMR/l26H2dH4Ui+RSYxDmk+td9dvNnfacFiTqvuBghHF3zW2RqC9V78
         /fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773753757; x=1774358557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjtHn1mz2ERVQdx3tsJyIVFy5VgkRZINLg+TTVUhtdE=;
        b=fb+96RqTSTy2t0YQZGVwQlrMoec0C+h4VlkxSjSjykgdRMtA+TTETleb4xMVYMbu2m
         KZ25B/LPWodd3/JGWrv1Ln0xq6o+jRj0JRYOyOAQW1SIVItOpSY9QHHcDzg73qyi69ar
         ZmrhSBg9aOz58tVXPDDTczkuY22VpYS06qFeWC2yZo9W79F8Zb3i6m37FGEaDMTmbz6S
         cJPmBOU58X/wLEynvrvcycu9SBzBVtpbwAGbK6JEzsrK0cge6K62PRcY9TVdiq/ZK3tr
         XhWJtswdfUoqG4DCEOsRsV8QkgfToO+3427/IRmQ1MH04pM8DCMzmA7ti7gn2bj6Uqce
         bgMg==
X-Gm-Message-State: AOJu0YzErCyXYgsnapeSvNQsvDdMeT2iWVKiLTFelcoHNPaAe07S6vxN
	5xk6cdVs+/7rjI7wXmPZYiOcOP1CZZ163utYCePB3pY24vfhY/1Vi/wwqQGWugtuqec=
X-Gm-Gg: ATEYQzySTFka15UZEV1Ey2SL7k6AUZ64x9a9fB3keO4RxMKXesNt8aX0pAZ6mVeNbzK
	JcIgCiq7qYQT9omAdJ9C52CAC7MQ5Kit1HcOFW5KwAuoubqpPA2xRGxqHTCoSaFIXzBmNEQHVdt
	hNvcOgziO359+Cw87hoqZj9Dw3EAUV1NWgFOOrcGJ9RR2u+ngMUv8ZY1ingO9di/MWJzTZwOeJG
	7sVvOO4zPZOYEsDk7DwHcT6wm/Iq6L/yPK/e982/XGU66b96rIS1+6udTtEgMEqbDQWoMy11MlJ
	ibAzbqxHFyeSdH9IooZa7FdLz2IjNJ/24QbvxIq9VEfwfhY05sjsHDP+J1zTALWC0wf6O+yIfoi
	r8r3mdTyRs0spb8hMSgrS6H7RUnNgz3Lf8MDu5O0GK86+hYSoGd1kZf3+1avDAArgl89M02Y5PX
	Rt+70Yx0d7X96lACLO2v+lzZsnsRZ3QB75nwmOIzsL+w==
X-Received: by 2002:a05:6000:2912:b0:43b:4e13:2220 with SMTP id ffacd0b85a97d-43b4e132b9cmr3563285f8f.41.1773753756316;
        Tue, 17 Mar 2026 06:22:36 -0700 (PDT)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe21b631sm56946650f8f.27.2026.03.17.06.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 06:22:35 -0700 (PDT)
Date: Tue, 17 Mar 2026 14:22:32 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, donald.hunter@gmail.com, 
	chuck.lever@oracle.com, matttbe@kernel.org, cjubran@nvidia.com, shshitrit@nvidia.com, 
	Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH v4 net-next 2/5] devlink: Implement devlink param multi
 attribute nested data values
Message-ID: <f3l4lzzumqlkluikqv2a3fopzotgjnoadnbzqoc3wllgew62zy@jj2jaseglkop>
References: <20260312022754.2029595-1-rkannoth@marvell.com>
 <20260312022754.2029595-3-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312022754.2029595-3-rkannoth@marvell.com>
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
	TAGGED_FROM(0.00)[bounces-268604-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,oracle.com,nvidia.com];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:email,nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: A52E12AAD69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thu, Mar 12, 2026 at 03:27:51AM +0100, rkannoth@marvell.com wrote:
>From: Saeed Mahameed <saeedm@nvidia.com>

[..]

>+
>+	case DEVLINK_PARAM_TYPE_U32_ARRAY:
>+		cnt = 0;
>+		nla_for_each_attr_type(param_data,
>+				       DEVLINK_ATTR_PARAM_VALUE_DATA,
>+				       genlmsg_data(info->genlhdr),
>+				       genlmsg_len(info->genlhdr), rem) {
>+			if (cnt >= __DEVLINK_PARAM_MAX_ARRAY_SIZE)
>+				return -EMSGSIZE;
>+
>+			if (nla_len(param_data) != sizeof(u32))
>+				return -EINVAL;
>+
>+			value->u32arr.val[cnt] = nla_get_u32(param_data);

Now that we have UINT to be used everywhere for new netlink attributes,
wouldn't it make sense to have rather UINT array?


>+			cnt++;
>+		}
>+
>+		value->u32arr.size = cnt;
>+		break;

[..]

