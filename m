Return-Path: <netdev+bounces-263456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKjRLitqp2l/hQAAu9opvQ
	(envelope-from <netdev+bounces-263456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 00:09:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7021F845B
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 00:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA1233049447
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 23:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B00391836;
	Tue,  3 Mar 2026 23:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="nNlCkWH4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D0339098C
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 23:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772579368; cv=none; b=SPThdguL7r9OLdjv4FD8h6xHBd3qMVuNa6SghgKhV+1rRdiBdBNxyI/GQ932fyaYQe3/NmuYqPoKi+8Zpre7Y7RNMfhcyn2U1gHls580CbIaRP3TZ8cep84AW2R/mWv0m3AnVhsoL/zD9ut7YrQdxWpVg5lC8u2iTl6OFBupSwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772579368; c=relaxed/simple;
	bh=tQBclTQoEFogvOvzg1NNYMQjkLHMah5juUwioIlFtyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niSiUgKjbAzhaVJHyj8QAefOtKDPnmsg6HA3khwErY1KBQEEBpvFcJecxNitBZDjmkDodSg7ZIILLsOrZEA1jOEhkBgBQHJJffhE8P5m1mcB6rxkiyjZSa/69Az6/Zakkwpqw1xo/58xNCG3YvtGlW2ky+no0KPHZ6mODS6TJKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=nNlCkWH4; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3598c008455so1637365a91.3
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 15:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1772579365; x=1773184165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4F+wvsg+rCfB+Xgc2i771Wn+E0HEDYAO2XFtN4tcCqo=;
        b=nNlCkWH46EwoJa8jGLd3miZLBYcqhvkst78l2V0tTlYL9JDiyUjMc9LsdAs+dmtdlU
         SbIeyWDGaIow83vojk1LaycyiK8Uvo6xmn47jDbe64LzNNCzj63F7LA6r0C6M+oUFHHp
         3B65LkopYhvSaqw0B2N1+ygj76BKZjCiKsAHZgR/ZCWB9UT7qX5aQvqQN5XcLZEuDzx2
         5n7lhD4nWxk5DZRcfcCJoBewyF3VzKbrnyiBTi1wMNI5GdM7GY9ytGXOVjeC9xwRD7XW
         iv5Sy2uYaFCKp8he6fDxy3Je/T7l3gwaIhThxgsDdfVonVB8Wt34pvmzaoYDugMO5NWu
         Cewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772579365; x=1773184165;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4F+wvsg+rCfB+Xgc2i771Wn+E0HEDYAO2XFtN4tcCqo=;
        b=V5U6V4xfmu/0TS038a8fY11ysiT+KmCkvbOa2loRrIFrp5pQetUdB1z06P1vBdjBIG
         s9M/ULwos1M28WNTMEH/QyUXYRXp+MLcS3lKod1t/B8+AAcMS6/YZmPmz2Qc8jrdvbOw
         r5PgIILrVq4XcgcCSQsa3EGpT65nKdl7FE297UXvVFH6NJQ2sdbeXv10H2OrwXtn1jus
         gXcLJEZMx7xUBhpp214CTSXqZ0CmW4t7OzFmdPD3GGkiCIHc7baoKMx4eUGl05vHF3ak
         jHmG7b438oIN4o1cLCk4h9rrGy7/Ef9G9Z1jXUAa2elDfOxboa937OG2EfJhiKNb8eXc
         upHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1xVyy65s3zYORbOjCz7/R7+mBFaRCY7f0gye2UiT3AcGIZxsUbIq6C5eZBypvDKNYR1PJ0MY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6YcHMlaK3lvf6I4oF56iwj8GYUmFlkjreMRDxEOSZDv9vMJjl
	XX5MgqJupG7lP5vGYAGqF5J9SmIfcwJfSq9YZdDDEWuBCyhtwnzUvYUXZIsvezNIGy8=
X-Gm-Gg: ATEYQzynusQGHM7LWhPnnsRB/5F+G9KeAHKavY/xLhkcmrNnRwkwZMBFRU3kBZTI4hT
	WR30Z5ZhhUzOuXt6+KqkHpFIYhokeGJf2P067/x5AzyXqXtvbs+Q/1w2kRVTxM1vEBMNAFvKr2I
	kXBxyeT+Lt3dwCSLCLT6V68kpKhWQEfAXcNJGNecbStlnobWJ6umkO1tf8RwKxJuRepsRZ4lquv
	iWzBEuY6f1nUNiDoBfHmDUupcIOhYGkCgFIvnr6pAEpWNCQWg+SoIu1P8oZQOQd+QM5gv5nJph8
	mBhRnmD+KAyyAZCcXLFy62VcnQgj6UbQDOQB3DtGMLfgtTH7xaF2kiKaOl3PfvPw+gBQFbSUcI+
	Ut8tnmV+AELLqUbQTqhElv7qbY1lSN20M9XcW2QzNYodEpGF0suGyhAHNsUvRAaKABcq3LRgsHH
	3SBvWF
X-Received: by 2002:a17:90b:3e4b:b0:33b:be31:8194 with SMTP id 98e67ed59e1d1-359a6a7d267mr67210a91.34.1772579365311;
        Tue, 03 Mar 2026 15:09:25 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:58::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c39db5bsm3340289a91.9.2026.03.03.15.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 15:09:24 -0800 (PST)
Date: Tue, 3 Mar 2026 15:09:24 -0800
From: Joe Damato <joe@dama.to>
To: maximilianpezzullo@gmail.com
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] igc: fix typos in comments
Message-ID: <aadqJKC8MagHA1de@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, maximilianpezzullo@gmail.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20260303-master-v1-0-f180b1ad98b5@gmail.com>
 <20260303-master-v1-2-f180b1ad98b5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303-master-v1-2-f180b1ad98b5@gmail.com>
X-Rspamd-Queue-Id: 2B7021F845B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-263456-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 10:38:21PM +0100, Maximilian Pezzullo via B4 Relay wrote:
> From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
> 
> Fix spelling errors in code comments:
>  - igc_diag.c: 'autonegotioation' -> 'autonegotiation'
>  - igc_main.c: 'revisons' -> 'revisions' (two occurrences)
> 
> Signed-off-by: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_diag.c | 2 +-
>  drivers/net/ethernet/intel/igc/igc_main.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

