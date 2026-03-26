Return-Path: <netdev+bounces-271965-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEcBNH0HxWnn5gQAu9opvQ
	(envelope-from <netdev+bounces-271965-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:16:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7107233320C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E54DB3218C7D
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AF13DC4D5;
	Thu, 26 Mar 2026 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOaVBZpR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FCC3DC4DB
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774519430; cv=none; b=Xo9oPjfju+n4vJ5dGPVsXC59ZvTdSP2bqxnzzhMpo7p6bOoRrpzUfYbGcLRATiBT9xKLfPtF3x/Lk3KgHCKwH3h7sd6zIKlevvrZYkZ4oIZpN1GTBi9FRSmThXCwcCF+z44kqPoqdphRJ/LvvbGdyH+3555AxloCOZDEwR3TNmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774519430; c=relaxed/simple;
	bh=LW0qRADKPjr04D8TGuAHO/KRzN1dXxvaIqKUKJK0bKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlVdvrQ+HGsYPZBFEN/Bz4RrAlpENJSfxSBAciWhcRAFnUEd2DT7me1AoXutfY3tN7Y0jKd4btNzSba2UiOQ6lOnHL5gVd7P+D+De+2T3PYkQ5zXNCShNonZgst2VnUh8ElIKywRAv9aKKCMrtQKHO9FUqxjU5EYApeLJqb6Yg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOaVBZpR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4832c8f9d87so1168945e9.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 03:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774519425; x=1775124225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uDQDkQMy9E2JiUiGI2tOdIGQqEDS0/kvaZaf9uVfroI=;
        b=SOaVBZpRGI09Eub0F3d6B1vNi04d6jlo7ZQmzS7yVHwOk2KTiJQSDwPsvSLEpko0dG
         6ogRhOQQvdyEa4KsxZnyX6vqWBPR4Qk9HEEh18XMLL0JMUKFkpqG1e0A9wo8oNN7tYIz
         UuaHOtqsBhLhcU/6eQFgWQX8lrbdHkiUZ89YjZv8WeufaTH5TqdUmxlobrENGQ9Bf7X4
         tnqn2E5PCSsoubPWnQ4vsZf0/a1eGQHYk+sX4XKAvHedjktP6xXjLkSBtkIDip4W2F5d
         wavo9wTXSEZ6KlrnReQLZvzUXcHdU/luH2bUV1FyA0j3TbN8zstdF4R54sI276VeLfJx
         ymeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774519425; x=1775124225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDQDkQMy9E2JiUiGI2tOdIGQqEDS0/kvaZaf9uVfroI=;
        b=NlYOrInpw0dm8IJ0k8Yzunx/Pd2R6zcWg8feS2iglvtJ+yypdRRMRiX20h/ZSLvNC7
         BpnIS3jb8r46jAepu83q7GBgjwEWxILc0cXnMbeheLAhn7DVb5T9LpxvyMr+S7u1eZ9p
         tnNh8ad5Lw1x42i50x5MS/clRLVKbWmcIdpp/iSB7p0GSK8im8dhDUZqo4eCD9we1UGC
         +ITIjsmtlVfhfyv+If0KnSJyOJHorDsa2cG2v3C49MfLf+06Rj7qG+PIs0Ozpc3jw6nx
         n+kOxSTx6AQek7VliL51PZdGQ0SNhI8iEcfVprOEKzEBQAWeTcRDWnqkxMlC0FbKy/QT
         kxEw==
X-Forwarded-Encrypted: i=1; AJvYcCUqO/Y4m05R2TADBpAro8WGSAHVAMbTOjeHqU+cMZNQ60+w9zRSijD23Ft8BMjy1B9MqrOvCfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YydQkXZBDpaj0291RojNbMiiZCzaMlzcT8sx+3XUtomI+cK9tJ3
	AEc0SsT5QJgl0/4X8BYdijf/q9ZDxo2xqLQvgWzyDikTZ51LH+5tObQh
X-Gm-Gg: ATEYQzwbzOEas8UyHACVs1GazFrljul1Bg1oiCEXDVAVQG/WbYpA9IAXJt73t/9KTC8
	MohFMT0Hav24w7ZU1kiM/Hgu+84JdTVzTBqNUx1Ja365NZj1Kpe0YXHPnq2k5UFdqWuUmfGlKOx
	adT29H+ZQsBTibjoKPPwgoorvQCkFbiXqtUsENEC6MgXoIW8cVlrzExHuwd+i+HDXY8orhGIV2J
	l6/tPTMExekVfmAS+mgRpl7ztIE0654aCI2j/WLQJ12p7Xzq84v8gkKK+sE0lSxjOc+P0V51YTY
	8OnM34iJw9U/8SC/IlIP70TJwB1AKZphizm0kV0gLiXjJMaTXZ0OgsSao7Mks5KqgHZE3Dws51Q
	2aHIGJAVpfoYEHxfoCYdPQlTNjC1VBVcB4ppcTgPvQ2n1NUq8/uZQ+HuTD8M1mhUJFl8McN2z/n
	yj4CsYFRoaaaTcags=
X-Received: by 2002:a05:600c:5248:b0:487:1108:48b0 with SMTP id 5b1f17b1804b1-487160844ecmr60348305e9.4.1774519424938;
        Thu, 26 Mar 2026 03:03:44 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d50a:b400:cf79:b8bb:14ce:d80f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c9134fsm30041835e9.9.2026.03.26.03.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 03:03:44 -0700 (PDT)
Date: Thu, 26 Mar 2026 12:03:42 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org
Subject: Re: [PATCH net v4 1/4] net: dsa: ks8995: Add shutdown callback
Message-ID: <20260326100342.h5cx5r2dkvaelb6i@skbuf>
References: <20260326-ks8995-fixups-v4-0-989abba8f077@kernel.org>
 <20260326-ks8995-fixups-v4-1-989abba8f077@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-ks8995-fixups-v4-1-989abba8f077@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271965-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7107233320C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 10:57:32AM +0100, Linus Walleij wrote:
> The DSA framework requires that dsa_switch_shutdown() be
> called when the driver is shut down.
> 
> Make sure to also implement the mutual exclusion required
> by checking the platform data pointer to be NULL in
> .remove() and .shutdown().
> 
> Fixes: a7fe8b266f65 ("net: dsa: ks8995: Add basic switch set-up")
> Reported-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

