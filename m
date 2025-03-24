Return-Path: <netdev+bounces-177086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E007A6DCD4
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 15:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8D2188B4D8
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 14:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D915D2627F2;
	Mon, 24 Mar 2025 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHX6jwgm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF40425FA22;
	Mon, 24 Mar 2025 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826083; cv=none; b=fnK6bJucHf5C0IgIbUM0sOxrtjU2B9Y00+E6yywvUwZHOUyqKum/kvfs2Cn5BYMFiQ025haXgE7YUXnW5deoEQ8ivY0ERAWJgr/ZWiIQjbqnx/OCQx49DmnXsumdracWtBi/c2j/vqSLK+fGwJjHJbkQ1jOEZwhtStaMxkg07rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826083; c=relaxed/simple;
	bh=2gwvYreVDT8Y627DcuFPV+DCncDkxW/x6CETOG01N7I=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=X7ia2ENnty52s/cUmSYpI5Ss97AVJrH1eNd5G1b7zDee4H+zdo3Gk6c2wt3qXQQ+rlVHNNh+kyj00igeAAUQngOsP43Gvx5JGXMoR9VYBqIroSZWTtMJnmFaJD6nTkcGBlM6AZJqYiS0Gl+NE6ilY8qpQSgh8T9YXojfjwQWEK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHX6jwgm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD198C4CEDD;
	Mon, 24 Mar 2025 14:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742826083;
	bh=2gwvYreVDT8Y627DcuFPV+DCncDkxW/x6CETOG01N7I=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=qHX6jwgm8E6h2HP2t3CTTzi7hYl5PmKBjoT6O1v5gpSAVFPQjAMsFRDlp1/tuZQcL
	 2jixSs5z1CEMoJOO8SCwXPXohgieVml12uTziedYE4DqZk8/Tbait0lWlebahVBaYo
	 f1DmjPeVxtbxpw/m+CLd+mgYSq+P4moJ0sr7StyL53jC47K3Yv8j7jxqm2BVAeLZsZ
	 V38YLJYXuZsmagE9DaM/6G3W95Av+SDOfs3ToYaDgfRYIO8bzdM4CAYTWxIlOQ+cdm
	 wodYw/XHauqSPkRjf0jOTBxuKhtJnW4zuyZzLecBGq1d1QkyKwrewcqrEirrcVMmfz
	 /re/0niX62cLQ==
Date: Mon, 24 Mar 2025 09:21:21 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Colin Foster <colin.foster@in-advantage.com>, netdev@vger.kernel.org, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Felix Blix Everberg <felix.blix@prevas.dk>, devicetree@vger.kernel.org
To: Rasmus Villemoes <ravi@prevas.dk>
In-Reply-To: <20250324085506.55916-3-ravi@prevas.dk>
References: <20250324085506.55916-1-ravi@prevas.dk>
 <20250324085506.55916-3-ravi@prevas.dk>
Message-Id: <174282607911.6262.15261935260960976141.robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: net: mscc,vsc7514-switch: allow
 specifying 'phys' for switch ports


On Mon, 24 Mar 2025 09:55:06 +0100, Rasmus Villemoes wrote:
> Ports that use SGMII / QSGMII to interface to external phys (or as
> fixed-link to a cpu mac) need to configure the internal SerDes
> interface appropriately. Allow an optional 'phys' property to describe
> those relationships.
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>  .../devicetree/bindings/net/mscc,vsc7514-switch.yaml      | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/mscc,vsc7514-switch.yaml:40:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mscc,vsc7514-switch.yaml: ignoring, error parsing file
./Documentation/devicetree/bindings/net/mscc,vsc7514-switch.yaml:40:1: found a tab character that violates indentation
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mscc,ocelot.yaml:
while scanning a plain scalar
  in "<unicode string>", line 39, column 21
found a tab character that violates indentation
  in "<unicode string>", line 40, column 1
make[2]: *** Deleting file 'Documentation/devicetree/bindings/net/mscc,vsc7514-switch.example.dts'
Documentation/devicetree/bindings/net/mscc,vsc7514-switch.yaml:40:1: found a tab character that violates indentation
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/net/mscc,vsc7514-switch.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1522: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250324085506.55916-3-ravi@prevas.dk

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


