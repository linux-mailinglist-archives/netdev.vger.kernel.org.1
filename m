Return-Path: <netdev+bounces-172785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD88AA55F43
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 05:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E601895210
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 04:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D8918E02A;
	Fri,  7 Mar 2025 04:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CL8qtgn4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F32249E5;
	Fri,  7 Mar 2025 04:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741320988; cv=none; b=rh4yFSmFY82VlB4cB+OHaWxtcQM0/phWXMljiKy/xm0Y8ZOqSM9OG2TFE23z+OsGdTYWqUi+0wCf6ANtg4BvMFlZ80pL+L52q4AasEaemgqG38SQdQeCeXrypH15bp+cgeNol+B6rQdhIaQ4nAqv8JlM84ydnwl2tz8Nitfaebw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741320988; c=relaxed/simple;
	bh=ajKfc7gigb87SKdIwwoyRysY03B56hMMZRp8G59YjxI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ntDnhxfhW2t/sIFdQCv4g67DFtT55lUEbra9pjYPDmSv3JhKeDjZ3QAT4UMqrolOP3ECm27TYZ7cU3DMHjJcUVW2kXXvEcHQAnAK6PwN5yHmWICfMM5HHKPN/nG0BCuo88tNqeMoLWNDuWfk+ywWX0knwjVvRIyBt5Cv4C//MA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CL8qtgn4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFD3C4CED1;
	Fri,  7 Mar 2025 04:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741320987;
	bh=ajKfc7gigb87SKdIwwoyRysY03B56hMMZRp8G59YjxI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=CL8qtgn4sJhzjtBviEMGu4ppipSMtJP1w4YUcCjeddS/TRxWje5+TJIy3dXVaUI6A
	 u5aFCJGR3DzAofl6XVgrJDurLXP0fkkO5TTHU8VlztHuKM3SnugeseRfiprGsKPt1F
	 eCHE+DV/OdEbO0DNd0r4S0wjHRkpL2+J66I0jkFNx35ap50y+r1uZTWtaVKHQCuMp/
	 q0K9I1KC1M0XV2CIWBY9Rx8yXkC18p9jUmC8GgN88p8mByq379KjmUD35A/7QVupeb
	 iLJ7UW5iJEAlTK3uebsBOKmYokopK1R3yHgo7M2n3WZJD/HSLz3aifEIMGKMQZ5oLT
	 0jFmn7DGsrUlg==
Date: Thu, 06 Mar 2025 22:16:26 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 linux-arm-kernel@lists.infradead.org, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 Richard Cochran <richardcochran@gmail.com>, linux-clk@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org
To: Guangjie Song <guangjie.song@mediatek.com>
In-Reply-To: <20250307032942.10447-7-guangjie.song@mediatek.com>
References: <20250307032942.10447-1-guangjie.song@mediatek.com>
 <20250307032942.10447-7-guangjie.song@mediatek.com>
Message-Id: <174132098632.2770289.10803747794522136743.robh@kernel.org>
Subject: Re: [PATCH 06/26] dt-bindings: clock: mediatek: Add new MT8196
 clock


On Fri, 07 Mar 2025 11:27:02 +0800, Guangjie Song wrote:
> Add the new binding documentation for system clock and functional clock
> on Mediatek MT8196.
> 
> Signed-off-by: Guangjie Song <guangjie.song@mediatek.com>
> ---
>  .../bindings/clock/mediatek,mt8196-clock.yaml |   66 +
>  .../clock/mediatek,mt8196-sys-clock.yaml      |   63 +
>  include/dt-bindings/clock/mt8196-clk.h        | 1503 +++++++++++++++++
>  3 files changed, 1632 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8196-clock.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8196-sys-clock.yaml
>  create mode 100644 include/dt-bindings/clock/mt8196-clk.h
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/mediatek,mt8196-sys-clock.example.dtb: clock-controller@10000800: reg: [[0, 268437504], [0, 4096]] is too long
	from schema $id: http://devicetree.org/schemas/mfd/syscon-common.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250307032942.10447-7-guangjie.song@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


