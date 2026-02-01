Return-Path: <netdev+bounces-255561-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BmpDRWjfmnRbgIAu9opvQ
	(envelope-from <netdev+bounces-255561-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 01:49:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAE0C489A
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 01:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 176B93018D7F
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 00:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6986E1A08BC;
	Sun,  1 Feb 2026 00:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7jcg+kp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435BC3EBF1F;
	Sun,  1 Feb 2026 00:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769906962; cv=none; b=UiZuOrWt8hKtMtXusl8HtnemPdushBSQZ3auXr+ZyQfAkX3OUmA9NaG7HQYDkVTOO8eaw7ZrtSXi3poynZYbPgS6kv942347H7kK+IBVSQPthJ26hDbxHQgODCT5fGlf9wyrnOEzO1bFHs2SRlRfdMtOn9rZRPlY7MDKXOsdukU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769906962; c=relaxed/simple;
	bh=NJ5+zTrjpK/C/d7JBXEq+LHzGzjvo1Z3mf8hdmSu5Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GlkVzzek5NOm5re5iyOa1tM0oXrgUY/F8h6GvDcbnA4OMK2Y78etvlMuww2b4m+JaTC3jiXH01+uV3gc9TdnfssbgoliPoUqRkIjLj2HhUI/tIibMqLVIK4nUrCibIeIGAC2M6j3L4jtaYWqQF/NNEF1Q4P48T9vLHV8SIX76+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7jcg+kp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBB5C4CEF1;
	Sun,  1 Feb 2026 00:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769906961;
	bh=NJ5+zTrjpK/C/d7JBXEq+LHzGzjvo1Z3mf8hdmSu5Ao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K7jcg+kpf2EYnTnQ8cIPQXY/0kwwp1Q5FVq8aVvD2co01bISKURWfsN8dtblRjv/j
	 kB5BqB38k3z4Xns57abHbJYTm7oOPJBWrhyrsCfroGpsjx74J7Pw6ClhMsW1xmqWnm
	 qDID2eisiU1QuIfbw0+saYfvFZqnWo6lqyWVIqK3ssG/SBo7akNA2UAi4jj+WMLHs7
	 sbSKXmvbpAvpy3lKCu+ehaJXUo+5Uj+njBJoCluiE5I3UqEh8vVmwmp3FnlZG7DJ0t
	 bRMuLyiU2MglpH0cMqnRfpG7B3XXCuna0DJT7iPPxe/yUnKOmd2DrezepQ6MpGoLSt
	 cv47KjISNgDSg==
Date: Sat, 31 Jan 2026 16:49:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, Alexandra Winter <wintera@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>, linux-s390@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next] net/iucv: clean up iucv kernel-doc warnings
Message-ID: <20260131164920.7e92896f@kernel.org>
In-Reply-To: <16c2528a-85be-4f7b-a60a-923613ecc8fb@infradead.org>
References: <20260130054759.1301608-1-rdunlap@infradead.org>
	<20260131131131.0d854805@kernel.org>
	<16c2528a-85be-4f7b-a60a-923613ecc8fb@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-255561-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CAE0C489A
X-Rspamd-Action: no action

On Sat, 31 Jan 2026 16:01:04 -0800 Randy Dunlap wrote:
> On 1/31/26 1:11 PM, Jakub Kicinski wrote:
> > On Thu, 29 Jan 2026 21:47:59 -0800 Randy Dunlap wrote:  
> >>   * @path: address of iucv path structure
> >>   * @msg: address of iucv msg structure
> >>   * @flags: how the reply is sent (IUCV_IPRMDATA, IUCV_IPPRTY, IUCV_IPBUFLST)  
> > 
> > In general -- Could we possibly delete the duplicated kdocs in 
> > the header. As clearly shown by this patch it's double the work
> > and kernel-doc will be able to find the definition wherever it is.
> > Kernel coding guide recommends kdoc next to definition.  
> 
> Thanks. I'll check all of that.

You probably figured this out but reading back I realize that my
message wasn't very clear -- I meant that some of the functions
are both documented next to their fwd declaration in
include/net/iucv/iucv.h and the definition in net/iucv/iucv.c

