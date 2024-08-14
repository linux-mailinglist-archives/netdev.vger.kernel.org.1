Return-Path: <netdev+bounces-118400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 248DA951794
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 11:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3301F2302D
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 09:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F02B1448E1;
	Wed, 14 Aug 2024 09:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TzlQTn8S"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F01143C5F;
	Wed, 14 Aug 2024 09:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723627433; cv=none; b=iaPOyOMYF593fMBRFf9q98lQxmOj3dROumpxBs2VtqkuOWJ72cgvbJ6RiDSG/wXzaZ7biaFko8VSW7h1/gfjkS+eP/HjYK32aYQrULJm/YPavE3ySciw7GC5d5KZ6678h8FsekuG9mMU7xu0446ZCe3tWEB8j3sMvZ4kYaXZUd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723627433; c=relaxed/simple;
	bh=dEbKJFG3WPXd88H9BTqxRDkKVw1cAbH1pxJ6tF4O/Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lLWLPRGC8xCGXP75ExrQb3H9lCHuAelVBPM0oV/ZgGHtGBNiZ3HzYvVZ62zRm7lzEmfB7GEkuwDwtNJN7+dHGb2op934Rt0SxaFiBX38hqItpcMwuozdjhGsJAMbk7vdlQSx0jkhwRerr2VN889o8338tdUs+4eyeYLGz+obHxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TzlQTn8S; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 07369240005;
	Wed, 14 Aug 2024 09:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723627429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dEbKJFG3WPXd88H9BTqxRDkKVw1cAbH1pxJ6tF4O/Ts=;
	b=TzlQTn8SwZYOe/SFAoucK/Zq9vZWMEDHcLF7fqqEw/4xstcrwCZOXJlq3lhjfJW2KrIXTG
	bNN6rhuWtLffQ0EbDVvPPf69ZTXx0MvQWg8BPmmadeLuRv6tF+z/hfu2C7YG2BCSqu+NWp
	xUQouFx5OJogtjKbBiAQzkKk9ooJ3yksSdytKVEprukv1FT49fJ70gJq9TllOuAPDXZ5ik
	qf8VkZ4uW41np4xwL9pHFlJyGgvBvEhQDda6WY3xE8uD7xZMjSpTdSCYQkN7SHYu3em2TL
	rJjH9ZSnfp2Lrs26ZjGmoIcivpMDclv6lyuPSPK+zGZMQiP5cQfKogbbelYuvQ==
Date: Wed, 14 Aug 2024 11:23:46 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v1] pse-core: Conditionally set current limit during
 PI regulator registration
Message-ID: <20240814112346.6160b93b@kmaincent-XPS-13-7390>
In-Reply-To: <20240813073719.2304633-1-o.rempel@pengutronix.de>
References: <20240813073719.2304633-1-o.rempel@pengutronix.de>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 13 Aug 2024 09:37:19 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Fix an issue where `devm_regulator_register()` would fail for PSE
> controllers that do not support current limit control, such as simple
> GPIO-based controllers like the podl-pse-regulator. The
> `REGULATOR_CHANGE_CURRENT` flag and `max_uA` constraint are now
> conditionally set only if the `pi_set_current_limit` operation is
> supported. This change prevents the regulator registration routine from
> attempting to call `pse_pi_set_current_limit()`, which would return
> `-EOPNOTSUPP` and cause the registration to fail.

Thanks for the fix!

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

