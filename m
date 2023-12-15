Return-Path: <netdev+bounces-57908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B46814779
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10ACF1C2275C
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDAF25561;
	Fri, 15 Dec 2023 11:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfffbYI1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46342288AE
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 11:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D9CC433C8;
	Fri, 15 Dec 2023 11:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702641527;
	bh=Dlp58BrSMA2HdtiBJSzV/gXO0OvsoM+MMj2fa/ZuML8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hfffbYI17tn9YHBxdY4YWHoRg4D5v/GDNcioY0rQXfKdQVz0cziT1M8mAb06CRUpI
	 LLeWjJfdjMDfT188IrJUOqm8GsbNjOwUPASIdnsnzEPr5kRc3JBfLT0dMPe+9DzQ1e
	 a5H/RqODCfFf5SbJTfGgD9kUWhq759qntgSOienbaQQOefAJn9dgp40IMKjzA0Lppg
	 Kiqda9B777zW/duu+TPWEFVH8mNutSDVL8uiD3G2lDrlJ3zPhnZxlkTXcKQcOJcxEV
	 Z4udPRD5VrQ2Scrm2qmY00CMMBOfL6olpicZzx0aOhRTmxtyNarq+nzb1r3UcRAw6B
	 3Rm/eIiPlMA9Q==
Date: Fri, 15 Dec 2023 11:58:43 +0000
From: Simon Horman <horms@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 8/8] dpaa2-switch: cleanup the egress flood
 of an unused FDB
Message-ID: <20231215115843.GH6288@kernel.org>
References: <20231213121411.3091597-1-ioana.ciornei@nxp.com>
 <20231213121411.3091597-9-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213121411.3091597-9-ioana.ciornei@nxp.com>

On Wed, Dec 13, 2023 at 02:14:11PM +0200, Ioana Ciornei wrote:
> In case a DPAA2 switch interface joins a bridge, the FDB used on the
> port will be changed to the one associated with the bridge. What this
> means exactly is that any VLAN installed on the port will need to be
> removed and then installed back so that it points to the new FDB.
> 
> Once this is done, the previous FDB will become unused (no VLAN to
> point to it). Even though no traffic will reach this FDB, it's best to
> just cleanup the state of the FDB by zeroing its egress flood domain.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>


