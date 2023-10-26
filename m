Return-Path: <netdev+bounces-44460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778BD7D80CD
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 12:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13C88B212F2
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 10:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982C4199C6;
	Thu, 26 Oct 2023 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="X77LQv3G"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726592D785;
	Thu, 26 Oct 2023 10:34:34 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A100E189;
	Thu, 26 Oct 2023 03:34:32 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 48677240003;
	Thu, 26 Oct 2023 10:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1698316470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=saIm7FSEV+9kLXpsXf/xO5iBzgEMxE19KvzeCSsqazY=;
	b=X77LQv3Go3nA5Bbq5lYteVg7ScwDmhfzMEPUOgY6cZhPYCJd/LZ1bl71TY/jYYnansPYa/
	BN5L7iAhBDAQY8Q3obiVIufiM0ME3RbuHh6MmbZy3AP2R3YlUXyniyzFOq3voPFoFz1kA0
	vZ2eF0HXaxvaWySo1EdfFBXNcJmLvsXlBze3KiKn3H6klnlk8TC+AMDVKiOyb+7mNPEKlN
	CH/jsVd9alXKKJhyBhJVU0Y0fe3N1AkkLMRUlWuXTKCTrzXuH61lqV+wkOQmhcNf/rC3hs
	n+C/8LkwWQ7ZSPvuHU1pySOgu+4TyTGEjBGHSnHwUy3cLl0qU4SblU17XouHyA==
Message-ID: <e5b55d22-9e02-49ad-ba5f-2596f17be8ea@arinc9.com>
Date: Thu, 26 Oct 2023 13:34:05 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] dt-bindings: net: dsa: realtek: add reset
 controller
Content-Language: en-US
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 vivien.didelot@gmail.com, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzk+dt@kernel.org, devicetree@vger.kernel.org
References: <20231024205805.19314-1-luizluca@gmail.com>
 <20231024205805.19314-3-luizluca@gmail.com>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20231024205805.19314-3-luizluca@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

Nice work Luiz.

On 24.10.2023 23:58, Luiz Angelo Daros de Luca wrote:
> Realtek switches can now be reset using a reset controller.

The switch could always be reset using a reset controller. The fact that
the Linux driver lacked the ability to do so is irrelevant here. The
abilities or the features of the hardware had never changed. You should get
rid of the "now" above.

> 
> The 'reset-gpios' were never mandatory for the driver, although they
> are required for some devices if the switch reset was left asserted by
> a previous driver, such as the bootloader.

dt-bindings are for documenting hardware. The Linux driver details are
irrelevant here. Also, from what I read above, I deduce that for the switch
to be properly controlled in all possible states that it would be found in,
the switch must be reset.

So instead of above I'd say:

Resetting the switch is mandatory. Resetting the switch with reset-gpios is
not mandatory. Therefore require one of reset-gpios or resets and
reset-names.

For dt-bindings changes, I'd remove reset-gpios from else of
if:required:reg as you already do with this patch, and add below to the
root of the schema.

oneOf:
   - required:
     - reset-gpios
   - required:
     - resets
     - reset-names

And, like Vladimir said, this should be a separate patch.

Also, please put the dt-bindings patches first in the patch series order.

Arınç

