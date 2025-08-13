Return-Path: <netdev+bounces-213517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39329B257A6
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 01:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28863B9327
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 23:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083434C81;
	Wed, 13 Aug 2025 23:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZ73VgqP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA622F60A8;
	Wed, 13 Aug 2025 23:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755128199; cv=none; b=Mg0SgeX1W8P94zJe8038oUZSrJrAtFyqwVe8QOk3yLqR578PwQIKonzb9ZEPn23SiOAwXpoKTJT1Hu04cYDWoEldwfn20c6ZmRLNFWiMfM5ovXz1cvTUUA8GOdZsgphAts/ABnxQDOWJYv10pI29wxqI4/drMXyuXBS3JfwASZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755128199; c=relaxed/simple;
	bh=iIlYZ2rFZRhKoq1MEczmfzDZ3sh8XaeMe0QhC+qV2yg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HiAonhymyeJUm6+z/H7um6V4h/83XNe2BXzCIPzCGp6R2z2zWr2TppOB/R8lmoqnclb26lu/d3rXujDwhp099hT+1MVS0BLKWmjt9YSjg4QPUDyRCb6rdXLjKSXLCmyk4ZVrxe5yU0W8ZMpee3PfvQE8WDTCvDYqUzMPqDhG82c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZ73VgqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F238EC4CEEB;
	Wed, 13 Aug 2025 23:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755128197;
	bh=iIlYZ2rFZRhKoq1MEczmfzDZ3sh8XaeMe0QhC+qV2yg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lZ73VgqPHBYXfJfl3GpSbhjQhFIatfnlyCPy4jchQyth3XBY5XgvVlEV23bjPtPAT
	 EehO51xJ5Byid398hSV78PEkiZnyM10mk8lBfo13aUZg4TNVmW+189/cOG1qx96udZ
	 Z9iPVzXjjLVz/3QLXYp6QRgG3ZNqACgXrdvJmw0jqCZ4aunG9pJNPwJQy29V94EFNY
	 L6SOSIJaN9j/DDzkBEvZhVuVt4fCSs0ZT4SYVy/R/Yc44AYstz0GpwnHXHVO1pmDxU
	 DzveLSKDltyZ+khOF5xxyfCF9a2eqwPS2eVFs5Y0QdKnYfaTCSBGo7VdPzhqDdaaWD
	 KylZbSoMhQqwQ==
Date: Wed, 13 Aug 2025 16:36:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: andrew@lunn.ch, o.rempel@pengutronix.de
Cc: Xu Yang <xu.yang_2@nxp.com>, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, max.schulze@online.de, khalasa@piap.pl,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2] net: usb: asix_devices: add phy_mask for ax88772
 mdio bus
Message-ID: <20250813163636.21b5a3f5@kernel.org>
In-Reply-To: <20250811092931.860333-1-xu.yang_2@nxp.com>
References: <20250811092931.860333-1-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Aug 2025 17:29:31 +0800 Xu Yang wrote:
> Without setting phy_mask for ax88772 mdio bus, current driver may create
> at most 32 mdio phy devices with phy address range from 0x00 ~ 0x1f.
> DLink DUB-E100 H/W Ver B1 is such a device. However, only one main phy
> device will bind to net phy driver. This is creating issue during system
> suspend/resume since phy_polling_mode() in phy_state_machine() will
> directly deference member of phydev->drv for non-main phy devices. Then
> NULL pointer dereference issue will occur. Due to only external phy or
> internal phy is necessary, add phy_mask for ax88772 mdio bus to workarnoud
> the issue.

Andrew, Oleksij, this looks like v2 of
https://lore.kernel.org/all/20250806082931.3289134-1-xu.yang_2@nxp.com/
are you willing to venture a Review tag here ? :)

