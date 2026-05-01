Return-Path: <netdev+bounces-283051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKrtK7j982nj9QEAu9opvQ
	(envelope-from <netdev+bounces-283051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:11:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 721114A97BB
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B289E3010629
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 01:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E01929B781;
	Fri,  1 May 2026 01:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjs1zysK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7FF264A9D
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 01:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777597871; cv=none; b=IqOSJk1nMEJEaePj1ibpzazBREEua1J1+0N9QW16HqaoNVpmYqPq7kOq1LfOEGmKWlFqMXaf9thbuzl5HDKVDB2/0fC9VevA3cJjXwCZbC/ZW9YtJ13MmRCjCrzF4fTRuO0+nalzTcqRtlsxlQDBsdGX0h9azKEvYxsKJK4Lapc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777597871; c=relaxed/simple;
	bh=iH/p+QtR2LkX7EPSpsttq7TDnYDbp0jfIyCaRYZNvX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/mfP5VLIGpLm6eSyopeGFtUKKWpHV6ZadDSD8pywAoKbgJImHrtFn3xq5eJsu3zhM3USwnAOb4GO6P9Swx6Lb1fPrnDBRsnjrwcNgk14CiiOJ31tb03hCfUeqZn/pMdlD4xeXRnJek9n6NUmiL/H9HwG9ncbOS9mrKephEDUZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjs1zysK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B61C2BCB3;
	Fri,  1 May 2026 01:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777597871;
	bh=iH/p+QtR2LkX7EPSpsttq7TDnYDbp0jfIyCaRYZNvX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kjs1zysKsB5u7Ub6LZJvdV9NON1tf33hwhMQ7GdozOwBN+QXknDE1Wwy9vbibNOOs
	 t/xyBX7jJmN0uGNNj4oscsFZb+JVUp4ZSDf2tsDmxtPinpCoakaV2W9rlh/5AigPby
	 L3Oumpzq5ZSiZo0//SAWrAV17vh+udSPf7Tsjr+Ywt6FYKKT/vEtzbdcLqtPAIcz+t
	 xcXXKPCI5eaAhxpT22ulz8aJH88a/xuZlRqjQvX7J2q/WKM46Rj7HEbpa55FbmKAmd
	 FA+Ha2MjzPe3gzRpQo7ihrFSSwvGUdjCHxsjbtFQ2jgO/YwoazmJuPsYaJU0W74q/w
	 UGw1BRjVAjKNg==
Date: Thu, 30 Apr 2026 18:11:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: airoha: Introduce
 airoha_fe_get()/airoha_qdma_get() register read helpers
Message-ID: <20260430181109.68c65940@kernel.org>
In-Reply-To: <20260429-airoha_fe_get-airoha_qdma_get-v2-1-909e791f1dc0@kernel.org>
References: <20260429-airoha_fe_get-airoha_qdma_get-v2-1-909e791f1dc0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 721114A97BB
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-283051-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Wed, 29 Apr 2026 12:54:32 +0200 Lorenzo Bianconi wrote:
> Add airoha_fe_get() and airoha_qdma_get() as utility routines for reading
> a masked field from a specified register.
> This is a non-functional refactor, no logical changes are introduced to
> the existing codebase.

Doesn't apply AFAICT.
If this is because of the net -> net-next merge - please avoid posting
patches which will cause a conflict on merge.

