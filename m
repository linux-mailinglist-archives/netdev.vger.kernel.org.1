Return-Path: <netdev+bounces-305869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IRgTDQNzTmr3MwIAu9opvQ
	(envelope-from <netdev+bounces-305869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 17:55:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 118BD72853D
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 17:55:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=dzkd2OQ3;
	dmarc=pass (policy=none) header.from=debian.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305869-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305869-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 740343059B7D
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 15:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3783F12E3;
	Wed,  8 Jul 2026 15:28:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33F43F12E4;
	Wed,  8 Jul 2026 15:28:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524533; cv=none; b=PzfV1Bd+fcevfQ+TYN9+4A8W2d+hr2jPt7Prq74vm0qSr4bdYvwYWiL7/ibmCX0hd2cNBv//JHNLKi3FFpQtQw6/DJie/QSowyJRkYWqcDzeItBMHh9geprD6pbe73gKc5L6rldchVtHFPsciRaEk2P4yk/pH5vCUtfMNv5X7uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524533; c=relaxed/simple;
	bh=1ju68Xv/NlzZW//1sBD79uM3omaujy+mnV+pNBjuuUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbNmjCQeIP9zLX21UBS5FiO6EP9FXXnmMzUmlkC/cuLcA45yFj0ck/jBfAzvFYjBco+hyBsDx3R4An8KqXigS2QqtXH79q7rfRBPQuW2s63o+w8tZx/fevQRx+k2qaFk3imq2XXfXctZTyZxIkA96pwHL41JiywrPtjdFslk69I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=dzkd2OQ3; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1ju68Xv/NlzZW//1sBD79uM3omaujy+mnV+pNBjuuUI=; b=dzkd2OQ3ZsiyvJsUAsdLfm+6sm
	qA3P/1H8aWGrS2pt7Dgn1YFPB7flBNCdF/3FGFiEB1arva54JGo5cUQTEJ/S5XsX0FPJQLrO3k8xH
	+WZUYC/yEb7uNSxFuQu/yexNHCtaQfHFEn72fummTIUK+fiqxGcd1SXs0JbYY4gQAKPtId0Kto6qE
	wlF5QluNdETfauSRoeJg58q15zdg5FrFWB6laYleujHfpEcbgNnjxCUi6H+lxMqcxHNwMuajRO9GJ
	S0L/HOOg2zId1427jswtOKFv68jy639LF0t64x1ojQvZ4ulDmv6BIa7DjYxGyMPIsj6YIuuC5iZx6
	MfPeiRDA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1whUCX-0032iJ-28;
	Wed, 08 Jul 2026 15:28:42 +0000
Date: Wed, 8 Jul 2026 08:28:36 -0700
From: Breno Leitao <leitao@debian.org>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com, 
	sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch, corbet@lwn.net, 
	kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org, pabeni@redhat.com, 
	vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com, edumazet@google.com, 
	enelsonmoore@gmail.com, skhan@linuxfoundation.org, hkallweit1@gmail.com, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v21 net-next 01/12] net/nebula-matrix: add minimum nbl
 build framework
Message-ID: <ak5sjL21NQSWDB9S@gmail.com>
References: <20260708064742.35391-1-illusion.wang@nebula-matrix.com>
 <20260708064742.35391-2-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708064742.35391-2-illusion.wang@nebula-matrix.com>
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-305869-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:illusion.wang@nebula-matrix.com,m:dimon.zhao@nebula-matrix.com,m:alvin.wang@nebula-matrix.com,m:sam.chen@nebula-matrix.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:kuba@kernel.org,m:horms@kernel.org,m:linux-doc@vger.kernel.org,m:pabeni@redhat.com,m:vadim.fedorenko@linux.dev,m:lukas.bulwahn@redhat.com,m:edumazet@google.com,m:enelsonmoore@gmail.com,m:skhan@linuxfoundation.org,m:hkallweit1@gmail.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,kernel.org,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nebula-matrix.com:url,nebula-matrix.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 118BD72853D

On Wed, Jul 08, 2026 at 02:47:27PM +0800, illusion.wang wrote:
> From: illusion wang <illusion.wang@nebula-matrix.com>
> +Support
> +=======
> +
> +For more information about m18110-NIC/m18000-NIC, please visit the following URL:
> +https://www.nebula-matrix.com/

Do you have a link for the site in english?

Thanks

