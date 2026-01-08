Return-Path: <netdev+bounces-248201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8F0D057B2
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 19:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B00A33FA795
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 17:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA302E7F1E;
	Thu,  8 Jan 2026 17:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mu9cqZfw"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413CF2D63E5
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892876; cv=none; b=NFFywjZvV75lweZcnDI2fTqrnZso0KD/dKXA74CqOuvZHNeuMzN4MC8onLj3/nDgAVThf/FuxUDvL6J/4tLgy2m9CxAYyxZslME7kRcCJxHiXe50aKunLwjM1jSrTIwmMtFmpI4vnWWAZ2wrfGNj1Ju6wXBQOanFdd+RktsVkZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892876; c=relaxed/simple;
	bh=uyjFwIdbhFHz4Izmfeur0cx+bC7GM0FxaoBCnQ8rrXs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JuTxmLLr1Sn/hAoyxG/C/x/kqgnyKeqhuM+d8PDRVQK6TYh7tnEY5NeymiTCU1G2tYmFnzA1WSXAMZl9Y0u5QXIezwFc19iWbAtdnH/0zEZm6ptNYhGOh8OX/zKA6tuU7ada3uNeVnSfcpI72AYeZnBoI1t/qhwT509zNyHtc1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mu9cqZfw; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E5EDC1A270F;
	Thu,  8 Jan 2026 17:21:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B9D376072B;
	Thu,  8 Jan 2026 17:21:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 78C37103C882E;
	Thu,  8 Jan 2026 18:21:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767892871; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uyjFwIdbhFHz4Izmfeur0cx+bC7GM0FxaoBCnQ8rrXs=;
	b=mu9cqZfw85WvM+ReQ6JdeaMt5KU+eQcv2hTyEXMTutKzNj6tau8jOhcCcStNGjVOthniEC
	Fuq0zBffBLqarPRtbJsCCKeqC/GGvAvrQHOffrzqtmf0Qp9yCRnOmSW27f/7Z8fh0dWvCM
	VVh7ZYYFTmIXKMzmDkfGtuns5oouylQ0re3Uk1gvZzPCo6VEKpc4ohXC4zwMnmozBGhWHa
	e48JX3hr2Ejhq+E3ejGcXWNeH8ZUWzM/GXpvtNzjXNcwbJrwj+HQoztO32aKOnj5AVQJS/
	Sj+A8sCznteIxSXW33F0NfvYlazftHrVRCf//+ipMMfRA+ilrtQb1EZ+YmgjeQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Kathara Sasikumar <katharasasikumar007@gmail.com>
Cc: alex.aring@gmail.com,  stefan@datenfreihafen.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  horms@kernel.org,  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  shuah@kernel.org,
  skhan@linuxfoundation.org,
  syzbot+60a66d44892b66b56545@syzkaller.appspotmail.com
Subject: Re: [PATCH] mac802154: fix uninitialized security header fields
In-Reply-To: <20251214001338.1127132-2-katharasasikumar007@gmail.com> (Kathara
	Sasikumar's message of "Sun, 14 Dec 2025 00:13:39 +0000")
References: <20251214001338.1127132-2-katharasasikumar007@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 08 Jan 2026 18:21:07 +0100
Message-ID: <87o6n4xbp8.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 14/12/2025 at 00:13:39 GMT, Kathara Sasikumar <katharasasikumar007@gmail=
.com> wrote:

> KMSAN reported an uninitialized-value access in
> ieee802154_hdr_push_sechdr(). This happened because
> mac802154_set_header_security() allowed frames with cb->secen=3D1 but
> LLSEC disabled when secen_override=3D0, leaving parts of the security
> header uninitialized.
>
> Fix the validation so security-enabled frames are rejected whenever
> LLSEC is disabled, regardless of secen_override. Also clear the full
> header struct in the header creation functions to avoid partial
> initialization.
>
> Reported-by: syzbot+60a66d44892b66b56545@syzkaller.appspotmail.com
> Tested-by: syzbot+60a66d44892b66b56545@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D60a66d44892b66b56545
> Signed-off-by: Kathara Sasikumar <katharasasikumar007@gmail.com>
> ---

For what I understand... :-)

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

