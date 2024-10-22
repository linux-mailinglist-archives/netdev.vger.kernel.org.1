Return-Path: <netdev+bounces-137935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03BF9AB2DC
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 17:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3801C217C2
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 15:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2251D1B5829;
	Tue, 22 Oct 2024 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OrEH2eJo"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805DC1B5325;
	Tue, 22 Oct 2024 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612568; cv=none; b=T7l7dLJt3pdzeyfaquos1yeQZJzIHg4RFeYEFJYgLql260v6L0X/WT3HnPhd/lh0OtxcVuxYTznPnI8X/A7y6BVfHDprImefM0OK2L91+jb9cRc7piEY4twdYsW6PGnpJOxr0x2HYqJqHv+QApnby8t8VitqJkk4XQZBDCR1MGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612568; c=relaxed/simple;
	bh=0zMhEFYUlJtMFyxQdZN5BV4hydU/hnXmDWl8xY9n790=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnwYvLG/L9g6IQs/r8BOWubm929Rnj7iUZ2nCodLXWKkEkZczTjGFDBWsUE9Y5RNFrxNS+Bpqu2tdHCzaydJ83WRGVr1Yk1WgixcvMpFjbjefqJ6bVIi4Xi5Xu9WNXN0b9+9OCkQaFHKWoQ1K6y7JGT7OtPnTCNiOuBi8il8lbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OrEH2eJo; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4D9EE40008;
	Tue, 22 Oct 2024 15:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729612564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0zMhEFYUlJtMFyxQdZN5BV4hydU/hnXmDWl8xY9n790=;
	b=OrEH2eJocZc8osyxdc/7D8Dc6IsdqjX5pb0PytGovP172ZhAaJRb4XhTkUcdastaBq01YE
	G6oIk9TIFWpaDu5/LLIs9tkRlRSn20VQQm9NOXxiO3ny02Wgz50B+oHzU6vSomJ4T2Wh9H
	GJ2qV2XR8fhxxzn+9YYhIu9Abnw9lFH1IDDVQM73JZOHS8WSKbKVb+wKODCHynFXhIz2yT
	HqRR4tbTxmC3zZZC8EhlCn991ph+wzygxSeqqcKuvoBVkXw2/fvFG9lg7pb+LvbHta5oWQ
	BonaQ8cIoKRkXa1KO7hc9o+LPrvxPJhNc9BdDQ90e393SWXWYKfFR89N7ua+mA==
Date: Tue, 22 Oct 2024 17:56:02 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>
Subject: Re: [PATCH net-next] netlink: specs: Add missing phy-ntf command to
 ethtool spec
Message-ID: <20241022175602.32c246d5@device-21.home>
In-Reply-To: <20241022151418.875424-1-kory.maincent@bootlin.com>
References: <20241022151418.875424-1-kory.maincent@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello K=C3=B6ry,

On Tue, 22 Oct 2024 17:14:18 +0200
Kory Maincent <kory.maincent@bootlin.com> wrote:

> ETHTOOL_MSG_PHY_NTF description is missing in the ethtool netlink spec.
> Add it to the spec.
>=20
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Nice catch, sorry about that.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

