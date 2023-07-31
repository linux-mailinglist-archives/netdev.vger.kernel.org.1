Return-Path: <netdev+bounces-22958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492BE76A30D
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 23:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 734F71C20D3B
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 21:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400B21E50A;
	Mon, 31 Jul 2023 21:37:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BA41DDF8
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 21:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E967C433C8;
	Mon, 31 Jul 2023 21:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690839475;
	bh=tNnNNAgUstMpo76JDeZJ2F9+DlBiOkyyYsbCO48kGd0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uDzKXr0TXQRQbCa8JAmgZN4sQX40ZMT50l+QcPtxLwXtpyerPkgNo2XK39zfKuyuq
	 6delEXi0pEpuPtJjOYF0I85L4cUOs/1NTKI6JdKDqiV6rHepui43a/CUlVnZBGuA+8
	 FxOKECIElWfddjFNYlcF5YAYK7Wf4HMXM4Xu5BdR1VphLeJRCdIuuXj/IGfraj8x1a
	 D0P6dGfCzJ8IKyziZOGpq/psijhI4/ox9XmQ32eHrcS4aqL9H0R7AS5KxPjajwUlRv
	 WYqfwSV/WkQt/nT3bnVf+JiHMO4YglCIiznM8o7at++7SMILMDsqdvMsrQGf0gYjTD
	 TS9iqF7u0B8cg==
Date: Mon, 31 Jul 2023 14:37:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Jan Sokolowski <jan.sokolowski@intel.com>,
 Gurucharan G <gurucharanx.g@intel.com>
Subject: Re: [PATCH net-next] i40e: remove i40e_status
Message-ID: <20230731143754.5a845ed7@kernel.org>
In-Reply-To: <20230728171336.2446156-1-anthony.l.nguyen@intel.com>
References: <20230728171336.2446156-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jul 2023 10:13:36 -0700 Tony Nguyen wrote:
> From: Jan Sokolowski <jan.sokolowski@intel.com>
> 
> Replace uses of i40e_status to as equivalent as possible error codes.
> Remove enum i40e_status as it is no longer needed

Thank you!!

