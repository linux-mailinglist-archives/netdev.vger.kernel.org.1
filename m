Return-Path: <netdev+bounces-227993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9225ABBECEC
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 19:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B9FD3B0750
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 17:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3950B23DEB6;
	Mon,  6 Oct 2025 17:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asCCj3Dh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E48C1C8630;
	Mon,  6 Oct 2025 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771622; cv=none; b=s4nB/tuIyh4gO8FfdTVmSDcfElx7wKyouEEck4moz7ZRGvup5jIFCxAchsZf2yauW8V3LJZEaMhWIWAmuIRoA4JoF+oJznBEbhq9VVuM0y3zOLdHaA53w+Zv6ZCyrVWlJ3PtsQZsTrx27aNb6xJlJxB4jxsXAYNZ74FbUKcHiGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771622; c=relaxed/simple;
	bh=qqvxQa/oiCnegBlxVsJ0LxBKAVgIATx8wemwX5rVasw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uwFkqmEu2OE7uj2F8r+v6smUykkgBc4zZGXW06hE9D0DwNOUmJa7X1CuNZWS0HH4mRI1NkiX79KGEmRgtCuY9ABFYGbihNGf0gbc7wG08foTYkj3+OcalAmgkpKYwXPSnH+R5lIUU5YUeJ0+Aa50GrIvs6iTki7VRn+nh3JGl0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asCCj3Dh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877C4C4CEF5;
	Mon,  6 Oct 2025 17:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759771621;
	bh=qqvxQa/oiCnegBlxVsJ0LxBKAVgIATx8wemwX5rVasw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=asCCj3Dh4Lb6Q/uZBAh2Fpi2OAnzQI15Lm9ucpzSp3hM85KSOhJeuLtzRVLKf4wSu
	 J9inp3ZmJXp7zzb5AcFkJEWi9XtMah2SfYC9JRPeSK0n+BUQmEMGGQj0hMmVrTwKwT
	 xKPNg5g7HPMlFaFV3izsnnRPAadI2EAxqF0HP/wAEWOS9a1b8RVifbqdyvkzmfUwMS
	 TkiaN00LKKimp90DsoCOgXg++XXZxEY0vYIhpuyUt1QxTQQlIDcKnsXuqEk6FaHG8z
	 FxIPXmjxOSi11pSe8/XK0xocLH0yIeqOuC1B3AVJKOrWSxhqbkO9MVaDzlNYylErrR
	 buRy7AcRRBLoQ==
Date: Mon, 6 Oct 2025 10:26:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, "Pavan Kumar Linga"
 <pavan.kumar.linga@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Willem de Bruijn <willemb@google.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>, Phani Burra
 <phani.r.burra@intel.com>, Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
 Simon Horman <horms@kernel.org>, Radoslaw Tyl <radoslawx.tyl@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>, Mateusz Polchlopek
 <mateusz.polchlopek@intel.com>, Anton Nadezhdin
 <anton.nadezhdin@intel.com>, Konstantin Ilichev
 <konstantin.ilichev@intel.com>, Milena Olech <milena.olech@intel.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Joshua Hay
 <joshua.a.hay@intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Chittim Madhu <madhu.chittim@intel.com>,
 Samuel Salin <Samuel.salin@intel.com>
Subject: Re: [PATCH net 3/8] idpf: fix possible race in idpf_vport_stop()
Message-ID: <20251006102659.595825fe@kernel.org>
In-Reply-To: <4a128348-48f9-40d7-b5bf-c3f1af27679c@intel.com>
References: <20251001-jk-iwl-net-2025-10-01-v1-0-49fa99e86600@intel.com>
	<20251001-jk-iwl-net-2025-10-01-v1-3-49fa99e86600@intel.com>
	<20251003104332.40581946@kernel.org>
	<4a128348-48f9-40d7-b5bf-c3f1af27679c@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Oct 2025 07:49:32 -0700 Tantilov, Emil S wrote:
> > Argh, please stop using the flag based state machines. They CANNOT
> > replace locking. If there was proper locking in place it wouldn't
> > have mattered when we clear the flag.  
> 
> This patch is resolving a bug in the current logic of how the flag is 
> used (not being atomic and not being cleared properly). I don't think
> there is an existing lock in place to address this issue, though we are
> looking to refactor the code over time to remove and/or limit how these
> flags are used.

Can you share more details about the race? If there is no lock in place
there's always the risk that:

  CPU 0                         CPU 1
 idpf_vport_stop()             whatever()
                                 if (test_bit(UP))
                                  # sees true
                                # !< long IRQ arrives
 test_and_clear(UP)
   ...
   all the rest
   ...
                                # > long IRQ ends
                                proceed but UP isn't really set any more

