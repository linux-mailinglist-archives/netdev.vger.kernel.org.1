Return-Path: <netdev+bounces-282660-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cF7fBq3k8ml8vQEAu9opvQ
	(envelope-from <netdev+bounces-282660-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 07:12:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7422D49D8CA
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 07:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78E2A300CE4D
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 05:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D779367F48;
	Thu, 30 Apr 2026 05:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="dQrnFY1S"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE07176FB1
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 05:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777525662; cv=none; b=IUtQ6CKKFC65+gF5UEL+/jhAKmDz+0ERplu6LA86mZ32GVV+8RBr5Jt23DUUf2QU1k5n1lUWH6RtpndWyMiWO32qf+0YFQXC0h3zq4yS6ch0ikdn2WvXqC2toYhhpCcIMdm1OgPwRtCufeHEJVgf95YHLcvdjPdYBC8W0lkWKcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777525662; c=relaxed/simple;
	bh=4YZ3RSstMHegNPjw86R+D9U+mxAykrXReBfroccRDOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlqbJWzbG5LfQhhR9xjpbAMzGu8Ax7N7Lh74ta4LyhU/aAkoEVmDNumPHSmusemeR2aPCZHzbiwzkXfd/mFfKRuSSuyRHvllp0xVYUeyYsNWyexjQhLwl22igxfXbmh62/NK4T4wEt4WcmDYt+Tj9Lox5cM/pcUa9qrsqKl8DaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=dQrnFY1S; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from x1 (197.87.13.160.dy.iij4u.or.jp [160.13.87.197])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63U57b7B064881
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 30 Apr 2026 14:07:39 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=eeHIrUqSnAqzh/VR/Sx4VFZCl3825OBixai19Wa58nI=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1777525659; v=1;
        b=dQrnFY1S6zv7THlSmC5G6ycOwYVb79eFANSDrAX6QSqt1feGWb7I+GAplF8R6RLF
         As0w558NeybCiFl8J7mY0ssBKzISCOQKqTUEZki0Bv7/D1b74/mi1feb7atw8pgF
         GhYzBeEknwI6L3rWysBhArX4EZ7cqp02zCValQI/XzthH0XXu1wIrs7CSbY/G0p/
         smwhg+9IvtC1p3q5xYMehvaulrrcTzmJFZEC1GO98x0PX/VcPYZGRdi8b0R3w2lO
         Ar23NxP3UAw27EmYlWpllq0vGEeiYSgqQAJNUbIR380GgmqN3+exes4cY+AmuC/Q
         db72AiWcBGzrhpP9LFjVuQ==
Date: Thu, 30 Apr 2026 14:07:37 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        Willem de Bruijn <willemb@google.com>,
        David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net v1 3/3] tcp: use skb_get_hwtstamp() for hardware
 timestamps
Message-ID: <afLftTCDDzw4bE0P@x1>
References: <20260429091632.26509-1-kohei@enjuk.jp>
 <20260429091632.26509-4-kohei@enjuk.jp>
 <willemdebruijn.kernel.2345608a210cc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.2345608a210cc@gmail.com>
X-Rspamd-Queue-Id: 7422D49D8CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282660-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,engleder-embedded.com,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,enjuk.jp:dkim,enjuk.jp:email]

On 04/29 17:09, Willem de Bruijn wrote:
> Kohei Enju wrote:
> > Since commit 97dc7cd92ac6 ("ptp: Support late timestamp determination"),
> > skb_shared_hwtstamps may contain netdev_data instead of hwtstamp. TCP
> > receive timestamping can then interpret the stored value as a ktime_t
> > and report bogus hardware timestamps to userspace.
> > 
> > Use skb_get_hwtstamp() instead of reading hwtstamp directly, so TCP
> > sockets follow the same hardware timestamp resolution path as the socket
> > layer. When coalescing SKBs, resolve late timestamps before copying them
> > to the merged skb.
> 
> Why? Does this preclude supporting SOF_TIMESTAMPING_BIND_PHC for such
> sockets at a later time?

You're right. If we want to keep the door open for
SOF_TIMESTAMPING_BIND_PHC on coalesced skbs, resolving the timestamp at
coalescing time is the wrong approach.

> 
> It is just as easy to coalesce the cookie as the htwtstamp.
> 
> That also avoids the need to mask out SKBTX_HW_TSTAMP_NETDEV.

Indeed. We should also carry the matching @napi_id, since
skb_get_hwtstamp() uses it for late resolution.

I'll update this in v2.

> 
> > Additionally, recognize SKBTX_HW_TSTAMP_NETDEV as
> > indicating a receive timestamp is present.
> 
> What is the reason for this extra condition?

With late timestamp determination, skb_shared_hwtstamps may hold
netdev_data instead of a resolved hwtstamp, and 0 can be a valid cookie
value. So checking only skb_hwtstamps(skb)->hwtstamp is not enough to
detect the presence of an RX hardware timestamp.

> 
> > Note that skb_get_hwtstamp() is called with cycles == false, since TCP
> > hasn't honored SOF_TIMESTAMPING_BIND_PHC so far, and this patch doesn't
> > change that behavior.
> > 
> > Fixes: 97dc7cd92ac6 ("ptp: Support late timestamp determination")
> > Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> > ---
[...]

