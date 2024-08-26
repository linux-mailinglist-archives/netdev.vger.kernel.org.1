Return-Path: <netdev+bounces-121781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8693095E81A
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 07:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4112C281549
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 05:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11A1770E5;
	Mon, 26 Aug 2024 05:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJ6qKLYL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D94443D;
	Mon, 26 Aug 2024 05:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724651448; cv=none; b=KzY8+ls4vote/M3kJ6l1nETj/+qdj7UO+nD+JjhT9HDYdo55mV3nfA1FYN2/RqLEhr9WkvncspLbstAK0Abm6Tisy6MtX9SFulGDqQcEjoc+CDDqdy21NtpmWLgfJ522Z/qbgcNphZxNxWILPd+uU43fZSKC1h1Bivwk6mw2/6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724651448; c=relaxed/simple;
	bh=aLzgLgLWLVzf1iRXKVptENNKfdzYPHBNK3OzoTkhSI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLmCoxM4HZ8tyaqtYbXjcap3i0vPgdEfUShjBUg/Yxesn8Uq4BnUBBePQtfw9MCDk9xmG83O14KDtXGePGLIcDifOfO9bcg6qpvN6/exupHknlqU68SzpS0s9ADIbAsOxrEBLzGBwChqayL5MebYBc0/9phyy+YzVZc7NohBqhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJ6qKLYL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7334DC4AF14;
	Mon, 26 Aug 2024 05:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724651448;
	bh=aLzgLgLWLVzf1iRXKVptENNKfdzYPHBNK3OzoTkhSI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fJ6qKLYLJf3P3WLRF4AMdUkfPnjg8WzQNRcjfLrbie8shPl/8kO3v6X2J8sO47V3N
	 7lNYRuys8c1+FEX/ynJl7fjVtvWcbd1Or+JzkyWABOTakkWb7t7hzqALAfClJKuF7o
	 Io/ocNCHGxAQZxrdZITY9peak6h0nh4c9ynv0lqDmIDCqxeMpd61eh5O5YUrMVf1Sd
	 rBOPEI0pyNeNx4/HpDad3DJkWe194cdUoRIrJZnUhGbfCVyxHsaWGKtUjI1EN4gtgO
	 GV326XHi6rGrN+57SWVRzY1T9In8FwNFTugEAwPJ0wcQ+qqepAXLcvs2xcdE1t8UqK
	 RH0kkZ5z8cnTg==
Date: Mon, 26 Aug 2024 07:50:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ayush Singh <ayush@beagleboard.org>
Cc: lorforlinux@beagleboard.org, jkridner@beagleboard.org, 
	robertcnelson@beagleboard.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Johan Hovold <johan@kernel.org>, 
	Alex Elder <elder@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	greybus-dev@lists.linaro.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/3] Add Firmware Upload support for beagleplay cc1352
Message-ID: <ldgyloxyvdi2ovpkdmbx443qxolfjlufdkuvgbqjzfw6jskcc6@qwdtctmjo26h>
References: <20240825-beagleplay_fw_upgrade-v3-0-8f424a9de9f6@beagleboard.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240825-beagleplay_fw_upgrade-v3-0-8f424a9de9f6@beagleboard.org>

On Sun, Aug 25, 2024 at 10:17:04PM +0530, Ayush Singh wrote:
> Adds support for beagleplay cc1352 co-processor firmware upgrade using
> kernel Firmware Upload API. Uses ROM based bootloader present in
> cc13x2x7 and cc26x2x7 platforms for flashing over UART.
> 
> Communication with the bootloader can be moved out of gb-beagleplay
> driver if required, but I am keeping it here since there are no
> immediate plans to use the on-board cc1352p7 for anything other than
> greybus (BeagleConnect Technology). Additionally, there do not seem to
> any other devices using cc1352p7 or its cousins as a co-processor.
> 
> Bootloader backdoor and reset GPIOs are used to enable cc1352p7 bootloader
> backdoor for flashing. Flashing is skipped in case we are trying to flash
> the same image as the one that is currently present. This is determined by
> CRC32 calculation of the supplied firmware and flash data.
> 
> We also do a CRC32 check after flashing to ensure that the firmware was
> flashed properly.
> 
> Link: https://www.ti.com/lit/ug/swcu192/swcu192.pdf Ti CC1352P7 Technical Specification
> 
> Changes in v3:
> - Spelling fixes in cover letter
> - Add Ack by Rob Herring on Patch 1


Where?

Just use b4 to collect tags.

Best regards,
Krzysztof


