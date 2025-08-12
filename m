Return-Path: <netdev+bounces-212974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFC6B22B51
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33AEF3B19A4
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 14:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FE82ED14B;
	Tue, 12 Aug 2025 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrV0Yt59"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6BF2ED141;
	Tue, 12 Aug 2025 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755010512; cv=none; b=c8jm+pSkY1nSQ0h/sywLHPKq9LHvaR71+WtZe5af5Q/6xzq5w4IJk534FehgXsoUsXZY9wE5FHeP2y9APzVqZync2ANuRZMgDAF74BcurqcY1YWIahjeH7YGAI3YEPuqeJ7zCvXzgHRLHaE1jB91zzl11Y/94k/TCpDhxlQL5L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755010512; c=relaxed/simple;
	bh=6bXEH3zDHpVqiB/3btu3Zm/oXUw7kpix8CdE6tp4Igk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=W9GdCs0Jj1hRE837Tf0Ej2vHsajLeOlyLliCMFVq+Z1qrICZ7mzIbmNZ96w3WtC7J3p9Y9+emCQlnPOlD6IAQOojjjtebIRb5+Cp62IJrkuhdDFXDUd7Fu93B9g1mPHD+xui9I1g4rlnlBO/H5bzRfJUBOqCzIq/kAUnZLvo+bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrV0Yt59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB27EC4CEF0;
	Tue, 12 Aug 2025 14:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755010512;
	bh=6bXEH3zDHpVqiB/3btu3Zm/oXUw7kpix8CdE6tp4Igk=;
	h=Date:From:To:Cc:Subject:From;
	b=HrV0Yt59I6JN9dxvDqiZ7e48QQDCeJ+5uh0CsP7nYxhzAIY1CAl2yso/jRsu28ALg
	 aCdfs65eJqSOWbTiQUZTdoq0pXtpHYv2hmXjZe3piA7xf0FB1KQGwEcAFMMmtrgsQd
	 /T/B40zH7Qrq+KWwluoMN2aojMZnH9vCx5e5y1NKhjjwsD5fvz6MfjRLl43Lj8dDqH
	 HGd5hdqktFZyzlQmgo6ks3i/zYCNu26hbEv51VQhzgsNnSjUGJ++BRqCcTLDjGY2du
	 WGwv4cyeeZGP/31bbFOE0+FJ6dXHaTWq8f9+ttGJLTRsy1zh3r2im5eiBv1K1KC+xl
	 IvBf/zetWjrQw==
Date: Tue, 12 Aug 2025 07:55:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-driver-reviewers@vger.kernel.org, netdev@vger.kernel.org, Sean
 Anderson <sean.anderson@linux.dev>, Daniel Golle <daniel@makrotopia.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Russell King
 <linux@armlinux.org.uk>, Christian Marangi <ansuelsmth@gmail.com>
Subject: [ANN] netdev call - Aug 12th
Message-ID: <20250812075510.3eacb700@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join

Sorry for the late announcement, I got out of the habit of sending
these. Luckily Daniel pinged.

Daniel do you think it still makes sense to talk about the PCS driver,
or did folks assume the that call is not happning?

