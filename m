Return-Path: <netdev+bounces-144449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485999C760A
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 16:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DDEC28248B
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 15:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22128158D93;
	Wed, 13 Nov 2024 15:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V9Gx51Pd"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B973A158A2E
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731510968; cv=none; b=QZ5CGX+iTJ0ewx3ukU/7kAvBd8Ti6DfrYdh47goTrqtIyd2SvmPXlTcPUV32omf891hxzpKIc19uudBR9ZzXS/7x53BIYwpdXMWry+1bpv5Ymo9PDBZ3atNLDxCpH4yC5x4Iw+y5zxZi80vJ82Zt0isgAl8KWnJPBoX6e4jYa/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731510968; c=relaxed/simple;
	bh=1zoS8rDp5x/H924HIa6uR4Khr2qMXmzRoI9O7XGyd2A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8KKf8qFj7UrpLBXT9qHgt2FgVW7fni0fVZ49cKANnVcQxqagRLbymJSfa+2kWjjrH1Sk+pGw9lA7rC5u55dMUEPRBefkFSbgWiu8rcSDC584ZUXU0EQxwiHZYe37XGegOnugoEaaI5huNCLAGW5eTHIc8rqk3ZsUkp9a1I/IyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V9Gx51Pd; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A7D99E000B;
	Wed, 13 Nov 2024 15:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731510963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1zoS8rDp5x/H924HIa6uR4Khr2qMXmzRoI9O7XGyd2A=;
	b=V9Gx51PdYcAS1GkT8U+2dlq4tJO2sjR9rSexzCOOuwxnXltRbnozX7BuDHeCHE7EFxK6QL
	pA11QWQYGhvUaWXutV4as49N2iVAQ2H9+YjMWrUD5DkAoX4kcO6SunW/5+ETr+SdXmqhIG
	2jwiNC1J5qRtVuPi20O3tixfyUjeTt5qn2UgFfPCpCONDjChE9DL8PQxll/BHgz+Dh9eRi
	N/BxoXYG5BW+tSpoV3vjRTXOVbe4jTik5bs3MsIwMlVTfilfsFvsWRuSpO4esJekhZ1B9t
	BtSUtEFSsqrvNxaCYoiZG3ZC6pzt3jKbaKnwiT2ytes0JcHY6R7LfVqR+RvZzw==
Date: Wed, 13 Nov 2024 16:16:02 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: Testing selectable timestamping - where are the tools for this
 feature?
Message-ID: <20241113161602.2d36080c@kmaincent-XPS-13-7390>
In-Reply-To: <ZzS7wWx4lREiOgL3@shell.armlinux.org.uk>
References: <ZzS7wWx4lREiOgL3@shell.armlinux.org.uk>
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

Hello Russell,

On Wed, 13 Nov 2024 14:46:25 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> Hi Kory,
>=20
> I've finally found some cycles (and time when I'm next to the platform)
> to test the selectable timestamping feature. However, I'm struggling to
> get it to work.
>=20
> In your email
> https://lore.kernel.org/20240709-feature_ptp_netnext-v17-0-b5317f50df2a@b=
ootlin.com/
> you state that "You can test it with the ethtool source on branch
> feature_ptp of: https://github.com/kmaincent/ethtool". I cloned this
> repository, checked out the feature_ptp branch, and while building
> I get the following warnings:
>=20
> My conclusion is... your ethtool sources for testing this feature are
> broken, or this is no longer the place to test this feature.

Yeah, it was for v3 of the patch series. It didn't follow up to v19, I am u=
sing
ynl tool which is the easiest way to test it.
As there were a lot of changes along the way, updating ethtool every time w=
as
not a good idea.

Use ynl tool. Commands are described in the last patch of the series:
https://lore.kernel.org/all/20241030-feature_ptp_netnext-v19-10-94f8aadc9d5=
c@bootlin.com/

You simply need to install python python-yaml and maybe others python
subpackages.
Copy the tool "tools/net/ynl" and the specs "Documentation/netlink/" on the
board.

Then run the ynl commands.

> Presumably there _is_ something somewhere that allows one to exercise
> this new code that Jakub merged on July 15th (commit 30b356005048)?

You can indeed test this merge with mainline ethtool.
Specially the commit 2dd356005901 which changes the default hwtstamp to MAC=
 for
newly supported PHY PTP as you requested.
With your marvell PTP support patch it should still report and use ts info =
from
the MAC.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

