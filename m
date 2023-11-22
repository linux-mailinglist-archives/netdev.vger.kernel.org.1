Return-Path: <netdev+bounces-49858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C26477F3B52
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 02:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F361A1C20F17
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 01:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A08D17D2;
	Wed, 22 Nov 2023 01:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3L8Bdjj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA0417CE
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 01:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318CEC433C7;
	Wed, 22 Nov 2023 01:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700616623;
	bh=qLkVBzXHR/QW5/imP3V/FC/AudAulL8dc5GkIdRhqfA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p3L8BdjjfTylDPlZyTn75Ouq8WJdrrS/p+OC10QDvCVlu/ODKjLeTcV03nzppkIgi
	 VMQA0a14bUeAqU6XFbXy1NrJsJ3aABmZnLu4Na+HcLOS9bkmDT47FJXScrXrMNlwnD
	 zmuD7fiGuTBnp7v7iyodEsqmNdXAqdC8IsmbQVQ5SvHi6lQ2ujoiRBV4SDn9TkZQRB
	 IIVGw58jUDEqluWJoa/udAezJY34dSvGn3+e2hu4K7M8xkS4eeCGx8Hnh+B3Gy0Qt8
	 AMcaz0paSaev1SLJeAgg3Pmi6mgauiCFdIvwJTBWuBin+PS1ebc69OnN9BQcyrgZPy
	 3/lqwSXL9P05A==
Date: Tue, 21 Nov 2023 17:30:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Russ Weight
 <russ.weight@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org, Conor Dooley
 <conor@kernel.org>, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] firmware_loader: Expand Firmware upload
 error codes with firmware invalid error
Message-ID: <20231121173022.3cb2fcad@kernel.org>
In-Reply-To: <20231121-feature_firmware_error_code-v2-1-f879a7734a4e@bootlin.com>
References: <20231121-feature_firmware_error_code-v2-1-f879a7734a4e@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Nov 2023 11:50:35 +0100 Kory Maincent wrote:
> No error code are available to signal an invalid firmware content.
> Drivers that can check the firmware content validity can not return this
> specific failure to the user-space
> 
> Expand the firmware error code with an additional code:
> - "firmware invalid" code which can be used when the provided firmware
>   is invalid

Any idea what this is?

lib/test_firmware.o: warning: objtool: test_fw_upload_prepare() falls through to next function __cfi_test_fw_upload_cancel()

My build shows this on an incremental clang 17 build.

