Return-Path: <netdev+bounces-26986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5170B779C34
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 03:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C0E281DF1
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 01:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99399EA2;
	Sat, 12 Aug 2023 01:07:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E86864B
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 01:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71796C433C7;
	Sat, 12 Aug 2023 01:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691802477;
	bh=kKoMGqkaZrFbOmdnbjaZigHjWuY+wtaLeAvAQcSut8g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s+ecJZcm4Oz+U3bYwpLmbRS+QGsII+kG+5Ys0Day30a0lTlmbEW/48JDwfh5b1zhi
	 XbM0VghvEgEJi9hEztjT19jxl9svUYb9VHZImvmIa3TFOnzP5unzQMpaKKYe1K1yCz
	 WlwA9/ohm0vsDLnLR0JjYMsi/HtxdJQ+O6UpUM+QFGBO/OP4bBO7wuejAQDbH2MeGy
	 OmxvfgYoEBcDZdRAV6DmTJeq88waEj9YwPqpyAsYLM4ChP8pBKskt50lseHBpbVRUY
	 rcSNfsQMkbLesVajkALme9GXf98DDjvWeGD5Zv9jVRtr5yq9oKf7+6kzQfGw1mhYuV
	 rU6cCDFBWjipA==
Date: Fri, 11 Aug 2023 18:07:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net,
 emil.s.tantilov@intel.com, joshua.a.hay@intel.com,
 sridhar.samudrala@intel.com, alan.brady@intel.com, madhu.chittim@intel.com,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com, willemb@google.com,
 decot@google.com
Subject: Re: [PATCH net-next 0/2] Fix invalid kernel-doc warnings
Message-ID: <20230811180755.14efaf73@kernel.org>
In-Reply-To: <20230812002549.36286-1-pavan.kumar.linga@intel.com>
References: <20230812002549.36286-1-pavan.kumar.linga@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Aug 2023 17:25:47 -0700 Pavan Kumar Linga wrote:
> kernel-doc reports invalid warnings on IDPF driver patch series [1]
> that is submitted for review. This patch series fixes those warnings.
> 
> [1]: https://lore.kernel.org/netdev/20230808003416.3805142-1-anthony.l.nguyen@intel.com/
> ---
> These fixes are needed for the IDPF driver patch series to have
> a clean CI. So targeting the series to net-next instead of
> linux-docs.

Neat, thanks for these.

Jon, no strong preference on the tree here. I'll confirm these resolve
the issues in Pavan's driver when applying it, there's no hard
requirement for the kdoc patches to be in net-next at that point.

