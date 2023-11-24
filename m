Return-Path: <netdev+bounces-50937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAFE7F79AE
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 17:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E775B20F66
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 16:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6AA31740;
	Fri, 24 Nov 2023 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8y+L/N7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD5F364A4
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 16:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12046C433C8;
	Fri, 24 Nov 2023 16:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700844519;
	bh=aOSyWxsPCSARKTHyqNLlusRc2HF7ChrOhJn8s86UXsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u8y+L/N74Nut5tJxqr8hMdvI0Nj4LKerxwOPf666UaRxC7XLfeNBwhQIA4muf0/sy
	 vL1K57nDKxZDNup4Zhzw4Glcm6i5ZB0GkPMsIDIf4lMP5joqsZcpmE7doL8svoNL1i
	 l6R733FuEeSrG5wDOAErGNTF0YufnEZ3U2jFlVQ/6dbVxsdzt0g3JOLgAeN/soTJ0P
	 VRxuGcN8uoulmVTJE9a16feowMBrT81YnpsUcu2Lo8YuY+mPADkurjx2YCxOzLUdoP
	 HM98Eh5aOdFqMEWg6eYpQrEdxha2pCypYuF1BVXBfD84TWY5SM9uYyHl4K4uUQ06Yb
	 KEihAys3IRodw==
Date: Fri, 24 Nov 2023 16:48:34 +0000
From: Simon Horman <horms@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3] firmware_loader: Expand Firmware upload
 error codes with firmware invalid error
Message-ID: <20231124164834.GT50352@kernel.org>
References: <20231122-feature_firmware_error_code-v3-1-04ec753afb71@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122-feature_firmware_error_code-v3-1-04ec753afb71@bootlin.com>

On Wed, Nov 22, 2023 at 02:52:43PM +0100, Kory Maincent wrote:
> No error code are available to signal an invalid firmware content.
> Drivers that can check the firmware content validity can not return this
> specific failure to the user-space
> 
> Expand the firmware error code with an additional code:
> - "firmware invalid" code which can be used when the provided firmware
>   is invalid
> 
> Sync lib/test_firmware.c file accordingly.
> 
> Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Changes in v3:
> - Add the newly introduced error code to test_firmware.c

I verified that the error obvserved in v2 when compiling the above
file with clang-16 has been resolved.

Link: https://lore.kernel.org/all/20231121173022.3cb2fcad@kernel.org/

Reviewed-by: Simon Horman <horms@kernel.org>

...

