Return-Path: <netdev+bounces-40669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 817577C842C
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 13:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2BCE1C20A56
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 11:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94647134D9;
	Fri, 13 Oct 2023 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDPvni/A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65370125A0
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 11:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE638C433C7;
	Fri, 13 Oct 2023 11:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697195710;
	bh=jA46OFfZWE5nXbqzK1rBDGiSAqJladumXI0uqrd0S44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UDPvni/AZVdMKTlO8s/IBEmavFAjqLDOaRcwMvA8tdAkQ8+fB/O3DzkNkzOtYMXpW
	 dkx6vgxkMbpHPwbEL9x/F1yBPw8WqjJMOzQ9PH9OEmKrM+V42syJ83yeVeL+CAOdGe
	 I6f+AihD+y26HPYtWFPdwnLhU8rR5OwxHmmE/R8cXqR3G0eEXY4paqAn+acP/PvlEp
	 xsRzRqJNJ/Zb1y34jhlLM63lWMbVfhX9oOzVvlE3p/9ZFz2ZNsS0jf6oKVlVdxZEeA
	 5uwk6rorBxYU9JcTtdhchUVCixTShpqgJ68w+OQAU2jZeF0EiTBA6Vt3dcHJqgSxBL
	 uWMXpoUjdmb5g==
Date: Fri, 13 Oct 2023 13:15:05 +0200
From: Simon Horman <horms@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: pabeni@redhat.com, linux-kernel@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, egallen@redhat.com, hgani@marvell.com,
	kuba@kernel.org, mschmidt@redhat.com, netdev@vger.kernel.org,
	sedara@marvell.com, vburru@marvell.com, vimleshk@marvell.com
Subject: Re: [net-next PATCH v2] octeon_ep: pack hardware structures
Message-ID: <20231013111505.GE29570@kernel.org>
References: <PH0PR18MB47341BB93B1CCC7E6E91AC53C7CDA@PH0PR18MB4734.namprd18.prod.outlook.com>
 <20231010194026.2284786-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010194026.2284786-1-srasheed@marvell.com>

On Tue, Oct 10, 2023 at 12:40:26PM -0700, Shinas Rasheed wrote:
> Add packed attribute to structures correlating to hardware
> data, as padding is not allowed by hardware.

Hi Shinas,

in the v1 you stated that this is bot a bugfix.
So I am assuming, that by some happy coincidence,
the layout of the structures is the same before and after
this patch. And this patch is thus a cleanup.

If so I think it would be worth noting in the patch description.

