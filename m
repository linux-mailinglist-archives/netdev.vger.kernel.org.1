Return-Path: <netdev+bounces-274632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMvkA3ChzmlZpAYAu9opvQ
	(envelope-from <netdev+bounces-274632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 19:03:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D29238C4FF
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 19:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02881307784E
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 16:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D383BC677;
	Thu,  2 Apr 2026 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQ1qS/1Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420C036DA0C
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775148842; cv=pass; b=j2U4Xb15bMUQZ3TAOaomEyp4kYif9dvuvVZ/G9t/ysOWN9cyqErVNT5Jb17vOUy2m+NOgywh351Chi5DbLkZTltD9ds5VblKGVObNAQ78kB0OMhEsurqFi0HzboBh9UXkTzRICZiZvMVe6mWRR8i0rVBcpIdKH8ysirNiH7ZJRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775148842; c=relaxed/simple;
	bh=YQHOj/bnPK/nIDomsOi7P10E15gaCTUx4OYWYgBgufo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rRmuKmQE/w0dQgtyQn8cXbl6A8fY8+FmyNFF9mDq2zlz4iPdc+HppIUn0nDfCZ9MSOLfQSu0hvJzJMOG+6YVG3vkmswuoPf3wTstYquQFBYKCaCQr9moyfIomAbmB6TOeIU0ZmvEodhAQrogHcRHW/6DBbOn0DTkQClcd0Yo0bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQ1qS/1Y; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43cfce3a195so713287f8f.2
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 09:53:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775148836; cv=none;
        d=google.com; s=arc-20240605;
        b=WJZBvHwEEVq3JjjYSgAOkZcw2OpGhLrHqSXSEiW46v3H7khYjga3lvWgz8YUUuze9L
         UqWUQYIskNTOjoXfAXb3+nftlXo1nkouqs/QCBgM/4v2XTgz41RSl7Iit3l3XfCvRH24
         5hPOFhx8J6fL1g2J423L2ih1NPbED+p8w+tFUy9NzNPZNwzU4n0nzszf6HMkRKROTHwn
         9EKBOkgX+E5dJLMkTWLnCjz+13Z2IGXSmMonTM6DQ73X/iJzsC7uQ+OTO3euGYwnALnG
         7uNb+DHZ0jwhXmU1c5stPobkQUfdsXGhA2M/rhxEPuJEBH+jHBfSOiW580frM0UOtHKY
         SyRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YQHOj/bnPK/nIDomsOi7P10E15gaCTUx4OYWYgBgufo=;
        fh=yPgEh7J3IKlPKqAl6V/9n5nPRq3VrU6EuE+uap665dU=;
        b=ehbmRKornRcUFCDsbGKmHAtUt19w29TiX9VCUz3WS89rH+aOyHj66ujz2Q1t9g6Lm1
         0oGRHr2tbPY26Ca9wOAzU8jsWdeAstKg8LRV0CNGNKYLDx/Nbqve/9rF0Y6AlzWi0bXq
         CESNtMasfzVo0G0a4U+xJP1ti7jIFuVmFjV8ubxKDT1eSli5DMX/vKPAMjojVEGjoB0f
         NjulQMXj+dOC3FRyHL+9bEKARd7pipZZB0Cg5TZKFt3BXITwuf82FNkK1WAlUz0bKfq8
         M1l0Ru3xvPSliVTQw36mptOlo5t7lyv/6QzjRhSVDxUxhGZfzfVoEPqyf9WT1YBKWSla
         DOKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775148836; x=1775753636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQHOj/bnPK/nIDomsOi7P10E15gaCTUx4OYWYgBgufo=;
        b=gQ1qS/1YA0agK+v2m6lwP9L10tKJmlyVhBVKetXJ0JKx0wwv2Rl/IvvMiYW8JbFRYW
         luUZbAyVylQjfNUk2JzwzM2ZRxL7RaToiPHhgqhP3StSausa235cDguB+DeID9YzFnBH
         wiEmtbfImNb4nTQKAebiGvwSe2orLHP0vhd7QaL0MqfgBIgja8iWZ5bWKtIYEetiOQ1S
         19f3b+FGePVkW+asHcNVGhkR6d/zC8wBh8Qdo5OnmmDavKbd0T4lzFobkMJ2zVJkxXpX
         q8eeAL/zijCI98ATxAbdjZGmrWKkmefe7tMn5bDDxj643zlB0iqA6ql8D9tVyn+rKYFS
         16QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775148836; x=1775753636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YQHOj/bnPK/nIDomsOi7P10E15gaCTUx4OYWYgBgufo=;
        b=Clg+4GZFrlWHvDvVZxGAd7LBqbAlI7lZdIZOfC3gPrEuxY1CRL9eBhnsIX2E61sp0L
         QyZtG+I6MxtUxB0R0Fl/H3d4i+PAdzqT8fELZ1HLxm0kj5M3LCV9/sTZjkKfbpzMxovr
         mYo7RvFn4UfQ4kwOxD7mtEFM8BIQaRZlh5Zyv8625y+49pp27zBkZ6vjEExal4T6vfFt
         WMKWeoM3NL/qL1oaFvms2u1Z5nmNnmjGgk+JfmEwPqL9Cex0PsX2x9groqTDqDP7j0aa
         GAgVPU3CwPeQ7fix9hHUSwbKbdlFARL2LNX5uEtpT5HtHLh7L0au2z+4SQBt4ZqNJm1J
         8ALw==
X-Forwarded-Encrypted: i=1; AJvYcCWEFu2xq33KLzO0yBN9UnICJRLisVko4u9EbaNzGwtPe3pN6FVTaftZpvaAHR+XUED1dkeYhiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJGIMfU9AZDqp0wn9bWVfp8ku0rabWYx/MFm0lWdoBRdbkLuzN
	2NIRgUVH6I8GTDEx+gYb4xsHyaJlvO1m8wWqUrNAt1OeLyV7cYMHgpbfkRsXcJagHQJN79WOfe2
	wVAs8dYXV/QsVIHu3jDCyjkQSfJbsc3Q=
X-Gm-Gg: AeBDietjKlWjIGwqwx2QinctBDxm7/Jc/5utIM5BuC5IzZQOF9Sv0gwV1MRs3WLLJv3
	8aRKPWi+AlXIRF9ACwA2yHyaHvCJ4iSFCnPidJ5KnybtoKu/lkO4JNr6j9tGZ3Rm8prna31IVMv
	J4Ze9s358tPxGwsU2TZQIG/bHw3jBIGl1wonNdwOJD22xN8zXKzwLAVHlNQf8nPbd84pS+4nEw/
	k3SpZaEg7Lui7eQswDWOMiBW0ZqVMyk0joqtH+Y+ZgjQTaqu3am6Wg/oJ5Z/7AuiXRCFaIwEYS+
	kKM0XGupvREEFonAr3gE4V58zmVLswEeqmdKb74=
X-Received: by 2002:a05:6000:15e0:b0:43d:1c75:db70 with SMTP id
 ffacd0b85a97d-43d1c75dc44mr7692327f8f.15.1775148835462; Thu, 02 Apr 2026
 09:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401041929.12392-1-CFSworks@gmail.com> <20260402080542.293e8729@kernel.org>
In-Reply-To: <20260402080542.293e8729@kernel.org>
From: Sam Edwards <cfsworks@gmail.com>
Date: Thu, 2 Apr 2026 09:53:43 -0700
X-Gm-Features: AQROBzCjWRVG4OPIJXMJdioZXiZLwrE45OlbnJvHM-A6xPnlux3hujAChNQ6Gwo
Message-ID: <CAH5Ym4j5peYXc5c9ycJzimy26Tv+4x18hyy+j-H4v7PyWuWhtA@mail.gmail.com>
Subject: Re: [PATCH net v4 0/2] stmmac crash/stall fixes when under memory pressure
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	Baruch Siach <baruch@tkos.co.il>, Serge Semin <fancer.lancer@gmail.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274632-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,renesas.com,nxp.com,tkos.co.il,st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5D29238C4FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 8:05=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
> I meant we need both a threshold, and a delay :(

Hi Jakub - got it: when the critical threshold is reached, allow the
NAPI instance to sleep and start a timer instead.

1) We'd either have to leave interrupts masked or let them race
against the timer. Either one is manageable, but I feel like those
interactions carry *just* enough regression risk to bump that patch to
-next.

2) Could you point out which NAPI driver best handles this situation?
I'd like to replicate its approach.

Thanks,
Sam

