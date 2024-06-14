Return-Path: <netdev+bounces-103667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F4D908FC8
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 18:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B23A1C213F9
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 16:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E432716FF5B;
	Fri, 14 Jun 2024 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMTOTLv8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB69916F845;
	Fri, 14 Jun 2024 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718381634; cv=none; b=t5IU1qglfwY9jG85kEvG+KPL0KBccvF5anPJF9Tmw8go+SnPvz7ljojVO5CE0+WwtzFv6jKqz7fSntejPPQKBxPA9zTq1omYdaM/dTB/8DRDz8AxDhUk0fNIXSXdBYcM4JVe+fLtTBchKntjiVL1isb5MG+Ex/wjiIaqcmCzo28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718381634; c=relaxed/simple;
	bh=XGt1Rpkng6ZxVlcYUCQn0/doZgfhqaFZdyt4RE3G0mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbRz73HtMrVWcyCd2CyS7m/FR+jSLOAUBvTWwj9XCzrjosG2cJvyO3YLZhlVjvn33S2dE5fc/JUwizi6EKE1h+2k4ICR8I3+cyoGIQ0bBjjfjnRv3VOjfdg4xa72spBBnZxYXh/YUN85sNaUdqNegJsGROuZVVxEiNDw3UimjmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMTOTLv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1B0C32786;
	Fri, 14 Jun 2024 16:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718381634;
	bh=XGt1Rpkng6ZxVlcYUCQn0/doZgfhqaFZdyt4RE3G0mA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dMTOTLv8tqRjZUEUi3J9KViKHB1KAv3OnWmjvaHxp1Ogfe/bx8MYDT0Xr9vTJy9J/
	 STdAS7h2efv+fa3fITvgohFq9OOS667p72vksyQFZ/UmWx6PROkjNbGlxwCIxUoWPP
	 Tr8YHQZl8V3IYwY3KmaGwRZuq6RTVSemBqvATcirlrrzVNj7hmA+G/X0iBFylUHDg+
	 PCZC8vt7MCqIW3dxWmHDBvA4SM6OAPI4rTjp7uy21U/aH5f5BwnFuVpDmeMMUVTAki
	 FAWHEsbCuvUq1ld72hzZ04Dszig8gzVKLHo1Z7X/Th8igcn/lUO3sb6sFVWcKtye5H
	 6kXukovzqgz1g==
Date: Fri, 14 Jun 2024 17:13:49 +0100
From: Simon Horman <horms@kernel.org>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
	i.maximets@ovn.org, dev@openvswitch.org,
	Yotam Gigi <yotam.gi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/9] net: psample: add user cookie
Message-ID: <20240614161349.GR8447@kernel.org>
References: <20240603185647.2310748-1-amorenoz@redhat.com>
 <20240603185647.2310748-2-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603185647.2310748-2-amorenoz@redhat.com>

On Mon, Jun 03, 2024 at 08:56:35PM +0200, Adrian Moreno wrote:
> Add a user cookie to the sample metadata so that sample emitters can
> provide more contextual information to samples.
> 
> If present, send the user cookie in a new attribute:
> PSAMPLE_ATTR_USER_COOKIE.
> 
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>


Reviewed-by: Simon Horman <horms@kernel.org>


