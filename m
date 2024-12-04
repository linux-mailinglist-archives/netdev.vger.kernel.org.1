Return-Path: <netdev+bounces-148745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 782009E30A4
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 02:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC522B237B1
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 01:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB52279F5;
	Wed,  4 Dec 2024 01:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmAxa6Pu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945FB33D1
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 01:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733274655; cv=none; b=MkcFBgLxgZwQPgV4x8oQ20i+PbwkUsLDTOq1JK41rA8Vh1GcK0WcOU36LyZlPu/9A150vWk7cNklolIv5m5HNqSjCThJh/K669/hv4RV0+cHB86CyUaEt7p6bKvK6xtoFG9ZCaxuJ4yUbVd3gVwBx8cTL46Oq93ezMZZ1kXG2Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733274655; c=relaxed/simple;
	bh=fjA9v0vM/XsCzMSA0wJLPA+BA7Smm4j31+jGT0IyMEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=psxfW3TINo+DTAHR7AZt/gIi2g+gfXq8+LqCKLOCSu7j2sL6pFjmPTLVHPFiEuBbl1ZnyYjnm7k7C3eUH6xC16VwbCIBX2we9bjrPK91eSIEdkcsJXr8Rw/Zi0D6VMreuYBkR30eEpVTHL0mbWPlyd8wZXsyyJCUlU87IZ+bZVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmAxa6Pu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC84DC4CEDC;
	Wed,  4 Dec 2024 01:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733274655;
	bh=fjA9v0vM/XsCzMSA0wJLPA+BA7Smm4j31+jGT0IyMEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QmAxa6Pu8h++YorN3DRgafm3i2h7aor5B5nnE11D1cwGb1+rANU/nTSyf1htJRz6c
	 BJ7WVgmWCLWSqplLLnvn1HE22nz0rKKe8D3zf4xFdnW/GBIoRCfsZoWL4CxeFq4+8z
	 pHFtyKzZ0/LrcVBAHpu2jy+KJ6sfIcC6zj73I7VeaKlR3NU6ZzdDyoOQkBC444P/Ku
	 q4A+KuffsMV+SEM+Y+pDhQnpwOkNSouoQqHZEnXOUjq8CQNb73zRCGbMz/sY7h9yHL
	 3g/wV494peIeU9M8j3K3sJW577Tp0QU17OJp4DtJYsmLs0i3u72vXgOm7DW8MtcDyY
	 CjCq/IEm4JjYg==
Date: Tue, 3 Dec 2024 17:10:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jesse Van Gavere <jesseevg@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, Jesse Van
 Gavere <jesse.vangavere@scioteq.com>
Subject: Re: [PATCH net-next v2] net: dsa: microchip: Make MDIO bus name
 unique
Message-ID: <20241203171053.544b1808@kernel.org>
In-Reply-To: <CAMdwsN9DSk=ANXoExsyEYiFaLvN5=V4-CJerpotykLZcCHePAA@mail.gmail.com>
References: <20241128212509.34684-1-jesse.vangavere@scioteq.com>
	<c3a018e5-01f9-4150-817d-ac37ed09a06f@lunn.ch>
	<CAMdwsN9DSk=ANXoExsyEYiFaLvN5=V4-CJerpotykLZcCHePAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2024 06:31:45 +0100 Jesse Van Gavere wrote:
> I'll adjust that in the next version when the
> merge window opens, my apologies for not sending at the correct time,
> still getting the hang of contributing.

net-next is closed when merge window is open, they are in opposite
states. All that to say that net-next is open now, you can resend :)

