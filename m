Return-Path: <netdev+bounces-255289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJzjHT9XfWn9RQIAu9opvQ
	(envelope-from <netdev+bounces-255289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:13:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5F6BFE8B
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 838E530131FB
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 01:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4A02E1722;
	Sat, 31 Jan 2026 01:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IId1qtpG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB58727AC48
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 01:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769822013; cv=none; b=X4oqYqo5kxDBL86WbHoMReRK6UNhJ1UTpG9o3s9QbltwjO1Ab7Tzs1fDYiT6Z205GmLtQGwasznQcfrnLEJjY77utOEFb3TIxXfQ3YsB6uW2XESy7oo+jPV4nfWHcT+W3IPZHf4rt09iUcDEm9e4JRm64TUTMVZSkqYG6ntdVwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769822013; c=relaxed/simple;
	bh=evgtStCu75itte8DFZOCQRwGzrdulcJ0CsxFLzCzYuY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BMnc8nQjAhn29Kv6llKDntkq3RwZ/h94BkBakjJhuwzCaYnNhNzVGsALwxlaoKylgzhjkUVeom74/lUNfmQZ1QCYElpWCcCSwu7VBDUBMRWv0mDMzm8u9L3Pku1kIR1uJbW1MxzaRm+h7ayV7c1iBbW3mLJETZ0umGvwD0hXO0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IId1qtpG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E022C4CEF7;
	Sat, 31 Jan 2026 01:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769822012;
	bh=evgtStCu75itte8DFZOCQRwGzrdulcJ0CsxFLzCzYuY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IId1qtpGfJn7lUn8mfTX7RHbRzYOksTBfxDGw8RHZzVV59hgsML5Eykkv+SztIIay
	 Kn1MWLOx7LSN+ax6GmnaTPuVCusOIjvrUiZz3w45YI9TRKju8J89xo4AszMfXgq9tD
	 b+5pFQu3DLnYJ+GhW3SxCbcpuEuMxmbXzh57ToTcqg5ZrCgT2macvFR89CN9DUdWmK
	 W9HHSjGsyfFa9p/YksjAEwRQ74wvTwUdCTERjPmM1a+uQnnvHqouX3BCOAeMDZ4yI+
	 E1ZwHsYgvESEs6wCfuTNYLlT80q+MGj5nYcL1EKtoJWA3NZKs7TZSmFkW+hYMgnmvo
	 9VWbkrnItSUyw==
Date: Fri, 30 Jan 2026 17:13:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>, Vikas Gupta
 <vikas.gupta@broadcom.com>, rajashekar.hudumula@broadcom.com,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next] bng_en: fix misleading error message for
 generic firmware version
Message-ID: <20260130171331.70172109@kernel.org>
In-Reply-To: <c19fdbaf-e179-4bbd-b51e-4de154233776@oracle.com>
References: <20260130073055.1609162-1-alok.a.tiwari@oracle.com>
	<CAHLZf_vxzcOpavJ-rNUsmi3XQ-NAqmWBvy2MRgGb2A3iWFHFHw@mail.gmail.com>
	<c102db6f-c676-4bb9-a1ee-3a43b35e6290@oracle.com>
	<CANXQDtbG9cXkzAPoDF9p5sLon=4aOrKJQvojgbieyhQ=+8mWuA@mail.gmail.com>
	<c19fdbaf-e179-4bbd-b51e-4de154233776@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255289-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DD5F6BFE8B
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 19:10:13 +0530 ALOK TIWARI wrote:
> >> ACK. will send v2. =20
> > Should this be a candidate for net with a Fixes tag? =20
>=20
> I am open to either approach. It does not break functionality, but the=20
> current message can be misleading so I am happy to tag it for net if you=
=20
> think it=E2=80=99s appropriate.

I think net-next is perfectly fine here

