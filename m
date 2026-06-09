Return-Path: <netdev+bounces-297263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MJpOImdwKGoEEwMAu9opvQ
	(envelope-from <netdev+bounces-297263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 21:58:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A6D663F9E
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 21:58:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=dama-to.20251104.gappssmtp.com header.s=20251104 header.b=WpIrqjL+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297263-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297263-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C1F430EC111
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 19:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8AA37C11E;
	Tue,  9 Jun 2026 19:54:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F6236495B
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 19:54:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781034877; cv=none; b=ohGzAAIFivCd5zPeZTBlTBqX89++mtngkLTguvZJ+6DP0n6gKADMRImpLt8oWovdjuQJeu5vjFo/a31oiGvyY7sSWe4ENoieJ69VSjyAbtCwYlUrtTXRI8sNbNv8fgDKb7C7inc0yRKXjMojtcMB3S1x3VSZ7eS+8TE6ZJ4DK0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781034877; c=relaxed/simple;
	bh=3xnCFiwxO16Y9VzNXXYKEYs0FSQlDolB6VBLYuJ9zk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgh1ZAek5p7Q2e8rzxjY9oK4VCaaRg4aVO3XfH6z3oHk0ipHxdN5ltjb9gOz9pp8WNVWB1RT4pyyHaORo1ZdG7Dv0hImEk2VGroC+d4TIqNON9Pt3kypai1g2b38pb/839WEHSEWse9Wg/pSg0pus5RNaTXJzzPIaJE3FIdJbwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=WpIrqjL+; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c0c2c7e0c5so40661815ad.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 12:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1781034875; x=1781639675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qtHL6AfuvT6c490Bz3CZQZfiaDxF8fCiU9SZX1nVkbE=;
        b=WpIrqjL+poY0IuoaQczPOeqXnvmtP5gnz8nZNkhNdEgl/jd2KGyInLs+LVM8KKLO6F
         5wKVM2ZKvWNgpoD0EBI5850afAiHsfXOzBtL9Cbe1Xbkp6vJxYIrle1usLKgU8kLCYTm
         0E5Rh0020uSyn9btasCPw5jnOjDDYI2tAdicOhCTsZZmnF8QLBVDzJtpGdoR17FUccP7
         1nBdl2nbLUn7jQckpajVtG3xM2kdJoRYUiQTDbV01uOJtIDBfKipTeBa5UZjoKuzP0jT
         SMQyVV38uCI6LsgMryeC/GrQZOLRdMPG2suEo9+i3YvXk17/beNvb4EQt+wEkCz03/5f
         owOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781034875; x=1781639675;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qtHL6AfuvT6c490Bz3CZQZfiaDxF8fCiU9SZX1nVkbE=;
        b=SU1tmVyJn0RfsvXiN2vC8MprP6xE4uaSusoyt0PjoOM2/eku5/dLE/waiE5AzHGWiI
         PdSSTNLSOsZgt1yz9xJMDWb4IBhSWi8gW98IX7afSUckGOfot3bQijASUhmPDjazxUBA
         iryrymavrSlWt20DpFZV5LWdYsS3VHG6uLJiJeJgdSC9NN+MW2cv0lGhgBlew3KN92Vo
         tpw+m2YU/Sm7ilvsY6t0ZinC1BHGsbFeIinp6S7HhYbTDTo6SBQFYCdX9ML3Ug9/+kMX
         OVy7t4zc7njpcqPsmPpr9NEVQmKgyb1+0BXaRQgofWcW8OHNfzkSbfanRSQ79Tu//7+V
         yCTg==
X-Forwarded-Encrypted: i=1; AFNElJ+7diypmcaznyBFWK0DcAhrau/lFyPjir52eJ3tLPSNE09gfl8/St/bbmf5P0jcokUG8yhM5g4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyib6kREJWnOzRnamO0MV+SiTRvh0QPgbtd2SyfDqH47/w2Yhn4
	yYExFe4eNjg4gRR2oXkFq4SR7SXEcb8DF6UshesHKTNzhQzzBu1IEBedDhIGof5TxGY=
X-Gm-Gg: Acq92OH4/YeJwLBu6TVUqvX8ZZjHQMek1uRPbyr6MXJY3MKYSfk20NITBPlKAZfo12u
	9dg+1LPKrl2/ELAsNZoherDeeGPrCQm1cqR+0u0RLF716wqSCFZ9rYDMUp/Pf4ZKAfKKc+B19sS
	hU33J1YQRUupJcy9F/TrsjOEnJu4p7z/B4SKBQAPR5wf1Cd+97BuhBtGEz7QnNvjPm97RMdnFZN
	zy2rcJkdUTCMa9W+axAyQg0MKpgXQSqvHn8hLFZc72yl/m70T14jVGoR13oVhsjclA4XQ7czuR5
	lb/yTuq6UK9a6moK3rmm1QUFIjTVZDRy8O8m3/brJfpHnqdkLkOmyEHdIvZ9KqTIX++MU+NurdS
	rwbnRWXFGJDaaUvEdp7ok6dMmIemAwF/3duZ6pUj6opX5b+QM1kzpFvQN4gGsOfXMLnyT38U8Sb
	Rq/uHqZDy03DFAGThUukl2cr2zOA==
X-Received: by 2002:a17:903:987:b0:2bf:128d:f7ff with SMTP id d9443c01a7336-2c2a1be668cmr51148805ad.16.1781034875215;
        Tue, 09 Jun 2026 12:54:35 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:42::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c24edbb49bsm92990365ad.38.2026.06.09.12.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 12:54:34 -0700 (PDT)
Date: Tue, 9 Jun 2026 12:54:34 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	dw@davidwei.uk, daniel@iogearbox.net, razor@blackwall.org,
	sdf@fomichev.me, dtatulea@nvidia.com, bobbyeshleman@meta.com
Subject: Re: [PATCH net-next 4/4] netdev: don't use dev->flags for IFF_UP
Message-ID: <aihvettu3tpPK9i/@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, dw@davidwei.uk,
	daniel@iogearbox.net, razor@blackwall.org, sdf@fomichev.me,
	dtatulea@nvidia.com, bobbyeshleman@meta.com
References: <20260609190804.1137085-1-kuba@kernel.org>
 <20260609190804.1137085-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609190804.1137085-5-kuba@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:dw@davidwei.uk,m:daniel@iogearbox.net,m:razor@blackwall.org,m:sdf@fomichev.me,m:dtatulea@nvidia.com,m:bobbyeshleman@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[joe@dama.to,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297263-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:from_mime,dama.to:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,devvm20253.cco0.facebook.com:mid,dama-to.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1A6D663F9E

On Tue, Jun 09, 2026 at 12:08:04PM -0700, Jakub Kicinski wrote:
> dev->flags are not technically ops lock protected. The IFF_UP flag
> will not change when dev->lock is held, but other flags may change
> so KCSAN would probably not be impressed. Because of this we added
> a dedicated dev->up which is safe to read under dev->lock.
> 
> qstats want to make sure device is up, use dev->up.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/core/netdev-genl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Joe Damato <joe@dama.to>

