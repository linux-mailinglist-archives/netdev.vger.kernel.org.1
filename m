Return-Path: <netdev+bounces-290013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMtcEfbnDWrM4gUAu9opvQ
	(envelope-from <netdev+bounces-290013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 18:57:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF92592B42
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 18:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53F1B30A415F
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31BC3BB9EF;
	Wed, 20 May 2026 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="CwMKLwtZ"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300D139C00B;
	Wed, 20 May 2026 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295830; cv=none; b=dTY+cuRSwVI7xV/eeF84fkaETD0Wl5ooTuGv60r/JkL9jYXGFGBtnaKyvdE03BRi/fQiWO0kULnKdMCOLPgIOKcaSaX4It5trIXQhBuvNOqvZ0DtXU+8yb84K8hIFaJogdP2r6c3UomdUy7AeyOILhKpZdDgspGHh5ox/QE4eHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295830; c=relaxed/simple;
	bh=1IyL0qaFWcPO4WUDBAibOqvMTxk2WBYZlkzKdMQx9oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hO2OU9GfkKWcQjrqT289iZvmSusHzxCgwgVWppCSdQ9QiEG0vSbid3KFSMEA74yhOHauJevUJEEHmA5yl9TzDcSgI4CbbUhnvAXYGxOA4BT3ZO+H2mJiIlfSv139hlSn9FscXllu+IGQTFeKyJ4iU19bqhEeAvtvLUUGEg8R5qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=CwMKLwtZ; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1IyL0qaFWcPO4WUDBAibOqvMTxk2WBYZlkzKdMQx9oE=; b=CwMKLwtZrxaUWnM3khs0eTJitd
	kIHNy/IOhpoR12m+484ksV0lXTCNPd7IylNBGPVTggOmWLCDB+8GazHf1P6LZKmq004dS7PknmEO4
	pSC7GFerFQBVa/8OCdyxbqqfmZmared0K0qCynwXyHLtN+Dqb+3YqjojgpCeW/+qHQvgR0EddV7Sp
	nK4qyigtMQL4+ym6vWQljMHDUpCgjJZQ2vMDBJsnIzK8hcCOIL6DDPJs9MZOL+kXF4MXbzPRBaOUl
	y4LL0ngJSbSd8iIX5O4Oeimh+CFqMcABxrUishdNL78wyK9tGJubd+T5lIiUmXoZrgTBBgF85Z/Q3
	p4JxUO4w==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wPk7O-003FKu-1z;
	Wed, 20 May 2026 16:50:02 +0000
Date: Wed, 20 May 2026 09:49:55 -0700
From: Breno Leitao <leitao@debian.org>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, 
	Chas Williams <3chas3@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
	Thorsten Winkler <twinkler@linux.ibm.com>, James Chapman <jchapman@katalix.com>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	David Heidelberg <david+nfc@ixit.cz>, Samuel Ortiz <sameo@linux.intel.com>, 
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-s390@vger.kernel.org, linux-afs@lists.infradead.org, oe-linux-nfc@lists.linux.dev, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next v2 1/7] af_iucv: take socket lock around
 SO_MSGSIZE getsockopt
Message-ID: <ag3kBcOwEDrqX8hk@gmail.com>
References: <20260515-getsock_four-v2-0-0d8eed952627@debian.org>
 <20260515-getsock_four-v2-1-0d8eed952627@debian.org>
 <ageFn6UV-c-pOPBW@devvm7509.cco0.facebook.com>
 <732d4698-8b36-4803-9c81-ae9865b3f943@linux.ibm.com>
 <ag3aAv4AV7VXQnKo@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag3aAv4AV7VXQnKo@gmail.com>
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290013-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,intel.com,fomichev.me,iogearbox.net,linux.ibm.com,katalix.com,auristor.com,ixit.cz,linux.intel.com,lists.sourceforge.net,vger.kernel.org,lists.infradead.org,lists.linux.dev,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,nfc];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EDF92592B42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 09:03:14AM -0700, Breno Leitao wrote:
> Let's try it once more in the same series, if this patch doesn't set
> easily, I will split it in v4.

Sorry, I've just changed my mind, this patch is better suited as
a standalone fix rather than part of the series. I'll exclude it from v3
and submit it separately to 'net' instead.

Thanks
--breno

