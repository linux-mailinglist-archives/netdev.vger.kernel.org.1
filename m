Return-Path: <netdev+bounces-50475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D262C7F5E84
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 12:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F11A1C20FB2
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 11:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC3C24205;
	Thu, 23 Nov 2023 11:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBtfNhqg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8E72377F
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 11:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014FAC433C8;
	Thu, 23 Nov 2023 11:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700740675;
	bh=wl9oNNHOLEXop5o0ArpCVRXBXQS6LvZBy1Xs2D72YlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RBtfNhqgVf2DOEg6I9Ifs5PmN+q9wsTnGe+qHhbeEJKlV8I3wzrxM4I2f5G51Q6I2
	 rYG1IMBn7OTW+y1uEZcyfOUd+/AcRqbZEM3uigEqI97iQgNZLWzo1Bb6wlbzq0C9An
	 xoPhMmQyKzAEvEbnekNqT89fst8W1GZVYnGv/8DFHntwaOie+yuRdTkDp9dN7MDmo/
	 D62Pp6nSt3IQLkaCFiWQT153LIol6TSYcPB5GtiWGB2g5qINJ6P9Y7QELDfkOtUrwh
	 M6CxD1zlgZX6MhtInT6OppoHdLT6VcWlTPaN3dz1G6jojeO1ku1/qcFbqRqy+q2xSf
	 ysgI+NwGKBteA==
Date: Thu, 23 Nov 2023 11:57:50 +0000
From: Simon Horman <horms@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] e1000e: Use PCI_EXP_LNKSTA_NLW & FIELD_GET()
 instead of custom defines/code
Message-ID: <20231123115750.GB6339@kernel.org>
References: <20231121123428.20907-1-ilpo.jarvinen@linux.intel.com>
 <20231121123428.20907-3-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231121123428.20907-3-ilpo.jarvinen@linux.intel.com>

On Tue, Nov 21, 2023 at 02:34:27PM +0200, Ilpo Järvinen wrote:
> e1000e has own copy of PCI Negotiated Link Width field defines. Use the
> ones from include/uapi/linux/pci_regs.h instead of the custom ones and
> remove the custom ones and convert to FIELD_GET().
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


