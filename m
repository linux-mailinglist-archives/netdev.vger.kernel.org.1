Return-Path: <netdev+bounces-228892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE34BD59F3
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 19:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E4B54E3CA4
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A842C21F5;
	Mon, 13 Oct 2025 17:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X28Oaq/s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF8E2C15A3;
	Mon, 13 Oct 2025 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760378393; cv=none; b=PfvfsnFd/PBbzP/blI5lysjqdSjD5IFSSJxmdy3Ei6PMiBaQ0dulwtOBX3gYj5bUEyw045V3hh8JLBioJ0iBS7muC8hjum+FQcGL5XS+UcqfNxa6OkCHP/5j8DJfDvG6caUJEtYUZAkOlZQlFSGkHcs3btxTHgkk5wthXNa82kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760378393; c=relaxed/simple;
	bh=yAqclelQ+x2VIMbz0XIlGvwP+MQo24gNnvSAjzjeb14=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+Zepk3b2JWQfeWm4gR6ODLC7WkARweLd8Ed7e560HN+RdTH1nAaB22qrbAb/XPHdIbKCj2kvYmVHYI/h597yB5hR7niM92jzwDgFQoyDSH0mqBeBfZw2TIlafeOMwP9gef0L3X98whHZe3ZtebSR6qszULszDIAwFSK6Ki0baU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X28Oaq/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498D1C4CEE7;
	Mon, 13 Oct 2025 17:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760378392;
	bh=yAqclelQ+x2VIMbz0XIlGvwP+MQo24gNnvSAjzjeb14=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X28Oaq/sjjNH40Z2jBfJtI/8708lfG6tBcELB+AKGkHw+Ez+RbE69dy8Lcy+ECfgu
	 QnymurPzMdupCGOgxlKn7DxQkZ7lcFVJ/dBD3iia/l4gPCZ23WOpJumQGyfHFFFTQD
	 D+Mpf/8KkRlN5mOG+ojWqN+9zhqY1IJijNamAu8JCS1FztcoN5Glvsn9/1BWI4zpUL
	 /h5SRpvwjl7miKnW5DloXGPcqDATT+fum9hR4Jr5p+cfRBExSRRvneACnPaHo/iTIa
	 c2elzi1ZuqPGt4RgQS7OkX/0VNrX9kZe2qSZcHrSG1UGbBFDtF6MUW8CPzySJJe34L
	 wCAD/ET1/Hhtg==
Date: Mon, 13 Oct 2025 10:59:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chris Babroski <cbabroski@nvidia.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <davthompson@nvidia.com>, <edumazet@google.com>, <hkallweit1@gmail.com>,
 <linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>,
 <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1] mlxbf_gige: report unknown speed and duplex
 when link is down
Message-ID: <20251013105951.261afc77@kernel.org>
In-Reply-To: <20251013151715.40715-1-cbabroski@nvidia.com>
References: <20250826184559.89822-1-cbabroski@nvidia.com>
	<20251013151715.40715-1-cbabroski@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Oct 2025 11:17:15 -0400 Chris Babroski wrote:
> Hi Jakub,
> 
> Following up on this patch.
> Any further comments or concerns?

Please read:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
It will tell you that you need to send a v2 and what changes are
expected :/

