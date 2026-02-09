Return-Path: <netdev+bounces-257995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBVqNhFeimkWJwAAu9opvQ
	(envelope-from <netdev+bounces-257995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 23:22:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4015E11508F
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 23:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B74843020A66
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 22:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9C430F535;
	Mon,  9 Feb 2026 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="KYQ6289H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE3130B50F
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770675721; cv=none; b=oKEY/UfEKtoo/pcZ/v0wIBBCvJshYzx4IoY5FV7Xw59nWUEKYV1pyBwdm6vDJqdbrCsp7snDPPQ7IVQdHOnj7mlFKcTv2vY0AUwqHoa8Xaozsd8NJ2b3mmhx2QbiUqEh579N65+wgeBYSYuVhcyx/btjXNxTe9WA14UmBgqeeuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770675721; c=relaxed/simple;
	bh=kopIiuG47i/LUjdvHAR/y+71H7Kgoee7zLVScP92UoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/scma/O3AVAWH+1bPgOcbdCOgrAxzobKflmosg9XhlNJiKkoXeIA+E5R3oTrXg4muqcOJspBymdI7Zh7HM95v565GuflpTxc6KRErY7s4jGLpkvJhLqBiQFL7SaVrd/bpju4/rxjQ3bYNaxPQe6qtHQoVjblH9Pwl0PDKnReXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=KYQ6289H; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a7a23f5915so32412495ad.2
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 14:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1770675719; x=1771280519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=707/uqbMFu5ChY5GJNald71pHyxP8HYT+iFACHxg2u0=;
        b=KYQ6289HuaVkXPxrJpGyjPGBdWCNuir2fpeY6kbPYCjjqWfNEGSjyqtc9/KM8irghJ
         wPPo2p+99XmDoloE42v2anNfa+ebTDWQ2NTsBJJ8r7+9pbsQ3HVxMXGF4ZTCBBCOwO1e
         Jui2oQEsl/NtGG9ZVRhDP3V+18/eyephl4epKeRUctegbAr6xTDe1I6QMnISzBSVB1WC
         94Khwo2ji/Rh7bUxVuQEwEIIEwPQ8VhD7TQ9EluBmXkOmV+WtLUG2aNv0X1XjNLxJkhE
         u7n4eEJ94o65Q9XKuIhD0CkELQb9+5bSpCe8EAYB38h8C4Q5TN7xU/Dxs2Gvs9nZlp3K
         Y8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770675719; x=1771280519;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=707/uqbMFu5ChY5GJNald71pHyxP8HYT+iFACHxg2u0=;
        b=LuHzXUQmwephlIFd/Kbb4upfl+Im7fyqOVWIYWnrSaYmpkmAklEyM8XnepcgQwsv+2
         BPCkMZZE3QNlUkau0oGaOx+dx6mUkX9dQ6RZvpdROTp9s6zonL+dQ4AUnDS4xvmMJ7Ut
         AytwGWkI+KxW1JzaZTkIXNGBcw8ktx5VjHWi4amrl78P0vsC6US7ME1ookBciHYobHRW
         KVSr1pppfZlS24VoJDu0GxTHbWnslwxibWW2b0t4yq9Dg4hA43jFaS6+HgM/D4i693es
         8sjwP2u9OOjUmACQ4JzzN58/ys3mM2VQq2UzWGaS4mdvyLa7cnQy3F2QG84bvfsRwbKZ
         zmgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFyiqH/qdb9sLv6PNLIsZl4L5v8BFWXhkc/vV1yk/I/UtaEauYKNqGygH+ngJWvDr7YuyCXaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV9mY5WPldVjioEIFsOX6r5J0nFmcpyDAibJbmetoLnMgDlRpM
	+dghcTFK5PR9Qkj1/El1vB0nVgHqO2zgjuAaHeiOmfZw6U2xx6IhjOnjUfJsRRn4H9s=
X-Gm-Gg: AZuq6aJC1Kc+9oj5pOzUXDkMakeuuFEzc3zLfxyIRgnAxB0hydAmvkKPDXq+HNn9jlm
	dmEDL7DhJgCCMnU72zHPnZyT7ZKjt6Y5stbp+AyYrO7U023D2OTCnzjxWTA+4G6xkXB8bpgHwp9
	3qDgEq57FGQIAr15zRFOTZpsSLkFyIJRtrxGj34iJEBkpM9rQybjOZ5CWcXyYUVYdxj30gmZKFD
	vL0cj1Koovyx/fYBSg1wCVarF7d95dbF9WMUvAQdxOs7YwM8OY+qZxB2p5WgYnfmPxYCos4jnf+
	EnlKLEN220SEL4IjcNAznPbRW4mqghFADmcN7esB+VYaHRRDqyQ3GNFgA2AbK7fvb6HVVagmO8Z
	cmm1aa5i/VpM3gXgzwbQIjCkC9CWQLsXg4JarJfxH5B5P/8IJirEy9IwRe6dh1O2TOgaN
X-Received: by 2002:a17:902:c945:b0:2a7:afca:fd1d with SMTP id d9443c01a7336-2a952025ffdmr120665495ad.14.1770675719467;
        Mon, 09 Feb 2026 14:21:59 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:4e::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a963f8fbdbsm86556115ad.58.2026.02.09.14.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 14:21:59 -0800 (PST)
Date: Mon, 9 Feb 2026 14:21:58 -0800
From: Joe Damato <joe@dama.to>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next 1/2] bnxt_en: Refactor bnxt_need_reserve_rings()
Message-ID: <aYpeBvldHPDI7N/F@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
References: <20260207235118.1987301-1-michael.chan@broadcom.com>
 <20260207235118.1987301-2-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260207235118.1987301-2-michael.chan@broadcom.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257995-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,devvm20253.cco0.facebook.com:mid]
X-Rspamd-Queue-Id: 4015E11508F
X-Rspamd-Action: no action

On Sat, Feb 07, 2026 at 03:51:17PM -0800, Michael Chan wrote:
> bnxt_need_reserve_rings() checks 6 ring resources against the reserved
> values to determine if a new reservation is needed.  Factor out the code
> to collect the total resources into a new helper function
> bnxt_get_total_resources() to make the code cleaner and easier to read.
> Instead of individual scalar variables, use the struct bnxt_hw_rings to
> hold all the ring resources.  Using the struct, hwr.cp replaces the nq
> variable and the chip specific hwr.cp_p5 replaces cp on newer chips.
> 
> There is no change in behavior.  This will make it easier to check the
> RSS context resource in the next patch.
> 
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 45 +++++++++++++++--------
>  1 file changed, 30 insertions(+), 15 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

