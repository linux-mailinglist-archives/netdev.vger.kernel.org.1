Return-Path: <netdev+bounces-106734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDC19175CB
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 03:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908641C21D14
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 01:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2AF11184;
	Wed, 26 Jun 2024 01:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G06JGvQ8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A3814AA0;
	Wed, 26 Jun 2024 01:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719366106; cv=none; b=oknpNbx7D6JDxEssa97AAsuUSbNZjWOaVNGWKpqg1zwALsAz3y1WAaM9aq1Ul8VZHZ7k0l3/YGfcPNkP+RLouT6AQzwl5Al8VSXwy9v7uf/pr+J/mo/kg/VqexnO0I0DJ6INR5w3N/lo9IeZAUAnvRrfL/zmYZT5AU2X2bOLZ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719366106; c=relaxed/simple;
	bh=uHai6EHLqk7JuszmV0uLDiI6h8mfmcLKdK4EEBOAphI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s0hxaH2DRjmBetUUItZiPet1fzf4qjPJEkeFV8d3PyyCcb4ixLEZAkxLh4Gzr90tL6R0BgLSJXzao/vWdipsY1f+pJ2PxfWUtQY/A7Wvq6mt8WEFXFvE+IXcyZSRy4KeQoEnwPMeWcWxqdgzSgTLlrK2oHbKwv4PvufieYuolr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G06JGvQ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89107C32781;
	Wed, 26 Jun 2024 01:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719366106;
	bh=uHai6EHLqk7JuszmV0uLDiI6h8mfmcLKdK4EEBOAphI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G06JGvQ8oos96fURjwqIQfVrIjyFRE0ujUqK1pAHTk3qCmCXO49pthYj/VqJ7qY0p
	 DK2JgFV1HJxhWbPO9/jpbYFg+vvGjc5SpCLp2dOj4yucPtEaowwcYq/4EttDVB/DAD
	 wwf6ZEhIY7HPghn98W4i3D93+35+ib+6Y7pXkRWnIwLod+wmNUIa9cTIu5SJWxmYfK
	 SnOlry2mr2P9E6fne2yK7OvEBJcmlsj7CjqgT+kO+RnvGjEw9XloDJezxk7ssDtqfM
	 U7AhkYy105ASV9CfA4jfwFI7b8gXJPAy/LkeakYml1nnuf70X3juuawYzizH7dAfTd
	 3TpeHUor797SA==
Date: Tue, 25 Jun 2024 18:41:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald Hunter
 <donald.hunter@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/7] net: pse-pd: Add new PSE c33 features
Message-ID: <20240625184144.49328de3@kernel.org>
In-Reply-To: <20240625-feature_poe_power_cap-v4-0-b0813aad57d5@bootlin.com>
References: <20240625-feature_poe_power_cap-v4-0-b0813aad57d5@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 14:33:45 +0200 Kory Maincent wrote:
> This patch series adds new c33 features to the PSE API.
> - Expand the PSE PI informations status with power, class and failure
>   reason
> - Add the possibility to get and set the PSE PIs power limit

Looks like we have a conflict on patch 6 now, please rebase
-- 
pw-bot: cr

