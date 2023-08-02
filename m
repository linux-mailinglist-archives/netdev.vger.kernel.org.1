Return-Path: <netdev+bounces-23691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0351976D1D9
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345C41C2129F
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D81D312;
	Wed,  2 Aug 2023 15:24:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26738C0C
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 15:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC64C433C7;
	Wed,  2 Aug 2023 15:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690989870;
	bh=AsAwCL7YysIyiApwU0DEZ4rat1nzt2aX13d1nS4nuDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bjlME2upSvXRAf/m/cuZiwmo5VnVspD8x1KGckoVYQHKmQplffbUWB1H7uK4qoUbt
	 PK8ca8wW+aNrIfdVEofOBhya1CiO7YkGKnDgOYBX8Y/96WuTNBDXaCdKIVoneZ4neu
	 4ET1Zs5R64PtWXwfAcZNi/3Xcuwrd8WrG6SGevC3Zrz40MzstmH8cJLFfny/MreVL/
	 6r2Vn0UxD1V2B89tmD8j7KnRXqaf/u34yVV8tTxPgCTeQKo6xSeB4QngdPUZt8tsxy
	 pbStjBW31lQFPs2Pi74aEJTB+8r0w9LYtn80AZx14nr2St7H1sjMHpiIHUBOBMyhZ4
	 Aib0mqDq/8UwQ==
Date: Wed, 2 Aug 2023 17:24:25 +0200
From: Simon Horman <horms@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 4/4][next] i40e: Replace one-element array with
 flex-array member in struct i40e_profile_aq_section
Message-ID: <ZMp1KUZIEli6WL0H@kernel.org>
References: <cover.1690938732.git.gustavoars@kernel.org>
 <8b945fa3afeb26b954c400c5b880c0ae175091ac.1690938732.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b945fa3afeb26b954c400c5b880c0ae175091ac.1690938732.git.gustavoars@kernel.org>

On Tue, Aug 01, 2023 at 11:07:06PM -0600, Gustavo A. R. Silva wrote:
> One-element and zero-length arrays are deprecated. So, replace
> one-element array in struct i40e_profile_aq_section with
> flexible-array member.
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/335
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


