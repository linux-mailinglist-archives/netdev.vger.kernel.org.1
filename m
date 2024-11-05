Return-Path: <netdev+bounces-141769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DFD9BC328
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 03:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78561C217A1
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 02:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3585736AF5;
	Tue,  5 Nov 2024 02:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nucBWmP/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037491CD0C;
	Tue,  5 Nov 2024 02:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730773783; cv=none; b=G30oMW7GnOc3i9UrWvEB0LBEaTwQfjB+hA1SboSxV3AjXcKw6yHjdhOSC0kL3i0n6iOS0gOD8k3JBmAZU3mSdqAsVlhUCPtUuPJCl1Ld3V7aPN+Pg8gXx/m9BsDp+5URfl6ymSbJDORNVX1paSW3AQKY7SNATRLlkw3sVvNMUSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730773783; c=relaxed/simple;
	bh=+rbvRAXwqFZheDS55rt0qf6Ed8xH23mKjmoTp+dzypo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1TRxJhEU5ZeD1SRUnXndjnB8IesCXL+b0TnECAEIARuC/PbuZfp+eAISaDWvuf7dcfmbSIg+jXepbpmudx2/AQEcq1uTyhoLE2Y/AnpxN3jPQM+E/S+y0uCob/phXE61jz05LM7MQwNP6jIOdrMl7ZsZ0enTT8ZvXXGoelzazw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nucBWmP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52736C4CECE;
	Tue,  5 Nov 2024 02:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730773782;
	bh=+rbvRAXwqFZheDS55rt0qf6Ed8xH23mKjmoTp+dzypo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nucBWmP/0+Miljuoo8HdIXFB+wse52JmwxgO6ngB7+Gh9TOElauZMY/rtC2H7alb4
	 OpTxEMBniTh5ErqdfgyqUAA3N7/F/VDDISpLlRlR88n6jrBDQNWCboWMuQtrYz7C/U
	 X9+qcMhkUbwjTQ5RsS4pfEZaP3spnsTuqjEs1S6fH7Ev5QlwulVhpL7P20Qz8SgSNi
	 WeA02ES/LAdKmhhCOgRfgfh4OcC4qt3zCPBdanugIHXuj9LQ2Wp69xXo27dVCa6GSD
	 2rvZ++bhpK6LMFwnvh2Q/cJ0yu3s36wOKPlJJdoiH7MN57DyieIdXpP8uhblz6AzK5
	 ZaikNeYgBPKLQ==
Date: Mon, 4 Nov 2024 18:29:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof
 Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH net-next v1 1/1] nfc: mrvl: Don't use "proxy" headers
Message-ID: <20241104182941.342c3b7a@kernel.org>
In-Reply-To: <ZyiChsS_zrHlet3E@smile.fi.intel.com>
References: <20241101083910.3362945-1-andriy.shevchenko@linux.intel.com>
	<20241103081740.7bc006c1@kernel.org>
	<ZyiChsS_zrHlet3E@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Nov 2024 10:15:02 +0200 Andy Shevchenko wrote:
> So, you are welcome to help developing such a tool.

FTR I find saying such things to maintains very, very rude.

> Can we have this being applied meanwhile, please? It's a showstopper for
> getting rid of of_gpio.h rather sooner than later.

Doing this cleanup as part of deleting a deprecated header seems legit.
But you need to say that in the commit message.

