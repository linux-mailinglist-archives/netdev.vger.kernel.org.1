Return-Path: <netdev+bounces-53308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C535180233F
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 12:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AEA61F2100F
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 11:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472AF947F;
	Sun,  3 Dec 2023 11:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjYMVFOP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C10928F0
	for <netdev@vger.kernel.org>; Sun,  3 Dec 2023 11:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2ED5C433C9;
	Sun,  3 Dec 2023 11:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701603727;
	bh=yyB6miuV3QDfgKnJCr8YxHHVQ4FeW1IM6trz2iKW220=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qjYMVFOPP3usK2DsxR2PhtHpHYZ4WGTs6XUpZV3XMQXpqDA+9QKDyqaTkSbXkxBJ+
	 WxygQf25Gdc2nlfqNmH26ZaPLuXlyfEA+jast5XjwuUaV2P/xGRMeMBJUPTSwsJnni
	 YdFTs03N9MelOH7/scZz96jkvHYSCEqTXMcMFTHHM27y5O7Y52E3weMUVkiC0APDdn
	 CO5oDRYWl0yzhVG2qSdgMuE1UQGGX0J7nkNYG+hxjJ54vq5TW7L7e26nJqLBWOdZue
	 RBZfxMPrTVaQna3U3XoG8FQ1LBUG0OoEQC4o3sQ0fn9hnpvu476fRIFWhEJcOqkVb9
	 iOkAWwSvm5LnQ==
Date: Sun, 3 Dec 2023 11:41:59 +0000
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>, mschmidt@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v5 3/5] i40e: Add helpers to find VSI and VEB by SEID and
 use them
Message-ID: <20231203114159.GH50400@kernel.org>
References: <20231124150343.81520-1-ivecera@redhat.com>
 <20231124150343.81520-4-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124150343.81520-4-ivecera@redhat.com>

On Fri, Nov 24, 2023 at 04:03:41PM +0100, Ivan Vecera wrote:
> Add two helpers i40e_(veb|vsi)_get_by_seid() to find corresponding
> VEB or VSI by their SEID value and use these helpers to replace
> existing open-coded loops.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


