Return-Path: <netdev+bounces-60213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC7381E1E2
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 18:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC7E282443
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 17:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C666352F90;
	Mon, 25 Dec 2023 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqySyZXY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB6752F8D
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 17:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCE8C433C8;
	Mon, 25 Dec 2023 17:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703526359;
	bh=byq1hGibl99ygcWYpBtSkc3nCaR1D+5Y2siaLmyP40c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nqySyZXYu86JeTGmtA6kDchGwMySP+VdqrIYBsqlobmRV3rshUp41qGkbdEFOsB9d
	 lgPPg0tL8vmBK2YNybFw6I6muCpy5CCoPgnJexBr06sNUa4EjHvBZoXSxW4OZtjHzw
	 kK1hOO7riHqIu6vhmlhLmQbYAcyVhL1XJydT9c/zsn3PQL0j71qOF7/U2o+amfX0pI
	 eiy2jCyUnXraw5UXaVgzLL6z1j1ah3foHLABxPhR328dmXScvIdo6+9yK/kEo8gY4P
	 xGXvXQr41giKpK9HPJGCtnWKuB+6LTXyUb52tpnxirjYK7Cd2TbyygfIBiiPTav3E4
	 A7XXu6S/svbCA==
Date: Mon, 25 Dec 2023 17:45:55 +0000
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next v2 06/13] bnxt_en: Add
 bnxt_lookup_ntp_filter_from_idx() function
Message-ID: <20231225174555.GQ5962@kernel.org>
References: <20231223042210.102485-1-michael.chan@broadcom.com>
 <20231223042210.102485-7-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223042210.102485-7-michael.chan@broadcom.com>

On Fri, Dec 22, 2023 at 08:22:03PM -0800, Michael Chan wrote:
> Add the helper function to look up the ntuple filter from the
> hash index and use it in bnxt_rx_flow_steer().  The helper function
> will also be used by user defined ntuple filters in the next
> patches.
> 
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>


