Return-Path: <netdev+bounces-102582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26125903CF3
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 15:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6704B25AD1
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 13:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7736A17B4F1;
	Tue, 11 Jun 2024 13:18:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C48417BB35;
	Tue, 11 Jun 2024 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718111886; cv=none; b=VotrqglXBNC6JdFA4CwBBiP8TE2TVAB2lJfSj/H5oqJo/HtVpnNb6vsU2mCgIYCGh6XnpT5rmhY2nPcyKh6q6oxqohn3gvDtmYvvEPJCVyyl8kO13qb6gingOFOG0IRWMXj0He6MvAAxE8KhMIKvGh05Zsh56PpwVEMD12L8kNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718111886; c=relaxed/simple;
	bh=wEAOcLBvfzE59CUuThF/RbfL0LF/IXsDpxRVgfmK2/s=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=IvVlG9TfBWv3qZh7U61OOWgD53J/0UkqT1KRJqxjvgXbZGsH986eBJFYrpcoRvoEe1Fdq4D2JPCjWsgrFCZ2XqUg3xzn6JE3nOnlxQ/yvkA33XCpuqwUFbPmi74xAY50BXPiUuS6n2djknn3UBAd/PhlwvI81lUpQeWA7zDOVfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9906f4c1d5=ms@dev.tdt.de>)
	id 1sH1Nx-002H6N-Dm; Tue, 11 Jun 2024 15:18:01 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sH1Nw-002pQ5-QC; Tue, 11 Jun 2024 15:18:00 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 69BF7240053;
	Tue, 11 Jun 2024 15:18:00 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id E7406240050;
	Tue, 11 Jun 2024 15:17:59 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 3D9B830F70;
	Tue, 11 Jun 2024 15:17:59 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Jun 2024 15:17:59 +0200
From: Martin Schiller <ms@dev.tdt.de>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: hauke@hauke-m.de, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, edumazet@google.com, andrew@lunn.ch,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, f.fainelli@gmail.com, devicetree@vger.kernel.org,
 olteanv@gmail.com, martin.blumenstingl@googlemail.com
Subject: Re: [PATCH net-next v4 01/13] dt-bindings: net: dsa: lantiq,gswip:
 convert to YAML schema
Organization: TDT AG
In-Reply-To: <171811031870.1486987.3222041734647742398.robh@kernel.org>
References: <20240611114027.3136405-1-ms@dev.tdt.de>
 <20240611114027.3136405-2-ms@dev.tdt.de>
 <171811031870.1486987.3222041734647742398.robh@kernel.org>
Message-ID: <74a190bff162feb209636748af14e5ce@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1718111881-C1C4D8CF-0E820EEB/0/0

On 2024-06-11 14:51, Rob Herring (Arm) wrote:
> On Tue, 11 Jun 2024 13:40:15 +0200, Martin Schiller wrote:
>> Convert the lantiq,gswip bindings to YAML format.
>> 
>> Also add this new file to the MAINTAINERS file.
>> 
>> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
>> ---
>>  .../bindings/net/dsa/lantiq,gswip.yaml        | 195 
>> ++++++++++++++++++
>>  .../bindings/net/dsa/lantiq-gswip.txt         | 146 -------------
>>  MAINTAINERS                                   |   1 +
>>  3 files changed, 196 insertions(+), 146 deletions(-)
>>  create mode 100644 
>> Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
>>  delete mode 100644 
>> Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt
>> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.example.dtb:
> switch@e108000: ports:port@6: 'phy-mode' is a required property
> 	from schema $id: 
> http://devicetree.org/schemas/net/dsa/lantiq,gswip.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.example.dtb:
> switch@e108000: ports:port@6: 'oneOf' conditional failed, one must be
> fixed:
> 	'fixed-link' is a required property
> 	'phy-handle' is a required property
> 	'managed' is a required property
> 	from schema $id: 
> http://devicetree.org/schemas/net/dsa/lantiq,gswip.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.example.dtb:
> switch@e108000: Unevaluated properties are not allowed ('dsa,member',
> 'ports' were unexpected)
> 	from schema $id: 
> http://devicetree.org/schemas/net/dsa/lantiq,gswip.yaml#
> 
> doc reference errors (make refcheckdocs):
> 
> See
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240611114027.3136405-2-ms@dev.tdt.de
> 
> The base for the series is generally the latest rc1. A different 
> dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. 
> Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up 
> checking
> your schema. However, it must be unset to test all examples with your 
> schema.

I have already run 'make dt_binding_check' and got no errors. However, I
then moved the components that are now being criticized to a separate
patch. These are exactly the properties that the original patch would
have added in the example.

I have currently put the conversion to the YAML schema in a separate
patch before adding these properties to preserve the original patch.

Should I combine both changes into one patch instead?

