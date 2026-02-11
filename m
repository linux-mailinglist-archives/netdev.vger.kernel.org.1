Return-Path: <netdev+bounces-258315-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNXsDUK1jGm5sQAAu9opvQ
	(envelope-from <netdev+bounces-258315-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:58:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 867C31265D9
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4AED3012256
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 16:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143F2343D75;
	Wed, 11 Feb 2026 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fwu2dSLa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51C733E36C
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 16:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770829104; cv=none; b=O3cxi0wmfeXyedsX2wwCkRg+aNPwFmjBiwaPXzpCmDXoIWjn9iJkB+grMUVPKCC47I52P1g/sV2kcjYZeAz9CAQXUpEir81zoWbrS48Hx6EtlRWdIv7HJvhcQwibE5uQTDB0tAjn1HuJoG/tfswLqi+cXT0m03qmqIIchEM+SYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770829104; c=relaxed/simple;
	bh=xEUCiuHuaBrSQxASYEk7cwhgYLqUzm3JLT9QA+TTjjw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SWy/ogcXnVqIJwwHfI8tLaV0ngsdxQgBcVJxCJSZ5W0T1bdmBRtyT9Mn27O3M/El9qeN4L+j/xcCFfDOagUU+KmieV97CdPslaaMYhTF9iGW0YhOWDnJ/Z768FvUvh29mFX37hXzdxfHaM+AY+tXqSpssq/t7E4RcgC/gcWlIJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fwu2dSLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DF8C4CEF7;
	Wed, 11 Feb 2026 16:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770829103;
	bh=xEUCiuHuaBrSQxASYEk7cwhgYLqUzm3JLT9QA+TTjjw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fwu2dSLax57iGcewB36e2PooL7V85NSYcf3gsl7d9IEvcFNv5O7ets+8DiiL/HGXv
	 9tT2SL8d06ZIN/VHSq5s8+0JsmEcFwulR4MaJLdoHRdiRiBcWTwzTn9KsEhzwV9VdO
	 kLDkONa/As5sZlmOKrN16KBJ5Fx/AdClIwx0Rmy5f03BFor3IXP4p8ffPZsgeo2qQu
	 IlhIKXi3FEYdZ5GlVBYqoMZfGj4EUaXzy89z39++YWGNov3zdDs6dt1XEl6Me/H3/Y
	 +k6Y+yoV80pidlMNokt9pk/Rr/tjncrsZMaMSdZRn6vikOmdSujfWqHZHPKxMQ0gW8
	 hyD4XTh1roPUg==
Date: Wed, 11 Feb 2026 08:58:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, Michael Chan
 <michael.chan@broadcom.com>, "David S . Miller" <davem@davemloft.net>,
 Linux Netdev List <netdev@vger.kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Andrew Gospodarek <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH net v2 4/4] selftests: drv-net: rss_ctx: test RSS
 contexts persist after ifdown/up
Message-ID: <20260211085822.184f85c2@kernel.org>
In-Reply-To: <CALs4sv1GtqdhGLkcJC1RFbr_bi3n_Hk2A2qahhAg38hrcmRznQ@mail.gmail.com>
References: <20260206052930.1882740-1-michael.chan@broadcom.com>
	<20260206052930.1882740-5-michael.chan@broadcom.com>
	<aYY2sak4adKOGRSv@devvm11784.nha0.facebook.com>
	<CALs4sv1Z+oWNT5myaEr=LyZsLCGUYfOKAet_bc+fmw7g8PbaxA@mail.gmail.com>
	<20260210174627.2360a03c@kernel.org>
	<CALs4sv3hca2N=+w9A81ZLMz9QCHqA7OzGFOzKGswd2sy+9zt7w@mail.gmail.com>
	<20260210201706.1da13881@kernel.org>
	<CALs4sv09qKxtHri6ydEh9QGAcZ=aET3ttkZue88O+X44BA-N0Q@mail.gmail.com>
	<CALs4sv3kG8kTt=VipR-=SzrLvK4ke3qj9Fe8pF=Mo3agd4X1=g@mail.gmail.com>
	<20260211083132.15b15870@kernel.org>
	<CALs4sv1GtqdhGLkcJC1RFbr_bi3n_Hk2A2qahhAg38hrcmRznQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch];
	TAGGED_FROM(0.00)[bounces-258315-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 867C31265D9
X-Rspamd-Action: no action

On Wed, 11 Feb 2026 22:08:39 +0530 Pavan Chebbi wrote:
> > > My experiments are pointing to 'self.cancel()' sometimes taking a lot
> > > of time as part of the exec().
> > > I don't know but I feel the new test code itself should be OK. I can
> > > send a v3 and you can run it once too?  
> >
> > Could you reply to this thread with what the version of the patch where
> > you see defer() takes a long time? We use defer all over the place..  
> 
> Oh it is still in my sandbox. It's after I incorporate the comments I
> received on the v2.
> You should see it in v3. Let me ask Michael to send it.

I'm asking for the version that doesn't work / causes trouble.
Presumably that's not the version you want Michael to submit?

