Return-Path: <netdev+bounces-51005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF697F881F
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 04:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F5A281A47
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 03:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F1FA50;
	Sat, 25 Nov 2023 03:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8pWhOot"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B715317D3
	for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 03:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E85C433C7;
	Sat, 25 Nov 2023 03:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700882649;
	bh=Dr/cM1vM6EddpUQmfjLcvcCsG7fZOQeUYmdcw+IGsrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X8pWhOotFPWTUhpf7Wi/DOZFtBuTojhbbG/TmFrPUFTPZoAc1tMZ10pYMr0M0dqVV
	 RCG1nwD+goEPAee1DWIUsp6V2/oDG98+MqtXmOnRWbmvxhWEUwGuaweLNXf1Ajz2a+
	 lh36NE4JSK0PuSQ6HlQayoKTEnapVq85QXb17E9Ap6KVKgZT/vc7tJuKLx/wV1Gg2x
	 bDmw9bkpfzASKzsya+MfNFWCXb/jYOV3qoYkmZNktEV7GTos15kZCS6JT/ok5iScIY
	 ThLcgpscfqLWeRt4DW4ElDGwUgQa5Hq8lqnp5xjGHkyZUOCaYkhpMfnMGz0m9bamES
	 2cYzc2mKt1QhQ==
Date: Fri, 24 Nov 2023 19:24:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Russ Weight
 <russ.weight@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org, Conor Dooley
 <conor@kernel.org>, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3] firmware_loader: Expand Firmware upload
 error codes with firmware invalid error
Message-ID: <20231124192407.7a8eea2c@kernel.org>
In-Reply-To: <20231122-feature_firmware_error_code-v3-1-04ec753afb71@bootlin.com>
References: <20231122-feature_firmware_error_code-v3-1-04ec753afb71@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Nov 2023 14:52:43 +0100 Kory Maincent wrote:
> Jakub could you create a stable branch for this patch and share the branch
> information? This way other Maintainers can then pull the patch.

Tagged at:

git://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git firmware_loader-add-upload-error

