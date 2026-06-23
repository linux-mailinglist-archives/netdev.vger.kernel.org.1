Return-Path: <netdev+bounces-301398-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9wVYKlOjOmpzCQgAu9opvQ
	(envelope-from <netdev+bounces-301398-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 17:16:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9927E6B83E1
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 17:16:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=o+gcWmXA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301398-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301398-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 57FCF302F75F
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 15:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B43C3CAA50;
	Tue, 23 Jun 2026 15:12:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8809A31E84E;
	Tue, 23 Jun 2026 15:12:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227567; cv=none; b=YsKa2EytF+MtkHAmZG1/gNtXiN98LB2ksKsudHaXJpYHSpFfyUNUdUFK2m+g7L4/qXqWE5czi3ZSmOzwkmVffMfXGih5i8bV1/5EorgNaykWVWRd9eQTr68W94MlLQvQBc/dNbrtxJB2eSb+/66vnnaxEaZUBjYrFLJRYACgjA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227567; c=relaxed/simple;
	bh=nPC4jdeJcRErLmYE+XtVF3VnxBQ2rVXb5nY0nlEKnRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Du1Crdz8oZC8WdSElNh1c9ytlBsJCIbOLMPbyOvQ/CHz91t/mgwRZgMspOfwoeJV/30uXOwlpl8tgYK3Q3cUUKGzrOTkjPiI3iZA+2aU1zIrK7i5RaO4XcsnkdfVlaXhrZhh3WbP14byGHEHTSUW+qOxJXPOS5uBYZ26Er8VdMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=o+gcWmXA; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GqkkKeTlLEue6st69aJaBvzWr7y8e4iXOI20z07pTsM=; b=o+gcWmXAdYjZqz94bMd6mlmTqZ
	KciTdDSSP879m3W5yR696vuTIAUwxoO2nQtkXPTLhEm0NA2K9AAedLmNu1oUbylD0petHRIybNzul
	QmDr8f/4ucgdQStKPwwtVoepaxIQxu2SqU854Ce74+5xUVYnsdaVxvDADQet/Dw1j1e5O+wUqeRR0
	e8MvpreKu5utObjQl0hns16vzEq0JCAC16gSjZLnpEWCx9pe+6/gB+W+1GBOMRFJ/1XFu+cwTpIUF
	pFKEWzfJJ8CiCfmOfkBcu2HoCRxVFAse77fUvwkmM6T0gxobmI3f9wdN7vVNBXSsbEil+LGTuyfHM
	OGu9L1+g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wc2ng-001jhy-3D;
	Tue, 23 Jun 2026 15:12:33 +0000
Date: Tue, 23 Jun 2026 08:12:27 -0700
From: Breno Leitao <leitao@debian.org>
To: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com, 
	dust.li@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com, 
	wintera@linux.ibm.com, pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com, 
	guwen@linux.alibaba.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH net-next v2] Documentation: net/smc: correct old value of
 smcr_max_recv_wr
Message-ID: <ajqh_3YDwz9q5Aiz@gmail.com>
References: <20260424052336.3262350-1-mjambigi@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424052336.3262350-1-mjambigi@linux.ibm.com>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301398-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mjambigi@linux.ibm.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:wintera@linux.ibm.com,m:pasic@linux.ibm.com,m:horms@kernel.org,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9927E6B83E1

On Fri, Apr 24, 2026 at 07:23:36AM +0200, Mahanta Jambigi wrote:
> The smc-sysctl.rst documentation incorrectly stated that the previous
> hardcoded maximum number of WR buffers on the receive path (smcr_max_recv_wr)
> was 16. The correct historical value used before the introduction of the sysctl
> control was 48. Update the documentation to reflect the accurate historical
> value. Also fix a couple of minor typos.
> 
> Fixes: aef3cdb47bbb net/smc: make wr buffer count configurable

This Fixes tag is broken. You probably want:

	Fixes: aef3cdb47bbb ("net/smc: make wr buffer count configurable")

Other than that, it looks good, the corrected value checks out.

