Return-Path: <netdev+bounces-268815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOLuI7HjuWmnPAIAu9opvQ
	(envelope-from <netdev+bounces-268815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:28:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F282B457E
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0F923006F0E
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5491B3A4F44;
	Tue, 17 Mar 2026 23:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhoqusmG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3132937A4B5;
	Tue, 17 Mar 2026 23:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773790125; cv=none; b=FdzyKAkhhLOUlXgKp0ktaIOgsJxWfcpnFs6dIiX0H7MoDKjxgwvx/Nek6lWdYs0DNKSmLz3eIl49THeJGnAI2hUoGoUsCsQMJwBeX+zdzR8KDVzT69TJ2U0xQmsWBcnXefnvsL+yz+7731gWZsjcbUoEG6qW3IrX6oULUR0d7EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773790125; c=relaxed/simple;
	bh=4/1y+WO1qwqKOBj5sXjwb9OHDtScb9JLjDVrKP7JM7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YTTEXsARSotJ6yeYVOOEUwjJs1E5zyZAaJIHTKcI/MamNkeAKFq7RQ2+g19P7eaTeLplXitGqbqM6NuGavJl0Z41jsAqGu/hiX7VcxP8BzY6xb32Iqt8hW3+GsaqEsOrDYPVs+hG7plMo/5/a96ttemAPBUvWqG0JfLlhyE5F3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhoqusmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429AFC19425;
	Tue, 17 Mar 2026 23:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773790124;
	bh=4/1y+WO1qwqKOBj5sXjwb9OHDtScb9JLjDVrKP7JM7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NhoqusmG8/XNQFyYucJvXXUXf0DjW4fcxdMdfQEXlKWliZjfyQk6BTLY6hyKUnXL6
	 YyqWAp5q72+UbhNjFHih7vOEC+9TNSRIzXyATVwkrcVbAk7tTncMmucVb62yFwglHG
	 KNfA9Q8nQb343NWs1nH6Jz5uf175r65v1uck0jd9GJDlD44zbs90iaidIhM2KQ2C5s
	 z7UBKWLsk0c58Ou0u0qSRVcPixlpZOfa5cy+Y1gHoTTetJAZlXf/B2s8Atof1Hd0xW
	 z/50TRdL079U8kmgPWwUwzKQGBvPNww3zMWMPATJaEZ0sgoLa0ePs3Hi9pJ9zZAxIg
	 Xc25ukTldEniQ==
Date: Tue, 17 Mar 2026 16:28:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux
 <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, David Miller <davem@davemloft.net>, Mark Brown
 <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 driver-core@lists.linux.dev
Subject: Re: [PATCH net-next 1/2] regmap: mdio: make it depend on PHYLIB
Message-ID: <20260317162843.4cc4b57a@kernel.org>
In-Reply-To: <a21a3b3e-272e-4c61-986e-48a2cb3421d9@gmail.com>
References: <bc63cf87-3dba-4ab6-9c84-caa7357c3273@gmail.com>
	<a21a3b3e-272e-4c61-986e-48a2cb3421d9@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268815-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 26F282B457E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 15 Mar 2026 17:48:43 +0100 Heiner Kallweit wrote:
>  config REGMAP_MDIO
>  	tristate
> -	select MDIO_BUS
> +	depends on PHYLIB

The REGMAP_MDIO symbol seems to have no user in the first place?
I'd have expected any driver that practically needs it to select it.
What am I missing?

