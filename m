Return-Path: <netdev+bounces-205115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D47BAFD6E4
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 21:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7F54E03CE
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 19:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3442E6131;
	Tue,  8 Jul 2025 19:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dxv3pCgz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178B92E610A
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 19:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752001710; cv=none; b=FRYDeOuWy8IToFtEB90G0+PyG6U7WTc9ToqgAAseSgp5VeGztD/oOpTjBUvq83Kn5jySPkSucB1GFzUIb099vmXVdfHckVYE+t+ejg8VzAKdhCvMalD0PfwbuUXQ7ju3MmMdHtrLQHwjgUSGGNybUEbAIbQhrYiK4Gsq4dsrKp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752001710; c=relaxed/simple;
	bh=qk/WA9sSyUO9s51WYTSBhbftZqEtK6dx0JPpj7KBuek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hH+5wBEKdnE+zTdLB/sdlsU8+fMlb+e/mTTuoziPonSz3Fjv0OJhDY1NrFErYKvZGUDpsYkVjaqNZ3m6DJzTxGIZBRMGXdZr3NIHjJA5TrkwK6XRwZhgGR+RtJU5focuqOy4bHk3zKFWB5SJ2a0ASP1fwtwysXqSKiYV5Mxukp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dxv3pCgz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29EEC4CEF5;
	Tue,  8 Jul 2025 19:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752001709;
	bh=qk/WA9sSyUO9s51WYTSBhbftZqEtK6dx0JPpj7KBuek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dxv3pCgz9ueLojvlVkfcw2E1obu6AdDv1uhp+Q+LlqmTi4y65gDSlNWsOLzSBgqOD
	 2hvd+W4jfVBbpI0acV/dUE0RcYkcHGZ/B3SKqxeeuMrlyupt+mrtwp4sidxBo9ImW6
	 kme6vXzAJ870Dn59UL0GXF7O9X9uwqzMG8yEzvUd5EOmCi6sIT7JMen4qwVB1tpiVL
	 lrPBrfOc4JsTKyxIiNAXSrI7B2pavBRcDaoNzz4zDFsPrjiZ5G8iOcVw82BmPPiiEP
	 J5ktzFMAsIk58ILC3LLXpIJ3bb61IhgbKMX1R3zF9C1LkQU4N0pRGRYx3Eu20GqaYS
	 LWeR0G7hFQaZg==
Date: Tue, 8 Jul 2025 20:08:25 +0100
From: Simon Horman <horms@kernel.org>
To: Jacek Kowalski <jacek@jacekk.info>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 4/5] igc: drop unnecessary constant casts to
 u16
Message-ID: <20250708190825.GZ452973@horms.kernel.org>
References: <b4ee0893-6e57-471d-90f4-fe2a7c0a2ada@jacekk.info>
 <42811fde-9b80-44a5-bc0e-74d204e05fe7@jacekk.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42811fde-9b80-44a5-bc0e-74d204e05fe7@jacekk.info>

On Tue, Jul 08, 2025 at 10:18:10AM +0200, Jacek Kowalski wrote:
> Remove unnecessary casts of constant values to u16.
> Let the C type system do it's job.
> 
> Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
> Suggested-by: Simon Horman <horms@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

...

