Return-Path: <netdev+bounces-54253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C7E8065E9
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 04:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A01971C21181
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 03:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F3CDDC3;
	Wed,  6 Dec 2023 03:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThjLwrXv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99332DDB8
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 03:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB10C433C7;
	Wed,  6 Dec 2023 03:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701835101;
	bh=QTqK7xlg3Kur369aSh8k2ICenQsCOeK2qm5MHkzrpnM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ThjLwrXvzO0yVrZz/lqY1nMvF9b4iqSQ5ZuPa6iFHNCgUh6Mz8/6iU69l4/8BQNJE
	 pI370SYo485tyoGViRUzODPXWBZVEU+p++c7YDsi69XtRP4tUXa6hZRL75taxuXRFJ
	 sroWyEhGqbZTT9/6Xq91R+aEIQ23M4dfSptO9L/BJETU0iZRJXPhvvinWlvKAsYuv2
	 YOpNHkfZT91J2nTRfdqlLau8AZiepO6U33JMoHcvkhQ9/HUhjuT6087tqJ2dN2+F4A
	 UkWes8aDFsUcKGR31KULZPzqxjnfTkAw7T2oEyrckTVghcLciZz0ITEqlp4pfwXw4E
	 eqHMaNOe+1R6w==
Date: Tue, 5 Dec 2023 19:58:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH 4/8] dpaa2-switch: add ENDPOINT_CHANGED to the irq_mask
Message-ID: <20231205195819.6c8dbcb8@kernel.org>
In-Reply-To: <20231204163528.1797565-5-ioana.ciornei@nxp.com>
References: <20231204163528.1797565-1-ioana.ciornei@nxp.com>
	<20231204163528.1797565-5-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Dec 2023 18:35:24 +0200 Ioana Ciornei wrote:
> Add the ENDPOINT_CHANGED irq to the irq_mask since it was omitted in the
> blamed commit.

Any user-visible impact? What's the observable problem?

