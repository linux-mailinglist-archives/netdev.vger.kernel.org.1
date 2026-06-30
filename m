Return-Path: <netdev+bounces-303210-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y+05CTXOQ2rpigoAu9opvQ
	(envelope-from <netdev+bounces-303210-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:09:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF9B6E53FA
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:09:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=txCZ5kho;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303210-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303210-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E6AF317247F
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6C6369D75;
	Tue, 30 Jun 2026 14:03:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6486F377010
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:03:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828227; cv=none; b=l1OXuf1Ymed6Rsz5rgP9XeNtkVY1zQNKqC4mdka78UdO8/VfdzH1xglLNLSO7KqYBz9vjJlyuKX8FTkHGcXg+VvSvV0HGCHh08brta2221t1WtLyCtWeoEXHOXSVg1cwSfSBsA5+W0v2GTASR5gDVvw3sfLW1FMnMIjy2MRPPqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828227; c=relaxed/simple;
	bh=mlHdGYMet4ugXAP3QOHY/WNYdWQUyQiiRMOCc4V+vvw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBZi1+iIzAkX9Ms85gI9SjKOngUfJp9bsWA4N6vAtkfiulMjfmnXVmew62W6S1dW4cQHYmBW8lSskb1h4kaEjvKHh6chIm3gg5pBNU4+FrbInW379Agl4jDXNAbp4EtNEmKrwc/5S12YIKFCt7aMavozsZkoXYBAxfEyT8dASEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=txCZ5kho; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 455B720844;
	Tue, 30 Jun 2026 16:03:43 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YkY0NSsW56KD; Tue, 30 Jun 2026 16:03:41 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 05F8B20719;
	Tue, 30 Jun 2026 16:03:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 05F8B20719
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1782828221;
	bh=WgpzmFEZSFC/xyyvqFfKSg8chY6dfQCbtMNV0rShAOY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=txCZ5khoiCPi3RuEGlJSKAN2L9kyT4Lw2CcAct6d1q42iPIBtInl9hRBUdSPEvyVC
	 WEr61Szjs/rzla3yOgXJ4zm8XKXV1uUbvqJaok92cJdytQFCzaUhVDcJslBxWESyua
	 HS+0nnFcUuMb4SsU2z/YApYrJSeiQTir7YRgHGoSjnupb4hl1yxL05/S7hndsNAu5i
	 DGN4Y+TkmeLpImNAsRRMSqwRAS8TyF8KMSaxsfrbGwOfQwblLNamtuGLs/+nNyP2u0
	 AwM4nLYtkiK2zStRlzJMyFUoGRnbHJjkkTEtGdKGBD2OsJVK+O0uH/Sl2pMeF3OcUj
	 2IsTzSWGKvNqw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 30 Jun
 2026 16:03:40 +0200
Received: (nullmailer pid 1133296 invoked by uid 1000);
	Tue, 30 Jun 2026 14:03:39 -0000
Date: Tue, 30 Jun 2026 16:03:39 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Eyal Birger <eyal.birger@gmail.com>
CC: Ren Wei <n05ec@lzu.edu.cn>, <netdev@vger.kernel.org>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <yuantan098@gmail.com>,
	<bird@lzu.edu.cn>, <qianyuluo3@gmail.com>
Subject: Re: [PATCH v2 1/1] xfrm: nat_keepalive: avoid double free on send
 error
Message-ID: <akPMu8LwZN7Sz0HO@secunet.com>
References: <20260625055513.1841167-1-n05ec@lzu.edu.cn>
 <CAHsH6Gupn_PVjZjOWPRLWL6LCL=-p8Gde6_BruGdetn+eP3NMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHsH6Gupn_PVjZjOWPRLWL6LCL=-p8Gde6_BruGdetn+eP3NMQ@mail.gmail.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303210-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:eyal.birger@gmail.com,m:n05ec@lzu.edu.cn,m:netdev@vger.kernel.org,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:yuantan098@gmail.com,m:bird@lzu.edu.cn,m:qianyuluo3@gmail.com,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lzu.edu.cn,vger.kernel.org,gondor.apana.org.au,davemloft.net,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lzu.edu.cn:email,secunet.com:dkim,secunet.com:mid,secunet.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[secunet.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6EF9B6E53FA

On Sun, Jun 28, 2026 at 06:42:44AM -0700, Eyal Birger wrote:
> On Wed, Jun 24, 2026 at 10:55 PM Ren Wei <n05ec@lzu.edu.cn> wrote:
> >
> > From: Qianyu Luo <qianyuluo3@gmail.com>
> >
> > nat_keepalive_send() frees the keepalive skb whenever the IPv4 or IPv6
> > send helper reports an error.
> >
> > That cleanup is only correct before the skb is handed to the output
> > path. Once ip_build_and_send_pkt() or ip6_xmit() takes ownership, the
> > networking stack may already have consumed the skb before returning an
> > error, so freeing it again is unsafe.
> >
> > Handle the pre-handoff failure cases inside nat_keepalive_send_ipv4()
> > and nat_keepalive_send_ipv6(), where the caller still owns the skb, and
> > keep nat_keepalive_send() responsible only for family dispatch and the
> > unsupported-family cleanup path.
> >
> > Fixes: f531d13bdfe3 ("xfrm: support sending NAT keepalives in ESP in UDP states")
> 
> Thanks for the fix!
> 
> Reviewed-by: Eyal Birger <eyal.birger@gmail.com>

Applied, thanks everyone!

