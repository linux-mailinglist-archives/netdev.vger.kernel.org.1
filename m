Return-Path: <netdev+bounces-282545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMBtMFeV8mnLsgEAu9opvQ
	(envelope-from <netdev+bounces-282545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:33:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4698349B5F4
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD8FF3019168
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59B3399361;
	Wed, 29 Apr 2026 23:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3o3Dqw3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A353B331220
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 23:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777505619; cv=none; b=gqIk1qyq8r3devGh12yRmz7iqNYrPf2DSsl6cfd4S2SusQCttc0w/ir0lK9MoCUG0z0c69JNXlUVh4M3lC6znNxtkIaMenS9wKSugO6HG6GMuTqKpdSW0/ViKfOyCyOK0iELnglEWPqD1qUHqpCbLpTBWaAtUOoe8mZ+pc5RmqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777505619; c=relaxed/simple;
	bh=hJmIiNAolj7wocAcdF+1vUVyWZT1CSnhTUwKj4KncjY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VjDlWpHTw48i0mDogBESauCqWaKCLfBh9WQUDc9xaB/rm5AFsrxQabFLsh/4KYVfL8YNxdf3Le1jlFpDkImL2xCltf+DkjWeimn7zbztT8ZgXBCh3ueDsa8LJqbtTIeCUHu0chrnC3ksSglGgI9PVIZPvOHObbpI8il4Y0YxWWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3o3Dqw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02757C19425;
	Wed, 29 Apr 2026 23:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777505619;
	bh=hJmIiNAolj7wocAcdF+1vUVyWZT1CSnhTUwKj4KncjY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c3o3Dqw3c7bFTitjCapvX7Y1VnLEXDdDwSnPALbgUFMxCcuMJwhMIjbmRJn9n3QCb
	 EHi0h0KyBL5hxAXshsa9Jl52MkT4dx7nRbQt6NgkRj+4Eu4WzCULvQ5L1jiKwz8ZZ7
	 BDZshd9rqq04hYOvQN7zWhWcsDa7I3Yti0uIvK5WWqo882uOp8PJ/OlOUCnxCDT1MB
	 a4QhbG60tTaMBkqnHT66iJdK39dCqb/k6th+znyWDj9PRF3wx1e+agBHcs2HhD2GYl
	 tZoFV0T9rv3+b0IILeSHvI2l8ZcSTjP12E5cUJxB/8Wc1TzOkLKaP1xVM3kjU780sX
	 PHe/QLUh5xp/A==
Date: Wed, 29 Apr 2026 16:33:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Neal Cardwell <ncardwell@google.com>, Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] selftests/net: packetdrill: add
 tcp_syncookies_ip6_9k
Message-ID: <20260429163338.423c75ee@kernel.org>
In-Reply-To: <CADVnQyn-U-QgyT-HqeqZVX3FJi-UCgwfGJk2VaBBhjajKoih6g@mail.gmail.com>
References: <20260429080036.1528533-1-edumazet@google.com>
	<20260429094805.1aa6bf3c@kernel.org>
	<CANn89i+KuSf8PhAsf7a=h+tR1c8aLNdiM6NzaBU8tjpoLAfcQA@mail.gmail.com>
	<CANn89iJrvSvw2XKvB7LfXc2egeaqC+seiCiKN2USMw9gicqM1w@mail.gmail.com>
	<CADVnQyn-U-QgyT-HqeqZVX3FJi-UCgwfGJk2VaBBhjajKoih6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4698349B5F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-282545-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Wed, 29 Apr 2026 16:47:14 -0400 Neal Cardwell wrote:
> > diff --git a/gtests/net/packetdrill/code.c b/gtests/net/packetdrill/code.c
> > index d90bffabcfe6..6d8d20e64d8c 100644
> > --- a/gtests/net/packetdrill/code.c
> > +++ b/gtests/net/packetdrill/code.c
> > @@ -129,6 +129,7 @@ static void write_symbols(struct code_state *code)
> >         emit_var(code, "TCPI_OPT_WSCALE",       TCPI_OPT_WSCALE);
> >         emit_var(code, "TCPI_OPT_ECN",          TCPI_OPT_ECN);
> >         emit_var(code, "TCPI_OPT_SYN_DATA",     TCPI_OPT_SYN_DATA);
> > +       emit_var(code, "TCPI_OPT_SACK", TCPI_OPT_SACK);
> >  #endif  /* linux */
> >  }  
> 
> Sure! Done. I added all the missing bit values in the following commit:
> 
> https://github.com/google/packetdrill/commit/faa0dfb54065118625e169d3111ce09c65b20229
> 
> This can be picked up with the following, or similar:
> 
>   git clone https://github.com/google/packetdrill.git

Updated in netdev CI.

