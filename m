Return-Path: <netdev+bounces-261693-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMFNBlQQoWlDqAQAu9opvQ
	(envelope-from <netdev+bounces-261693-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:32:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A58A61B2475
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52DC330C7D38
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F92F2FFDE4;
	Fri, 27 Feb 2026 03:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BW6DautK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E922F1FCA;
	Fri, 27 Feb 2026 03:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163038; cv=none; b=pBmRZoRpKco3kz7m/34G83FT/zxtACudY9y7LmaAl+NnTroGro6iBcT+7bxCGBZwuxFOsh985QNU7+fKru9dr15tqDC8CHejR82gB4yg2wjKZDDCyeDZNxG4DQ6PpmtM6XLIw3DKgqzyWwDjo2ZmvD51YxpWzs2Ho/O6MDZQsb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163038; c=relaxed/simple;
	bh=uI3j6DRmBkXWULFnXqlQf+BiSX/P55PHnGunZeBTc+s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4fjEcmJZF0bSrxPCeFWTWpWwMwmGewXK1+yLxkocREUyfABy2tf/yZgD73Q+yGdzVTyrCIRKTmwA7Gh8apti2A71rqpoykJW5Td+Bp323pJBAZYoBrfJXarka543QPu7IXlLGG3DRb2NYi1PsqGVB6JPDUP/WG/HNQPKYZhoP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BW6DautK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AECAC116C6;
	Fri, 27 Feb 2026 03:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772163037;
	bh=uI3j6DRmBkXWULFnXqlQf+BiSX/P55PHnGunZeBTc+s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BW6DautKTGhv0C64x2ff1vFvE0EadOhiHa0SZz+Io+yBuUEFqypxT9r+s1XuUDuDU
	 T3VKYFABAFmlHntUmABb+NaLcrSAmKYys9wZ//LNjNy+bSwww1F5HxV4KZL1CDProa
	 ctNQzZh+pbeIItHyrszQJ2IFNXGiQvk6Ch6ZqckFPAh+AncfI+iOVB1wLQInlrCYVi
	 VVPWvAi3/Rz9ye5feE+rbz64Zn5L69lRHa2HHvRqosHlTk+/er4wOlF4y9YZGydxHc
	 xQsGU8wcNfDiqF0l9/o+1JiJ9IF5K79SLSTgLood3ZDpqK1ZEErHQgVvMHxlN0RSdI
	 83qZAsL7k0xaw==
Date: Thu, 26 Feb 2026 19:30:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: tomasz.unger@yahoo.pl
Cc: horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nfc: pn544: i2c: Replace strcpy() with strscpy()
Message-ID: <20260226193036.39b93497@kernel.org>
In-Reply-To: <20260225172715.75756-1-tomasz.unger@yahoo.pl>
References: <20260225172715.75756-1-tomasz.unger.ref@yahoo.pl>
	<20260225172715.75756-1-tomasz.unger@yahoo.pl>
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261693-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[yahoo.pl];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,yahoo.pl:email]
X-Rspamd-Queue-Id: A58A61B2475
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 18:27:15 +0100 tomasz.unger@yahoo.pl wrote:
> This is a bug fix, not a cleanup.

Could you include an example path thru which a firmware_name longer
than the array can reach the driver? On a quick look the input comes
via netlink which sets the max length appropriately.

