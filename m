Return-Path: <netdev+bounces-185034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86397A9848D
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 11:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20F618847BB
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 09:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69761DD539;
	Wed, 23 Apr 2025 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b="IbWWLfS/"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C2642A8B;
	Wed, 23 Apr 2025 09:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745398880; cv=pass; b=sYSffnKpsuCQh4qHZvRuK6BeoHGcgyCfb+mbiTXpnJFzaTdSlahMiw3DOTKAKTtXeQ0B0rfcQP71tH01d/qC/+bdL4sM2baP+MQhXfN0COvqG209XDptHMysFQHAqARd0TqlNkJWZ6acBV8p7KyD041u4A9ygDzAhsmm2c2yLFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745398880; c=relaxed/simple;
	bh=WEFboc1GBdXAA9WvCS/gR1Bseal3a2X9Ch7YA1eEJ9c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LYmEiJgnuc8Kp7Uvt3kezHYNj4AdbPA8zDxw9owOzLm2f2rrDUu0V1aY4b6YHkXdlMgyQePve7hJr/RYzPNYJFlsYsXh6xLeRkMZIQ7ndSxna/dMdaqvq0YTdbwP/vWr6X9TxWw+E+h0UusDdS6cofD4D3wPJtPYq//JhDXykLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b=IbWWLfS/; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1745398840; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lJgtMKWq6xOI2o+ZGlMrwdS+6YwQAEaoTr+OpCcs3SsgWhfkFSoYGo4WfwVmOP7yrxOzt3bzhqVzTiSvjWZEQRefHWqFyNnRek0HNZVH//8pR0I5F0dKJU8CDfFfxxyQMle4xPSdfvr2rKqiyIReDVtLg1O5gaM/9fND2U7PSr0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745398840; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WEFboc1GBdXAA9WvCS/gR1Bseal3a2X9Ch7YA1eEJ9c=; 
	b=fDxNID6hxMeFZwbYw3XmYCdjCo4XiAwqJNnJMuQF0BRMfLX1PZI+/lcavXFF6SPEq0CG4B99bL4K+vkvs1m3yO3hh9uoVjrofBimXuV8t7E6pBctA7sMnVmYxYMxhOHmtkdVaq2o5OsX6oAGLeIJ/asJ74NbS+6kfabC4GBzsBU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745398840;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=WEFboc1GBdXAA9WvCS/gR1Bseal3a2X9Ch7YA1eEJ9c=;
	b=IbWWLfS/sg+vpsYTKWwUVP7NyM1PPY3FDC8FI4iQNoi6cdadB7tvM6bL0iAxRJ10
	2NmHHH13frKbxF9EsCc8sSbTBg+/BDwM1KtWkaVsAzIZPF7nwQ3LwWyitf1YJjrxzwV
	0XsOMq5q1G568jkdPRLpg+w8j9k5wneSYVCjY194=
Received: by mx.zohomail.com with SMTPS id 1745398837671692.7273249531318;
	Wed, 23 Apr 2025 02:00:37 -0700 (PDT)
Message-ID: <ce7a0b320ed41ebe76e9908ab3eac3780fc56764.camel@collabora.com>
Subject: Re: [PATCH 2/2] net: ethernet: mtk-star-emac: rearm interrupts in
 rx_poll only when advised
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>,  Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,  Biao
 Huang <biao.huang@mediatek.com>, Yinghua Pan <ot_yinghua.pan@mediatek.com>,
 kernel@collabora.com, 	netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Date: Wed, 23 Apr 2025 11:00:31 +0200
In-Reply-To: <20250422160716.71a16b1a@fedora.home>
References: 
	<20250422-mtk_star_emac-fix-spinlock-recursion-issue-v1-0-1e94ea430360@collabora.com>
		<20250422-mtk_star_emac-fix-spinlock-recursion-issue-v1-2-1e94ea430360@collabora.com>
	 <20250422160716.71a16b1a@fedora.home>
Organization: Collabora Ltd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

Hi Maxime,

On Tue, 2025-04-22 at 16:07 +0200, Maxime Chevallier wrote:
> Hi Louis-Alexis,
>=20
> On Tue, 22 Apr 2025 15:03:39 +0200
> Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com> wrote:
>=20
> > In mtk_star_rx_poll function, on event processing completion, the
> > mtk_star_emac driver calls napi_complete_done but ignores its
> > return
> > code and enable RX DMA interrupts inconditionally. This return code
> > gives the info if a device should avoid rearming its interrupts or
> > not,
> > so fix this behaviour by taking it into account.
> >=20
> > Signed-off-by: Louis-Alexis Eyraud
> > <louisalexis.eyraud@collabora.com>
>=20
> Patch looks correct, however is it fixing a problematic behaviour
> you've seen ? I'm asking because it lacks a Fixes: tag, as well as
> targetting one of the net/net-next trees :)
>=20
I found the issue by code reading and checking if the sequence is
correct with my other fix.=C2=A0
It seemed the right way to do in comparison to mtk_star_tx_poll
function that does check napi_complete return code before rearming
interrupts.

Regarding the Fixes tag and subject prefix, I'll also add those in the
v2.

> Thanks,
>=20
> Maxime
>=20
Regards,

Louis-Alexis

