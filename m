Return-Path: <netdev+bounces-225073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9922B8E076
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 18:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFBD87AD2ED
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 16:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C344327A10D;
	Sun, 21 Sep 2025 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeZm+GLx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F27266B6F;
	Sun, 21 Sep 2025 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758473634; cv=none; b=HXrL1ycix07sRcMX4ibYLlEcnWqsfqWCVuEzOm3ryMl615g1oYFjC4MD0I39Of8ZVOHFSrPsPZSMqm/S4eXdLS9BVWQ625ATw9J48Zi7os5sySIhwwmkxdcFZz2z8JPZKy+HV9g19ap7H3Att04HSGGRy2rPkA3sGC/GLbDKdKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758473634; c=relaxed/simple;
	bh=GA6BCFTOq3NBFHY6q2lgyBET4FIS7eNAL7ai6/PmSoE=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=Dqw23sb0i+TGQEQYDwwhCM9O+4Axd/eCjp/XowlpviCA+rKQgzFekW4FoiRnFrP3rLlI0E6QIcDW+4A4gc67DIWsqpOhIL8i3OUGRxiL936RvC/rBLhJ/ACYgZpk0KYsNR2Sy4oSLYHTr3C/frIthLwgo+W9vjrobDPBdw5CW4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeZm+GLx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1FEC4CEE7;
	Sun, 21 Sep 2025 16:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758473634;
	bh=GA6BCFTOq3NBFHY6q2lgyBET4FIS7eNAL7ai6/PmSoE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=EeZm+GLxVHviyeka01Bsj2CCEeYvDXc07N0pUAD5Ce4fJDb4h4gxVw/VV8NZiBpt+
	 POTLqVL0YBPWSSYUEAiCZzbK0LiUWzSsZzW3kUWF+fLPRjGwpXB3NzQhbQ8Mo1smfB
	 kj0ikoXr+YPcTi4Q2QLsuCqUZU3mCncrI/c9Jmn3eLj1pRsKta4l00wqC3wNV9zHBF
	 dAFj23zUaKx4axLjQk6Rf6OCvg2xD/mVelxikLG+6WCn3vwiEtz34AORJDFFg8mEEL
	 Vqu4P1lQEZNlIZcvOmHaq7Tj2j/oeQopiuV58JWchDVGOms9PeWq7Ic7UDZ4pH6KnV
	 x988fSzi6iYhw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250915151947.277983-11-laura.nao@collabora.com>
References: <20250915151947.277983-1-laura.nao@collabora.com> <20250915151947.277983-11-laura.nao@collabora.com>
Subject: Re: [PATCH v6 10/27] clk: mediatek: Add MT8196 apmixedsys clock support
From: Stephen Boyd <sboyd@kernel.org>
Cc: guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, kernel@collabora.com, Laura Nao <laura.nao@collabora.com>, =?utf-8?q?N=C3=ADcolas?= F . R . A . Prado <nfraprado@collabora.com>
To: Laura Nao <laura.nao@collabora.com>, angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com, mturquette@baylibre.com, p.zabel@pengutronix.de, richardcochran@gmail.com, robh@kernel.org
Date: Sun, 21 Sep 2025 09:53:53 -0700
Message-ID: <175847363300.4354.16886488568604694955@lazor>
User-Agent: alot/0.11

Quoting Laura Nao (2025-09-15 08:19:30)
> Add support for the MT8196 apmixedsys clock controller, which provides
> PLLs generated from SoC 26m.
>=20
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---

Applied to clk-next

