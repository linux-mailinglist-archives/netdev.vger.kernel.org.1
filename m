Return-Path: <netdev+bounces-253981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAE6MeIKeWnyugEAu9opvQ
	(envelope-from <netdev+bounces-253981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 19:58:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF8E997FA
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 19:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4CCA30268C0
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531BC346E5D;
	Tue, 27 Jan 2026 18:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCil7Av/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFE03271FB;
	Tue, 27 Jan 2026 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539987; cv=none; b=tdxHkStX8DdqlmWZEB8V1qiNWs/+i/a6An+w0hIUlPIuFFaDvR9WojOenmW7x57Ta7B8B3eifPWdstekRkmfb0GV9HSPZSrfHGhYAICHu62ku080bg1mm3Y6OoQGih5KFOiW++0BYQCOevmVm4mYxuwDOAxFw/26FMk6ymRfKOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539987; c=relaxed/simple;
	bh=GZCoMlfvieIY4SnhDAPojfug9cNjrcmF3L7heUTj1DI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGy/+aMw74o9Kjhm5596uWledORquAKLAwlpvHq15Y2e69LBvZgcvecy8yuQQxWeC0UcJhGDVd7UmU9cwNr5eg0esKP2J80IslF8fx9/vZcKTytnAr/Kf3i0BYXqLTVcznYqEtRXznx8TH6kwVSO+pqJZ0a0uewc+wC18ZQbqIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCil7Av/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AF7C116C6;
	Tue, 27 Jan 2026 18:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769539986;
	bh=GZCoMlfvieIY4SnhDAPojfug9cNjrcmF3L7heUTj1DI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pCil7Av/fGrXIwk9h4hyuqdSM8Bkai+2iwCbsg8y+oPHlRfkLrjKMWkB11l98bZWc
	 4eiAB2dlblxjeg0URw2IrRj/ehBhXVjcKlg6GzbSpYxSoN3kJGS7JjOltdnfP3Qta3
	 oRsNFDVlrDLO0WroiRu+xoge5CTkyq0TF/DT+r9Bf5gsrKiWAmxDv9dxNCCYKE0gE5
	 VZ0n3r6ReFd6UvW8wMGGuIWhMUht62kOqS1/MiJgdYsaMazlCPFMkI4d5+LTT202pu
	 2FPyeJhTUHIY4V8qababczKm4kqMGFdeUOetkTvkCoxaHbV3eW4jlS11S7Tcm2Pdn8
	 XGyDxBk37oBvA==
Date: Tue, 27 Jan 2026 10:53:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>, "illusion.wang"
 <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, linux-doc@vger.kernel.org, lorenzo@kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 hawk@kernel.org, ast@kernel.org, bpf@vger.kernel.org, sdf@fomichev.me,
 daniel@iogearbox.net, john.fastabend@gmail.com, edumazet@google.com, open
 list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 net-next 00/15] nbl driver for Nebulamatrix NICs
Message-ID: <20260127105304.21279cc2@kernel.org>
In-Reply-To: <aXj-uam1HodC0851@horms.kernel.org>
References: <20260123011804.31263-1-illusion.wang@nebula-matrix.com>
	<aXj-uam1HodC0851@horms.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253981-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7EF8E997FA
X-Rspamd-Action: no action

On Tue, 27 Jan 2026 18:06:49 +0000 Simon Horman wrote:
> As per Jakub's advice in his review of v1 [*],
> Please try to create a minimal driver in the order of ~5kLoC.

Perhaps other maintainers will disagree, but for ease of review
and to avoid the huge reposts perhaps we should consider merging
something like patches 1 and 3* first, as the initial series.
And then you can build up the driver from there in reasonable,
5kLoC-at-a-time series?

 * patch 3 currently includes things which do not seem machine
   generated / like register descriptors like structs added to
   nbl_def_channel.h and nbl_include.h

