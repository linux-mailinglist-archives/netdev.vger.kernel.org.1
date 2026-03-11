Return-Path: <netdev+bounces-266624-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGGMAN5XsWmGtwIAu9opvQ
	(envelope-from <netdev+bounces-266624-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 12:54:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D3826335B
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 12:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD2893014C3D
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451023DD526;
	Wed, 11 Mar 2026 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWWRXpiq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E7413DDAA
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 11:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230043; cv=none; b=n0Jv2nzbXataIGYVmWh9hXEUS76MsCKDQgaKEhXGDk/NmzfOjxPH8lgDH8Cx4ahLQUpj0RCHO1MluI3Hnisb7FZzHp59IDOKbLAQFbsWBaI6hP5Gkpgh4mVfSng2uzn1dkxSjApl1nd/YSuBDav55Kt/BlvIFDAmC5KUCkVdU/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230043; c=relaxed/simple;
	bh=TuYlb10rCFL8PwMrHyGpVLx9lejf1x6yL5QyRJrZinQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7dQGgR2Rvgn4If5DJtX1FkYCkgcOpZrolxOTjyEUpnOPv2fDwYC4DZED/n0t/rex+wBDo16byqL77jnzT3HfYH6YKlL8jMt8NUNxqg1kit5/ZBRb8L/DN2eQPmqFyyrxrXhZZKS6MTaATyllyeF4hE5BoPaHBgsb1Kl0ppe4xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWWRXpiq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-485358f43e7so1656615e9.2
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 04:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773230040; x=1773834840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vAw6q4XY2+b8zt+2zhUzdOZV9aAh8z+HL3jAW2Wl3qY=;
        b=HWWRXpiqc9Vy1Nsk6TXVy+T2R/YX/dictHGrXVvIZoR+78AyCk0IrJPg1PGFa+F3x3
         WtwFGnu2DQuJfflqVcoclDJqNClvAnXAceQnw/fkansLqh++Ez3my76Rvc4dPEEdnAjz
         1kdou/Bk4mtMo9L3VcS4jwOZ9zd/61oUxgCWm78AYntcqfWVOGYc7B/O6yhLC29IWrdT
         i1u8jYBVgA0SKObE2j+c/hdidjTdPGGcYXf4gdG+15lChSwM0AAnDCqPGg2G5MitLXL5
         zL5BUvu33o5Z9GKRIBQrKad8AAftF+vVKUHLE6T+LbIeiwirj9CmHXM42d9COBNMV6lc
         LwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773230040; x=1773834840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAw6q4XY2+b8zt+2zhUzdOZV9aAh8z+HL3jAW2Wl3qY=;
        b=BBnhGK7OCbssnOKitKR4HGmIzp5O3bEHWITXR8lqb94LWi957p8ERfJX3JajnXojwX
         t0sy8Wxi0T14S87I0SNmg1YOdE4ZOkXu5I5uNcv12CiB3FMvPC3FBwy+KhPsOov5tBJL
         4ZemGLwEMoOwpgxwPnDQdq/v21AOe0UUJfu8wxXrFB+l+5XDpYaG14ArwsxLSotT9t1E
         33JZCPQK6SgKOnysqW/h+1cN/5RZTpg1tgZJm2Fy6Xx3tudIhMZ93yw/U/VhQPYUak8R
         LQLRjJQGVNIEHPEeqv9iM8ZITxdepn8M+B7JroT/JaH26G64XbXoTA188OIglcvnaoPf
         WyHA==
X-Forwarded-Encrypted: i=1; AJvYcCVfqudmw1MWMQojBk6YUV28VVLROux1G6KKg5/e0C7J87jtZ2qalxC+WF9oc7ZihChHPIdXPyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPbFlltuwtjj9qYFTQ1kJkO0S8Sx5asKOMvg/C8exikl6x93Qd
	hxUUGQNJzjTRD2tvy5fkEPHYzoJ7HaQRArrOD9UwxP/fEzjwJ4aLZnzN
X-Gm-Gg: ATEYQzwWurkPNVYZ8Y0WuVfnmNrkjXzsv5YsGplTv3c5C8zrRL9sarrDsCprj3IkzMO
	ooQGU2cTFtiYHV47cL4cTL3b4olU14ETK6rYYKtcFwKr5xpRwfIwziN13ZFv6930iRsNtdf53vk
	p82b9aJoOBoJdVd1edLdpJXqgBVPYqPGDLz8pv8ZEVXvJmEnPDfaZ9XFL8IJr13z8J29WSH/g1e
	5E94tQ7Eivjcc2mD5UMzRED0TW3DeCp3LiBC53SFMEOf8uK/fsWLNJ0jpQhRToi/pMp/8Z1HgD/
	DEimmeQq3cKEVX+h+AfTigqyJsCsZmRlVrbe/3dxB0Qec3n6O6efrqON25Evx8HzU+0FLxqs7iG
	aNZLeOFe48FM+JpnYdqki+AECfQcpFB2S4NZqGjqYFmbtn6v3jvMxY034IPGRiab+KXV1qAtN7d
	QgREF00YxBxbjtzQ==
X-Received: by 2002:a05:600c:c166:b0:485:2a02:38d with SMTP id 5b1f17b1804b1-4854b0fa222mr22550215e9.3.1773230040064;
        Wed, 11 Mar 2026 04:54:00 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d00a:e00:43cb:c21c:efe7:d225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b6756e4sm55180555e9.15.2026.03.11.04.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:53:58 -0700 (PDT)
Date: Wed, 11 Mar 2026 13:53:56 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Woojung.Huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, horms@kernel.org,
	pascal.eberhard@se.com, miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com,
	Tristram.Ha@microchip.com
Subject: Re: [PATCH net-next v6 1/9] net: dsa: microchip: Add support for
 KSZ8463 global irq
Message-ID: <20260311115356.windefb3j4kkuslg@skbuf>
References: <20260304-ksz8463-ptp-v6-0-3f4c47954c71@bootlin.com>
 <20260304-ksz8463-ptp-v6-1-3f4c47954c71@bootlin.com>
 <20260305095656.vlyaztv6nbdqrmil@skbuf>
 <98944cef-0877-4fb9-83a0-92bbd3852f66@bootlin.com>
 <20260305125149.ejju5ptrkviqi3sm@skbuf>
 <a3a915af-5190-4582-a3e6-4ebf92a7e35d@bootlin.com>
 <DM3PR11MB87364DB5439A20F44AEB690DEC7AA@DM3PR11MB8736.namprd11.prod.outlook.com>
 <0658868d-671c-46a2-8daa-26420cdd2975@bootlin.com>
 <20260309205401.bk5fpw6kqnmlktbu@skbuf>
 <dde60639-af13-4653-9a34-38c4bd98b149@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dde60639-af13-4653-9a34-38c4bd98b149@bootlin.com>
X-Rspamd-Queue-Id: 53D3826335B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266624-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,se.com,bootlin.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 11:02:35AM +0100, Bastien Curutchet wrote:
> I, more or less, managed to fit this PTP support in the current framework,
> but the next series I prepared to add periodic output support is full of
> is_ksz8463() branches. So I think that I'll go with what you suggested and
> try to move the KSZ8463 support in the ksz8995.c driver. It will probably be
> cleaner this way.
> 
> TBH I'm a bit lost with all these KSZ variants but IIUC KSZ8463 and KSZ8995
> both belong to the 'old generation' of the hardware. Maybe a good split
> would be to have these old switches in the ksz8995.c driver and keep the
> rest under ksz_common infra.

Wait, to make sure I understand, you said you're going to rebase this
series onto the ksz8995 driver?

