Return-Path: <netdev+bounces-50473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314197F5E78
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 12:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5A0281CEE
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 11:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C53241EC;
	Thu, 23 Nov 2023 11:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asew1abr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15642241E9
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 11:57:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E33C433C8;
	Thu, 23 Nov 2023 11:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700740654;
	bh=d1KKFj+DyjKk6+RozV1+DoTTJKQS2amb7hIMgX6LAvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=asew1abrsIY6gEFKiHpdM4HgeUYNjUYxkfJwcM8AY78HdsjF4c9X1ruoxfVSCYRR0
	 BijnDVaEp+5V652iMAyaNcFpJTJ83/LaTU6XjfUjCxUN5fRucLY4oL7/vMQBhwEcG0
	 mdGWod2B+3HjqG9YXstRAHHBUwzhGTC7OcoO1RCfWQ4jI7howUKc7AxJj/HY4m2Aty
	 HO7bSH0KskPl+uUYUYDHRRSYtfHNjI646+EMzwNl6fhsFAC/jcVlOWgrayEyyndjZb
	 whWdGZ/h8GS29BhGv0gYhOtXXtVQeH7WET3kL2Sh72T4aBFa0cbAGdd03SwK72sy/4
	 0XqdT/k64sCiw==
Date: Thu, 23 Nov 2023 11:57:29 +0000
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
Subject: Re: [PATCH v4 1/3] igb: Use FIELD_GET() to extract Link Width
Message-ID: <20231123115729.GA6339@kernel.org>
References: <20231121123428.20907-1-ilpo.jarvinen@linux.intel.com>
 <20231121123428.20907-2-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231121123428.20907-2-ilpo.jarvinen@linux.intel.com>

On Tue, Nov 21, 2023 at 02:34:26PM +0200, Ilpo Järvinen wrote:
> Use FIELD_GET() to extract PCIe Negotiated Link Width field instead of
> custom masking and shifting.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks, nice to see FIELD_GET() used here.

Reviewed-by: Simon Horman <horms@kernel.org>


