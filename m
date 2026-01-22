Return-Path: <netdev+bounces-252411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPU6CqpCcmnpfAAAu9opvQ
	(envelope-from <netdev+bounces-252411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:30:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AF368DC4
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A82030015BE
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 15:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242BF38A284;
	Thu, 22 Jan 2026 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYhT1yn4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA5934F24A;
	Thu, 22 Jan 2026 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769095845; cv=none; b=Zv1GoGPWG9OrxSANGsSoXloPK96T1fXaqIiyAyccu9ltTtbvqu0zz/bWmI0RaEuz11EspOQpMsOGpsGyVjsMfv3OT1r8ftmM8edU2f0oiGDRx/o2+LgO2PihXtrShSAm9ddD489NByqqnV9/QuaFq/fiUK0USVpr//Ch9C7aqoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769095845; c=relaxed/simple;
	bh=ANg5M9bdXUHW9bMx19M0GjytrhaC2dSQ5F7F+spFkJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m8Vq1mSfso8PSYrKN6ikMF+gIwvQTjefxsrxinXdlKhknEA4NqHaifATjOeaxJfYJ7aHtRpZLs9hhglOvWAkd9mODtR8Vlnsq0GqdmNidsxwAN+sC5M/dBE3/rvxmZI4zgRmlq6qPoj6oPwvT/Kcg7M2QoEzfEYBiUrVyHQDeWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYhT1yn4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D54C116C6;
	Thu, 22 Jan 2026 15:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769095844;
	bh=ANg5M9bdXUHW9bMx19M0GjytrhaC2dSQ5F7F+spFkJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IYhT1yn4Bjgk3YWlRzOiqht4ndOe/2FortRNdEusRVbggBT0EGruRInA2in7lfeX7
	 lPZraa64Lz7NL4cseEA9rPcU95OYYPE1ho7FENs/kGc70IpaXjD3zgFItBDhn92Drs
	 BPlkJ5arVrS8FG17CLSc2RvrXaB5DZbz+e89cBl/y/+W93VuM6+J+sRsGXYvCqkS3p
	 DC5OMHBNauNWCys0NP8G7nGji3PLMPvwzx6R/N2jTxX6UuT/cPUg9OMJteSheyFsU5
	 +UeGqXJPS5Uya+qNfPnkDWn+qDTLjkbRhvK2csnMyL/16eUDhTeKwny/Tq/5+cdc2G
	 Q4KnaafOpi8eg==
Date: Thu, 22 Jan 2026 07:30:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Yixun Lan <dlan@gentoo.org>, Chukun Pan
 <amadeus@jmu.edu.cn>, Michael Opdenacker
 <michael.opdenacker@rootcommit.com>, netdev@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: spacemit: Clarify stat timeout comments and
 messages
Message-ID: <20260122073043.3089d435@kernel.org>
In-Reply-To: <5639ff0c-dfd1-4528-a0ce-92d3c457ce64@iscas.ac.cn>
References: <20260121-k1-ethernet-clarify-stat-timeout-v2-1-76ff1a1168d9@iscas.ac.cn>
	<20260121200439.64c22125@kernel.org>
	<5639ff0c-dfd1-4528-a0ce-92d3c457ce64@iscas.ac.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252411-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 93AF368DC4
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 18:39:06 +0800 Vivian Wang wrote:
> > Because if it's the latter we should be able to skip reading the stats
> > when link is down (still racy but better than waiting in cases we can
> > detect?)  
> 
> If checking the link is definitely up as a condition for updating stats
> would be acceptable, then maybe the original patch from the linked
> thread [2] can also be adopted?

Yes, speaking under correction if Andrew disagrees, but could you
squash those two patches ([2] and the v2) into one?

