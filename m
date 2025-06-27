Return-Path: <netdev+bounces-201951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34549AEB8E5
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 15:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7609B3BDA56
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435762D9ED8;
	Fri, 27 Jun 2025 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1DE9m63"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF5A2D3EFC
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751030915; cv=none; b=dXR9bWhhlLg12SdOUdbpMJEY+/4Oet59xn0AwesQiiJ3skJUiDTWDxxdlf1ehSErg2AUTuRmLd9j0s4St7JXU+Wpm0uepzLsKT3Pw9+1Tf4aUKvQ3XDi2l7MpeJ2H+fI8rpWvssza9D/i0Xg074IGUp+UHo8TOPxF6H4RR/wZh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751030915; c=relaxed/simple;
	bh=N1gYT10JR+JGr0+DNkv8aeAAmeaN2XiWSkzhKzlOM9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0OxAicSqZBOrnGaOv5X1ecShyZB6PjgaHPcAtEg3K71D3bqXbEFG1KilmvMCPBMUzz+AorKjfUufoHFpVuQZ4iKxlE0r1wBXjHT35F6xOLi9cz0ZpQH/YrM+9JrFLR6U1YV39slKX1F0PTU2MqUqgtZ15EoSPvna+d4jrTDrxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1DE9m63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F08DC4CEF1;
	Fri, 27 Jun 2025 13:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751030914;
	bh=N1gYT10JR+JGr0+DNkv8aeAAmeaN2XiWSkzhKzlOM9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S1DE9m63gVCOWtk059+N3r50owI9wtkyXic51OKM/X8gpHmzsIxXhuqPGqxusBWE2
	 pznQDio/PPkp8pZoskNEW6Vsx7CqOf8oeS/SMoDZSK3k+sI+irPP7x/ieZYVwkSUBP
	 cqiZXGUN557bOhSM9iUPqpxMFtK92L4rcGU9qmRWvGut0QbXthtbmU3MX2gAiBHsTT
	 7d0WGFzjxj1qu79VlP/7iHxCn6iekeQYzcYfXyZnQSZsA46XFmkzy26msJOarN0CDg
	 JDhnisUG7ldI6JkZrn0RKuOauoEShgzMy+7k2EUFYQDWV/+ZdUA8TZQBpnp0ZgxMx1
	 FwnP32nzGIoUw==
Date: Fri, 27 Jun 2025 14:28:31 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net-next] docs: fbnic: explain the ring config
Message-ID: <20250627132831.GB1776@horms.kernel.org>
References: <20250626191554.32343-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626191554.32343-1-kuba@kernel.org>

On Thu, Jun 26, 2025 at 12:15:53PM -0700, Jakub Kicinski wrote:
> fbnic takes 4 parameters to configure the Rx queues. The semantics
> are similar to other existing NICs but confusing to newcomers.
> Document it.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


