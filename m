Return-Path: <netdev+bounces-275702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICWkDG3902kSpAcAu9opvQ
	(envelope-from <netdev+bounces-275702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:37:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B37DB3A648F
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE3803021720
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 18:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E1D395D84;
	Mon,  6 Apr 2026 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4NaLOlF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D10C3947BA;
	Mon,  6 Apr 2026 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775500638; cv=none; b=TVPpFY+l7rQLiBorg3fXBKFZBEYrfqxty48dzhCaRryspW128vhn65ASETDTm43MvLYiNysysjOYYUqvB1FS1QRlkK3/Xs0Wq+a6fy827sKr17Fo2lpWySNRDGoSXmjkReRleZuPIRQvuCrJnsrci3ledbR+DyfDWmA09MBeQpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775500638; c=relaxed/simple;
	bh=BkzmfjdLkZjIEE3dl4fidpIJh+Uk/PlxW8cxqIb1ftI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rkERYxKmFCPMHd7RhmyRg4a1UIRTUNGUa1h2CrJpOZ5KGpdPZfBiq7N/osjUNFLlqhs+Vy+316ktRQQQz2I4YGHbxpNEoeRD3ZESbmYuUs8HkqobfYW6VISRvCJoQ3njSl8kQshDAjnR46P/USCSGNSV+D6e9Lu9lweuK6PPJKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4NaLOlF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A6FC19421;
	Mon,  6 Apr 2026 18:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775500638;
	bh=BkzmfjdLkZjIEE3dl4fidpIJh+Uk/PlxW8cxqIb1ftI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b4NaLOlFbMQPwTk3mYms/9XSSK+KwJZL/01tw35C5UEQ9J5bPmxwnT1Tk+kOxYt+V
	 Em5SUeWpfc4R/6blR5/qhXsHG71QNzt32CIc+FCpVyp1wo3jVws7YHqYKT12Av40rd
	 V9SnCWGC3vZKhywRtK3DoCxBCq0WHNm5VzhAg3LKykEy9IXGtQ+9x5u1Yq+rrk1XmZ
	 P61Z0RO26KeHTLQnzhB7XFLxsk5Gkqvi7RoSsIrziYGLIWzlUCvjFr+JSf0TOVgfnh
	 42QUzvVgTm4f8Bc/R511yQHvUMuTr8sCLj+0AHIr+KtEdTS3JkqqeMDmbX8EvQZeiE
	 Uy4N3lCdFswdg==
Date: Mon, 6 Apr 2026 11:37:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org, willemb@google.com,
 linux-kselftest@vger.kernel.org
Subject: Re: [net-next v2 2/3] selftests/net: Test PACKET_STATISTICS drops
Message-ID: <20260406113713.59534080@kernel.org>
In-Reply-To: <adPfTwbARPVFLys8@devvm20253.cco0.facebook.com>
References: <20260403233240.178948-1-joe@dama.to>
	<20260403233240.178948-3-joe@dama.to>
	<willemdebruijn.kernel.aa6e2a3e845d@gmail.com>
	<adPfTwbARPVFLys8@devvm20253.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275702-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,lunn.ch];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B37DB3A648F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 6 Apr 2026 09:29:03 -0700 Joe Damato wrote:
> > > +	if (cfg_drop) {
> > > +		check_packet_stats(fds);
> > > +		goto out;
> > > +	}  
> > 
> > Sashiko pointed out  
> 
> In the future, please link to the AI report.

No. We don't link to CI reports as a general rule to avoid people
posting code just to have it tested.

