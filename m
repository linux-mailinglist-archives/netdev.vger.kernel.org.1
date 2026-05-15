Return-Path: <netdev+bounces-288366-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uO/1OapRB2rBxgIAu9opvQ
	(envelope-from <netdev+bounces-288366-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:02:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAF25545A9
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E983F301956A
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8AC3FF1A2;
	Fri, 15 May 2026 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZ8wUSdw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B8C30569C;
	Fri, 15 May 2026 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863051; cv=none; b=UGzi8/yU3osRhxD2S9ArBMr1jk4T8YoQt4jyf5s+AoAfaj7Q8GVuTSSaH022W7l3ObKBilTpoZS8ruM8E67M40ijND35F5LL1+tSiBUrKVQuIipTn9ssmcOdF4o4iLHLDaq8tclWUZNtoUhUl2g+jCAhR7I4bKUJLdIrQsOG4QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863051; c=relaxed/simple;
	bh=5eKtdsYg9aWj3p4rG7m5KFNc8Jvv0LaOC7pZlXsoAVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdjjI23N9IAixS3a1TKk5osv+FGkRvAX9bbpGp9tJ7X/PLHJQmn2hkK9mffK/1Cb31AzquHqVVZMwxQJKMvpl5GwbutHZzCWSmVkUbS2ZWwiFq3SfsdPgRMbZTyNnqukC2TyNhQfDe2CUqJ8IxCdDdO/O4ziHf/mTdQ93rpCkRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZ8wUSdw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3F1C2BCB0;
	Fri, 15 May 2026 16:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778863050;
	bh=5eKtdsYg9aWj3p4rG7m5KFNc8Jvv0LaOC7pZlXsoAVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tZ8wUSdw8AuBUeIUBMZa+8AFTCXk8Sx6mMXsVsnv1f0AEjwiwhP65DQHYvDvlExfc
	 PDkaMEVcSkff32Lo1H/pURfHyTccvj2ZlXuE4gXglJNW6sDxaXv0AZBJUB5i6uJuJY
	 OQZ29xVWDPoxcMN3VjodybgzhoRZ4kE6knVcR6ItlVU6ozMllmV/JkfIT6Qs61vPJ5
	 HdzLCNCcM3g08AM/KURt+Y4swoYqnpRukNKuxnsLO1XTSCG84CoVxBcUoSpL6yGinO
	 maUqTUZ/5D9PsJ6B+Z0KlWv4+XB5ZYEeDQE0KzHHkVCEoKEByCF/3q5snn57GOgELQ
	 k/d9YXrx4sAkA==
Date: Fri, 15 May 2026 17:37:26 +0100
From: Simon Horman <horms@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net: dsa: yt921x: Add port TBF support
Message-ID: <20260515163726.GB227382@horms.kernel.org>
References: <20260508065757.2566258-3-mmyangfl@gmail.com>
 <20260512091026.279150-2-horms@kernel.org>
 <CAAXyoMOiokO-yh7AVs6qXDZzfM3PVYUDRKHY7FdXivjpcH=5mg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAXyoMOiokO-yh7AVs6qXDZzfM3PVYUDRKHY7FdXivjpcH=5mg@mail.gmail.com>
X-Rspamd-Queue-Id: 9BAF25545A9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288366-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,resnulli.us];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 01:55:58AM +0800, David Yang wrote:
> On Tue, May 12, 2026 at 5:12 PM Simon Horman <horms@kernel.org> wrote:
> > Is it intended to return 0 here without populating the hardware statistics?
> >
> > When the driver handles this command by returning 0 without modifying
> > qopt->stats, it incorrectly signals to the TC core that hardware statistics
> > were successfully fetched. As a result, the subsystem will report
> > unmodified (typically zeroed) statistics, which hides any packets shaped
> > or dropped by the hardware.
> 
> https://lore.kernel.org/all/20260507012311.2187979-1-kuba@kernel.org/

Sorry for not noticing that earlier.

> Would a stub TC_TBF_STATS case that returns 0 (leaving bstats/qstats
> untouched) preserve the flag here?  mlxsw does this in its
> spectrum_qdisc.c.

Maybe adding a comment is sufficient.

> (also trying to address that in
> https://lore.kernel.org/r/20260509122238.2792915-1-mmyangfl@gmail.com)

Nice, thanks.

> 
> > Should this read the hardware statistic registers (like the newly defined
> > YT921X_PORTn_SHAPE_STAT) to update qopt->stats, or alternatively return
> > -EOPNOTSUPP to indicate a lack of support?
> 
> YT921X_PORTn_SHAPE_STAT gives the token bucket statistic, not flow meter.
> 
> (Not a real problem, but trying to suppress further AI gossip)

Ack.

