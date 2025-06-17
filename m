Return-Path: <netdev+bounces-198816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7011DADDEFC
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 00:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4A1117895D
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 22:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D108A28C029;
	Tue, 17 Jun 2025 22:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlDv6axZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2AE1AAA1B
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 22:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750199499; cv=none; b=qsdpr6ic/jhqwgHiQcy9uCXU4bfUeBvVX4T2sNf2FclgSVliI7zpmTFTgnm96YqveUwGr6JENgb/dOVK9kwEMItg+dBXC1Pa1OaCVgbpDRgqL9yMFhlf3qWdKOpclYtGEnBhPqv+bzQQMoeBIV137iYQDHnnArb1/6TUQVBKG9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750199499; c=relaxed/simple;
	bh=daWIuCnKOqJxZjDHibvmOWaePziSzoIYshMdU3ihRCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FlETPOHRAzkYiO/NK6Hcn7eexq02dvg75bvPVKD/Tbmyu/gYJ7719tEIIDajobepHsBkDfhUGWp5Rt9HkdWT0z6W/SIi4ltAnxEfckSlf1B9DtI8rxsQ4xgqXEdW53SOcuxwYjxMWLG0jARlhtc8mLWl+uDDBpuvI9/nfr/nZho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlDv6axZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE23CC4CEE3;
	Tue, 17 Jun 2025 22:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750199498;
	bh=daWIuCnKOqJxZjDHibvmOWaePziSzoIYshMdU3ihRCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OlDv6axZhMMRiln0sTMZjX+4xP3daKbFPzNgMsZXR73qzPxX9Djhcknu1eFzKfrq0
	 hDkf/EwKs7v+MyOU5hxueGOLLj4bb+jMK1IaQJP6//3OJ5lv+jxDbTpCKWMJj9uLtS
	 9JfHonaUVBUsUvObWK2dBHSzHjIzmgrMHGfdumwWNV83weAdEyLdFjpNEyDJ8TA3Qz
	 uWKS209HY9QM/ibGkEBrKqOYroAvdzPt29gyHBXQLa4WaS3orfXpFLtvV8ZwzAdRzq
	 XdO1SSLN6jEd3JNJzcPrNlj0JZhDEnvunKqpAlHtFX/+igsEDHAi9J9J9WIK498NeA
	 EUHTwOEQYDeSw==
Date: Tue, 17 Jun 2025 15:31:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Always check return value from
 airoha_ppe_foe_get_entry()
Message-ID: <20250617153131.56a783c4@kernel.org>
In-Reply-To: <20250616-check-ret-from-airoha_ppe_foe_get_entry-v1-1-1acae5d677f7@kernel.org>
References: <20250616-check-ret-from-airoha_ppe_foe_get_entry-v1-1-1acae5d677f7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Jun 2025 12:27:06 +0200 Lorenzo Bianconi wrote:
> Subject: [PATCH net-next] net: airoha: Always check return value from airoha_ppe_foe_get_entry()
> 
> airoha_ppe_foe_get_entry routine can return NULL, so check the returned
> pointer is not NULL in airoha_ppe_foe_flow_l2_entry_update()
> 
> Fixes: b81e0f2b58be3 ("net: airoha: Add FLOW_CLS_STATS callback support")

Looks like the commit under fixes is in net, is the tree in the subject
wrong?

