Return-Path: <netdev+bounces-301849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id znUtKxGXPGqnpggAu9opvQ
	(envelope-from <netdev+bounces-301849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 04:48:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0956C2760
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 04:48:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HolgLYdh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301849-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301849-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5280F3029E43
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 02:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB35291864;
	Thu, 25 Jun 2026 02:48:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E775A21773D;
	Thu, 25 Jun 2026 02:48:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782355696; cv=none; b=FDQN8LVeEwZ4qckUPd7urcdBe12DAJ/rXrzXoM4HtQnzhus1Ov4ftpuWstxrIwevzhjSiy/8xVvf5KG9ye+PDeQtc59aN3wVvB6QHbt1P5APp0qGO7l6WNrT68hB+GCt/dZyXuA9cJHJWUKP0L654rrxQ2/lPYY8CIJpba4OQjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782355696; c=relaxed/simple;
	bh=vjbeSP5smM1dIMr0Bdr4YKNk9KN39+pe1aZylvOxals=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R05VcDtoZgPAt1zhWrQp7pkL9ZqpNGptaK6iuuDtCfW8AAKGV49JuhGgUfb+S7mOD9ituwhFRIpTe/ql2qZLId7lwXR1nSgcqY/JhAWGyqVWMZEPj/kgJ5X6tC62/38tx4621vl9hHJJcAZmkLYvOSFgyiPUpiXFBCl0m2uMJiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HolgLYdh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A741F000E9;
	Thu, 25 Jun 2026 02:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782355695;
	bh=vjbeSP5smM1dIMr0Bdr4YKNk9KN39+pe1aZylvOxals=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HolgLYdhcI44tmkHBqhcNk+vR4TYfk3uC/URHebjxdZMjMJRuLWqtCY/vaz9Qzw9b
	 1CQGlg3d6Vs6DlgpUlsDEuy8/YZFVIfKByIJI4mF7kqtWePqSATOSy6J5YzTT3fi4H
	 9QsBxRwmIqizT93ruEMecJREKiEoyww4TtKOER5oAQhNL2Dw/emyFAJQ0uj7dfJXtg
	 z/Q+uBstWq93ukndAbMlCRQV/77H446aSPWQVrmqmEFJf3lGu4kznVWyqBS+L2dgPw
	 0gCRGZ67VNhwcMqehnWflNHjR6oaADi3urCBzF0dYefcTDSOxbA+JdE+w1/KqPWUNd
	 D/oq/0gE6KwKw==
Date: Wed, 24 Jun 2026 19:48:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: madalin.bucur@nxp.com, sean.anderson@linux.dev, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 florinel.iordache@nxp.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@kernel.org, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH net v3] fsl/fman: Free init resources on KeyGen failure
 in fman_init()
Message-ID: <20260624194814.350800e9@kernel.org>
In-Reply-To: <20260625004834.3394389-1-haoxiang_li2024@163.com>
References: <20260625004834.3394389-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-301849-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[163.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:haoxiang_li2024@163.com,m:madalin.bucur@nxp.com,m:sean.anderson@linux.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:florinel.iordache@nxp.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@kernel.org,m:pavan.chebbi@broadcom.com,m:leitao@debian.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D0956C2760

On Thu, 25 Jun 2026 08:48:34 +0800 Haoxiang Li wrote:
> fman_muram_alloc() allocates initialization resources before
> initializing the KeyGen block. If keygen_init() fails, the
> function returns -EINVAL directly and leaves those resources
> allocated. Free the initialization resources before returning
> from the KeyGen failure path.

Please slow down. You're sending a lot of low value patches.
Please do not have more than 5 outstanding "active" networking
patches under name at any given time:

https://patchwork.kernel.org/project/netdevbpf/list/?submitter=215341

