Return-Path: <netdev+bounces-114181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C133E9413DE
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6317BB29E9E
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 14:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B841A08AF;
	Tue, 30 Jul 2024 14:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meeJ7X0V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA94F1DFE4;
	Tue, 30 Jul 2024 14:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348095; cv=none; b=KFRj0hVbMPu5iU2BOyyV3xOaPmcoJLYhlwZbyvaBYJyswU8NuqBYv2Nl903TgoVM5nqXqhbqVnIlxEWqFrV//dI82Dp00X6BNb+YA5jfmDoYe620/bbD2Ew18yBUU85m4o6hzlBDHu6hjV7uZFfcUtt0u6v689SU1sauQaHZXv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348095; c=relaxed/simple;
	bh=oVQX6zHOpCl5gc7xhnnurdgTcUhr+9LmMK6XNr3Kldc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXIn18YScRTZgZPCEB5JFlLNdgnLVD58DfpUXgSSjQlFkMs6lPJZE9up9ggiHhQgLPfv8XOwRs4XnqTR3ooC/YMme7HBRqvDRR7/aG86LmEcwWBhjgZMY2DaxsMDxdVwBfRjiccsVaij+pfZ4KMwBTNDMpWM+idqBbKXZWpTbuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meeJ7X0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1958BC32782;
	Tue, 30 Jul 2024 14:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722348095;
	bh=oVQX6zHOpCl5gc7xhnnurdgTcUhr+9LmMK6XNr3Kldc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=meeJ7X0VyjMtS11PBQPUdV+vha3QrOx9IJ0wRCf/9qrNCM/iTpDDeoOodWYJsmKcf
	 hrpdZ0r2fEqzpMTSTsyMn6dvGiZvKQiwG1ugKLRr+b4Zj/As9QqPtvsTAxtM6qtdhz
	 2eV6r6/uPfcSwylv5Jq4ZpxY0MufaqxqYOFM1lSDRhkbHu3FLV3HR16DkPHkbMa9+/
	 3/31RNAsE0r2yxcNW3KuNq3yqZ0Uw+B9u7AIpZPB08+izjQxIW3yPVQx6L7M6lYJQT
	 OMzJZ06NKob7ObDIFxoSSZ6wG1NmK/+INhLCZOOQUmsrpSEnF8GORVZR187ef/JAWY
	 ZsUe4yk6h0DXA==
Date: Tue, 30 Jul 2024 07:01:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: Add skbuff.h to MAINTAINERS
Message-ID: <20240730070134.7b31ab6e@kernel.org>
In-Reply-To: <20240730125700.GB1781874@kernel.org>
References: <20240729141259.2868150-1-leitao@debian.org>
	<20240730125700.GB1781874@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 13:57:00 +0100 Simon Horman wrote:
> I might have chosen the NETWORKING [GENERAL] rather than the
> NETWORKING DRIVERS section.

Good catch and agreed!
-- 
pw-bot: cr

