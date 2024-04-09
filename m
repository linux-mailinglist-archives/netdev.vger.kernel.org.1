Return-Path: <netdev+bounces-85962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A33689D093
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 04:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED63E1F23EA3
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 02:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA425466E;
	Tue,  9 Apr 2024 02:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5jvAn94"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9FC54BDA
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 02:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712631496; cv=none; b=CpYrBtxJIUehvK+NPJUo3GoVesYAG+VyMHJG7hAOVKO35QYxceKZAJWBStrSxk5D8d/VeHLyUY0V/He8MouRtoPf5B0weLQC3/Y17+B54MOhYxu/RvKc9QYXKIVdCzvFMtugPzja/FKcue5VhaWsxWSemOjr0jJWrZ70MAGYJ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712631496; c=relaxed/simple;
	bh=EyG6VlwVh1JdzHgStFWheyZTdryl6aVNweMcKHy64rI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSqNlGS6/18wsC8+ORzacbrh5RSlwBRomkMhjErlqwMA+xaT47WZHtYIMpZxpdxr7Tf86ix4LPgjUxYnGdWA8ewQoBtF2BIhNG41NofjouvfzurvKHRsVlsScR3dbVY4WusW3YXVjBirvLrircNEf5JJRG2puTO5EXuFn8i3T3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5jvAn94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C8EC43390;
	Tue,  9 Apr 2024 02:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712631496;
	bh=EyG6VlwVh1JdzHgStFWheyZTdryl6aVNweMcKHy64rI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q5jvAn94deBQudR6ShaTVw92uOkvquvChz+Hx13fGa3HpejC+SSCdcGZq5WCqjA/q
	 SO56JHFAPY3SI2iJsV8vwPrHxMqDXh+mhaeVYl7aVnk5AaojnsXNPzN6ACnz5v26Ck
	 kPKazeW6cCvZ1G58SYB6cNsf4u+3tOArTEhux2n4ryaOCvED34D2t/9szFS3tYhe46
	 LSXJDN7Js9FXMz5OX6lXJYE2DIynludgbcu60Rbr24HApNmiU15noQI1CWSABKmHjO
	 XxRBSjrL9dRUAlOvtUhxHamAdJk8Wc+1HvniIX40Xmvr9lc6HHGjIc0f8akjqabKcN
	 dtYfJYXBk5mtQ==
Date: Mon, 8 Apr 2024 19:58:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Louis Peens <louis.peens@corigine.com>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Fei Qin <fei.qin@corigine.com>,
 netdev@vger.kernel.org, oss-drivers@corigine.com
Subject: Re: [PATCH net-next v4 2/4] nfp: update devlink device info output
Message-ID: <20240408195815.5e932da3@kernel.org>
In-Reply-To: <20240405081547.20676-3-louis.peens@corigine.com>
References: <20240405081547.20676-1-louis.peens@corigine.com>
	<20240405081547.20676-3-louis.peens@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Apr 2024 10:15:45 +0200 Louis Peens wrote:
> +   * - ``board.part_number``
> +     - fixed
> +     - Part number of the board design

Sorry, one more nit. Part number is not "of the board design"
Part number is a part number, AFAIU it's a customer-facing
identifier of a product. Let's drop the design or say "of the 
board and its components"? Since AFAIU part number may also
change if you replace a component even if you don't have to
redesign the PCB?

