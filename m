Return-Path: <netdev+bounces-260091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCDXJ5p1nGmwHwQAu9opvQ
	(envelope-from <netdev+bounces-260091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:43:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD08178F07
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 753C2305BB85
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15EF2EC0B4;
	Mon, 23 Feb 2026 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0cd2s3/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5122EC090
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861034; cv=none; b=mq3ErUwFDttnKrGXlYxgTHDi055S/aQh3PaA7qtPjpZEwlZ+4vA5Mf/WHwqpFzxEgh+qHwBl+BQMXTXWWhWM9gX4GqHAYY7gW990lc6Zx0jTAQnaLknYq4yc+++dtW/igQ43JY8u6T1yewoHP1MoFQzq6jCaevpArHD0yTekd3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861034; c=relaxed/simple;
	bh=0o95pXJjgp4FLQTdYQkchaekc3rRuTiM+bQT8AHAU5I=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=jBLnbPzD6bBVHfoJnmDOwTwJW9onEpRKnFEm2LYkoQhb/veM7FMufRMCexv4KZ+qeZ8Nc7I/loiQvUULr5WcToTLIr/vnyZ4wyMhuGCBD0I0iQFuYeQ4Yer0klp9gbCwWDho4ul1/QokAQnc2u2+n8uIPMzt5jkUkcbtHMKu2x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0cd2s3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D8EC116C6
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 15:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771861034;
	bh=0o95pXJjgp4FLQTdYQkchaekc3rRuTiM+bQT8AHAU5I=;
	h=Date:From:To:Subject:From;
	b=n0cd2s3/Ay4aRGLApwb8TuwouepaKwLTiGTSNqPt92qBzQ9A+7wyYh4rmYAH5EPsM
	 51rCUTrN4dWx/xWDhbY5/gaAnENbv+h61MgOfrLgAWJE4g5DrK2bSbtf7PZk17tOwm
	 Ct3xbeaxqin8SXt9+4J2QCXxNCVjGhRps364PI4qH1HE4v00e/oD5xrsZErEsXHuP3
	 ngEvLWs1w6AiRb4UtBX21FGEd6cwNFcqCJJI8kbcTzys+YFlAHOF6Qdm0aVRNTXvct
	 nGqv6o0VjAkjf63cOlgXMEnSUCevorW7J7nalNs71lX9DaNYw98ilnMnJoe9h39/v+
	 mbKkPlVk4isew==
Date: Mon, 23 Feb 2026 07:37:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] net-next is OPEN
Message-ID: <20260223073713.711a8058@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-260091-lists,netdev=lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 4FD08178F07
X-Rspamd-Action: no action

Hi!

net-next is now open.

