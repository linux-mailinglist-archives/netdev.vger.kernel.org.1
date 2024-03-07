Return-Path: <netdev+bounces-78423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A14C28750BD
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 14:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41E0DB261B5
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 13:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D3912DD89;
	Thu,  7 Mar 2024 13:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/r//Z0I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D467512DD9A
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818939; cv=none; b=um9jl9sCBTtKXcNxftOnK84TboLemk8g6WB1TUeffU9jx8TPIzqp/wcld50MncpsgmHiyOEpDyG5UuNrM+ZgMw6CFPJAJF0Cot8XndrrkTc2tGNt4IvafBP5uSfkbbXqNDHGspMt48ehnE6Z7FfTci/wWOFl3WFOehqzNDaOp0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818939; c=relaxed/simple;
	bh=sdmobqG0hEAVUrOR8BI+EeiJIxSsb+VTNhZ0pMWdcKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3N3igyUh+LaVzC1uvbH/anV25NV8oUedAEymLT/4QlUJAjomq3wd2GNSeIWQ5RFB5RXAYR5UKgGvtt7zAJ55bB9GFssO4mVRkhmMniJo34/XMu8JfzNOxsOCg1KtNbRDaiBV+ANqWitSzcdTQ6AG2b/wwA74i2H6aFXORxmroE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/r//Z0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB39C43390;
	Thu,  7 Mar 2024 13:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709818939;
	bh=sdmobqG0hEAVUrOR8BI+EeiJIxSsb+VTNhZ0pMWdcKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g/r//Z0IbgybEQVbsZCWhb7WuKUdc0Pi2f5oyeIDgB9ZcwCpau9bFahZx6NuWn2Gh
	 CQEyNC9HjYUfRRjdTcH634leNGW1N/g7h7MKa7GMDofungD37cJofSGibjuqBBqCH/
	 unSl6qd1lSfQH3aywuiQWp9DZEETXMvI6WfZPgGwnbLqlbpeYaD8B3Tj4Jn1hbu6rL
	 OPN+pA4oYpq/FWXIdx6CdIm87i/D6FnhZuE+FCVjglI9s8kIo6QfISCZevrEU9CaSg
	 DtmkLdEopLhDYpn1zJqFVVatkjMHhKv4QD6bgM6X75VqAjMsdj4Vq9M0SJhU+bS+Gs
	 jdgrs7obhDQ2Q==
Date: Thu, 7 Mar 2024 13:42:15 +0000
From: Simon Horman <horms@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Chas Williams <3chas3@gmail.com>,
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH next] atm: fore200e: Convert to platform remove callback
 returning void
Message-ID: <20240307134215.GA576211@kernel.org>
References: <20240306212344.97985-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240306212344.97985-2-u.kleine-koenig@pengutronix.de>

On Wed, Mar 06, 2024 at 10:23:44PM +0100, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Simon Horman <horms@kernel.org>


