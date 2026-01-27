Return-Path: <netdev+bounces-253970-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aE+tCc7+eGmOuQEAu9opvQ
	(envelope-from <netdev+bounces-253970-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 19:07:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4902F98C98
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 19:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9F5C73004CB2
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349F6324B2D;
	Tue, 27 Jan 2026 18:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlIVTTC+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DC4324712;
	Tue, 27 Jan 2026 18:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537215; cv=none; b=XezNNdG7JnldvW90AqIiPKt4AmDOQa0Bo6ZMCn8L4/nhoGXHRiNoj/WY9eqd12o3Pg6qiQA27Vg9mHsC3i+Zx5gXIoIqrXhGZkd9Z2Om+h/SE/94c/uoCWt+rOU6Z0Xc3y8Ss76pDPpoC4kpyP0LcqwNNLJMk1HZwDrkSIcOHyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537215; c=relaxed/simple;
	bh=xBwxZeG2PpLihNUtFGynbrnnONyfeENxZd6gKfTyx2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQxjG9sIum+kuuZo4FOk5lMgUEcKXcqD+rd7AvIQZ7rEAXL775W8vp60gWpQk8XMcm9chmte2HkoUQLNeqGPtstkWreWZXLQxOduAQFSnPwcpZg73hLlbxhV87JjyEHwjD9roUIElqjyO0w+L744AzQItKU/K7eG1to/ZvXujxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlIVTTC+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A84C116C6;
	Tue, 27 Jan 2026 18:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769537214;
	bh=xBwxZeG2PpLihNUtFGynbrnnONyfeENxZd6gKfTyx2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NlIVTTC+0rq7q3J9Q9AKmsq/I0LMBSgnR4E4ktDEKIB5UszmlhSrertt4pYrN/Zco
	 wM9ekqEBc2hLUCQKQTRacR7dDmBxmA/vHmt9phhM3E3UKc0XNNJ93uMrCUjfdjLG4k
	 +w3Nl+X9kh4CPIYN6ZEEmgkooVWiljGnyPTR+wmPuu3hhh80Z6ebCPDglbntwJQkRE
	 k8yqbnzcuNNXQ5R6bcI4jknoesd/2QyAJoX/IGYY3ACFgtqSv5p5bSJZCCbCDBAFG4
	 Uagqa9e9L1oxghbtkWF6CQXcYUU+81fzjGv13/0fF/4hhjM1bKv56a6ykAGpkK5DPd
	 Zht7emb7T7Rxw==
Date: Tue, 27 Jan 2026 18:06:49 +0000
From: Simon Horman <horms@kernel.org>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org,
	linux-doc@vger.kernel.org, lorenzo@kernel.org, pabeni@redhat.com,
	vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
	hawk@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	sdf@fomichev.me, daniel@iogearbox.net, john.fastabend@gmail.com,
	edumazet@google.com, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 net-next 00/15] nbl driver for Nebulamatrix NICs
Message-ID: <aXj-uam1HodC0851@horms.kernel.org>
References: <20260123011804.31263-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123011804.31263-1-illusion.wang@nebula-matrix.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253970-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,kernel.org,redhat.com,linux.dev,fomichev.me,iogearbox.net,gmail.com,google.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 4902F98C98
X-Rspamd-Action: no action

...

>  55 files changed, 26753 insertions(+)

Hi,

I realise this is down from the 45kLoC in v1,
but 26kLoC is still too much for a patchset.

As per Jakub's advice in his review of v1 [*],
Please try to create a minimal driver in the order of ~5kLoC.

Thanks!

[*] https://lore.kernel.org/netdev/20260109162051.42f71451@kernel.org/

...

