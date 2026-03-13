Return-Path: <netdev+bounces-267550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AB71AJVPtGk4kAAAu9opvQ
	(envelope-from <netdev+bounces-267550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 18:55:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A01ED2885D3
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 18:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FBC3327271C
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 17:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D493D090B;
	Fri, 13 Mar 2026 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="TdEPBI/+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8DD3CF67D
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773424275; cv=none; b=b1vxMJWfR1/hyHLCv3zdKJ3KzQ5EggL0enPM6kFSKn4j5Fsh3qc4EJYkZW8ybH+KVOP82ofhI6+u5FmXqtpdT1yxFdbD7y3c66adlsHzCR8rfIhbvnlP24lKIaUb7NnlNDyUCsxKIjbIE05LD+wZp2GmlLucvlygPCT2g0xRztA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773424275; c=relaxed/simple;
	bh=qvsKtgFzPXN+lLScDp+m8HgvSi6kxwQ4R4oo464TpwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdNDBGzC7EcIR3wZiGZKvyfvcywdu4sn6D3Cbe4/0IzRgTZLa9J83uQTWzkX1geqkoHWXVU1lKrzURn2+YqhvH+kqIkPLLgy0bEaopUK+NO0lfcMeYBxjfS2kCuljAgE0f/oYYL+2Acbb2fqXGRqwKDCPyZvJGS4AnDvyjrZQU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=TdEPBI/+; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-824c9da9928so1643800b3a.3
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 10:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773424273; x=1774029073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Ski0FE2bQULyvUQFwoDAaSkxf64xsZOdGRUr53F3qI=;
        b=TdEPBI/+wTxj8FSgNM94AUShLvZUM+8PlbQ2C8Gjjz0RpH2hnyv6fEYNl5iBN28Dqp
         612Z/Wgm9/ttkbD5spRPB4cKGP8ERi4/BwPFzZJFokeDOGu93QRFGw9arZRgbbN40CjG
         eIB6iyJxR5TVW5EJEu0lUXw/JS51C0nakPRPorolqjV+c7t/UgTSX4KUomuNsBfu1WEb
         NC2HnokmPUr5SYHUI+18g4ct3Xu1jAKjtDsocTE8AKJ+JjK987yoTMEetxrs/lh2jYam
         i3qKK2HRGGLgdHf+1tJcEmZGBh+xUMbYubSj2T2JLLZ8/zKvlQzLi2NcgR8jhOrPCrqK
         K/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773424273; x=1774029073;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ski0FE2bQULyvUQFwoDAaSkxf64xsZOdGRUr53F3qI=;
        b=dUG0Go6p2PdkBJ7YU64ngsRqahPNIfhizFVfH1THhRedwBnrjXX7x0EyUKd/OJzQ1J
         0r35T7P9qYk6/WgHo70Kfq0fGrjy6H3DxW6A9gI8IOVrZJ0i5aE/QtFm/l5Spkva92+4
         5WZqj6AIGaU6VCKD1M4algz/kEhN2Ytf3beLWFw92aobltEimGBTHkBsxMyFtLZKYoiM
         WTWmVV+CDXO+pxvr7YSpA2zsxfYyGcrCMRV08PTHyBSlNLI84OSUZwLthMGVZbr7gRZi
         mTWY1xN+s5piFzJynN2JRpkyhpg2EwIqWebezr36mKOtbri0LmUhXriFSkVJ9SkojRBH
         nP0g==
X-Forwarded-Encrypted: i=1; AJvYcCUCC3oA6OfvrQklcoAM2vjSaCEfp5juz+cDzWOUfrIgS4NIy9wDhCHsTq8l0fcs9ByS1RvFlpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YywTc1hZeZa2DGorJyeIo0N0QutOFumn5YNZriOVG13Vfp7HlGD
	n7apoLw1f1MG5M+DAFa4FDqu2Jyn/cRW4jJHw+f6lASHYDkAuswjQBnYJHY5ewy+Qrc=
X-Gm-Gg: ATEYQzwowtrXTgZB85tKZJ536J0kevcHgGdm9UgQcnPTxjnEEd98uKS+FIITcMgSSW4
	LfL33iNy8+Ke9KW06R5usDxRFSqbMwYDRVF0lsWdPQt/JhXS2EypuIugUs2a2w36+E0oxLQsgwV
	HTur3IEJfPMcFaa7Zxzd3cgQMLoSgcVY+dhwzeYbOqrNjMxClsgWaN+lz4DQQoW098b52y0Uu9g
	JGGmI4MO3u+DUcKmQU/m6PLILB7wr+rHDM85hBswQVQOFkeEV0W/4MNxwPTNdDEp0c81kkv881L
	AjdDWxsi610kljUX7mS8uiusSGkUa0yV6EPdWmSHlU28URc46sxkAbBc2BDPqZHm6J/JAj5hkoz
	Ijwe+tiLGfktws1oO3SYNRTIu2I0TyURp2mNQNkBE63Fr1qUcsjkf9TzoBPcPBBjQwdB7Hdk0Vo
	R4PGyO
X-Received: by 2002:a05:6a00:124d:b0:827:3914:f130 with SMTP id d2e1a72fcca58-82a198d0c53mr3634373b3a.36.1773424272713;
        Fri, 13 Mar 2026 10:51:12 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0725be23sm6290765b3a.15.2026.03.13.10.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 10:51:12 -0700 (PDT)
Date: Fri, 13 Mar 2026 10:51:11 -0700
From: Joe Damato <joe@dama.to>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Fan Gong <gongfan1@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] hinic3: Fix spelling mistake "capbility" ->
 "capability"
Message-ID: <abROj00x3K/pauRL@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Colin Ian King <colin.i.king@gmail.com>,
	Fan Gong <gongfan1@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20260312235922.3442120-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312235922.3442120-1-colin.i.king@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267550-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[dama.to];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama-to.20230601.gappssmtp.com:dkim,devvm20253.cco0.facebook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A01ED2885D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 11:59:22PM +0000, Colin Ian King wrote:
> There is a spelling mistake in a dev_dbg message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Joe Damato <joe@dama.to>

