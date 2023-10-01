Return-Path: <netdev+bounces-37259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 888F27B4759
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 14:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id A920C1C2048D
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 12:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E4A1772F;
	Sun,  1 Oct 2023 12:23:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4310E5666
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 12:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C31C433C7;
	Sun,  1 Oct 2023 12:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696162981;
	bh=OkfmSReXJWH65GTbJ8/OWhwdpJ6O+HTlW6xaMfOmcAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vKQ6iWk3LDBQwoOkyswRFnrviy9ScHi2U9OPc1p7MlgpAmDJ5Go6j112CRQJbYShA
	 YpfsbY1ryvRkN+fEPJW3/jOEqCD/XcmFrzIQ33SOvx156KY+22zx6iuS3Vowlgqndx
	 ak4yZK2CUk3lIYCFflWdgxLMdjJ3lm8pw1nvfZxUsgTyCInrkVvvlIX/eGtikikVrh
	 ov3bpgO+Ygp08rWcMeG1/aKJA4ky3so4pOYtbFybWb8UshcnJv/AokHnWnEUGz0Lug
	 5zrvk1FC2oFPISMBkb4s7mYhbpfcVqnxdvRqy2bZpw0B0DPMCVE4UW4G89836fL89d
	 /Qh8nAVOvQhYQ==
Date: Sun, 1 Oct 2023 14:22:57 +0200
From: Simon Horman <horms@kernel.org>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Julien Panis <jpanis@baylibre.com>,
	Judith Mendez <jm@ti.com>
Subject: Re: [PATCH v6 02/14] can: m_can: Move hrtimer init to
 m_can_class_register
Message-ID: <20231001122257.GK92317@kernel.org>
References: <20230929141304.3934380-1-msp@baylibre.com>
 <20230929141304.3934380-3-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929141304.3934380-3-msp@baylibre.com>

On Fri, Sep 29, 2023 at 04:12:52PM +0200, Markus Schneider-Pargmann wrote:
> The hrtimer_init() is called in m_can_plat_probe() and the hrtimer
> function is set in m_can_class_register(). For readability it is better
> to keep these two together in m_can_class_register().
> 
> Cc: Judith Mendez <jm@ti.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: Simon Horman <horms@kernel.org>


