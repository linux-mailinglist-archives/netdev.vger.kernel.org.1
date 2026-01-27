Return-Path: <netdev+bounces-253948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GF5YO0rueGkCuAEAu9opvQ
	(envelope-from <netdev+bounces-253948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:56:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8B3980E0
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B331300F1A7
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D80A361657;
	Tue, 27 Jan 2026 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FHY9k/0s"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E815D352C24;
	Tue, 27 Jan 2026 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769532893; cv=none; b=YUakHnP9fmYiBr6XlbiaygvWXbiAjIkDX48DcA3XFwJ7369gCQnMcl77zhiryEtQxSnHylGpdTkM4iSxYJT4LKWqwV/vQL2u7EXk3U9z09/C4+BwETSuE1ZQdfYh1UqTSZNHKojBhOyne8do7tqhFZdsg/kMabdksDHnkgLyPbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769532893; c=relaxed/simple;
	bh=KWKe0wX4GK/AG/2rFbVu3ED65dDKanSyJnKDxVkTOZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nw7gSP8xoXT906Yu/3WSP9ChSExvb+QUnsgJXZrlpvAB6CFgtxnkFljLpAs8+VVCW3yH9qAhx6M8THeBJftgvfVtX+GO+GCxYuAKGvkhoShXE7caT2l3XoJqngM290soVL014hxCS+QWTTNjrv+rTy/wi/6D2hOh/HrGvZtXrXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FHY9k/0s; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 76C49C211C6;
	Tue, 27 Jan 2026 16:54:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 45E78606F5;
	Tue, 27 Jan 2026 16:54:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7AECF119A8695;
	Tue, 27 Jan 2026 17:54:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769532889; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KWKe0wX4GK/AG/2rFbVu3ED65dDKanSyJnKDxVkTOZ0=;
	b=FHY9k/0sIYVFFS5ztIeN/TPvuWhS7KyzaGKYYmzgvIfyRCIDneKxfgI+wSczN7KP3qCTQt
	tWqwAWboB86xuHNnH15VlglQYs2Cy+/dlK4Sv0vWUIL1lMxvRE9cIdSZWTTtR/Iyvs2dOU
	5zqxbRUVSVjK9jj8bZrgf6SPXOg/5clbelj+GH3TrJ++PL+hOvmX7io9T6BATgvbKDWgWx
	ohdWtFq+6kPNs2cPGlLvqhxZiELHMgh0beK11up0D1+mt9C6lpaLvf/xU1yTNR21BiUdUt
	eLTVtWawCRLVvogz3x/xSgt7S8+YcAlSKYeLdIZp7HBK7OXD3P4EPN0FjEH1xg==
Date: Tue, 27 Jan 2026 17:54:46 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: horms@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, jianhao.xu@seu.edu.cn, kuba@kernel.org,
 linux-kernel@vger.kernel.org, marco.crivellari@suse.com,
 netdev@vger.kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net v3 2/3] net: liquidio: Fix off-by-one error in VF
 setup_nic_devices() cleanup
Message-ID: <20260127175446.73fe9c7e@kmaincent-XPS-13-7390>
In-Reply-To: <20260127151241.1144039-3-zilin@seu.edu.cn>
References: <20260127151241.1144039-1-zilin@seu.edu.cn>
	<20260127151241.1144039-3-zilin@seu.edu.cn>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-253948-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kory.maincent@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,seu.edu.cn:email,bootlin.com:email,bootlin.com:url,bootlin.com:dkim]
X-Rspamd-Queue-Id: 5F8B3980E0
X-Rspamd-Action: no action

On Tue, 27 Jan 2026 15:12:40 +0000
Zilin Guan <zilin@seu.edu.cn> wrote:

> In setup_nic_devices(), the initialization loop jumps to the label
> setup_nic_dev_free on failure. The current cleanup loop while(i--)
> skip the failing index i, causing a memory leak.
>=20
> Fix this by changing the loop to iterate from the current index i
> down to 0.
>=20
> Compile tested only. Issue found using code review.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

