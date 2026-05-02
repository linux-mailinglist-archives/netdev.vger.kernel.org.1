Return-Path: <netdev+bounces-283456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6A+bBVQ79mneTAIAu9opvQ
	(envelope-from <netdev+bounces-283456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 19:58:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8514B3207
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 19:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 041B8300A134
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 17:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068A138758A;
	Sat,  2 May 2026 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lv5wvGS0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE44355F30
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777744718; cv=none; b=MlLgGVWw2qb0jwnQgvgn25pRMdJbc390d+LlUsNm1VBxaFbdotd1D0EgMeJLeydVBxetFBCcULdgapGu9mtMKt3eXMOQ70uXmUHLl2HRoXRfVAN7+tdMiPFjuaMdQhIzEMZCAmmgX/V626S0EljgE8ZjGeqGx2hEScyrIWIJcMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777744718; c=relaxed/simple;
	bh=NQgu2PdBUEYvUyb9x7bb/XZLHII6qlEE26Z03WKiK6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkeIFvE+GIGGXwxSuvIFMl8wHMUqgL/yU/MCsCVb7lI9QXIypSgvhsaqQ21KhcJzm8OOhc5rgfkQR6r86iJ2zeu7fHO6vg8SQRci0WLf0soAk+uYJa1S5t8+SwKaQmFSiWe9lPPgxljIGphcmBB8FeU6JocJSi8Vwn5oosLW7pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lv5wvGS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56DA9C19425;
	Sat,  2 May 2026 17:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777744718;
	bh=NQgu2PdBUEYvUyb9x7bb/XZLHII6qlEE26Z03WKiK6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lv5wvGS0pq0JOkFEPusoEKB2IOBpyzPh5QsKnZ4EEhw5qMMDFxl4HqsBlKRm59fWd
	 QATDUbf87p+x69NFWt/ceLPJbHMIBiiDteS7deoXf0kKB4wvllYwiIT/GnpH7qbRUC
	 qrxAgdWsAiyJpiS1R9prHRCMtRjFIgl+lTD4eHj2htU9gVsqGddonsYNLDTeNixm7C
	 SM6bZU9vLVHskLiJ5ZA+HsB17XOcJC5qz9VHUom7PCNeZdlWQKuSPOH0hA1/aertI3
	 SCSeSe57gEjTtEg/68yKlxanhp2JvRflfEFEvRyq4toUms2VLo3FFt6YNhX3VW9hTA
	 XHD51qUVa7Cuw==
Date: Sat, 2 May 2026 18:58:34 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net 0/2] net/sched: sch_cake: annotate data-races in
 cake_dump_class_stats (series)
Message-ID: <20260502175834.GO15617@horms.kernel.org>
References: <20260430061610.3503483-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430061610.3503483-1-edumazet@google.com>
X-Rspamd-Queue-Id: 6A8514B3207
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,toke.dk,resnulli.us,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-283456-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid]

On Thu, Apr 30, 2026 at 06:16:08AM +0000, Eric Dumazet wrote:
> cake_dump_class_stats() runs without qdisc spinlock being held.
> 
> In this series (of two), I add READ_ONCE()/WRITE_ONCE() annotations for:
> 
> - flow->head
> - flow->dropped
> - b->backlogs[]
> - flow->deficit
> - flow->cvars.dropping
> - flow->cvars.count
> - flow->cvars.p_drop
> - flow->cvars.blue_timer
> - flow->cvars.drop_next
> 
> Eric Dumazet (2):
>   net/sched: sch_cake: annotate data-races in cake_dump_class_stats (I)
>   net/sched: sch_cake: annotate data-races in cake_dump_class_stats (II)

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>


