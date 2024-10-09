Return-Path: <netdev+bounces-133800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D348D997145
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B0431F29373
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 16:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AB51F709F;
	Wed,  9 Oct 2024 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTxs4UUX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAB61AD3E2;
	Wed,  9 Oct 2024 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490460; cv=none; b=elzEcNbVo+E9LcYWZhvwyCXFb4ab/cUWNtQj0dIZEY2Caq4ddYEn5dbVndfy3WBts4+7ZLOzXHY3MPuiRx5/FOV/3ILAiR6kOeNQSUdHdtaDeDIRaP60y+MrAPI1FplMvRKtQv+QGJsBrh5u8DZBf0N/H4J9D8oEl/sUHv5sD0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490460; c=relaxed/simple;
	bh=z1LuONDl3RATSbrn2d4WdFShwqbOSB+zQTg8FzcAjwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAUQJB63KkBeabWLj654BenFCdR8XTj0i0edJx2g+SqJ4GKphSgh8w+RFIHD/VbpTVYStDCN+vj3nWzMTNWLM0qTmk6j/DC7aSeIc6yab7o8yss/HgqV22JHrUcU4qvZ20GUfvdQpvk+thPa6m0bJOjiyn1gRmxQnUEVJwPV8r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTxs4UUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922F8C4CEC3;
	Wed,  9 Oct 2024 16:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728490459;
	bh=z1LuONDl3RATSbrn2d4WdFShwqbOSB+zQTg8FzcAjwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GTxs4UUXEhk+erP28HEvJ8KD6wwObGsaBCMP2nbe5397fFDHtP91UcgQzypXmq8pX
	 n8P+VbfRFdjByQp/oguFMWgwfrIbHJrsGqUk9czQ7X0lV2y4ex2TBS8VNk2COL2VwN
	 QfUUMvlLRyM2vU/6uo+o9NLsnhCBGa6WFy41s9G6P1JnEdF1Y45A7xPk103LUJYUHk
	 ReVX5yQf3Cy25DfapuKfWI2EyyYT6GD0Go/bb4iLjQ3vQt1yA236Cd705g+SLscsCl
	 jWcpP5LdHai5W2a5KmmrTJNkmc4DyeFz4sQiHjg9J6pPg7q9UeRQ1CqWfyFnO/PO0R
	 hM8ucgAk6e5XQ==
Date: Wed, 9 Oct 2024 18:14:17 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	netdev@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 12/15] iopoll/regmap/phy/snd: Fix comment referencing
 outdated timer documentation
Message-ID: <Zwar2Qu-_ivvMnJT@localhost.localdomain>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-flseep-v2-12-b0d3f33ccfe0@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240911-devel-anna-maria-b4-timers-flseep-v2-12-b0d3f33ccfe0@linutronix.de>

Le Wed, Sep 11, 2024 at 07:13:38AM +0200, Anna-Maria Behnsen a écrit :
> Function descriptions in iopoll.h, regmap.h, phy.h and sound/soc/sof/ops.h
> copied all the same outdated documentation about sleep/delay function
> limitations. In those comments, the generic (and still outdated) timer
> documentation file is referenced.
> 
> As proper function descriptions for used delay and sleep functions are in
> place, simply update the descriptions to reference to them. While at it fix
> missing colon after "Returns" in function description and move return value
> description to the end of the function description.
> 
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-sound@vger.kernel.org
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

