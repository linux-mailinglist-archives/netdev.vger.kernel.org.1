Return-Path: <netdev+bounces-281207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LU4AiTG7ml5xgAAu9opvQ
	(envelope-from <netdev+bounces-281207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 04:12:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F3F46C0DF
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 04:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E5CF30068DF
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 02:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F19E2E6CC7;
	Mon, 27 Apr 2026 02:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CzHRNtkS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6862E6116;
	Mon, 27 Apr 2026 02:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777255969; cv=none; b=rqWN0PT3fNXRjCGPGQmoy/UYeQrZq6pG9rIl5fkJ/CUYI0xjmfdPA/S/kigEvnLiC1bJQW9DumTQq6INtOAu1mgdvrNvBpQC4Nlu8W6l8AESDzhQue40xs2nrKgaD3lZNDrs6fsDBXpOV9okPR40mYdrDroGnSSCQOVQwV1Ar9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777255969; c=relaxed/simple;
	bh=VSAvZtHfEDU5KMQbNdZWssH8NOiiuDtf2ZvUUNFp7Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcxKkLszr6EMbske6iEdaV2TykS8nNnLAeFCib9hzcXiIlpJVsaeV0mnA0BRM1LtEmfKR+ALv2pwHLiYJ1spRl0U7yDC2RBq0CqBwYFd9OccUJObSZndIcSo1w1cyjF5X86Fjm1SmdZVYmzFbNd7klM8+BrUipfKmjtUUZ8mN/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CzHRNtkS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MgEJ69q6/2Eo5Fd1kCxFRwD38wAChneaqSi9dudAnds=; b=CzHRNtkSVcsgjQttPhHJZr1aWG
	Fen/7A4JakTlcpSG0UjhRcS3zoMAlQs/JQNrsdzKmD3dU9l/JSFu2g0+DyoF4BC6YRwbXKZhlc174
	jOYYtIS7CejKLj7nhQQ9l278hzs59kraxuFhUuRn6wfiAg3cHqhM1nQ2ldfWriHRf5mU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHBSZ-0005Za-2E; Mon, 27 Apr 2026 04:12:31 +0200
Date: Mon, 27 Apr 2026 04:12:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Palmer <daniel@0x0f.com>
Cc: Jakub Kicinski <kuba@kernel.org>, torvalds@linux-foundation.org,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: Re: [GIT PULL] Networking deletions for 7.1
Message-ID: <bf856521-c391-48a5-904b-69975588da97@lunn.ch>
References: <20260423235422.1541768-1-kuba@kernel.org>
 <CAFr9PXnNVL4mUEu19jMu2sPkOucGK7Q32iB-7FY8eUpKZY_XJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PXnNVL4mUEu19jMu2sPkOucGK7Q32iB-7FY8eUpKZY_XJA@mail.gmail.com>
X-Rspamd-Queue-Id: 32F3F46C0DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281207-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

> If this does get merged and someone wants to put one of them back will
> it be as simple as sending a revert?

Yes. Ideally with a patch adding an entry to MAINTAINERS for who ever
is volunteering to maintain it.

With drivers this old, my _guess_ is, those people still using them
are not your typical users, but enthusiasts with the skills needed to
do patch triage. Decide if AI/bot driver bug reports are worth fixing,
and patches generated by newbies are helpful/harmful, etc.

	Andrew

