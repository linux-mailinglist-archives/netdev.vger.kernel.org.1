Return-Path: <netdev+bounces-107125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C855B919F29
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 08:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8397228308F
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 06:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF54320B33;
	Thu, 27 Jun 2024 06:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqWnhYoz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA82D20323;
	Thu, 27 Jun 2024 06:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719469090; cv=none; b=iFD79cPjcTNagGbDjGyW5lHv5bipglDdXzaoSMqkDaU380J6n/uTvZ1eLZVuTTjWiAxo4xus1GbgIForTh7HjfGXFficcnA4PCScyc4UdFn/L/94kNbsbQdkROQvmy5Zu7+slJumCw5GYVisCrExLvnX6gz1xzMYiu/EHSqD6KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719469090; c=relaxed/simple;
	bh=MYFVjqg+EAkqvJ5mp4tbyCI2xi9AcHpRcZasjxXeeDo=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ROFb695fkpmg2an5NkkRvDpJQQEzpA3Wz95+2p5SPQRhDYu9bXvg2N9CBNWnhk+Zt89sPZnI+RhHiCtnN+vFka2U9mUg47/Y+O+b6O0JhfRTFqDDhaekex5QIuYCWPzX4ynNlR/1AA5qTkrTJXY1eYilSyDEeWmQiuVl19rB2+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqWnhYoz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE35C2BBFC;
	Thu, 27 Jun 2024 06:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719469090;
	bh=MYFVjqg+EAkqvJ5mp4tbyCI2xi9AcHpRcZasjxXeeDo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=aqWnhYoz9EuT9cHl1Gq/f5pcneBmS9IR36dP7zgDhjMUnsFCPgj1WWnEGBu4cM2Cw
	 GzXpqmi+PzNZxSEn2ipLLHoHEQW0NFF0kWDv0JPH3Dt1GAqFvlhMSjRNY3xXw53OvR
	 6UMMzspy3V2xEDboD8+/H5zk6J5Gk+Ospr2hqXblnLWzWWzh2MBOvmkAeExn4fBby6
	 z2xF9bM/5pBSof9dWxmlvdYhx2Fmd3V5jlbARWrmcRZ8aFIO9Jncw1BWtijj37xFkh
	 fMFowpCbAapVBeByXxR7O1I+TXr99IyZ2zBXQDx0uRkT7HIRk4lvzxFGel9W4Fx7OC
	 1IMHHUWAcnSvQ==
Date: Thu, 27 Jun 2024 00:18:08 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Conor Dooley <conor+dt@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 devicetree@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, linux-bluetooth@vger.kernel.org, 
 Marcel Holtmann <marcel@holtmann.org>, netdev@vger.kernel.org
In-Reply-To: <20240627054011.26621-1-zajec5@gmail.com>
References: <20240627054011.26621-1-zajec5@gmail.com>
Message-Id: <171946908894.1855961.17183583790942661835.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: net: bluetooth: convert MT7622 Bluetooth
 to the json-schema


On Thu, 27 Jun 2024 07:40:11 +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This helps validating DTS files.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../bluetooth/mediatek,mt7622-bluetooth.yaml  | 61 +++++++++++++++++++
>  .../bindings/net/mediatek-bluetooth.txt       | 36 -----------
>  2 files changed, 61 insertions(+), 36 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7622-bluetooth.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7622-bluetooth.example.dtb: serial@1100c000: reg: [[0, 285261824], [0, 4096]] is too long
	from schema $id: http://devicetree.org/schemas/serial/8250.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7622-bluetooth.example.dtb: serial@1100c000: Unevaluated properties are not allowed ('clock-names' was unexpected)
	from schema $id: http://devicetree.org/schemas/serial/8250.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240627054011.26621-1-zajec5@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


