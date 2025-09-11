Return-Path: <netdev+bounces-222332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE5DB53DCE
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 23:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89CC1707D5
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 21:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492A72D6E71;
	Thu, 11 Sep 2025 21:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RWhRMWv9"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE12D21D5BC
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 21:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626678; cv=none; b=JfqQt7nYvbrv/RagJvKHcHhFA7Bfld3eYoGzTpMrKW61jpgdlnksHdt9G+4qa2QshUBDxzsLzeIyvcg5QFF7dWX1JN2rfmVn0CGa2uNSpbWL6BvKu0ozw87g7exWbGEaoWTjm8rgxjhI3ZHmg88KumDf4SWVj9X5GU9RoWcgrWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626678; c=relaxed/simple;
	bh=zEmFhb4Me/YUyv8svtXalnalPUQva/4LhKbVMJkxUQM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UpkgdTyHmw7PnShgYmaO+hwe4DAARb45NCNXy67wkePMxnjCC5/T9OSc8wT12BJaffyUsnNs8ksHCvGBe1V0WJXhJ+fHciD8Fz3aDhxxhX6HfMQi/XmW7CJuevibUWdgHBeCgDuqxyFgCl26IbmG2e+9y6sl/dJaPY/XDlQSg6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RWhRMWv9; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C87B31A0DF1;
	Thu, 11 Sep 2025 21:37:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 98E2560638;
	Thu, 11 Sep 2025 21:37:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EC361102F29A4;
	Thu, 11 Sep 2025 23:37:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757626670; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zEmFhb4Me/YUyv8svtXalnalPUQva/4LhKbVMJkxUQM=;
	b=RWhRMWv91RPZx2AnmtCxzIC+/3ZcyBvW0JulkFCGJsDRrE/A5juUHkQO8jjDFOYQDkw22l
	NBSc5Tn0Wsju7NDwwuPjZ+zzETGsnWua0EnCtOi8tSZ66lXKBWbgzG/BLqPOAABORHkpsE
	6YqqLnCN7U02fDi2oEDLhv42ZoPr59Yiz8VpbPWC8+hgIy/mMGaVxm8rj8ku7P3V12MfQG
	SbKOsu4b7EBOuboCWhCLseHmcjQjrZ3ZYVi5f3uR+JcZi/J+CqlYcwGVMXj1zZXCYRlLyA
	YVV4/CHnDuaf6zgbF21O9vBmwzXdFnocsCxVmJVweEvcU0L9oQgU+x+894eLGQ==
Date: Thu, 11 Sep 2025 23:37:33 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net] net: ethtool: handle EOPNOTSUPP from ethtool
 get_ts_info() method
Message-ID: <20250911233733.41248f64@kmaincent-XPS-13-7390>
In-Reply-To: <E1uwiW3-00000004jRF-3CnC@rmk-PC.armlinux.org.uk>
References: <E1uwiW3-00000004jRF-3CnC@rmk-PC.armlinux.org.uk>
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

On Thu, 11 Sep 2025 15:43:15 +0100
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> Network drivers sometimes return -EOPNOTSUPP from their get_ts_info()
> method, and this should not cause the reporting of PHY timestamping
> information to be prohibited. Handle this error code, and also
> arrange for ethtool_net_get_ts_info_by_phc() to return -EOPNOTSUPP
> when the method is not implemented.
>=20
> This allows e.g. PHYs connected to DSA switches which support
> timestamping to report their timestamping capabilities.

You forgot the v2 in the subject prefix.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

