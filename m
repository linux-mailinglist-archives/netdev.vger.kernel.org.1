Return-Path: <netdev+bounces-246291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD13CE8A21
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 04:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 725C830124C1
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 03:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEC1239E80;
	Tue, 30 Dec 2025 03:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1szQ9Na"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C5429408;
	Tue, 30 Dec 2025 03:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767064674; cv=none; b=YydfjST+7iqxgimwafcWXyUzFhHLzn32DWIPOyWGWpJxPMMlVJI35hNTfIO0OI50+qrK37TSrG5konF2JyuIGOX/mvG7XAz3F+gSeNcDLBdGeiFEJku+IPrUnfpcYbvpCTGzq64xVHqjIPk3FrNiso1Ks92z2eS0WPpkpYhPT9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767064674; c=relaxed/simple;
	bh=lMVQ+KapLp/smzNEVl1Ob2owKXzPDHMOWDKikmE6PHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9b2AF1C+KZPoS2L+MczTK+W48sx7EEWLwj4L+Ki48m77Ox9KQcKOjI//IlMLk/fbOLt37nGR1UUCA031if7iWsaEMzhtdHEC8mb4L8IBqhX3digBxCCZJeH+q7Sku5fqiCq4fDCAxWn2Pm58qaGrvOujgSSaDJ6CB2kf0pMCTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1szQ9Na; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D46C4CEF7;
	Tue, 30 Dec 2025 03:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767064673;
	bh=lMVQ+KapLp/smzNEVl1Ob2owKXzPDHMOWDKikmE6PHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y1szQ9NaZZTVIVSErIYpQHEbiZCdoZBySVtoa7vJ8PsPbQOWI7DYiM8NsNqeUO613
	 pIwholDFd4HNGT8ebglR6AbtX0JI+ZGrtXT//1r9HnCgFPlFIobAHXhjwNCzARGQea
	 l8TlRLxF98yTD/hEJvGU0wD2db+NznyL9NYXlO8lcpKpADdqn8y0oZy2/zQ6A54Fz/
	 i6vYrEsq4dk6JAqzUAj8/GZBNzq2OoekDyJeCcYIw4DhWHbb7sMxDlqDlXFndnmSq8
	 CnlHPeXdmOz/3ww4JHqQgvYIcO1K4BbgaW0b9QtskeWi8yH1fWzYfjovQbSrBAVCzJ
	 9/14GDCLLawTA==
Date: Tue, 30 Dec 2025 11:17:48 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Martin Schmiedel <Martin.Schmiedel@tq-group.com>,
	Richard Cochran <richardcochran@gmail.com>, linux@ew.tq-group.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 0/8] TQMa8MPxL DT fixes
Message-ID: <aVNEXMxhkWMumfvG@dragon>
References: <20251209105318.977102-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209105318.977102-1-alexander.stein@ew.tq-group.com>

On Tue, Dec 09, 2025 at 11:53:06AM +0100, Alexander Stein wrote:
> Hi,
> 
> this seris includes small fixes for TQMa8MPxL both on MBa8MPxL and
> MBa8MP-RAS314. The ethernet IRQ type has been changed to level-low and CEC
> pad configuration has been fixed to use open-drain output.
> For both boards the HDMI audio output support has been added as well as
> the ENET event2 signal on MBa8MPxL, which can be enabled using
> /sys/class/ptp/ptp1/period.
> 
> Best regards,
> Alexander
> 
> Changes in v2:
> * Collected R-b
> * Fixed typos
> 
> Alexander Stein (8):
>   arm64: dts: tqma8mpql-mba8mpxl: Adjust copyright text format
>   arm64: dts: tqma8mpql-mba8mpxl: Fix Ethernet PHY IRQ support
>   arm64: dts: tqma8mpql-mba8mpxl: Fix HDMI CEC pad control settings
>   arm64: dts: tqma8mpql-mba8mpxl: Add HDMI audio output support
>   arm64: dts: tqma8mpql-mba8mpxl: Configure IEEE 1588 event out signal
>   arm64: dts: tqma8mpql-mba8mp-ras314: Fix Ethernet PHY IRQ support
>   arm64: dts: tqma8mpql-mba8mp-ras314: Fix HDMI CEC pad control settings
>   arm64: dts: tqma8mpql-mba8mp-ras314: Add HDMI audio output support

Applied all, thanks!

