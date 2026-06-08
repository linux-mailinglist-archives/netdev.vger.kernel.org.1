Return-Path: <netdev+bounces-296513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tnRtLnyxJmoEbQIAu9opvQ
	(envelope-from <netdev+bounces-296513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:11:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DE8655FEF
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:11:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296513-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296513-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8434300C0DD
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 12:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00FA33D6D7;
	Mon,  8 Jun 2026 12:11:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5E54071EC
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 12:11:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920697; cv=none; b=Q+8Dpg9HZ7N/VouOptiBOkrvMxbGJWHpki81G+L5ab9fhjLdnjH4YmZuSs9DrBYoCTd2wafETsSQ4mQNPVgTDqYfCnPtYVZ/TtOn/L1RSdk9BpZjeSjPBvMQsGB0FoNBb1R+BEkggg8Tc6ZEpwoy+C5BdCXp50oPQSXP6HP9Ik0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920697; c=relaxed/simple;
	bh=X2oPBa0tJdZD45RtrzjksZtFfaD404Cxrg3Bai+IPnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJxYK8E3eha6c3EM4BDSpIErsb7UCnUqO2p4X/jo0diqcJyS6aqGlZaE9enY8onV2P2aDlF/8j5UdzjVBkIh4EbM2LxgRLkI9Cd2xzQsrtf+NqC7ulhXh2EeuEJUehA8G4hk9i8jsnyUBubSYKFvWwpjTg/II7F8Ex8W400KJU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 6905060337; Mon, 08 Jun 2026 14:11:28 +0200 (CEST)
Date: Mon, 8 Jun 2026 14:11:28 +0200
From: Florian Westphal <fw@strlen.de>
To: Eric Dumazet <edumazet@google.com>
Cc: xietangxin <xietangxin@yeah.net>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, Willy Tarreau <w@1wt.eu>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Zhouyan Deng <dengzhouyan_nwpu@163.com>
Subject: Re: [PATCH net] tcp: secure_seq: add back ports to TS offset
Message-ID: <aiaxcKgQUqF56SHp@strlen.de>
References: <20260302205527.1982836-1-edumazet@google.com>
 <99caeafd-edf5-44a4-8742-4eada5d0f5d1@yeah.net>
 <CANn89iK8GcY3GHCRs-8EVrDoBPhdw1iY4mBjZKe8gx58+ko73Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iK8GcY3GHCRs-8EVrDoBPhdw1iY4mBjZKe8gx58+ko73Q@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	TAGGED_FROM(0.00)[bounces-296513-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:xietangxin@yeah.net,m:pablo@netfilter.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:w@1wt.eu,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:dengzhouyan_nwpu@163.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[yeah.net,netfilter.org,davemloft.net,kernel.org,redhat.com,google.com,1wt.eu,vger.kernel.org,gmail.com,163.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,strlen.de:from_mime,strlen.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57DE8655FEF

Eric Dumazet <edumazet@google.com> wrote:
> > Is this performance degradation an expected side-effect of the security fix,
> > or is there any sysctl param we should tune when `--random-fully` is
> > required for high-concurrency short connections?
> 
> Hi Tangxin
> 
> I do not know why that patch would affect MASQUERADE performance.
> 
> Pablo, Florian, do you have an idea?

tcpdump would help.  Willy could be right, tcpdump would confirm
increase in retries.

