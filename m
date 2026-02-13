Return-Path: <netdev+bounces-258595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDfWOGH9jmmOGwEAu9opvQ
	(envelope-from <netdev+bounces-258595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 11:30:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 513941351A4
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 11:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1168730158A9
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 10:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128ED276049;
	Fri, 13 Feb 2026 10:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/BQgi/D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CB11E5714
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770978655; cv=none; b=X/NKUOYZn3rWZd4gwtuNARCMShOrnjo02GZFRrfgJImqfkdECoPxnRRGDv8WfUB5qqLnpMBGOSA64vq9mr/Fg3GnF/sQrnDAEhc42rU4qGWs5OXoW6WN0/0zadrzuexbAK5grrkavtu/aTBC3Lq7m63CkokxFEMXx2eLqkuhE7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770978655; c=relaxed/simple;
	bh=P7pSsQiAl3lP2jHV8lmIY6FCnrO56cbN22yl5MkWzBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOdEq20yX7O5L7pgHXFGOwJCsOV4NR43/pLjMYKS16hobWzuSpPryd9Wg4qYY5WFr1n9ZgiU0X8yLTnteqLdTbo5/OhFl9cqPH6B7bfq8Hfvk6+7oEr7+bMcMzyXDeqr4/QeNG43mZyAanwrkgzgkJxaiTh28zSDEM9+yGH4vS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/BQgi/D; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a8fba3f769so3471875ad.2
        for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 02:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770978653; x=1771583453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P7pSsQiAl3lP2jHV8lmIY6FCnrO56cbN22yl5MkWzBU=;
        b=F/BQgi/DajFa6koU5c4/Fw+FlAdthgolpuPCo4RP4bUc67+JGRCh+ymrBMtdsfxfBe
         rU4unMLErCmS7gbiRjnGGmIcyRgooGWoZ8iM36LU/q+UZfcmdVq1RJzQqFlfQ8GuEgjq
         YL1UaBfmj9R1W3wzBoZSIW0y7D8Tb9Rfdn+RdzZC7e9MiYaEdsLZQLQHH0NQcV7BHeh9
         UVAF7tUsUrlbj97kZc/4OleEUi4JMr+yu+vQA4PVYcZpZrWvC1V6Zsp1y8HvH0Ox4Ohc
         LNL+u3sLu6jWI2CC6mCS35sRyFJaDXaMvaIfiMJ3Pbe6Nq1NZzS9kne8ggfAlrFpfm0J
         l8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770978653; x=1771583453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7pSsQiAl3lP2jHV8lmIY6FCnrO56cbN22yl5MkWzBU=;
        b=StvehpmU2pgav3CzsCu2/HvEoaFXyN0wNQhHBMpZP2p/GRHcUKHg/tUy77Fa8e9tQl
         +N5dX/tBT6CVvR/jx8ixxSwRfvxeuIgn5UKgiJpgjoBDIfDIiGr9hQVaSEorHzypfXA1
         zzEviDRa6M3b84ixWtqGBPc9sUdIIf1yPQigseKccB7tuNQafLOevuS3QsjB+4DypsZd
         WS13Wj3UF5v79O/UmNvR+n1Y7d8BEqwrmi8cKSDhqcpD0WjiQc5CSerimlS0PrIE7Zt0
         H3cjbp6ihbNJNhhr501rDULb6nzXqfJoKosFkENaM0yC0LmPhvbBKXCF6ZYBgmY4Fixi
         dKEA==
X-Gm-Message-State: AOJu0Yyf+QvCLjtuVVb78wIp8t67m8rFFKm8YOa4cMEgLOWgIjHFpzq6
	F4M/HZjKbVAjI0xBCwRDYH0lsyddjaIMCySdXTNeIAV0jnl/t9QzTSRq
X-Gm-Gg: AZuq6aJPezSoaHTxFgQ4q2A5tM25VGtg5HsU/zFHTkmGMgJXJd4aOZllxz8DlcDi548
	LnQRF76qMN+kiIqypLu0svv/i5tU/B0TjA6VbbyOmjNe2+4NaUJRxZMBLUiMwm//AMfSkaFzWQE
	C1AkCcD6pwUKWFY2qtKtZ2eyjw09CahCsIHYtzmZ+8+yTiEcJx7XKK4YrmCAaX0i6K4EpXv8GOE
	YHEx11pQHgu172yRRo/ebo3BvI6gCgKrb4TE+Gx5zKlND5phWQSBK/KBkHhNKf3WdTBSfM4dTOk
	qVvSNhbTLipobHAfDXniS9RBF9EI/bMOCnvmcA9oBp5+yuSJ4JX6RQhAzpBBcTSoUzQr7ete/rN
	G/fXsqxHbEreIQa7HK8094vB6srHED6FJQ8yhvy0O0TNI6XERFjKTobdUACgzzValZCA92Uy3hi
	vCGbSolzFx91xZCVb1mNoyQhyY0PY=
X-Received: by 2002:a17:902:e5c5:b0:2a7:c8db:488a with SMTP id d9443c01a7336-2ab50522a04mr15635395ad.7.1770978653359;
        Fri, 13 Feb 2026 02:30:53 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2986f527sm76848805ad.28.2026.02.13.02.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 02:30:52 -0800 (PST)
Date: Fri, 13 Feb 2026 10:30:46 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>, Liang Li <liali@redhat.com>
Subject: Re: [PATCH net] bonding: alb: fix UAF in rlb_arp_recv during bond
 up/down
Message-ID: <aY79VhTfW80VT3FU@fedora>
References: <20260213095424.84636-1-liuhangbin@gmail.com>
 <aY76FfhYi2jcZcaT@debil>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY76FfhYi2jcZcaT@debil>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258595-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 513941351A4
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 12:16:53PM +0200, Nikolay Aleksandrov wrote:
> Ouch, good catch! By the way I have a (very old) patch that properly
> converts recv_probe to RCU, currently it's missing any annotations on
> the write side. I think I'll revive it when net-next opens up. :)

Yes, I also thought about using RCU. But that changes too much compared
with this one. And bond_close is not a critical area.

Convert it in net-next is a good choice.

Thanks
Hangbin

