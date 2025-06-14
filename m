Return-Path: <netdev+bounces-197799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 035D8AD9E90
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 19:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0744F189661C
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 17:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392082E62A1;
	Sat, 14 Jun 2025 17:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiN9nziZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0F62E6100;
	Sat, 14 Jun 2025 17:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749923102; cv=none; b=atAvSqzKOLXZ+PbkUW3FbF3u75GdhsqOmP7h4SFY39oCXVOV0FWuQJJ2HNcI65zBXtEBC1MdD2UCkMpZbl1BwmHKETRgwolQXVKUnXigBn6138MKNyfyLrVjwZRPA6FT6mUq1Oj6JmVOUfN2yjtMZa5Kg2ch6ZpSg7c4UTgm6zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749923102; c=relaxed/simple;
	bh=ob6J8ah842UQUR2Ib9MQThUSNdQz5fBho16ro9ePGaM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i566Ze53hODIlK0QMV/nFxlK2fkwOBT1aNTwTts373PuFMIlfVea0eQc7TQWwCoAD0/jhIdkfbRu1rn4rfyJrWwRzWIpsF+wHoWpJGhhtw5XQ5U/9sR/btVWRb647YE3/MEsYF70DH4cepX6pZ575akQW4L0pChGiLpLLrCR3h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiN9nziZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36F5C4CEEB;
	Sat, 14 Jun 2025 17:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749923101;
	bh=ob6J8ah842UQUR2Ib9MQThUSNdQz5fBho16ro9ePGaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CiN9nziZccbRfQZKUBjIxIkHkt8dvgrIAe3WbNiWaoIVNBMLUiLIwTp+iuQBDF50q
	 WP7CoIsyq51p+45w5raZHYDqtoykfNHBiiVyMT727v19vtt3lPD138mTFoOHxxivsX
	 j7SQHI0bujBAKzmgXyzA3eDH2uneKWBmA0sw1bngR8Z0KWVoWi/DmJDXP0vDeHwOfB
	 1Nj+z1LmYhjF/s+hwxhyoKGma1BYUJ9yNeE5MHe8j2f5IsfBWv6VHWzpVKBj4IzX71
	 hY68hJeqpLz14OTHyw2rsTDDBJr9X0ryudWbvtctvteNdnA3U7EphRXyCAPWjpWsJY
	 PJBUf8ih65VtQ==
Date: Sat, 14 Jun 2025 10:44:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: kernel test robot <lkp@intel.com>, netdev@vger.kernel.org,
 oe-kbuild-all@lists.linux.dev, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko
 <jiri@resnulli.us>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Prathosh Satish
 <Prathosh.Satish@microchip.com>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>, Shannon Nelson
 <shannon.nelson@amd.com>, Dave Jiang <dave.jiang@intel.com>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Michal Schmidt
 <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
Subject: Re: [PATCH net-next v9 06/14] dpll: zl3073x: Fetch invariants
 during probe
Message-ID: <20250614104454.444672fc@kernel.org>
In-Reply-To: <00780331-37cb-48ae-bb87-06d21a9ec4d1@redhat.com>
References: <20250612200145.774195-7-ivecera@redhat.com>
	<202506140541.KcP4ErN5-lkp@intel.com>
	<00780331-37cb-48ae-bb87-06d21a9ec4d1@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Jun 2025 12:39:08 +0200 Ivan Vecera wrote:
> should I fix this in v10 or in a follow-up in the part 2?

I don't love this but yes, please fix and respin. We auto-discard
series that get a build bot reply.

