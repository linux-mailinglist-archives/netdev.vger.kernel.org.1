Return-Path: <netdev+bounces-110877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D91B892EB61
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 17:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829DD1F22777
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 15:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76CF16131A;
	Thu, 11 Jul 2024 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shikadi.net header.i=@shikadi.net header.b="EJ3qPWYR"
X-Original-To: netdev@vger.kernel.org
Received: from sphereful.sorra.shikadi.net (sphereful.sorra.shikadi.net [52.63.116.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131CC5477A
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.63.116.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720710870; cv=none; b=kA1FKHNhOoyraQzPc3LFaadrxv+FUQwtpA3Xe5Y1nOuIWC6Y+NwbxVMRku7rt7srmuNtGogfTN0grFEuyVlJ0W2UiKOEuOc+yLlmL/qlFceuo3iNo5U1oFZ59bchA4vIKXz8ZXGuTC+6rXsYhoaKTBmlvsCXJQlkR2TDw9525EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720710870; c=relaxed/simple;
	bh=QKwNK6AWOmEZD89Ob4PmfdQbjEECKKXNZdy1J8BBN5k=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=KKo+wpQp5DVZ3ExwK4gd7pb/cEdHEcy7b2qN9poEUbV8U1kuzzHcotrpnrdBeLetBgJe3z5ERGEVijdaeFf9rcOJ9y689blrFd0y2HdRFy6GXqsTy2pAdQpSiSZ0evZBTTysOjgKULFNz+fFiY7rnrJHuqC/9IvCrYwab6sPCJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=shikadi.net; spf=pass smtp.mailfrom=shikadi.net; dkim=pass (2048-bit key) header.d=shikadi.net header.i=@shikadi.net header.b=EJ3qPWYR; arc=none smtp.client-ip=52.63.116.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=shikadi.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shikadi.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=shikadi.net
	; s=since20200425; h=MIME-Version:Message-ID:Subject:To:From:Date:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
	bh=/edu9ZJIPs7ePknyoB+Ox5/oSqx8UhTEX5Y8ysWETRM=; b=EJ3qPWYRrWzU9gSMPaQ/NwWtrV
	JlV80Gw8KHMv3IJYAjjAh6PEc1C4wVMyouG6oM/y4tOZuF6y87Gpc14tVeAw/JzYeq/Z+e7aApVWF
	orTfvfb25evJbizFtyylBs8TKwC2PMJVghGNKMvGTeJ6l2lcvFKFFmmah67/CP9fE9bSCrU81eHsM
	Whll1+Lbhx/W0Y+iza1sOh63+EpQ1M+FhgnqTpjKKYl+WJbSjGpcZBmIiYXtCNRG4d49AM09LMRDN
	zk+a1TipIcq+Kw1NJadX3KHH5wiEpmyP3rRSnMhpfikFuP/fKqGnqdcvpwwylbjtk3T8nV16qGHuY
	o58J1kfw==;
Received: by sphereful.sorra.shikadi.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <a.nielsen@shikadi.net>)
	id 1sRvAF-0004uT-3M
	for netdev@vger.kernel.org; Fri, 12 Jul 2024 00:52:55 +1000
Date: Fri, 12 Jul 2024 00:52:52 +1000
From: Adam Nielsen <a.nielsen@shikadi.net>
To: netdev@vger.kernel.org
Subject: Is the manpage wrong for "ip address delete"?
Message-ID: <20240712005252.5408c0a9@gnosticus.teln.shikadi.net>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi all,

I'm trying to remove an IP address from an interface, without having to
specify it, but the behaviour doesn't seem to match the manpage.

In the manpage for ip-address it states:

    ip address delete - delete protocol address
       Arguments: coincide with the arguments of ip addr add.  The
       device name is a required  argument. The rest are optional.  If no
       arguments are given, the first address is deleted.

I can't work out how to trigger the "if no arguments are given" part:

  $ ip address delete dev eth0
  RTNETLINK answers: Operation not supported

  $ ip address delete "" dev eth0
  Error: any valid prefix is expected rather than "".

  $ ip address dev eth0 delete
  Command "dev" is unknown, try "ip address help".

In the end I worked out that "ip address flush dev eth0" did what I
wanted, but I'm just wondering whether the manpage needs to be updated
to reflect the current behaviour?

Cheers,
Adam.

(Not subscribed, please CC)

