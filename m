Return-Path: <netdev+bounces-275697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLYGKvf502k8owcAu9opvQ
	(envelope-from <netdev+bounces-275697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:22:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ECC3A6254
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C4246300C7D7
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 18:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB753939D9;
	Mon,  6 Apr 2026 18:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="n5DKFsXb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BA639099E
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 18:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775499752; cv=none; b=SRmjcHtTupW2MigcXerSwj8IX9DE5xKajjxzBl8xfT2KdQvhQ3Gjm9M8KDekh2cYq5Rx4Xg8bi5k/GXDnj1WsW1NaJX7u1rLych7t1X53epKo5I2OretYeL/3FwlIKIl9trREYODxR6zxFZtTCFV+01pt05aLbcH17gtuXLDOPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775499752; c=relaxed/simple;
	bh=B8brx8enrGAKNK/GTZCZ9+CebemN9//C1P1BW+RdNSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSkWtbwRUbdjYCf3oFpd8Vvm5x465kx6zEhgLl8fFcc7cBslHOmj8gR6e0D77K3TAZyQbXVZL0Nl3SFHJCDAsPgybwLJD+8rCI3PkU5yap4IsFsCUwnprmpLKu9EYZwEzrctFozUY5vf6M4NT5WOzG2A/CTwt171uY/caJcOsiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=n5DKFsXb; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b0ba3bfe16so41328815ad.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 11:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775499750; x=1776104550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/gVcY2SMYwC6mQAd+Ffvz0fZeo9R6pSPs95jEm28w4=;
        b=n5DKFsXbjFTtorAc9GnodVWTrpbH6Gv0tUGfS36C30VmT9hjkU6XUfxGxIAM0PB6FB
         lNqnnmYy2wPL4PNW9JWYEoZD6QjE3ae+cVZbJcxWzbvgdJSVvU5jNi4uqMG1Xx8UItOn
         FNfI19UzPFyn1fbwIYx9yqvnXxGpiOIVnhYDB6XlSBfCPAlWfSFSlJ1zk0KGRXt8zSh8
         dJEKCys7+wgtu93YZWEQbyQA5RA92Vw0nMEQADz/6f0Y0jcyRue34K+3Etsp5KscShFJ
         U38kPjfvBJjCuIvI9GAop1rt9+D17mj2Wj/1N3Bkk02sullm6qdojMxqiwP41WSHFNs7
         Halw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775499750; x=1776104550;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X/gVcY2SMYwC6mQAd+Ffvz0fZeo9R6pSPs95jEm28w4=;
        b=roOd69oEd1f1azKu0DZ2Ln09ewKn7765/rZL2WX81/BGB/s7wjpSVhSFbeffmBqGrB
         djIE9H+/UHXT9N4Qh8Pas49YU9cqh19Sde/jGpBJ7hxmXCme3DXIHJHCLfMxWVY/92F8
         Lxyyspgmw2huyOvsMzmMOJzAi5mc4R1fU/r1T28Wro6MOE09hDhyOCtpT48zcEHpJY0r
         PMt9vXoyXpQn+FY4kwR0xQMRJaAT/wd9C7fqhCDQXMM2zBInxvl12pXU920vC6gkUc/u
         yEcnztvFT2YX9I0fYN1mYq7pD5bHzv1d/nbW+pI3pZYnUOakU6vLJ+VBcNhBKBuchzQt
         QFBg==
X-Forwarded-Encrypted: i=1; AJvYcCV63TQMK4QsR00Qr2B7sOKyNpMx/MeXNtN2GSbKpa9+Fv/dTmQFyh304l0t6fr2NC3/t86NWqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/SIiWPwykX5xOZaHvsSYYovRqBQdNFmRzj3t8r4L9U/LjHBzY
	u30BseX75el88ixmjtTwdVTBw88+tVnmpxKeP0Pzc2wVmXy5RWWluEF+TvJrtR8f+Ps=
X-Gm-Gg: AeBDievqOUjndsif4QZASamExzd8BS9eXBu0vfXlhUekpmXIKyj0XZ+r7lEX0yTwxFG
	7zP1I6MO8plbyqqp18HnK29/HXYlkoVlyKPr0zS1sgihnp2CV8kpD93QIFcPJN3L7zDah9lGw3X
	RnV4Xbepit8khRAtQ60XVCpMK/TjpCiKAkkzQNtSqQ3L2dSJNgtEGcU8SvzFjns+bXCeiZoJvqB
	wAFIyBkG0fkI0P/m4fEA2WggPlZaFX6OjuWFnDj/c6ilMfz1pIhR6Ws26fdgs8J+UUIg68GK+zH
	PCg0ZbqECuOt3TzMMRWLqHlSJVbXjoICrWmdeg+3mkC9+6Tv4dX2J6BymzdBbb2r+5dgB4UaL5D
	pz7QQVFGkVCRroOz4AgVvzhVjQqwGp4lHpkCsZCz4/oTCST1Lc6Rb5TQAvUxPbhIRQPxIw3TSHf
	1YQwiZ1ruPM+xT+2I=
X-Received: by 2002:a17:902:ce0b:b0:2b0:c060:aab8 with SMTP id d9443c01a7336-2b277d9b788mr149553495ad.9.1775499750169;
        Mon, 06 Apr 2026 11:22:30 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:47::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27475bc2asm151273645ad.19.2026.04.06.11.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:22:29 -0700 (PDT)
Date: Mon, 6 Apr 2026 11:22:29 -0700
From: Joe Damato <joe@dama.to>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: dropreason: add
 SKB_DROP_REASON_{BROAD,MULTI}CAST_BACKLOG
Message-ID: <adP55WGtpzoEGXek@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
References: <20260403022443.3480770-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403022443.3480770-1-edumazet@google.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-275697-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,lunn.ch,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,dama-to.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: A1ECC3A6254
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 02:24:43AM +0000, Eric Dumazet wrote:
> ipvlan and macvlan use queues to process broadcast or multicast packets
> from a work queue.
> 
> Under attack these queues can drop packets.
> 
> Add BROADCAST_BACKLOG drop_reason for macvlan broadcast queue.
> 
> Add MULTICAST_BACKLOG drop_reason for ipvlan multicast queue.
> 
> Also change ipvlan_rcv_frame() to use SKB_DROP_REASON_DEV_READY
> when the device is not UP.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  drivers/net/ipvlan/ipvlan_core.c |  4 ++--
>  drivers/net/macvlan.c            |  2 +-
>  include/net/dropreason-core.h    | 12 ++++++++++++
>  3 files changed, 15 insertions(+), 3 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

