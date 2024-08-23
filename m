Return-Path: <netdev+bounces-121414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B92395D008
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 16:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E28286781
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 14:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D435F191F60;
	Fri, 23 Aug 2024 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gB5/gceK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A140618892B;
	Fri, 23 Aug 2024 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724423133; cv=none; b=J5JmiNbRBOc0bYRlQ0QKr6YHs3o/FQ5sKWVcKE/Vds09R+wYiDzowvxanuujYcpNqkVw/pLVyjWl7lgX9zZTD6VeNmx9xpJBDJ4WPGf2w5wrku2IHA75DQR7YIOd5ZYAaOkC7csnwd35WJO8EMtrn1MWKwabTyUgTegiiuTTkEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724423133; c=relaxed/simple;
	bh=E6HhVC49fWMIbCrNdxjo9QdjxU/ksztYw7Z1Vc2pjb4=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=b9C3ipNvNNvwlT+WXhU+pHSksDpRhSOHXYFtNswTu3JselT2yzUdSCc4pp8jP/4JB7LncZmOFCa9WmFgZp4vKffBrMI4FpIIczVqWbe6BoOcQWp3Etlyp4cRCk8WSFCwgXk4iTcTAg/5KkumAK1LBqnywKkdDXBJt6FsCHzCE6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gB5/gceK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75EDC32786;
	Fri, 23 Aug 2024 14:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724423133;
	bh=E6HhVC49fWMIbCrNdxjo9QdjxU/ksztYw7Z1Vc2pjb4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=gB5/gceKTeiP7nMDM4TqTZO+1Ez6JQlQ08UcyjKutT6JKeYAanxt/c+rFtgXiI1TC
	 1y8pK1DH2AGrgMqY+d8+QprezKygf9ejPEfDWoVcBhtFOh8TmodTnZfqo/EkF6Gx7l
	 nMCGfqXdPEAfwQxBbtQuz4wnRw5O30/yjSZ7hG+QgcnLxMe3G421NP+ObNFs/2kTVU
	 15/Che5vrE3+/1MEZV54mys3V/BY1z0ZOjY6vPaItKHqyMf8XTVGrtLxi4aITfkfvQ
	 lgo2mZaH8GA4gnjUxNqiWrB+ieiAHqjbMelq4ILQOsnJISriOZ7UOYd2Mz4RqTaw5f
	 jiYOI3KhmdQlg==
Date: Fri, 23 Aug 2024 09:25:30 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: linux-kernel@vger.kernel.org, marcel@holtmann.org, edumazet@google.com, 
 neeraj.sanjaykale@nxp.com, davem@davemloft.net, netdev@vger.kernel.org, 
 conor+dt@kernel.org, devicetree@vger.kernel.org, 
 bsp-development.geo@leica-geosystems.com, linux-bluetooth@vger.kernel.org, 
 kuba@kernel.org, amitkumar.karwar@nxp.com, luiz.dentz@gmail.com, 
 krzk+dt@kernel.org, customers.leicageo@pengutronix.de, pabeni@redhat.com
In-Reply-To: <20240823124239.2263107-1-catalin.popescu@leica-geosystems.com>
References: <20240823124239.2263107-1-catalin.popescu@leica-geosystems.com>
Message-Id: <172442313089.1474016.13312263665925055519.robh@kernel.org>
Subject: Re: [PATCH next 1/2] dt-bindings: net: bluetooth: nxp: support
 multiple init baudrates


On Fri, 23 Aug 2024 14:42:38 +0200, Catalin Popescu wrote:
> Make "fw-init-baudrate" a list of baudrates in order to support chips
> using different baudrates assuming that we could not detect the
> supported baudrate otherwise.
> 
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
> ---
>  .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml  | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml: properties:fw-init-baudrate:maxItems: False schema does not allow 8
	hint: Scalar properties should not have array keywords
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240823124239.2263107-1-catalin.popescu@leica-geosystems.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


