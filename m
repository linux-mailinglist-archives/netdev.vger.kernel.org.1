Return-Path: <netdev+bounces-299714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mZlrFiiyMGp4WQUAu9opvQ
	(envelope-from <netdev+bounces-299714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:17:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2AF68B6E2
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:17:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OStTHS9c;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299714-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299714-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3219D300FA88
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD90A3BFE44;
	Tue, 16 Jun 2026 02:17:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF63B37B413;
	Tue, 16 Jun 2026 02:17:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781576227; cv=none; b=PVwmllBjv9fIvXWSxqMt8Hi9Thw61Ej3gAmRfZajEutcnXoziHxtWwJrgnrG46JVK3yOAeCVvNGgaBchvxEluW6yjXX2Oe8XfQVWmXw2mistMd9GzjtHxHSbrgqoBclI1c5aPANj3OwmUds8bpV9m0YWe3vzTfM6yXvfFu4eRp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781576227; c=relaxed/simple;
	bh=iYuwh/QjPCaFltZgY1oNyGfCkwfgJLRV5G8y/pey57o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDwyFBXPviVRojsR9lz2pUixS+AkXHmOkoMenmN6JcArVvgoIg1fD02gTj/McWu8yE9fav7qzQO1tephnUuFpleif7+ah3gmC2610VsjDOgVhWOfhxrU12SM8YVwJbAY2j4RhLTYxBI/IJuo3lnFGqNF+lva9AobhhaBS4CREbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OStTHS9c; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E4D1F000E9;
	Tue, 16 Jun 2026 02:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781576226;
	bh=xD+Oip3IRpQPzSxenYyTvneudjF43QmGVA6/28MSifo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OStTHS9ceHewKrSU9o18QwJHMw4AaB6qp16uTX1ZTaLPmPIBVJ1pSMw1/lJ3jQeA+
	 G1Vj/m3qrDZP/n3iLx4qkdSkdRQD7RAXYKDxBmdm/4HEpJs6zXA5x6lFVaHtN17NAI
	 hw74FSwUS74Zigh7lKdAGeN2AS+22bqzFTCbWu0athb/SR13nF5ZZT3dcoGyc1vCHL
	 BHjECOGWU8Y7vIwGaDgVr1A4bbBgAtxKo1f8Q6Qn65+vqV6m5HJXYSEBJOYKaMqWjV
	 i75kqeYQMypXa9zyHUjO7tSEBlL7sd/dgKS8PXvUFzFLOPYGDDsrrFm92iX/5Qa371
	 H7KQ1oHer7+Qw==
Date: Mon, 15 Jun 2026 19:17:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@google.com, ncardwell@google.com
Cc: chia-yu.chang@nokia-bell-labs.com, jolsa@kernel.org,
 yonghong.song@linux.dev, song@kernel.org, linux-kselftest@vger.kernel.org,
 memxor@gmail.com, shuah@kernel.org, martin.lau@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 horms@kernel.org, dsahern@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 stephen@networkplumber.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, kuniyu@google.com, ij@kernel.org,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
Subject: Re: [PATCH v2 net-next 1/1] tcp: Replace min_tso_segs() with
 tso_segs() CC callback for TCP Prague
Message-ID: <20260615191704.31be22da@kernel.org>
In-Reply-To: <20260615185102.5e8de52d@kernel.org>
References: <20260614071756.239686-1-chia-yu.chang@nokia-bell-labs.com>
	<20260615185102.5e8de52d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299714-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:ncardwell@google.com,m:chia-yu.chang@nokia-bell-labs.com,m:jolsa@kernel.org,m:yonghong.song@linux.dev,m:song@kernel.org,m:linux-kselftest@vger.kernel.org,m:memxor@gmail.com,m:shuah@kernel.org,m:martin.lau@linux.dev,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:horms@kernel.org,m:dsahern@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:stephen@networkplumber.org,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:donald.hunter@gmail.com,m:kuniyu@google.com,m:ij@kernel.org,m:koen.de_schepper@nokia-bell-labs.com,m:g.white@cablelabs.com,m:ingemar.s.johansson@ericsson.com,m:mirja.kuehlewind@ericsson.com,m:cheshire@apple.com,m:rs.ietf@gmx.at,m:Jason_Livingood@comcast.com,m:vidhi_goel@apple.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[nokia-bell-labs.com,kernel.org,linux.dev,vger.kernel.org,gmail.com,iogearbox.net,redhat.com,mojatatu.com,networkplumber.org,davemloft.net,lunn.ch,google.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nokia-bell-labs.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD2AF68B6E2

On Mon, 15 Jun 2026 18:51:02 -0700 Jakub Kicinski wrote:
> On Sun, 14 Jun 2026 09:17:56 +0200 chia-yu.chang@nokia-bell-labs.com
> wrote:
> > This patch replaces existing min_tso_segs() with tso_segs() CC callbak
> > for CC algorithm to provides explicit tso segment number of each data
> > burst and overrides tcp_tso_autosize().
> > 
> > No functional change.  
> 
> Eric, Neal, looks good?
> 
> The min rtt thing in tcp_tso_autosize() helps a bit but if the sender
> gets congested for a longer stretch min_rtts on new connections are
> high and we're back to sending small TSO, keeping the sender overloaded.
> Which is to say - I _hope_ this also solves some of Meta's problems :)

Ugh, I didn't see the Sashiko report, it's only CCed to the author and
bpf@, not to netdev :/

The zero-check sounds legit. Let's revisit this after the merge window.

