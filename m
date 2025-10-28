Return-Path: <netdev+bounces-233695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85581C176FE
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2EE13B6683
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 23:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F63530BBBF;
	Tue, 28 Oct 2025 23:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDW7RrOK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F8A307AC6;
	Tue, 28 Oct 2025 23:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761695880; cv=none; b=qhh4zJesi4PhqqgfI4vd+84ApNKIuVjT6JDG18vEgLBG+Q3KLRvNABjyS/1l8m1XgSWp1t6q2RTyAGHm8jYpm7czaF+YxUUbbmcw+MU/1AqPSt6E4VplJxaqbEL0Uc+d8HmfRGmByz3T0tmyzSMV3boYwvd3ml4YeXSwxd3/aeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761695880; c=relaxed/simple;
	bh=nE2NJLHROko0alBLv6YqPW8LGiyGs8HTmlyMDEfRYQY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jYWUIaDDtX9TFSTnWgcWzRxzoupXYKL5DkrRVpkf6tNbWUce+RZJCAbU+HWIS0P+znQ+RGJOBCIZmXTdS7DaU6oiGd2Jz1UnZAQhCnFcs9j+ORzV/pFuMjqGIJzawJNB7F9q9oQPZZMOMTuBvMhqnoaVC1Y6OMemKVB/mEGeyb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDW7RrOK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F5EC4CEE7;
	Tue, 28 Oct 2025 23:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761695879;
	bh=nE2NJLHROko0alBLv6YqPW8LGiyGs8HTmlyMDEfRYQY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mDW7RrOK14KV7C8wTB6IM7YI+HpyyZfXI/4MAxBxYE3Ob8/DJIROhoKgMUKYNCxi3
	 T894OHpazzq4S4RJ4UaZmq7birG9ugP38wZisuROFJz244EtQxBkajTkvhnyhV799Z
	 z77ED/I7miSX3X3O1ly+ucwp+K3X+/PwXfbjGY1DtjKE79tbXZHSJlbkUhA5iJa2td
	 RhD9dW6H8g+Msu596yozb80eoq83yInfwyQO7pCZN5OY6mpy9ljcSmtwJMmqMbe93I
	 YYXbMoHdBCnxghg6JKTu7qOCJ+0E2Bw0GdWzzLse3B3cMa7k5qj127ay2MPN0gWZf8
	 vkDyJXJt0hGYw==
Date: Tue, 28 Oct 2025 16:57:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 Frank.Li@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, richardcochran@gmail.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v3 net-next 0/6] net: enetc: Add i.MX94 ENETC support
Message-ID: <20251028165757.3b7c2f96@kernel.org>
In-Reply-To: <20251027014503.176237-1-wei.fang@nxp.com>
References: <20251027014503.176237-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Oct 2025 09:44:57 +0800 Wei Fang wrote:
> i.MX94 NETC has two kinds of ENETCs, one is the same as i.MX95, which
> can be used as a standalone network port. The other one is an internal
> ENETC, it connects to the CPU port of NETC switch through the pseudo
> MAC. Also, i.MX94 have multiple PTP Timers, which is different from
> i.MX95. Any PTP Timer can be bound to a specified standalone ENETC by
> the IERB ETBCR registers. Currently, this patch only add ENETC support
> and Timer support for i.MX94. The switch will be added by a separate
> patch set.

Is there a reason to add the imx94 code after imx95?
If in doubt order things alphabetically.

