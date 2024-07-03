Return-Path: <netdev+bounces-108655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A0D924D44
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 03:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49997283B6F
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 01:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DA51854;
	Wed,  3 Jul 2024 01:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9qOMJo8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CD039B;
	Wed,  3 Jul 2024 01:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719971304; cv=none; b=sG2m5VmumQSgehnsdipG/9Ra0QRmjkvTT9IvCGWwS3+zBiQCVTqFP7r4KMfca9Ooz5R8q2WQQADZ2sp2PVlD/dVWTA6bS+6PqgKG/PRHuWeOFSj1NzeVmnCzRCAOCfB0GWTaPXDkpV6Sxr0/6gOxVXZtPDQTW3kFqcuTlQBn7xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719971304; c=relaxed/simple;
	bh=GZCoVWFN6u3VhMnkbEhDyzJp0J4meoC0ropIoKAfXbg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujIkhv9XaVwGFg5I+ARWyKFHS+58qA+mo/hjyJBwe6QIWsE3MrCLiFLQftHUaIgbN5/1b2C+6CE4IQ/vZOX4S9YOCFTRiK9vOsxRUnuguGU7vWyPKLnw9T1dSr8EEeY6eJNfr6NwY9wUZ8bO56BIKyC5n/dtBdHvjj5IPLLZI+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9qOMJo8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6CAC116B1;
	Wed,  3 Jul 2024 01:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719971303;
	bh=GZCoVWFN6u3VhMnkbEhDyzJp0J4meoC0ropIoKAfXbg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b9qOMJo8rzsW4XkY0xCgKObkkg8xFIL8bW+E5KqDEKh3s77Rn+HjXFwUFQgE3n+LA
	 3DjQPse0N/dgAq+aaOAtNwiXbZI5SGK924VrqnfvvwBEc4wT7Au4y5TVV3YEXNsPWf
	 M5aPn0uKrvwUVyw+1qhxBwTyAwjHM7Xr58sg+TJ9LKUNuLblg2IjKH9QL1NlFMGTJy
	 SgvIuB3mUHqmG7hlopvQvApJW1R4FOveptyFXnr3/sbLpRZXNxQdVj5iRfAUxUhN/f
	 hwuw7k2xAa1qMFsTX4CDKiY7RRSG8n0a9AR200AD/dCWOzkFGHhIacICUP9wNdloFR
	 WeYNSu3ePSp5Q==
Date: Tue, 2 Jul 2024 18:48:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Madalin Bucur <madalin.bucur@nxp.com>, Sean Anderson
 <sean.anderson@seco.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, netdev@vger.kernel.org (open list:FREESCALE QORIQ
 DPAA FMAN DRIVER), devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
 imx@lists.linux.dev
Subject: Re: [PATCH v2 1/2] dt-bindings: net: fsl,fman: allow dma-coherence
 property
Message-ID: <20240702184821.3dfb5e33@kernel.org>
In-Reply-To: <20240701201448.1901657-1-Frank.Li@nxp.com>
References: <20240701201448.1901657-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Jul 2024 16:14:47 -0400 Frank Li wrote:
> - Fix paste wrong warning mesg.

Pretty sure Rob had another comment.
-- 
pv-bot: feedback
pw-bot: cr

